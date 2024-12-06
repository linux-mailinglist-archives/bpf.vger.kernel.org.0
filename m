Return-Path: <bpf+bounces-46319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 115CA9E789A
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 20:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4F718866EC
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351821DA0E0;
	Fri,  6 Dec 2024 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO8Igt53"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8B22069F
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512248; cv=none; b=Dlvovb2GRVPYoJbPneNi2MH0HiCs5S7T1c0XU2Memv1LFNAG8FzlUqbfQ9tEL2TNqUU940/T0qKaCvHw10uD4YEmT2x61Z4EHw22ZKNY3ES2uP5Z0j8u1h65Cmuc/KpyZ/UpT0nQGEUPCOQH64rm0VK0Bxom8z4Lwunm2ULPQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512248; c=relaxed/simple;
	bh=kUqN9TK3vMg8mQQj7bkiXtAiPuCiW92G9hWcGl6hJsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yk/5zbIhG4HPQRpXtUmaSqAOuulml85SNftw5GQTN6HLkQ3OS4c3rZ8i5cYXzRBs8d6RdQk+RbLP/AKBmOltA5Lj4VNh9yyPmM/MvrzzD/BIBGbYhsKzb5GL3p0yo/P8NTq//H77Whz4Q4Rheuc6KUF5Pl0p5gjxMG4hyNIuPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JO8Igt53; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5d3d74363cbso564174a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 11:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733512245; x=1734117045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pclT6wuumay2QJtBD4CwLSNKiJBllTaOYB5ClO8XhJ0=;
        b=JO8Igt53n3HOUEj8XED3FKTBM7C6bubyAked1do0WpKEjbwFI7PZqcl5RA8NgwqwOD
         lHeFd4tq2e+KbcfkrACt1oionUX71y4qyNDXyFo00GhYSgSm9vbL/GlQE89KKppOv8wA
         vgx3Tz7Odi4eVcFuQabEmw+VH5MV+SHtPjR/4iui2bYVmdn9UWO5LiAGZTiPWjWKS5wg
         KfMzJ7MlqplRegjvQ4EIG8LCYeE4Q+htLc+ygblh49MdrEVrkoT7+KI1MXl6/bzeyLkI
         EjoS3+wq0SlhS8SJK3OhERQiVD4RV1JhKc2tTYVpfjNAzfYldP6eFnNHGfbU8+JigCCz
         nLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512245; x=1734117045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pclT6wuumay2QJtBD4CwLSNKiJBllTaOYB5ClO8XhJ0=;
        b=VP937qfd5ANHHhCKgA/ACzrWqKBrcTJCWhRkas879mSiz8YvXo9Zvy7NlzhcNgibPA
         JGQJ7u58CPW6EaxZMNRV9o8DR1PAj/iOhh1GioBleLm6ajEpxJjWqDgr/lKwitUQNAT/
         i7xs3kdfBR8y9o89/nPppYWgpdk/tFfr8WYFy7ZrHDjthFguowfo2mjYtG/r31pU20a4
         vXTpwfvtuBuEBu1qis2CElI/lRxYD8kY+FFFz15OvCWkCarAI9rIB+qnnom6J99BlFT6
         Tx7TYm+epmnkIaxbfZ7aNAgp7IXm64NC/mw9+Hbly9DYfdw2upXoWz+YnaPK8CqgVLoe
         3Evw==
X-Forwarded-Encrypted: i=1; AJvYcCXjkCPnulsRCU7kYDGqWspFbqdewjBMSCTWd+gcI3vYE5owY8mq+6GLi5ZFyys/TFuzLvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6XYmC4pMUWIrH7EdAxr/YMmKi63Dz35Tvd/fqypgvieoYPGL9
	65fyuI276A0Pb8h5Fe4LTscpp7vzHWxHN+mLNUoZh/X/jYdl6EPmmYCr3Bz6YSIocnQV3E6aXEO
	tNsS5b+1ub08/fbI42ymEJJygYYs=
X-Gm-Gg: ASbGncvPGI6IhgALqdSY3ur/JTgdWScKioX+k7zsuXeceJ3p3z8gd6VNohy1tlLNMyH
	3tJFxzLcUPUnOfnfOjq/PnhKTwkjlBEvLu13xEm2OMx8HZ4ruaL94NcqkGpPMpbIs
