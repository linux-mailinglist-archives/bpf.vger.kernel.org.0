Return-Path: <bpf+bounces-39516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8020974212
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA531286E96
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608181A4E70;
	Tue, 10 Sep 2024 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1NxHkmy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789116F27F
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992729; cv=none; b=S+u/Ox+XzN1mhRHYOKuJY4dQBlKVFf++2OTvFLGA1YLd01jl9dl3UZK666LPO7dY0fYFJCelfFTHKX3vcMFT+phBPHvBD+5Su/tDGnhJDhIz7Eap+ZRKbJjAHDSPQ4kSsOeqhYoovEtl2PXixMiyBtz6q9pudX7vQLUyTwGa9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992729; c=relaxed/simple;
	bh=M0BXL/kfziWjFfouxBa+08k0YoAdhjonziKucITEDH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPsCRSq3g4mHY3BksP8IeJ4Bv5H7M6hTqj3SSPibZ25UnUKctQTD3x5UKumMRfJE156ivYxELXcP3JaJ8jjbUT7tX8U1fWW6wDqz/LTWsaqDZOz8o/0SZM85L/OD54HRURIjibPJHiLdrn1GCO4tsAue7bZdG7z4NTP747AsJA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1NxHkmy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2068acc8b98so54636705ad.3
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725992728; x=1726597528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GS0DjTCbOCdHzd3qB5AGsShbg7Sx/xCaoDPcaSaVGg=;
        b=D1NxHkmykDhVFowyKWqiHlA2SUsreEWn/HWjK/kbi+Lp88UIDpav6S+I+aS4VEiz7s
         RZbHXAvCc3IkT7iPFu3AMcLz/RHPj5ap1nRVw4SkdN6Hn1VqapjtxgYQ1BEw/OBorkdj
         gZlsPqexrliMBMK0huQeGZ8vSM6vGIP0Vm6xiMzmk2pTNFcOZdNGm74dU5SkyhyAU8NT
         wJybx09Pa/s+e/1NEWxYGn9k1xp1+7EJjHGqsRQDasFuWPPAYHDDuzQ4YpTmWeLpLE/I
         ZK5DY/7JEJR2HKB5XL6nMHezrtTjxJAWGbCrgJzdjbsn2uIrwTUC/lezwzgJDK/F2GsJ
         LB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725992728; x=1726597528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GS0DjTCbOCdHzd3qB5AGsShbg7Sx/xCaoDPcaSaVGg=;
        b=ne9jJaRaKPWiP1NqRnKYI3hnp6F3VZVQL20JlenDDBjrCtEs/owRaUQqSqFP5bh2ki
         F1t16vLiaiDJmKO8kmD4oHH0tF+EP84TXjfeUtMQRHrccC2eVWkMpFDNJJGW4ZEYNQky
         h0E3FRn4hwlDsfZx+m7yv621gkZ7G3QFD8fZg8Sa9EJ8G2MT+UFVm83+wluVqVLaiFvq
         ujnHshUVU0y0nF8H8B8hfwgXr6MdK6pRM3+bEcPZz32aVLbbJSn8KfCDyXhy8fDkW6In
         oZmrLVDU8ODmnFJUCKAPfuCttNlngzFzhgkmi/Xix+FY7Ss1qfHp+eNDsqEWut9PLESi
         FyGQ==
X-Gm-Message-State: AOJu0YxPm1IomR/TVSUCGsyEju3wYkzqpNmCl7dGNOCZH38wu0mSMZV/
	gM5PnlT5+6KStsNTSXE6jJQLJSERS1D6Pfa0QAXzv4KaqQyj10r4YhalPdVih7JOMh9Uqk3KGHk
	e7vRre2CLZIcojgJJ7vlAtSwQBWI=
