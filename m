Return-Path: <bpf+bounces-38453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BD4964EC5
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F9D1C22E08
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A741B9B34;
	Thu, 29 Aug 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg7EsqpN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5E3AC28;
	Thu, 29 Aug 2024 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959594; cv=none; b=HknDNO7KE3IulPoEAxQ9bQWCB83FF+5nCjtPYaETO6VuB20yEssJ4283qTlhVNc4c1y1+87/LK9FjRqzEqj45U9UEyyk8Lf49wiZ0hq4obnBtG9Km94SaHihpEvjqR+pXmn4w1OpVgi6IgRGnmDCZfT9bFe5LBG4jtvZAkURKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959594; c=relaxed/simple;
	bh=98XiTTL0PQ8U/PP4inw+3MrLbFzfXfKjXHK9uMAazXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beIXRZ1w6lmNxUqEL8Kmy25tbmqBSnU3Gn7axbX0uU+DwqLIAi/8v9lqVbquRkN7oSgBk2g2s6ZDDXKyMpH4WhhQZuzxLnF4QThwy6vay8wSAcNwCF+p6WCMR84YdfRVNPjNvWhoq51wvldmnuYsX3oznGkwHFmON7AeV9EvSXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dg7EsqpN; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d439572aeaso807812a91.1;
        Thu, 29 Aug 2024 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724959592; x=1725564392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9J0LOZCD9Yit1u6ZMfKdLolBj1C82j/ILw3Pu2OeUHQ=;
        b=Dg7EsqpNjkucf9BHWQ8eb7Og++SDwHi2nYioFuF4DT5MdZOK1CuYm1jDmRDSlm8EVd
         HlhVHW7+d9brdDLyDRrluArCiqm4zMRV3Q4/xZt85CHhMm26EpUOnvcSGFaYlMyF4CYb
         5a6KGqYJ+MpR8uk7l3v3lctnnq9lDu+VVYIhjW2SPv8Jw0kg2CLsLQR7pQ1rGBu/kwWJ
         8V8ogCzqVWhFThpnYi5l0gswCEaUCD779fagtP3ZYL4apWmo8ZJfeI+FmJHlGQRsQ/TN
         usKSAwzJ5XMah6MIuHFdQgI34NhNtRb2in5x6jrWvFjEMWYsy+PpUJsG1Y+pHEmKK89h
         wveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724959592; x=1725564392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9J0LOZCD9Yit1u6ZMfKdLolBj1C82j/ILw3Pu2OeUHQ=;
        b=eG2dIw9nISLXzjJqtfB7/vY4meXpEX8vWbMoKWwu6OUZ5wiDDsXTQ0obo2i4VhQe3u
         ZvVhcmezdp7IarrJpoNozzoD/XD4Pgapa2YUyMu52Pbuq2TNSFiyiTG3183z6y5IbdKO
         GDHs9tYN62THdFOGc/ocl7nO0DorzD0YdNMqd1/ps+y+OXfjB/nq/Hh+NCBMA391m0gq
         shrekPrd8S+zErJBtPFfEAqqYfwI3H9D4HZzaNqgN5n/en+L/B6N6IzWTtjHOq6JaTCB
         OiyHZHKNEaXGjcF3ydTDJbYDeOoBd8sZ7Vf3P5o4zuuL/gZ6/+/kzJL/oW+6dzZdTEzE
         qzlA==
X-Forwarded-Encrypted: i=1; AJvYcCUX81A028lUOtOqzrM0KUHVI8uWjx4SNpb/glFKqI93wFGBQmjqsqB6d7GU3yIsUDOnlkI=@vger.kernel.org, AJvYcCW/AFhTV5Mu72Ic85iuL4/cBwx2zqnmbiP1CMtTSQLfEIYHJzT+SBtvS7OElnEkBSUTF4FwpVBAv0XmeXTrptDaRKUM@vger.kernel.org, AJvYcCXfdMGGHrK0fnJk656hoQOVjta19UTxFk/qiBOZKHK38afdCUmEeMO+wWAjrXY2l3hnd3xjEnuVA3m/Wukg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb51JGwLNCNB2302VLT9c58/dfT8decrba7jZ1jLvX5vG2Ruom
	zL030LEPRrWbVwkWmi0urQcRL1zMLhI91McI98rx6YZDY8cMtSm4TnQw1/uEaX/YEpZGN+tMUSa
	q2LZzaQ4vezJVt9GdjElEATi5ijA=
