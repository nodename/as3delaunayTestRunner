package com {
	import asunit.framework.TestSuite;
	import com.nodename.AllTests;
 
	public class AllTests extends TestSuite {
 
		public function AllTests() {
			addTest(new com.nodename.AllTests());
		}
	}
}