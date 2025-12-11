Return-Path: <bpf+bounces-76452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1876CB48AF
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 03:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E260F30633B4
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 02:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D742E175F;
	Thu, 11 Dec 2025 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DlNL54mJ"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8233F20A5C4;
	Thu, 11 Dec 2025 02:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765419201; cv=none; b=M/i+ZHEFJUPGyTBrDRyDkHwdF7Y0oR90/UTczTlSuomWsBhEtgtRDaOxVGNedIZDyw6iiUzbAw8WSqYgHEzlLZJSt7D6vnNJlTo8zE5l5V/cPAkw/v+FdPZQScqvGBFeBtXrHAtCRVKN9CW36fbP9mn04/we3R3HfVB/I9SRuJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765419201; c=relaxed/simple;
	bh=n5wJ2CXG+nzcMIT49abvHtPdpHcRMOCEe5Imn/9joc0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHB8NgKyuxlekCCM7ZLLvISeOw10whVc473/2jsgmD2OdgC8foC5qmoePyMI4CryEwnNy9X3NiMOmAvfRPtxKJ2NCLb2lmTM6NK10plgXI46J5laY6ZfMnNEk6CjXY1p5dE7+xkInlii2SMoaTQGsVNPS8GbE/4CHc/wSs61JL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DlNL54mJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 725E22116043;
	Wed, 10 Dec 2025 18:13:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 725E22116043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765419198;
	bh=xtXBZp01Gf8QxqlxSJyJMsLhZkeyPe2aXuwT3ptpSmQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DlNL54mJ5XJrKBGKOITEjuSJgEj+brxfKrtxQaDOm0Tby2HkFg4occlDpsAEw78+c
	 TsB1QjfOJJRIHBcdqxkAuOLOdg/GCaruWPyYqA6ERZFum8MiIaL+UHD72NXZzRr03g
	 xTfc1pcalKyXrmZd1YdkzfpWADowEc18rczYzcbA=
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
Subject: [RFC 06/11] crypto: pkcs7: add ability to extract signed attributes by OID
Date: Wed, 10 Dec 2025 18:12:01 -0800
Message-ID: <20251211021257.1208712-7-bboscaccy@linux.microsoft.com>
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

Signers may add any information they like in signed attributes and
sometimes this information turns out to be relevant to specific
signing cases, so add an api pkcs7_get_authattr() to extract the value
of an authenticated attribute by specific OID.  The current
implementation is designed for the single signer use case and simply
terminates the search when it finds the relevant OID.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 crypto/asymmetric_keys/Makefile       |  4 +-
 crypto/asymmetric_keys/pkcs7_aa.asn1  | 18 ++++++
 crypto/asymmetric_keys/pkcs7_parser.c | 87 +++++++++++++++++++++++++++
 include/crypto/pkcs7.h                |  4 ++
 4 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 crypto/asymmetric_keys/pkcs7_aa.asn1

diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index bc65d3b98dcbf..f99b7169ae7cd 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -53,12 +53,14 @@ clean-files	+= pkcs8.asn1.c pkcs8.asn1.h
 obj-$(CONFIG_PKCS7_MESSAGE_PARSER) += pkcs7_message.o
 pkcs7_message-y := \
 	pkcs7.asn1.o \
+	pkcs7_aa.asn1.o \
 	pkcs7_parser.o \
 	pkcs7_trust.o \
 	pkcs7_verify.o
 
-$(obj)/pkcs7_parser.o: $(obj)/pkcs7.asn1.h
+$(obj)/pkcs7_parser.o: $(obj)/pkcs7.asn1.h $(obj)/pkcs7_aa.asn1.h
 $(obj)/pkcs7.asn1.o: $(obj)/pkcs7.asn1.c $(obj)/pkcs7.asn1.h
+$(obj)/pkcs7_aa.asn1.o: $(obj)/pkcs7_aa.asn1.c $(obj)/pkcs7_aa.asn1.h
 
 #
 # PKCS#7 parser testing key
