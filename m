Return-Path: <bpf+bounces-74625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9553AC5FE3A
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 4953124151
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200751F37D3;
	Sat, 15 Nov 2025 02:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt+NTtak"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B81E7C12
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763173595; cv=none; b=k5yxOrO6qphOhA8qCZUUe8wRRJTDZrYykz8ZJcpHjruM0xeoh8RWTh4WfchwpxL5i1DYJhalAWwPKzlUs7JPiwPYWCj6RFwSXZ2xI3DuK4WISc6xnSL6/vQUIvh2cyMB6HaAj8Zm9jBUHw6Z3CSV5ca/+1fHNbPtM/nO7kkGS1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763173595; c=relaxed/simple;
	bh=w/K6RurYyjKwDb9uwr75l06xBH4l2DKlYqRmxHlI2jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQ3Uzn589hYCzyz8OALoyfE0s7XDyjEl6IzuBlsm53gjNzhwhrJctkGgoC5gIRhSub7d5pp3dPbavxPvwuyGMD3YaG+KBbAxnDel2JHd3dmJwkpg1Z2/r5Dqfai98EFcfCwJmiep+IpwpxvB30+cpW5wgOVveB0nMoHFt2fjH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mt+NTtak; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-641e9422473so1264736d50.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763173593; x=1763778393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p8fQmw3Qlh03PwyHgF0UmpBDAFUeZSS6CX7+CeIrVQ=;
        b=Mt+NTtak+2wk/3nn5F5N0ECx2AmVbISF7N1MbYhhhNAJlhBgsHUZy0y+DBbmwrwU9o
         gTrzHBQKxGuGOpzuk/RAXigCmQCdphMcEW5YGodLKEzCO2YRmiOgLrNc59F6n9RH0hT+
         hFrn15UjIrFalQSDTLQA3NeVBp/bi66aWE+UyQ9fGD0/fGPhyWaRH1rC7S8+tHmaXmdW
         38u3r+Lo1w7A8Nm1Ienq12kVsjC2+iUKctVdTpfg0jyR46AtS0imb6SPeEuVZhJvUXxz
         pB2sH1ClItAXxES1YLrTEyhozhd5frWs0OQGQv7XBK1XIkCn+cuvKT8aXhVVXhVXAfb1
         /s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763173593; x=1763778393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4p8fQmw3Qlh03PwyHgF0UmpBDAFUeZSS6CX7+CeIrVQ=;
        b=peeWl4am4CZ/k09M4vDCzd4H62lK+Tulvxb1BOF8gku3l1b0T/jSgZ2MWB6fa4cJTl
         u0tMxeGRfMJnMPmDBji/GscMZXMosPHOJG2NHVWhwzsYII2tKqWVh/763/9aN1xM28Nt
         Ov1q67VM+lFOFrM3TYWMfKSo1cI6KyJP8P6q1G5h27+GrZN/dr9qmYx9TYrL99ofvOxm
         vbsC61+hPk3yurlVuCLSLqeE+hZ8a0DkXoyZof5r4AIYTsPnkAjlytrM90NALT6ezmay
         mAJVgWp+Ryw//+Uo9j+6bIhqW+S7C/j/1T8t09vJl+AEEs0Hkq/q2j5uKuQ0HAqcsaZZ
         fR6A==
X-Forwarded-Encrypted: i=1; AJvYcCX5DokN+HBkquCt9nuU29InOVmiZ5N3iImv0VS8K4gogZ9RS/FTuNCtxrtWFxnV5wNqfvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ10QNLffYEgr5pzDSWQq4/3sSk6HajXxjl9zXLWvKJktW5eL5
	45gc6J21ioNac7iVl8gqoguDO3Skj9uS7WcPeDN6pwJ0yVtVOEdpcPBf8qHjk+em/XyucLBnIUZ
	lSxMZnGL7HRxJ4kEcgUwM2jCzUXdXeE0=
