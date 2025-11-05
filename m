Return-Path: <bpf+bounces-73733-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A360DC38214
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 23:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CD494E6321
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 22:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522FD2EAD0D;
	Wed,  5 Nov 2025 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pr+G5dM8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FB52DA774
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380036; cv=none; b=ooFeSoOAvWkYs/6IbmOCy6FEC8Reetqgn54v/uvSvLbOeMevXgy4iHyrHyWerwx+8QuAcLEE0vp1bIIWCMNSxtRCRw336YgwN0dFUHvkJlwXBd4qeU18z/wI6VHkgFpvLkX60Mu6IMUCosEHVT4Hpk8Fs9ys7H1Gcz6SCzwj4SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380036; c=relaxed/simple;
	bh=OvaR4LExsvzgceSEhP7+9FOe+N4cs9WxJGnp9hyaPC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l39AXdjoqjD4DPy+ZdkQRsfeQHohG2XrxOWBg4bstTyXCjDiOJOx5zpWxiwoH4C1JPrimaL2QzkBo49DwIFdoK/z1CL63WGeipaU7/uwExLJU0Wsgm/TaREAb6ilLMu/Aq80C3oyRu7u/eRuRURviysHb8vveoeuaSCUOOFItbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pr+G5dM8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477632b0621so879775e9.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 14:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762380033; x=1762984833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpLxnM3y6r4L8VSxULLu+iUbkAn7jwt8iRgXySHYxss=;
        b=Pr+G5dM86irVpBHLEZSa5Jhu0TkdR/eDAsDs1M6X6jq7eNnbTbeS0jMMJQmEeNkeUg
         Sw7PTxnBF53FihnQaoDaEJSVfdGdqCUhRgKEtR2cqo1Dhu/gFTaWIHi72xgAcBUC5B9r
         HLSr/pFLM/Dgf3tncHQK/mXa9okvYSnDaJSNPpPBESxKgxTtq2zvnEl0rcyglwdYRx8d
         0zR30qsIC3oqDpUP56f1jJzggmFOPQcEfXL31Q3TMNCsdmMQS6XPyimOkCI7IGf1OG6L
         YfjkOeIHKeN7K+21TrtFOBebgFYNcdcJH9mxyCfJ9HMSszWplZSZGTz0cRQecEtT9c52
         tGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762380033; x=1762984833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpLxnM3y6r4L8VSxULLu+iUbkAn7jwt8iRgXySHYxss=;
        b=Fh/fTUUtdvCJ63naxNUjr8G2eeIyn6b6UMm0ODlRwiBpVzKwfTkRq3H9X/2bhU4ECX
         yNe3IAU8gDgHqstPRoX95SjAfXKhWdu9pVCa3r4B+ve4RI2aOkN640/h54mKimHyvfYZ
         0HeN04LYHeL/k/d+HsRPu0zNL400oyLQLpQmTHAc9cQ2M5KGy2NmL6hpFSu6vFYBGMTG
         kjR1O991+F8chcs9DA7mLscoz7QbMnbuESIexiDEu2rRbhSCRTP9Kkc2ZXt2nMGSzA30
         zymiYFFpD0rtvZnI6mVIE4uPU2hKL3R/tErP6/hmP3th4dfiuxzpfYgswMcOqLP4KHFC
         PtrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNJ5bWKBCq/mJxXMxVoC9x3gzojuXy8Z0yWIMqmq6cmdwGTc0tXdQ5PRyQjC49v3HJ3zU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz83prbrIpxtqnaKn0Ha4AJV5PUuBmRg2BnsqtX5C4fPXWlCsOM
	/IjFyUHJ2n75nv6VIERwKjqLyBAE0QKqF7ncaoyoJaCa4nBrQWZGiRPV9sjHH3mDPTSpBJlmkiH
	zsZkL1MoTfU10SiIjdUiyTe8UaD7ju+c=
X-Gm-Gg: ASbGncu3Z759ABDD6TC2Sztri5T2FOl6hydlibyEE20tDSaOkHUwp4dMRIv5TzIsX68
	90OgOekR9OEzX6jvXv9fjjBcbw6qs1FiUdjQMhjapHAS/UI8VVFqFr06HDVRCfrzndUL7sU9719
	O/ccEm4C9jcL3iHXL2el16KYvKHJFdUtORu3RINKNnSj6En9ufEstE1fuMmzBFCSxKi/Wt4RkUh
	lkVFtq5jbb/L/KeNuZpTFpUTw2O+wgBniTm3TuiMbHaBRdTT4u3WS0MAkI95A8EXiBCBj5i1fFP
	t6VVBkGKKJfbTRFV5A==
