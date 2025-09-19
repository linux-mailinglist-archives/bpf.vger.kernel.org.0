Return-Path: <bpf+bounces-68907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DF4B87E05
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 06:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403276284E6
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4969E26B0AE;
	Fri, 19 Sep 2025 04:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lw4nDDBq"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5425C6E2
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 04:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758256987; cv=none; b=ZwBXTVtWbtW3kQG7xlJ5RsdIDoTfm6SNE4peeNj75kndc2Lm5OKGlVj1KSIH7xOHHqcw8Ip+ZnZANRAfnXcCnTvzK3nFEV65F+gN8iONTfqpdwW82TloutSxbvTjXkU3YgBo8f1UA/d4h9/+XHXZ59/zKJdGSCqH7oZYn8irsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758256987; c=relaxed/simple;
	bh=76gIooNCMMFT65DrAPDmLLeJsGB+uzG/0Y2buyJ79io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRWJcE9fo83le8wiEpObs71nq/0seGfF3Q+NCOxKwU9xw87K1O6OlBUQ5E0ML8U4d7qPoufpmnDEKfur3cuWMRjy2aCoxuEzeYHuOjIfIBKYxt3UIRTlDfrXWVv4fBaO6LXUzjwlb+BI5m5Gc9+tt1oWegt5FidRBpt2XRKZZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lw4nDDBq; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758256980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rZm4778+NvLdi8Qqm5FqTQz+ZBqAxcQ0+8C+HJ9KIs=;
	b=Lw4nDDBqJYUsUllO8yGP9nyHIHyR4fRESdKgt7qD6zm/1NY3+moisMq98TQ5jbJTFi17f7
	twZcDxfnkmJd4ixNlYZA7XBwDg3Y1F6rWJLUPSkYZsXDKBeZTud3EVhSExFma9E9OfLl+v
	HFez99jL78oAFrP5Yupys4oV8IIt8qs=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	ameryhung@gmail.com,
	menglong8.dong@gmail.com,
	chen.dylane@linux.dev,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 1/2] bpf: Allow union argument in trampoline based programs
Date: Fri, 19 Sep 2025 12:41:09 +0800
Message-ID: <20250919044110.23729-2-leon.hwang@linux.dev>
In-Reply-To: <20250919044110.23729-1-leon.hwang@linux.dev>
References: <20250919044110.23729-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, functions with 'union' arguments cannot be traced with
fentry/fexit:

bpftrace -e 'fentry:release_pages { exit(); }' -v

The function release_pages arg0 type UNION is unsupported.

The type of the 'release_pages' arg0 is defined as:

typedef union {
	struct page **pages;
	struct folio **folios;
	struct encoded_page **encoded_pages;
} release_pages_arg __attribute__ ((__transparent_union__));

This patch relaxes the restriction by allowing function arguments of type
'union' to be traced in verifier.

Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h | 2 +-
 kernel/bpf/btf.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 41f776071ff5..42242e238757 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1113,7 +1113,7 @@ struct bpf_prog_offload {
  */
 #define MAX_BPF_FUNC_REG_ARGS 5

-/* The argument is a structure. */
+/* The argument is a structure or a union. */
 #define BTF_FMODEL_STRUCT_ARG		BIT(0)

 /* The argument is signed. */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64739308902f..bfd83e9e7979 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6762,7 +6762,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	/* skip modifiers */
 	while (btf_type_is_modifier(t))
 		t = btf_type_by_id(btf, t->type);
-	if (btf_type_is_small_int(t) || btf_is_any_enum(t) || __btf_type_is_struct(t))
+	if (btf_type_is_small_int(t) || btf_is_any_enum(t) || btf_type_is_struct(t))
 		/* accessing a scalar */
 		return true;
 	if (!btf_type_is_ptr(t)) {
@@ -7334,7 +7334,7 @@ static int __get_type_size(struct btf *btf, u32 btf_id,
 	if (btf_type_is_ptr(t))
 		/* kernel size of pointer. Not BPF's size of pointer*/
 		return sizeof(void *);
-	if (btf_type_is_int(t) || btf_is_any_enum(t) || __btf_type_is_struct(t))
+	if (btf_type_is_int(t) || btf_is_any_enum(t) || btf_type_is_struct(t))
 		return t->size;
 	return -EINVAL;
 }
@@ -7343,7 +7343,7 @@ static u8 __get_type_fmodel_flags(const struct btf_type *t)
 {
 	u8 flags = 0;

-	if (__btf_type_is_struct(t))
+	if (btf_type_is_struct(t))
 		flags |= BTF_FMODEL_STRUCT_ARG;
 	if (btf_type_is_signed_int(t))
 		flags |= BTF_FMODEL_SIGNED_ARG;
@@ -7384,7 +7384,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 		return -EINVAL;
 	}
 	ret = __get_type_size(btf, func->type, &t);
-	if (ret < 0 || __btf_type_is_struct(t)) {
+	if (ret < 0 || btf_type_is_struct(t)) {
 		bpf_log(log,
 			"The function %s return type %s is unsupported.\n",
 			tname, btf_type_str(t));
--
2.51.0


