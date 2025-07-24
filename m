Return-Path: <bpf+bounces-64276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622FEB10DD8
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 16:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED5D1782E7
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6CC2E88AB;
	Thu, 24 Jul 2025 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="bUPflxxl"
X-Original-To: bpf@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72712E543A;
	Thu, 24 Jul 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368006; cv=none; b=Ue++ICF0bMU0OOEcrwSIXk3cTBA/EdAhOc3QcLRpWZtaUZ+ei90LdwvfeQR8r5acmZV3AbFddbVxkKloB9IDQHWpeWAcR96ZuSexPj8YnJrjZEtmymo3l3T8ooanGgc9Hu8x8Y5ySdBRGtBmmSaDNSd4iqiJw8Xc4xSIVGZ4SMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368006; c=relaxed/simple;
	bh=+uorimRnfzLR0YeuLefqbxyZF5+wGDR8IDp2J0dTNQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejAC8RtSzo0F8Jo1Esa5MDlw0jcsuZpDIT3r2pm8kFTv00fbz7zhOj5vq2HjKzsb6BrWMPTlcbbsHEjTC+HpE9+qe9rtYjdJWn4R/Ce/47/qgpY5vhcEW740JGSrrnT/T7EKGjBp+7AkcOKZHgb9EHpci2sDbPn5V15Tunoz+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=bUPflxxl; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1753368003;
	bh=+uorimRnfzLR0YeuLefqbxyZF5+wGDR8IDp2J0dTNQA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:From;
	b=bUPflxxlPnCmRAVpQZfnYPn9wYigp7j4gnmj3Xk0KCSRLXOzaFVEiWRF00xTqmgpy
	 RR2lJhkuhRtGXtOXitTVhSvJF8xGq7BqhN/MKU2U38wY5GZiPb0j0ML2Fjrs8RVQdo
	 pj5jDeqaqaBYPH/fangtBR1hmnTASG9kALEE/B5g=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id 8EDA91C003D;
	Thu, 24 Jul 2025 10:40:03 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 2/3] bpf: remove bpf_key reference
Date: Thu, 24 Jul 2025 10:34:27 -0400
Message-ID: <20250724143428.4416-3-James.Bottomley@HansenPartnership.com>
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

bpf_key.has_ref is used to distinguish between real key pointers and
the fake key pointers that are used for system keyrings (to ensure the
actual pointers to system keyrings are never visible outside
certs/system_keyring.c).  The keyrings subsystem has an exported
function to do this, so use that in the bpf keyring code eliminating
the need to store has_ref.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 kernel/trace/bpf_trace.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e7bf00d1cd05..9575d018ed0f 100644
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
+	if (system_keyring_id_check((u64)bkey->key) < 0)
 		key_put(bkey->key);
 
 	kfree(bkey);
@@ -1377,7 +1374,7 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
 	u32 data_len, sig_len;
 	int ret;
 
-	if (trusted_keyring->has_ref) {
+	if (system_keyring_id_check((u64)trusted_keyring->key) < 0) {
 		/*
 		 * Do the permission check deferred in bpf_lookup_user_key().
 		 * See bpf_lookup_user_key() for more details.
-- 
2.43.0


