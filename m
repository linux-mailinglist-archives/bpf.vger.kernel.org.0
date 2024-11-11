Return-Path: <bpf+bounces-44549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293489C48A0
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 22:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB7828B653
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 21:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA3E1BC070;
	Mon, 11 Nov 2024 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3mwwS1V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80438F83
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362212; cv=none; b=UduEj9+w8NkK3p56qUP97eV7V2aF1RR8RtImNqKXNZweUl5bpeHJZt8rGbxa+BZ1N8OCXym4XGk9FxVPJCZBR/QAvTX93UCsa352wYiEK7e20N2/CqftnksyTP2sdwN+VM+H30gYBUG4NJXEG8BqdjOatYa9lzujjUa8ynPRe2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362212; c=relaxed/simple;
	bh=tu+tazk7weyrW+K+AUYWppRBr8SEkdiek60cKYjeZQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffEeZAB5tabJfFHha3dVI7Vqkt8ssdWCbPzt1ebqxeBiApTnRAcxDuT1W3n3HMSY1vegfW2UGUdEEQF0tcvU8m/MNBQ1kqiHipQUL0pZnbiaze2GzhEzqCjqr9WtAW/XsCJiwROPP5KglZDMpiYk3aftrlZr3UR1M116WclONdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3mwwS1V; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7f45ab88e7fso1041328a12.1
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 13:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731362211; x=1731967011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPMbnNkaBRi2VBHJIdApz5jb3wL93NKTMZwxPhML3XE=;
        b=E3mwwS1VOToI3v035rAX6Ln1bpRRu1GqSi56jCRn+WGfeqT4gEgyX4LnUCKlQyhA16
         rk3knWE+hkc1DyUdN9ofaa8BxYPxhmKUxV7Mr1f4u2eDPdoWatMfzt6+OvKY4O8APRFz
         geEx2p7InIATmUxxjRzvEsVMjwtYD2lUBGfw/qfxorEm1Z7onNojs7ElqKlOvYshEiGy
         FGKpPIlGTa6z01yYWbdCgsGQqeR9VItyFQL0fQXkTRIhJ47RJTK0tyxXqUVx5DMaT+wI
         t9O+dD8NjKz6CQl8RLRyxf45fR0wGQ3V4yFG36VTBnjGCoLDS20SKvaBbs7ojKOXvJ/w
         Wk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731362211; x=1731967011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPMbnNkaBRi2VBHJIdApz5jb3wL93NKTMZwxPhML3XE=;
        b=B5YK77Q1IC7QiEGb1bryN3c6L38DiBUaZiBRq76+KEBI1ujdoDfFNGgysjA6T2vOBW
         V5dt3KJsjMGSfwqV0vVzJzo0Y4qXO4BAtWQdNLCJuSts1QnMAtghu18EK4Uuxp5SUCl5
         h2COsMILVPsef8AhZ+K45sjHGsIVPOryPx53ldCDpMRXLPakL3uRCLU+0fqF5/ZK0X79
         JBXFFV6aHotp7wxkEbunbhUhKxYhSR17w3RuY4jH7AjIPM0ti84NgcwwUQzvNCvsgda+
         7xFYoaBWl5h+iVJzpa9xnLztRQtc0sapdDOfh4JKgVd03rD/ZIhPCl7wvf4HJ+Ww8PXu
         ITYg==
X-Forwarded-Encrypted: i=1; AJvYcCVVm8oI+29GrpAvFGupIwpWYarFae+xOXvO0ym+FlkzJsgRmwYdjpUK9Ajv1lzah7b8cpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtnMSjY+lK7MIeq1Nrd4QduE5IOrvPRR1LxcZ9VXtUUPk/3LQJ
	ladsi+qvjDFMNwJ+uqFXQRt/NWfjE1OsBNueuCIBHPKGBHhyAQJuMaqYOT+lYN4qnnqOL0GTZKr
	A9Xy8sEXocwBlylf89qOZ5qHNvao=
