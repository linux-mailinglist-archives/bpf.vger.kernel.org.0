Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BDC49D27F
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 20:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiAZTbO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 26 Jan 2022 14:31:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5784 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230462AbiAZTbO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jan 2022 14:31:14 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20QGV0jU002515
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 11:31:13 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dtvbew6ke-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 11:31:13 -0800
Received: from twshared3399.25.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 11:31:11 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id A1F221002C4D2; Wed, 26 Jan 2022 11:31:05 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: fix uprobe offset calculation in selftests
Date:   Wed, 26 Jan 2022 11:30:58 -0800
Message-ID: <20220126193058.3390292-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: mrTKCGYJgnYSzJ-38Pmou7_odvHrzW_8
X-Proofpoint-ORIG-GUID: mrTKCGYJgnYSzJ-38Pmou7_odvHrzW_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_07,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201260116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix how selftests determine relative offset of a function that is
uprobed. Previously, there was an assumption that uprobed function is
always in the first executable region, which is not always the case
(libbpf CI hits this case now). So get_base_addr() approach in isolation
doesn't work anymore. So teach get_uprobe_offset() to determine correct
memory mapping and calculate uprobe offset correctly.

While at it, I merged together two implementations of
get_uprobe_offset() helper, moving powerpc64-specific logic inside (had
to add extra {} block to avoid unused variable error for insn).

Also ensured that uprobed functions are never inlined, but are still
static (and thus local to each selftest), by using a no-op asm volatile
block internally. I didn't want to keep them global __weak, because some
tests use uprobe's ref counter offset (to test USDT-like logic) which is
not compatible with non-refcounted uprobe. So it's nicer to have each
test uprobe target local to the file and guaranteed to not be inlined or
skipped by the compiler (which can happen with static functions,
especially if compiling selftests with -O2).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/benchs/bench_trigger.c      |  6 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 18 +++--
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 16 +++--
 .../selftests/bpf/prog_tests/task_pt_regs.c   | 16 +++--
 tools/testing/selftests/bpf/trace_helpers.c   | 70 ++++++++-----------
 tools/testing/selftests/bpf/trace_helpers.h   |  3 +-
 6 files changed, 63 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 7f957c55a3ca..0c481de2833d 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -154,7 +154,6 @@ static void *uprobe_producer_without_nop(void *input)
 static void usetup(bool use_retprobe, bool use_nop)
 {
 	size_t uprobe_offset;
-	ssize_t base_addr;
 	struct bpf_link *link;
 
 	setup_libbpf();
@@ -165,11 +164,10 @@ static void usetup(bool use_retprobe, bool use_nop)
 		exit(1);
 	}
 
-	base_addr = get_base_addr();
 	if (use_nop)
-		uprobe_offset = get_uprobe_offset(&uprobe_target_with_nop, base_addr);
+		uprobe_offset = get_uprobe_offset(&uprobe_target_with_nop);
 	else
