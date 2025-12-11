Return-Path: <bpf+bounces-76449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F486CB4851
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 03:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6C72301F014
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 02:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067982BE625;
	Thu, 11 Dec 2025 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lInPFTOn"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35D62D8364;
	Thu, 11 Dec 2025 02:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765419194; cv=none; b=qXXVqKjmMo9QDkcxQErCpQOPs9+HJkMsEgnDl4MKQyzkBi9DPY/klrNoQKQwqt6I64kVUbVsoZF2OddzAs6hD7c8CaHc0Jc+Vuhc3FGTFUYOSFSR4Y3DTxHcoDpaBIsO9szNr1V6/7QQzgOWo4nKTOdAkjntgBx/Avm/2sDoTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765419194; c=relaxed/simple;
	bh=JdRHlwoj2ekW+YizjrNg1K6XKl5v6vm6K00XxhLHug0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDGVnzucxBJbttCdf9AyRM41Df+O3xjQqptlTJoa5ATz2DU3ZzUjohOhIvXjWxzE+9Er84t75ubQ+ly4YpYi7TIb9t0FFY0NRm/yYfGJR0O8/q5+VOwIqdhFsrT6mzCYMTm4GmLUrRn5XrUxlP0lEa8m4jtuH4Fg0X74AHuLlYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lInPFTOn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7E9742116043;
	Wed, 10 Dec 2025 18:13:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E9742116043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765419191;
	bh=+cUv2YDEFdHJCABGsGpyw43sJvYTINrg6wV3aMZO9tA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lInPFTOn4wx3xXJvPmVHSA+UW+dfQ8jMkTogn8fpkrSKOKbgyaEiWFeYjLofv1lIW
	 uoR1wD28HDfE90fhOQSVcOmDkj8o55b37kTLPoaJwjy65DwQ5aBLtfdtZGCkGpRs1k
	 61IajokQEKz1bL9VS82K3CJrOWKzIXzd87QtY+y8=
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
Subject: [RFC 03/11] certs: break out pkcs7 check into its own function
Date: Wed, 10 Dec 2025 18:11:58 -0800
Message-ID: <20251211021257.1208712-4-bboscaccy@linux.microsoft.com>
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

Add new validate_pkcs7_trust() function which can operate on the
system keyrings and is simply some of the innards of
verify_pkcs7_message_sig().

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 certs/system_keyring.c       | 76 +++++++++++++++++++++---------------
 include/linux/verification.h |  2 +
 2 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 9de610bf1f4b2..807ab4a6fc7ea 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -298,42 +298,19 @@ late_initcall(load_system_certificate_list);
 #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
 
 /**
- * verify_pkcs7_message_sig - Verify a PKCS#7-based signature on system data.
- * @data: The data to be verified (NULL if expecting internal data).
- * @len: Size of @data.
+ * validate_pkcs7_trust - add trust markers based on keyring
  * @pkcs7: The PKCS#7 message that is the signature.
  * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
  *					(void *)1UL for all trusted keys).
- * @usage: The use to which the key is being put.
- * @view_content: Callback to gain access to content.
- * @ctx: Context for callback.
  */
-int verify_pkcs7_message_sig(const void *data, size_t len,
-			     struct pkcs7_message *pkcs7,
-			     struct key *trusted_keys,
-			     enum key_being_used_for usage,
-			     int (*view_content)(void *ctx,
-						 const void *data, size_t len,
-						 size_t asn1hdrlen),
-			     void *ctx)
+int validate_pkcs7_trust(struct pkcs7_message *pkcs7, struct key *trusted_keys)
 {
 	int ret;
 
-	/* The data should be detached - so we need to supply it. */
-	if (data && pkcs7_supply_detached_data(pkcs7, data, len) < 0) {
-		pr_err("PKCS#7 signature with non-detached data\n");
-		ret = -EBADMSG;
-		goto error;
-	}
-
-	ret = pkcs7_verify(pkcs7, usage);
-	if (ret < 0)
-		goto error;
-
 	ret = is_key_on_revocation_list(pkcs7);
 	if (ret != -ENOKEY) {
 		pr_devel("PKCS#7 key is on revocation list\n");
-		goto error;
+		return ret;
 	}
 
 	if (!trusted_keys) {
@@ -351,18 +328,55 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
 		trusted_keys = NULL;
 #endif
 		if (!trusted_keys) {
-			ret = -ENOKEY;
 			pr_devel("PKCS#7 platform keyring is not available\n");
-			goto error;
+			return -ENOKEY;
 		}
 	}
 	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
-	if (ret < 0) {
-		if (ret == -ENOKEY)
-			pr_devel("PKCS#7 signature not signed with a trusted key\n");
+	if (ret == -ENOKEY)
+		pr_devel("PKCS#7 signature not signed with a trusted key\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(validate_pkcs7_trust);
+
+/**
+ * verify_pkcs7_message_sig - Verify a PKCS#7-based signature on system data.
+ * @data: The data to be verified (NULL if expecting internal data).
+ * @len: Size of @data.
+ * @pkcs7: The PKCS#7 message that is the signature.
+ * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
+ *					(void *)1UL for all trusted keys).
+ * @usage: The use to which the key is being put.
+ * @view_content: Callback to gain access to content.
+ * @ctx: Context for callback.
+ */
+int verify_pkcs7_message_sig(const void *data, size_t len,
+			     struct pkcs7_message *pkcs7,
+			     struct key *trusted_keys,
+			     enum key_being_used_for usage,
+			     int (*view_content)(void *ctx,
+						 const void *data, size_t len,
+						 size_t asn1hdrlen),
+			     void *ctx)
+{
+	int ret;
+
+	/* The data should be detached - so we need to supply it. */
+	if (data && pkcs7_supply_detached_data(pkcs7, data, len) < 0) {
+		pr_err("PKCS#7 signature with non-detached data\n");
+		ret = -EBADMSG;
 		goto error;
 	}
 
+	ret = pkcs7_verify(pkcs7, usage);
+	if (ret < 0)
+		goto error;
+
+	ret = validate_pkcs7_trust(pkcs7, trusted_keys);
+	if (ret < 0)
+		goto error;
+
 	if (view_content) {
 		size_t asn1hdrlen;
 
diff --git a/include/linux/verification.h b/include/linux/verification.h
index dec7f2beabfd4..57f1460d36f13 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -44,6 +44,8 @@ enum key_being_used_for {
 struct key;
 struct pkcs7_message;
 
+extern int validate_pkcs7_trust(struct pkcs7_message *pkcs7,
+				struct key *trusted_keys);
 extern int verify_pkcs7_signature(const void *data, size_t len,
 				  const void *raw_pkcs7, size_t pkcs7_len,
 				  struct key *trusted_keys,
-- 
2.52.0


