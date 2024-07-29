Return-Path: <bpf+bounces-35947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 749B993FFFD
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 23:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994EB1C20CDA
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 21:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ADF18D4B0;
	Mon, 29 Jul 2024 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kT/len8Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2736812C544;
	Mon, 29 Jul 2024 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286895; cv=none; b=ASbTEiojrk6qvskLHxgFEWB2AY5EBjMwIqVhdmsBTnHFuVldQO17IfkWWfWfjrsEqMlBMiUWmmZahTkFkLydIEo3dYneD4KQLqEIX0s2c8mem7HBEVQTjtX/bG4RbaSMuN9PrSlK/ElEfB1rtNzquownffLC23wPovUXvIzdMy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286895; c=relaxed/simple;
	bh=BOUEnXkPMRlwVpTQj269rZKa7QeCPYZzdLGNims2HEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeENvJ2605rSv2wkwJE/MboClPM2PBdIDRfJXyqgCFiRyelHdhjhJRsWk/V+lKn1AOnL7qVFoqc+y0SEY27gG/ygdWxyLNSrRMjFfNFiP27fltXJvkX678QF/jknO8vJLHEbjwro0CsODm/Mhwiu/uEFR3lvX7+OWz2wHcPmctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kT/len8Q; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cd48ad7f0dso2946144a91.0;
        Mon, 29 Jul 2024 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722286893; x=1722891693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g54ywdmfOyPSY/M415ayVdZba31QR2jYtMD9H8HjLE0=;
        b=kT/len8QfmatShHgFfU32ijAgER9UQq6BTtmd+RdqhM4J4yH5uIUQBPLt4E8+uhrPB
         SDS5elaP+KtajZ4PZ3dkIYbIUBCUq7ZKOzm6sh19/4HUo+Z6XJgH4EDkL/JUyRgt76Li
         oZgnKPPKWuN7j1JjoYh/9AwuSVFjZ+FPD/bz/BFjpUEvS6QPSTSMKdezH3Y3x46LI4XG
         6iM2XHQJSGRw++aq4f1+51bOj+QYMwyyp0RCmeqrafWM6xkmcOCEcGgJa/9+28NAf2EB
         mVnCIRFsGQnPuIit7eCZ+nuYNbBaKNnT79m+Vh63pzVoMgUlSwZ5CFc8WH6enoKzg/Ux
         VMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286893; x=1722891693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g54ywdmfOyPSY/M415ayVdZba31QR2jYtMD9H8HjLE0=;
        b=wsg5Dfuv/SMOPbCuSc2S/L0L6KLLRxNB+AV+SY6EGzzyYLLIXotgw5GLfPy7YLqu1z
         nqVQ56mKICzqGkW7KixYSjLMMi+7L3ucsVTj5AHL1Qtd751Xm8vkkeKCu+xSQefaLtxG
         BMnYzkloLXiL4iXOGM9oITosQLe6Ez8VzIMGT5jqHBAYUmXmvLTZB6plfSvXj5eADLg4
         b9P1bZ3JxhkwLD3qkNtzzSG8v46y/i6vl1iSu7CrCUFy5vKBL8O3f258sPtKpSU9jMbH
         yY/EHDpf5AiUXjVoEHfqI1hj+gAaaxSK0mPauW5fy5UcwW5yFwYWX1J6lCkR9IsSluA0
         5Q+g==
X-Forwarded-Encrypted: i=1; AJvYcCXw+/atKMOHNQAQLuAzhGUNIerSlj9KJ0BaycMWFNh45HRpPgSJdLlUy+73at/b1WYQxFKmW+eV/nwhZ1aMJ7VNIsAhCmy6L1a4I3BwqV1nbYOfmF0DG8NqtF9NCGxXszH5
X-Gm-Message-State: AOJu0YzWHZUBOLxLBwm1+ppgCEkbbqv1AYR9ZTTVL8kuWdi91yZkiaZ5
	lbJi1XWtSAYgzF8pp2xkpt8QTrjwwV9VRUeEGw3zXtz/dFMUNyA0NhzLi97hjbk4Fl2GeC4Tqdr
	Tkyk0BAkCWuxdEEJy5J/R02BrDFI=
