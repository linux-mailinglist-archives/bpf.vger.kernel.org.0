Return-Path: <bpf+bounces-65552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E42CB254CF
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF887AE103
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230E52ECD02;
	Wed, 13 Aug 2025 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MePD4sJ/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6BA2FE597;
	Wed, 13 Aug 2025 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118548; cv=none; b=gl2z81tJOL+coywhUsGwjd1Y88ZEr04g1vhpF/g1Y2CnPKVtchPkk6yrXghz3cyckw+N6tDSVPPTYc+1FBiPHSjsiOB672UbCvjCgmSfc3EUt7Rb/7NGDFLESvAMygFxQ2LyNxbtuDBTFd8FJzg9M940vrX1jJrRZMb2IoC4vuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118548; c=relaxed/simple;
	bh=fnLVc97hLK6HSNu9HvM244ZanGfdhd7J4dAa2Ee9EMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gx0+EETGsrkC4k47kVRWpivKbAwd6N7Lu+JhWYEUq6LqqPtyHRK80xfUNX60cxHZUMVNucuUgwvSBuyvymnGrVdoMobZHhA6Ksr8yvG2rMR/rud8kk70m6SQGnCcUNNH0wXqqYUwZ1Cvs5Wzp6X/Z27k/LJkB2PsyJFUVYM2rfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MePD4sJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18353C4CEED;
	Wed, 13 Aug 2025 20:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755118548;
	bh=fnLVc97hLK6HSNu9HvM244ZanGfdhd7J4dAa2Ee9EMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MePD4sJ/ltB6zr5HAcyp7nSsWSfWV93YuaiCprYdHAc1AyNpsStmJQ1tRjp4ybifC
	 Bv2IlqM2RnktzPJWuvDXevAPnlQZLDEThmN/NhyBxMhKXAHoIOyQuBNVCQq7eOyQFg
	 V3It7Wvvjn7sD5ZeA9gahSRgUZHORBt7T2ARv0XhaBnVeuGJIM8kE7lhAoAUhMTrgj
	 r/tWM5MbLIIJq6LGyDR5yjolVUvrrJEIKC1Mgjyz0yzrWW1bNH7ttjPTNYvhXqgr/S
	 0I5s42o62a2JpaL7kNnZap34mo0+S1hHBNX9RowVFSkRQvV8G0zjLV5mBO07RgajPM
	 te3gQ1SnPVgCA==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH v3 07/12] bpf: Move the signature kfuncs to helpers.c
Date: Wed, 13 Aug 2025 22:55:21 +0200
Message-ID: <20250813205526.2992911-8-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813205526.2992911-1-kpsingh@kernel.org>
References: <20250813205526.2992911-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes, except for the addition of the headers for the
kfuncs so that they can be used for signature verification.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf.h      |  32 +++++++
 kernel/bpf/helpers.c     | 166 +++++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 183 ---------------------------------------
 3 files changed, 198 insertions(+), 183 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b12a0645c2a3..809a1c6882f1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3412,6 +3412,38 @@ static inline int bpf_fd_reuseport_array_update_elem(struct bpf_map *map,
 #endif /* CONFIG_BPF_SYSCALL */
 #endif /* defined(CONFIG_INET) && defined(CONFIG_BPF_SYSCALL) */
 
+#if defined(CONFIG_KEYS) && defined(CONFIG_BPF_SYSCALL)
+
+struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags);
+struct bpf_key *bpf_lookup_system_key(u64 id);
+void bpf_key_put(struct bpf_key *bkey);
+int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
+			       struct bpf_dynptr *sig_p,
+			       struct bpf_key *trusted_keyring);
+
+#else
+static inline struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
+{
+	return NULL;
+}
+
+static inline struct bpf_key *bpf_lookup_system_key(u64 id)
+{
+	return NULL;
+}
+
+static inline void bpf_key_put(struct bpf_key *bkey)
+{
+}
+
+static inline int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
+					     struct bpf_dynptr *sig_p,
+					     struct bpf_key *trusted_keyring)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* defined(CONFIG_KEYS) && defined(CONFIG_BPF_SYSCALL) */
+
 /* verifier prototypes for helper functions called from eBPF programs */
 extern const struct bpf_func_proto bpf_map_lookup_elem_proto;
 extern const struct bpf_func_proto bpf_map_update_elem_proto;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6b4877e85a68..a052bbbcbfc5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -25,6 +25,7 @@
 #include <linux/kasan.h>
 #include <linux/bpf_verifier.h>
 #include <linux/uaccess.h>
