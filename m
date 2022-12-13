Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C926C64B476
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 12:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbiLMLug (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 06:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiLMLua (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 06:50:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BEDE11820;
        Tue, 13 Dec 2022 03:50:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFDF0168F;
        Tue, 13 Dec 2022 03:51:09 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B9243F5A1;
        Tue, 13 Dec 2022 03:50:27 -0800 (PST)
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
Subject: [PATCH v2 3/4] perf test: Add mechanism for skipping attr tests on kernel versions
Date:   Tue, 13 Dec 2022 11:47:38 +0000
Message-Id: <20221213114739.2312862-4-james.clark@arm.com>
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
index eceb6d022141..ccfef861e931 100644
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
2.25.1

