Return-Path: <bpf+bounces-67325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A923FB42896
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 20:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3ED3B524D
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4DA362081;
	Wed,  3 Sep 2025 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgSwY/Xt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50622010EE;
	Wed,  3 Sep 2025 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756923616; cv=none; b=rmq0wgYyUssU/9JhP7gRQm+XF1mULUj0Bm/rT2EvMO0e/CcZ9sQtaoFL1MiRq8C0c5XFk4jUOBlZwUaHm7KgJUF8K9XdPjiuLUx4qzw4H76Ynq6Dkqsk3uqlqpph7YmfH3hfZhsh6jo4JRLS6Y3cEDxsyQ8VTDzdqn6y3flr+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756923616; c=relaxed/simple;
	bh=5L9IvmqvIoBbv7cKvxT07RQpTrNSVmQNxpLyw9n7IFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rngQqfnugg19Sx3URs623fE69KsUGrvvGZAZSoulMJaFBlyYUplyENMaxlZmlnv9c1muAwPSxAE+szz4Pyo01IPJAyPVaRX1Eg1866eFgvyrQQmhoagb7Ai9zrr7Wlk8wHA3i5WsDzxYG5uHfwkdXOMofQmTzyTS7a+DgYoFthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgSwY/Xt; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4f9d61e7deso75703a12.2;
        Wed, 03 Sep 2025 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756923614; x=1757528414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LklR1axfAguady/UTzpPSQ/6MSRqKnTgXH9zey9jMY=;
        b=WgSwY/Xt8S93/Yn/p9UxNmDGYrL6sOwpX51YRHIgticgCAuCjolW5d1oAlzMc7Mydr
         DIEgYeTpHneFGLZZAjhc1tz3EM9cPBdg4cHiNQdRvS1LKDmozDUJw85/wIg9WPvYSsxM
         UoQmni1lsgPryTVBD8SV4sPxoBG8scfpjjfmvSEQoToG8egT3PeHZPNYuxCa0qad2qha
         zNoclL6eDdq2fgnQldsEgjaZ8EcMGTfoBYNf3Hn/MSY21yout1MxuNrusB22RHQb9/si
         TC3BWo9rmcjwjIeFPjjB2musLaUPJ/dnonEmBY5Nw2eh+5vEttpkfVlABu6PeosYKIBQ
         T4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756923614; x=1757528414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LklR1axfAguady/UTzpPSQ/6MSRqKnTgXH9zey9jMY=;
        b=QTPWtZiMBccBqUZ5GhBAgZ1Ups1TOC9AKuEeoY44/qzvFJknYx2PGJnm8stf4wvZSA
         JhK0++QeJyVuWkh/L9QBP2vF7gyjh286LU0h4N1JMU4z44SMO71qCwnOQAMyZfLfTC6/
         dGobgVKjeJZZk0un3dLx3yu9ILVFplqJtvGkYUcPcdsjPaPCW/f/+VYOFg/c/m0CEwkH
         HrfVfdFOjQaodtSCchP2oUqfAYwC8ynChaSI5uIOdbjtbURFJzZUO6XbBWZtPIN8prPK
         o0VtuI/SeZW/Mylh8wADlBanCnIjEZFVwepxYbPiigNLNsTLc/7GOT3/F8ksVxIQ2BMU
         k7fw==
X-Forwarded-Encrypted: i=1; AJvYcCVT3BEKWfJQYna8yCkQntaJCdKLOUoOx1xhfW7AM2WVHFV4gTzt3J3asTzaOMoza5iUSGzQE8jX71K+WX1f@vger.kernel.org, AJvYcCWFyQuf2dgKTBJco8Ucnv/4DJrGe2JYC7uncKLWcJaoKD+WJkEtRlLYyvrONLrRN5nxzfs=@vger.kernel.org, AJvYcCXFP1Rtx6+J8pPOX3hCzu2coCrHWBBk7aijDRMOnSsgrOvNDiEc+NMoc8nU8fb+5dO/tCtw54GAFv9r978x/ROFMBdT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+ZLHQP0khG3oBEfllt4pgHgY36CGVsZDsa0WmNQCurc6rHTK
	s55ZSkPwsuRm+C8/AExO1KI4wpejyKud2UlrRR6P2wygOxof8OltYswP0MJWtrK4mtG7BcK/MvO
	UKUXuCs3itw/FY/TmEYH/bDkuvxnwUcY=
X-Gm-Gg: ASbGncsf144mepK9LNn/N421fMV1t83CpeehVVPiTEK2RlKyOtUrFRbquJe8NEU5nBs
	F1pM9hD8cH9YCiU+jQ3Ntavnj/J3l2z5xn3tn1Ce96clxBp69Rm8GqxR5sKet77d5FET0T2SoNA
	0rbqXsiGYGmO5DjIj7lSO8CQuQKmuIv9Cpr9UFMpDoTfeYyBfSrazfn8DzkoNeXaOZepN///SXk
	XnUq77claLUVfN0owvtPjp1mEO0d7BrNg==
