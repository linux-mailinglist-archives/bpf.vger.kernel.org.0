Return-Path: <bpf+bounces-71656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE7EBF98F8
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 03:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8500119C7495
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 01:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C5C13A258;
	Wed, 22 Oct 2025 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDCIcUu9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6419A86340
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 01:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761095122; cv=none; b=NIwJ7r4UdJrSKPsbtA9HMMREUQc10kfI/9Cn7UCoRBQTXs7IZUX7YaxPR06HnPN3oxRNtEyWKTfB5niOPibPHkkx4SgMhj1j98fhc4zbp+crW0QpLv87kmm47RpYLt4MFXpnDuWlF1B0CHEr7IOErLVLZKho1RiK3gDOMpE5dXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761095122; c=relaxed/simple;
	bh=4rmLUQu1le5r8D+swi25K4jEmqaVPWc7lJ6PHq6tcyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ishtiKzqH96KYSolga5uQVoWh+nw6YBGdAzLsgQCkNK7DTNopiwOSvkrs7JuK9dJ6C/kgEGjuXkDX5qmw15NeRopJXmIFEEj8poWFRoaoyNNzkgj9Od1eu0ksrYcCPEgdKkSnEFOsVgLAUITNg4t/FzoZeqeCr8YwomiFvfdhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDCIcUu9; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-63e1e1bf882so4646421d50.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 18:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761095119; x=1761699919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpBWUMQUyNYztr0Z+6+lgRKFyM4PGQRNG3RtejXI1dQ=;
        b=HDCIcUu9l4Uhbwu7zyX3X3VuVKCyI+HKGSp+LI2xNLz2NFyfdscIQyW79bnFihm5DG
         z1suO+SaaItuy4Hq2UCxlO7iyTb/+ayXNTFxxvuLWpI0j6DOx1QxjufvksL7ImfSD2Z8
         96S2x+n9F7eUFdKsVsaO9Zv59SiqrmJbXaoSSzRmYoCWuR//TW8kRR2oQeHyP/cINZ+B
         He3v3uo6tWAnxRwUwX9IME4SQqMIvZKpUwxvsfzIx3UlY0Hrdf2qfgkFPXn6RMeKLPsS
         bEztIWcL7Ctf9ulY2Zgbs7SpXq52QX8ysVLQ4QAHdayRVZasehc2+Smw3CWM3iFayeoY
         m5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761095119; x=1761699919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpBWUMQUyNYztr0Z+6+lgRKFyM4PGQRNG3RtejXI1dQ=;
        b=ST2Gmjiv1tYVF3sijHOXwagksKHoLyFtg7XLnQCwbgIT7L5Y/xumgo3TmxYHzHPaPY
         7yEnYf6pgB1bqCW82W8G2qeIp6Pm0ZVTc5YsWGomIMyVZAxfBxFgjjJhbq5Xhhf/hOwa
         bQs1hL9FXXhNxPIQdCmG+XO8RNg2fc5LOlQQyILRtU1NzSFJ10YQbK0aPxrTlHZeZlDW
         Q5k6JpbCz6+EemZrnbk3uVyw8ECpdsg8Rw/A6T8tbfadkliEcXq1+XsQsa0v8TJ7yEiS
         WCN2u46zskncMmnlusuu5jz7B/gJy+go8PK7XjfNwBMYEPYxV4u9oFdRirW3DkSAC7/D
         WWAg==
X-Forwarded-Encrypted: i=1; AJvYcCXr6SnfXJ3/ACrmRmpdac5Nix1Qi7CPDco2oy7gm+VASsb4LIkqSX0lGNUdtKzKWmqlLAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsucXf0O2KAmSqLj/M4G8QH/qMKFjonvpQ2kwWW7lYW0wBfhaH
	34ya1xVl0ElNYl62wFmENZvF39dOULf32sMjNcojsi26Zub1OFySJh0Le1E7Wp6xwtz7pRaG4aE
	wemPZqub1VbfPji5i/sZYm2plQtyWwV4=
