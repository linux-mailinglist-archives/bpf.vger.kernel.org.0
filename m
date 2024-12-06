Return-Path: <bpf+bounces-46314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C909E782C
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47D9283AC4
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A501D63C0;
	Fri,  6 Dec 2024 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkpWUqLn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AC51D515D
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510228; cv=none; b=TxqyQcCis51y1a6lo3rJ8bZtgQvyc5TRDxV0arIMpHQqLge+uTBAbs9l9rkSIgW7AMcCsQVapX5hpPVrAxp2DQfD1zv9S/YRy9bZWOJjgA9WOu3ym8znch73xSbeg3iwOq41TPa7T89AH4kEru8d41HefKMFhNtBL7pvOFpeSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510228; c=relaxed/simple;
	bh=nuI9V+2CQXQ6BlnVIowuK0Te59/XBdP//+jjWdYjfRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkpsgLpLgqgZ3LjgW0E/v3cpWPhaY9Qzlrce5lrMEV3mAb3OEkSvSrMazi9VLcV+Uyiw5NX1qcrIuKcHsh6PDi4xGhu8dE3V2yzHHVHtNpu6QIdoC75wCu3QW+VK8MoFIhVAwGS+7+cASXOy6TdS5cTwMcGTvNMYApdh5F2VWkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkpWUqLn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434e406a547so2093925e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 10:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733510225; x=1734115025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZv3zwaNd4UzGCfg97dpELACEVFg+P8g0mfgKer3WQU=;
        b=SkpWUqLn7iOExJYUh2RWOUvwXG1vkEYxIcXJOQ6gi2tJNNAcnTFvncff+VzaK91NbM
         OIywKlI9iaRh8GSe3EAM4yM1bGkP4+MA+DHFhGnZY2BapPe9U8It+9Fj56ENvlv5GKpf
         9TjHCUvzJ3i496vYniSDj/0ibZpjtgySddohJMt1iiigIrhTk47nIeP8NF89s6ulOAxy
         3kAPujBk9U5MaNcNZ/O1E0nDO44O7QGz0qogB7Kfb1du3H7AinWifaVEpgWyHW5yFxQt
         hPoRm+9SWb4tOrOwzhly/1xEUso0oUvh1PvOyrQFPqRvnXEJPmWcXyK2rwYGyeb6O5yy
         ADRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733510225; x=1734115025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZv3zwaNd4UzGCfg97dpELACEVFg+P8g0mfgKer3WQU=;
        b=XAXDQ8SYic4R6ESGZCpcJyaOAMJNWcBBD9VHOJqONmaRUif09Z719pz/W/1uEsHmuh
         KaDHDE/MZMghgz6SF7ZRD4GWhDWuyDwSRjZ1xTP/UZtwgj3B9+mP1LzzvFMi+VRjFxFQ
         ueouj1EJTaBVQRqNwm5B0/NqBJf5jJ569V6oocOanKbnoiwdTnpLMSssEFNknQ8xOEOP
         2s8bkIUIS+r76AyrRFSpnT7NiESgUpdpdF5wDFuStMdkemEQE5gzwEqDuDdzHDAU9Vpo
         Njbz2M/hM24FdrV5DvAjQMBe6GyoH63GMY2Z6plSIcKh9GRKKIYuJI1+iJ3sfWVb0Z52
         9wlg==
X-Forwarded-Encrypted: i=1; AJvYcCWLsXA22FfowxEq9DYXgJYYQFOwPCo3DjQvzrXRZ0o2ETwsdWzTiXyRvY/kRcR07d6lqP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YziQ3YTxgsQVGXKwT4RkGjQqqZGd2SixPn1UN6mz0Wu37K5px5G
	iXpdmjDj3lht9Z047qtWN2l/Sjw9BiyyuEkdN1bYQG9gPH15PsSjzpuEWdC/IKQssDTRiKmKzij
	OQsbb0b7IEucuXJ0fcjvXLgCwfU2P6KKE
X-Gm-Gg: ASbGncsoKxwcSgunXYS9Fc+RzbPg1wtv5vUjfAAKkfHKi8H3WUBES7LsXqjo8PlER8h
	BcXvp45RfoVD+xr+kXlgJSZjZ3c5yWudoj5HToMriklBkqKw=
