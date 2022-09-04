Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30785AC673
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiIDUmT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiIDUmP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBBD2CDD8
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:08 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bj12so13404021ejb.13
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KpdDgupqzzbUa1NqbLKUKOzHfNZ62ZFxYEzAPnsLyyA=;
        b=N+DHqqj5vEZZjmhNQYCtfGz2EjHDg7Te1Iyo2Exfo2G8UBcq1zFTv/BEjapPhNKxp7
         0N8yJXiBijoosQQzkZ0qOnwX8i8tsSqT6UmutMbVHIKkL9IAXeVSb1rzo++rEHxCCZmH
         ocxaKWW/uJyOb8lqVuhFCT+FRQ4zJ0OaBBixPnXP0vGinr3SevMFgOC156tXJ81YS4Kv
         /PWUKaNFxeWackhfq+4W4piTGyZqdIZGeLos/n49AP7ghlCMgj7rzvVhrv8dm9lakB8N
         PcYA6ty1jxhX9cxX1F43PLzPTP4B1TxQrMjGHAF9EQukyktKuNhTf1XcKBwb0riXk36B
         /OaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KpdDgupqzzbUa1NqbLKUKOzHfNZ62ZFxYEzAPnsLyyA=;
        b=Ej2f1zUv1Ib68UHFjbyiE4edczsQwbQSj9X36qmGNJkRJCYIxb9Hemd2vg1Bhy6hEF
         TA2xMWOEhgP2zkFdGnkg1xDiIFFL7sxCyh98uNhpvbZX/yEfkW8kjqHYR3hofQB8UIv4
         6RJM9jb8zRssqTmt92vVNVBpJsvg/7hP6J0Fztt7y5zDe0DNK7ePHa6j/NRW7+ZEzB5U
         ZlxZobeLQaSny0Hzpg3SqD+3meGAe0a7xhrKiCk4aGf0ufzaWzx1inbbuwwb2TRXBDQ3
         26IybIJkrS38QQqb+ZfD245EcKd6cLNF9n693pK9TKy5oRu06wiUF8H+bnHN69lMZyNW
         Y3sQ==
X-Gm-Message-State: ACgBeo0TeVAqtq+MX+NEht07BN0HavP9K0TVLTJLnlaZkYj1vMf78316
        nUJAl5nv3DFjqVCdltOP8xuuW62SRqHiYw==
X-Google-Smtp-Source: AA6agR5ROjlPpdgAswUkokiusk4+pF38GxRj7mOVLyWaGjlq0niSPQ1bplgGsJTrWKnuRhs8hFik4Q==
X-Received: by 2002:a17:907:7214:b0:731:465d:a77c with SMTP id dr20-20020a170907721400b00731465da77cmr32781753ejc.308.1662324126241;
        Sun, 04 Sep 2022 13:42:06 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090630cf00b0073dd1ac2fc8sm4085126ejb.195.2022.09.04.13.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:05 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 16/32] bpf: Introduce BPF memory object model
Date:   Sun,  4 Sep 2022 22:41:29 +0200
Message-Id: <20220904204145.3089-17-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19700; i=memxor@gmail.com; h=from:subject; bh=YwYms1MZlTYq4GUA/3V4tZPe2wGas24BEVoT0ibs3gk=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1wAt+rYJrsVw3L+MqC7hfUuMG/Z+ibts0o41RC k9MAXG2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcAAKCRBM4MiGSL8RyuR/D/ 9UOgazNuxC7saBSyMQsG4QrbY4CTU+TwZ/ps3T82/dL3lya5v7u40PuiDNy97j94ReAYvoodJjK9S6 mX6PIrJrQYD7gV+it5tbHPW/SG8GL7d4zFhpMmYxAu9rVsBPgMk7HfATZrj0BhOkMP9z9hU3o5aoeI xIhLbcicUOUQiuX51OSb/TC6GeY1UWAKS2GLKH4PtagYzLXqS+rwQcCWE4TeUnUE98xD8ZcKdY7xZG M1Q+Y5aABrzVIK9jLCnDyYgy9ILkQwPERcYc/KAdx4Ci6M50lSXPJ/ipgKs6j4YPwA7PlvwZ3qGNIr GwLK9GlEQy2LlyeumMGm2faaaMuDESy4H9rDHbvPCjfwWKvU7QEu0+VjKn3L+cF5BSggnwDkcNyzQN UiOwQ9hAzrJ/b+KeHHwwIYN8W6wM+I0WsVaB/tvxRpEHBIORXoHgQGN+muTiHjuF/TbbQds1eprW8c U63GIl8eQur6+UsQkO/Co8SW0P5Cz2vDtM7jPDNyP1FzWnp4x0wJ9CpaJ3+mm/NHgfcmMegXpW34k1 9EVzGaUgrOVcXPfSP5pO5TRlyVFejlxMF15Xfzlly14rRSOrxASbiRT4yL60fL+iLN1X6mcHGhN7Q5 zYdFsL2LSNTvvxhfR1YQxwCVNVROWrx9zdTyi2/UTIOOIoiKTPokc1+mDpSg==
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

