Return-Path: <bpf+bounces-68733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D017BB82C89
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 05:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4B12A4BCC
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 03:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954CF23C4F4;
	Thu, 18 Sep 2025 03:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fOnq56Cl"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEEA23AB87
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 03:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166988; cv=none; b=rVSyTZM+lceeyQ7DlIZtcof7KZbrHOQuZW+Awl3MX1Okwv5DTClp1X9VaRLHVXQhHW/9Is8Kam5SzRgE83E4hY2Usl6zubxWtgFIldF4r1nQGZKVZI9n0GNfwnJjoy0CXT6ElxOes0XxOEL8b4jQIbA8Vh47Ce2/+VYsj2TfmXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166988; c=relaxed/simple;
	bh=vVPef6q5MaQWwJ9kIZNkMvhFmP5n+5bDcWsF2Hjj+fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2tAvzWz9ftq6TLtTcbF+hlmURDV5b05dBz7wyxX7v65p3A/cmxU1fKQS64D3KbWlr6TnERR/yM1DPxSxXf0gm5/HMw2GDdjnMX7h6iPFUd2AsZ+nv9i8ptupsBmwlK/9c/aIVXxIl9K34guoLKEm3XitSCST/4Im5qjKBcxXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fOnq56Cl; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758166983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+IALbvYxSQwSrG+EOtHvU5OvxTvawaOAoWZ11cqxYM=;
	b=fOnq56ClJk4H9vkBOn6L6mLtEX/+xmwBahsfT0KjqXLD7KvBjzZu5E41MMu3v2O5jXJsCH
	zXAv9X65XiY2CwG3P4e2F9WurlzGWrB/2ALDKmA7GqXg57jz8Z7LekFbTERHEzwAJBH7KJ
	GSR/fNgp9g8khtZUwLNdOwF8ESu7bfo=
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
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 1/2] bpf: Allow union argument in trampoline based programs
Date: Thu, 18 Sep 2025 11:42:42 +0800
Message-ID: <20250918034243.205940-2-leon.hwang@linux.dev>
In-Reply-To: <20250918034243.205940-1-leon.hwang@linux.dev>
References: <20250918034243.205940-1-leon.hwang@linux.dev>
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
AST node count: 6
Attaching 1 probe...
ERROR: Error loading BPF program for fentry_vmlinux_release_pages_1.
Kernel error log:
The function release_pages arg0 type UNION is unsupported.
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

ERROR: Loading BPF object(s) failed.

The type of the 'release_pages' argument is defined as:

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


