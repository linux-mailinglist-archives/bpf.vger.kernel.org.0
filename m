Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13883502D79
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 18:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244767AbiDOQH3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 12:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355706AbiDOQH2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 12:07:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245D154F97
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so8695092pjb.1
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X4zsR2GaA6eV5dA6C1NSmHiEdAIuh3PhOfc3YPtBAf0=;
        b=BEjo4+65FeaOu6WNISIeGYsK+yZgtwf7EV/B/A+SlkVWuvhxHZ0gtCGHx3BWTWlzAY
         Y0bXNSqUc0Y5VJ8WWePHLuLH3Tf4rBJTkS/bADLBHdBAktY2fRrih8ijCktKB99u43m8
         guAsDLCxrwfGojNpmmLIePlXqWuqZsBQ7fyEZg5PfHeoZfvte/1n2wqKtNOt34lu4NnF
         CXDFV/oQt2RsERltDLQNAoPS4zIbAqlM9KIfJVRa9v1mwUowZX1slH7g+H4bHUIFjc8p
         RjetdzF6lwt0GJ2/6GbNR5hyIlupjZwt65kxuE9F06nzu93coljLFDyHN593dRQE2Cf2
         dGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4zsR2GaA6eV5dA6C1NSmHiEdAIuh3PhOfc3YPtBAf0=;
        b=qz/VfPl6sXoFKttWVXjHIOBRv7XnLo5Dw5Jew3Ao/giaDIt6mhFXMmtRwquGHYTJK6
         TasV8Fazb8DKxXEzKrM+wchtqIoBxQjdjAurmkLXsLf8w/QsVseQKlR0j4QArP1YpSUB
         LDJxDcOol2SuchRBpjdvm95LgOLCoVYop1Fl5H6Sbnlf8Oktlz60atAqvcuZ1IUdfITx
         taVTBlOsCdKcxqc2nwdqi9tFezDI4SdkJs9dHiy6PlzRl0lwvAlyXFH/5A3OSGxPPGDK
         IDIfevWXucq0fVXeEv66JwWS0W9UIfxax6DFJY9jcb0r45c7DzdO3sNywGoFLQG/zCKs
         3Jwg==
X-Gm-Message-State: AOAM533f+MxrwR+ThM+lidF3Pn/IygHTq5y8iJgKYME5J+cmnfzxEMcE
        FTRAeZaC2o92Zvx+VLjEqbWie9syarY=
X-Google-Smtp-Source: ABdhPJz2GQaZWA4M2flC1or0DcWy5L3tRkvsEHzd7Crrfq8cWVLT4qqlXAmo4NSafg6+t5+4lzIe9g==
X-Received: by 2002:a17:903:124a:b0:154:c7a4:9374 with SMTP id u10-20020a170903124a00b00154c7a49374mr52968194plh.68.1650038696698;
        Fri, 15 Apr 2022 09:04:56 -0700 (PDT)
Received: from localhost ([112.79.166.196])
        by smtp.gmail.com with ESMTPSA id s35-20020a056a001c6300b00505ff320d97sm3489081pfw.91.2022.04.15.09.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:04:56 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v5 13/13] selftests/bpf: Add verifier tests for kptr
