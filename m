Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40365EC863
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 17:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiI0Ppr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 11:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiI0PpN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 11:45:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9748B1B85F6;
        Tue, 27 Sep 2022 08:41:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96B9E1756;
        Tue, 27 Sep 2022 08:41:37 -0700 (PDT)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6403F3F73B;
        Tue, 27 Sep 2022 08:41:28 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        will@kernel.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Subject: [RFC PATCH 4/4] perf test arm64: Add attr tests for new VG register
Date:   Tue, 27 Sep 2022 16:41:04 +0100
Message-Id: <20220927154104.869029-5-james.clark@arm.com>
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

Ensure that the availability of the VG register behaves as expected
depending on the kernel version and SVE support.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../attr/test-record-user-regs-no-sve-aarch64      |  9 +++++++++
 .../attr/test-record-user-regs-old-sve-aarch64     | 10 ++++++++++
 .../tests/attr/test-record-user-regs-sve-aarch64   | 14 ++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64
 create mode 100644 tools/perf/tests/attr/test-record-user-regs-old-sve-aarch64
 create mode 100644 tools/perf/tests/attr/test-record-user-regs-sve-aarch64

diff --git a/tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64 b/tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64
new file mode 100644
index 000000000000..fbb065842880
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64
@@ -0,0 +1,9 @@
+# Test that asking for VG fails if the system doesn't support SVE. This
+# applies both before and after the feature was added in 6.1
+[config]
+command = record
+args    = --no-bpf-event --user-regs=vg kill >/dev/null 2>&1
+ret     = 129
+test_ret = true
+arch    = aarch64
+auxv    = auxv["AT_HWCAP"] & 0x200000 == 0
diff --git a/tools/perf/tests/attr/test-record-user-regs-old-sve-aarch64 b/tools/perf/tests/attr/test-record-user-regs-old-sve-aarch64
new file mode 100644
index 000000000000..15ebfc3418e3
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-user-regs-old-sve-aarch64
@@ -0,0 +1,10 @@
+# Test that asking for VG always fails on old kernels because it was
+# added in 6.1. This applies to systems that either support or don't
+# support SVE.
+[config]
+command = record
+args    = --no-bpf-event --user-regs=vg kill >/dev/null 2>&1
+ret     = 129
+test_ret = true
+arch    = aarch64
+kernel_until = 6.1
diff --git a/tools/perf/tests/attr/test-record-user-regs-sve-aarch64 b/tools/perf/tests/attr/test-record-user-regs-sve-aarch64
new file mode 100644
index 000000000000..c598c803221d
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-user-regs-sve-aarch64
@@ -0,0 +1,14 @@
+# Test that asking for VG works if the system has SVE and after the
+# feature was added in 6.1
+[config]
+command = record
+args    = --no-bpf-event --user-regs=vg kill >/dev/null 2>&1
+ret     = 1
+test_ret = true
+arch    = aarch64
+auxv    = auxv["AT_HWCAP"] & 0x200000 == 0x200000
+kernel_since = 6.1
+
+[event:base-record]
+sample_type=4359
+sample_regs_user=70368744177664
-- 
2.28.0