X-Google-Smtp-Source: AGHT+IGDCa4EwL7bP2V2z2GkMWLvQUuUbktGhar1M02KWSIFZzhNh/UvUvHm6urEWLoxdqPP2gn0X51AftPZbEwrFN4=
X-Received: by 2002:a5d:64a3:0:b0:385:f249:c336 with SMTP id
 ffacd0b85a97d-3862b3e60e9mr3227143f8f.45.1733510224653; Fri, 06 Dec 2024
 10:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206161053.809580-1-memxor@gmail.com> <20241206161053.809580-3-memxor@gmail.com>
 <CAADnVQ+_XGVsxYji3WYNj1-KhYZwKaFCgQ6aN=yFB3YWpRT78A@mail.gmail.com> <6ef10614dfdf281663f62315247c4bb33c2609bc.camel@gmail.com>
In-Reply-To: <6ef10614dfdf281663f62315247c4bb33c2609bc.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Dec 2024 10:36:53 -0800
Message-ID: <CAADnVQLKROxDbx8ehfbCNvKPnrWQpGeqzdy_AipCVbwEW9Bcow@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Do not mark NULL-checked raw_tp arg as scalar
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	kkd@meta.com, Manu Bretelle <chantra@meta.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:15=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-12-06 at 09:59 -0800, Alexei Starovoitov wrote:
> > On Fri, Dec 6, 2024 at 8:11=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@=
gmail.com> wrote:
> > >
> > > An implication of this fix, which follows from the way the raw_tp fix=
es
> > > were implemented, is that all PTR_MAYBE_NULL trusted PTR_TO_BTF_ID ar=
e
> > > engulfed by these checks, and PROBE_MEM will apply to all of them, in=
cl.
> > > those coming from helpers with KF_ACQUIRE returning maybe null truste=
d
> > > pointers. This NULL tagging after this commit will be sticky. Compare=
d
> > > to a solution which only specially tagged raw_tp args with a differen=
t
> > > special maybe null tag (like PTR_SOFT_NULL), it's a consequence of
> > > overloading PTR_MAYBE_NULL with this meaning.
> > >
> > > Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL"=
)
> > > Reported-by: Manu Bretelle <chantra@meta.com>
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 82f40d63ad7b..556fb609d4a4 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -15365,6 +15365,12 @@ static void mark_ptr_or_null_reg(struct bpf_=
verifier_env *env,
> > >                         return;
> > >
> > >                 if (is_null) {
> > > +                       /* We never mark a raw_tp trusted pointer as =
scalar, to
> > > +                        * preserve backwards compatibility, instead =
just leave
> > > +                        * it as is.
> > > +                        */
> > > +                       if (mask_raw_tp_reg_cond(env, reg))
> > > +                               return;
> >
> > The blast radius is getting too big.
> > Patch 1 is ok, but here we're doubling down on
> > the hack in commit
> > cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> >
> > I think we need to revert the raw_tp masking hack and
> > go with denylist the way Jiri proposed:
> > https://lore.kernel.org/bpf/ZrIj9jkXqpKXRuS7@krava/
> >
> > denylist is certainly less safer and it's a whack-a-mole
> > comparing to allowlist, but it's much much shorter
> > according to Jiri's analysis:
> > https://lore.kernel.org/bpf/Zr3q8ihbe8cUdpfp@krava/
> >
> > Eduard had an idea how to auto generate such allow/denylist
> > during the build.
> > That could be a follow up.
>
> If the sole goal is to avoid dead code elimination for tracepoint
> parameter null check, there might be another hack. Not sure if it was
> discussed:
> - don't add PTR_MAYBE_NULL (but maybe add a new tag, PTR_SOFT_NULL
>   from Kumar's original RFC);
> - in is_branch_taken() don't predict anything when tracepoint
>   parameters are compared;

this part was discussed, but we didn't realize we need below bit...

> - in mark_ptr_or_null_regs() don't propagate null for pointers to
>   tracepoint parameters (as in this patch).

... and here the 'for tp args' filter is hard to do.
mark_ptr_or_null_regs() is generic. arg vs non-arg is lost long ago.

