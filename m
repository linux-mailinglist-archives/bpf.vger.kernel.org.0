Return-Path: <bpf+bounces-15013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1DE7EA62A
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 23:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D2DDB20A41
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 22:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517662D62D;
	Mon, 13 Nov 2023 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db3kv2uF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA7A249FA
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 22:54:07 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0350BD50;
	Mon, 13 Nov 2023 14:54:06 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50a71aac023so4847635e87.3;
        Mon, 13 Nov 2023 14:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699916044; x=1700520844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPzazopAtUp+EgOFQKTlhOdPvNnxkyd2UByDdcWqmgk=;
        b=db3kv2uFTFkzyATcKk9t7wWTDaCUnGluMbtrbFxRtQeU0/XgC4XRBlpcrKWIhB+UKU
         fcNNdPUFwLSfbscvBHIqycmy6UruxCA6dy7GentlaibcLTpIHlw5DsT4SPVA4Xvxc6H6
         i+AQ58h9RFDLVNhfhD0LDerhTyuzEzcpX/E2Vp2d8IKg+bpsHyA6S8VDj1iYsowGXnG9
         I0fts0BwNrYneeyk2A/mzgANhveNH7GzeDSMv7QOfxqsriAdvBmgseV83Yy0VU52xhmt
         epB2OfF3qy2bX5e1Oux4HQOwb8xzigu0m6TWqrsVNtyxWmXnPQHk2Cu1xZ15IMJ9mCv3
         VMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699916044; x=1700520844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPzazopAtUp+EgOFQKTlhOdPvNnxkyd2UByDdcWqmgk=;
        b=sn5EZqlZ3iqFGr9XLiSR7FNVKVFC91tTP/KyYQNuPzrcPo0NPZdcIB3Ccn4im9mXqq
         h3wkivTqwZcVptbc9l1BuFSy7Wqa+CumZxl1NTTdud+yXMGxb108IpOfXxwceknxTWVY
         G0KhndlrE02lljGyh8/47yY2cXIkLLIqti11zsvCDQa5ioVqAeuS/PNAYlgzyKFA1+cC
         KOpkLWE3H80npV3id4nZZY1TzxsMPUSJ+W1xYEeWD5zEcxsupQjllUc4d00dMa2CHvW8
         7eKQBimZaJtr85w34Urmkyj+qxsjVOHeauGgjwG0KMWe+Tx9pW551wHbOXwxFPN4D+Wq
         DCEQ==
X-Gm-Message-State: AOJu0YxrH3Fd2ow/TXTHlrYrmfJtRjbN+MmTL+HfvJ67lmpB/+iLI0c0
	dfd18Ip8qg2ERDzsEoX2z+L60Q8RCCKyNX2xsyxqprFVyIQZH621
X-Google-Smtp-Source: AGHT+IE2bTUx0LhkZZJH+vP5uJOdSWaGyU3nUDdSamSvabzCzRXojWIN5VyaTGMJJLe06hGlnsX8P69m2vKy+T4pCYk=
X-Received: by 2002:a05:6512:32b3:b0:509:cc4:f23a with SMTP id
 q19-20020a05651232b300b005090cc4f23amr4786433lfe.64.1699916043876; Mon, 13
 Nov 2023 14:54:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230917000045.56377-1-puranjay12@gmail.com> <20230917000045.56377-2-puranjay12@gmail.com>
 <ZUPVbrMSNNwPw_B-@FVFF77S0Q05N.cambridge.arm.com> <CANk7y0g8SOrSAY2jqZ22v6Duu9yhHY-d39g5gJ2vA2j2Y-v53Q@mail.gmail.com>
 <ZUtjyxBheN-dbj84@FVFF77S0Q05N>