X-Gm-Gg: ASbGnct202FvDjnC9mI/Iqi+XfkE87SUbRmm7cqyb/Y25s0ZVZZR45SQItQxgxttBQH
	FAx8fz6hFYsofmQ/LzVZlJH2AflYVdevKIlLSAKDMwdOPFAEJlXjAtlpz/pDLc124RBUhbVeoQ4
	tM8/qtEWwrHvNI753U42xprnYc8kA9CSeurhXggIGqOajeQYVqx/s/oVlb9NHzKebNl/9oMwRBQ
	nbTJqdmZoz5Sy+1qNbGiPTwdldxBcF23wxiAk/3vxh/cvW4A+UCAA9jdS1mp8yPuVQdgUA=
X-Google-Smtp-Source: AGHT+IHvm41JAhUDEbyWTid8WkjAehWDnQr8gxbsk25b0U+TU9Sap7KQD49QTdx/V9RytVZkc+BiLTIzprFbrokBkLo=
X-Received: by 2002:a05:690c:4882:b0:787:c849:6554 with SMTP id
 00721157ae682-78929dff3e2mr94246947b3.13.1763173593065; Fri, 14 Nov 2025
 18:26:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
 <20251114092450.172024-6-dongml2@chinatelecom.cn> <CAADnVQLemtF-m5et+c5pWppNZoWnWBehtMCHVJU9Yagvi+dRZA@mail.gmail.com>
In-Reply-To: <CAADnVQLemtF-m5et+c5pWppNZoWnWBehtMCHVJU9Yagvi+dRZA@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 15 Nov 2025 10:26:22 +0800
X-Gm-Features: AWmQ_bmbzoRUinc7PMPnzhciwmLUmNSoyFDnepiHxuuzmLIwO33uSziHm1ylXkk
Message-ID: <CADxym3a3UCgW1ukK_VZEfqM6YvPT1ZAE=Wd52oq1FhHwdhf4Cg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 5/7] bpf: introduce bpf_arch_text_poke_type
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

On Sat, Nov 15, 2025 at 2:42=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 14, 2025 at 1:25=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Introduce the function bpf_arch_text_poke_type(), which is able to spec=
ify
> > both the current and new opcode. If it is not implemented by the arch,
> > bpf_arch_text_poke() will be called directly if the current opcode is t=
he
> > same as the new one. Otherwise, -EOPNOTSUPP will be returned.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  include/linux/bpf.h |  4 ++++
> >  kernel/bpf/core.c   | 10 ++++++++++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index d65a71042aa3..aec7c65539f5 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3711,6 +3711,10 @@ enum bpf_text_poke_type {
> >         BPF_MOD_JUMP,
> >  };
> >
> > +int bpf_arch_text_poke_type(void *ip, enum bpf_text_poke_type old_t,
> > +                           enum bpf_text_poke_type new_t, void *addr1,
> > +                           void *addr2);
> > +
>
> Instead of adding a new helper, I think, it's cleaner to change
> the existing bpf_arch_text_poke() across all archs in one patch,
> and also do:
>
> enum bpf_text_poke_type {
> +       BPF_MOD_NOP,
>         BPF_MOD_CALL,
>         BPF_MOD_JUMP,
> };
>
> and use that instead of addr[12] =3D !NULL to indicate
> the transition.
>
> The callsites will be easier to read when they will look like:
> bpf_arch_text_poke(ip, BPF_MOD_CALL, BPF_MOD_CALL, old_addr, new_addr);
>
> bpf_arch_text_poke(ip, BPF_MOD_NOP, BPF_MOD_CALL, NULL, new_addr);
>
> bpf_arch_text_poke(ip, BPF_MOD_JMP, BPF_MOD_CALL, old_addr, new_addr);

Yeah, much clearer. The new helper also makes me feel a bit
dizzy.

Thanks!
Menglong Dong

