Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170A05EC85B
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 17:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiI0PpW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 11:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiI0Po5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 11:44:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C22043FA0D;
        Tue, 27 Sep 2022 08:41:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 971501EDB;
        Tue, 27 Sep 2022 08:41:30 -0700 (PDT)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 222693F73B;
        Tue, 27 Sep 2022 08:41:20 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        will@kernel.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Subject: [RFC PATCH 2/4] perf test: Add mechanism for skipping attr tests on auxiliary vector values
Date:   Tue, 27 Sep 2022 16:41:02 +0100
Message-Id: <20220927154104.869029-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220927154104.869029-1-james.clark@arm.com>
References: <20220927154104.869029-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This can be used to skip tests or provide different test values on
different platforms. For example to run a test only where Arm SVE is
present add this to the config section:

  auxv    = auxv["AT_HWCAP"] & 0x200000 == 0x200000

The value is a freeform Python expression that is evaled in the context
of a map called "auxv" that contains the decoded auxiliary vector.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/attr.py | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 7e053fa5d6ae..2d6124801da0 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -8,7 +8,9 @@ import glob
 import optparse
 import tempfile
 import logging
+import re
 import shutil
+import subprocess
 
 try:
     import configparser
@@ -134,6 +136,8 @@ class Event(dict):
 #     'arch'    - architecture specific test (optional)
 #                 comma separated list, ! at the beginning
 #                 negates it.
+#     'auxv'    - Truthy statement that is evaled in the scope of the auxv map. When false,
+#                 the test is skipped. For example 'auxv["AT_HWCAP"] == 10'. (optional)
 #
 # [eventX:base]
 #   - one or multiple instances in file
@@ -164,6 +168,7 @@ class Test(object):
         except:
             self.arch  = ''
 
+        self.auxv = parser.get('config', 'auxv', fallback=None)
         self.expect   = {}
         self.result   = {}
         log.debug("  loading expected events");
@@ -175,7 +180,28 @@ class Test(object):
         else:
             return True
 
-    def skip_test(self, myarch):
+    def skip_test_auxv(self):
+        def new_auxv(a, pattern):
+            items = list(filter(None, pattern.split(a)))
+            # AT_HWCAP is hex but doesn't have a prefix, so special case it
+            if items[0] == "AT_HWCAP":
+                value = int(items[-1], 16)
+            else:
+                try:
+                    value = int(items[-1], 0)
+                except:
+                    value = items[-1]
+            return (items[0], value)
+
+        if not self.auxv:
+            return False
+        auxv = subprocess.check_output("LD_SHOW_AUXV=1 sleep 0", shell=True) \
+               .decode(sys.stdout.encoding)
+        pattern = re.compile(r"[: ]+")
+        auxv = dict([new_auxv(a, pattern) for a in auxv.splitlines()])
+        return not eval(self.auxv)
+
+    def skip_test_arch(self, myarch):
         # If architecture not set always run test
         if self.arch == '':
             # log.warning("test for arch %s is ok" % myarch)
@@ -225,9 +251,12 @@ class Test(object):
     def run_cmd(self, tempdir):
         junk1, junk2, junk3, junk4, myarch = (os.uname())
 
-        if self.skip_test(myarch):
+        if self.skip_test_arch(myarch):
             raise Notest(self, myarch)
 
+        if self.skip_test_auxv():
+            raise Notest(self, "auxv skip")
+
         cmd = "PERF_TEST_ATTR=%s %s %s -o %s/perf.data %s" % (tempdir,
               self.perf, self.command, tempdir, self.args)
         ret = os.WEXITSTATUS(os.system(cmd))
-- 
2.28.0