X-Google-Smtp-Source: AGHT+IEXvTyKX1QnhmoYRG8oaAvf4yW1XtzWmyzs/+4KM9m0wNyV0e/nQqC/kFvsLYrGsije7OFBaVdzSpm56K/hg9g=
X-Received: by 2002:a17:90a:7807:b0:2c9:75a7:5c25 with SMTP id
 98e67ed59e1d1-2d856c7e4e8mr4821455a91.15.1724959591532; Thu, 29 Aug 2024
 12:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814080356.2639544-1-liaochang1@huawei.com>
 <Zr3RN4zxF5XPgjEB@J2N7QTR9R3> <f95fc55b-2f17-7333-2eae-52caae46f8b2@huawei.com>
 <8cc13794-30a7-a30b-2ac9-4d151499d184@huawei.com>
In-Reply-To: <8cc13794-30a7-a30b-2ac9-4d151499d184@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Aug 2024 12:26:19 -0700
Message-ID: <CAEf4BzbPRX2pTJBmwA081Wj+BqGwrNZytzq+=-ftzRRj=xWM_A@mail.gmail.com>
Subject: Re: [PATCH] arm64: insn: Simulate nop and push instruction for better
 uprobe performance
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com, will@kernel.org, 
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	puranjay@kernel.org, ast@kernel.org, andrii@kernel.org, xukuohai@huawei.com, 
	revest@chromium.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:34=E2=80=AFAM Liao, Chang <liaochang1@huawei.com>=
 wrote:
>
> Hi, Mark
>
> Would you like to discuss this patch further, or do you still believe emu=
lating
> STP to push FP/LR into the stack in kernel is not a good idea?
>

Please send an updated version of your patches taking into account
various smaller issues Mark pointed out. But please keep STP
emulation, I think it's very important, even if it's not covering all
possible uprobe tracing scenarios.

> Thanks.
>
>
> =E5=9C=A8 2024/8/21 15:55, Liao, Chang =E5=86=99=E9=81=93:
> > Hi, Mark
> >
> > My bad for taking so long to rely, I generally agree with your suggesti=
ons to
> > STP emulation.
> >
> > =E5=9C=A8 2024/8/15 17:58, Mark Rutland =E5=86=99=E9=81=93:
> >> On Wed, Aug 14, 2024 at 08:03:56AM +0000, Liao Chang wrote:
> >>> As Andrii pointed out, the uprobe/uretprobe selftest bench run into a
> >>> counterintuitive result that nop and push variants are much slower th=
an
> >>> ret variant [0]. The root cause lies in the arch_probe_analyse_insn()=
,
> >>> which excludes 'nop' and 'stp' from the emulatable instructions list.
> >>> This force the kernel returns to userspace and execute them out-of-li=
ne,
> >>> then trapping back to kernel for running uprobe callback functions. T=
his
> >>> leads to a significant performance overhead compared to 'ret' variant=
,
> >>> which is already emulated.
> >>
> >> I appreciate this might be surprising, but does it actually matter
> >> outside of a microbenchmark?
> >
> > I just do a simple comparsion the performance impact of single-stepped =
and
> > emulated STP on my local machine. Three user cases were measured: Redis=
 GET and
> > SET throughput (Request Per Second, RPS), and the time taken to execute=
 a grep
