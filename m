Return-Path: <bpf+bounces-75614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D108FC8C2E8
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 23:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A016F35577D
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 22:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1121034321F;
	Wed, 26 Nov 2025 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yhMN14/b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3D2D9EE4
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195454; cv=none; b=tGN95g/RO4wWUR8id6EpyLj9yvMD1ysmsSfbUwBA6sBPoD8Eca5/t7SFmOZiga44oC/kfvohDC14K9Y5ZzM6nE0j8QAlEQIFsbGAJVvWJVG1Jm/iJ8D8cuzolP/TkpDsQAHgq7BAunxIALNbToTbrsEoD1dnlEp3JILdXFqHBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195454; c=relaxed/simple;
	bh=8bdhp/XEyRN6TXsJtRAeA96+8FmS2vgEzQfyVsGO/oE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T6C+0REAeh9ktriio64ieYf1lWWXc2qoCYgWAs4CpLlY+3ztf+DUsidAaqjmAW/ez1Y57aoBbjbJlWFVrIJ1u9JuANWxsjBhbYG+wvGzHmziViZ/03+BwJwY9TQDGzD8XSO1ngb2LrOI8exfAnZlaBrXWAuLEeYfJHsTjNHp54w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yhMN14/b; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b9b9e8b0812so338137a12.0
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 14:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764195452; x=1764800252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FMHh1Jv6KIP5NP429fH/fqQBwAKNE3Ze+gaNeawP9DU=;
        b=yhMN14/b85S16kVa31e4O2v6i5zfiObJVc0vE+vuDVo6bmif99DlQdlNqTcOZ9bO3h
         8mXpUYmaoLRPrsesFe5ADx+9ybD5r19eIfylTbA79HTKr/TEja75+ZNcg+eeObVh3tgJ
         Br19bWOD6+dOCGTMcyLcQUReyMK2D27WTVNXppL0p/YUBROJyV6k6G6/2ghpr27DrQXX
         3w+g+tyMZHIF7XzZudV6JxysSgtYNFYvZfSHVs7IWSKn+hozVJAmPlyMJ1+u7sRfPqhs
         1De4njpan0HlfYw+9bzB+rNPT7zDq3TaEb0qtPeqxEJruOxgcl1DT5D44aFW5JsCJeSE
         KFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764195452; x=1764800252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMHh1Jv6KIP5NP429fH/fqQBwAKNE3Ze+gaNeawP9DU=;
        b=rSs8TtOFzhjF8bjiEjIC+eqKSJSCCggEZCscdiDc0cpW9Qgp0OA89AQAAkr53cN7UT
         eyubXFqq752Pr0hWUNOvFErG0HlPb4xqO6DgZ0Y/GOi5f5OmSMolFHW+b+lpcgDKq83X
         MRogYjFZ9GLC8/rfhxPKdcI1YAeAns2gpQ3kD4pfmDtODgPME5JHezuN2HLDAjfkENaE
         yNqUcGSRhA9u6MpqsPfJmL5MYQ5Q1bfnQIlNV7LcEmZvEzq0RtIgU9tcrDiGbEyMIbOX
         SZ6IUpjxWrhPMAbA8FYddCKXoPTRer4836/v1mM7IE7Du/LUuCn7N7rtNIke04wTMcGs
         dxXQ==
X-Gm-Message-State: AOJu0YzQMhawE97//TYT6omDlrpnv7dyAJGqMZrhcLgmUohMz0e+03YD
	Rec6lpFciJ5Zz11UHY+HjYx7o2BeTDtHmeIXsnDRy1UA4n4Tkyu9gR+16EQtJC4NMNZX7xhpqG1
	myBPAQ2hu3Gw+Ja4WkDlNFl9LZJGBmaIVAAX0Q1+JpAxT7pUC5astFOeypDyqaukUDZ+l20w2eJ
	c8/dmm0+xG+esSJMzkqkK1HhKHHKY6uS2rHAwA4YX2sIAxJ/z/wm12gyGBUUXgaovC
X-Google-Smtp-Source: AGHT+IEbnKxY9Xeyzuu5MMGLqSobmE20jDIMb11W+9BVqTdpdxRimEZd6sLMSi1ynNQjKwrc5nixFVWYCFDRJlNQr24=
X-Received: from dyjh19.prod.google.com ([2002:a05:7300:5613:b0:2a4:603a:d424])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:50ef:b0:2a4:7fb3:7a96 with SMTP id 5a478bee46e88-2a7192d82b0mr11685916eec.36.1764195452142;
 Wed, 26 Nov 2025 14:17:32 -0800 (PST)
Date: Wed, 26 Nov 2025 22:17:26 +0000
In-Reply-To: <20251126221724.897221-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126221724.897221-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=samitolvanen@google.com;
 h=from:subject; bh=8bdhp/XEyRN6TXsJtRAeA96+8FmS2vgEzQfyVsGO/oE=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJnqNaVP9i9t/HFhytmXb8zmFk+40VvNebqHYzfjlp6N4
 lXvbZcEdJSyMIhxMciKKbK0fF29dfd3p9RXn4skYOawMoEMYeDiFICJFBox/C9w3vbcTf5P0JNO
 48lH03xMLUNZdbcUytw452s/+aviy8+MDL2NyjoGRo2Mjzz3S7XccW18qN95K1km4L1DlCbDSeX PTAA=
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126221724.897221-7-samitolvanen@google.com>
Subject: [PATCH bpf-next v4 1/4] bpf: crypto: Use the correct destructor kfunc type
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
index 83c4d9943084..1d024fe7248a 100644
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
2.52.0.487.g5c8c507ade-goog