-		uprobe_offset = get_uprobe_offset(&uprobe_target_without_nop, base_addr);
+		uprobe_offset = get_uprobe_offset(&uprobe_target_without_nop);
 
 	link = bpf_program__attach_uprobe(ctx.skel->progs.bench_trigger_uprobe,
 					  use_retprobe,
diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index d0bd51eb23c8..d48f6e533e1e 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -5,9 +5,10 @@
 /* this is how USDT semaphore is actually defined, except volatile modifier */
 volatile unsigned short uprobe_ref_ctr __attribute__((unused)) __attribute((section(".probes")));
 
-/* attach point */
-static void method(void) {
-	return ;
+/* uprobe attach point */
+static void trigger_func(void)
+{
+	asm volatile ("");
 }
 
 void test_attach_probe(void)
@@ -17,8 +18,7 @@ void test_attach_probe(void)
 	struct bpf_link *kprobe_link, *kretprobe_link;
 	struct bpf_link *uprobe_link, *uretprobe_link;
 	struct test_attach_probe* skel;
-	size_t uprobe_offset;
-	ssize_t base_addr, ref_ctr_offset;
+	ssize_t uprobe_offset, ref_ctr_offset;
 	bool legacy;
 
 	/* Check if new-style kprobe/uprobe API is supported.
@@ -34,11 +34,9 @@ void test_attach_probe(void)
 	 */
 	legacy = access("/sys/bus/event_source/devices/kprobe/type", F_OK) != 0;
 
-	base_addr = get_base_addr();
-	if (CHECK(base_addr < 0, "get_base_addr",
-		  "failed to find base addr: %zd", base_addr))
+	uprobe_offset = get_uprobe_offset(&trigger_func);
+	if (!ASSERT_GE(uprobe_offset, 0, "uprobe_offset"))
 		return;
-	uprobe_offset = get_uprobe_offset(&method, base_addr);
 
 	ref_ctr_offset = get_rel_offset((uintptr_t)&uprobe_ref_ctr);
 	if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
@@ -103,7 +101,7 @@ void test_attach_probe(void)
 		goto cleanup;
 
 	/* trigger & validate uprobe & uretprobe */
-	method();
+	trigger_func();
 
 	if (CHECK(skel->bss->uprobe_res != 3, "check_uprobe_res",
 		  "wrong uprobe res: %d\n", skel->bss->uprobe_res))
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 5eea3c3a40fe..cd10df6cd0fc 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -8,6 +8,12 @@
 #include <test_progs.h>
 #include "test_bpf_cookie.skel.h"
 
+/* uprobe attach point */
+static void trigger_func(void)
+{
+	asm volatile ("");
+}
+
 static void kprobe_subtest(struct test_bpf_cookie *skel)
 {
 	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
@@ -62,11 +68,11 @@ static void uprobe_subtest(struct test_bpf_cookie *skel)
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts);
 	struct bpf_link *link1 = NULL, *link2 = NULL;
 	struct bpf_link *retlink1 = NULL, *retlink2 = NULL;
-	size_t uprobe_offset;
-	ssize_t base_addr;
+	ssize_t uprobe_offset;
 
-	base_addr = get_base_addr();
-	uprobe_offset = get_uprobe_offset(&get_base_addr, base_addr);
+	uprobe_offset = get_uprobe_offset(&trigger_func);
+	if (!ASSERT_GE(uprobe_offset, 0, "uprobe_offset"))
+		goto cleanup;
 
 	/* attach two uprobes */
 	opts.bpf_cookie = 0x100;
@@ -99,7 +105,7 @@ static void uprobe_subtest(struct test_bpf_cookie *skel)
 		goto cleanup;
 
 	/* trigger uprobe && uretprobe */
-	get_base_addr();
+	trigger_func();
 
 	ASSERT_EQ(skel->bss->uprobe_res, 0x100 | 0x200, "uprobe_res");
 	ASSERT_EQ(skel->bss->uretprobe_res, 0x1000 | 0x2000, "uretprobe_res");
diff --git a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
index 37c20b5ffa70..61935e7e056a 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
@@ -3,18 +3,22 @@
 #include <test_progs.h>
 #include "test_task_pt_regs.skel.h"
 
+/* uprobe attach point */
+static void trigger_func(void)
+{
+	asm volatile ("");
+}
+
 void test_task_pt_regs(void)
 {
 	struct test_task_pt_regs *skel;
 	struct bpf_link *uprobe_link;
-	size_t uprobe_offset;
-	ssize_t base_addr;
+	ssize_t uprobe_offset;
 	bool match;
 
-	base_addr = get_base_addr();
-	if (!ASSERT_GT(base_addr, 0, "get_base_addr"))
+	uprobe_offset = get_uprobe_offset(&trigger_func);
+	if (!ASSERT_GE(uprobe_offset, 0, "uprobe_offset"))
 		return;
-	uprobe_offset = get_uprobe_offset(&get_base_addr, base_addr);
 
 	skel = test_task_pt_regs__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
@@ -32,7 +36,7 @@ void test_task_pt_regs(void)
 	skel->links.handle_uprobe = uprobe_link;
 
 	/* trigger & validate uprobe */
-	get_base_addr();
+	trigger_func();
 
 	if (!ASSERT_EQ(skel->bss->uprobe_res, 1, "check_uprobe_res"))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 7b7f918eda77..65ab533c2516 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -138,6 +138,29 @@ void read_trace_pipe(void)
 	}
 }
 
+ssize_t get_uprobe_offset(const void *addr)
+{
+	size_t start, end, base;
+	char buf[256];
+	bool found;
+	FILE *f;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f)
+		return -errno;
+
+	while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
+		if (buf[2] == 'x' && (uintptr_t)addr >= start && (uintptr_t)addr < end) {
+			found = true;
+			break;
+		}
+	}
+
+	fclose(f);
+
+	if (!found)
+		return -ESRCH;
+
 #if defined(__powerpc64__) && defined(_CALL_ELF) && _CALL_ELF == 2
 
 #define OP_RT_RA_MASK   0xffff0000UL
