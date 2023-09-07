Return-Path: <bpf+bounces-9413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5375C79756E
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 17:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389C9281768
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 15:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D078012B95;
	Thu,  7 Sep 2023 15:51:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8397D12B63;
	Thu,  7 Sep 2023 15:51:22 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A37558F;
	Thu,  7 Sep 2023 08:50:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so1060929f8f.1;
        Thu, 07 Sep 2023 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694101789; x=1694706589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1qZO3bB1qLnyi3BBeYYJLFW/Yx+AHJhtzRJDvUCLS0=;
        b=DFCpv22ZyLD5yaD1rgG4TRfdIDx1DrZreh2HTpJsud+7vAYVN7QRtYAmw+ZzSxsHlG
         LSk+3FcvQLvZ36I5pSZrEhPssLwHrEUicltPzSiB1wCCubySW8fixh43U+oTmZRZcBb1
         c+eEaldwAcaSXlF7JhZ4oCJmrFNm7Jy3a1vtTuVpWr1xlVSNioTVnmdUGbZd+q0eY6FW
         06BS6FIglaeKxH0KlQ8exbX3xfDr/bci4mfaJt9eHlYLfMa9z+qfdCvg5tVYz32Zan5o
         Xpf4XGdJnpGTYA9uJPAU5lWHthU9w40DW2vantztwruvKh45cfaL/gzZE4ssg0eVnMe6
         Ygwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101789; x=1694706589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1qZO3bB1qLnyi3BBeYYJLFW/Yx+AHJhtzRJDvUCLS0=;
        b=Kxdu9d5PxHoxGH/Dn87mkvqgJ9ydKYum8lFMSUr5ez2t+b75RdK/P0vUvwy60XwRdQ
         WkGfpBg04FhIyq3g8RZucCw4/FdVisKy/eF+DnoibGgGf/5UMWGGFDvjfQx4wqvTUafC
         sqCDGyrOp+6iFRf2vvzz0goKUG6gZlvbADpAMMRjUdzbCpnILYKtdCUbXbbmOlqEPzoQ
         voLqJ+7hX0FoClHdtptCecEQGbEvKrqKfv90R9GhLZzwJ/ANV9mTc79+GErHeBv0CPOB
         i9L0h2OiIKojWYMejFNxNFFswEAMEB6ZZgYGXbIScZ2iwIvlLCV10Ty67nY2H3j3rkbB
         ucfA==
X-Gm-Message-State: AOJu0YzKgGWZfQy61AcbYbwklDWIqhFJazUA+dyw1CqC0hE4FPhMuqDO
	pVytLvCmJZL8lbKFHjFH9NjH9uehDLUIWy+PpHLtt0ZB
X-Google-Smtp-Source: AGHT+IEzyHI0pzl4GyAcfvVHqxzW9R7+ow58dqR5wh7sO7KF8defnlBtJxQLUBLD6GcB4+31JZ/vrhux8jTFEUcumP8=
X-Received: by 2002:a2e:9dc9:0:b0:2bc:ed75:1b0 with SMTP id
 x9-20020a2e9dc9000000b002bced7501b0mr5019343ljj.2.1694101258245; Thu, 07 Sep
 2023 08:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABcoxUbYwuZUL-xm1+5juO42nJMgpQX7cNyQELYz+g2XkZi9TQ@mail.gmail.com>
 <87o7ienuss.fsf@toke.dk> <CAP01T76Ce2KHQqTGsqs5K9RM5qSv07rNxnV+-=q_J25i9NkqxA@mail.gmail.com>
 <87fs3qnnh4.fsf@toke.dk>
In-Reply-To: <87fs3qnnh4.fsf@toke.dk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Sep 2023 08:40:46 -0700
Message-ID: <CAADnVQK-ov_rve4pM7McMDQd5E9U5-JPjT5522BaVWDH-NvM5g@mail.gmail.com>
Subject: Re: Possible deadlock in bpf queue map
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Hsin-Wei Hung <hsinweih@uci.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 6:04=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@kernel.org> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > On Thu, 7 Sept 2023 at 12:26, Toke H=C3=B8iland-J=C3=B8rgensen <toke@ke=
rnel.org> wrote:
> >>
> >> +Arnaldo
> >>
> >> > Hi,
> >> >
> >> > Our bpf fuzzer, a customized Syzkaller, triggered a lockdep warning =
in
> >> > the bpf queue map in v5.15. Since queue_stack_maps.c has no major ch=
anges
> >> > since v5.15, we think this should still exist in the latest kernel.
> >> > The bug can be occasionally triggered, and we suspect one of the
> >> > eBPF programs involved to be the following one. We also attached the=
 lockdep