In-Reply-To: <ZUtjyxBheN-dbj84@FVFF77S0Q05N>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 13 Nov 2023 23:53:52 +0100
Message-ID: <CANk7y0hvEu3WkYEJ5oRqRHwKGfDnM+fO0=vDen5=zO8-rCvr9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf, arm64: support exceptions
To: Mark Rutland <mark.rutland@arm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Nov 8, 2023 at 11:32=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Mon, Nov 06, 2023 at 10:04:09AM +0100, Puranjay Mohan wrote:
> > Hi Mark,
> >
> > On Thu, Nov 2, 2023 at 5:59=E2=80=AFPM Mark Rutland <mark.rutland@arm.c=
om> wrote:
> > >
> > > On Sun, Sep 17, 2023 at 12:00:45AM +0000, Puranjay Mohan wrote:
> > > > Implement arch_bpf_stack_walk() for the ARM64 JIT. This will be use=
d
> > > > by bpf_throw() to unwind till the program marked as exception bound=
ary and
> > > > run the callback with the stack of the main program.
> > > >
> > > > The prologue generation code has been modified to make the callback
> > > > program use the stack of the program marked as exception boundary w=
here
> > > > callee-saved registers are already pushed.
> > > >
> > > > As the bpf_throw function never returns, if it clobbers any callee-=
saved
> > > > registers, they would remain clobbered. So, the prologue of the
> > > > exception-boundary program is modified to push R23 and R24 as well,
> > > > which the callback will then recover in its epilogue.
> > > >
> > > > The Procedure Call Standard for the Arm 64-bit Architecture[1] stat=
es
> > > > that registers r19 to r28 should be saved by the callee. BPF progra=
ms on
> > > > ARM64 already save all callee-saved registers except r23 and r24. T=
his
> > > > patch adds an instruction in prologue of the  program to save these
> > > > two registers and another instruction in the epilogue to recover th=
em.
> > > >
> > > > These extra instructions are only added if bpf_throw() used. Otherw=
ise
> > > > the emitted prologue/epilogue remains unchanged.
> > > >
> > > > [1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs6=
4.rst
> > > >
> > > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > > ---
> > >
> > > [...]
> > >
> > > > +void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, =
u64 sp, u64 bp), void *cookie)
> > > > +{
> > > > +     struct stack_info stacks[] =3D {
> > > > +             stackinfo_get_task(current),
> > > > +     };
> > >
> > > Can bpf_throw() only be used by BPF programs that run in task context=
, or is it
> > > possible e.g. for those to run within an IRQ handler (or otherwise on=
 the IRQ
> > > stack)?
> >
> > I will get back on this with more information.
> >
> > >
> > > > +
> > > > +     struct unwind_state state =3D {
> > > > +             .stacks =3D stacks,
> > > > +             .nr_stacks =3D ARRAY_SIZE(stacks),
> > > > +     };
> > > > +     unwind_init_common(&state, current);
> > > > +     state.fp =3D (unsigned long)__builtin_frame_address(1);
> > > > +     state.pc =3D (unsigned long)__builtin_return_address(0);
> > > > +
> > > > +     if (unwind_next_frame_record(&state))
> > > > +             return;
> > > > +     while (1) {
> > > > +             /* We only use the fp in the exception callback. Pass=
 0 for sp as it's unavailable*/
> > > > +             if (!consume_fn(cookie, (u64)state.pc, 0, (u64)state.=
fp))
> > > > +                     break;
> > > > +             if (unwind_next_frame_record(&state))
> > > > +                     break;
> > > > +     }
> > > > +}
> > >
> > > IIUC you're not using arch_stack_walk() because you need the FP in ad=
dition to
> > > the PC.
> >
> > Yes,
> >
> > > Is there any other reason you need to open-code this?
> >
> > No,
> >
> > >
> > > If not, I'd rather rework the common unwinder so that it's possible t=
o get at
> > > the FP. I had patches for that a while back:
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/=
?h=3Darm64/stacktrace/metadata
> > >
> > > ... and I'm happy to rebase that and pull out the minimum necessary t=
o make
> > > that possible.
> >
> > It would be great if you can rebase and push the code, I can rebase thi=
s on
> > your work and not open code this implementation.
>
> I've rebased the core of that atop v6.6, and pushed that out to my
> arm64/stacktrace/kunwind branch:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=
=3Darm64/stacktrace/kunwind
>
> Once v6.7-rc1 is out, I'll rebase that and post it out (possibly with som=
e of
> the other patches atop).
>
> With that I think you can implement arch_bpf_stack_walk() in stacktrace.c=
 using
> kunwind_stack_walk() in a similar way to how arch_stack_walk() is impleme=
nted
> in that branch.
>
> If BPF only needs a single consume_fn, that can probably be even simpler =
as you
> won't need a struct to hold the consume_fn and cookie value.

Thanks for the help.
I am planning to do something like the following:
let me know if this can be done in a better way:

+struct bpf_unwind_consume_entry_data {
+       bool (*consume_entry)(void *cookie, u64 ip, u64 sp, u64 fp);
+       void *cookie;
+};
+
+static bool
+arch_bpf_unwind_consume_entry (const struct kunwind_state *state, void *co=
okie)
+{
+       struct bpf_unwind_consume_entry_data *data =3D cookie;
+       return data->consume_entry(data->cookie, state->common.pc, 0,
state->common.fp);
+}
+
+noinline noinstr void arch_bpf_stack_walk(bool (*consume_entry)(void
*cookie, u64 ip, u64 sp,
+                                         u64 fp), void *cookie)
+{
+       struct bpf_unwind_consume_entry_data data =3D {
+               .consume_entry =3D consume_entry,
+               .cookie =3D cookie,
+       };

I need to get the task and regs here so it can work from all contexts.
How can I do it?

+
+       kunwind_stack_walk(arch_bpf_unwind_consume_entry, &data, task, regs=
);
+}


>
> Mark.



Thanks,
Puranjay