Date:   Fri, 15 Apr 2022 21:33:54 +0530
Message-Id: <20220415160354.1050687-14-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415160354.1050687-1-memxor@gmail.com>
References: <20220415160354.1050687-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23933; h=from:subject; bh=0qBChrVaoLU86kIZ9yzeeMRSwFblakjncirsfwZcQd8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiWZdCZl65xS582ds/9hVSuWdV0svcbyUdLmXuVmAY FujyYmuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlmXQgAKCRBM4MiGSL8Ryt8REA CtfiuPTN7HnnnvYBxCusIXk1/sr6+k7Vi9g4SQJTE2AAhkDj1JyWlZNw5pOKEGO6HUzVKh0g83uzqs Q6+mEKg7L07I4jfpOvs1NXzL+259OZm7T0bh8Cq+xLWMfxaeZi0AAcL3NfmnQSeglXsO6cZXX/wQTd pNU0oKq27DcLzlymHrrN6/4WjpNBmL92RA/EdVn2R/CFiYPtlmQmjLJwz01CiAmP58xzl5ZDmnn8WA 5lPI2RdHau/RX3vfDTmfoKu6CBnRnukWtDPrmaMOGYsGZ5MolrRiYRtbR7uA+StdSDZ9yj6MTr7nr/ lrckMljdqwTEqggWxlJiZTsNzVPk25k866G6Oq8yz2OryR0J6IKMAByozOJxQ9deVNmCKf0F1Xbifp mvAHgPIYG2gt5TZcWfdHhrXHs/W98ou451m4+V//3k2LGf72Oz/wkSC0OWQTLTaxajlwR1YIMlG9mb u9nFbeMguKwl4vGrJyJHEyA6ucCNPEoFb0LpXko5kTGIUur1lqEuBQ6xr1JFgaQoTiY+E4LoWdgG9V HhoMKvxTCs6dbMNNgSQ+eOP+aHIYp16XiS1WyvPZ3udG8Bvl6yeUgDbQeqzztKio0+mkoqX9bRR2pj t90sB3LzDf8lHOwJ59tD7kx88d4BlcjIB3zPwOILs0WdCXicIIe4aCq/NdDg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Reuse bpf_prog_test functions to test the support for PTR_TO_BTF_ID in
BPF map case, including some tests that verify implementation sanity and
corner cases.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 net/bpf/test_run.c                            |  45 +-
 tools/testing/selftests/bpf/test_verifier.c   |  55 +-
 .../testing/selftests/bpf/verifier/map_kptr.c | 469 ++++++++++++++++++
 3 files changed, 562 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/map_kptr.c

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index e7b9c2636d10..29fe32821e7e 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -584,6 +584,12 @@ noinline void bpf_kfunc_call_memb_release(struct prog_test_member *p)
 {
 }
 
