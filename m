Return-Path: <bpf+bounces-54272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546EAA667DA
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 04:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2F9188F0B0
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 03:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF206195FE8;
	Tue, 18 Mar 2025 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buPbIOMa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00F620322
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 03:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742270312; cv=none; b=kaLQ34Ppc2S+lvWIpuTvSqQk4Yl2JwOCHizRmDukMCnW5Z49E4v3CsvNE4FFVzN9mQUrnA5iGe3BAdckItNHDQJo0EZy93zeG0Cc9z/K5cWFzD9nksrmrxZJKVDkXQGlHdZQlGXh2Os61BHZLuWAyZpUaGekCAwQ9D3XxWuhj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742270312; c=relaxed/simple;
	bh=GcHDzYkmdMpiOrDil0zQhGD/nPNseC5IuQX8SaUOrm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcmtAD/ZsTub0SZBbvNCCAS5Nx0s+rvNvnFfWbzHzNehVRqbN9WXsJ5A+0hhor1fZTqNMU+4EyaORFjy22TglzQMPx69bbzH5QwULJq0J+7CqIK2YCqBmt+Pbb8Mi5JvsNFkCgxPUkzWe5X65Duz+6Y8XPYaaPoQMb4L5g4ASCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buPbIOMa; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso76401106d6.0
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 20:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742270309; x=1742875109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGvPTobKRqlX88Q1CppvuJbTnYHq8E1bVWUJZ0px51o=;
        b=buPbIOMatNxJx+OopSMuv0YzFsFL0Lm9vmZZlteDbFQdIQj5YGh38DHfSWNE9Xv2eZ
         gw+6qSVXay6qr6gWJ/40ZN5NsO4/Je2cWHN40xShYzMYy93UoP7+kllx6tNltJUGmK8W
         5PLYP28RmlERz9gLTv0SAM07EddIHURPXa3OlQJzML7RuExAPepw4qvkTdUMv6UI2stS
         1DXyfR1RMyQ4hSWLXHTIW277xrfrdwgeIDiuXrptic3o23pYy8OgknjMvOWUT+v5OtDl
         UBp+PyBreHbqSkj/pqL16XcGNcCuUh0c1k/jAgTnepIN09xUVtJrsRNtYmkbw5vaZVIk
         qXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742270309; x=1742875109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGvPTobKRqlX88Q1CppvuJbTnYHq8E1bVWUJZ0px51o=;
        b=OZPXC86x1g6YHHZm+UrDgZSiVMsisu7AZvonONuPsANfC6TZPE4mYyfL+tp1pdHT2T
         StteU7zGNSmLP95WxpLbwsALLX+Qd+crPexecX2U1Tn/FKyw5lOL0Lq2dAyfh9rKvCpx
         SNgb5UnnfW5XYHsCKP2Q9gFXIJdBUq2NCdEDh4JmMCMc3GiHDC11e6EzZTrCKPi6rfuR
         BOx4mHcPxTKQMD4fsRCuXqrLJkRtpE+7RglIShat5FriQqpmEUL4Nw6LCRlwAnpMDTSE
         lc72K5z2zOtCEwQ+vezaxv+EX6S4cEtOnYuqjQtNynfnSfVLQsM4/0CkhnX6jil5PBaQ
         7xsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLKIn+zM/EDFo5ljUxJ8QMs3LiHyEFCO/xXIcUqKirYpvih+qJsUF57tM9lVBQUgtRT8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHoR5WzQdIT3GnoYIQB+00K/4SdnGq783wl3D0Aw1oYYgas0C
	Vg0HfHQi7rKcq1/jQXlIXRmbCVJFjQmtn9bCQfCwnzr3kU/xP5WsexyumPfpfmDAOcpMdphX4We
	4SlereXHposXLerV8mF7chPHgW4k=
X-Gm-Gg: ASbGncvEsXu/x9kkBkOTBb4dG3kB/isgDpqNIat0mRlVOcziWTLrCf6xTGZKHm+bqQW
	6yjCilEwUZd74PY3l6UOALwsj/v/q3vd8G5NdQfMU0dMy/l4toP9KsudKumubIRE4mkAqhc7aQ4
	juvs5tSaxOu2Gjrj73nbph5lETjJM=
X-Google-Smtp-Source: AGHT+IEXNv9VJKQ27BfQWLExcH4Wkdv9bdJgpU7xEULE4Y6tonix8HxmfnumcH23D8ttzc+511AqvNfALJ0OCY5LjMA=
X-Received: by 2002:a05:6214:ca4:b0:6e8:9021:9090 with SMTP id
 6a1803df08f44-6eaeaa79212mr216201776d6.26.1742270309464; Mon, 17 Mar 2025
 20:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317121735.86515-1-laoar.shao@gmail.com> <20250317121735.86515-2-laoar.shao@gmail.com>
 <CAADnVQK=TBLUNrUUa0Yhi=M1-MfNVkKYKKca+jmTysJypign+g@mail.gmail.com>