> > command on the "arch_uprobe_copy_xol" string within the kernel source.
> >
> > Redis GET (higher is better)
> > ----------------------------
> > No uprobe: 49149.71 RPS
> > Single-stepped STP: 46750.82 RPS
> > Emulated STP: 48981.19 RPS
> >
> > Redis SET (larger is better)
> > ----------------------------
> > No uprobe: 49761.14 RPS
> > Single-stepped STP: 45255.01 RPS
> > Emulated stp: 48619.21 RPS
> >
> > Grep (lower is better)
> > ----------------------
> > No uprobe: 2.165s
> > Single-stepped STP: 15.314s
> > Emualted STP: 2.216s
> >
> > The result reveals single-stepped STP instruction that used to push fp/=
lr into
> > stack significantly impacts the Redis and grep performance, leading to =
a notable
> > notable decrease RPS and increase time individually. So emulating STP o=
n the
> > function entry might be a more viable option for uprobe.
> >
> >>
> >>> Typicall uprobe is installed on 'nop' for USDT and on function entry
> >>> which starts with the instrucion 'stp x29, x30, [sp, #imm]!' to push =
lr
> >>> and fp into stack regardless kernel or userspace binary.
> >>
> >> Function entry doesn't always start with a STP; these days it's often =
a
> >> BTI or PACIASP, and for non-leaf functions (or with shrink-wrapping in
> >> the compiler), it could be any arbitrary instruction. This might happe=
n
> >> to be the common case today, but there are certain;y codebases where i=
t
> >> is not.
> >
> > Sure, if kernel, CPU and compiler support BTI and PAC, the entry instru=
ction
> > is definitly not STP. But for CPU and kernel lack of these supports, ST=
P as
> > the entry instruction is still the common case. And I profiled the entr=
y
> > instruction for all leaf and non-leaf function, the ratio of STP is 64.=
5%
> > for redis, 76.1% for the BPF selftest bench. So I am thinking it is sti=
ll
> > useful to emulate the STP on the function entry. Perhaps, for CPU and k=
ernel
> > with BTI and PAC enabled, uprobe chooses the slower single-stepping to =
execute
> > STP for pushing stack.
> >
> >>
> >> STP (or any instruction that accesses memory) is fairly painful to
> >> emulate because you need to ensure that the correct atomicity and
> >> ordering properties are provided (e.g. an aligned STP should be
> >> single-copy-atomic, but copy_to_user() doesn't guarantee that except b=
y
> >> chance), and that the correct VMSA behaviour is provided (e.g. when
> >> interacting with MTE, POE, etc, while the uaccess primitives don't try
> >> to be 100% equivalent to instructions in userspace).
> > Agreed, but I don't think it has to emulate strictly the single-copy-at=
omic
> > feature of STP that is used to push fp/lr into stack. In most cases, on=
ly one
> > CPU will push registers to the same position on stack. And I barely und=
erstand
> > why other CPUs would depends on the ordering of pushing data into stack=
. So it
> > means the atomicity and ordering is not so important for this scenario.=
 Regarding
> > MTE and POE, a similar stragety to BTI and PAC can be applied: for CPUs=
 and kernel