X-Google-Smtp-Source: AGHT+IFo2iriVEFEvlWsYJOOc2NoY/3bOJDC3FtYYGb/9IPRlhizk/I7h00NlgV60mb0a7VRJ4Z0SAjmXp90TaeUPj0=
X-Received: by 2002:a17:90b:4f8e:b0:2c7:700e:e2b7 with SMTP id
 98e67ed59e1d1-2cf7e82cc77mr10858469a91.39.1722286893115; Mon, 29 Jul 2024
 14:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725051511.57112-1-me@manjusaka.me> <08e180da-e841-427d-bed6-3ba8d73e8519@linux.dev>
 <c7952df9-5830-45d3-89bb-b45f2b030e24@gmail.com> <6511ce2a-1c7d-497c-aeb6-d4f0b17271ed@linux.dev>
 <2c6b1737-0a96-44ed-afe9-655444121984@gmail.com> <CAEf4BzbL0xfdCEYmzfQ4qCWQxKJAK=TwsdS3k=L58AoVyObL3Q@mail.gmail.com>
 <0f5b7717-fad3-4c89-bacf-7a11baf7a9df@gmail.com> <CAEf4BzZCz+sLuAUF65SaHqPUemsUb0WBhAhLYoaAs54VfH1V2w@mail.gmail.com>
 <a1ba10df-b521-40f7-941f-ab94b1bf9890@gmail.com>
