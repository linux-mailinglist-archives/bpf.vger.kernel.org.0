Return-Path: <bpf+bounces-77694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E1CEF1F9
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 19:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1059301EF86
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 18:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE7F2FE056;
	Fri,  2 Jan 2026 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ+2dnUE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B5324501B
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767376854; cv=none; b=asQCW6osgsamIG2cvf1a3w1rYghZIxJaH4dun0QoVUGu0EwY4cFmpEZTR4t3NQaPamhSZXLbtChW1aB6JKz6Z1rnegR7QBUhwcoAp+lZkED4l6ELEs35EH7CIdecWbkqLEHBaZxYCNaPSQwXYB0HykLF+MQYmsPhI4RPirs3HY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767376854; c=relaxed/simple;
	bh=3kqbf90NWrusK6a85JclmPAUXiiWKUPYsLUGHjoIvKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YW8o5HbXA/AUeJsCHt2WL3RRetm8+IWe3J4OP/+jhnc1V5LKrO76no2p7T28aWAtkMadwb/DFoCZDrEW5+lhA0N7U7mT6bdOhzhKcaBcvSuCErriQfXGKfoGE+TQJAlj0Nbn9Ez6OQwZNmFvVEvcEnb41Ihe0Hrhvi9Mz5oyD2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJ+2dnUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031FAC116B1;
	Fri,  2 Jan 2026 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767376853;
	bh=3kqbf90NWrusK6a85JclmPAUXiiWKUPYsLUGHjoIvKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJ+2dnUEuLcED8zGolEgkssEz50PA/w/8phO469x6xbkOCL3Zzyryt4JKqS3nqTct
	 xxti9g3xnY42uAOEcu6RhgYEBn72h95G13sS/LEHl8u+km/in6ZdJoL5cz3GnHlNco
	 Cvg5Cwe9JV1ckOYPpA67P/7Dcanl9lqim3aXDFpulFPyU1CYYAbj++osVr7/x2M/ao
	 7Vxu4u38gHYrqqFIiqyHAW2zyRR2GmiI+jKS1sp2CwdLPSQwqq7Ewr5kzVF/U6krbE
	 s+l5bhKpvCaeE8PfsJRl5opOvYzxWzfNXgvEJNo34r6Jec6nh+I3UnNGQaTF0Ruli/
	 FfdHCpjs0Mj5g==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"Emil Tsalapatis" <emil@etsalapatis.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 01/10] bpf: Make KF_TRUSTED_ARGS the default for all kfuncs
Date: Fri,  2 Jan 2026 10:00:27 -0800
Message-ID: <20260102180038.2708325-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102180038.2708325-1-puranjay@kernel.org>
References: <20260102180038.2708325-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the verifier to make trusted args the default requirement for
all kfuncs by removing is_kfunc_trusted_args() assuming it be to always
return true.

This works because:
1. Context pointers (xdp_md, __sk_buff, etc.) are handled through their
   own KF_ARG_PTR_TO_CTX case label and bypass the trusted check
2. Struct_ops callback arguments are already marked as PTR_TRUSTED during
   initialization and pass is_trusted_reg()
3. KF_RCU kfuncs are handled separately via is_kfunc_rcu() checks at
   call sites (always checked with || alongside is_kfunc_trusted_args)

This simple change makes all kfuncs require trusted args by default
while maintaining correct behavior for all existing special cases.