Add the concept of a memory object model to BPF verifier.

What this means is that there are now some types that are not just plain
old data, but require explicit action when they are allocated on a
storage, before their lifetime is considered as started and before it is
allowed for them to escape the program. The verifier will track state of
such fields during the various phases of the object lifetime, where it
can be sure about certain invariants.

Some inspiration is taken from existing memory object and lifetime
models in C and C++ which have stood the test of time. See [0], [1], [2]
for more information, to find some similarities. In the future, the
separation of storage and object lifetime may be made more stark by
allowing to change effective type of storage allocated for a local kptr.
For now, that has been left out. It is only possible when verifier
understands when the program has exclusive access to storage, and when
the object it is hosting is no longer accessible to other CPUs.

This can be useful to maintain size-class based freelists inside BPF
programs and reuse storage of same size for different types. This would
only be safe to allow if verifier can ensure that while storage lifetime
has not ended, object lifetime for the current type has. This
necessiates separating the two and accomodating a simple model to track
object lifetime (composed recursively of more objects whose lifetime
is individually tracked).

Everytime a BPF program allocates such non-trivial types, it must call a
set of constructors on the object to fully begin its lifetime before it
can make use of the pointer to this type. If the program does not do so,
the verifier will complain and lead to failure in loading of the
program.

Similarly, when ending the lifetime of such types, it is required to
fully destruct the object using a series of destructors for each
non-trivial member, before finally freeing the storage the object is
making use of.

During both the construction and destruction phase, there can be only
one program that can own and access such an object, hence their is no
need of any explicit synchronization. The single ownership of such
objects makes it easy for the verifier to enforce the safety around the
beginning and end of the lifetime without resorting to dynamic checks.

When there are multiple fields needing construction or destruction, the
program must call their constructors in ascending order of the offset of
the field.

For example, consider the following type (support for such fields will
be added in subsequent patches):

struct data {
	struct bpf_spin_lock lock;
	struct bpf_list_head list __contains(struct, foo, node);
	int data;
};

struct data *d = bpf_kptr_alloc(...);
if (!d) { ... }

Now, the type of d would be PTR_TO_BTF_ID | MEM_TYPE_LOCAL |
OBJ_CONSTRUCTING, as it needs two constructor calls (for lock and head),
before it can be considered fully initialized and alive.

Hence, we must do (in order of field offsets):

bpf_spin_lock_init(&d->lock);
bpf_list_head_init(&d->list);

Once the final constructor call that is required for the type is made,
in this case bpf_list_head_init, the verifier will unmark the
OBJ_CONSTRUCTING flag. Now, the type is PTR_TO_BTF_ID | MEM_TYPE_LOCAL,
so the pointer can be used anywhere these local kptrs are allowed, and
it can also escape the program.

The verifier ensures that the pointer can only be made visible once the
construction of the object is complete.

Likewise, once the first call to destroy the non-trivial field with
greatest offset is made, the verifier marks the pointer as
OBJ_DESTRUCTING, ensuring that the destruction is taken to its
conclusion and renders the object unusable except for destruction and
consequent freeing of the storage it is occupying.