X-Google-Smtp-Source: AGHT+IFu+upH9Fk32auU5/XabVzfdgG+CnYHMchqKeFwQmcV9fsksrrcbR7WowkXi/26LvHsf2Fenzim6jFEpOYgASo=
X-Received: by 2002:a17:90b:3943:b0:2d8:b075:7862 with SMTP id
 98e67ed59e1d1-2daffa3a79bmr14393161a91.5.1725992727591; Tue, 10 Sep 2024
 11:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910034306.3122378-1-yonghong.song@linux.dev>
 <CAEf4BzbsYn-b7YiKZ0MPW9_VLzDq38Jv8UkocfMLVje_SAmENA@mail.gmail.com>
 <CAEf4BzZC3FyP06p-H8JhQVJqOTRfjLSfNpHBZn3hN2WRfypDsw@mail.gmail.com>
 <84f2c314-980c-4e01-bcaa-dafb62a934f3@linux.dev> <CAEf4BzahXi9t+Y883iCTDrAkcr2DEy0he-NW+jg9yT3TXH6NUA@mail.gmail.com>
 <e9b9db08-7ad4-47e0-be4d-6cd85eed854e@linux.dev>
In-Reply-To: <e9b9db08-7ad4-47e0-be4d-6cd85eed854e@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Sep 2024 11:25:15 -0700
Message-ID: <CAEf4Bzb7i9p-4f+1NLpNU6Wx2AkYywwbWtzCrMyoi5HK0=QbyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Use fake pt_regs when doing bpf syscall
 tracepoint tracing
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Salvatore Benedetto <salvabenedetto@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 11:22=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
> On 9/10/24 9:50 AM, Andrii Nakryiko wrote:
> > On Tue, Sep 10, 2024 at 8:25=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>
> >> On 9/9/24 10:42 PM, Andrii Nakryiko wrote:
> >>> On Mon, Sep 9, 2024 at 10:34=E2=80=AFPM Andrii Nakryiko
> >>> <andrii.nakryiko@gmail.com> wrote:
> >>>> On Mon, Sep 9, 2024 at 8:43=E2=80=AFPM Yonghong Song <yonghong.song@=
linux.dev> wrote:
> >>>>> Salvatore Benedetto reported an issue that when doing syscall trace=
point
> >>>>> tracing the kernel stack is empty. For example, using the following
> >>>>> command line
> >>>>>     bpftrace -e 'tracepoint:syscalls:sys_enter_read { print("Kernel=
 Stack\n"); print(kstack()); }'
> >>>>> the output will be
> >>>>> =3D=3D=3D
> >>>>>     Kernel Stack
> >>>>> =3D=3D=3D
> >>>>>
> >>>>> Further analysis shows that pt_regs used for bpf syscall tracepoint
> >>>>> tracing is from the one constructed during user->kernel transition.
> >>>>> The call stack looks like
> >>>>>     perf_syscall_enter+0x88/0x7c0
> >>>>>     trace_sys_enter+0x41/0x80
> >>>>>     syscall_trace_enter+0x100/0x160
> >>>>>     do_syscall_64+0x38/0xf0
> >>>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>>>>
> >>>>> The ip address stored in pt_regs is from user space hence no kernel
> >>>>> stack is printed.
> >>>>>
> >>>>> To fix the issue, we need to use kernel address from pt_regs.
> >>>>> In kernel repo, there are already a few cases like this. For exampl=
e,
> >>>>> in kernel/trace/bpf_trace.c, several perf_fetch_caller_regs(fake_re=
gs_ptr)
> >>>>> instances are used to supply ip address or use ip address to constr=
uct
> >>>>> call stack.
> >>>>>
> >>>>> The patch follows the above example by using a fake pt_regs.
> >>>>> The pt_regs is stored in local stack since the syscall tracepoint
> >>>>> tracing is in process context and there are no possibility that
> >>>>> different concurrent syscall tracepoint tracing could mess up with =
each
> >>>>> other. This is similar to a perf_fetch_caller_regs() use case in
> >>>>> kernel/trace/trace_event_perf.c with function perf_ftrace_function_=
call()
> >>>>> where a local pt_regs is used.
> >>>>>
> >>>>> With this patch, for the above bpftrace script, I got the following=
 output
