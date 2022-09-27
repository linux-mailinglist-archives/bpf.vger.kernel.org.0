Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E855EC861
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 17:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiI0Ppo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiI0PpK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 11:45:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87A611B85C3;
        Tue, 27 Sep 2022 08:41:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20F9E1F02;
        Tue, 27 Sep 2022 08:41:34 -0700 (PDT)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B0BE53F73B;
        Tue, 27 Sep 2022 08:41:24 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        will@kernel.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Subject: [RFC PATCH 3/4] perf test: Add mechanism for skipping attr tests on kernel versions
Date:   Tue, 27 Sep 2022 16:41:03 +0100
Message-Id: <20220927154104.869029-4-james.clark@arm.com>
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

The first two version numbers are used since that is where the ABI
changes happen, so seems to be the most useful for now.

'Until' is exclusive and 'since' is inclusive so that the same version
number can be used to mark a point where the change comes into effect.

This allows keeping the tests in a state where new tests will also pass
on older kernels if the existence of a new feature isn't explicitly
broadcast by the kernel. For example extended user regs are currently
discovered by trial and error calls to perf_event_open.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/attr.py | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 2d6124801da0..e890c261ad26 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -6,6 +6,7 @@ import os
 import sys
 import glob
 import optparse
+import platform
 import tempfile
 import logging
 import re
@@ -125,6 +126,11 @@ class Event(dict):
             if not data_equal(self[t], other[t]):
                 log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
 
+def parse_version(version):
+    if not version:
+        return None
+    return [int(v) for v in version.split(".")[0:2]]
+
 # Test file description needs to have following sections:
 # [config]
 #   - just single instance in file
@@ -138,7 +144,9 @@ class Event(dict):
 #                 negates it.
 #     'auxv'    - Truthy statement that is evaled in the scope of the auxv map. When false,
 #                 the test is skipped. For example 'auxv["AT_HWCAP"] == 10'. (optional)
-#
+#     'kernel_since' - Inclusive kernel version from which the test will start running. Only the
+#                      first two values are supported, for example "6.1" (optional)
+#     'kernel_until' - Exclusive kernel version from which the test will stop running. (optional)
 # [eventX:base]
 #   - one or multiple instances in file
 #   - expected values assignments
@@ -169,6 +177,8 @@ class Test(object):
             self.arch  = ''
 
         self.auxv = parser.get('config', 'auxv', fallback=None)
+        self.kernel_since = parse_version(parser.get('config', 'kernel_since', fallback=None))
+        self.kernel_until = parse_version(parser.get('config', 'kernel_until', fallback=None))
         self.expect   = {}
         self.result   = {}
         log.debug("  loading expected events");
@@ -180,6 +190,16 @@ class Test(object):
         else:
             return True
 
+    def skip_test_kernel_since(self):
+        if not self.kernel_since:
+            return False
+        return not self.kernel_since <= parse_version(platform.release())
+
+    def skip_test_kernel_until(self):
+        if not self.kernel_until:
+            return False
+        return not parse_version(platform.release()) < self.kernel_until
+
     def skip_test_auxv(self):
         def new_auxv(a, pattern):
             items = list(filter(None, pattern.split(a)))
@@ -257,6 +277,12 @@ class Test(object):
         if self.skip_test_auxv():
             raise Notest(self, "auxv skip")
 
+        if self.skip_test_kernel_since():
+            raise Notest(self, "old kernel skip")
+
+        if self.skip_test_kernel_until():
+            raise Notest(self, "new kernel skip")
+
         cmd = "PERF_TEST_ATTR=%s %s %s -o %s/perf.data %s" % (tempdir,
               self.perf, self.command, tempdir, self.args)
         ret = os.WEXITSTATUS(os.system(cmd))
-- 
2.28.0