+noinline struct prog_test_ref_kfunc *
+bpf_kfunc_call_test_kptr_get(struct prog_test_ref_kfunc **p, int a, int b)
+{
+	return &prog_test_struct;
+}
+
 struct prog_test_pass1 {
 	int x0;
 	struct {
@@ -669,6 +675,7 @@ BTF_ID(func, bpf_kfunc_call_test3)
 BTF_ID(func, bpf_kfunc_call_test_acquire)
 BTF_ID(func, bpf_kfunc_call_test_release)
 BTF_ID(func, bpf_kfunc_call_memb_release)
+BTF_ID(func, bpf_kfunc_call_test_kptr_get)
 BTF_ID(func, bpf_kfunc_call_test_pass_ctx)
 BTF_ID(func, bpf_kfunc_call_test_pass1)
 BTF_ID(func, bpf_kfunc_call_test_pass2)
@@ -682,6 +689,7 @@ BTF_SET_END(test_sk_check_kfunc_ids)
 
 BTF_SET_START(test_sk_acquire_kfunc_ids)
 BTF_ID(func, bpf_kfunc_call_test_acquire)
+BTF_ID(func, bpf_kfunc_call_test_kptr_get)
 BTF_SET_END(test_sk_acquire_kfunc_ids)
 
 BTF_SET_START(test_sk_release_kfunc_ids)
@@ -691,8 +699,13 @@ BTF_SET_END(test_sk_release_kfunc_ids)
 
 BTF_SET_START(test_sk_ret_null_kfunc_ids)
 BTF_ID(func, bpf_kfunc_call_test_acquire)
+BTF_ID(func, bpf_kfunc_call_test_kptr_get)
 BTF_SET_END(test_sk_ret_null_kfunc_ids)
 
+BTF_SET_START(test_sk_kptr_acquire_kfunc_ids)
+BTF_ID(func, bpf_kfunc_call_test_kptr_get)
+BTF_SET_END(test_sk_kptr_acquire_kfunc_ids)
+
 static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 			   u32 size, u32 headroom, u32 tailroom)
 {
@@ -1579,14 +1592,36 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 
 static const struct btf_kfunc_id_set bpf_prog_test_kfunc_set = {
 	.owner        = THIS_MODULE,
-	.check_set    = &test_sk_check_kfunc_ids,
-	.acquire_set  = &test_sk_acquire_kfunc_ids,
-	.release_set  = &test_sk_release_kfunc_ids,
-	.ret_null_set = &test_sk_ret_null_kfunc_ids,
+	.check_set        = &test_sk_check_kfunc_ids,
+	.acquire_set      = &test_sk_acquire_kfunc_ids,
+	.release_set      = &test_sk_release_kfunc_ids,
+	.ret_null_set     = &test_sk_ret_null_kfunc_ids,
+	.kptr_acquire_set = &test_sk_kptr_acquire_kfunc_ids
 };
 
+BTF_ID_LIST(bpf_prog_test_dtor_kfunc_ids)
+BTF_ID(struct, prog_test_ref_kfunc)
+BTF_ID(func, bpf_kfunc_call_test_release)
+BTF_ID(struct, prog_test_member)
+BTF_ID(func, bpf_kfunc_call_memb_release)
+
 static int __init bpf_prog_test_run_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_prog_test_kfunc_set);
+	const struct btf_id_dtor_kfunc bpf_prog_test_dtor_kfunc[] = {
+		{
+		  .btf_id       = bpf_prog_test_dtor_kfunc_ids[0],
+		  .kfunc_btf_id = bpf_prog_test_dtor_kfunc_ids[1]
+		},
+		{
+		  .btf_id	= bpf_prog_test_dtor_kfunc_ids[2],
+		  .kfunc_btf_id = bpf_prog_test_dtor_kfunc_ids[3],
+		},
+	};
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_prog_test_kfunc_set);
+	return ret ?: register_btf_id_dtor_kfuncs(bpf_prog_test_dtor_kfunc,
+						  ARRAY_SIZE(bpf_prog_test_dtor_kfunc),
+						  THIS_MODULE);
 }
 late_initcall(bpf_prog_test_run_init);
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index a2cd236c32eb..372579c9f45e 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -53,7 +53,7 @@
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_TEST_INSNS	1000000
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	22
+#define MAX_NR_MAPS	23
 #define MAX_TEST_RUNS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
