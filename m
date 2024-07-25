Return-Path: <bpf+bounces-35677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BFF93CA2B
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 23:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F99BB2245D
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 21:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CB913D8B3;
	Thu, 25 Jul 2024 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJ4t2wXP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F613D601;
	Thu, 25 Jul 2024 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721942864; cv=none; b=cg+pUACSbBqS8Fp0GbscXYFjLPOFyLmUqqtE1EO3S0GPQkjpApbFyoPT6NaLgRhaz7YYAWo1uSydRauQtrlGxbuCXLbgLSUBdVqyuXudQypvQzNdNnmnvf82+ZhR9Ps6G0BBGGcl/j5RJSdeK4GarcL/2EB/SyhOTjMhGAaM/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721942864; c=relaxed/simple;
	bh=7HH1/bjgMWGKvoAOEfiRBwdrL2QijsJhS8lAU52D7lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ao33RueHNwCNe9m8YmyARSFmDaHAYLMF2wD8drqbCi0SeuySlbAybnlbMNb1RqjO/7YoetUGqW4GXAb1zKshsFtpFbyx4tx8Isf5eP47PABV4xaMdI+3REFWuae4PfAYp7e7aviCOCAAjiL3H22EuA5ABKCHnjx0UWO/8Itfquw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJ4t2wXP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cd48ad7f0dso258101a91.0;
        Thu, 25 Jul 2024 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721942862; x=1722547662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gFGcJG5YJ9WgvT8pZMtXcTiIA+/pmIZZ6voQvuWWRQ=;
        b=eJ4t2wXPI62NhIMWxum+JfKFLuD2T6vPWLDc6Aw7Dr9vWbpso+hr0pp/1pvEM6mmaI
         MBQkcWJGXpHbS5eaiauXM0fg5RwPNsEl6TtJvPEWlFu232cbMTR82u+mTnRpYLp3xY+2
         MVfqgsfSG/h1RqSH8YEhGUvebzTwp/7vaKV0wHAcw4pPWUpeGo5iOIj6Zns1YpZQHcM9
         tRuEXfOgBVVwhcU++4o12sB7KRah38V1WlhIaVuoJr+AvOmCQ6cJriqkNAqFIqzJ417G
         xCyqRSOo8TikzyTmIYpV45AOQYY91KPsR9nnF7XINFlaH7hQW7mrwrCnzLg987zkYGms
         B9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721942862; x=1722547662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gFGcJG5YJ9WgvT8pZMtXcTiIA+/pmIZZ6voQvuWWRQ=;
        b=DoHNp5AM7xEyFZ5FeZEBHg53wM4HjXGcj8MCYhUCkUgi+fo3o00PpnbKPdKkj1aPuh
         bO4eSbXrvxvd4LnCltqm//NkGuhT4rxdiPLwiQB5379/5LVR9R7VxK9PO2s8EoXjHi4Y
         h9KGLw/R+myVCVNWmZsW+bzonWOH0ZoIhh85djvKkgpoUpJTcBW7pZ4AvEhR+M6x/Fpc
         yM2mXdxdBGVZkgdHxiA8inTgnc+w18A22+vffS6z1YejGjBnMqEV5kPThNjcaLxnuqQb
         mrNj8nBB+68AacJac03vEXzrZ+KZ3EJkFczwpSWYOXS8pKXPrUplaJSp1QQiubWIqQpj
         fPRg==
X-Forwarded-Encrypted: i=1; AJvYcCVoDVtatEaWi6EclqPyvInaSGr0iMUQRkvO69otNz4tgbc8IYyReBQ1MvictW+M02qjNZ6LWxBAI8THvpM64vjXwCLSU9AHafZKjhYSk2JjcJbX70k4dAlP6AN8T9AHGv/H
X-Gm-Message-State: AOJu0Yx8TLQ8p9TXvyNmf9b7NgaT1Z1WFRfSS1tWfcJWUS1XFPFt753k
	tXW2kXTur9bndAuz38I3YBeUp6dlnBnv5ahJBrh02m+hTzotZOPhNRma3gJmv/BQrizYMcg2AQB
	r1vUFy32wJvtiHhNLykWtvzuaU0Q=
X-Google-Smtp-Source: AGHT+IEM2c9hYv4ioDrYmhlRR9b4D/qgb76nW2nhG2j//OPmJ1TGFJuLtbgbV7HNA87je7tNIjIZFuPWCRgb90mCrEA=
X-Received: by 2002:a17:90a:fa98:b0:2cb:3306:b2cc with SMTP id
 98e67ed59e1d1-2cf2e9cfbf9mr3810107a91.1.1721942861745; Thu, 25 Jul 2024
 14:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725051511.57112-1-me@manjusaka.me> <08e180da-e841-427d-bed6-3ba8d73e8519@linux.dev>
 <c7952df9-5830-45d3-89bb-b45f2b030e24@gmail.com> <6511ce2a-1c7d-497c-aeb6-d4f0b17271ed@linux.dev>
 <2c6b1737-0a96-44ed-afe9-655444121984@gmail.com>
