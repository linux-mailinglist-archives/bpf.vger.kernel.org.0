Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026C05EC85E
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 17:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiI0PpZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 11:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiI0PpA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 11:45:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E6DC188BF9;
        Tue, 27 Sep 2022 08:41:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E12551756;
        Tue, 27 Sep 2022 08:41:26 -0700 (PDT)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 878E03F73B;
        Tue, 27 Sep 2022 08:41:17 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        will@kernel.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Subject: [RFC PATCH 1/4] perf test: Add ability to test exit code for attr tests
Date:   Tue, 27 Sep 2022 16:41:01 +0100
Message-Id: <20220927154104.869029-2-james.clark@arm.com>
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

Currently the return value is used to skip the test, but sometimes it
can be useful to test if a certain command should return a certain exit
code.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/attr.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 6d9b5312e6c2..7e053fa5d6ae 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -129,7 +129,8 @@ class Event(dict):
 #   - needs to specify:
 #     'command' - perf command name
 #     'args'    - special command arguments
-#     'ret'     - expected command return value (0 by default)
+#     'ret'     - Skip test if Perf doesn't exit with this value (0 by default)
+#     'test_ret'- If set to 'true', fail test instead of skipping for 'ret' argument
 #     'arch'    - architecture specific test (optional)
 #                 comma separated list, ! at the beginning
 #                 negates it.
@@ -155,6 +156,8 @@ class Test(object):
         except:
             self.ret  = 0
 
+        self.test_ret = parser.getboolean('config', 'test_ret', fallback=False)
+
         try:
             self.arch  = parser.get('config', 'arch')
             log.warning("test limitation '%s'" % self.arch)
@@ -232,7 +235,10 @@ class Test(object):
         log.info("  '%s' ret '%s', expected '%s'" % (cmd, str(ret), str(self.ret)))
 
         if not data_equal(str(ret), str(self.ret)):
-            raise Unsup(self)
+            if self.test_ret:
+                raise Fail(self, "Perf exit code failure")
+            else:
+                raise Unsup(self)
 
     def compare(self, expect, result):
         match = {}
-- 
2.28.0