@@ -101,6 +101,7 @@ struct bpf_test {
 	int fixup_map_reuseport_array[MAX_FIXUPS];
 	int fixup_map_ringbuf[MAX_FIXUPS];
 	int fixup_map_timer[MAX_FIXUPS];
+	int fixup_map_kptr[MAX_FIXUPS];
 	struct kfunc_btf_id_pair fixup_kfunc_btf_id[MAX_FIXUPS];
 	/* Expected verifier log output for result REJECT or VERBOSE_ACCEPT.
 	 * Can be a tab-separated sequence of expected strings. An empty string
@@ -621,8 +622,15 @@ static int create_cgroup_storage(bool percpu)
  * struct timer {
  *   struct bpf_timer t;
  * };
+ * struct btf_ptr {
+ *   struct prog_test_ref_kfunc __kptr *ptr;
+ *   struct prog_test_ref_kfunc __kptr_ref *ptr;
+ *   struct prog_test_member __kptr_ref *ptr;
+ * }
  */
-static const char btf_str_sec[] = "\0bpf_spin_lock\0val\0cnt\0l\0bpf_timer\0timer\0t";
+static const char btf_str_sec[] = "\0bpf_spin_lock\0val\0cnt\0l\0bpf_timer\0timer\0t"
+				  "\0btf_ptr\0prog_test_ref_kfunc\0ptr\0kptr\0kptr_ref"
+				  "\0prog_test_member";
 static __u32 btf_raw_types[] = {
 	/* int */
 	BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
@@ -638,6 +646,22 @@ static __u32 btf_raw_types[] = {
 	/* struct timer */                              /* [5] */
 	BTF_TYPE_ENC(35, BTF_INFO_ENC(BTF_KIND_STRUCT, 0, 1), 16),
 	BTF_MEMBER_ENC(41, 4, 0), /* struct bpf_timer t; */
+	/* struct prog_test_ref_kfunc */		/* [6] */
+	BTF_STRUCT_ENC(51, 0, 0),
+	BTF_STRUCT_ENC(89, 0, 0),			/* [7] */
+	/* type tag "kptr" */
+	BTF_TYPE_TAG_ENC(75, 6),			/* [8] */
+	/* type tag "kptr_ref" */
+	BTF_TYPE_TAG_ENC(80, 6),			/* [9] */
+	BTF_TYPE_TAG_ENC(80, 7),			/* [10] */
+	BTF_PTR_ENC(8),					/* [11] */
+	BTF_PTR_ENC(9),					/* [12] */
+	BTF_PTR_ENC(10),				/* [13] */
+	/* struct btf_ptr */				/* [14] */
+	BTF_STRUCT_ENC(43, 3, 24),
+	BTF_MEMBER_ENC(71, 11, 0), /* struct prog_test_ref_kfunc __kptr *ptr; */
+	BTF_MEMBER_ENC(71, 12, 64), /* struct prog_test_ref_kfunc __kptr_ref *ptr; */
+	BTF_MEMBER_ENC(71, 13, 128), /* struct prog_test_member __kptr_ref *ptr; */
 };
 
 static int load_btf(void)
@@ -727,6 +751,25 @@ static int create_map_timer(void)
 	return fd;
 }
 
+static int create_map_kptr(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts,
+		.btf_key_type_id = 1,
+		.btf_value_type_id = 14,
+	);
+	int fd, btf_fd;
+
+	btf_fd = load_btf();
+	if (btf_fd < 0)
+		return -1;
+
+	opts.btf_fd = btf_fd;
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "test_map", 4, 24, 1, &opts);
+	if (fd < 0)
+		printf("Failed to create map with btf_id pointer\n");
+	return fd;
+}
+
 static char bpf_vlog[UINT_MAX >> 8];
 
 static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
@@ -754,6 +797,7 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	int *fixup_map_reuseport_array = test->fixup_map_reuseport_array;
 	int *fixup_map_ringbuf = test->fixup_map_ringbuf;
 	int *fixup_map_timer = test->fixup_map_timer;
+	int *fixup_map_kptr = test->fixup_map_kptr;
 	struct kfunc_btf_id_pair *fixup_kfunc_btf_id = test->fixup_kfunc_btf_id;
 
 	if (test->fill_helper) {
@@ -947,6 +991,13 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 			fixup_map_timer++;
 		} while (*fixup_map_timer);
 	}
