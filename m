Return-Path: <bpf+bounces-21676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACD985022E
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 03:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1F3B2429B
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 02:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724CA23B9;
	Sat, 10 Feb 2024 02:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJo68yh6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471DC366
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 02:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707532394; cv=none; b=IlfjgKm4KNldDE3UnzHsc0RjHhNQYaMQziWpVaEHrl3Wrqau4UMR+FnmHdOi13xqk+ou+QohHj+bHGquQKTDkA9SR43Q2gjhTCne1K11AyhQWb1Dv5c0KofdemRveyzPpz+0OZXRbSP9Y1iHcz7IGC77XUZ2gaIxpQbd02FxbdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707532394; c=relaxed/simple;
	bh=mJmFbQq6XP3IKElTVM8LeubPfw+0/PFihNvh3h+5jlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLtSa2nWPUEk9AtiIP9x+65CBNPcJ1eEAmOX017FQGIC8k0nrl9biM9OG8G7NhKo3SVXfFkcIqlrBiNpt/YTega0rzGaoESnvFaN6rgNizRqrCwPjpnJn7+VTCmyCMURygRpvZFLZsPAblWtYv1ftwWlRj8nhKTWpjV2gqJt7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJo68yh6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4101565d20bso13900685e9.2
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 18:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707532390; x=1708137190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MpCdF8ON0eMIc46JXDNd8gADv5BuQCYb+ck4K+GqhA=;
        b=dJo68yh6tp9mxeaaH8xJTLnJT1pDGcqQoVJy8EhAObdcghyFn3FeP/Y0cG+A8GlRYH
         o3DVx+0ydeO2/inRYM+9wR84F9e1JQZkLh02Et1aZcq0EtJqmbkvceJgyeAADcuT1pI3
         4avDoxk6dMgbXpR1CbYqF0S53T0Q292eYgeWb8K0NzKVTNjqlgTCdXTn5QzHx3hr7tGu
         Uw6D+f2ZJszR/kw+0F3lp93Xs0LUNwmh40rnjTxwfkpHqynhdYScdzJeLWDRDhmsbWEZ
         dPxt96D+5L1JXtsE1Zp9gBlci9mP5P7zmC9AJhubTkYycJJwxN2chxGSDj839FQyKQ+j
         weIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707532390; x=1708137190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MpCdF8ON0eMIc46JXDNd8gADv5BuQCYb+ck4K+GqhA=;
        b=AQbDdVfT/ZV4SAqxHK4xPgARseIPd2W9fV49tmkdvBrKN5oog1FJcvaC5TUfhgZ8Nv
         WCPsKZCpUuHhcAW9srON4uF3I0rcvuueIkqMYJSer+QOtILW613QTLM/LcD35MVlNauu
         FOvoPF2vIvAuUqgFytXF7y6dLCXfm0Ibr0GJifo4N65B2DxqjLItATHt7uPkZEa1Xbbv
         OTUN4KjchhZwqTCIfNcIoMnaCof2XXMKjPBRKfSbOL9zbpYe647EwkXbBBGBPCZITJe/
         gZ1Z6GVnrGd+5gxRH+sk+c78WSoZYQKr4oq3PHy0MRInJ5A3gVWI92snjHUuZ7k+J90X
         ZcSQ==
X-Gm-Message-State: AOJu0YzHFMknqlc6vehDI70XMtZOFk405SwINvBf5NFgTqAOnFdk5Ipe
	aB4o0OoGKM4mFkiCjmIqCWSVluZpJCNEyp0ipMfWJ/YtYlt1PGHUb6CqbBD31BHV+ZUWnn5AVBt
	+DD7YOyai6NgoubpxH3wLqwupQAs=
X-Google-Smtp-Source: AGHT+IE5cO6RKNBNRcqQWQPrlfKFYo3kbxatiPndfb5TLuqs6saYM8SdMxskcym57ocMTdMny/xyEs0xTUiLbsm3D3E=
X-Received: by 2002:adf:f9ce:0:b0:33b:1894:c497 with SMTP id
 w14-20020adff9ce000000b0033b1894c497mr401431wrr.35.1707532390065; Fri, 09 Feb
 2024 18:33:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-2-alexei.starovoitov@gmail.com> <CAEf4BzYBjzHL20NU_yuj+en-YF0dJmHuvB1SOPGZc=tnbhjZhQ@mail.gmail.com>
 <CAADnVQLTt5S8HPcLv1hHWZFBXeU7HJNyocg7rE3rGrpnOuwxTQ@mail.gmail.com> <CAEf4BzZVgtZc0EfJaHJ1hVQUECV0W+ytXgjKTySBwC9ZkdqogQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZVgtZc0EfJaHJ1hVQUECV0W+ytXgjKTySBwC9ZkdqogQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Feb 2024 18:32:58 -0800
