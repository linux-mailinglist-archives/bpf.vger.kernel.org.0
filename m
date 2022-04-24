Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4485450D565
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 23:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiDXVwi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 17:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbiDXVwc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 17:52:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9961F644DF
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k14so11892925pga.0
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bLuBqY4PJdBpH5AusJBrxubVKetrC0vBPoERUzIBRLM=;
        b=p4c+qjZcZGF+peKj4e6omPUmnMfYYRcXVMfZ0VsBtGig7SHBnChlcwH2VScfN7b+9d
         7ithh9KacVr1hv9uXarwiKZbU7HS6vbTLi9UYDEFTpvOjd6ERSgvyM0E9KRWbNdjmHaM
         i8PI3ePNL/IrhyzO9nR5alzztJ4KnUkQ+gMlmCo6D2cPQjYCwznHXx7Z7+h5Seeimiz4
         /ZVsjC27V5sn2Ks2wvupNhtA9bhIXuz7bakBGwDdXus5uPzTAM/CKtPZ7XLNlFnVPKXe
         Lvj2Ic8H92k9Rg21rXnWMjrqoGDbOfCJx/5EJ+AoFHaUhfHka3e7EOAhL35EHeuZqqCy
         bl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bLuBqY4PJdBpH5AusJBrxubVKetrC0vBPoERUzIBRLM=;
        b=CZn6dqZwE2mXpvcosLdYWUMMjtIn2sDBPUHKqEk02eCXAALsp2YYIxpDH9erwmLtt9
         lmuepTUqHP3r3BDQt8Qm4WGXYkKzXpqZCaa6ZU3wO0oi+rptig1AvZ8pEz6sxNX61dys
         QFEOypEPxVDrpLp9rqMmwdXiqkj36f26ckN0c4ZyqB/7GgKoeyRii0R8DH1bkw2ESHQI
         OqitN09jEMeghR+RSuIorBESfNia/Vht3plKyeHIrz/BO38QS9LxYz3jWpSOvwj1fWC5
         mbXfD5srxN8Zo/YPkM+ti/jPjQRuuHxJrOWYlPQXprU77nLATJjPX/3TrozDhsNrg/uK
         48zw==
X-Gm-Message-State: AOAM530Xy8ohbRAPh3ssneLNCat6rWT6OHn62vE+q5A49UNbGy0rIyfI
        kPhfGaQ7JsCXzibXCJUipSUafK4TiVQ=
X-Google-Smtp-Source: ABdhPJw3oelPQjtozhunWd4c5+MHodo+HGB/HAXmUGHAGiHqYXdfj/xBlVi9CqAznjkKdP3iw89IlA==
X-Received: by 2002:aa7:9783:0:b0:50c:f012:2727 with SMTP id o3-20020aa79783000000b0050cf0122727mr13069449pfp.8.1650836968647;
        Sun, 24 Apr 2022 14:49:28 -0700 (PDT)
Received: from localhost ([157.49.66.127])
        by smtp.gmail.com with ESMTPSA id p3-20020a17090a2d8300b001d6a79768b6sm11949502pjd.49.2022.04.24.14.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:49:28 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v6 12/13] selftests/bpf: Add verifier tests for kptr
Date:   Mon, 25 Apr 2022 03:19:00 +0530
Message-Id: <20220424214901.2743946-13-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424214901.2743946-1-memxor@gmail.com>
References: <20220424214901.2743946-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23963; h=from:subject; bh=2HGfpnMVQrfnC5ndNKYCMLtBfhJXiysWJl3kdxiI4MI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiZcTLJYfhxzvUnW5wvL0ShS3wCiP3KFXfx00kPdUu 9zmhkuKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYmXEywAKCRBM4MiGSL8RygX8D/ 4hY6B9o8WdTKVOMT6goV5hHV7vyC9q2CD9CGvwE1zNrS1WNd4GMkBqKWwA/FzhDLn5PzOaVUTOTZFQ 4Uq81p9rMhxIpuouh5+XzuuMl1frQP1Ju0G0ug2EnJgd41ozivSMwjrNmh6Ief6gHw6WlqXC2/gBcs ZVOjSXOlp2IxiNe7ozAgkggi+vKJglhMnYYZzi/RZQNahwZBlMA6R3d0w62+vGqz9omRn+ZWcT/MPA sd5d5j7tn87pIUwT2CyHZiwqEUQLCiFnht8alj6NUrYtJtTRTQmRp8P+t6TsUy3lkKbJraXhFmsqIe LOuUnjecdVyXDsLjSRo7UBTBra71bfokWVduRR1gpgQIJUHcDLbkMV4FALvCvfIMf7RVH6PnTcQBy/ JbRg2iLtVVkzZjItyNdk8hQfkDJ165DRztV/EeQpdMUFEx+Tv50P14zcgRemXWn9bUBa4VtxVFjlx1 3eG61COnrisotb9abwdgwukDmk3usNkFQi9VrQJqwCmnUvCt0b/0qEARdep1gZeNtjlbZbr2qQS3h2 Y6zIYgKqAFs5b8fddwv8MU/6dxr3Vo3iiKNOf2H3xtdkbpMDjUr1I9Qqxk4qPLnCdybbpJBJ7ZgMZR dcLsmDBl1/s6oaslsR/EmvqatLTNJCb/AC4jUyrs34m2KlX4LuuK/80fnUhw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 000000000000..9113834640e6
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
+	.errstr = "invalid kptr access, R2 type=ptr_prog_test_ref_kfunc expected=ptr_prog_test_member",
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

