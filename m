Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8C464BBE7
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 19:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiLMS1q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 13:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbiLMS1o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 13:27:44 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4401A183
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 10:27:42 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDHl7nC005634
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 10:27:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=uWvS5QX113x3YR1UlP8modRgSVJISEauQkwb/PRWDHk=;
 b=DCyK+BI9M8dgYbO7Zu231CtNOcpG/ALV/6yvzJgQw1st51voS561U9tzGY5YDz8SKduV
 BSmbWG2nulgDPDeqHO+ZaX/Pev8c9ISkO6GH53FSMwcp9EH0l0vkUSuQTkdr7cUPF14y
 RAtyTTjfBl6e+8V93ZvfvPuoVmFbTIb8/hI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3me4bkp548-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 10:27:42 -0800
Received: from twshared8047.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 10:27:38 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 1596E1270D0A0; Tue, 13 Dec 2022 10:27:27 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add verifier test exercising jit PROBE_MEM logic
Date:   Tue, 13 Dec 2022 10:27:26 -0800
Message-ID: <20221213182726.325137-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221213182726.325137-1-davemarchevsky@fb.com>
References: <20221213182726.325137-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _zqH6W5pjpRLV-VXe5j8YGbHykakZxb5
X-Proofpoint-GUID: _zqH6W5pjpRLV-VXe5j8YGbHykakZxb5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a test exercising logic that was fixed / improved in
the previous patch in the series, as well as general sanity checking for
jit's PROBE_MEM logic which should've been unaffected by the previous
patch.

The added verifier test does the following:
  * Acquire a referenced kptr to struct prog_test_ref_kfunc using
    existing net/bpf/test_run.c kfunc
    * Helper returns ptr to a specific prog_test_ref_kfunc whose first
      two fields - both ints - have been prepopulated w/ vals 42 and
      108, respectively
  * kptr_xchg the acquired ptr into an arraymap
  * Do a direct map_value load of the just-added ptr
    * Goal of all this setup is to get an unreferenced kptr pointing to
      struct with ints of known value, which is the result of this step
  * Using unreferenced kptr obtained in previous step, do loads of
    prog_test_ref_kfunc.a (offset 0) and .b (offset 4)
  * Then incr the kptr by 8 and load prog_test_ref_kfunc.a again (this
    time at offset -8)
  * Add all the loaded ints together and return

Before the PROBE_MEM fixes in previous patch, the loads at offset 0 and
4 would succeed, while the load at offset -8 would incorrectly fail
runtime check emitted by the JIT and 0 out dst reg as a result. This
confirmed by retval of 150 for this test before previous patch - since
second .a read is 0'd out - and a retval of 192 with the fixed logic.

The test exercises the two optimizations to fixed logic added in last
patch as well:
  * BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0) exercises "insn->off is
    0, no need to add / sub from src_reg" optimization
  * BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, -8) exercises "src_reg =3D=3D
    dst_reg, no need to restore src_reg after load" optimization

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 75 ++++++++++++++----
 tools/testing/selftests/bpf/verifier/jit.c  | 84 +++++++++++++++++++++
 2 files changed, 146 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
index 8c808551dfd7..14f8d0231e3c 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -55,7 +55,7 @@
 #define MAX_UNEXPECTED_INSNS	32
 #define MAX_TEST_INSNS	1000000
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	23
+#define MAX_NR_MAPS	24
 #define MAX_TEST_RUNS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