> > with MTE and POE enabled, uprobe chooses the slower single-stepping to =
execute
> > STP for pushing stack.
> >
> >>
> >> For those reasons, in general I don't think we should be emulating any
> >> instruction which accesses memory, and we should not try to emulate th=
e
> >> STP, but I think it's entirely reasonable to emulate NOP.
> >>
> >>> In order to
> >>> improve the performance of handling uprobe for common usecases. This
> >>> patch supports the emulation of Arm64 equvialents instructions of 'no=
p'
> >>> and 'push'. The benchmark results below indicates the performance gai=
n
> >>> of emulation is obvious.
> >>>
> >>> On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Arm64 cores@2.4GHz.
> >>>
> >>> xol (1 cpus)
> >>> ------------
> >>> uprobe-nop:  0.916 =C2=B1 0.001M/s (0.916M/prod)
> >>> uprobe-push: 0.908 =C2=B1 0.001M/s (0.908M/prod)
> >>> uprobe-ret:  1.855 =C2=B1 0.000M/s (1.855M/prod)
> >>> uretprobe-nop:  0.640 =C2=B1 0.000M/s (0.640M/prod)
> >>> uretprobe-push: 0.633 =C2=B1 0.001M/s (0.633M/prod)
> >>> uretprobe-ret:  0.978 =C2=B1 0.003M/s (0.978M/prod)
> >>>
> >>> emulation (1 cpus)
> >>> -------------------
> >>> uprobe-nop:  1.862 =C2=B1 0.002M/s  (1.862M/prod)
> >>> uprobe-push: 1.743 =C2=B1 0.006M/s  (1.743M/prod)
> >>> uprobe-ret:  1.840 =C2=B1 0.001M/s  (1.840M/prod)
> >>> uretprobe-nop:  0.964 =C2=B1 0.004M/s  (0.964M/prod)
> >>> uretprobe-push: 0.936 =C2=B1 0.004M/s  (0.936M/prod)
> >>> uretprobe-ret:  0.940 =C2=B1 0.001M/s  (0.940M/prod)
> >>>
> >>> As shown above, the performance gap between 'nop/push' and 'ret'
> >>> variants has been significantly reduced. Due to the emulation of 'pus=
h'
> >>> instruction needs to access userspace memory, it spent more cycles th=
an
> >>> the other.
> >>>
> >>> [0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zL=
n02ezZ5YruVuQw@mail.gmail.com/
> >>>
> >>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >>> ---
> >>>  arch/arm64/include/asm/insn.h            | 21 ++++++++++++++++++
> >>>  arch/arm64/kernel/probes/decode-insn.c   | 18 +++++++++++++--
> >>>  arch/arm64/kernel/probes/decode-insn.h   |  3 ++-
> >>>  arch/arm64/kernel/probes/simulate-insn.c | 28 ++++++++++++++++++++++=
++
> >>>  arch/arm64/kernel/probes/simulate-insn.h |  2 ++
> >>>  arch/arm64/kernel/probes/uprobes.c       |  2 +-
> >>>  6 files changed, 70 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/i=
nsn.h
> >>> index 8c0a36f72d6f..a246e6e550ba 100644
> >>> --- a/arch/arm64/include/asm/insn.h
> >>> +++ b/arch/arm64/include/asm/insn.h
> >>> @@ -549,6 +549,27 @@ static __always_inline bool aarch64_insn_uses_li=
teral(u32 insn)
> >>>            aarch64_insn_is_prfm_lit(insn);
> >>>  }
> >>>
> >>> +static __always_inline bool aarch64_insn_is_nop(u32 insn)
> >>> +{
> >>> +   /* nop */
> >>> +   return aarch64_insn_is_hint(insn) &&
> >>> +          ((insn & 0xFE0) =3D=3D AARCH64_INSN_HINT_NOP);
> >>> +}
> >>
> >> This looks fine, but the comment can go.
> >
> > Removed.
> >
> >>
> >>> +static __always_inline bool aarch64_insn_is_stp_fp_lr_sp_64b(u32 ins=
n)
> >>> +{
> >>> +   /*
> >>> +    * The 1st instruction on function entry often follows the
> >>> +    * patten 'stp x29, x30, [sp, #imm]!' that pushing fp and lr
> >>> +    * into stack.
> >>> +    */
> >>> +   return aarch64_insn_is_stp_pre(insn) &&
> >>> +          (((insn >> 30) & 0x03) =3D=3D  2) && /* opc =3D=3D 10 */
> >>> +          (((insn >>  5) & 0x1F) =3D=3D 31) && /* Rn  is sp */
> >>> +          (((insn >> 10) & 0x1F) =3D=3D 30) && /* Rt2 is x29 */
> >>> +          (((insn >>  0) & 0x1F) =3D=3D 29);   /* Rt  is x30 */
> >>> +}
> >>
> >> We have accessors for these fields. Please use them.
> >
> > Do you mean aarch64_insn_decode_register()?
> >
> >>
> >> Regardless, as above I do not think we should have a helper this
> >> specific (with Rn, Rt, and Rt2 values hard-coded) inside <asm/insn.h>.
> >
> > If we left necessary of emulation of STP aside, where would the best fi=
le to
> > place these hard-coded decoder helper?
> >
> >>
> >>>  enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
> >>>  u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u=
32 insn);
> >>>  u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
> >>> diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kern=
el/probes/decode-insn.c
> >>> index 968d5fffe233..df7ca16fc763 100644
> >>> --- a/arch/arm64/kernel/probes/decode-insn.c
> >>> +++ b/arch/arm64/kernel/probes/decode-insn.c
> >>> @@ -73,8 +73,22 @@ static bool __kprobes aarch64_insn_is_steppable(u3=
2 insn)
> >>>   *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use i=
ts slot.
> >>>   */
> >>>  enum probe_insn __kprobes
> >>> -arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *a=
pi)
> >>> +arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *a=
pi,
> >>> +                 bool kernel)
> >>>  {
> >>> +   /*
> >>> +    * While 'nop' and 'stp x29, x30, [sp, #imm]! instructions can
> >>> +    * execute in the out-of-line slot, simulating them in breakpoint
> >>> +    * handling offers better performance.
> >>> +    */
> >>> +   if (aarch64_insn_is_nop(insn)) {
> >>> +           api->handler =3D simulate_nop;
> >>> +           return INSN_GOOD_NO_SLOT;
> >>> +   } else if (!kernel && aarch64_insn_is_stp_fp_lr_sp_64b(insn)) {
> >>> +           api->handler =3D simulate_stp_fp_lr_sp_64b;
> >>> +           return INSN_GOOD_NO_SLOT;
> >>> +   }
> >>
> >> With the STP emulation gone, you won't need the kernel parameter here.=
>
> >>> +
> >>>     /*
> >>>      * Instructions reading or modifying the PC won't work from the X=
OL
> >>>      * slot.
> >>> @@ -157,7 +171,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, str=
uct arch_specific_insn *asi)
> >>>             else
> >>>                     scan_end =3D addr - MAX_ATOMIC_CONTEXT_SIZE;
> >>>     }
> >>> -   decoded =3D arm_probe_decode_insn(insn, &asi->api);
> >>> +   decoded =3D arm_probe_decode_insn(insn, &asi->api, true);
> >>>
> >>>     if (decoded !=3D INSN_REJECTED && scan_end)
> >>>             if (is_probed_address_atomic(addr - 1, scan_end))
> >>> diff --git a/arch/arm64/kernel/probes/decode-insn.h b/arch/arm64/kern=
el/probes/decode-insn.h
> >>> index 8b758c5a2062..ec4607189933 100644
> >>> --- a/arch/arm64/kernel/probes/decode-insn.h
> >>> +++ b/arch/arm64/kernel/probes/decode-insn.h
> >>> @@ -28,6 +28,7 @@ enum probe_insn __kprobes
> >>>  arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_i=
nsn *asi);
> >>>  #endif
> >>>  enum probe_insn __kprobes
> >>> -arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *a=
si);
> >>> +arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *a=
si,
> >>> +                 bool kernel);
> >>>
> >>>  #endif /* _ARM_KERNEL_KPROBES_ARM64_H */
> >>> diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/ke=
rnel/probes/simulate-insn.c
> >>> index 22d0b3252476..0b1623fa7003 100644
> >>> --- a/arch/arm64/kernel/probes/simulate-insn.c
> >>> +++ b/arch/arm64/kernel/probes/simulate-insn.c
> >>> @@ -200,3 +200,31 @@ simulate_ldrsw_literal(u32 opcode, long addr, st=
ruct pt_regs *regs)
> >>>
> >>>     instruction_pointer_set(regs, instruction_pointer(regs) + 4);
> >>>  }
> >>> +
> >>> +void __kprobes
> >>> +simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
> >>> +{
> >>> +   instruction_pointer_set(regs, instruction_pointer(regs) + 4);
> >>> +}
> >>
> >> Hmm, this forgets to update the single-step state machine and PSTATE.B=
T,
> >> and that's an extant bug in arch_uprobe_post_xol(). This can be:
> >
> > For emulated instruction, uprobe won't enable single-step mode of CPU,
> > please check the handle_swbp() in kernel/events/uprobes.c:
> >
> >   if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
> >           goto out;
> >
> >   if (!pre_ssout(uprobe, regs, bp_vaddr))
> >           return;
> >
> > For emualted instruction, It will skip entire single-stepping and assoc=
iated
> > exception, which typically begins with pre_ssout() and ends with
> > arch_uprobe_post_xol(). Therefore, using instruction_pointer_set() to e=
mulate
> > NOP is generally not a bad idea.
> >
> >>
> >> | void __kprobes
> >> | simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
> >> | {
> >> |    arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> >> | }
> >>
> >>> +
> >>> +void __kprobes
> >>> +simulate_stp_fp_lr_sp_64b(u32 opcode, long addr, struct pt_regs *reg=
s)
> >>> +{
> >>> +   long imm7;
> >>> +   u64 buf[2];
> >>> +   long new_sp;
> >>> +
> >>> +   imm7 =3D sign_extend64((opcode >> 15) & 0x7f, 6);
> >>> +   new_sp =3D regs->sp + (imm7 << 3);
> >>
> >> We have accessors for these fields, please use them.
> >
> > Do you mean aarch64_insn_decode_immediate()?
> >
> >>
> >>> +
> >>> +   buf[0] =3D regs->regs[29];
> >>> +   buf[1] =3D regs->regs[30];
> >>> +
> >>> +   if (copy_to_user((void __user *)new_sp, buf, sizeof(buf))) {
> >>> +           force_sig(SIGSEGV);
> >>> +           return;
> >>> +   }
> >>
> >> As above, this won't interact with VMSA features (e.g. MTE, POE) in th=
e
> >> same way as an STP in userspace, and this will not have the same
> >> atomicity properties as an STP>
> >>> +
> >>> +   regs->sp =3D new_sp;
> >>> +   instruction_pointer_set(regs, instruction_pointer(regs) + 4);
> >>
> >> Likewise, this sould need ot use arm64_skip_faulting_instruction(),
> >> though as above I think we should drop STP emulation entirely.
> >
> > I explain the reason why using instruction_pointer_set() under your com=
ments
> > for simulate_nop().
> >
> > Thanks.
> >
> >>
> >> Mark.
> >>
> >
>
> --
> BR
> Liao, Chang
>

