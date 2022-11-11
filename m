Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D296261FC
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiKKTd3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiKKTd1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:33:27 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17DA62EB
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:25 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id s196so5141556pgs.3
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Qn946/Dfi7ihlJL944GILOqS6Benn+3+4NY3sXoxuY=;
        b=Bd3aKnKOT/9np74KxEcC0tQPgcjuJ1bROkpwOxpKTtx+wNA2vQXMiC6Gnm/24ovXyU
         fGCbWG/gUS5DdoIYb8yRerwXf9eoq26hi5rhY895BoMHDmF5PscKIf3MUGIbI1TCM/I8
         wB3fVfZZC7GSO8IVL7AZeyA4MVerN2TgJi+/eOKhd4ffgWb7cIl6ouSPd/3ITQ0JN/Af
         Yd+ysuZPnGFkCzJvMI7uGKnyxzsIk0gVLv47Z+213aJ4sr/u6lmwHDS1fHLk7nULhd0Y
         tMknmJAMrCcTxD/btsEzw7wpVFwbFBMD78ayBPL1n8q1Y/vP1F7SjnqCYEAMEgUqhu7U
         0dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Qn946/Dfi7ihlJL944GILOqS6Benn+3+4NY3sXoxuY=;
        b=1/EewteDVxfvgKYKWWFmtg7dDOtzsb46hlzsn2tMNvF8tLJAspAjW9B+jPnqwG/x0q
         n9gFj61Ls6sz74raosWJnv2ZPSdn4qgpCnv4XVvzHmLQ+rrvASVWZoUlM25phA0DFpqE
         t6Unuj1plTmHa8JeOZIvXkDCb4XMIJ1xGY3QoVBMvEga/6wxdZ10kGLu/s85Am7zMXMV
         NjVk+GkS3n2pvG7cNucaurgjwaOyyZgbEiu2mJpR6Zx8o41WTmTzlcRqDQXwFgh9F8cf
         uvX0NDgBX47prVXIlksy09GotRik7nUvXgKx7J5n6GrAeUsza8zT6K0WEMsKmbhBYN1N
         tVAA==
X-Gm-Message-State: ANoB5pks9nQumB2bA2TmJP1pCJoSz7F56eGo7/N9F2FDcOki6ey1XwHF
        HYNR0pUhG5u3gtIa6cZwmIMJk0IhDqltsA==
X-Google-Smtp-Source: AA0mqf5hOyjfbmQPJtK7ZDTPiU3ubdoTwQi77flbe4E9ZUpDtsLQB/hlOdcDoYo+q7PzOl1jwPKlVA==
X-Received: by 2002:a63:e80f:0:b0:46b:4d6:e82b with SMTP id s15-20020a63e80f000000b0046b04d6e82bmr2888749pgh.88.1668195205179;
        Fri, 11 Nov 2022 11:33:25 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id p21-20020a631e55000000b004405c6eb962sm1707523pgm.4.2022.11.11.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:33:24 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 06/26] bpf: Rename MEM_ALLOC to MEM_RINGBUF
Date:   Sat, 12 Nov 2022 01:02:04 +0530
Message-Id: <20221111193224.876706-7-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9098; i=memxor@gmail.com; h=from:subject; bh=QiF5aiMWdeVPrX2X+RNmqO7yjZn/FhBvFcVkHpPSfBU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqIn6ZPke4vV7BNRjXfeS4Pi5fu52IQiEddTUb6G YQ5duCiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iJwAKCRBM4MiGSL8RypF2EA ChO/4ly0Pzm7t4mLmn3cL0Xdq1ZEl2DZuvSdCk9XSlMDO4bn+WBMgO0VgamZEqG0HJe1Q9aMmCqcTN t+56IqynbsfrS74g7+95i5n/HpezZVlMdFfP+6PhoggPAyvvIrwQznXpXiH5E6irheJ9YsP2tWl/Oh oxQfTA4vnid4dHAdQeK5BFLjjsGxPV3+iC4u4oHb0x5cMoLj1jwnTDfIlEq69D43qxDrRGBZd7AgJl bwLZV7SfM+ys//fiT1dvOxYywkva0Nw2d5z6XvcQabZao1PyaH14s/b3lO//yiOH14UArHcd6ZHebe ylWPBuqB/ZNPgZMVRfTnN51rnMOLcn7LYWydu0T6pwK8Y6kWNN1cCP3TbLmGr6C4SWjRDpJ7D6Pon9 RHB3tJJQERUgVG37hCm5/YnP3haruPbNtK5oD1opWIZ/As8uO6K7hksXXFNK/NVlL4wtuufgV9JaOp t4/IyEEp2BAEvJvuX5wOjomriJhXqiuPS16rLA+Sqvvq834p3qfrhMzKavPdgS2WtLyrD4mRWXSIXy wuxO+NjVi2MrqjhiZ7bNaaXBYIpRDc4ALPekkYeq3gUNX/BZPbyNIyo8IuQEQT6pis9WYGx+M+SHlw LZWm1I+9H5F4yRfpuEjklur0uWQ3G3xrEB3daoKYzcbOtJvbtq9LdAc1eB1g==
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

