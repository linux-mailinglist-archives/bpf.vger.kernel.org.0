Return-Path: <bpf+bounces-64734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6AEB16581
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 19:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA213AABE3
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E222E03E4;
	Wed, 30 Jul 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="RwkN66Nt"
X-Original-To: bpf@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2F3173;
	Wed, 30 Jul 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896526; cv=none; b=Swg1PTFIkuZ8ER4Z2TLUZl0IGTI+qeQ9b/YM3WNkQfG4Hf2tgLowNOghwyOPKAfUbVx8XMRj9vKI5g9oL5ux+f/btPp9EPrEzpb1jkQdH1wC24mfG7CkuDSBwLX+uDXN6jSN/S0FsZeS1rUce/Dba957FdumBtlrbGdFDfQtw3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896526; c=relaxed/simple;
	bh=KBaGtJwAGgTVRJtEYVtmYK4bGjPGtS0WUEINVUx434s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+PskIO1QdtdXpb3D7x8b0k2ZwnPmZ9GP5Fs6n4x8NOUCoaZf4KJ5ooCnxOt1m0CJm7mZfNGFyvctHqggcMHkO49OSqLVf7/vU+rZzuFo/x9pZtxC7aYagjlnWuEczpY5q3152EE4gbG8TmR/SIPnOfEBtNJI/FzHb5YMY7wdkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=RwkN66Nt; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1753896522;
	bh=KBaGtJwAGgTVRJtEYVtmYK4bGjPGtS0WUEINVUx434s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:From;
	b=RwkN66Ntc8SMjYbWng+iLvgu9IPZGCie0y0bNqGudFUYc12Z3/hsS2QvlgOSHszl9
	 P9/6d1By2I+cKOMMy5OE/2oWYRFUA+11L7hVLzvk4V1J47wSqbCgmAAZub4gLLdDVu
	 IIo8gamRlofHjcg8kcTqocXPLUI8esgDatDU3v94=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id CB2E81C0251;
	Wed, 30 Jul 2025 13:28:42 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 2/3] bpf: remove bpf_key reference
Date: Wed, 30 Jul 2025 13:27:44 -0400
Message-ID: <20250730172745.8480-3-James.Bottomley@HansenPartnership.com>
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

bpf_key.has_ref is used to distinguish between real key pointers and
the fake key pointers that are used for system keyrings (to ensure the
actual pointers to system keyrings are never visible outside
certs/system_keyring.c).  The keyrings subsystem has an exported
function to do this, so use that in the bpf keyring code eliminating
the need to store has_ref.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---
v2: use unsigned long for pointer to int conversion
---
 kernel/trace/bpf_trace.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e7bf00d1cd05..c0ccd55a4d91 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1244,7 +1244,6 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 #ifdef CONFIG_KEYS
 struct bpf_key {
 	struct key *key;
-	bool has_ref;
 };
 
 __bpf_kfunc_start_defs();
@@ -1297,7 +1296,6 @@ __bpf_kfunc struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags)
 	}
 
 	bkey->key = key_ref_to_ptr(key_ref);
-	bkey->has_ref = true;
 
 	return bkey;
 }
@@ -1335,7 +1333,6 @@ __bpf_kfunc struct bpf_key *bpf_lookup_system_key(u64 id)
 		return NULL;
 
 	bkey->key = (struct key *)(unsigned long)id;
-	bkey->has_ref = false;
 
 	return bkey;
 }
@@ -1349,7 +1346,7 @@ __bpf_kfunc struct bpf_key *bpf_lookup_system_key(u64 id)
  */
 __bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
 {
-	if (bkey->has_ref)
+	if (system_keyring_id_check((unsigned long)bkey->key) < 0)
 		key_put(bkey->key);
 
 	kfree(bkey);
@@ -1377,7 +1374,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
 	u32 data_len, sig_len;
 	int ret;
 
-	if (trusted_keyring->has_ref) {
+	if (system_keyring_id_check((unsigned long)trusted_keyring->key) < 0) {
 		/*
 		 * Do the permission check deferred in bpf_lookup_user_key().
 		 * See bpf_lookup_user_key() for more details.
-- 
2.43.0


