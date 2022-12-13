Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E96F64B472
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 12:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbiLMLu2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 06:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiLMLu0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 06:50:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4B6510FFE;
        Tue, 13 Dec 2022 03:50:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEC191682;
        Tue, 13 Dec 2022 03:51:04 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB3683F5A1;
        Tue, 13 Dec 2022 03:50:22 -0800 (PST)
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
Subject: [PATCH v2 1/4] perf test: Add ability to test exit code for attr tests
Date:   Tue, 13 Dec 2022 11:47:36 +0000
Message-Id: <20221213114739.2312862-2-james.clark@arm.com>
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

Currently the return value is used to skip the test, but sometimes it
can be useful to test if a certain command should return a certain exit
code.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/attr.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index cb39ac46bc73..cf40df472918 100644
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
2.25.1