Note: This change means kfuncs that previously accepted NULL pointers
without KF_TRUSTED_ARGS will now reject NULL at verification time.
Several netfilter kfuncs are affected: bpf_xdp_ct_lookup(),
bpf_skb_ct_lookup(), bpf_xdp_ct_alloc(), and bpf_skb_ct_alloc() all
accept NULL for their bpf_tuple and opts parameters internally (checked
in __bpf_nf_ct_lookup), but after this change the verifier rejects NULL
before the kfunc is even called. This is acceptable because these kfuncs
don't work with NULL parameters in their proper usage. Now they will be
rejected rather than returning an error, which shouldn't make a
difference to BPF programs that were using these kfuncs properly.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 Documentation/bpf/kfuncs.rst | 184 +++++++++++++++++------------------
 fs/bpf_fs_kfuncs.c           |  10 +-
 kernel/bpf/verifier.c        |  14 +--
 3 files changed, 97 insertions(+), 111 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index e38941370b90..6cb6857bfa6f 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -50,7 +50,70 @@ A wrapper kfunc is often needed when we need to annotate parameters of the
 kfunc. Otherwise one may directly make the kfunc visible to the BPF program by
 registering it with the BPF subsystem. See :ref:`BPF_kfunc_nodef`.
 
-2.2 Annotating kfunc parameters
+2.2 kfunc Parameters
+--------------------
+
+All kfuncs now require trusted arguments by default. This means that all
+pointer arguments must be valid, and all pointers to BTF objects must be
+passed in their unmodified form (at a zero offset, and without having been
+obtained from walking another pointer, with exceptions described below).
+
+There are two types of pointers to kernel objects which are considered "trusted":
+
+1. Pointers which are passed as tracepoint or struct_ops callback arguments.
+2. Pointers which were returned from a KF_ACQUIRE kfunc.
+
+Pointers to non-BTF objects (e.g. scalar pointers) may also be passed to
+kfuncs, and may have a non-zero offset.
+
+The definition of "valid" pointers is subject to change at any time, and has
+absolutely no ABI stability guarantees.
+
+As mentioned above, a nested pointer obtained from walking a trusted pointer is
+no longer trusted, with one exception. If a struct type has a field that is
+guaranteed to be valid (trusted or rcu, as in KF_RCU description below) as long
+as its parent pointer is valid, the following macros can be used to express
+that to the verifier:
+
+* ``BTF_TYPE_SAFE_TRUSTED``
+* ``BTF_TYPE_SAFE_RCU``
+* ``BTF_TYPE_SAFE_RCU_OR_NULL``
+
+For example,
+
+.. code-block:: c
+
+	BTF_TYPE_SAFE_TRUSTED(struct socket) {
+		struct sock *sk;
+	};
+
+or
+
+.. code-block:: c
+
+	BTF_TYPE_SAFE_RCU(struct task_struct) {
+		const cpumask_t *cpus_ptr;
+		struct css_set __rcu *cgroups;
+		struct task_struct __rcu *real_parent;
+		struct task_struct *group_leader;
+	};
+
+In other words, you must:
+
+1. Wrap the valid pointer type in a ``BTF_TYPE_SAFE_*`` macro.
+
+2. Specify the type and name of the valid nested field. This field must match
+   the field in the original type definition exactly.
+
+A new type declared by a ``BTF_TYPE_SAFE_*`` macro also needs to be emitted so
+that it appears in BTF. For example, ``BTF_TYPE_SAFE_TRUSTED(struct socket)``
+is emitted in the ``type_is_trusted()`` function as follows:
+
+.. code-block:: c
+
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct socket));
+
+2.3 Annotating kfunc parameters
 -------------------------------
 
 Similar to BPF helpers, there is sometime need for additional context required
@@ -58,7 +121,7 @@ by the verifier to make the usage of kernel functions safer and more useful.
 Hence, we can annotate a parameter by suffixing the name of the argument of the
 kfunc with a __tag, where tag may be one of the supported annotations.
 
-2.2.1 __sz Annotation
+2.3.1 __sz Annotation
 ---------------------
 
 This annotation is used to indicate a memory and size pair in the argument list.
@@ -74,7 +137,7 @@ argument as its size. By default, without __sz annotation, the size of the type
 of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
 pointer.
 
-2.2.2 __k Annotation
+2.3.2 __k Annotation
 --------------------
 
 This annotation is only understood for scalar arguments, where it indicates that
