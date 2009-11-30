package com.nodename
{
	import asunit.framework.TestSuite;
	import com.nodename.Delaunay.AllTests;
 
	public class AllTests extends TestSuite {
 
		public function AllTests() {
			addTest(new com.nodename.Delaunay.AllTests());
		}
	}
}