X-Google-Smtp-Source: AGHT+IH7xUjlRjXWoio/G/hpcbIUqqkiqDGPqHYMwzUpUdCoxzxZNwCT9FmFA7Ba0I+tfyWtvDZ1tacuishcv76GxEk=
X-Received: by 2002:a17:90b:224f:b0:2e2:da6e:8807 with SMTP id
 98e67ed59e1d1-2e9b177fc52mr19443905a91.26.1731362210817; Mon, 11 Nov 2024
 13:56:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030235057.1984848-1-andrii@kernel.org> <CAADnVQ+pShXOS9WnDSA5CjrGvNRC7NS-MQrgr_X_Obo5zLs8yA@mail.gmail.com>
 <CAEf4BzZMObcOs5NzHqY-v3scjv7zHL2oKf=zn36LsAXhYuwn8Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZMObcOs5NzHqY-v3scjv7zHL2oKf=zn36LsAXhYuwn8Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Nov 2024 13:56:39 -0800
Message-ID: <CAEf4BzYks_vSzoYMxSCED=kTJ6n9WHY5daJTwPam6KXaWv0feg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: use common instruction history across all states
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 1:53=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Nov 11, 2024 at 10:46=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Oct 30, 2024 at 4:51=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > > Async callback state enqueing, while logically detached from parent
> >
> > typo. enqueuing
>
> yep, tricky word :) should be "enqueueing", fixed
>
> >
> > > -static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
> > > -                            u32 *history)
> > > +static int get_prev_insn_idx(const struct bpf_verifier_env *env,
> > > +                            struct bpf_verifier_state *st,
> > > +                            int insn_idx, u32 hist_start, u32 *hist_=
endp)
> > >  {
> > > -       u32 cnt =3D *history;
> > > +       u32 hist_end =3D *hist_endp;
> > > +       u32 cnt =3D hist_end - hist_start;
> > >
> > > -       if (i =3D=3D st->first_insn_idx) {
> > > +       if (insn_idx =3D=3D st->first_insn_idx) {
> > >                 if (cnt =3D=3D 0)
> > >                         return -ENOENT;
> > > -               if (cnt =3D=3D 1 && st->jmp_history[0].idx =3D=3D i)
> > > +               if (cnt =3D=3D 1 && env->insn_hist[hist_end - 1].idx =
=3D=3D insn_idx)
> > >                         return -ENOENT;
> > >         }
> >
> > I think the above bit would be easier to understand if it was
> > env->insn_hist[hist_start].
> >
> > When cnt=3D=3D1 it's the same as hist_end-1, but it took me more time
> > to grok that part. With [hist_start] would have been easier.
> > Not a big deal.
>
> yep, I agree. Originally I didn't pass hist_start directly, so I would
> have to use st->insn_hist_start, and it felt too verbose. But now
> that's not a problem, I'll use hist_start everywhere.
>
> >
> > Another minor suggestion...
> > wouldn't it be cleaner to take hist_start/end from 'st' both
> > in get_prev_insn_idx() and in get_insn_hist_entry() ?
> >
> > So that __mark_chain_precision() doesn't need to reach out into
> > details of 'st' just to pass hist_start/end values into other helpers.
>
> Note that for get_prev_insn_idx() we modify (but only locally!)
> hist_end, as we process instruction history for the currently
> processed state (we do a virtual stack pop for each entry). So we
> can't just use st->insn_hist_end, we need a local copy for hist_end
> that will be updated without touching the actual insn_hist_end. That's
> the reason I have `u32 hist_end =3D st->insn_hist_end;`, to pass
> &hist_end into get_prev_insn_idx().
>
> Having said that, if you prefer, I can fetch insn_hist_{start, end}
> from st, always, but then maintain local hist_cnt as input argument
> for get_insn_hist_enrty() and in/out argument for get_prev_insn_idx().
> Would you prefer that? something like below:
>

Argh, gmail messed this up. See [0] for better formatting.

  [0] https://gist.github.com/anakryiko/25228b0ae2760f78b7ae7f0160faa5c1

