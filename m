Return-Path: <bpf+bounces-50159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB10A234EB
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 21:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1E17A3307
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DAA1F12F3;
	Thu, 30 Jan 2025 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uf3R1F9H"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE181F0E52
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738267970; cv=none; b=KnCrqg3poOh1Q0yUpr9CDv1CmEW5dmctnboQ6zqKBYPBs463j2PUe/+M8nrHaxzEE/iLokl15E4f47/nWD9rY9EKzyKPaPTl0ekk8gQaFlCBYKpzhsOoSqw+I5FsOANiiUzxJCH02g7Tk85ZCQPiuBWDGJpTWhIRMqiKHe/b83A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738267970; c=relaxed/simple;
	bh=G1YkVlJNRbghrecK6Iwtwr8+SvzhXz18JEBADdV0vD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Icx/8gJsJzqa8VkyJKP9Nyvb7G0LKntvKDobnZYGfPFrVn2dwW2/ZjkCdrBqbPa+3FQi7yRz96oevsEvqDLHmD9D2G0x835U5UElhWjLSMnJNzSthskkH5+l+dXgnNpQ7GA5ZT9Qj/TIi3A0TqRPqKHVrDDTcPPTmXFge+tnYyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uf3R1F9H; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738267966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dUnRjR+ZXiJ+b+lmv+ariFavm4upcCNCp/onud2wgE=;
	b=uf3R1F9HoRBrzOkH4yWvK6U7T+TKISSAoDY3NAp+WoxqMoSDTwimUVwZK6IJGDp2l5LP4e
	nV4oBHCsc1rP2DbsfWtah2VvBhVVfkyIyqyweoHPn99wRj03E78Tb5Bd1ua0Jforw4bR1n
	ycyZ35HhQuEVDB9y3QCRP5ik/k9AY/s=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	jose.marchesi@oracle.com
Subject: [PATCH bpf-next v3 2/6] docs/bpf: document the semantics of BTF tags with kind_flag
Date: Thu, 30 Jan 2025 12:12:35 -0800
Message-ID: <20250130201239.1429648-3-ihor.solodrai@linux.dev>
In-Reply-To: <20250130201239.1429648-1-ihor.solodrai@linux.dev>
References: <20250130201239.1429648-1-ihor.solodrai@linux.dev>
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
index 2478cef758f8..3b60583f5db2 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -102,7 +102,8 @@ Each type contains the following common data::
          * bits 24-28: kind (e.g. int, ptr, array...etc)
          * bits 29-30: unused
          * bit     31: kind_flag, currently used by
-         *             struct, union, fwd, enum and enum64.
+         *             struct, union, enum, fwd, enum64,
+         *             decl_tag and type_tag
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