@@ -145,10 +168,6 @@ void read_trace_pipe(void)
 #define ADDIS_R2_R12    0x3c4c0000UL
 #define ADDI_R2_R2      0x38420000UL
 
-ssize_t get_uprobe_offset(const void *addr, ssize_t base)
-{
-	u32 *insn = (u32 *)(uintptr_t)addr;
-
 	/*
 	 * A PPC64 ABIv2 function may have a local and a global entry
 	 * point. We need to use the local entry point when patching
@@ -165,43 +184,16 @@ ssize_t get_uprobe_offset(const void *addr, ssize_t base)
 	 * lis   r2,XXXX
 	 * addi  r2,r2,XXXX
 	 */
-	if ((((*insn & OP_RT_RA_MASK) == ADDIS_R2_R12) ||
-	     ((*insn & OP_RT_RA_MASK) == LIS_R2)) &&
-	    ((*(insn + 1) & OP_RT_RA_MASK) == ADDI_R2_R2))
-		return (ssize_t)(insn + 2) - base;
-	else
-		return (uintptr_t)addr - base;
-}
-
-#else
+	{
+		const u32 *insn = (const u32 *)(uintptr_t)addr;
 
-ssize_t get_uprobe_offset(const void *addr, ssize_t base)
-{
-	return (uintptr_t)addr - base;
-}
-
-#endif
-
-ssize_t get_base_addr(void)
-{
-	size_t start, offset;
-	char buf[256];
-	FILE *f;
-
-	f = fopen("/proc/self/maps", "r");
-	if (!f)
-		return -errno;
-
-	while (fscanf(f, "%zx-%*x %s %zx %*[^\n]\n",
-		      &start, buf, &offset) == 3) {
-		if (strcmp(buf, "r-xp") == 0) {
-			fclose(f);
-			return start - offset;
-		}
+		if ((((*insn & OP_RT_RA_MASK) == ADDIS_R2_R12) ||
+		     ((*insn & OP_RT_RA_MASK) == LIS_R2)) &&
+		    ((*(insn + 1) & OP_RT_RA_MASK) == ADDI_R2_R2))
+			return (uintptr_t)(insn + 2) - start + base;
 	}
-
-	fclose(f);
-	return -EINVAL;
+#endif
+	return (uintptr_t)addr - start + base;
 }
 
 ssize_t get_rel_offset(uintptr_t addr)
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index d907b445524d..238a9c98cde2 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -18,8 +18,7 @@ int kallsyms_find(const char *sym, unsigned long long *addr);
 
 void read_trace_pipe(void);
 
-ssize_t get_uprobe_offset(const void *addr, ssize_t base);
-ssize_t get_base_addr(void);
+ssize_t get_uprobe_offset(const void *addr);
 ssize_t get_rel_offset(uintptr_t addr);
 
 #endif
-- 
2.30.2