Message-ID: <CAADnVQKaUFUb=hHp=2kr9fQpkP=8mRs+D7c9HLAXZu3-mXOHcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/16] bpf: Allow kfuncs return 'void *'
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 11:09=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Feb 8, 2024 at 4:09=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Feb 8, 2024 at 11:40=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Feb 6, 2024 at 2:04=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > Recognize return of 'void *' from kfunc as returning unknown scalar=
.
> > > >
> > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > > ---
> > > >  kernel/bpf/verifier.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index ddaf09db1175..d9c2dbb3939f 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -12353,6 +12353,9 @@ static int check_kfunc_call(struct bpf_veri=
fier_env *env, struct bpf_insn *insn,
> > > >                                         meta.func_name);
> > > >                                 return -EFAULT;
> > > >                         }
> > > > +               } else if (btf_type_is_void(ptr_type)) {
> > > > +                       /* kfunc returning 'void *' is equivalent t=
o returning scalar */
> > > > +                       mark_reg_unknown(env, regs, BPF_REG_0);
> > >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > I think we should do a similar extension when passing `void *` into
> > > global funcs. It's best to treat it as SCALAR instead of rejecting it
> > > because we can't calculate the size. Currently users in practice just
> > > have to define it as `uintptr_t` and then cast (or create static
> > > wrappers doing the casting). Anyways, my point is that it makes sense
> > > to treat `void *` as non-pointer.
> >
> > Makes sense. Will add it to my todo list.
> >
> > On that note I've been thinking how to get rid of __arg_arena
> > that I'm adding in this series.
> >
> > How about the following algorithm?
> > do_check_main() sees that scalar or ptr_to_arena is passed
> > into global subprog that has BTF 'struct foo *'
> > and today would require ptr_to_mem.
> > Instead of rejecting the prog the verifier would override
> > (only once and in one direction)
> > that arg of that global func from ptr_to_mem into scalar.
> > And will proceed as usual.
> > do_check_common() of that global subprog will pick up scalar
> > for that arg, since args are cached.
> > And verification will proceed successfully without special __arg_arena
> > .
>
> Can we pass PTR_TO_MEM (e.g., map value pointer) to something that is
> expecting PTR_TO_ARENA? Because there are few problems with the above
> algorithm, I think.

The patch 10 allows only ptr_to_arena and scalar to be passed in,
but passing ptr_to_mem is safe too. It won't crash the kernel,
but it won't do what user might expect.
Hence it's disabled.

> First, this check won't be just in do_check_main(), the same global
> function can be called from another function.

that shouldn't matter.

> And second, what if you have the first few calls that pass PTR_TO_MEM.
> Verifier sees that, allows it, assumes global func will take
> PTR_TO_MEM. Then we get to a call that passes PTR_TO_ARENA or scalar,
> we change the argument expectation to be __arg_arena-like and
> subsequent checks will assume arena stuff. But the first few calls
> already assumed correctness based on PTR_TO_MEM.

I think that would the issue only if we call that global func
with ptr_to_mem and then went at processed the body of it
with ptr_to_mem and later discovered another call site that
passes scalar.
Such bug can be accounted for.

> In short, it seems like this introduces more subtleness and
> potentially unexpected interactions. I don't really see explicit
> __arg_arena as a bad thing, I find that explicit annotations for
> "special things" help in practice as they bring specialness into
> attention. And also allow people to ask/google more specific
> questions.

In general I agree that __arg is a useful indication.
I've been writing arena enabled bpf progs and found this __arg_arena
quite annoying to add when converting static to global func.
I know that globals are verified differently, but it feels
we can do better with arena pointers.

Anyway I'll proceed with the existing __arg_arean approach and
put this "smart" detection of arena pointers on back burner for now.

