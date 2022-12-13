Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A5864B479
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 12:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiLMLu6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 06:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbiLMLud (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 06:50:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B922813E37;
        Tue, 13 Dec 2022 03:50:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CFBE2F4;
        Tue, 13 Dec 2022 03:51:12 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE4863F5A1;
        Tue, 13 Dec 2022 03:50:29 -0800 (PST)
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
Subject: [PATCH v2 4/4] perf test arm64: Add attr tests for new VG register
Date:   Tue, 13 Dec 2022 11:47:39 +0000
Message-Id: <20221213114739.2312862-5-james.clark@arm.com>
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
2.25.1