@@ -131,6 +131,7 @@ struct bpf_test {
 	int fixup_map_ringbuf[MAX_FIXUPS];
 	int fixup_map_timer[MAX_FIXUPS];
 	int fixup_map_kptr[MAX_FIXUPS];
+	int fixup_map_probe_mem_read[MAX_FIXUPS];
 	struct kfunc_btf_id_pair fixup_kfunc_btf_id[MAX_FIXUPS];
 	/* Expected verifier log output for result REJECT or VERBOSE_ACCEPT.
 	 * Can be a tab-separated sequence of expected strings. An empty string
@@ -698,15 +699,26 @@ static int create_cgroup_storage(bool percpu)
  * struct timer {
  *   struct bpf_timer t;
  * };
+ * struct prog_test_member1 {
+ *   int a;
+ * };
+ * struct prog_test_member {
+ *   struct prog_test_member1 m;
+ *   int c;
+ * };
  * struct btf_ptr {
  *   struct prog_test_ref_kfunc __kptr *ptr;
  *   struct prog_test_ref_kfunc __kptr_ref *ptr;
  *   struct prog_test_member __kptr_ref *ptr;
- * }
+ * };
+ * struct probe_mem_holder {
+ *   struct prog_test_member kptr_ref *ptr;
+ * };
  */
 static const char btf_str_sec[] =3D "\0bpf_spin_lock\0val\0cnt\0l\0bpf_t=
imer\0timer\0t"
 				  "\0btf_ptr\0prog_test_ref_kfunc\0ptr\0kptr\0kptr_ref"
-				  "\0prog_test_member";
+				  "\0prog_test_member\0prog_test_member1\0a\0c\0m"
+				  "\0probe_mem_holder";
 static __u32 btf_raw_types[] =3D {
 	/* int */
 	BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
@@ -724,20 +736,29 @@ static __u32 btf_raw_types[] =3D {
 	BTF_MEMBER_ENC(41, 4, 0), /* struct bpf_timer t; */
 	/* struct prog_test_ref_kfunc */		/* [6] */
 	BTF_STRUCT_ENC(51, 0, 0),
-	BTF_STRUCT_ENC(89, 0, 0),			/* [7] */
+	/* struct prog_test_member1 */			/* [7] */
+	BTF_STRUCT_ENC(106, 1, 4),
+	BTF_MEMBER_ENC(124, 1, 0), /* int a; */
+	/* struct prog_test_member */			/* [8] */
+	BTF_STRUCT_ENC(89, 2, 8),
+	BTF_MEMBER_ENC(128, 7, 0), /* struct prog_test_member1 m; */
+	BTF_MEMBER_ENC(126, 1, 32), /* int c; */
 	/* type tag "kptr" */
-	BTF_TYPE_TAG_ENC(75, 6),			/* [8] */
+	BTF_TYPE_TAG_ENC(75, 6),			/* [9] */
 	/* type tag "kptr_ref" */
-	BTF_TYPE_TAG_ENC(80, 6),			/* [9] */
-	BTF_TYPE_TAG_ENC(80, 7),			/* [10] */
-	BTF_PTR_ENC(8),					/* [11] */
+	BTF_TYPE_TAG_ENC(80, 6),			/* [10] */
+	BTF_TYPE_TAG_ENC(80, 8),			/* [11] */
 	BTF_PTR_ENC(9),					/* [12] */
 	BTF_PTR_ENC(10),				/* [13] */
-	/* struct btf_ptr */				/* [14] */
+	BTF_PTR_ENC(11),				/* [14] */
+	/* struct btf_ptr */				/* [15] */
 	BTF_STRUCT_ENC(43, 3, 24),
-	BTF_MEMBER_ENC(71, 11, 0), /* struct prog_test_ref_kfunc __kptr *ptr; *=
/
-	BTF_MEMBER_ENC(71, 12, 64), /* struct prog_test_ref_kfunc __kptr_ref *p=
tr; */
-	BTF_MEMBER_ENC(71, 13, 128), /* struct prog_test_member __kptr_ref *ptr=
; */
+	BTF_MEMBER_ENC(71, 12, 0), /* struct prog_test_ref_kfunc __kptr *ptr; *=
/
+	BTF_MEMBER_ENC(71, 13, 64), /* struct prog_test_ref_kfunc __kptr_ref *p=
tr; */
+	BTF_MEMBER_ENC(71, 14, 128), /* struct prog_test_member __kptr_ref *ptr=
; */
+	/* struct probe_mem_holder */			/* [16] */
+	BTF_STRUCT_ENC(130, 1, 8),
+	BTF_MEMBER_ENC(71, 13, 0), /* struct prog_test_ref_kfunc kptr_ref *ptr;=
 */
 };
=20
 static char bpf_vlog[UINT_MAX >> 8];
@@ -863,7 +884,7 @@ static int create_map_kptr(void)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, opts,
 		.btf_key_type_id =3D 1,
-		.btf_value_type_id =3D 14,
+		.btf_value_type_id =3D 15,
 	);
 	int fd, btf_fd;
=20
@@ -878,6 +899,26 @@ static int create_map_kptr(void)
 	return fd;
 }