+#include <linux/verification.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -3702,6 +3703,163 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
 {
 	return bpf_strnstr(s1__ign, s2__ign, XATTR_SIZE_MAX);
 }
+#ifdef CONFIG_KEYS
+/**
+ * bpf_lookup_user_key - lookup a key by its serial
+ * @serial: key handle serial number
+ * @flags: lookup-specific flags
+ *
+ * Search a key with a given *serial* and the provided *flags*.
+ * If found, increment the reference count of the key by one, and
+ * return it in the bpf_key structure.
+ *
+ * The bpf_key structure must be passed to bpf_key_put() when done
+ * with it, so that the key reference count is decremented and the
+ * bpf_key structure is freed.
+ *
+ * Permission checks are deferred to the time the key is used by
+ * one of the available key-specific kfuncs.
+ *
+ * Set *flags* with KEY_LOOKUP_CREATE, to attempt creating a requested
+ * special keyring (e.g. session keyring), if it doesn't yet exist.
+ * Set *flags* with KEY_LOOKUP_PARTIAL, to lookup a key without waiting
+ * for the key construction, and to retrieve uninstantiated keys (keys
+ * without data attached to them).
+ *
+ * Return: a bpf_key pointer with a valid key pointer if the key is found, a
+ *         NULL pointer otherwise.
+ */
+__bpf_kfunc struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags)
+{
+	key_ref_t key_ref;
+	struct bpf_key *bkey;
+
+	if (flags & ~KEY_LOOKUP_ALL)
+		return NULL;
+
+	/*
+	 * Permission check is deferred until the key is used, as the
+	 * intent of the caller is unknown here.
+	 */
+	key_ref = lookup_user_key(serial, flags, KEY_DEFER_PERM_CHECK);
+	if (IS_ERR(key_ref))
+		return NULL;
+
+	bkey = kmalloc(sizeof(*bkey), GFP_KERNEL);
+	if (!bkey) {
+		key_put(key_ref_to_ptr(key_ref));
+		return NULL;
+	}
+
+	bkey->key = key_ref_to_ptr(key_ref);
+	bkey->has_ref = true;
+
+	return bkey;
+}
+
+/**
+ * bpf_lookup_system_key - lookup a key by a system-defined ID
+ * @id: key ID
+ *
+ * Obtain a bpf_key structure with a key pointer set to the passed key ID.
+ * The key pointer is marked as invalid, to prevent bpf_key_put() from
+ * attempting to decrement the key reference count on that pointer. The key
+ * pointer set in such way is currently understood only by
+ * verify_pkcs7_signature().
+ *
+ * Set *id* to one of the values defined in include/linux/verification.h:
+ * 0 for the primary keyring (immutable keyring of system keys);
+ * VERIFY_USE_SECONDARY_KEYRING for both the primary and secondary keyring
+ * (where keys can be added only if they are vouched for by existing keys
+ * in those keyrings); VERIFY_USE_PLATFORM_KEYRING for the platform
+ * keyring (primarily used by the integrity subsystem to verify a kexec'ed
+ * kerned image and, possibly, the initramfs signature).
+ *
+ * Return: a bpf_key pointer with an invalid key pointer set from the
+ *         pre-determined ID on success, a NULL pointer otherwise
+ */
+__bpf_kfunc struct bpf_key *bpf_lookup_system_key(u64 id)
+{
+	struct bpf_key *bkey;
+
+	if (system_keyring_id_check(id) < 0)
+		return NULL;
+
+	bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);
+	if (!bkey)
+		return NULL;
+
+	bkey->key = (struct key *)(unsigned long)id;
+	bkey->has_ref = false;
+
+	return bkey;
+}
+
+/**
+ * bpf_key_put - decrement key reference count if key is valid and free bpf_key
+ * @bkey: bpf_key structure
+ *
+ * Decrement the reference count of the key inside *bkey*, if the pointer
+ * is valid, and free *bkey*.
+ */
+__bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
+{
+	if (bkey->has_ref)
+		key_put(bkey->key);
+
+	kfree(bkey);
+}
+
+/**
+ * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
+ * @data_p: data to verify
+ * @sig_p: signature of the data
+ * @trusted_keyring: keyring with keys trusted for signature verification
+ *
+ * Verify the PKCS#7 signature *sig_ptr* against the supplied *data_ptr*
+ * with keys in a keyring referenced by *trusted_keyring*.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
+			       struct bpf_dynptr *sig_p,
+			       struct bpf_key *trusted_keyring)
+{
+#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
+	struct bpf_dynptr_kern *data_ptr = (struct bpf_dynptr_kern *)data_p;
+	struct bpf_dynptr_kern *sig_ptr = (struct bpf_dynptr_kern *)sig_p;
+	const void *data, *sig;
+	u32 data_len, sig_len;
+	int ret;
+
+	if (trusted_keyring->has_ref) {
+		/*
+		 * Do the permission check deferred in bpf_lookup_user_key().
+		 * See bpf_lookup_user_key() for more details.
+		 *
+		 * A call to key_task_permission() here would be redundant, as
+		 * it is already done by keyring_search() called by
+		 * find_asymmetric_key().
+		 */
+		ret = key_validate(trusted_keyring->key);
+		if (ret < 0)
+			return ret;
+	}
+
+	data_len = __bpf_dynptr_size(data_ptr);
+	data = __bpf_dynptr_data(data_ptr, data_len);
+	sig_len = __bpf_dynptr_size(sig_ptr);
+	sig = __bpf_dynptr_data(sig_ptr, sig_len);
+
+	return verify_pkcs7_signature(data, data_len, sig, sig_len,
+				      trusted_keyring->key,
+				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
+				      NULL);
+#else
+	return -EOPNOTSUPP;
+#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
+}
+#endif /* CONFIG_KEYS */
 
 __bpf_kfunc_end_defs();
 
