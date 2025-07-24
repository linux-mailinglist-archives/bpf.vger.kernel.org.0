Return-Path: <bpf+bounces-64308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0108B113F6
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 00:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F6D5A609F
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 22:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D9923F40F;
	Thu, 24 Jul 2025 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1rGxNHwm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FF823BCE4
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396354; cv=none; b=tfohrBzpSxVWoZWUx2FcmXgi3WYBeqL855h8OXA9JuOuf0cONhEVCnGTojbAhDOEmYR0/4Al8ekW0ibikh3eL8qMNKVfU9wvVZeRIPIc5tTxFVcZuVr6i8UxkPYwjJ9khMcRETj8Z+H0vjLEAfxLjCnIf1R4ElL+rGSo4WyY2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396354; c=relaxed/simple;
	bh=HteP852RK5J1QiH2uzeIVvSELts0Mqfzj/8HRpKenLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cID6h4OGHg33cTVIjH+y1GRw138ur26fO9rP6v3QVOn+jzcJ8uguBuqImpr9+LZ0DUs+C77huNUl18w3JK6sg57lOnRmer9KWTWNm4ODeNULy/RuulbtycxN3d1WY4Y/UmiweEfGtI5A9xDSuPnnF2aRfDkFXCaJGXQFjmdNCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1rGxNHwm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b34abbcdcf3so1092109a12.1
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 15:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753396352; x=1754001152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W++rfy7Ckrm4pbQZbQbrjeSn7L0O+EOfVFPaS3WWK2g=;
        b=1rGxNHwmip3SLoNVBeYgd7lKzvq/U/Y6mc561U4Zjy3HRp108Dq0F54Bff9jYJoS45
         OI8ICaKsgGgm7HS1FTuewbjpe/chbDbNt1X+MIL3Nmf3oAGDQK8XhmgeV1HVwL0pVhAn
         TGluIuoJTXuNjo2YKdKKDv9TaYJDx89MT3/UdLWbv2ErZso9coOUbHaIqqVIKr5QVgOy
         fARvBaijsRaJd9oCs2Tu6TqBBLVsTgkzrqcm0XzB6Z1cqRIFrpFptypD05WkS0d3oR4W
         dPUMN9JqFkAmEjojwXfn7+K5fuV07OW1yR+BJ91tFooipfMPSoxVME7RF7fd8PEEbSJY
         703w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753396352; x=1754001152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W++rfy7Ckrm4pbQZbQbrjeSn7L0O+EOfVFPaS3WWK2g=;
        b=DPgxQlqOG53uVzfcmNPcDbCzlNwyPlm2kmqcI9NeiTruahJrvrYHbMnssC8EkRha1u
         OoB5K3KVIV0M9NQPqGYz88E/mofuouo6fwE75rQCdMMv4N2MTF6uZYLziw/Xmsm0Y+Xd
         Z63L3bYpevvvm1VJ7gyDe982bz+pag36/dwgjE76I4i29OG/2JsebiwXuJFaV0eWO9ZA
         hWfI2XNzVevIx9Up5aXhp/ywXdeYVHF9zA7L8LCbXuIrvxW+siKqX11C9fxAZIY00SK2
         7A1Tvt3Jz9zLtXaiE4r5K84nTxJbaKa0w7xxGbA+aZhCCMRpRL6eeZ/iSEHsuwPyLzZc
         WJ0A==
X-Gm-Message-State: AOJu0YzxTUN2vRoL8zk9xT8hm9oqdiCdibSUYNH0AYpGT5zx31cvSo2z
	r0IrLbLDnQEyuWrvd6yxV4LOLKKs9RqpH+FosEArzEUN2Qxlave5YvGpXe2EThqRWw5YlpI0uWT
	/UvNfhsKV661gOEIxYNASzmNl+qReQyFJxuR/wdR/OkClv2VYpI6aJW8OBPFYFBVSKBaz/dN5Cn
	JOnIpk062gdBEyT2fAFxn3R491KUOpWxf/QZAzz0nQZ/eUeJ88D/hPuLf6pxZj9jit
X-Google-Smtp-Source: AGHT+IGgkCKtpxoLZCJIhQvorDzFLqiG8h8Sn2E1b+a5JvxAcvHUrj2rVlHQjJhJHSFxhgZAh1/lsIYz1+ylxt5EJKw=
X-Received: from pjboe10.prod.google.com ([2002:a17:90b:394a:b0:311:ef56:7694])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3809:b0:31e:326e:4d2d with SMTP id 98e67ed59e1d1-31e5073f566mr10846803a91.5.1753396352411;
 Thu, 24 Jul 2025 15:32:32 -0700 (PDT)
Date: Thu, 24 Jul 2025 22:32:27 +0000
In-Reply-To: <20250724223225.1481960-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724223225.1481960-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1650; i=samitolvanen@google.com;
 h=from:subject; bh=HteP852RK5J1QiH2uzeIVvSELts0Mqfzj/8HRpKenLk=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBlNW6r63p77Pv3SnbiFyWE7qoKaY94fud1SOW8ui2aRU
 Zfv9rAJHaUsDGJcDLJiiiwtX1dv3f3dKfXV5yIJmDmsTCBDGLg4BWAir5IY/krOrlsb8MvHsWhC
 BeMr7qDtuW9z30W31nm0pPPzHYqNT2Fk+MftN6P//8OvIjNPa0rZrJpvpeqZ9cJQel13f/1JNuU HnAA=
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724223225.1481960-7-samitolvanen@google.com>
Subject: [PATCH bpf-next 1/4] bpf: crypto: Use the correct destructor kfunc type
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
indirect function calls use a function pointer type that matches the
target function. I ran into the following type mismatch when running
BPF self-tests:

  CFI failure at bpf_obj_free_fields+0x190/0x238 (target:
    bpf_crypto_ctx_release+0x0/0x94; expected type: 0xa488ebfc)
  Internal error: Oops - CFI: 00000000f2008228 [#1]  SMP
  ...

As bpf_crypto_ctx_release() is also used in BPF programs and using
a void pointer as the argument would make the verifier unhappy, add
a simple stub function with the correct type and register it as the
destructor kfunc instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/bpf/crypto.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 94854cd9c4cc..b703b1d1c282 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -261,6 +261,11 @@ __bpf_kfunc void bpf_crypto_ctx_release(struct bpf_crypto_ctx *ctx)
 		call_rcu(&ctx->rcu, crypto_free_cb);
 }
 
+__bpf_kfunc void __bpf_crypto_ctx_release(void *ctx)
+{
+	bpf_crypto_ctx_release(ctx);
+}
+
 static int bpf_crypto_crypt(const struct bpf_crypto_ctx *ctx,
 			    const struct bpf_dynptr_kern *src,
 			    const struct bpf_dynptr_kern *dst,
@@ -368,7 +373,7 @@ static const struct btf_kfunc_id_set crypt_kfunc_set = {
 
 BTF_ID_LIST(bpf_crypto_dtor_ids)
 BTF_ID(struct, bpf_crypto_ctx)
-BTF_ID(func, bpf_crypto_ctx_release)
+BTF_ID(func, __bpf_crypto_ctx_release)
 
 static int __init crypto_kfunc_init(void)
 {
-- 
2.50.1.470.g6ba607880d-goog