X-Google-Smtp-Source: AGHT+IFHUVvNi+8bg4ydCPjxsPtOn43qlWR9NXvR37UfOXKWWdqRmdfZlMqI5aeF5c3TmX+FRy2OQ/rY0+fy77DypR8=
X-Received: by 2002:a05:6000:402b:b0:3e8:9e32:38f8 with SMTP id
 ffacd0b85a97d-429e32e43efmr4308677f8f.14.1762380033093; Wed, 05 Nov 2025
 14:00:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
 <CADxym3Y4nc2Qaq00Pp7XwmCXJHn0SsEoOejK8ZxhydepcbB8kQ@mail.gmail.com>
 <CAADnVQKDza_ueBFRkZS8rmUVJriynWi_0FqsZE8=VbTzQYuM4w@mail.gmail.com>
 <3577705.QJadu78ljV@7950hx> <CAEf4Bzas7Or4yPzqdHqEcgVpTDx2j26dR5oRnSg7bepr-uDqHw@mail.gmail.com>
 <CAADnVQKV_a7NxvWwXDgRab_gakwJ=VadZ0=eC5sHwutVyM0rmg@mail.gmail.com> <CAEf4BzZcrWCyC3DhNoefJsWNUhE46_yu0d3XyJZttQ8sRRpyag@mail.gmail.com>
In-Reply-To: <CAEf4BzZcrWCyC3DhNoefJsWNUhE46_yu0d3XyJZttQ8sRRpyag@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 14:00:22 -0800
X-Gm-Features: AWmQ_bmT69Sz2nRyX-TdiCO7Pl7wABX4MFyWITM7LU_ayHKel8lLsUJkoJTzHtg
Message-ID: <CAADnVQ+ZuQS_RSFL8ThrDkZwSygX2Rx49LBAcMpiv3y4nnYunQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting
 for x86_64
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 9:30=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 4, 2025 at 6:43=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Nov 4, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Nov 3, 2025 at 3:29=E2=80=AFAM Menglong Dong <menglong.dong@l=
inux.dev> wrote:
> > > >
> > > > On 2025/11/1 01:57, Alexei Starovoitov wrote:
> > > > > On Thu, Oct 30, 2025 at 8:36=E2=80=AFPM Menglong Dong <menglong8.=
dong@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Oct 31, 2025 at 9:42=E2=80=AFAM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sat, Oct 25, 2025 at 8:02=E2=80=AFPM Menglong Dong <menglo=
ng8.dong@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_sess=
ion_entry and
> > > > > > > > invoke_bpf_session_exit is introduced for this purpose.
> > > > > > > >
> > > > > > > > In invoke_bpf_session_entry(), we will check if the return =
value of the
> > > > > > > > fentry is 0, and set the corresponding session flag if not.=
 And in
> > > > > > > > invoke_bpf_session_exit(), we will check if the correspondi=
ng flag is
> > > > > > > > set. If set, the fexit will be skipped.
> > > > > > > >
> > > > > > > > As designed, the session flags and session cookie address i=
s stored after
> > > > > > > > the return value, and the stack look like this:
> > > > > > > >
> > > > > > > >   cookie ptr    -> 8 bytes
> > > > > > > >   session flags -> 8 bytes
> > > > > > > >   return value  -> 8 bytes
> > > > > > > >   argN          -> 8 bytes
> > > > > > > >   ...
> > > > > > > >   arg1          -> 8 bytes
> > > > > > > >   nr_args       -> 8 bytes
> > >
> > > Let's look at "cookie ptr", "session flags", and "nr_args". We can
> > > combine all of them into a single 8 byte slot: assign each session
> > > program index 0, 1, ..., Nsession. 1 bit for entry/exit flag, few bit=
s
> > > for session prog index, and few more bits for nr_args, and we still
> > > will have tons of space for some other additions in the future. From
> > > that session program index you can calculate cookieN address to retur=
n
> > > to user.
> > >
> > > And we should look whether moving nr_args into bpf_run_ctx would
> > > actually minimize amount of trampoline assembly code, as we can
> > > implement a bunch of stuff in pure C. (well, BPF verifier inlining is
> > > a separate thing, but it can be mostly arch-independent, right?)
> >
> > Instead of all that I have a different suggestion...
> >
> > how about we introduce this "session" attach type,
> > but won't mess with trampoline and whole new session->nr_links.
> > Instead the same prog can be added to 'fentry' list
> > and 'fexit' list.
> > We lose the ability to skip fexit, but I'm still not convinced
> > it's necessary.
> > The biggest benefit is that it will work for existing JITs and trampoli=
nes.
> > No new complex asm will be necessary.
> > As far as writable session_cookie ...
> > let's add another 8 byte space to bpf_tramp_run_ctx
> > and only allow single 'fsession' prog for a given kernel function.
> > Again to avoid changing all trampolines.
> > This way the feature can be implemented purely in C and no arch
> > specific changes.
> > It's more limited, but doesn't sound that the use case for multiple
> > fsession-s exist. All this is on/off tracing. Not something
> > that will be attached 24/7.
>
> I'd rather not have a feature at all, than have a feature that might
> or might not work depending on circumstances I don't control. If
> someone happens to be using fsession program on the same kernel
> function I happen to be tracing (e.g., with retsnoop), random failure
> to attach would be maddening to debug.

fentry won't conflict with fsession. I'm proposing
the limit of fsession-s to 1. Due to stack usage there gotta be
a limit anyway. I say, 32 is really the max. which is 256 bytes
for cookies plus all the stack usage for args, nr_args, run_ctx, etc.
Total of under 512 is ok.
So tooling would have to deal with the limit regardless.