@@ -98,7 +161,7 @@ Hence, whenever a constant scalar argument is accepted by a kfunc which is not a
 size parameter, and the value of the constant matters for program safety, __k
 suffix should be used.
 
-2.2.3 __uninit Annotation
+2.3.3 __uninit Annotation
 -------------------------
 
 This annotation is used to indicate that the argument will be treated as
@@ -115,7 +178,7 @@ Here, the dynptr will be treated as an uninitialized dynptr. Without this
 annotation, the verifier will reject the program if the dynptr passed in is
 not initialized.
 
-2.2.4 __opt Annotation
+2.3.4 __opt Annotation
 -------------------------
 
 This annotation is used to indicate that the buffer associated with an __sz or __szk
@@ -135,7 +198,7 @@ Either way, the returned buffer is either NULL, or of size buffer_szk. Without t
 annotation, the verifier will reject the program if a null pointer is passed in with
 a nonzero size.
 
-2.2.5 __str Annotation
+2.3.5 __str Annotation
 ----------------------------
 This annotation is used to indicate that the argument is a constant string.
 
@@ -160,7 +223,7 @@ Or::
                 ...
         }
 
-2.2.6 __prog Annotation
+2.3.6 __prog Annotation
 ---------------------------
 This annotation is used to indicate that the argument needs to be fixed up to
 the bpf_prog_aux of the caller BPF program. Any value passed into this argument
@@ -179,7 +242,7 @@ An example is given below::
 
 .. _BPF_kfunc_nodef:
 
-2.3 Using an existing kernel function
+2.4 Using an existing kernel function
 -------------------------------------
 
 When an existing function in the kernel is fit for consumption by BPF programs,
@@ -187,7 +250,7 @@ it can be directly registered with the BPF subsystem. However, care must still
 be taken to review the context in which it will be invoked by the BPF program
 and whether it is safe to do so.
 
-2.4 Annotating kfuncs
+2.5 Annotating kfuncs
 ---------------------
 
 In addition to kfuncs' arguments, verifier may need more information about the
@@ -216,7 +279,7 @@ protected. An example is given below::
         ...
         }
 
-2.4.1 KF_ACQUIRE flag
+2.5.1 KF_ACQUIRE flag
 ---------------------
 
 The KF_ACQUIRE flag is used to indicate that the kfunc returns a pointer to a
@@ -226,7 +289,7 @@ referenced kptr (by invoking bpf_kptr_xchg). If not, the verifier fails the
 loading of the BPF program until no lingering references remain in all possible
 explored states of the program.
 
-2.4.2 KF_RET_NULL flag
+2.5.2 KF_RET_NULL flag
 ----------------------
 
 The KF_RET_NULL flag is used to indicate that the pointer returned by the kfunc
@@ -235,87 +298,21 @@ returned from the kfunc before making use of it (dereferencing or passing to
 another helper). This flag is often used in pairing with KF_ACQUIRE flag, but
 both are orthogonal to each other.
 
-2.4.3 KF_RELEASE flag
+2.5.3 KF_RELEASE flag
 ---------------------
 
 The KF_RELEASE flag is used to indicate that the kfunc releases the pointer
 passed in to it. There can be only one referenced pointer that can be passed
 in. All copies of the pointer being released are invalidated as a result of
