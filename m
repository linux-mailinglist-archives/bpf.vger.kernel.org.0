Return-Path: <bpf+bounces-74620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1560BC5FDEB
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6332C4E3345
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF741F099C;
	Sat, 15 Nov 2025 02:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5RhoKE7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53651E3DE8
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172858; cv=none; b=dAqsvjjbEo883CHaBsn2FzMyfmNRJB3gD9zbK9czNTdb+a8QIXh0rjdI+wuv/QkyWHFuA4bKsNtI8BngHPAeJsi9b8edbJEuizZUA6YLr0nP/SY6zv/5TFpvcLJLrO2xYT6Nj9MwWl6K9XqnAM5LwxWnYVhdgCzxMX1ssCpvFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172858; c=relaxed/simple;
	bh=+m60YjmlqfTe/IuZN5tAdQGIgUv5mVLfsgQlL5jkVv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NV53weeFZb8t060u1jZqIUctwtkH7mU8i1i0nbFBcA6RQy4UEXbXYnoapNGJZ73u3NlJgWRE/bK7EOoo2vpsF9T+OT2Z/pn3pEh3rHJQ9SW3baZQIF/FEqXD1/7eVus80LxwBxSAyGdqPvHbzr/ax6FkN30W74uZka158IUmpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5RhoKE7; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-71d60157747so22365087b3.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763172855; x=1763777655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypHiODfqvhtjR5/PkxQuREAV0OnJoKZAgpPoPF8g7XE=;
        b=d5RhoKE71EvY/GvQ5qoLPGGwvDUhC/FaB5XvD83vY9VbJ8Eg6jT7yS5xF6Mx/Ub2s5
         iiGi2g2MsBSJUfUNqEzyjRyGl4oKwvVj+D7Xge8q3dN9+oo5v0L7dCVIlyyDIjbb4+pE
         TP0ynqwRelOlCABnqmPtcpXk20nfSISfEovS/XIe0Zm5M/0guN4vabWSR+pt1u1ZZ1Bv
         ywdWhstZkvlI7trMcHe929GJBpFwiHMoIOWK0HLrlcwKrZS5Wpjob+PfmeQx1w4jR2i8
         hFftyu+eb+WxTgwoAXrz+55zmI8a1XnfhkJ+Anm8vhreOOiN5FKberr9RryFUtVPc7yd
         G0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763172855; x=1763777655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ypHiODfqvhtjR5/PkxQuREAV0OnJoKZAgpPoPF8g7XE=;
        b=Ttlf4VBnbueXHW5SHRsSvtg8owVjh0JJkeVhuJPbo6ut6+0C9Chu1yfrtPPpW4m0mx
         1SfiIK11HW2Hj23LtJFXEX++dahlAp7Qsj/c5TvxO2BQUmD25WoPTUATOXu0lp0hCnTz
         GorjN+XbAr+zzZM7PVqXfxUoVXwq7BdnH1QqI4AbQpSGF89Spy+7QU8Rwxg86ZEODoi4
         ySQC4/pdwRK/AV7vk/3zVMbskhQ3KONoH+TfGyzg/RdvO+iK01efF3wVo6UIrcS4Ezqc
         q+AUQ6onZ+apCxdqLkYIOETTklIwQzjlwURYKrBFJ53ESTSudvKhThc+eOHrzjRWE56P
         AK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwk5gQCN11NB/tfIF/LdCBGroBh4tjtOJEMec3PtiblY7U/AuVhIzkvAbyqRPDMpltI1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLI0LT4Bqzxtih725NNl4Cue34J3XSFV7tzzcbenUGCP2LwnTL
	YibfwKAAOaDGQK1kZcdqNxAz+1kIwcDCBnwS6ZZLFAPPeiwTjLjro+UpDYgzH9r0+ZElJYG39Ds
	/9q5ivThiKVqdwWyUc0pBpFGWrz0GCBA=
X-Gm-Gg: ASbGncvzrbekPDhLwmcfNWR6HA+MU3pbsz+6UV3R+9buSp2m+M+0fOll6EZvHVPMpAX
	smezb/D0rBP4uYjvzph4FExVChWeGoq/rcGKPpfwtMw0iTbZfsJU767jUR6dH+Rfefz20t9tEvy
	eJWe6SoJ3mZAh4yDOPWJsR0LJuUK+4C2fBCXI5A5lIzAzKvYXSL63LJU2tqJY71VCMPQWNmPW/s
	0GnqGyjVtyRiVJboyArOMii3OAMoNvBeJLXCEdCRjFHwV6uaCswlmnlqtvo81dIeOgveig=
X-Google-Smtp-Source: AGHT+IEZRehbbAVxb6HJsyS6vM8ac8eTWfXaOWmpx2XOFR03rskBetT5Bdil02SpZoBr41srGSaazYv3kD+abX5VVjc=
X-Received: by 2002:a05:690c:e3ca:b0:786:8adb:8ae with SMTP id
 00721157ae682-78929ed9753mr49681907b3.44.1763172854859; Fri, 14 Nov 2025
 18:14:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
 <20251114092450.172024-5-dongml2@chinatelecom.cn> <CAADnVQJU39q9amZMuVLzsg7CK5MLT_xFr0K4Bx9zp7P5C6MCRw@mail.gmail.com>
In-Reply-To: <CAADnVQJU39q9amZMuVLzsg7CK5MLT_xFr0K4Bx9zp7P5C6MCRw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 15 Nov 2025 10:14:03 +0800
X-Gm-Features: AWmQ_bn9NAseH0LF8VNiBXBHj2voVilxDIw4c6Woqc_dG2KzsnEmofP3sbNmqAU
Message-ID: <CADxym3agZw6yzDdwpxYnRmzvT_R9aAQyML5_DGW-AknciB2Ceg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 4/7] bpf,x86: adjust the "jmp" mode for bpf trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 2:22=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 14, 2025 at 1:25=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > In the origin call case, if BPF_TRAMP_F_SKIP_FRAME is not set, it means
> > that the trampoline is not called, but "jmp".
> >
> > Introduce the function bpf_trampoline_need_jmp() to check if the
> > trampoline is in "jmp" mode.
> >
> > Do some adjustment on the "jmp" mode for the x86_64. The main adjustmen=
t
> > that we make is for the stack parameter passing case, as the stack
> > alignment logic changes in the "jmp" mode without the "rip". What's mor=
e,
> > the location of the parameters on the stack also changes.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 15 ++++++++++-----
> >  include/linux/bpf.h         | 12 ++++++++++++
> >  2 files changed, 22 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 2d300ab37cdd..21ce2b8457ec 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2830,7 +2830,7 @@ static int get_nr_used_regs(const struct btf_func=
_model *m)
> >  }
> >
> >  static void save_args(const struct btf_func_model *m, u8 **prog,
> > -                     int stack_size, bool for_call_origin)
> > +                     int stack_size, bool for_call_origin, bool jmp)
>
> I have an allergy to bool args.
>
> Please pass flags and do
> boll jmp_based_tramp =3D bpf_trampoline_uses_jmp(flags);

Ok, I'll do this way in the next patch.

>
> I think bpf_trampoline_uses_jmp() is more descriptive than
> bpf_trampoline_need_jmp().

ACK.

>
> The actual math lgtm.

