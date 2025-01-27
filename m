Return-Path: <bpf+bounces-49904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475FBA201C9
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291F01662A3
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B2A1DDC37;
	Mon, 27 Jan 2025 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gGDJegYY"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8D1DC9BE
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021209; cv=none; b=k3yKBGXGqQkUlebasyJOL7y0M3muIBFIbOef+WhF/OMzXM1fHTyS7WX6iCUydV8ABQrVG31poVgIMBFHMAmOajLpPonNd5DzFfibEEhF7kQV2MLJkvlq5FpYmgbr8lZCGsxO1WPKRNHYjk6SzVPzxUuukc7RcI/VtdjDDYzH/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021209; c=relaxed/simple;
	bh=x62fGO/+S/hBgRU/Tw6RYQqFftSfHissCZjzh364n/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUTkdjrq5r+8F7B2m9YTbvAmlifa3d+xRGQD9mEaECDrY693b63PPD9KfGf2pc2ambVyRZxoDfLMsgjGbt07lwY0fQh0W+eNmRLRyH7sPP8mEaIuqHciJzjVKNgBq21mMwEKzsxhENqImNgJhv6oPC+khY5JrRvXCBMEJAFmmPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gGDJegYY; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738021205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39ai8KCTykcHjuN/hfG+Uz32i7d9BqLJ5GoGtjef1v0=;
	b=gGDJegYYDMC4213y1JQ2+Vtwy5aZCyOFLMskghLl7YRFOrmCJim0RrYMWoWyAFm8I4s1nI
	yLTd27zemuFg/UD1HtvnTQ9qBF7oX0g6+8dsXeiMfqasm1ptWVudtN1ZCqBGJv5IcLzJi1
	KgzXU2R8YWwzDmHpJepYhQrUYVei1Gg=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	jose.marchesi@oracle.com
Subject: [PATCH bpf-next v2 2/6] docs/bpf: document the semantics of BTF tags with kind_flag
Date: Mon, 27 Jan 2025 15:39:51 -0800
Message-ID: <20250127233955.2275804-3-ihor.solodrai@linux.dev>
In-Reply-To: <20250127233955.2275804-1-ihor.solodrai@linux.dev>
References: <20250127233955.2275804-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Explain the meaning of kind_flag in BTF type_tags and decl_tags.
Update uapi btf.h kind_flag comment to reflect the changes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/bpf/btf.rst      | 25 +++++++++++++++++++++----
 include/uapi/linux/btf.h       |  3 ++-
 tools/include/uapi/linux/btf.h |  3 ++-
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 2478cef758f8..48d9b33d59db 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -102,7 +102,8 @@ Each type contains the following common data::
          * bits 24-28: kind (e.g. int, ptr, array...etc)
          * bits 29-30: unused
          * bit     31: kind_flag, currently used by
-         *             struct, union, fwd, enum and enum64.
+	 *             struct, union, enum, fwd, enum64,
+	 *             decl_tag and type_tag
          */
         __u32 info;
         /* "size" is used by INT, ENUM, STRUCT, UNION and ENUM64.
@@ -478,7 +479,7 @@ No additional type data follow ``btf_type``.
 
 ``struct btf_type`` encoding requirement:
  * ``name_off``: offset to a non-empty string
- * ``info.kind_flag``: 0
+ * ``info.kind_flag``: 0 or 1
  * ``info.kind``: BTF_KIND_DECL_TAG
  * ``info.vlen``: 0
  * ``type``: ``struct``, ``union``, ``func``, ``var`` or ``typedef``
@@ -489,7 +490,6 @@ No additional type data follow ``btf_type``.
         __u32   component_idx;
     };
 
-The ``name_off`` encodes btf_decl_tag attribute string.
 The ``type`` should be ``struct``, ``union``, ``func``, ``var`` or ``typedef``.
 For ``var`` or ``typedef`` type, ``btf_decl_tag.component_idx`` must be ``-1``.
 For the other three types, if the btf_decl_tag attribute is
@@ -499,12 +499,21 @@ the attribute is applied to a ``struct``/``union`` member or
 a ``func`` argument, and ``btf_decl_tag.component_idx`` should be a
 valid index (starting from 0) pointing to a member or an argument.
 
+If ``info.kind_flag`` is 0, then this is a normal decl tag, and the
+``name_off`` encodes btf_decl_tag attribute string.
+
+If ``info.kind_flag`` is 1, then the decl tag represents an arbitrary
+__attribute__. In this case, ``name_off`` encodes a string
+representing the attribute-list of the attribute specifier. For
+example, for an ``__attribute__((aligned(4)))`` the string's contents
+is ``aligned(4)``.
+
 2.2.18 BTF_KIND_TYPE_TAG
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 ``struct btf_type`` encoding requirement:
  * ``name_off``: offset to a non-empty string
- * ``info.kind_flag``: 0
+ * ``info.kind_flag``: 0 or 1
  * ``info.kind``: BTF_KIND_TYPE_TAG
  * ``info.vlen``: 0
  * ``type``: the type with ``btf_type_tag`` attribute
@@ -522,6 +531,14 @@ type_tag, then zero or more const/volatile/restrict/typedef
 and finally the base type. The base type is one of
 int, ptr, array, struct, union, enum, func_proto and float types.
 
+Similarly to decl tags, if the ``info.kind_flag`` is 0, then this is a
+normal type tag, and the ``name_off`` encodes btf_type_tag attribute
+string.
+
+If ``info.kind_flag`` is 1, then the type tag represents an arbitrary
+__attribute__, and the ``name_off`` encodes a string representing the
+attribute-list of the attribute specifier.
+
 2.2.19 BTF_KIND_ENUM64
 ~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
index ec1798b6d3ff..266d4ffa6c07 100644
--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -36,7 +36,8 @@ struct btf_type {
 	 * bits 24-28: kind (e.g. int, ptr, array...etc)
 	 * bits 29-30: unused
 	 * bit     31: kind_flag, currently used by
-	 *             struct, union, enum, fwd and enum64
+	 *             struct, union, enum, fwd, enum64,
+	 *             decl_tag and type_tag
 	 */
 	__u32 info;
 	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64.
diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
index ec1798b6d3ff..266d4ffa6c07 100644
--- a/tools/include/uapi/linux/btf.h
+++ b/tools/include/uapi/linux/btf.h
@@ -36,7 +36,8 @@ struct btf_type {
 	 * bits 24-28: kind (e.g. int, ptr, array...etc)
 	 * bits 29-30: unused
 	 * bit     31: kind_flag, currently used by
-	 *             struct, union, enum, fwd and enum64
+	 *             struct, union, enum, fwd, enum64,
+	 *             decl_tag and type_tag
 	 */
 	__u32 info;
 	/* "size" is used by INT, ENUM, STRUCT, UNION, DATASEC and ENUM64.
-- 
2.48.1


