Return-Path: <bpf+bounces-15246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D9B7EF68B
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 17:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D9AB20A27
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 16:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDED341228;
	Fri, 17 Nov 2023 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG/X4v0L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCCAA4
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:47:12 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso291800266b.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 08:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239631; x=1700844431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P49K8rvs2jyjxWY7j1NsrNWUPhghQTxY+uaoS9l7d/E=;
        b=OG/X4v0LtD7tU7jUpQMgH9SFFDsTqS8jCFFNFVX71+nMvbnRBq84lN4WghhHtigidY
         G3TW8yXau5kroQGk6enq4cXGMWywkxYoEN0WZhPD/k0mE35CnnbCgqpLIGTgxH9o6yR4
         vM0euhCAxZLLH3+f2LQf889yjBgafX7Q2jb5NvY9VV8BIf6YY+qNwMK4sRHtzZ00P14h
         H0LKPcFepqovm6BG+RivlgekU5GLWT5s7EJz3iyza93/l9V+jscbGW1dhc+/CZyuLBuW
         6gBwAfs75tPV0vlDzUn2UwvTqGOutUJ1l+mJOTsu5/qjPuthMyVdrVFgC5ikZrbN/ywK
         OIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239631; x=1700844431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P49K8rvs2jyjxWY7j1NsrNWUPhghQTxY+uaoS9l7d/E=;
        b=Q+VGVuxEpGkmhTXA0YLBQytO9KOalRuiIP4wFXP2x5TiWTRUXZU1JHA5dDibxZaEeE
         oOEqVQFf0ouSJM0QUooG0ZC23iTXQJjpNnzkt0mPIwuxBn2SI/SLiv+Ml/iObQbkxTBe
         8k6iqJGuodxbCcx+/sYvD9ptW3iL4koqz0Tvuk3+RZct4f5HAjNuL4zHFKyg3BQAjRti
         QjW0itOXfKf5WXux3NwSYpFTqF3chnCM8ePvUbx3ChyvMHQMRb3nhfTcNwd4g5NoXfb5
         YpRdb1F3qHlQlgHp2VtSozLnAbbfn2TwsjOssLVmn/CkDFGfQsFQiwZt4Yr+6mFST8y8
         VKJA==
X-Gm-Message-State: AOJu0YxJYKJQgRPU1AyIhgQBjLj77GULeUGZrH3COELm4HNFO5xd7oGL
	lmN+DLI549mmaIUtqZmXBxJu4fl+j4hTzq0IgvA=
X-Google-Smtp-Source: AGHT+IHPUN39RSmp2vhFQWUwsDTYLoWewx+bLt86kDlpRQXid87UCcIuWHyGRFgRtN9NBXAoBXyx5jwlnLSC+/Tj1CQ=
X-Received: by 2002:a17:906:119b:b0:9c4:344e:b496 with SMTP id
 n27-20020a170906119b00b009c4344eb496mr12772600eja.11.1700239631299; Fri, 17
 Nov 2023 08:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-9-eddyz87@gmail.com>
In-Reply-To: <20231116021803.9982-9-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 11:46:59 -0500
Message-ID: <CAEf4BzasZeFPFecLbmwVrR8Tp42mpatWW3AjAK_iuUqQuTyJ8w@mail.gmail.com>
Subject: Re: [PATCH bpf 08/12] bpf: widening for callback iterators
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Callbacks are similar to open coded iterators, so add imprecise
> widening logic for callback body processing. This makes callback based
> loops behave identically to open coded iterators, e.g. allowing to
> verify programs like below:
>
>   struct ctx { u32 i; };
>   int cb(u32 idx, struct ctx* ctx)
>   {
>           ++ctx->i;
>           return 0;
>   }
>   ...
>   struct ctx ctx =3D { .i =3D 0 };
>   bpf_loop(100, cb, &ctx, 0);
>   ...
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