In-Reply-To: <2c6b1737-0a96-44ed-afe9-655444121984@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jul 2024 14:27:29 -0700
Message-ID: <CAEf4BzbL0xfdCEYmzfQ4qCWQxKJAK=TwsdS3k=L58AoVyObL3Q@mail.gmail.com>
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

On Thu, Jul 25, 2024 at 12:33=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> w=
rote:
>
>
>
> On 25/7/24 14:09, Yonghong Song wrote:
> >
> > On 7/24/24 11:05 PM, Leon Hwang wrote:
> >>
> >> On 25/7/24 13:54, Yonghong Song wrote:
> >>> On 7/24/24 10:15 PM, Zheao Li wrote:
> >>>> This is a v2 patch, previous Link:
> >>>> https://lore.kernel.org/bpf/20240724152521.20546-1-me@manjusaka.me/T=
/#u
> >>>>
> >>>> Compare with v1:
> >>>>
> >>>> 1. Format the code style and signed-off field
> >>>> 2. Use a shorter name bpf_check_attach_target_with_klog instead of
> >>>> original name bpf_check_attach_target_with_kernel_log
> >>>>
> >>>> When attaching a freplace hook, failures can occur,
> >>>> but currently, no output is provided to help developers diagnose the
> >>>> root cause.
> >>>>
> >>>> This commit adds a new method, bpf_check_attach_target_with_klog,
> >>>> which outputs the verifier log to the kernel.
> >>>> Developers can then use dmesg to obtain more detailed information
> >>>> about the failure.
> >>>>
> >>>> For an example of eBPF code,
> >>>> Link:
> >>>> https://github.com/Asphaltt/learn-by-example/blob/main/ebpf/freplace=
/main.go
> >>>>
> >>>> Co-developed-by: Leon Hwang <hffilwlqm@gmail.com>
> >>>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> >>>> Signed-off-by: Zheao Li <me@manjusaka.me>
> >>>> ---
> >>>>    include/linux/bpf_verifier.h |  5 +++++
> >>>>    kernel/bpf/syscall.c         |  5 +++--
> >>>>    kernel/bpf/trampoline.c      |  6 +++---
> >>>>    kernel/bpf/verifier.c        | 19 +++++++++++++++++++
> >>>>    4 files changed, 30 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/bpf_verifier.h
> >>>> b/include/linux/bpf_verifier.h
> >>>> index 5cea15c81b8a..8eddba62c194 100644
> >>>> --- a/include/linux/bpf_verifier.h
> >>>> +++ b/include/linux/bpf_verifier.h
> >>>> @@ -848,6 +848,11 @@ static inline void bpf_trampoline_unpack_key(u6=
4
> >>>> key, u32 *obj_id, u32 *btf_id)
> >>>>            *btf_id =3D key & 0x7FFFFFFF;
> >>>>    }
> >>>>    +int bpf_check_attach_target_with_klog(const struct bpf_prog *pro=
g,
> >>>> +                        const struct bpf_prog *tgt_prog,
> >>>> +                        u32 btf_id,
> >>>> +                        struct bpf_attach_target_info *tgt_info);
> >>> format issue in the above. Same code alignment is needed for argument=
s
> >>> in different lines.
> >>>
> >>>> +
> >>>>    int bpf_check_attach_target(struct bpf_verifier_log *log,
> >>>>                    const struct bpf_prog *prog,
> >>>>                    const struct bpf_prog *tgt_prog,
> >>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >>>> index 869265852d51..bf826fcc8cf4 100644
> >>>> --- a/kernel/bpf/syscall.c
> >>>> +++ b/kernel/bpf/syscall.c
> >>>> @@ -3464,8 +3464,9 @@ static int bpf_tracing_prog_attach(struct
> >>>> bpf_prog *prog,
> >>>>             */
> >>>>            struct bpf_attach_target_info tgt_info =3D {};
> >>>>    -        err =3D bpf_check_attach_target(NULL, prog, tgt_prog, bt=
f_id,
> >>>> -                          &tgt_info);
> >>>> +        err =3D bpf_check_attach_target_with_klog(prog, NULL,
> >>>> +                                  prog->aux->attach_btf_id,
> >>>> +                                  &tgt_info);
> >>> code alignment issue here as well.
> >>> Also, the argument should be 'prog, tgt_prog, btf_id, &tgt_info', rig=
ht?
> >>>
> >>>>            if (err)
> >>>>                goto out_unlock;
> >>>>    diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> >>>> index f8302a5ca400..8862adaa7302 100644
> >>>> --- a/kernel/bpf/trampoline.c
> >>>> +++ b/kernel/bpf/trampoline.c
> >>>> @@ -699,9 +699,9 @@ int bpf_trampoline_link_cgroup_shim(struct
> >>>> bpf_prog *prog,
> >>>>        u64 key;
> >>>>        int err;
> >>>>    -    err =3D bpf_check_attach_target(NULL, prog, NULL,
> >>>> -                      prog->aux->attach_btf_id,
> >>>> -                      &tgt_info);
> >>>> +    err =3D bpf_check_attach_target_with_klog(prog, NULL,
> >>>> +                              prog->aux->attach_btf_id,
> >>>> +                              &tgt_info);
> >>> code alignment issue here
> >>>
> >>>>        if (err)
> >>>>            return err;
> >>>>    diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>>> index 1f5302fb0957..4873b72f5a9a 100644
> >>>> --- a/kernel/bpf/verifier.c
> >>>> +++ b/kernel/bpf/verifier.c
> >>>> @@ -21643,6 +21643,25 @@ static int
> >>>> check_non_sleepable_error_inject(u32 btf_id)
> >>>>        return btf_id_set_contains(&btf_non_sleepable_error_inject,
> >>>> btf_id);
> >>>>    }
> >>>>    +int bpf_check_attach_target_with_klog(const struct bpf_prog *pro=
g,
> >>>> +                        const struct bpf_prog *tgt_prog,
> >>>> +                        u32 btf_id,
> >>>> +                        struct bpf_attach_target_info *tgt_info);
> >>> code alignment issue here.
> >>>
> >>>> +{
> >>>> +    struct bpf_verifier_log *log;
> >>>> +    int err;
> >>>> +
> >>>> +    log =3D kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
> >>> __GFP_NOWARN is unnecessary here.
> >>>
> >>>> +    if (!log) {
> >>>> +        err =3D -ENOMEM;
> >>>> +        return err;
> >>>> +    }
> >>>> +    log->level =3D BPF_LOG_KERNEL;
> >>>> +    err =3D bpf_check_attach_target(log, prog, tgt_prog, btf_id,
> >>>> tgt_info);
> >>>> +    kfree(log);
> >>>> +    return err;
> >>>> +}
> >>>> +
> >>>>    int bpf_check_attach_target(struct bpf_verifier_log *log,
> >>>>                    const struct bpf_prog *prog,
> >>>>                    const struct bpf_prog *tgt_prog,
> >>> More importantly, Andrii has implemented retsnoop, which intends to
> >>> locate
> >>> precise location in the kernel where err happens. The link is
> >>>    https://github.com/anakryiko/retsnoop
> >>>
> >>> Maybe you want to take a look and see whether it can resolve your iss=
ue.
> >>> We should really avoid putting more stuff in dmesg whenever possible.
> >>>
> >> retsnoop is really cool.
> >>
> >> However, when something wrong in bpf_check_attach_target(), retsnoop
> >> only gets its return value -EINVAL, without any bpf_log() in it. It's
> >> hard to figure out the reason why bpf_check_attach_target() returns
> >> -EINVAL.
> >
> > It should have line number like below in
> > https://github.com/anakryiko/retsnoop
> >
> > |$ sudo ./retsnoop -e '*sys_bpf' -a ':kernel/bpf/*.c' Receiving data...
> > 20:19:36.372607 -> 20:19:36.372682 TID/PID 8346/8346 (simfail/simfail):
> > entry_SYSCALL_64_after_hwframe+0x63 (arch/x86/entry/entry_64.S:120:0)
> > do_syscall_64+0x35 (arch/x86/entry/common.c:80:7) . do_syscall_x64
> > (arch/x86/entry/common.c:50:12) 73us [-ENOMEM] __x64_sys_bpf+0x1a
> > (kernel/bpf/syscall.c:5067:1) 70us [-ENOMEM] __sys_bpf+0x38b
> > (kernel/bpf/syscall.c:4947:9) . map_create (kernel/bpf/syscall.c:1106:8=
)
> > . find_and_alloc_map (kernel/bpf/syscall.c:132:5) ! 50us [-ENOMEM]
> > array_map_alloc !* 2us [NULL] bpf_map_alloc_percpu Could you double
> > check? It does need corresponding kernel source though. |
> >
>
> I have a try on an Ubuntu 24.04 VM, whose kernel is 6.8.0-39-generic.
>
> $ sudo retsnoop -e '*sys_bpf' -a ':kernel/bpf/*.c' -T
> Receiving data...
> 07:18:38.643643 -> 07:18:38.643728 TID/PID 6042/6039 (freplace/freplace):
>
> FUNCTION CALL TRACE                                   RESULT
>    DURATION
> ---------------------------------------------------
> --------------------  --------
> =E2=86=92 __x64_sys_bpf
>
>     =E2=86=92 __sys_bpf
>
>         =E2=86=94 bpf_check_uarg_tail_zero                    [0]
>     2.376us
>         =E2=86=92 link_create
>
>             =E2=86=94 __bpf_prog_get
> [0xffffb55f40db3000]   2.796us
>             =E2=86=94 bpf_prog_attach_check_attach_type       [0]
>     2.260us
>             =E2=86=92 bpf_tracing_prog_attach
>
>                 =E2=86=94 __bpf_prog_get
> [0xffffb55f40d71000]   9.455us
>                 =E2=86=92 bpf_check_attach_target
>
>                     =E2=86=92 btf_check_type_match
>
>                         =E2=86=92 btf_check_func_type_match
>
>                             =E2=86=94 bpf_log                 [void]
>     2.578us
>                         =E2=86=90 btf_check_func_type_match   [-EINVAL]
>     7.659us
>                     =E2=86=90 btf_check_type_match            [-EINVAL]
>    15.950us
>                 =E2=86=90 bpf_check_attach_target             [-EINVAL]
>    22.397us
>                 =E2=86=94 __bpf_prog_put                      [void]
>     2.323us
>             =E2=86=90 bpf_tracing_prog_attach                 [-EINVAL]
>    45.509us
>             =E2=86=94 __bpf_prog_put                          [void]
>     2.182us
>         =E2=86=90 link_create                                 [-EINVAL]
>    66.445us
>     =E2=86=90 __sys_bpf                                       [-EINVAL]
>    77.347us
> =E2=86=90 __x64_sys_bpf                                       [-EINVAL]
>    81.979us
>
>                     entry_SYSCALL_64_after_hwframe+0x78
> (arch/x86/entry/entry_64.S:130:0)
>                     do_syscall_64+0x7f
> (arch/x86/entry/common.c:83:7)
>                     . do_syscall_x64
> (arch/x86/entry/common.c:52:12)
>                     x64_sys_call+0x1936
> (arch/x86/entry/syscall_64.c:33:1)
>     81us [-EINVAL]  __x64_sys_bpf+0x1a
> (kernel/bpf/syscall.c:5588:1)
>     77us [-EINVAL]  __sys_bpf+0x4ae
> (kernel/bpf/syscall.c:5556:9)
> !   66us [-EINVAL]  link_create
>
> !*  45us [-EINVAL]  bpf_tracing_prog_attach
>
> !*  22us [-EINVAL]  bpf_check_attach_target
>
> !*  15us [-EINVAL]  btf_check_type_match
>
> !*   7us [-EINVAL]  btf_check_func_type_match
>
> P.S. Check
> https://gist.github.com/Asphaltt/883fd7362968f7747e820d63a9519971 to
> have a better view of this output.
>
> When attach freplace prog to a static-noline subprog, there is a
> bpf_log() in btf_check_func_type_match(). However, I don't know what
> bpf_log() logs.

If you build the very latest retsnoop from Github (this functionality
hasn't been released just yet, I added it literally two days ago), you
will be able to capture bpf_log's format string. vararg arguments
themselves are not (yet) captured, but I'm going to play with that.

Try something like this:

sudo ./retsnoop -e verbose -e bpf_log -e bpf_verifier_vlog -e
bpf_verifier_log_write -STA -v

And you might see something like:

FUNCTION CALLS   RESULT  DURATION  ARGS
--------------   ------  --------  ----
=E2=86=94 bpf_log        [void]   2.555us  log=3D&{} fmt=3D'func '%s' arg%d=
 has
btf_id %d type %s '%s' ' =3D(vararg)

or

FUNCTION CALLS   RESULT  DURATION  ARGS
--------------   ------  --------  ----
=E2=86=94 bpf_log        [void]   5.729us  log=3D&{} fmt=3D'arg#%d referenc=
e
type('%s %s') size cannot be determined: %ld ' =3D(vararg)


So you'll get a general understanding from format string (but yeah,
actual arguments would be good to have).


This is not really a solution, but definitely useful for debugging.

Is there some simple way for me to reproduce your specific issue, I'd
like to use that as one motivating example to see how far retsnoop can
be pushed.

P.S. I do think that putting any logging like this into dmesg is
definitely wrong, btw.

>
> With this patch, we are able to figure out what bpf_log() logs.
> Therefore, we are able to figure out the reason why it fails to attach
> freplace prog.
>
> Thanks,
> Leon
>