+	if (*fixup_map_kptr) {
+		map_fds[22] = create_map_kptr();
+		do {
+			prog[*fixup_map_kptr].imm = map_fds[22];
+			fixup_map_kptr++;
+		} while (*fixup_map_kptr);
+	}
 
 	/* Patch in kfunc BTF IDs */
 	if (fixup_kfunc_btf_id->kfunc) {
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
new file mode 100644
index 000000000000..501a5d31ef35
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -0,0 +1,469 @@
+/* Common tests */
+{
+	"map_kptr: BPF_ST imm != 0",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "BPF_ST imm must be 0 when storing to kptr at off=0",
+},
+{
+	"map_kptr: size != bpf_size_to_bytes(BPF_DW)",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ST_MEM(BPF_W, BPF_REG_0, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "kptr access size must be BPF_DW",
+},
+{
+	"map_kptr: map_value non-const var_off",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_2, 0),
+	BPF_JMP_IMM(BPF_JLE, BPF_REG_2, 4, 1),
+	BPF_EXIT_INSN(),
+	BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_2),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_3, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "kptr access cannot have variable offset",
+},
+{
+	"map_kptr: bpf_kptr_xchg non-const var_off",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_2, 0),
+	BPF_JMP_IMM(BPF_JLE, BPF_REG_2, 4, 1),
+	BPF_EXIT_INSN(),
+	BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_2),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_3),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "R1 doesn't have constant offset. kptr has to be at the constant offset",
+},
+{
+	"map_kptr: unaligned boundary load/store",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 7),
+	BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "kptr access misaligned expected=0 off=7",
+},
+{
+	"map_kptr: reject var_off != 0",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
+	BPF_JMP_IMM(BPF_JLE, BPF_REG_2, 4, 1),
+	BPF_EXIT_INSN(),
+	BPF_JMP_IMM(BPF_JGE, BPF_REG_2, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_2),
+	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "variable untrusted_ptr_ access var_off=(0x0; 0x7) disallowed",
+},
+/* Tests for unreferened PTR_TO_BTF_ID */
+{
+	"map_kptr: unref: reject btf_struct_ids_match == false",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 4),
+	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "invalid kptr access, R1 type=untrusted_ptr_prog_test_ref_kfunc expected=ptr_prog_test",
+},
+{
+	"map_kptr: unref: loaded pointer marked as untrusted",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "R0 invalid mem access 'untrusted_ptr_or_null_'",
+},
+{
+	"map_kptr: unref: correct in kernel type size",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 24),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "access beyond struct prog_test_ref_kfunc at off 24 size 8",
+},
+{
+	"map_kptr: unref: inherit PTR_UNTRUSTED on struct walk",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 16),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_this_cpu_ptr),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "R1 type=untrusted_ptr_ expected=percpu_ptr_",
+},
+{
+	"map_kptr: unref: no reference state created",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = ACCEPT,
+},
+{
+	"map_kptr: unref: bpf_kptr_xchg rejected",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "off=0 kptr isn't referenced kptr",
+},
+{
+	"map_kptr: unref: bpf_kfunc_call_test_kptr_get rejected",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_3, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "arg#0 no referenced kptr at map value offset=0",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_kfunc_call_test_kptr_get", 13 },
+	}
+},
+/* Tests for referenced PTR_TO_BTF_ID */
+{
+	"map_kptr: ref: loaded pointer marked as untrusted",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_0, 8),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_this_cpu_ptr),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "R1 type=untrusted_ptr_or_null_ expected=percpu_ptr_",
+},
+{
+	"map_kptr: ref: reject off != 0",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, 8),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "R2 must have zero offset when passed to release func",
+},
+{
+	"map_kptr: ref: reference state created and released on xchg",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8),
+	BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
+	BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, BPF_PSEUDO_KFUNC_CALL, 0, 0),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_kptr_xchg),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "Unreleased reference id=5 alloc_insn=20",
+	.fixup_kfunc_btf_id = {
+		{ "bpf_kfunc_call_test_acquire", 15 },
+	}
+},
+{
+	"map_kptr: ref: reject STX",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_1, 0),
+	BPF_STX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 8),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "store to referenced kptr disallowed",
+},
+{
+	"map_kptr: ref: reject ST",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_ST_MEM(BPF_DW, BPF_REG_0, 8, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "store to referenced kptr disallowed",
+},
+{
+	"map_kptr: reject helper access to kptr",
+	.insns = {
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_LD_MAP_FD(BPF_REG_6, 0),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 2),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_delete_elem),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_kptr = { 1 },
+	.result = REJECT,
+	.errstr = "kptr cannot be accessed indirectly by helper",
+},
-- 
2.35.1