Construction is always done in ascending order of field offsets, and
destruction is done in descending order of field offsets.

  [0]: https://eel.is/c++draft/basic.life
       "C++: Memory and Objects"
  [1]: https://en.cppreference.com/w/cpp/language/lifetime
       "C++: Object Lifetime"
  [2]: https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2021/p2318r1.pdf
       "A Provenance-aware Memory Object Model for C"

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h          |  15 ++
 include/linux/bpf_verifier.h |  37 ++++-
 kernel/bpf/verifier.c        | 286 +++++++++++++++++++++++++++++++++++
 3 files changed, 336 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5c8bfb0eba17..910aa891b97a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -492,6 +492,21 @@ enum bpf_type_flag {
 	 */
 	MEM_TYPE_LOCAL		= BIT(11 + BPF_BASE_TYPE_BITS),
 
+	/* This is applied to PTR_TO_BTF_ID pointing to object of a local type
+	 * (also called local kptr) whose lifetime start needs explicit
+	 * constructor calls in the BPF program before it can be considered
+	 * fully intialized and ready for use, escape program, etc.
+	 */
+	OBJ_CONSTRUCTING	= BIT(12 + BPF_BASE_TYPE_BITS),
+
+	/* This is applied to PTR_TO_BTF_ID pointing to object of a local type
+	 * (also called local kptr) whose lifetime has ended officially and it
+	 * needs destructor calls to be invoked in the BPF program that has
+	 * final ownership of its storage before it can be released back to the
+	 * memory allocator.
+	 */
+	OBJ_DESTRUCTING		= BIT(13 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 73d9443d0074..2a9dcefca3b6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -49,6 +49,15 @@ enum bpf_reg_precise {
 	PRECISE_ABSOLUTE,
 };
 
+enum {
+	FIELD_STATE_UNKNOWN	  = 0,
+	FIELD_STATE_CONSTRUCTED   = 1,
+	FIELD_STATE_DESTRUCTED	  = 2,
+	/* We only have room for one more state */
+	FIELD_STATE_MAX,
+};
+static_assert(FIELD_STATE_MAX <= (1 << 2));
+
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
 	enum bpf_reg_type type;
@@ -74,6 +83,17 @@ struct bpf_reg_state {
 		struct {
 			struct btf *btf;
 			u32 btf_id;
+			/* In case of PTR_TO_BTF_ID to a local type, sometimes
+			 * it may embed some special kernel types that we need
+			 * to track the state of.
+			 * To save space, we use 2 bits per field for state
+			 * tracking, and so have room for 16 fields. The special
+			 * field with lowest offset takes first two bits,
+			 * special field with second lowest offset takes next
+			 * two bits, and so on. The mapping can be determined
+			 * each time we encounter the type.
+			 */
+			u32 states;
 		};
 
 		u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
@@ -92,8 +112,8 @@ struct bpf_reg_state {
 
 		/* Max size from any of the above. */
 		struct {
-			unsigned long raw1;
-			unsigned long raw2;
+			u64 raw1;
+			u64 raw2;
 		} raw;
 
 		u32 subprogno; /* for PTR_TO_FUNC */
@@ -645,4 +665,17 @@ static inline enum bpf_prog_type resolve_prog_type(struct bpf_prog *prog)
 		prog->aux->dst_prog->type : prog->type;
 }
 
+static inline int local_kptr_get_state(struct bpf_reg_state *reg, u8 index)
+{
+	WARN_ON_ONCE(index >= 16);
+	return (reg->states >> (2 * index)) & 0x3;
+}
+
+static inline void local_kptr_set_state(struct bpf_reg_state *reg, u8 index, u32 state)
+{
+	WARN_ON_ONCE(state >= FIELD_STATE_MAX);
+	reg->states &= ~(0x3UL << (2 * index));
+	reg->states |= (state << (2 * index));
+}
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 817131537adb..64cceb7d2f20 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -585,6 +585,10 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 		strncpy(prefix, "percpu_", 32);
 	if (type & PTR_UNTRUSTED)
 		strncpy(prefix, "untrusted_", 32);
+	if (type & OBJ_CONSTRUCTING)
+		strncpy(prefix, "constructing_", 32);
+	if (type & OBJ_DESTRUCTING)
+		strncpy(prefix, "destructing_", 32);
 
 	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
@@ -5861,6 +5865,9 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	 * fixed offset.
 	 */
 	case PTR_TO_BTF_ID:
+	case PTR_TO_BTF_ID | MEM_TYPE_LOCAL:
+	case PTR_TO_BTF_ID | MEM_TYPE_LOCAL | OBJ_CONSTRUCTING:
+	case PTR_TO_BTF_ID | MEM_TYPE_LOCAL | OBJ_DESTRUCTING:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * it's fixed offset must be 0.	In the other cases, fixed offset
 		 * can be non-zero.
@@ -7684,6 +7691,19 @@ static bool is_kfunc_arg_sfx_constant(const struct btf *btf, const struct btf_pa
 	return __kfunc_param_match_suffix(btf, arg, "__k");
 }
 
+static bool
+is_kfunc_arg_sfx_constructing_local_kptr(const struct btf *btf,
+					 const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__clkptr");
+}
+
+static bool is_kfunc_arg_sfx_destructing_local_kptr(const struct btf *btf,
+						    const struct btf_param *arg)
+{
+	return __kfunc_param_match_suffix(btf, arg, "__dlkptr");
+}
+
 /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
 static bool __btf_type_is_scalar_struct(struct bpf_verifier_env *env,
 					const struct btf *btf,
@@ -7755,6 +7775,8 @@ enum kfunc_ptr_arg_types {
 	KF_ARG_PTR_TO_CTX,
 	KF_ARG_PTR_TO_BTF_ID,	     /* Also covers reg2btf_ids conversions */
 	KF_ARG_PTR_TO_KPTR_STRONG,   /* PTR_TO_KPTR but type specific */
+	KF_ARG_CONSTRUCTING_LOCAL_KPTR,
+	KF_ARG_DESTRUCTING_LOCAL_KPTR,
 	KF_ARG_PTR_TO_MEM,
 	KF_ARG_PTR_TO_MEM_SIZE,	     /* Size derived from next argument, skip it */
 };
@@ -7778,6 +7800,12 @@ enum kfunc_ptr_arg_types get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	 * arguments, we resolve it to a known kfunc_ptr_arg_types enum
 	 * constant.
 	 */
+	if (is_kfunc_arg_sfx_constructing_local_kptr(meta->btf, &args[argno]))
+		return KF_ARG_CONSTRUCTING_LOCAL_KPTR;
+
+	if (is_kfunc_arg_sfx_destructing_local_kptr(meta->btf, &args[argno]))
+		return KF_ARG_DESTRUCTING_LOCAL_KPTR;
+
 	if (is_kfunc_arg_kptr_get(meta, argno)) {
 		if (!btf_type_is_ptr(ref_t)) {
 			verbose(env, "arg#0 BTF type must be a double pointer for kptr_get kfunc\n");
@@ -7892,6 +7920,241 @@ static int process_kf_arg_ptr_to_kptr_strong(struct bpf_verifier_env *env,
 	return 0;
 }
 
+struct local_type_field {
+	enum {
+		FIELD_MAX,
+	} type;
+	enum bpf_special_kfuncs ctor_kfunc;
+	enum bpf_special_kfuncs dtor_kfunc;
+	const char *name;
+	u32 offset;
+	bool needs_destruction;
+};
+
+static int local_type_field_cmp(const void *a, const void *b)
+{
+	const struct local_type_field *fa = a, *fb = b;
+
+	if (fa->offset < fb->offset)
+		return -1;
+	else if (fa->offset > fb->offset)
+		return 1;
+	return 0;
+}
+
+static int find_local_type_fields(const struct btf *btf, u32 btf_id, struct local_type_field *fields)
+{
+	/* XXX: Fill the fields when support is added */
+	sort(fields, FIELD_MAX, sizeof(fields[0]), local_type_field_cmp, NULL);
+	return FIELD_MAX;
+}
+
+static int
+process_kf_arg_constructing_local_kptr(struct bpf_verifier_env *env,
+				       struct bpf_reg_state *reg,
+				       struct bpf_kfunc_arg_meta *meta)
+{
+	struct local_type_field fields[FIELD_MAX];
+	struct bpf_func_state *fstate;
+	struct bpf_reg_state *ireg;
+	int ret, i, cnt;
+
+	ret = find_local_type_fields(reg->btf, reg->btf_id, fields);
+	if (ret < 0) {
+		verbose(env, "verifier internal error: bad field specification in local type\n");
+		return -EFAULT;
+	}
+
+	cnt = ret;
+	for (i = 0; i < cnt; i++) {
+		int j;
+
+		if (fields[i].offset != reg->off)
+			continue;
+
+		switch (local_kptr_get_state(reg, i)) {
+		case FIELD_STATE_CONSTRUCTED:
+			verbose(env, "'%s' field at offset %d has already been constructed\n",
+				fields[i].name, fields[i].offset);
+			return -EINVAL;
+		case FIELD_STATE_UNKNOWN:
+			break;
+		case FIELD_STATE_DESTRUCTED:
+			WARN_ON_ONCE(1);
+			fallthrough;
+		default:
+			verbose(env, "verifier internal error: unknown field state\n");
+			return -EFAULT;
+		}
+
+		/* Make sure everything coming before us has been constructed */
+		for (j = 0; j < i; j++) {
+			if (local_kptr_get_state(reg, j) != FIELD_STATE_CONSTRUCTED) {
+				verbose(env, "'%s' field at offset %d must be constructed before this field\n",
+					fields[j].name, fields[j].offset);
+				return -EINVAL;
+			}
+		}
+
+		/* Since we always ensure everything before us is constructed,
+		 * fields after us will be in unknown state, so we do not need
+		 * to check them.
+		 */
+		if (!__is_kfunc_special(meta->btf, meta->func_id, fields[i].ctor_kfunc)) {
+			verbose(env, "incorrect constructor function for '%s' field\n",
+				fields[i].name);
+			return -EINVAL;
+		}
+
+		/* The constructor is the right one, everything before us is
+		 * also constructed, so we can mark this field as constructed.
+		 */
+		bpf_expr_for_each_reg_in_vstate(env->cur_state, fstate, ireg, ({
+			if (ireg->ref_obj_id == reg->ref_obj_id)
+				local_kptr_set_state(ireg, i, FIELD_STATE_CONSTRUCTED);
+		}));
+
+		/* If we are the final field needing construction, move the
+		 * object from constructing to constructed state as a whole.
+		 */
+		if (i + 1 == cnt) {
+			bpf_expr_for_each_reg_in_vstate(env->cur_state, fstate, ireg, ({
+				if (ireg->ref_obj_id == reg->ref_obj_id) {
+					ireg->type &= ~OBJ_CONSTRUCTING;
+					/* clear states to make it usable for tracking states of fields
+					 * after construction.
+					 */
+					reg->states = 0;
+				}
+			}));
+		}
+		return 0;
+	}
+	verbose(env, "no constructible field at offset: %d\n", reg->off);
+	return -EINVAL;
+}
+
+static int
+process_kf_arg_destructing_local_kptr(struct bpf_verifier_env *env,
+				      struct bpf_reg_state *reg,
+				      struct bpf_kfunc_arg_meta *meta)
+{
+	struct local_type_field fields[FIELD_MAX];
+	struct bpf_func_state *fstate;
+	struct bpf_reg_state *ireg;
+	int ret, i, cnt;
+
+	ret = find_local_type_fields(reg->btf, reg->btf_id, fields);
+	if (ret < 0) {
+		verbose(env, "verifier internal error: bad field specification in local type\n");
+		return -EFAULT;
+	}
+
+	cnt = ret;
+	/* If this is a normal reg transitioning to destructing phase,
+	 * mark state for all fields as constructed, to begin tracking
+	 * them during destruction.
+	 */
+	if (reg->type == (PTR_TO_BTF_ID | MEM_TYPE_LOCAL)) {
+		bpf_expr_for_each_reg_in_vstate(env->cur_state, fstate, ireg, ({
+			if (ireg->ref_obj_id != reg->ref_obj_id)
+				continue;
+			for (i = 0; i < cnt; i++)
+				local_kptr_set_state(ireg, i, FIELD_STATE_CONSTRUCTED);
+		}));
+	}
+
+	for (i = 0; i < cnt; i++) {
+		bool mark_dtor = false, unmark_ctor = false;
+		int j;
+
+		if (fields[i].offset != reg->off)
+			continue;
+
+		switch (local_kptr_get_state(reg, i)) {
+		case FIELD_STATE_UNKNOWN:
+			verbose(env, "'%s' field at offset %d has not been constructed\n",
+				fields[i].name, fields[i].offset);
+			return -EINVAL;
+		case FIELD_STATE_DESTRUCTED:
+			verbose(env, "'%s' field at offset %d has already been destructed\n",
+				fields[i].name, fields[i].offset);
+			return -EINVAL;
+		case FIELD_STATE_CONSTRUCTED:
+			break;
+		default:
+			verbose(env, "verifier internal error: unknown field state\n");
+			return -EFAULT;
+		}
+
+		/* Ensure all fields after us have been destructed */
+		for (j = i + 1; j < cnt; j++) {
+			if (!fields[j].needs_destruction)
+				continue;
+			/* For normal case, every field is constructed, so we
+			 * must check destruction order. If we see constructed
+			 * after us that needs destruction, we catch out of
+			 * order destructor call.
+			 *
+			 * For constructing kptr being destructed, later fields
+			 * may be in unknown state. It is fine to not destruct
+			 * them, as we are unwinding construction.
+			 *
+			 * For already destructing kptr, we can only see
+			 * destructed or unknown for later fields, never
+			 * constructed.
+			 */
+			if (local_kptr_get_state(reg, j) == FIELD_STATE_CONSTRUCTED) {
+				verbose(env, "'%s' field at offset %d must be destructed before this field\n",
+					fields[j].name, fields[j].offset);
+				return -EINVAL;
+			}
+		}
+
+		/* Everything before us must be constructed */
+		for (j = i - 1; j >= 0; j--) {
+			if (local_kptr_get_state(reg, j) != FIELD_STATE_CONSTRUCTED) {
+				verbose(env, "invalid state of '%s' field at offset %d\n",
+					fields[j].name, fields[j].offset);
+				return -EINVAL;
+			}
+		}
+
+		if (!__is_kfunc_special(meta->btf, meta->func_id, fields[i].dtor_kfunc)) {
+			verbose(env, "incorrect destructor function for '%s' field\n",
+				fields[i].name);
+			return -EINVAL;
+		}
+
+		if (reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL | OBJ_DESTRUCTING)) {
+			mark_dtor = true;
+			if (reg->type & OBJ_CONSTRUCTING)
+				unmark_ctor = true;
+		}
+
+		/* The destructor is the right one, everything after us is
+		 * also destructed, so we can mark this field as destructed.
+		 */
+		bpf_expr_for_each_reg_in_vstate(env->cur_state, fstate, ireg, ({
+			if (ireg->ref_obj_id != reg->ref_obj_id)
+				continue;
+			local_kptr_set_state(ireg, i, FIELD_STATE_DESTRUCTED);
+			/* If mark_dtor is true, this is either a normal or
+			 * constructing kptr entering the destructing phase. If
+			 * it is constructing kptr, we also need to unmark
+			 * OBJ_CONSTRUCTING flag.
+			 */
+			if (unmark_ctor)
+				ireg->type &= ~OBJ_CONSTRUCTING;
+			if (mark_dtor)
+				ireg->type |= OBJ_DESTRUCTING;
+		}));
+		return 0;
+	}
+	verbose(env, "no destructible field at offset: %d\n", reg->off);
+	return -EINVAL;
+}
+
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_arg_meta *meta)
 {
 	const char *func_name = meta->func_name, *ref_tname;
@@ -8011,6 +8274,25 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_arg_m
 			if (ret < 0)
 				return ret;
 			break;
+		case KF_ARG_CONSTRUCTING_LOCAL_KPTR:
+			if (reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL | OBJ_CONSTRUCTING)) {
+				verbose(env, "arg#%d expected pointer to constructing local kptr\n", i);
+				return -EINVAL;
+			}
+			ret = process_kf_arg_constructing_local_kptr(env, reg, meta);
+			if (ret < 0)
+				return ret;
+			break;
+		case KF_ARG_DESTRUCTING_LOCAL_KPTR:
+			if (base_type(reg->type) != PTR_TO_BTF_ID ||
+			    (type_flag(reg->type) & ~(MEM_TYPE_LOCAL | OBJ_CONSTRUCTING | OBJ_DESTRUCTING))) {
+				verbose(env, "arg#%d expected pointer to normal, constructing, or destructing local kptr\n", i);
+				return -EINVAL;
+			}
+			ret = process_kf_arg_destructing_local_kptr(env, reg, meta);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_MEM:
 			resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
 			if (IS_ERR(resolve_ret)) {
@@ -8157,6 +8439,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			 * setting of this flag.
 			 */
 			regs[BPF_REG_0].type |= MEM_TYPE_LOCAL;
+			/* TODO: Recognize special fields in local type aand
+			 * force their construction before pointer escapes by
+			 * setting OBJ_CONSTRUCTING.
+			 */
 		} else {
 			if (!btf_type_is_struct(ptr_type)) {
 				ptr_type_name = btf_name_by_offset(desc_btf, ptr_type->name_off);
-- 
2.34.1