In-Reply-To: <CAADnVQK=TBLUNrUUa0Yhi=M1-MfNVkKYKKca+jmTysJypign+g@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 18 Mar 2025 11:57:53 +0800
X-Gm-Features: AQ5f1JpWxNlh_j93lpEPj62YdUeR7BSUpHdV-vC2btsiyEajWrSzXjC4__5kkJI
Message-ID: <CALOAHbBY3z-QeAE98zO+R3Pa8E05pcQsk3NcdTWVB4xLg-=NQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: Reject attaching fexit/fmod_ret to
 __noreturn functions
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 4:20=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 17, 2025 at 5:18=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > If we attach fexit/fmod_ret to __noreturn functions, it will cause an
> > issue that the bpf trampoline image will be left over even if the bpf
> > link has been destroyed. Take attaching do_exit() with fexit for exampl=
e.
> > The fexit works as follows,
> >
> >   bpf_trampoline
> >   + __bpf_tramp_enter
> >     + percpu_ref_get(&tr->pcref);
> >
> >   + call do_exit()
> >
> >   + __bpf_tramp_exit
> >     + percpu_ref_put(&tr->pcref);
> >
> > Since do_exit() never returns, the refcnt of the trampoline image is
> > never decremented, preventing it from being freed. That can be verified
> > with as follows,
> >
> >   $ bpftool link show                                   <<<< nothing ou=
tput
> >   $ grep "bpf_trampoline_[0-9]" /proc/kallsyms
> >   ffffffffc04cb000 t bpf_trampoline_6442526459    [bpf] <<<< leftover
> >
> > In this patch, all functions annotated with __noreturn are rejected, ex=
cept
> > for the following cases:
> > - Functions that result in a system reboot, such as panic,
> >   machine_real_restart and rust_begin_unwind
> > - Functions that are never executed by tasks, such as rest_init and
> >   cpu_startup_entry
> > - Functions implemented in assembly, such as rewind_stack_and_make_dead=
 and
> >   xen_cpu_bringup_again, lack an associated BTF ID.
> >
> > With this change, attaching fexit probes to functions like do_exit() wi=
ll
> > be rejected.
> >
> > $ ./fexit
> > libbpf: prog 'fexit': BPF program load failed: -EINVAL
> > libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
> > Attaching fexit/fmod_ret to __noreturn functions is rejected.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 48 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 9971c03adfd5..b7d7d5c4989f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -22841,6 +22841,49 @@ BTF_ID(func, __rcu_read_unlock)
> >  #endif
> >  BTF_SET_END(btf_id_deny)
> >
> > +/* fexit and fmod_ret can't be used to attach to __noreturn functions.
> > + * Currently, we must manually list all __noreturn functions here. Onc=
e a more
> > + * robust solution is implemented, this workaround can be removed.
> > + */
> > +BTF_SET_START(noreturn_deny)
> > +#define NORETURN(fn) BTF_ID(func, fn)
>
> no need for extra macro. Just use BTF_ID(...) below.
>
> > +#ifdef CONFIG_IA32_EMULATION
> > +NORETURN(__ia32_sys_exit)
> > +NORETURN(__ia32_sys_exit_group)
> > +#endif
> > +#ifdef CONFIG_KUNIT
> > +NORETURN(__kunit_abort)
> > +NORETURN(kunit_try_catch_throw)
> > +#endif
> > +#ifdef CONFIG_MODULES
> > +NORETURN(__module_put_and_kthread_exit)
> > +#endif
> > +#ifdef CONFIG_X86_64
> > +NORETURN(__x64_sys_exit)
> > +NORETURN(__x64_sys_exit_group)
> > +#endif
> > +#ifdef CONFIG_XEN_PV_SMP
> > +NORETURN(cpu_bringup_and_idle)
> > +#endif
>
> it's called during bringup. bpf doesn't exist at that time.
> Drop it.
>
> > +NORETURN(do_exit)
> > +NORETURN(do_group_exit)
> > +#if defined(CONFIG_X86) && defined(CONFIG_SMP)
> > +NORETURN(hlt_play_dead)
> > +#endif
>
> This one is similar to panic.
> Drop it.
>
> > +#ifdef CONFIG_HYPERV
> > +NORETURN(hv_ghcb_terminate)
> > +#endif
>
> Also does 'hlt'.
> Drop it.
>
> > +NORETURN(kthread_complete_and_exit)
> > +NORETURN(kthread_exit)
> > +NORETURN(make_task_dead)
> > +#ifdef CONFIG_AMD_MEM_ENCRYPT
> > +NORETURN(sev_es_terminate)
> > +NORETURN(snp_abort)
>
> drop both for the same reason as above.
>
> > +#endif
> > +NORETURN(stop_this_cpu)
>
> and this one as well.
>
> Pls make sure to resend as series of 2 patches
> otherwise bpf CI will complain.

will change it.
Thanks for your review.

--=20
Regards
Yafang