X-Google-Smtp-Source: AGHT+IFxUDpvQwQcAv4hB1iibf2NU1dOiz63Qx10qtKcH2IaNT1ovh2+xGw9IrZKeLLdzA2/4mYQ/kDS7GtkiuVD5CE=
X-Received: by 2002:aa7:d1cb:0:b0:5d3:cff2:71a3 with SMTP id
 4fb4d7f45d1cf-5d3cff294f2mr2504341a12.33.1733512245196; Fri, 06 Dec 2024
 11:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206161053.809580-1-memxor@gmail.com> <20241206161053.809580-3-memxor@gmail.com>
 <CAADnVQ+_XGVsxYji3WYNj1-KhYZwKaFCgQ6aN=yFB3YWpRT78A@mail.gmail.com>
 <6ef10614dfdf281663f62315247c4bb33c2609bc.camel@gmail.com> <CAADnVQLKROxDbx8ehfbCNvKPnrWQpGeqzdy_AipCVbwEW9Bcow@mail.gmail.com>
In-Reply-To: <CAADnVQLKROxDbx8ehfbCNvKPnrWQpGeqzdy_AipCVbwEW9Bcow@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Dec 2024 20:10:09 +0100
Message-ID: <CAP01T75j=4A2t2pngMg_A3+NyEG3OmO2gMk3NKX4UjYj4gcR-w@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Do not mark NULL-checked raw_tp arg as scalar
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	kkd@meta.com, Manu Bretelle <chantra@meta.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 19:37, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 6, 2024 at 10:15=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Fri, 2024-12-06 at 09:59 -0800, Alexei Starovoitov wrote:
> > > On Fri, Dec 6, 2024 at 8:11=E2=80=AFAM Kumar Kartikeya Dwivedi <memxo=
r@gmail.com> wrote:
> > > >
> > > > An implication of this fix, which follows from the way the raw_tp f=
ixes
> > > > were implemented, is that all PTR_MAYBE_NULL trusted PTR_TO_BTF_ID =
are
> > > > engulfed by these checks, and PROBE_MEM will apply to all of them, =
incl.
> > > > those coming from helpers with KF_ACQUIRE returning maybe null trus=
ted
> > > > pointers. This NULL tagging after this commit will be sticky. Compa=
red
> > > > to a solution which only specially tagged raw_tp args with a differ=
ent
> > > > special maybe null tag (like PTR_SOFT_NULL), it's a consequence of
> > > > overloading PTR_MAYBE_NULL with this meaning.
> > > >
> > > > Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NUL=
L")
> > > > Reported-by: Manu Bretelle <chantra@meta.com>
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  kernel/bpf/verifier.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 82f40d63ad7b..556fb609d4a4 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -15365,6 +15365,12 @@ static void mark_ptr_or_null_reg(struct bp=
f_verifier_env *env,
> > > >                         return;
> > > >
> > > >                 if (is_null) {
> > > > +                       /* We never mark a raw_tp trusted pointer a=
s scalar, to
> > > > +                        * preserve backwards compatibility, instea=
d just leave
> > > > +                        * it as is.
> > > > +                        */
> > > > +                       if (mask_raw_tp_reg_cond(env, reg))
> > > > +                               return;
> > >
> > > The blast radius is getting too big.
> > > Patch 1 is ok, but here we're doubling down on
> > > the hack in commit
> > > cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> > >
> > > I think we need to revert the raw_tp masking hack and
> > > go with denylist the way Jiri proposed:
> > > https://lore.kernel.org/bpf/ZrIj9jkXqpKXRuS7@krava/
> > >
> > > denylist is certainly less safer and it's a whack-a-mole
> > > comparing to allowlist, but it's much much shorter
> > > according to Jiri's analysis:
> > > https://lore.kernel.org/bpf/Zr3q8ihbe8cUdpfp@krava/
> > >
> > > Eduard had an idea how to auto generate such allow/denylist
> > > during the build.
> > > That could be a follow up.
> >
> > If the sole goal is to avoid dead code elimination for tracepoint
> > parameter null check, there might be another hack. Not sure if it was
> > discussed:
> > - don't add PTR_MAYBE_NULL (but maybe add a new tag, PTR_SOFT_NULL
> >   from Kumar's original RFC);
> > - in is_branch_taken() don't predict anything when tracepoint
> >   parameters are compared;
>
> this part was discussed, but we didn't realize we need below bit...
>
> > - in mark_ptr_or_null_regs() don't propagate null for pointers to
> >   tracepoint parameters (as in this patch).
>
> ... and here the 'for tp args' filter is hard to do.
> mark_ptr_or_null_regs() is generic. arg vs non-arg is lost long ago.

It is not lost. If only args are marked PTR_SOFT_NULL or
reg->btf.is_raw_tp_arg (or w/e else), it can still be seen when we are
in that function, and all its copies will have the same information.

