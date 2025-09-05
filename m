Return-Path: <bpf+bounces-67559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B598B45927
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 15:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1CE1C23700
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 13:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179E4352FFF;
	Fri,  5 Sep 2025 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sl6PZwir"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456CF35208A
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079169; cv=none; b=b0Uduh7TieqzlnzmMKJXN9Z/luO+wEyiUIVrFnwUFI8f0jEwXYiQ+8+UPn1ViXcBnN/0t9bAGQqGW6GwgJ4xILGV4FuRCxP05ZQISG2+QcEiKuwkbmsfSLGvaMW/FPY6hHXQ9Xzgj1pT0nAp0YMbYdjKofyc+G87IZl8HADbK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079169; c=relaxed/simple;
	bh=p4jcOUlnFsPlwQKKhAeofZd7pW0D/hauwANMH6oB8VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKxOxp53qOftWxoS8oYJ8XiTByVAEjs3+H22mQBDpXcRRs6QqMK3A3S6InlewC0eoNgM27MX+qGkjDUI/yuqJnlHc2QWwP0WuozaherNqF4IIVDemKnhycfB2m4vKfGUqio+uaT1e4zmrQ4WDqiz7BuC8a1vjzRaV8mpAG7b0I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sl6PZwir; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757079165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oBKM7KaZAek2Q0NY2l12aJ4wT++4m1UmFtSJCLY2LaI=;
	b=sl6PZwirHJWpPuYIxrVh9Ho/nW6ZdoWrCqadTmaLzd6IstG4nj74qNn3PzPhqYzgYzmMiL
	Af/PuqXZLSpeiGgo/vGvJ4vwxsRmusQQMigVgp8zsoTEwgjHh1Az6fMryoG24PgLLalYH9
	0yduwOXOplx41zrDQKVKt8yRdQx53Dw=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 1/2] bpf: Support fentry/fexit for functions with union args
Date: Fri,  5 Sep 2025 21:32:25 +0800
Message-ID: <20250905133226.84675-2-leon.hwang@linux.dev>
In-Reply-To: <20250905133226.84675-1-leon.hwang@linux.dev>
References: <20250905133226.84675-1-leon.hwang@linux.dev>
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
'union' to be traced.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 64739308902f7..86883b3c97d20 100644
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
--
2.50.1


