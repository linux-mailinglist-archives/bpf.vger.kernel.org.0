Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FA564B473
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 12:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiLMLu3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 06:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiLMLu2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 06:50:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0023A1057F;
        Tue, 13 Dec 2022 03:50:26 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D4FE1688;
        Tue, 13 Dec 2022 03:51:07 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A2993F5A1;
        Tue, 13 Dec 2022 03:50:25 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v2 2/4] perf test: Add mechanism for skipping attr tests on auxiliary vector values
Date:   Tue, 13 Dec 2022 11:47:37 +0000
Message-Id: <20221213114739.2312862-3-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213114739.2312862-1-james.clark@arm.com>
References: <20221213114739.2312862-1-james.clark@arm.com>
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
index cf40df472918..eceb6d022141 100644
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
2.25.1