=20
+static int create_map_probe_mem_read(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		.btf_key_type_id =3D 1,
+		.btf_value_type_id =3D 16,
+	);
+	int fd, btf_fd;
+
+	btf_fd =3D load_btf();
+	if (btf_fd < 0)
+		return -1;
+
+	opts.btf_fd =3D btf_fd;
+	fd =3D bpf_map_create(BPF_MAP_TYPE_ARRAY, "test_map", 4, 8, 1, &opts);
+	if (fd < 0)
+		printf("Failed to create map for probe_mem reads\n");
+
+	return fd;
+}
+
 static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog=
_type,
 			  struct bpf_insn *prog, int *map_fds)
 {
@@ -904,6 +945,7 @@ static void do_test_fixup(struct bpf_test *test, enum=
 bpf_prog_type prog_type,
 	int *fixup_map_ringbuf =3D test->fixup_map_ringbuf;
 	int *fixup_map_timer =3D test->fixup_map_timer;
 	int *fixup_map_kptr =3D test->fixup_map_kptr;
+	int *fixup_map_probe_mem_read =3D test->fixup_map_probe_mem_read;
 	struct kfunc_btf_id_pair *fixup_kfunc_btf_id =3D test->fixup_kfunc_btf_=
id;
=20
 	if (test->fill_helper) {
@@ -1104,6 +1146,13 @@ static void do_test_fixup(struct bpf_test *test, e=
num bpf_prog_type prog_type,
 			fixup_map_kptr++;
 		} while (*fixup_map_kptr);
 	}
+	if (*fixup_map_probe_mem_read) {
+		map_fds[23] =3D create_map_probe_mem_read();
+		do {
+			prog[*fixup_map_probe_mem_read].imm =3D map_fds[23];
+			fixup_map_probe_mem_read++;
+		} while (*fixup_map_probe_mem_read);
+	}
=20
 	/* Patch in kfunc BTF IDs */
 	if (fixup_kfunc_btf_id->kfunc) {
diff --git a/tools/testing/selftests/bpf/verifier/jit.c b/tools/testing/s=
elftests/bpf/verifier/jit.c
index 8bf37e5207f1..92f19bcaf3ad 100644
--- a/tools/testing/selftests/bpf/verifier/jit.c
+++ b/tools/testing/selftests/bpf/verifier/jit.c
@@ -216,3 +216,87 @@
 	.result =3D ACCEPT,
 	.retval =3D 3,
 },
+{
+	"jit: PROBE_MEM_READ ldx success cases",
+	.insns =3D {
+	/* int *reg_9 =3D fp - 12;
+	 * *reg_9 =3D 0
+	 */
+	BPF_MOV64_REG(BPF_REG_9, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_9, -12),
+	BPF_ST_MEM(BPF_W, BPF_REG_9, 0, 0),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+
+	/* long *dummy_arg =3D fp - 8
+	 * ret =3D bpf_kfunc_call_test_acquire(dummy_arg)
+	 * if (!ret) exit
+	 */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 5),
+	BPF_EXIT_INSN(),
+
+	/* label err_exit
+	 * err_exit:
+	 *  bpf_kfunc_call_test_release(reg_7);
+	 *  return 1;
+	 */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+
+	/* reg_7 =3D acquired prog_test_ref_kfunc */
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_9),
+
+	/* ret =3D bpf_map_lookup_elem(&data, &zero);
+	 * if (!ret) goto err_exit;
+	 * else reg_0 =3D ptr_map_val containing struct prog_test_ref_kfunc
+	 */
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, -10),
+
+	/* ret =3D bpf_kptr_xchg(ptr_map_val, acquired prog_test_ref_kfunc)
+	 * if(ret) goto err_exit;
+	 */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_7),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, -15),
+
+	/* Do a direct LD of the struct prog_test_ref_kfunc we just xchg'd into
+	 * map
+	 */
+	BPF_LD_MAP_VALUE(BPF_REG_0, 0, 0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+
+	/* Try accessing its fields - this should trigger PROBE_MEM jit
+	 * behavior
+	 *
+	 * r0 =3D prog_test_ref_kfunc.a * 2 + prog_test_ref_kfunc.b
+	 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_0, 0),
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_0, 4),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, -8),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_2),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_probe_mem_read =3D { 3, 26 },
+	.fixup_kfunc_btf_id =3D {
+		{ "bpf_kfunc_call_test_acquire", 8 },
+		{ "bpf_kfunc_call_test_release", 12},
+	},
+	.result =3D ACCEPT,
+	.retval =3D 192,
+},
--=20
2.30.2

