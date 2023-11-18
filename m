Return-Path: <bpf+bounces-15305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4650C7EFD97
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 04:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44A91F23BEA
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 03:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5552C5692;
	Sat, 18 Nov 2023 03:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShfXAPKx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039DEA7
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 19:48:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5480edd7026so3216988a12.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 19:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700279312; x=1700884112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTJFcHOnN8lScdCjKL/xi8mxb4YYMHoC6zg78la2l1k=;
        b=ShfXAPKxMnxfdnF21yedXBCHlJgfcfoSybQR+DOsXPiGUIVAMW3EmasIjpMcItHrt8
         87RbMJ6YM6qlvwqjY+CLbMwBS+TJtYTDezElTyt0ZYZQ3OhATgAq0WiJ9TizNVoPSVpP
         oHzwkiaorPBTMBOoV1qfr7ZrCGXy6kjvxr67HP37UaYAlQkavX6XX8DIDzabIrBY0mse
         TA/A/YUYkGj5eNMcAijydu87V1SZkpoDeR7aVyrTz2T2nn0qN3yfEd/xNWXCGR6ACvkg
         nFdZX0FUMrgtlIPaPF5zxs3SyqYDJcv+rjoKA51YkAQxnlXOjntgaDQ7fAVHLsEm/Brg
         CXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700279312; x=1700884112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTJFcHOnN8lScdCjKL/xi8mxb4YYMHoC6zg78la2l1k=;
        b=QriI4JCs/wl8L5kRlPYEY8UTS9nB2Ujx5R94NVRwuQ6ullzZV6MUUxGG52rbqMuNXE
         LuS2/HlHpuuUYaQgQG8+7A376VUATul/HjtkpHv5wxjeUN/E+r5UNWG/Lmc7FXgclHzY
         WeVESwTjLOEXlD5DcTls8dr3SFbonZzWV/u5z85FEnVnN4RXygLn+GD0cveGKZtGmNv3
         4DRuOUxZRu+LOEUWEIboZHcbAmEuWjIvZuQO41LK7yo5S6E9fUj2pyYMsmJYkUFUtewj
         eEdv5M+WBVOisLBdX1p0QgpI1wNjoAEHguwN2jPMDUkAHwPmjYBZXNgJLqBWYLEJ+PFi
         5AhQ==
X-Gm-Message-State: AOJu0YySq6ohXWxMjgPaFZbZiRPYpIBnC3ZJmc3hPO+L99p3AtCv6HGF
	EUmgTmvBBCxUG+tR/pZg93VfLnAJCHxnnYe4eSM=
X-Google-Smtp-Source: AGHT+IHhb84Dz65Y7X/KUcRB5ClwikZiz/B+2MopvOt5ms51sT0Gh8XFIvTsMy6i7CSHD101ly/lBhNNxA2EbuTK5EM=
X-Received: by 2002:aa7:d342:0:b0:541:875:53d8 with SMTP id
 m2-20020aa7d342000000b00541087553d8mr661680edr.23.1700279312400; Fri, 17 Nov
 2023 19:48:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111201633.3434794-1-andrii@kernel.org> <20231111201633.3434794-8-andrii@kernel.org>
 <CAADnVQJT_On7dbs8_KZt8otZfVZBUerJfTBJpLE2_CmbbiNvdA@mail.gmail.com> <CAEf4BzYdY9b3hsKYPipwxQGy3X1tLbQMqjTxJf2Y5-XamuQaZQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYdY9b3hsKYPipwxQGy3X1tLbQMqjTxJf2Y5-XamuQaZQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 19:48:21 -0800
Message-ID: <CAEf4BzZzPBRc90rD1rL7C=WdEzk10V5LMW8ZEZOinTC7Mo_bpg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/8] bpf: smarter verifier log number printing logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 7:38=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 17, 2023 at 9:33=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Nov 11, 2023 at 12:17=E2=80=AFPM Andrii Nakryiko <andrii@kernel=
.org> wrote:
> > >
> > > +static void verbose_unum(struct bpf_verifier_env *env, u64 num)
> > > +{
> > > +       if (is_unum_decimal(num))
> > > +               verbose(env, "%llu", num);
> > > +       else
> > > +               verbose(env, "%#llx", num);
> >
> > I didn't know about %#.
> > The kernel printk doc doesn't describe it.
> > Great find.
> > Curious, how did you discover this modifier?
> > Not sure whether it's worth adding a comment here
> > that # adds 0x. Probably not ?
>
> This # is called "an alternative form" and is a standard printf()
> feature. I saw it somewhere, don't remember where, so yeah, probably
> an overkill to add a comment for that.
>
> >
> > > +       if (type_is_pkt_pointer(t)) {
> > > +               verbose_a("r=3D");
> > > +               verbose_snum(env, reg->range);
> > > +       }
> >
> > A tiny nit...
> > The pkt range cannot be negative, so using Snum here
> > begs the question... why?
>
> original code was using "r=3D%d" format string, so I was preserving
> signedness. But if it's supposed to be unsigned, then yeah, no reason
> to do snum here.
>
> > The rest looks great.
> > If you're ok I can fix it up to unum while applying or respin?
>
> This patch requires fixes for reg_bounds.c tester in the part that
> parses register state. It's not a lot, but not really trivially
> fixup-able. I already have all that ready locally, so I'll repost v3
> with unum change.

btw, please also double-check off=3D and imm=3D outputs, they are
currently verbose_snum() just like original code, but if it makes more
sense to emit them as unsigned, please fix up while applying, thanks!

