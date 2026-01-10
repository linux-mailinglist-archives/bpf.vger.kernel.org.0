Return-Path: <bpf+bounces-78453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54468D0D322
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 09:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17FD9301E6C4
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 08:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2CC2EAD1C;
	Sat, 10 Jan 2026 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRaWMV27"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB428313D
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033559; cv=none; b=cKrx26FUiU459n0hEtBKDIT+y05AZ3rkHmVInWFEncVEjygaL0Qyl/a9Ieo2SJwAnsgjNgKR9wG24q8VoN4BTaMXnRZ/cRfKv0PM0cUc/fZ7Rh+IxrT4doxX8tD/oesGMqG4WgSs9NyIyPgJUNHaG051uFXxqGkWx/Js24ENX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033559; c=relaxed/simple;
	bh=YneUrfDC+afPg04mHEBCFzOnJ9GClFp9DvMMnQVWiXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U4cCVOwIQjMedfI6zd5/N+t+KTeDycgBLPGHrG/ufc/eCGl/tcnluFI9HKPB0SbX2w+xWW1c9h1qtcWCTotFVk7KoXqgi5RcuEpz9n+grCR92Dc5wBZQbixJwUDijFfwuav+gJE8Qxy++dW1shyNYL/GzM/QTu9Fn0oQ1QK/3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRaWMV27; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7f89d880668so4190597b3a.2
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 00:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768033557; x=1768638357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJF1LUIh8jkifINEtEw71yvGIoLQhEraR0Au5jgHYts=;
        b=hRaWMV2737wsK6ATqj/KN/3SVDkFsq9EQDlrpouiLQaLexxb+bIP6YiOsNOOkUzX+3
         bRViMSOJzg8L+ZPh8F18AGfLOO+EOHBIRzdwELF1s4ii7dkrYKE7CrxN1aKS5v+/MDXD
         vb9Y7twLp8DGVjE0DgcxxlvX8NNq2TRN6aahFiJMazYdyv53brw9sZLetMmhTaWIK+nk
         CMLop5NlFeK1+73fAKd+Ai4e3V3JQH/JWWGKPwNTWl0KHFYB5X+Y3w3fwnaDX0vgto9X
         ZqRqNVZHNDjbpgClzzecux7tJtqIAbU1BQC1yuYaDQ8/KBjMltbR2Bp4tjaJnEYMLszA
         5G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768033557; x=1768638357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJF1LUIh8jkifINEtEw71yvGIoLQhEraR0Au5jgHYts=;
        b=vLrcCM9xxawEdgVpRlHUwvbWZb1UBMbNIBG8vcZwB01S7nMsBadXh82CEzI4Z3EgXI
         bLigI7Xw31AWofkm/FXPiyeyo2cbdZh4N5zK66uzXv4kmxU95tKMxct+Y5h+X3v2v/jk
         iG4wBeVpFhl+JW/Q4ko+Q+yt5uZbIYaNupDeP+VvYafV5ln7u32ZxQtjptHzMsNR2R4F
         ageLjnRzYnkX+KyMrItpCvc9AdJ3rw22c/6KFXe9dG4l2h4xuL26+h1X4XHm5W0QnLAE
         eI2wJyOD18GwhtuP7c1HdFP/655YZSrIOpxrIxaaFY9U1ncEvj/zci26MwKp/zzxMl5I
         7X0Q==
X-Gm-Message-State: AOJu0YzCXg/JT78G2B8nLLbCW75rB6iukLkwPuXp/uJSD68rSo8E3J1Y
	CWiCi9UYwiTbhPgkIf87zg571nR+OSd5MYpkrAjVpWYouZfwixbSZQdEv/0hg7aCxHKaEeDUNY4
	IL1PIIV70EwkysTpTuUC+zaV/1vWnvgHZcX9Vfljb1vScwpxmyWUyIYNK2ZC/Jnlkfg/dlenwiz
	T2W+LkkX5Wqp6U4nYZ2BlPRVnaYIgT6Sg3KVbpwVInrsHWwUGXLaqMtPaUtDORzJAN
X-Google-Smtp-Source: AGHT+IF8OevB1WR6kexFfrfNZzGzpamdEcA6jEwIpPLjN+f4AucUzGZNCkumFIP44/6yhkDe+QYhRZxaIwfK9sDGBpk=
X-Received: from pfvo27.prod.google.com ([2002:a05:6a00:1b5b:b0:7b8:909:1a04])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2907:b0:81f:3cd5:2072 with SMTP id d2e1a72fcca58-81f3cd5233emr1056219b3a.3.1768033556888;
 Sat, 10 Jan 2026 00:25:56 -0800 (PST)
Date: Sat, 10 Jan 2026 08:25:50 +0000
In-Reply-To: <20260110082548.113748-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260110082548.113748-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=samitolvanen@google.com;
 h=from:subject; bh=YneUrfDC+afPg04mHEBCFzOnJ9GClFp9DvMMnQVWiXc=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJlJvLxcT5nqueWZli1lnqP8qvqkPW8O90oztzv6ale/m
 xk31+Z1lLIwiHExyIopsrR8Xb1193en1FefiyRg5rAygQxh4OIUgIlMzWZkeHWf9aXJ5j8yMfyL
 zIxP7877dvgzR/Z1exZb1QlPfz67bMzIcOVS9d+496GTn2hk3FIqet64jWnOj7eT3+i8+XS1wXj NJTYA
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260110082548.113748-7-samitolvanen@google.com>
Subject: [PATCH bpf-next v5 1/4] bpf: crypto: Use the correct destructor kfunc type
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Viktor Malik <vmalik@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_CFI enabled, the kernel strictly enforces that indirect
function calls use a function pointer type that matches the target
function. I ran into the following type mismatch when running BPF
self-tests:

  CFI failure at bpf_obj_free_fields+0x190/0x238 (target:
    bpf_crypto_ctx_release+0x0/0x94; expected type: 0xa488ebfc)
  Internal error: Oops - CFI: 00000000f2008228 [#1]  SMP
  ...

As bpf_crypto_ctx_release() is also used in BPF programs and using
a void pointer as the argument would make the verifier unhappy, add
a simple stub function with the correct type and register it as the
destructor kfunc instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Tested-by: Viktor Malik <vmalik@redhat.com>
---
 kernel/bpf/crypto.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 1ab79a6dec84..7e75a1936256 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -261,6 +261,12 @@ __bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
 		call_rcu(&ctx->rcu, crypto_free_cb);
 }
 
+__bpf_kfunc void bpf_crypto_ctx_release_dtor(void *ctx)
+{
+	bpf_crypto_ctx_release(ctx);
+}
+CFI_NOSEAL(bpf_crypto_ctx_release_dtor);
+
 static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
 			    const struct bpf_dynptr_kern *src,
 			    const struct bpf_dynptr_kern *dst,
@@ -368,7 +374,7 @@ static const struct btf_kfunc_id_set crypt_kfunc_set = {
 
 BTF_ID_LIST(bpf_crypto_dtor_ids)
 BTF_ID(struct, bpf_crypto_ctx)
-BTF_ID(func, bpf_crypto_ctx_release)
+BTF_ID(func, bpf_crypto_ctx_release_dtor)
 
 static int __init crypto_kfunc_init(void)
 {
-- 
2.52.0.457.g6b5491de43-goog


