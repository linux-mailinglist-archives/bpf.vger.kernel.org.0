Return-Path: <bpf+bounces-64277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C826B10DDA
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 16:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40761CE37DE
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA00F2E543E;
	Thu, 24 Jul 2025 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="N5ZNkqdf"
X-Original-To: bpf@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D502E2F15;
	Thu, 24 Jul 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368046; cv=none; b=WWMLnHD4o6WqH5F/GwSA/o20nfAUJsIkIhec77hTDmCGFoLUc+VUWGEa1LQIzy6f6C2TQnFNmbvIPWK0LoXISSLdCVx/btD+FR1t7iEW//z2PUIA09fCkCmvAbVH88Yyn8qFef0NtkIWLBWo862St90w1Nq1OqiIF3Av8jHZsaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368046; c=relaxed/simple;
	bh=oMNBG6IAuIWfV3TGb7z7bijgfhvYkpgvypaGPsdErDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiNG9tgZMeRUYINkgI9unMkDK+OUJqguD5EaWGFFocdJsSM44G9PR2WDy+f+5HX2DEJA4w6k0NNCzdBwaQSchcqMb3fIr8RumukynyUJqcRX71oSqxTISh/wT7IZQ+waCuHWrEOLCGzB25EZDHzSmWSW6vTN0o1XKhbo/3U7Hqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=N5ZNkqdf; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1753368043;
	bh=oMNBG6IAuIWfV3TGb7z7bijgfhvYkpgvypaGPsdErDw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:From;
	b=N5ZNkqdfbwwBsgZ1U2S4m8GtV0zSo5AP9ipNvTmn2Yb7voUH44uRoc6gXPqt0LgOS
	 MhTENwTs23foB/VSsVfjgO9pUss+DW9j3inPcO2a63a266n5LJsXguL0SEoY0YCHf7
	 3vl+y7wj52O54b71aml96kZXdNMjG96QG/ad7sgE=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id 49B8B1C003D;
	Thu, 24 Jul 2025 10:40:43 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 3/3] bpf: eliminate the allocation of an intermediate struct bpf_key
Date: Thu, 24 Jul 2025 10:34:28 -0400
Message-ID: <20250724143428.4416-4-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724143428.4416-1-James.Bottomley@HansenPartnership.com>
References: <20250724143428.4416-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that struct bpf_key is an opaque structure only containing a
pointer to the key, make it an alias for the key itself and thus
eliminate the need to allocate and free the container.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 kernel/trace/bpf_trace.c | 39 +++++++++------------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9575d018ed0f..287b69438fac 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1242,10 +1242,6 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 };
 
 #ifdef CONFIG_KEYS
-struct bpf_key {
-	struct key *key;
-};
-
 __bpf_kfunc_start_defs();
 
 /**
@@ -1276,7 +1272,6 @@ __bpf_kfunc_start_defs();
 __bpf_kfunc struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags)
 {
 	key_ref_t key_ref;
-	struct bpf_key *bkey;
 
 	if (flags & ~KEY_LOOKUP_ALL)
 		return NULL;
@@ -1289,15 +1284,7 @@ __bpf_kfunc struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags)
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
@@ -1323,18 +1310,10 @@ __bpf_kfunc struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags)
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
+	return (struct bpf_key *)(unsigned long)id;
 }
 
 /**
@@ -1346,10 +1325,10 @@ __bpf_kfunc struct bpf_key *bpf_lookup_system_key(u64 id)
  */
 __bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
 {
-	if (system_keyring_id_check((u64)bkey->key) < 0)
-		key_put(bkey->key);
+	struct key *key = (struct key *)bkey;
 
-	kfree(bkey);
+	if (system_keyring_id_check((u64)key) < 0)
+		key_put(key);
 }
 
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
@@ -1370,11 +1349,12 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
 {
 	struct bpf_dynptr_kern *data_ptr = (struct bpf_dynptr_kern *)data_p;
 	struct bpf_dynptr_kern *sig_ptr = (struct bpf_dynptr_kern *)sig_p;
+	struct key *key = (struct key *)trusted_keyring;
 	const void *data, *sig;
 	u32 data_len, sig_len;
 	int ret;
 
-	if (system_keyring_id_check((u64)trusted_keyring->key) < 0) {
+	if (system_keyring_id_check((u64)key) < 0) {
 		/*
 		 * Do the permission check deferred in bpf_lookup_user_key().
 		 * See bpf_lookup_user_key() for more details.
@@ -1383,7 +1363,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
 		 * it is already done by keyring_search() called by
 		 * find_asymmetric_key().
 		 */
-		ret = key_validate(trusted_keyring->key);
+		ret = key_validate(key);
 		if (ret < 0)
 			return ret;
 	}
@@ -1393,8 +1373,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
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