X-Google-Smtp-Source: AGHT+IFDckPXLt62/YVrwNa7YVFAXYaMU92lBDll278DpS343p7hIE9hmeIPdtlDUj823tk4D7pWm3Cv5GFyPELW2gM=
X-Received: by 2002:a17:902:ecc1:b0:24c:b54e:bf0a with SMTP id
 d9443c01a7336-24cb54ec1c4mr12662195ad.0.1756923613755; Wed, 03 Sep 2025
 11:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902143504.1224726-1-jolsa@kernel.org> <20250902143504.1224726-3-jolsa@kernel.org>
 <20250903112648.GC18799@redhat.com>
In-Reply-To: <20250903112648.GC18799@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Sep 2025 11:20:01 -0700
X-Gm-Features: Ac12FXy4s2geNOmLCONj1osd11jEfHmKme1TYgq3LHbeuSWAD6nNQwo2SGjYqPA
Message-ID: <CAEf4BzZ87DAtQSKOOLjADP3C7_4FwNw6iZr_OKYtPNO=RqFAjQ@mail.gmail.com>
Subject: Re: [PATCH perf/core 02/11] uprobes: Skip emulate/sstep on unique
 uprobe when ip is changed
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:28=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 09/02, Jiri Olsa wrote:
> >
> > If user decided to take execution elsewhere, it makes little sense
> > to execute the original instruction, so let's skip it.
>
> Exactly.
>
> So why do we need all these "is_unique" complications? Only a single

I second this. This whole is_unique flag just seems like an
unnecessary thing that spills all around (extra kernel and libbpf
flags/APIs), and it's all just not to confuse the second uprobe
attached? Let's just allow uprobes to override user registers and
handle IP change on kernel side (as unlikely() check)?

> is_unique/exclusive consumer can change regs->ip, so I guess handle_swbp(=
)
> can just do
>
>         handler_chain(uprobe, regs);
>         if (instruction_pointer(regs) !=3D bp_vaddr)
>                 goto out;
>
>
> > Allowing this
> > behaviour only for uprobe with unique consumer attached.
>
> But if a non-exclusive consumer changes regs->ip, we have a problem
> anyway, right?
>
> We can probably add something like
>
>                 rc =3D uc->handler(uc, regs, &cookie);
>         +       WARN_ON(!uc->is_unique && instruction_pointer(regs) !=3D =
bp_vaddr);
>
> into handler_chain(), although I don't think this is needed.
>
> Oleg.
>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/events/uprobes.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index b9b088f7333a..da8291941c6b 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2568,7 +2568,7 @@ static bool ignore_ret_handler(int rc)
> >       return rc =3D=3D UPROBE_HANDLER_REMOVE || rc =3D=3D UPROBE_HANDLE=
R_IGNORE;
> >  }
> >
> > -static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> > +static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs,=
 bool *is_unique)
> >  {
> >       struct uprobe_consumer *uc;
> >       bool has_consumers =3D false, remove =3D true;
> > @@ -2582,6 +2582,9 @@ static void handler_chain(struct uprobe *uprobe, =
struct pt_regs *regs)
> >               __u64 cookie =3D 0;
> >               int rc =3D 0;
> >
> > +             if (is_unique)
> > +                     *is_unique |=3D uc->is_unique;
> > +
> >               if (uc->handler) {
> >                       rc =3D uc->handler(uc, regs, &cookie);
> >                       WARN(rc < 0 || rc > 2,
> > @@ -2735,6 +2738,7 @@ static void handle_swbp(struct pt_regs *regs)
> >  {
> >       struct uprobe *uprobe;
> >       unsigned long bp_vaddr;
> > +     bool is_unique =3D false;
> >       int is_swbp;
> >
> >       bp_vaddr =3D uprobe_get_swbp_addr(regs);
> > @@ -2789,7 +2793,10 @@ static void handle_swbp(struct pt_regs *regs)
> >       if (arch_uprobe_ignore(&uprobe->arch, regs))
> >               goto out;
> >
> > -     handler_chain(uprobe, regs);
> > +     handler_chain(uprobe, regs, &is_unique);
> > +
> > +     if (is_unique && instruction_pointer(regs) !=3D bp_vaddr)
> > +             goto out;
> >
> >       /* Try to optimize after first hit. */
> >       arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> > @@ -2819,7 +2826,7 @@ void handle_syscall_uprobe(struct pt_regs *regs, =
unsigned long bp_vaddr)
> >               return;
> >       if (arch_uprobe_ignore(&uprobe->arch, regs))
> >               return;
> > -     handler_chain(uprobe, regs);
> > +     handler_chain(uprobe, regs, NULL);
> >  }
> >
> >  /*
> > --
> > 2.51.0
> >
>

