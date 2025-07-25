Return-Path: <bpf+bounces-64380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73042B121F9
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 18:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9736C188D4C1
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341CC2EF646;
	Fri, 25 Jul 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v4p2u1gD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428EA2F0039
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460592; cv=none; b=iKNnm96YWtzH9SuOEnlyA0nvLZ5JY8n8l8UCqyxcnvGYTdl2bcZU6KpSOkY6WERVIP0mB3YlmFESXUuUdBgdJ4cfsLQangrQjkzQ1I9sUkcKzNBKyDQb5LsV6RQkMTBXxikrVF2DXENm6f811NF6Xe/rS+Fdy1Dm4+pCCYPrYuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460592; c=relaxed/simple;
	bh=MCf3LWmvVfC4w2iOlCtezE1SdttwqDIvC+7VYe8Hat8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/8tXuZy/N0emHnh/o15aCcZH5es/6IimGJGMSRa/GwWi0ntT333NNHPaC//BBuFkM9HsqFJRtHseR0H1wF1O13/zVAsgSSwDX0dBzgHU0H5afjTt8+GnUnV3OW7UcNUr1fugH61vkluNx6Xnz7r3Vg4zoLPFo113tGdTqwCq7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v4p2u1gD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235e389599fso233875ad.0
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753460590; x=1754065390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOBPRmaFhkr1VfnfvoDnAO+QXzN8zO4nX02Uk1KMjOo=;
        b=v4p2u1gD0NOWyRtndv7Wmsv2tmx5Xd7OI9hhWWC4Fmo13VnzyLxYwnvzwoMUSet+Op
         OgfYlzy0C5tXd3Wl9VUiBuKBg2xBgjlYGXp4mpBGaX5pVAE/Znh37JRkSGPFbimFA9cx
         EUkZhlgewn94Y9U8VehdoEKib5+6iggCV9/+NKNs8itD6vn0kajoS1ZlTT3tPXcAB6Fh
         xDqFT0xZ0bq0t3j/r/pDwCA+4S6/c5U3Pqi0ENNGKbShHIgjCqsSv4NYp+b/9Gd/e1gh
         GixfFOBoi3wfjeNedqI/a3CAGuSe/go9cUEW7T/Y129d+geMpLaYZYPygKNEdHbSR8Xy
         Lrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460590; x=1754065390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOBPRmaFhkr1VfnfvoDnAO+QXzN8zO4nX02Uk1KMjOo=;
        b=Vo12/HdnwjYpZOiJpRoAXVdPlNITV5rMdbarmbeVJf5pusmjVL+TDknwBQ4WREXTRl
         csyxbciBbaaFoKBCk7H33e3vccF05O4dEuxLp3BkClzinBJwZ15zibXmTmi9eIk6x8ry
         7E1mmoLHJBP5pp7zMxm7IAX3Az+yqfEZLZuIsEGcp0yqyPRUm5r/hZmqOr7M43fbrKtX
         VU+Ctv6yLEzpWltqHrwtHcKmtSTcH0TMVWqgse1/6RuFQFlStcC0kIHDWiwxtcEsdyEe
         xWcO3J1sMWAyH0NNEXpwrM08Uo2qWnzyRvXV4SZThYs+TU3hyanQMvk7aoURAvy6vGfB
         FKhw==
X-Gm-Message-State: AOJu0Yz6ahFraGYkD0SdskJvzFd7aZNnyxbmLKlSSSkWZJQGK2Dg+7/A
	GpLfU2tnL+374sguyJO3a7lV8Q+wXmCMGHY9rnSfUO6pP7+MS65cJI5dnYxkVd0dm3VimyJznrr
	Psf7WKQJ2C9BgL1PmOui3qidGE4UAJ+JdXals9o0E
X-Gm-Gg: ASbGncvn5mWjzG3JkoZnTq90ydw9kld6OgmeUiWFhFh3d0wzm31YTQPX7LJwKtCQh4L
	OFOnPHS4NjazCcFMsEfTT1HeA2+pR6YqtgNYtwyp4revLHJeLY5XkuPONogfgJbBk6ApOB5US/c
	vjmB94kpNHMOtvzaHPwJxlNlQAkZoGAM7zW6I13L/I322/wC9tNtYcYJQEaSXsvG99m1DeKJRym
	mvO
X-Google-Smtp-Source: AGHT+IGl5iiHRkkzci+gUdFqLMJFBHIWbSieIx+bGFL50yCzQfeZlmr0c4UH6jz8XtwMqFYiJ43X/E0ucoD727+cJ7E=
X-Received: by 2002:a17:902:ec83:b0:22e:4509:cb86 with SMTP id
 d9443c01a7336-23fb0432716mr3084215ad.19.1753460590204; Fri, 25 Jul 2025
 09:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724223225.1481960-6-samitolvanen@google.com> <c7241cc9-2b20-4f32-8ae2-93f40d12fc85@linux.dev>
In-Reply-To: <c7241cc9-2b20-4f32-8ae2-93f40d12fc85@linux.dev>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 25 Jul 2025 09:22:33 -0700
X-Gm-Features: Ac12FXx3vnvKmaRrVmdNDaZtOc0Kn1Ho7Fd64VMkmyNNaYB2638tqbZtyHox5bw
Message-ID: <CABCJKud8u_AF6=gWvvYqMeP71kWG3k88jjozEBmXpW9r4YxGKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Use correct destructor kfunc types
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 25, 2025 at 9:05=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> I tried your patch set on top of latest bpf-next. The problem
> still exists with the following error:
>
> [   71.976265] CFI failure at bpf_obj_free_fields+0x298/0x620 (target: __=
bpf_crypto_ctx_release+0x0/0x10; expected type: 0xc1113566)
> [   71.980134] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> ...
>
>
> The following is the CFI related config items:
>
> $ grep CFI .config
> CONFIG_CFI_AUTO_DEFAULT=3Dy
> CONFIG_FUNCTION_PADDING_CFI=3D11
> CONFIG_ARCH_SUPPORTS_CFI_CLANG=3Dy
> CONFIG_ARCH_USES_CFI_TRAPS=3Dy
> CONFIG_CFI_CLANG=3Dy
> # CONFIG_CFI_ICALL_NORMALIZE_INTEGERS is not set
> CONFIG_HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG=3Dy
> CONFIG_HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC=3Dy
> # CONFIG_CFI_PERMISSIVE is not set
>
> Did I miss anything?

Interesting. I tested this on arm64 and confirmed that the issue is
fixed there, so I wonder if we need to use KCFI_REFERENCE() here to
make sure objtool / x86 runtime patching knows this function actually
indirectly called. I'll test this on x86 and see what's going on.

Thanks for taking a look!

Sami