X-Gm-Gg: ASbGncs8lDeyl+df4O2Q5QGvdMHY+9wxuhznQXpSVVmetmnDpEX721l9XyQL2rCAKHN
	m113OhW7cjbvUZoPhLKx6Z7HYFRSLCsmF3cOMBlpw04h/ZeKaD3/Qb1/AlhxQNyyujishIZHtow
	yEEG9mJc6RDhS7WOPIiQ91ryH8qhrvKogeGku7JKNA0AH9oIgHj43xIy263EYWc1tqBpfrQAQpm
	R9vF5NzlOpUyb1A1w9WHb/Gd/4Wn76t1F35ctigP/a6fRN8jqtRtmD0tDtY0myr9MRL7Zs=
X-Google-Smtp-Source: AGHT+IF3FvmioM9BLiSXPvFefJ9mFTLeZP3TQOzmbGHlmIBl0/JtWtAgQ/j9lUo1B1DPYzFjyNFxiVtADeI/nOfgO0Y=
X-Received: by 2002:a05:690c:6204:b0:722:7a7f:537a with SMTP id
 00721157ae682-783b02e8f85mr264235697b3.38.1761095119351; Tue, 21 Oct 2025
 18:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
 <20251018142124.783206-4-dongml2@chinatelecom.cn> <CAADnVQLN96WZd0eWWb=__62g49y_wPfjTPKXaB_=o5jdVE7uKQ@mail.gmail.com>
In-Reply-To: <CAADnVQLN96WZd0eWWb=__62g49y_wPfjTPKXaB_=o5jdVE7uKQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 22 Oct 2025 09:05:08 +0800
X-Gm-Features: AS18NWBvheWbnEYFkDqoW2scTpYlV2lsYeAzkOkH1tIPcoLNZoG6fvzq48EGweo
Message-ID: <CADxym3ad72C+0D2AMDp799-zmLO-f2TG1+Xtbu-72Jv6LSzwSg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/5] bpf,x86: add tracing session supporting
 for x86_64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 2:17=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Oct 18, 2025 at 7:21=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >  /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> >  #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)    \
> >         __LOAD_TCC_PTR(-round_up(stack, 8) - 8)
> > @@ -3179,8 +3270,10 @@ static int __arch_prepare_bpf_trampoline(struct =
bpf_tramp_image *im, void *rw_im
> >                                          void *func_addr)
> >  {
> >         int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
> > -       int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rb=
x_off;
> > +       int regs_off, nregs_off, session_off, ip_off, run_ctx_off,
> > +           arg_stack_off, rbx_off;
> >         struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
> > +       struct bpf_tramp_links *session =3D &tlinks[BPF_TRAMP_SESSION];
> >         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
> >         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_R=
ETURN];
> >         void *orig_call =3D func_addr;
> > @@ -3222,6 +3315,8 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
> >          *
> >          * RBP - nregs_off [ regs count      ]  always
> >          *
> > +        * RBP - session_off [ session flags ] tracing session
> > +        *
> >          * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
> >          *
> >          * RBP - rbx_off   [ rbx value       ]  always
> > @@ -3246,6 +3341,8 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
> >         /* regs count  */
> >         stack_size +=3D 8;
> >         nregs_off =3D stack_size;
> > +       stack_size +=3D 8;
> > +       session_off =3D stack_size;
>
> Unconditional stack increase? :(

Ah, it should be conditional increase and I made a mistake here,
which will be fixed in the V2.

In fact, we can't add the session stuff here. Once we make it
conditional increase, we can't tell the location of "ip" in
bpf_get_func_ip() anymore, as we can't tell if session stuff exist
in bpf_get_func_ip().

Several solution that I come up:

1. reuse the nregs_off. It's 8-bytes, but 1-byte is enough for it.
Therefore, we can store some metadata flags to the high 7-bytes
of it, such as "SESSION_EXIST" or "IP_OFFSET". And then,
we can get the offset of the ip in bpf_get_func_ip().
It works, but it will make the code more confusing.

2. Introduce a bpf_tramp_session_run_ctx:
struct bpf_tramp_session_run_ctx {
  struct bpf_tramp_run_ctx;
  __u64 session_flags;
  __u64 session_cookie;
}
If the session exist, use the bpf_tramp_session_run_ctx in the
trampoline.
It work and simple.

3. Add the session stuff to the tail of the context, which means
after the "return value". And the stack will become this:
session cookie -> 8-bytes if session
session flags   -> 8-bytes if session
return value     -> 8-bytes
argN
.....
arg1

Both method 2 and method 3 work and simple, and I decide use
the method 3 in the V2.

Thanks!
Menglong Dong

