Return-Path: <bpf+bounces-64735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5333B16582
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 19:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA701AA4651
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 17:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1261A2E03FF;
	Wed, 30 Jul 2025 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="O1vR+GXe"
X-Original-To: bpf@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2442DEA7D;
	Wed, 30 Jul 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896543; cv=none; b=Ohc3aCetAPThUtGic/FH0d6CXNcwOfullTiQT0rHCChJVNE8hCydtHjPbktsIOT9PW58M3AfTp1OBr9y0Z2QY79JcuMM5n7ja7XriPWJOSgiWwLZHH0z+rJzwyCyUieCRpwWVEQE86IX7RqelFaHLSydqux6cyuuXXVvFKVpnfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896543; c=relaxed/simple;
	bh=jtW2WPDHo1i0GZINGZRpFxtSaFbg9MxRVhF1WqPSDD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtvrHYyOA14ZM9UksmbK6JS94p03a6XI7IyMGk3/vf2l9M/5M257iHKoC0kfmZe966NOWzbOJ1z66ON6QUXKnesCsd7k3zVrMmAoak6q+s3D18gQf0M6cb9ltikwH3jDrx/2wxuKVtuShJwtHVwQj3mQwpbWcDDjNaca3uGYMYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=O1vR+GXe; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1753896541;
	bh=jtW2WPDHo1i0GZINGZRpFxtSaFbg9MxRVhF1WqPSDD8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:From;
	b=O1vR+GXe4IU2DFmp7QTm9Sp/llTcM+crsI+C7SaBVIVA7ZsvNZqfWMVEgec45op6Y
	 Jh7RpR8ZZ3Ncz3UvWQ42P4O88aIuSOfOKa16FkFJuemkCv/I0bjmb8Tp/O0vVJgR32
	 qNsDMxxnhX7pFZR4XhISZGxT5PsqC3BiOgD3F7i4=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id 1480C1C0251;
	Wed, 30 Jul 2025 13:29:01 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 3/3] bpf: eliminate the allocation of an intermediate struct bpf_key
Date: Wed, 30 Jul 2025 13:27:45 -0400
Message-ID: <20250730172745.8480-4-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730172745.8480-1-James.Bottomley@HansenPartnership.com>
References: <20250730172745.8480-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that struct bpf_key is an opaque structure only containing a
pointer to the key, make it an alias for the key itself and thus
eliminate the need to allocate and free the container.  Because the
return value of bpf_lookup_system_key() is now overloaded with 0 being
a legitimate built in key identifier being the same value as NULL
indicating failure, key id 0 is swizzled to -1 to distinguish it again
and swizzled back in bpf_key_put() and bpf_verify_pkcs7_signature() to
ensure correctness.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---
v2: keep empty struct bpf_key to avoid BTF problems and swizzle 0 key id.
---
 kernel/trace/bpf_trace.c | 43 +++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c0ccd55a4d91..7242167fd4b6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1242,9 +1242,11 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 };
 
 #ifdef CONFIG_KEYS
+/* BTF requires this even if it serves no purpose */
 struct bpf_key {
-	struct key *key;
 };
+/* conventional value to replace zero return which would become NULL */
+const u64 BUILTIN_KEY = -1LL;
 
 __bpf_kfunc_start_defs();
 
@@ -1276,7 +1278,6 @@ __bpf_kfunc_start_defs();
 __bpf_kfunc struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags)
 {
 	key_ref_t key_ref;
-	struct bpf_key *bkey;
 
 	if (flags & ~KEY_LOOKUP_ALL)
 		return NULL;
@@ -1289,15 +1290,7 @@ __bpf_kfunc struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags)
 	if (IS_ERR(key_ref))
 		return NULL;
 
-	bkey = kmalloc(sizeof(*bkey), GFP_KERNEL);
-	if (!bkey) {
-		key_put(key_ref_to_ptr(key_ref));
-		return NULL;
-	}
-
-	bkey->key = key_ref_to_ptr(key_ref);
-
-	return bkey;
+	return (struct bpf_key *)key_ref_to_ptr(key_ref);
 }
 
 /**
@@ -1323,18 +1316,10 @@ __bpf_kfunc struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags)
  */
 __bpf_kfunc struct bpf_key *bpf_lookup_system_key(u64 id)
 {
-	struct bpf_key *bkey;
-
 	if (system_keyring_id_check(id) < 0)
 		return NULL;
 
-	bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);
-	if (!bkey)
-		return NULL;
-
-	bkey->key = (struct key *)(unsigned long)id;
-
-	return bkey;
+	return (struct bpf_key *)(unsigned long)(id ? id : BUILTIN_KEY);
 }
 
 /**
@@ -1346,10 +1331,11 @@ __bpf_kfunc struct bpf_key *bpf_lookup_system_key(u64 id)
  */
 __bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
 {
-	if (system_keyring_id_check((unsigned long)bkey->key) < 0)
-		key_put(bkey->key);
+	struct key *key = (struct key *)bkey;
 
-	kfree(bkey);
+	if (system_keyring_id_check((unsigned long)key) < 0 &&
+	    (unsigned long)key != BUILTIN_KEY)
+		key_put(key);
 }
 
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
@@ -1370,11 +1356,15 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
 {
 	struct bpf_dynptr_kern *data_ptr = (struct bpf_dynptr_kern *)data_p;
 	struct bpf_dynptr_kern *sig_ptr = (struct bpf_dynptr_kern *)sig_p;
+	struct key *key = (struct key *)trusted_keyring;
 	const void *data, *sig;
 	u32 data_len, sig_len;
 	int ret;
 
-	if (system_keyring_id_check((unsigned long)trusted_keyring->key) < 0) {
+	if ((unsigned long)key == BUILTIN_KEY)
+		key = NULL;
+
+	if (system_keyring_id_check((unsigned long)key) < 0) {
 		/*
 		 * Do the permission check deferred in bpf_lookup_user_key().
 		 * See bpf_lookup_user_key() for more details.
@@ -1383,7 +1373,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
 		 * it is already done by keyring_search() called by
 		 * find_asymmetric_key().
 		 */
-		ret = key_validate(trusted_keyring->key);
+		ret = key_validate(key);
 		if (ret < 0)
 			return ret;
 	}
@@ -1393,8 +1383,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
 	sig_len = __bpf_dynptr_size(sig_ptr);
 	sig = __bpf_dynptr_data(sig_ptr, sig_len);
 
-	return verify_pkcs7_signature(data, data_len, sig, sig_len,
-				      trusted_keyring->key,
+	return verify_pkcs7_signature(data, data_len, sig, sig_len, key,
 				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
 				      NULL);
 }
-- 
2.43.0