-invoking kfunc with this flag. KF_RELEASE kfuncs automatically receive the
-protection afforded by the KF_TRUSTED_ARGS flag described below.
-
-2.4.4 KF_TRUSTED_ARGS flag
---------------------------
-
-The KF_TRUSTED_ARGS flag is used for kfuncs taking pointer arguments. It
-indicates that the all pointer arguments are valid, and that all pointers to
-BTF objects have been passed in their unmodified form (that is, at a zero
-offset, and without having been obtained from walking another pointer, with one
-exception described below).
-
-There are two types of pointers to kernel objects which are considered "valid":
-
-1. Pointers which are passed as tracepoint or struct_ops callback arguments.
-2. Pointers which were returned from a KF_ACQUIRE kfunc.
-
-Pointers to non-BTF objects (e.g. scalar pointers) may also be passed to
-KF_TRUSTED_ARGS kfuncs, and may have a non-zero offset.
-
-The definition of "valid" pointers is subject to change at any time, and has
-absolutely no ABI stability guarantees.
-
-As mentioned above, a nested pointer obtained from walking a trusted pointer is
-no longer trusted, with one exception. If a struct type has a field that is
-guaranteed to be valid (trusted or rcu, as in KF_RCU description below) as long
-as its parent pointer is valid, the following macros can be used to express
-that to the verifier:
-
-* ``BTF_TYPE_SAFE_TRUSTED``
-* ``BTF_TYPE_SAFE_RCU``
-* ``BTF_TYPE_SAFE_RCU_OR_NULL``
-
-For example,
-
-.. code-block:: c
-
-	BTF_TYPE_SAFE_TRUSTED(struct socket) {
-		struct sock *sk;
-	};
-
-or
-
-.. code-block:: c
-
-	BTF_TYPE_SAFE_RCU(struct task_struct) {
-		const cpumask_t *cpus_ptr;
-		struct css_set __rcu *cgroups;
-		struct task_struct __rcu *real_parent;
-		struct task_struct *group_leader;
-	};
-
-In other words, you must:
-
-1. Wrap the valid pointer type in a ``BTF_TYPE_SAFE_*`` macro.
-
-2. Specify the type and name of the valid nested field. This field must match
-   the field in the original type definition exactly.
-
-A new type declared by a ``BTF_TYPE_SAFE_*`` macro also needs to be emitted so
-that it appears in BTF. For example, ``BTF_TYPE_SAFE_TRUSTED(struct socket)``
-is emitted in the ``type_is_trusted()`` function as follows:
-
-.. code-block:: c
-
-	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct socket));
-
+invoking kfunc with this flag.
 
-2.4.5 KF_SLEEPABLE flag
+2.5.4 KF_SLEEPABLE flag
 -----------------------
 
 The KF_SLEEPABLE flag is used for kfuncs that may sleep. Such kfuncs can only
 be called by sleepable BPF programs (BPF_F_SLEEPABLE).
 
-2.4.6 KF_DESTRUCTIVE flag
+2.5.5 KF_DESTRUCTIVE flag
 --------------------------
 
 The KF_DESTRUCTIVE flag is used to indicate functions calling which is
@@ -324,18 +321,19 @@ rebooting or panicking. Due to this additional restrictions apply to these
 calls. At the moment they only require CAP_SYS_BOOT capability, but more can be
 added later.
 
-2.4.7 KF_RCU flag
+2.5.6 KF_RCU flag
 -----------------
 
-The KF_RCU flag is a weaker version of KF_TRUSTED_ARGS. The kfuncs marked with
-KF_RCU expect either PTR_TRUSTED or MEM_RCU arguments. The verifier guarantees
-that the objects are valid and there is no use-after-free. The pointers are not
-NULL, but the object's refcount could have reached zero. The kfuncs need to
-consider doing refcnt != 0 check, especially when returning a KF_ACQUIRE
-pointer. Note as well that a KF_ACQUIRE kfunc that is KF_RCU should very likely
-also be KF_RET_NULL.
+The KF_RCU flag allows kfuncs to opt out of the default trusted args
+requirement and accept RCU pointers with weaker guarantees. The kfuncs marked
+with KF_RCU expect either PTR_TRUSTED or MEM_RCU arguments. The verifier
+guarantees that the objects are valid and there is no use-after-free. The
+pointers are not NULL, but the object's refcount could have reached zero. The
+kfuncs need to consider doing refcnt != 0 check, especially when returning a
+KF_ACQUIRE pointer. Note as well that a KF_ACQUIRE kfunc that is KF_RCU should
+very likely also be KF_RET_NULL.
 
