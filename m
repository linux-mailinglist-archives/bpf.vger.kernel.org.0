Return-Path: <bpf+bounces-76451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F3ECB48A8
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 03:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDB8B3059595
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 02:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C316F2DF12C;
	Thu, 11 Dec 2025 02:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WdM0Sw7Q"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFC12BEFEB;
	Thu, 11 Dec 2025 02:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765419199; cv=none; b=SMlJk/o/7U9HI/7LnAyglomxshoxUhzF/WR2ehNcKdM6umHI18G36TEBLabL650ZTjOE74NPDd29Whql7e5v9noN9EpOXBQHKzRmE4j4kAql6Hcapd6s65yfbNr4EXcDLrhBdhFQmVO8VcMwiW7Ie+pZWi4JWQcEdD+idG66T4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765419199; c=relaxed/simple;
	bh=DKeu+qTEIr2iRtbwN3hwjCcXwv2PM3N3C/GTGIjIVlQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEbVr2bAHkjhsphBJkQ0LRHCMCNtZEUBPiNtTbLPdTdMgkSzIedt8v1cMgU65AgqOM5QAGnuQQaUxe3HEWzOtyd1Qxcy8KRsmu/O/snl5b1Qe3l7X7g2hEY51k4KLoParfShTOlWAQWP0KWL2FtYlGNtmJRRkNIwiy0YCNDuxW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WdM0Sw7Q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id A68B02116046;
	Wed, 10 Dec 2025 18:13:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A68B02116046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765419196;
	bh=4ifvqlY9jJPeiFBANJpL6uEefFDnll7LXYcCLrNqepU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WdM0Sw7Qtg6sVKXeOC5de4kfwuHDuu7EIBUHc09vKwL9Qtr+h18vfunrqICjs8zYr
	 f2pyGlhQHZmAZ+Zdtxvp2jvmH1cJne4k0ff90VgQ4n1TjUtt00+JwKuuGfnmwqq/LA
	 4mhORMX3fQMW5/DPyQn8vhN4SbPSVmU7ImacRsQA=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC 05/11] crypto: pkcs7: allow pkcs7_digest() to be called from pkcs7_trust
Date: Wed, 10 Dec 2025 18:12:00 -0800
Message-ID: <20251211021257.1208712-6-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
References: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Bottomley <James.Bottomley@HansenPartnership.com>

Trying to run pkcs7_validate_trust() on something that parsed
correctly but is not verified doesn't work because the signature
digest hasn't been calculated.  Fix this by adding a digest calclation
in to pkcs7_validate_one().  This is almost a nop if the digest exists.

Additionally, the trust validation doesn't know the data payload, so
adjust the digest calculator to skip checking the data digest if
pkcs7->data is NULL.  A check is added in pkcs7_verify() for
pkcs7->data being null (returning -EBADMSG) to guard against someone
forgetting to supply data and getting an invalid success return.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 crypto/asymmetric_keys/pkcs7_parser.h |  3 +++
 crypto/asymmetric_keys/pkcs7_trust.c  |  8 ++++++++
 crypto/asymmetric_keys/pkcs7_verify.c | 13 +++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_parser.h b/crypto/asymmetric_keys/pkcs7_parser.h
index 344340cfa6c13..179cd1cdbe22d 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.h
+++ b/crypto/asymmetric_keys/pkcs7_parser.h
@@ -63,3 +63,6 @@ struct pkcs7_message {
 	size_t		data_hdrlen;	/* Length of Data ASN.1 header */
 	const void	*data;		/* Content Data (or 0) */
 };
+
+int pkcs7_digest(struct pkcs7_message *pkcs7,
+		 struct pkcs7_signed_info *sinfo);
diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
index 78ebfb6373b61..7cb0a6bc7b32e 100644
--- a/crypto/asymmetric_keys/pkcs7_trust.c
+++ b/crypto/asymmetric_keys/pkcs7_trust.c
@@ -30,6 +30,14 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
 
 	kenter(",%u,", sinfo->index);
 
+	/*
+	 * if we're being called immediately after parse, the
+	 * signature won't have a calculated digest yet, so calculate
+	 * one.  This function returns immediately if a digest has
+	 * already been calculated
+	 */
+	pkcs7_digest(pkcs7, sinfo);
+
 	if (sinfo->unsupported_crypto) {
 		kleave(" = -ENOPKG [cached]");
 		return -ENOPKG;
diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 6d6475e3a9bf2..19b3999381e6f 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -19,8 +19,8 @@
 /*
  * Digest the relevant parts of the PKCS#7 data
  */
-static int pkcs7_digest(struct pkcs7_message *pkcs7,
-			struct pkcs7_signed_info *sinfo)
+int pkcs7_digest(struct pkcs7_message *pkcs7,
+		 struct pkcs7_signed_info *sinfo)
 {
 	struct public_key_signature *sig = sinfo->sig;
 	struct crypto_shash *tfm;
@@ -85,8 +85,8 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
 			goto error;
 		}
 
-		if (memcmp(sig->digest, sinfo->msgdigest,
-			   sinfo->msgdigest_len) != 0) {
+		if (pkcs7->data && memcmp(sig->digest, sinfo->msgdigest,
+					  sinfo->msgdigest_len) != 0) {
 			pr_warn("Sig %u: Message digest doesn't match\n",
 				sinfo->index);
 			ret = -EKEYREJECTED;
@@ -439,6 +439,11 @@ int pkcs7_verify(struct pkcs7_message *pkcs7,
 		return -EINVAL;
 	}
 
+	if (!pkcs7->data) {
+		pr_warn("Data not supplied to verify operation\n");
+		return -EBADMSG;
+	}
+
 	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
 		ret = pkcs7_verify_one(pkcs7, sinfo);
 		if (sinfo->blacklisted) {
-- 
2.52.0


