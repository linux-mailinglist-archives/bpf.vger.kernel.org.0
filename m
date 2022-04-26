Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A03850EDC1
	for <lists+bpf@lfdr.de>; Tue, 26 Apr 2022 02:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbiDZAsm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Apr 2022 20:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbiDZAsk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 20:48:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2C8252B9
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:35 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q0XOBx001583
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:35 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fp6a3022f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 17:45:34 -0700
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 17:45:32 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 1485318FD8F2F; Mon, 25 Apr 2022 17:45:26 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 05/10] selftests/bpf: add CO-RE relos and SEC("?...") to linked_funcs selftests
Date:   Mon, 25 Apr 2022 17:45:06 -0700
Message-ID: <20220426004511.2691730-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426004511.2691730-1-andrii@kernel.org>
References: <20220426004511.2691730-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: okzE226rv6UiZjiZz6qq1QJ_N66tUCFz
X-Proofpoint-ORIG-GUID: okzE226rv6UiZjiZz6qq1QJ_N66tUCFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enhance linked_funcs selftest with two tricky features that might not
obviously work correctly together. We add CO-RE relocations to entry BPF
programs and mark those programs as non-autoloadable with SEC("?...")
annotation. This makes sure that libbpf itself handles .BTF.ext CO-RE
relocation data matching correctly for SEC("?...") programs, as well as
ensures that BPF static linker handles this correctly (this was the case
before, no changes are necessary, but it wasn't explicitly tested).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/linked_funcs.c | 6 ++++++
 tools/testing/selftests/bpf/progs/linked_funcs1.c     | 7 ++++++-
 tools/testing/selftests/bpf/progs/linked_funcs2.c     | 7 ++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_funcs.c b/tools/testing/selftests/bpf/prog_tests/linked_funcs.c
index e9916f2817ec..cad664546912 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_funcs.c
@@ -14,6 +14,12 @@ void test_linked_funcs(void)
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		return;
 
+	/* handler1 and handler2 are marked as SEC("?raw_tp/sys_enter") and
+	 * are set to not autoload by default
+	 */
+	bpf_program__set_autoload(skel->progs.handler1, true);
+	bpf_program__set_autoload(skel->progs.handler2, true);
+
 	skel->rodata->my_tid = syscall(SYS_gettid);
 	skel->bss->syscall_id = SYS_getpgid;
 
diff --git a/tools/testing/selftests/bpf/progs/linked_funcs1.c b/tools/testing/selftests/bpf/progs/linked_funcs1.c
index 963b393c37e8..b05571bc67d5 100644
--- a/tools/testing/selftests/bpf/progs/linked_funcs1.c
+++ b/tools/testing/selftests/bpf/progs/linked_funcs1.c
@@ -61,12 +61,17 @@ extern int set_output_val2(int x);
 /* here we'll force set_output_ctx2() to be __hidden in the final obj file */
 __hidden extern void set_output_ctx2(__u64 *ctx);
 
-SEC("raw_tp/sys_enter")
+SEC("?raw_tp/sys_enter")
 int BPF_PROG(handler1, struct pt_regs *regs, long id)
 {
+	static volatile int whatever;
+
 	if (my_tid != (u32)bpf_get_current_pid_tgid() || id != syscall_id)
 		return 0;
 
+	/* make sure we have CO-RE relocations in main program */
+	whatever = bpf_core_type_size(struct task_struct);
+
 	set_output_val2(1000);
 	set_output_ctx2(ctx); /* ctx definition is hidden in BPF_PROG macro */
 
diff --git a/tools/testing/selftests/bpf/progs/linked_funcs2.c b/tools/testing/selftests/bpf/progs/linked_funcs2.c
index db195872f4eb..ee7e3848ee4f 100644
--- a/tools/testing/selftests/bpf/progs/linked_funcs2.c
+++ b/tools/testing/selftests/bpf/progs/linked_funcs2.c
@@ -61,12 +61,17 @@ extern int set_output_val1(int x);
 /* here we'll force set_output_ctx1() to be __hidden in the final obj file */
 __hidden extern void set_output_ctx1(__u64 *ctx);
 
-SEC("raw_tp/sys_enter")
+SEC("?raw_tp/sys_enter")
 int BPF_PROG(handler2, struct pt_regs *regs, long id)
 {
+	static volatile int whatever;
+
 	if (my_tid != (u32)bpf_get_current_pid_tgid() || id != syscall_id)
 		return 0;
 
+	/* make sure we have CO-RE relocations in main program */
+	whatever = bpf_core_type_size(struct task_struct);
+
 	set_output_val1(2000);
 	set_output_ctx1(ctx); /* ctx definition is hidden in BPF_PROG macro */
 
-- 
2.30.2