@@ -3743,6 +3901,14 @@ BTF_ID_FLAGS(func, bpf_throw)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
 #endif
+#ifdef CONFIG_KEYS
+BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
+#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
+BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
+#endif
+#endif
 BTF_KFUNCS_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3ae52978cae6..02c3f610420d 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -22,7 +22,6 @@
 #include <linux/bsearch.h>
 #include <linux/sort.h>
 #include <linux/key.h>
-#include <linux/verification.h>
 #include <linux/namei.h>
 
 #include <net/bpf_sk_storage.h>
@@ -1241,188 +1240,6 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
-#ifdef CONFIG_KEYS
-__bpf_kfunc_start_defs();
-
-/**
- * bpf_lookup_user_key - lookup a key by its serial
- * @serial: key handle serial number
- * @flags: lookup-specific flags
- *
- * Search a key with a given *serial* and the provided *flags*.
- * If found, increment the reference count of the key by one, and
- * return it in the bpf_key structure.
- *
- * The bpf_key structure must be passed to bpf_key_put() when done
- * with it, so that the key reference count is decremented and the
- * bpf_key structure is freed.
- *
- * Permission checks are deferred to the time the key is used by
- * one of the available key-specific kfuncs.
- *
- * Set *flags* with KEY_LOOKUP_CREATE, to attempt creating a requested
- * special keyring (e.g. session keyring), if it doesn't yet exist.
- * Set *flags* with KEY_LOOKUP_PARTIAL, to lookup a key without waiting
- * for the key construction, and to retrieve uninstantiated keys (keys
- * without data attached to them).
- *
- * Return: a bpf_key pointer with a valid key pointer if the key is found, a
- *         NULL pointer otherwise.
- */
-__bpf_kfunc struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags)
-{
-	key_ref_t key_ref;
-	struct bpf_key *bkey;
-
-	if (flags & ~KEY_LOOKUP_ALL)
-		return NULL;
-
-	/*
-	 * Permission check is deferred until the key is used, as the
-	 * intent of the caller is unknown here.
-	 */
-	key_ref = lookup_user_key(serial, flags, KEY_DEFER_PERM_CHECK);
-	if (IS_ERR(key_ref))
-		return NULL;
-
-	bkey = kmalloc(sizeof(*bkey), GFP_KERNEL);
-	if (!bkey) {
-		key_put(key_ref_to_ptr(key_ref));
-		return NULL;
-	}
-
-	bkey->key = key_ref_to_ptr(key_ref);
-	bkey->has_ref = true;
-
-	return bkey;
-}
-
-/**
- * bpf_lookup_system_key - lookup a key by a system-defined ID
- * @id: key ID
- *
- * Obtain a bpf_key structure with a key pointer set to the passed key ID.
- * The key pointer is marked as invalid, to prevent bpf_key_put() from
- * attempting to decrement the key reference count on that pointer. The key
- * pointer set in such way is currently understood only by
- * verify_pkcs7_signature().
- *
- * Set *id* to one of the values defined in include/linux/verification.h:
- * 0 for the primary keyring (immutable keyring of system keys);
- * VERIFY_USE_SECONDARY_KEYRING for both the primary and secondary keyring
- * (where keys can be added only if they are vouched for by existing keys
- * in those keyrings); VERIFY_USE_PLATFORM_KEYRING for the platform
- * keyring (primarily used by the integrity subsystem to verify a kexec'ed
- * kerned image and, possibly, the initramfs signature).
- *
- * Return: a bpf_key pointer with an invalid key pointer set from the
- *         pre-determined ID on success, a NULL pointer otherwise
- */
-__bpf_kfunc struct bpf_key *bpf_lookup_system_key(u64 id)
-{
-	struct bpf_key *bkey;
-
-	if (system_keyring_id_check(id) < 0)
-		return NULL;
-
-	bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);
-	if (!bkey)
-		return NULL;
-
-	bkey->key = (struct key *)(unsigned long)id;
-	bkey->has_ref = false;
-
-	return bkey;
-}
-
-/**
- * bpf_key_put - decrement key reference count if key is valid and free bpf_key
- * @bkey: bpf_key structure
- *
- * Decrement the reference count of the key inside *bkey*, if the pointer
- * is valid, and free *bkey*.
- */
-__bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
-{
-	if (bkey->has_ref)
-		key_put(bkey->key);
-
-	kfree(bkey);
-}
-
-#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
-/**
- * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
- * @data_p: data to verify
- * @sig_p: signature of the data
- * @trusted_keyring: keyring with keys trusted for signature verification
- *
- * Verify the PKCS#7 signature *sig_ptr* against the supplied *data_ptr*
- * with keys in a keyring referenced by *trusted_keyring*.
- *
- * Return: 0 on success, a negative value on error.
- */
-__bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
-			       struct bpf_dynptr *sig_p,
-			       struct bpf_key *trusted_keyring)
-{
-	struct bpf_dynptr_kern *data_ptr = (struct bpf_dynptr_kern *)data_p;
-	struct bpf_dynptr_kern *sig_ptr = (struct bpf_dynptr_kern *)sig_p;
-	const void *data, *sig;
-	u32 data_len, sig_len;
-	int ret;
-
-	if (trusted_keyring->has_ref) {
-		/*
-		 * Do the permission check deferred in bpf_lookup_user_key().
-		 * See bpf_lookup_user_key() for more details.
-		 *
-		 * A call to key_task_permission() here would be redundant, as
-		 * it is already done by keyring_search() called by
-		 * find_asymmetric_key().
-		 */
-		ret = key_validate(trusted_keyring->key);
-		if (ret < 0)
-			return ret;
-	}
-
-	data_len = __bpf_dynptr_size(data_ptr);
-	data = __bpf_dynptr_data(data_ptr, data_len);
-	sig_len = __bpf_dynptr_size(sig_ptr);
-	sig = __bpf_dynptr_data(sig_ptr, sig_len);
-
-	return verify_pkcs7_signature(data, data_len, sig, sig_len,
-				      trusted_keyring->key,
-				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
-				      NULL);
-}
-#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
-
-__bpf_kfunc_end_defs();
-
-BTF_KFUNCS_START(key_sig_kfunc_set)
-BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
-#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
-BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
-#endif
-BTF_KFUNCS_END(key_sig_kfunc_set)
-
-static const struct btf_kfunc_id_set bpf_key_sig_kfunc_set = {
-	.owner = THIS_MODULE,
-	.set = &key_sig_kfunc_set,
-};
-
-static int __init bpf_key_sig_kfuncs_init(void)
-{
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
-					 &bpf_key_sig_kfunc_set);
-}
-
-late_initcall(bpf_key_sig_kfuncs_init);
-#endif /* CONFIG_KEYS */
-
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-- 
2.43.0