In-Reply-To: <a1ba10df-b521-40f7-941f-ab94b1bf9890@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Jul 2024 14:01:20 -0700
Message-ID: <CAEf4BzZhsQeDn8biUnt9WXt6RVcW_PPX76YFyZo6CjEXGKTdDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog
 method to output failure logs to kernel
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Zheao Li <me@manjusaka.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 9:04=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 2024/7/27 08:12, Andrii Nakryiko wrote:
> > On Thu, Jul 25, 2024 at 7:57=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com=
> wrote:
> >>
> >>
> >>
> >> On 26/7/24 05:27, Andrii Nakryiko wrote:
> >>> On Thu, Jul 25, 2024 at 12:33=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.=
com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 25/7/24 14:09, Yonghong Song wrote:
> >>>>>
> >>>>> On 7/24/24 11:05 PM, Leon Hwang wrote:
> >>>>>>
> >>>>>> On 25/7/24 13:54, Yonghong Song wrote:
> >>>>>>> On 7/24/24 10:15 PM, Zheao Li wrote:
> >>>>>>>> This is a v2 patch, previous Link:
> >>>>>>>> https://lore.kernel.org/bpf/20240724152521.20546-1-me@manjusaka.=
me/T/#u
> >>>>>>>>
> >>
> >> [SNI]
> >>
> >
> > [...]
> >
> >>>
> >>
> >> Build and run, sudo ./retsnoop -e verbose -e bpf_log -e
> >> bpf_verifier_vlog -e bpf_verifier_log_write -STA -v, here's the output=
:
> >>
> >>
> >> FUNCTION CALLS   RESULT  DURATION  ARGS
> >> --------------   ------  --------  ----
> >> =E2=86=94 bpf_log        [void]   1.350us  log=3DNULL fmt=3D'%s() is n=
ot a global
> >> function ' =3D(vararg)
> >>
> >> It's great to show arguments.
> >>
> >
> > Thanks for repro steps, they worked. Also, I just pushed latest
> > retsnoop version to Github that does support capturing vararg
> > arguments for printf-like functions. See full debugging log at [0],
> > but I basically did just two things:
> >
> > $ sudo retsnoop -e '*sys_bpf' --lbr -n freplace
> >
> > -n freplace filters by process name, to avoid the noise. I traced
> > bpf() syscall (*sys_bf), and I requested function call LBR (Last
> > Branch Record) stack. LBR showed that we have
> > bpf_prog_attach_check_attach_type() call, and then eventually we get
> > to bpf_log().
> >
> > So I then traced bpf_log (no --lbr this time, but I requested function
> > trace + arguments capture:
> >
> > $ sudo retsnoop -n freplace -e '*sys_bpf' -a bpf_log -TA
> >
> > 17:02:39.968302 -> 17:02:39.968307 TID/PID 2730863/2730855 (freplace/fr=
eplace):
> >
> > FUNCTION CALLS      RESULT     DURATION  ARGS
> > -----------------   ---------  --------  ----
> > =E2=86=92 __x64_sys_bpf
> > regs=3D&{.r15=3D2,.r14=3D0xc0000061c0,.bp=3D0xc00169f8a8,.bx=3D28,.r11=
=3D514,.ax=3D0xffffffffffffffda,.cx=3D0x404f4e,.dx=3D64,.si=3D0xc00169fa10=
=E2=80=A6
> >     =E2=86=92 __sys_bpf                          cmd=3D28
> > uattr=3D{{.kernel=3D0xc00169fa10,.user=3D0xc00169fa10}} size=3D64
> >         =E2=86=94 bpf_log   [void]      1.550us  log=3DNULL fmt=3D'%s()=
 is not a
> > global function ' vararg0=3D'stub_handler_static'
> >     =E2=86=90 __sys_bpf     [-EINVAL]   4.115us
> > =E2=86=90 __x64_sys_bpf     [-EINVAL]   5.467us
> >
> >
> > For __x64_sys_bpf that's struct pt_regs, which isn't that interesting,
> > but then we have:
> >
> > =E2=86=94 bpf_log   [void]      1.550us  log=3DNULL fmt=3D'%s() is not =
a global
> > function ' vararg0=3D'stub_handler_static'
>
> It's awesome to show vararg.
>
> >
> > Which showed format string and the argument passed to it:
> > 'stub_hanler_static' subprogram seems to be the problem here.
> >
> >
> > Anyways, tbh, for a problem like this, it's probably best to just
> > request a verbose log when doing the BPF_PROG_LOAD command. You can
> > *normally* use veristat tool to get that easily, if you have a .bpf.o
> > object file on the disk. But in this case it's freplace and veristat
> > doesn't know what's the target BPF program, so it's not that useful in
> > this case:
> >
> > $ sudo veristat -v freplace_bpfel.o
> > Processing 'freplace_bpfel.o'...
> > libbpf: prog 'freplace_handler': attach program FD is not set
> > libbpf: prog 'freplace_handler': failed to prepare load attributes: -22
> > libbpf: prog 'freplace_handler': failed to load: -22
> > libbpf: failed to load object 'freplace_bpfel.o'
> > PROCESSING freplace_bpfel.o/freplace_handler, DURATION US: 0, VERDICT:
> > failure, VERIFIER LOG:
> >
> > File              Program           Verdict  Duration (us)  Insns
> > States  Peak states
> > ----------------  ----------------  -------  -------------  -----
> > ------  -----------
> > freplace_bpfel.o  freplace_handler  failure              0      0
> >  0            0
> > ----------------  ----------------  -------  -------------  -----
> > ------  -----------
> > Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.
> >
> > But for lots of other programs this would be a no-brainer.
> >
> >
> >   [0] https://gist.github.com/anakryiko/88a1597a68e43dc945e40fde88a96e7=
e
> >
> > [...]
> >
> >>
> >> Is it OK to add a tracepoint here? I think tracepoint is more generic
> >> than retsnoop-like way.
> >
> > I personally don't see a problem with adding tracepoint, but how would
> > it look like, given we are talking about vararg printf-style function
> > calls? I'm not sure how that should be represented in such a way as to
> > make it compatible with tracepoints and not cause any runtime
> > overhead.
>
> The tracepoint is not about vararg printf-style function calls.
>
> It is to trace the reason why it fails to bpf_check_attach_target() at
> attach time.
>

Oh, that changes things. I don't think we can keep adding extra
tracepoints for various potential reasons that BPF prog might be
failing to verify.

But there is usually no need either. This particular code already
supports emitting extra information into verifier log, you just have
to provide that. This is done by libbpf automatically, can't your
library of choice do the same (if BPF program failed).

Why go to all this trouble if we already have a facility to debug
issues like this. Note every issue is logged into verifier log, but in
this case it is.

> So, let me introduce bpf_check_attach_target_with_tracepoint() and
> BPF_LOG_KERNEL_WITHOUT_PRINT. bpf_check_attach_target_with_tracepoint()
> is to call bpf_check_attach_target() and then to call
> trace_bpf_check_attach_target() if err. BPF_LOG_KERNEL_WITHOUT_PRINT is
> to avoid pr_err() in bpf_verifier_vlog().
>
> Here's the diff without trace_bpf_check_attach_target() definition:

[...]