diff --git a/crypto/asymmetric_keys/pkcs7_aa.asn1 b/crypto/asymmetric_keys/pkcs7_aa.asn1
new file mode 100644
index 0000000000000..7a8857bdf56e1
--- /dev/null
+++ b/crypto/asymmetric_keys/pkcs7_aa.asn1
@@ -0,0 +1,18 @@
+-- SPDX-License-Identifier: BSD-3-Clause
+--
+-- Copyright (C) 2009 IETF Trust and the persons identified as authors
+-- of the code
+--
+-- https://www.rfc-editor.org/rfc/rfc5652#section-3
+
+AA ::= 	CHOICE {
+	aaSet		[0] IMPLICIT AASet,
+	aaSequence	[2] EXPLICIT SEQUENCE OF AuthenticatedAttribute
+}
+
+AASet ::= SET OF AuthenticatedAttribute
+
+AuthenticatedAttribute ::= SEQUENCE {
+	type	OBJECT IDENTIFIER ({ pkcs7_aa_note_OID }),
+	values	SET OF ANY ({ pkcs7_aa_note_attr })
+}
diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
index 423d13c475452..55bdcbad70952 100644
--- a/crypto/asymmetric_keys/pkcs7_parser.c
+++ b/crypto/asymmetric_keys/pkcs7_parser.c
@@ -15,6 +15,7 @@
 #include <crypto/public_key.h>
 #include "pkcs7_parser.h"
 #include "pkcs7.asn1.h"
+#include "pkcs7_aa.asn1.h"
 
 MODULE_DESCRIPTION("PKCS#7 parser");
 MODULE_AUTHOR("Red Hat, Inc.");
@@ -197,6 +198,92 @@ int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
 }
 EXPORT_SYMBOL_GPL(pkcs7_get_content_data);
 
+struct pkcs7_aa_context {
+	bool found;
+	enum OID oid_to_find;
+	const void *data;
+	size_t len;
+};
+
+int pkcs7_aa_note_OID(void *context, size_t hdrlen,
+		      unsigned char tag,
+		      const void *value, size_t vlen)
+{
+	struct pkcs7_aa_context *ctx = context;
+	enum OID oid = look_up_OID(value, vlen);
+
+	ctx->found = (oid == ctx->oid_to_find);
+
+	return 0;
+}
+
+int pkcs7_aa_note_attr(void *context, size_t hdrlen,
+		       unsigned char tag,
+		       const void *value, size_t vlen)
+{
+	struct pkcs7_aa_context *ctx = context;
+
+	if (ctx->found) {
+		ctx->data = value;
+		ctx->len = vlen;
+	}
+
+	return 0;
+}
+
+/**
+ * pkcs7_get_authattr - get authenticated attribute by OID
+ * @pkcs7: The preparsed PKCS#7 message
+ * @oid: the enum value of the OID to find
+ * @_data: Place to return a pointer to the attribute value
+ * @_len: length of the attribute value
+ *
+ * Searches the authenticated attributes until one is found with a
+ * matching OID.  Note that because the attributes are per signer
+ * there could be multiple signers with different values, but this
+ * routine will simply return the first one in parse order.
+ *
+ * Returns -ENODATA if the attribute can't be found
+ */
+int pkcs7_get_authattr(const struct pkcs7_message *pkcs7,
+		       enum OID oid,
+		       const void **_data, size_t *_len)
+{
+	struct pkcs7_signed_info *sinfo = pkcs7->signed_infos;
+	struct pkcs7_aa_context ctx;
+
+	ctx.data = NULL;
+	ctx.oid_to_find = oid;
+
+	for (; sinfo; sinfo = sinfo->next) {
+		int ret;
+
+		/* only extract OIDs from validated signers */
+		if (!sinfo->verified)
+			continue;
+
+		/*
+		 * Note: authattrs is missing the initial tag for
+		 * digesting reasons.  Step one back in the stream to
+		 * point to the initial tag for fully formed ASN.1
+		 */
+		ret = asn1_ber_decoder(&pkcs7_aa_decoder, &ctx,
+				       sinfo->authattrs - 1,
+				       sinfo->authattrs_len + 1);
+		if (ret < 0 || ctx.data != NULL)
+			break;
+	}
+
+	if (!ctx.data)
+		return -ENODATA;
+
+	*_data = ctx.data;
+	*_len = ctx.len;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pkcs7_get_authattr);
+
 /*
  * Note an OID when we find one for later processing when we know how
  * to interpret it.
diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
index 38ec7f5f90411..bd83202cd805c 100644
--- a/include/crypto/pkcs7.h
+++ b/include/crypto/pkcs7.h
@@ -25,6 +25,10 @@ extern void pkcs7_free_message(struct pkcs7_message *pkcs7);
 extern int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
 				  const void **_data, size_t *_datalen,
 				  size_t *_headerlen);
+extern int pkcs7_get_authattr(const struct pkcs7_message *pkcs7,
+			      enum OID oid,
+			      const void **_data, size_t *_len);
+
 
 /*
  * pkcs7_trust.c
-- 
2.52.0