-2.4.8 KF_RCU_PROTECTED flag
+2.5.7 KF_RCU_PROTECTED flag
 ---------------------------
 
 The KF_RCU_PROTECTED flag is used to indicate that the kfunc must be invoked in
@@ -354,7 +352,7 @@ RCU protection but do not take RCU protected arguments.
 
 .. _KF_deprecated_flag:
 
-2.4.9 KF_DEPRECATED flag
+2.5.8 KF_DEPRECATED flag
 ------------------------
 
 The KF_DEPRECATED flag is used for kfuncs which are scheduled to be
@@ -374,7 +372,7 @@ encouraged to make their use-cases known as early as possible, and participate
 in upstream discussions regarding whether to keep, change, deprecate, or remove
 those kfuncs if and when such discussions occur.
 
-2.5 Registering the kfuncs
+2.6 Registering the kfuncs
 --------------------------
 
 Once the kfunc is prepared for use, the final step to making it visible is
@@ -397,7 +395,7 @@ type. An example is shown below::
         }
         late_initcall(init_subsystem);
 
-2.6  Specifying no-cast aliases with ___init
+2.7  Specifying no-cast aliases with ___init
 --------------------------------------------
 
 The verifier will always enforce that the BTF type of a pointer passed to a
diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 5ace2511fec5..abd5eaa4892e 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -68,10 +68,7 @@ __bpf_kfunc void bpf_put_file(struct file *file)
  *
  * Resolve the pathname for the supplied *path* and store it in *buf*. This BPF
  * kfunc is the safer variant of the legacy bpf_d_path() helper and should be
- * used in place of bpf_d_path() whenever possible. It enforces KF_TRUSTED_ARGS
- * semantics, meaning that the supplied *path* must itself hold a valid
- * reference, or else the BPF program will be outright rejected by the BPF
- * verifier.
+ * used in place of bpf_d_path() whenever possible.
  *
  * This BPF kfunc may only be called from BPF LSM programs.
  *
@@ -377,9 +374,8 @@ static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	return -EACCES;
 }
 
-/* bpf_[set|remove]_dentry_xattr.* hooks have KF_TRUSTED_ARGS and
- * KF_SLEEPABLE, so they are only available to sleepable hooks with
- * dentry arguments.
+/* bpf_[set|remove]_dentry_xattr.* hooks have KF_SLEEPABLE, so they are only
+ * available to sleepable hooks with dentry arguments.
  *
  * Setting and removing xattr requires exclusive lock on dentry->d_inode.
  * Some hooks already locked d_inode, while some hooks have not locked
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d44c5d06623..359a962d69a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12040,11 +12040,6 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RELEASE;
 }
 
-static bool is_kfunc_trusted_args(struct bpf_kfunc_call_arg_meta *meta)
-{
-	return (meta->kfunc_flags & KF_TRUSTED_ARGS) || is_kfunc_release(meta);
-}
-
 static bool is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_SLEEPABLE;
@@ -13253,9 +13248,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EINVAL;
 		}
 
-		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
-		    (register_is_null(reg) || type_may_be_null(reg->type)) &&
-			!is_kfunc_arg_nullable(meta->btf, &args[i])) {
+		if ((register_is_null(reg) || type_may_be_null(reg->type)) &&
+		    !is_kfunc_arg_nullable(meta->btf, &args[i]) &&
+		    !is_kfunc_arg_optional(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
 			return -EACCES;
 		}
@@ -13320,9 +13315,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			fallthrough;
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
-			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
-				break;
-
 			if (!is_trusted_reg(reg)) {
 				if (!is_kfunc_rcu(meta)) {
 					verbose(env, "R%d must be referenced or trusted\n", regno);
-- 
2.47.3