Currently, verifier uses MEM_ALLOC type tag to specially tag memory
returned from bpf_ringbuf_reserve helper. However, this is currently
only used for this purpose and there is an implicit assumption that it
only refers to ringbuf memory (e.g. the check for ARG_PTR_TO_ALLOC_MEM
in check_func_arg_reg_off).

Hence, rename MEM_ALLOC to MEM_RINGBUF to indicate this special
relationship and instead open the use of MEM_ALLOC for more generic
allocations made for user types.

Also, since ARG_PTR_TO_ALLOC_MEM_OR_NULL is unused, simply drop it.

Finally, update selftests using 'alloc_' verifier string to 'ringbuf_'.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                               | 11 ++++-------
 kernel/bpf/ringbuf.c                              |  6 +++---
 kernel/bpf/verifier.c                             | 14 +++++++-------
 tools/testing/selftests/bpf/prog_tests/dynptr.c   |  2 +-
 tools/testing/selftests/bpf/verifier/ringbuf.c    |  2 +-
 tools/testing/selftests/bpf/verifier/spill_fill.c |  2 +-
 6 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2fe3ec620d54..afc1c51b59ff 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -488,10 +488,8 @@ enum bpf_type_flag {
 	 */
 	MEM_RDONLY		= BIT(1 + BPF_BASE_TYPE_BITS),
 
-	/* MEM was "allocated" from a different helper, and cannot be mixed
-	 * with regular non-MEM_ALLOC'ed MEM types.
-	 */
-	MEM_ALLOC		= BIT(2 + BPF_BASE_TYPE_BITS),
+	/* MEM points to BPF ring buffer reservation. */
+	MEM_RINGBUF		= BIT(2 + BPF_BASE_TYPE_BITS),
 
 	/* MEM is in user address space. */
 	MEM_USER		= BIT(3 + BPF_BASE_TYPE_BITS),
@@ -565,7 +563,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_LONG,	/* pointer to long */
 	ARG_PTR_TO_SOCKET,	/* pointer to bpf_sock (fullsock) */
 	ARG_PTR_TO_BTF_ID,	/* pointer to in-kernel struct */
-	ARG_PTR_TO_ALLOC_MEM,	/* pointer to dynamically allocated memory */
+	ARG_PTR_TO_RINGBUF_MEM,	/* pointer to dynamically reserved ringbuf memory */
 	ARG_CONST_ALLOC_SIZE_OR_ZERO,	/* number of allocated bytes requested */
 	ARG_PTR_TO_BTF_ID_SOCK_COMMON,	/* pointer to in-kernel sock_common or bpf-mirrored bpf_sock */
 	ARG_PTR_TO_PERCPU_BTF_ID,	/* pointer to in-kernel percpu type */
@@ -582,7 +580,6 @@ enum bpf_arg_type {
 	ARG_PTR_TO_MEM_OR_NULL		= PTR_MAYBE_NULL | ARG_PTR_TO_MEM,
 	ARG_PTR_TO_CTX_OR_NULL		= PTR_MAYBE_NULL | ARG_PTR_TO_CTX,
 	ARG_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
-	ARG_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_ALLOC_MEM,
 	ARG_PTR_TO_STACK_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
 	ARG_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | ARG_PTR_TO_BTF_ID,
 	/* pointer to memory does not need to be initialized, helper function must fill
@@ -617,7 +614,7 @@ enum bpf_return_type {
 	RET_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
 	RET_PTR_TO_TCP_SOCK_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
 	RET_PTR_TO_SOCK_COMMON_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
-	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_MEM,
+	RET_PTR_TO_RINGBUF_MEM_OR_NULL	= PTR_MAYBE_NULL | MEM_RINGBUF | RET_PTR_TO_MEM,
 	RET_PTR_TO_DYNPTR_MEM_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_MEM,
 	RET_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
 
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 9e832acf4692..80f4b4d88aaf 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -447,7 +447,7 @@ BPF_CALL_3(bpf_ringbuf_reserve, struct bpf_map *, map, u64, size, u64, flags)
 
 const struct bpf_func_proto bpf_ringbuf_reserve_proto = {
 	.func		= bpf_ringbuf_reserve,
-	.ret_type	= RET_PTR_TO_ALLOC_MEM_OR_NULL,
+	.ret_type	= RET_PTR_TO_RINGBUF_MEM_OR_NULL,
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_CONST_ALLOC_SIZE_OR_ZERO,
 	.arg3_type	= ARG_ANYTHING,
@@ -490,7 +490,7 @@ BPF_CALL_2(bpf_ringbuf_submit, void *, sample, u64, flags)
 const struct bpf_func_proto bpf_ringbuf_submit_proto = {
 	.func		= bpf_ringbuf_submit,
 	.ret_type	= RET_VOID,
-	.arg1_type	= ARG_PTR_TO_ALLOC_MEM | OBJ_RELEASE,
+	.arg1_type	= ARG_PTR_TO_RINGBUF_MEM | OBJ_RELEASE,
 	.arg2_type	= ARG_ANYTHING,
 };
 
@@ -503,7 +503,7 @@ BPF_CALL_2(bpf_ringbuf_discard, void *, sample, u64, flags)
 const struct bpf_func_proto bpf_ringbuf_discard_proto = {
 	.func		= bpf_ringbuf_discard,
 	.ret_type	= RET_VOID,
-	.arg1_type	= ARG_PTR_TO_ALLOC_MEM | OBJ_RELEASE,
+	.arg1_type	= ARG_PTR_TO_RINGBUF_MEM | OBJ_RELEASE,
 	.arg2_type	= ARG_ANYTHING,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2407e3b179ec..5fca156eca43 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -577,8 +577,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 
 	if (type & MEM_RDONLY)
 		strncpy(prefix, "rdonly_", 32);
-	if (type & MEM_ALLOC)
-		strncpy(prefix, "alloc_", 32);
+	if (type & MEM_RINGBUF)
+		strncpy(prefix, "ringbuf_", 32);
 	if (type & MEM_USER)
 		strncpy(prefix, "user_", 32);
 	if (type & MEM_PERCPU)
@@ -5780,7 +5780,7 @@ static const struct bpf_reg_types mem_types = {
 		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
 		PTR_TO_MEM,
-		PTR_TO_MEM | MEM_ALLOC,
+		PTR_TO_MEM | MEM_RINGBUF,
 		PTR_TO_BUF,
 	},
 };
@@ -5798,7 +5798,7 @@ static const struct bpf_reg_types int_ptr_types = {
 static const struct bpf_reg_types fullsock_types = { .types = { PTR_TO_SOCKET } };
 static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
-static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
+static const struct bpf_reg_types ringbuf_mem_types = { .types = { PTR_TO_MEM | MEM_RINGBUF } };
 static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
 static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
 static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
@@ -5831,7 +5831,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_BTF_ID]		= &btf_ptr_types,
 	[ARG_PTR_TO_SPIN_LOCK]		= &spin_lock_types,
 	[ARG_PTR_TO_MEM]		= &mem_types,
-	[ARG_PTR_TO_ALLOC_MEM]		= &alloc_mem_types,
+	[ARG_PTR_TO_RINGBUF_MEM]	= &ringbuf_mem_types,
 	[ARG_PTR_TO_INT]		= &int_ptr_types,
 	[ARG_PTR_TO_LONG]		= &int_ptr_types,
 	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
@@ -5952,14 +5952,14 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_MAP_VALUE:
 	case PTR_TO_MEM:
 	case PTR_TO_MEM | MEM_RDONLY:
-	case PTR_TO_MEM | MEM_ALLOC:
+	case PTR_TO_MEM | MEM_RINGBUF:
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
 	case SCALAR_VALUE:
 		/* Some of the argument types nevertheless require a
 		 * zero register offset.
 		 */
-		if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
+		if (base_type(arg_type) != ARG_PTR_TO_RINGBUF_MEM)
 			return 0;
 		break;
 	/* All the rest must be rejected, except PTR_TO_BTF_ID which allows
diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 8fc4e6c02bfd..b0c06f821cb8 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -17,7 +17,7 @@ static struct {
 	{"ringbuf_missing_release2", "Unreleased reference id=2"},
 	{"ringbuf_missing_release_callback", "Unreleased reference id"},
 	{"use_after_invalid", "Expected an initialized dynptr as arg #3"},
-	{"ringbuf_invalid_api", "type=mem expected=alloc_mem"},
+	{"ringbuf_invalid_api", "type=mem expected=ringbuf_mem"},
 	{"add_dynptr_to_map1", "invalid indirect read from stack"},
 	{"add_dynptr_to_map2", "invalid indirect read from stack"},
 	{"data_slice_out_of_bounds_ringbuf", "value is outside of the allowed memory range"},
diff --git a/tools/testing/selftests/bpf/verifier/ringbuf.c b/tools/testing/selftests/bpf/verifier/ringbuf.c
index b64d33e4833c..84838feba47f 100644
--- a/tools/testing/selftests/bpf/verifier/ringbuf.c
+++ b/tools/testing/selftests/bpf/verifier/ringbuf.c
@@ -28,7 +28,7 @@
 	},
 	.fixup_map_ringbuf = { 1 },
 	.result = REJECT,
-	.errstr = "dereference of modified alloc_mem ptr R1",
+	.errstr = "dereference of modified ringbuf_mem ptr R1",
 },
 {
 	"ringbuf: invalid reservation offset 2",
diff --git a/tools/testing/selftests/bpf/verifier/spill_fill.c b/tools/testing/selftests/bpf/verifier/spill_fill.c
index e23f07175e1b..9bb302dade23 100644
--- a/tools/testing/selftests/bpf/verifier/spill_fill.c
+++ b/tools/testing/selftests/bpf/verifier/spill_fill.c
@@ -84,7 +84,7 @@
 	},
 	.fixup_map_ringbuf = { 1 },
 	.result = REJECT,
-	.errstr = "R0 pointer arithmetic on alloc_mem_or_null prohibited",
+	.errstr = "R0 pointer arithmetic on ringbuf_mem_or_null prohibited",
 },
 {
 	"check corrupted spill/fill",
-- 
2.38.1