> >>>>> =3D=3D=3D
> >>>>>     Kernel Stack
> >>>>>
> >>>>>           syscall_trace_enter+407
> >>>>>           syscall_trace_enter+407
> >>>>>           do_syscall_64+74
> >>>>>           entry_SYSCALL_64_after_hwframe+75
> >>>>> =3D=3D=3D
> >>>>>
> >>>>> Reported-by: Salvatore Benedetto <salvabenedetto@meta.com>
> >>>>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >>>>> ---
> >>>>>    kernel/trace/trace_syscalls.c | 5 ++++-
> >>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>>
> >>>> Note, we need to solve the same for perf_call_bpf_exit().
> >>>>
> >>>> pw-bot: cr
> >>>>
> >>> BTW, we lived with this bug for years, so I suggest basing your fix o=
n
> >>> top of bpf-next/master, no bpf/master, which will give people a bit o=
f
> >>> time to validate that the fix works as expected and doesn't produce
> >>> any undesirable side effects, before this makes it into the final
> >>> Linux release.
> >> Yes, I did. See I indeed use 'bpf-next' in subject above.
> > Huh, strange, I actually tried to apply your patch to bpf-next/master
> > and it didn't apply cleanly. It did apply to bpf/master, though, which
> > is why I assumed you based it off of bpf/master.
>
> Interesting. The following is my git history:
>
> 7b71206057440d9559ecb9cd02d891f46927b272 (HEAD -> trace_syscall) bpf: Use=
 fake pt_regs when doing bpf syscall tracepoint tracing
> 41d0c4677feee1ea063e0f2c2af72dc953b1f1cc (origin/master, origin/HEAD, mas=
ter) libbpf: Fix some typos in comments
> 72d8508ecd3b081dba03ec00930c6b07c1ad55d3 MAINTAINERS: BPF ARC JIT: Update=
 my e-mail address
> bee109b7b3e50739b88252a219fa07ecd78ad628 bpf: Fix error message on kfunc =
arg type mismatch
> ...
>
> Not sure what is going on ...
>

Doesn't matter, maybe my local bpf-next/master branch was screwed up.
Just send a v2 when you are ready and I'll try again :)

>
> >
> >>>>> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_sys=
calls.c
> >>>>> index 9c581d6da843..063f51952d49 100644
> >>>>> --- a/kernel/trace/trace_syscalls.c
> >>>>> +++ b/kernel/trace/trace_syscalls.c
> >>>>> @@ -559,12 +559,15 @@ static int perf_call_bpf_enter(struct trace_e=
vent_call *call, struct pt_regs *re
> >>>> let's also drop struct pt_regs * argument into
> >>>> perf_call_bpf_{enter,exit}(), they are not actually used anymore
> >>>>
> >>>>>                   int syscall_nr;
> >>>>>                   unsigned long args[SYSCALL_DEFINE_MAXARGS];
> >>>>>           } __aligned(8) param;
> >>>>> +       struct pt_regs fake_regs;
> >>>>>           int i;
> >>>>>
> >>>>>           BUILD_BUG_ON(sizeof(param.ent) < sizeof(void *));
> >>>>>
> >>>>>           /* bpf prog requires 'regs' to be the first member in the=
 ctx (a.k.a. &param) */
> >>>>> -       *(struct pt_regs **)&param =3D regs;
> >>>>> +       memset(&fake_regs, 0, sizeof(fake_regs));
> >>>> sizeof(struct pt_regs) =3D=3D 168 on x86-64, and on arm64 it's a who=
pping
> >>>> 336 bytes, so these memset(0) calls are not free for sure.
> >>>>
> >>>> But we don't need to do this unnecessary work all the time.
> >>>>
> >>>> I initially was going to suggest to use get_bpf_raw_tp_regs() from
> >>>> kernel/trace/bpf_trace.c to get a temporary pt_regs that was already
> >>>> memset(0) and used to initialize these minimal "fake regs".
> >>>>
> >>>> But, it turns out we don't need to do even that. Note
> >>>> perf_trace_buf_alloc(), it has `struct pt_regs **` second argument,
> >>>> and if you pass a valid pointer there, it will return "fake regs"
> >>>> struct to be used. We already use that functionality in
> >>>> perf_trace_##call in include/trace/perf.h (i.e., non-syscall
> >>>> tracepoints), so this seems to be a perfect fit.
> >>>>
> >>>>> +       perf_fetch_caller_regs(&fake_regs);
> >>>>> +       *(struct pt_regs **)&param =3D &fake_regs;
> >>>>>           param.syscall_nr =3D rec->nr;
> >>>>>           for (i =3D 0; i < sys_data->nb_args; i++)
> >>>>>                   param.args[i] =3D rec->args[i];
> >>>>> --
> >>>>> 2.43.5
> >>>>>