> >> > warning at the end.
> >> >
> >> > #define DEFINE_BPF_MAP_NO_KEY(the_map, TypeOfMap, MapFlags,
> >> > TypeOfValue, MaxEntries) \
> >> >         struct {                                                    =
    \
> >> >             __uint(type, TypeOfMap);                                =
    \
> >> >             __uint(map_flags, (MapFlags));                          =
    \
> >> >             __uint(max_entries, (MaxEntries));                      =
    \
> >> >             __type(value, TypeOfValue);                             =
    \
> >> >         } the_map SEC(".maps");
> >> >
> >> > DEFINE_BPF_MAP_NO_KEY(map_0, BPF_MAP_TYPE_QUEUE, 0 | BPF_F_WRONLY,
> >> > struct_0, 162);
> >> > SEC("perf_event")
> >> > int func(struct bpf_perf_event_data *ctx) {
> >> >         char v0[96] =3D {};
> >> >         uint64_t v1 =3D 0;
> >> >         v1 =3D bpf_map_pop_elem(&map_0, v0);
> >> >         return 163819661;
> >> > }
> >> >
> >> >
> >> > The program is attached to the following perf event.
> >> >
> >> > struct perf_event_attr attr_type_hw =3D {
> >> >         .type =3D PERF_TYPE_HARDWARE,
> >> >         .config =3D PERF_COUNT_HW_CPU_CYCLES,
> >> >         .sample_freq =3D 50,
> >> >         .inherit =3D 1,
> >> >         .freq =3D 1,
> >> > };
> >> >
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3DWARNING: inconsistent lock state
> >> > 5.15.26+ #2 Not tainted
> >> > --------------------------------
> >> > inconsistent {INITIAL USE} -> {IN-NMI} usage.
> >> > syz-executor.5/19749 [HC1[1]:SC0[0]:HE0:SE1] takes:
> >> > ffff88804c9fc198 (&qs->lock){..-.}-{2:2}, at: __queue_map_get+0x31/0=
x250
> >> > {INITIAL USE} state was registered at:
> >> >   lock_acquire+0x1a3/0x4b0
> >> >   _raw_spin_lock_irqsave+0x48/0x60
> >> >   __queue_map_get+0x31/0x250
> >> >   bpf_prog_577904e86c81dead_func+0x12/0x4b4
> >> >   trace_call_bpf+0x262/0x5d0
> >> >   perf_trace_run_bpf_submit+0x91/0x1c0
> >> >   perf_trace_sched_switch+0x46c/0x700
> >> >   __schedule+0x11b5/0x24a0
> >> >   schedule+0xd4/0x270
> >> >   futex_wait_queue_me+0x25f/0x520
> >> >   futex_wait+0x1e0/0x5f0
> >> >   do_futex+0x395/0x1890
> >> >   __x64_sys_futex+0x1cb/0x480
> >> >   do_syscall_64+0x3b/0xc0
> >> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> >> > irq event stamp: 13640
> >> > hardirqs last  enabled at (13639): [<ffffffff95eb2bf4>]
> >> > _raw_spin_unlock_irq+0x24/0x40
> >> > hardirqs last disabled at (13640): [<ffffffff95eb2d4d>]
> >> > _raw_spin_lock_irqsave+0x5d/0x60
> >> > softirqs last  enabled at (13464): [<ffffffff93e26de5>] __sys_bpf+0x=
3e15/0x4e80
> >> > softirqs last disabled at (13462): [<ffffffff93e26da3>] __sys_bpf+0x=
3dd3/0x4e80
> >> >
> >> > other info that might help us debug this:
> >> >  Possible unsafe locking scenario:
> >> >
> >> >        CPU0
> >> >        ----
> >> >   lock(&qs->lock);
> >> >   <Interrupt>
> >> >     lock(&qs->lock);
> >>
> >> Hmm, so that lock() uses raw_spin_lock_irqsave(), which *should* be
> >> disabling interrupts entirely for the critical section. But I guess a
> >> Perf hardware event can still trigger? Which seems like it would
> >> potentially wreak havoc with lots of things, not just this queue map
> >> function?
> >>
> >> No idea how to protect against this, though. Hoping Arnaldo knows? :)
> >>
> >
> > The locking should probably be protected by a percpu integer counter,
> > incremented and decremented before and after the lock is taken,
> > respectively. If it is already non-zero, then -EBUSY should be
> > returned. It is similar to what htab_lock_bucket protects against in
> > hashtab.c.
>
> Ah, neat! Okay, seems straight-forward enough to replicate. Hsin, could
> you please check if the patch below gets rid of the splat?

Instead of adding all this complexity for the map that is so rarely used
it's easier to disallow it perf_event prog types.
Or add a single if (in_nmi()) return -EBUSY.

