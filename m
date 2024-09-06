Return-Path: <bpf+bounces-39154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530A596FA17
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 19:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4091C2338C
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 17:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB041D67A1;
	Fri,  6 Sep 2024 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpFED3at"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A981D54FC;
	Fri,  6 Sep 2024 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725644775; cv=none; b=jY5cHihwGvcw2ytbSfjj4Hlf52+niB/FGuU0LAa6dAwTzDsU4pq9iyFIt+Gfjb2r3Ji5AL0fEEQYRVW65tqJHYDBxFVd2/t/kDKoZDZp5aFoWH3g5LONdy4EMRhNVyXFG5Hh+0RbkPR/L+7CntQLSMJ9yrCKBDTxnI46pqNa6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725644775; c=relaxed/simple;
	bh=1EdSolMbqrhtSQvTFdMIftWK3dAFOYLqvQOIJvZh48I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tS0NZ5UpoJIyCaT0plMcablgLHM3VGmpObr7LTrMSt5hs8JaMFc3OzXB0idAsaOuVqC1mm44wkGluHO5GJ8TNwXDKKvaeHLOrUzXMEDPdzFi5EfkqWKSufBhokxuGN3RL9JKqY4IB3jfq3jUtKtkSId1glEKhZU1J5ylnxQPBMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpFED3at; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8a744aa9bso1673000a91.3;
        Fri, 06 Sep 2024 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725644773; x=1726249573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MunaMAGA4p4/sv+E147autv8egKDEreFDyZPwIOZz4=;
        b=QpFED3atkDNkEw0IePJ1X4TJQygEuFfJmkT3mpt5AwRlgpgM1AsiZf9YyhicOpQe5V
         7gMvhAcHvkZp3w3qvUM29JoAd0U63HKBrz0/s9KkfxO9+6+IlOhaq9AnC3Xw2Igj1CCJ
         eLOV1tWXOwtYBu7TJr6kxb9+/rrMHdpSvU+VnJmOVBn8Ca/Yu8jyU9lAnjZRYHX/hvcL
         rtEtlV6zKNMpDDEeit3r+oFDEkWNve9AaE2l2Q9fYkYzN39C/8RJD1N9yMJd14so7RMS
         ROJ0WyhLg2my13w/aibHFkoDdlugRPVFNo3gPcoEwxzdSNwCci+IB8zQipeSrUEdOl0o
         d5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725644773; x=1726249573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MunaMAGA4p4/sv+E147autv8egKDEreFDyZPwIOZz4=;
        b=fAJdpu00EFFT7HiOFeO+Q30l8JBSfhLTyg8Qw6JzwpI0R546f76drhIISEq3d1QM72
         0HwEtsEwqWeZI70VyrlIZAvTcWC5lXOqDNJxM/rpN4kD97llBOoXVcSPCUY1macdpXc5
         jsUkQYhmVx0ttazRZoMWeDQ0oALeFWghRXhzRHXVZH51WIRvccA0OuL2SzeAbfdd3fPR
         9AEoZVH+1otOYEehRjdZG+raMFT11nhmpZEpfK3Ok9F6GlLmjfSSFa7PWBAvvRkaY/Ay
         GLk1TwCvAr3gTkpZTqOpixT85hERO3GNblfcOQncUBj5OwsT0M9/n5pxQXTbI9slGOMq
         vkQA==
X-Forwarded-Encrypted: i=1; AJvYcCX5tdhqzWys/p90ROSvih9Fji9dgs+5clIF5c1gVjD9cqYEGWyKZepRcjbTzZaHNI6nZLI=@vger.kernel.org, AJvYcCXAu3q3dwCd1Nb9xe4RJ0v1CsZQsndv0Ki9QQUKXpmyXo6SwjJWOQxhkG+pJJTYajTsNyBKy0rObZWPXuIwah4k6xoH@vger.kernel.org, AJvYcCXD1aLYskNxQu0i1EbKxnT/b356sl3mfRVbN5hT6et2jesl0XGKN4RDplWBPFU8j22LwREDJ+HpUTFA+fm3@vger.kernel.org
X-Gm-Message-State: AOJu0YwXR+vYFhYDMqulI1aclGnzNZs8KMrwffDIFN0YbL7mSIPVhLUH
	MuOS+v/6Nkg2R9xVHiSCjEvcXL7D3wy7rYS9ozaiUnsBPAPkH/XnL8uVzQr3W6z5ZVeAf97O8o/
	GOXLpjGJOnNmFXRku4dmCuNaKd0148ulB
X-Google-Smtp-Source: AGHT+IFgEvxGdQlU8vOZo1Z9nlqoxWMcs+RADXWsawBCc0fNlj4EXvm1GsmhBM+Mf+0dBJH8Lkf/a8tmeFjnAApmh/E=
X-Received: by 2002:a17:90b:3810:b0:2d3:d68e:e8d8 with SMTP id
 98e67ed59e1d1-2dad513cd89mr3291651a91.40.1725644772879; Fri, 06 Sep 2024
 10:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814080356.2639544-1-liaochang1@huawei.com>
 <Zr3RN4zxF5XPgjEB@J2N7QTR9R3> <f95fc55b-2f17-7333-2eae-52caae46f8b2@huawei.com>
 <8cc13794-30a7-a30b-2ac9-4d151499d184@huawei.com> <ZtrN4eWwrSWTMGmD@J2N7QTR9R3>
In-Reply-To: <ZtrN4eWwrSWTMGmD@J2N7QTR9R3>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 10:46:00 -0700
Message-ID: <CAEf4BzYn3EkVVk4dnWMBMKa16y_ZFvQp3ZcdM44a2LeS08S6FQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: insn: Simulate nop and push instruction for better
 uprobe performance
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Liao, Chang" <liaochang1@huawei.com>, catalin.marinas@arm.com, will@kernel.org, 
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	puranjay@kernel.org, ast@kernel.org, andrii@kernel.org, xukuohai@huawei.com, 
	revest@chromium.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 2:39=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Tue, Aug 27, 2024 at 07:33:55PM +0800, Liao, Chang wrote:
> > Hi, Mark
> >
> > Would you like to discuss this patch further, or do you still believe e=
mulating
> > STP to push FP/LR into the stack in kernel is not a good idea?
>
> I'm happy with the NOP emulation in principle, so please send a new
> version with *just* the NOP emulation, and I can review that.

Let's definitely start with that, this is important for faster USDT tracing=
.

>
> Regarding STP emulation, I stand by my earlier comments, and in addition
> to those comments, AFAICT it's currently unsafe to use any uaccess
> routine in the uprobe BRK handler anyway, so that's moot. The uprobe BRK
> handler runs with preemption disabled and IRQs (and all other maskable
> exceptions) masked, and faults cannot be handled. IIUC
> CONFIG_DEBUG_ATOMIC_SLEEP should scream about that.

This part I don't really get, and this might be some very
ARM64-specific issue, so I'm sorry ahead of time.

But in general, at the lowest level uprobes work in two logical steps.
First, there is a breakpoint that user space hits, kernel gets
control, and if VMA which hit breakpoint might contain uprobe, kernel
sets TIF_UPROBE thread flag and exits. This is the only part that's in
hard IRQ context. See uprobe_notify_resume() and comments around it.

Then uprobe infrastructure gets called in user context on the way back
to user space. This is where we confirm that this is uprobe/uretprobe
hit, and, if supported, perform instruction emulation.

So I'm wondering if your above comment refers to instruction emulation
within the first part of uprobe handling? If yes, then, no, that's not
where emulation will happen.

>
> Longer-term I'm happy to look into making it possible to do uaccesses in
> the uprobe handlers, but that requires a much wider rework of the way we
> handle BRK instructions, single-step, and hardware breakpoints and
> watchpoints.

See above and please let me know whether we are talking about the same
issue. In general, we run BPF programs in the same context where this
instruction emulation will happen, and BPF uprobe programs can be even
sleepable, so not just non-faultable user memory accesses, but even
faultable user accesses are supported.

>
> Mark.
>
> > Thanks.
> >
> >
> > =E5=9C=A8 2024/8/21 15:55, Liao, Chang =E5=86=99=E9=81=93:
> > > Hi, Mark
> > >
> > > My bad for taking so long to rely, I generally agree with your sugges=
tions to
> > > STP emulation.
> > >
> > > =E5=9C=A8 2024/8/15 17:58, Mark Rutland =E5=86=99=E9=81=93:
> > >> On Wed, Aug 14, 2024 at 08:03:56AM +0000, Liao Chang wrote:
> > >>> As Andrii pointed out, the uprobe/uretprobe selftest bench run into=
 a
> > >>> counterintuitive result that nop and push variants are much slower =
than
> > >>> ret variant [0]. The root cause lies in the arch_probe_analyse_insn=
(),
> > >>> which excludes 'nop' and 'stp' from the emulatable instructions lis=
t.
> > >>> This force the kernel returns to userspace and execute them out-of-=
line,
> > >>> then trapping back to kernel for running uprobe callback functions.=
 This
> > >>> leads to a significant performance overhead compared to 'ret' varia=
nt,
> > >>> which is already emulated.
> > >>
> > >> I appreciate this might be surprising, but does it actually matter
> > >> outside of a microbenchmark?
> > >
> > > I just do a simple comparsion the performance impact of single-steppe=
d and
> > > emulated STP on my local machine. Three user cases were measured: Red=
is GET and
> > > SET throughput (Request Per Second, RPS), and the time taken to execu=
te a grep
> > > command on the "arch_uprobe_copy_xol" string within the kernel source=
.
> > >
> > > Redis GET (higher is better)
> > > ----------------------------
> > > No uprobe: 49149.71 RPS
> > > Single-stepped STP: 46750.82 RPS
> > > Emulated STP: 48981.19 RPS
> > >
> > > Redis SET (larger is better)
> > > ----------------------------
> > > No uprobe: 49761.14 RPS
> > > Single-stepped STP: 45255.01 RPS
> > > Emulated stp: 48619.21 RPS
> > >
> > > Grep (lower is better)
> > > ----------------------
> > > No uprobe: 2.165s
> > > Single-stepped STP: 15.314s
> > > Emualted STP: 2.216s
> > >
> > > The result reveals single-stepped STP instruction that used to push f=
p/lr into
> > > stack significantly impacts the Redis and grep performance, leading t=
o a notable
> > > notable decrease RPS and increase time individually. So emulating STP=
 on the
> > > function entry might be a more viable option for uprobe.
> > >
> > >>
> > >>> Typicall uprobe is installed on 'nop' for USDT and on function entr=
y
> > >>> which starts with the instrucion 'stp x29, x30, [sp, #imm]!' to pus=
h lr
> > >>> and fp into stack regardless kernel or userspace binary.
> > >>
> > >> Function entry doesn't always start with a STP; these days it's ofte=
n a
> > >> BTI or PACIASP, and for non-leaf functions (or with shrink-wrapping =
in
> > >> the compiler), it could be any arbitrary instruction. This might hap=
pen
> > >> to be the common case today, but there are certain;y codebases where=
 it
> > >> is not.
> > >
> > > Sure, if kernel, CPU and compiler support BTI and PAC, the entry inst=
ruction
> > > is definitly not STP. But for CPU and kernel lack of these supports, =
STP as
> > > the entry instruction is still the common case. And I profiled the en=
try
> > > instruction for all leaf and non-leaf function, the ratio of STP is 6=
4.5%
> > > for redis, 76.1% for the BPF selftest bench. So I am thinking it is s=
till
> > > useful to emulate the STP on the function entry. Perhaps, for CPU and=
 kernel
> > > with BTI and PAC enabled, uprobe chooses the slower single-stepping t=
o execute
> > > STP for pushing stack.
> > >
> > >>
> > >> STP (or any instruction that accesses memory) is fairly painful to
> > >> emulate because you need to ensure that the correct atomicity and
> > >> ordering properties are provided (e.g. an aligned STP should be
> > >> single-copy-atomic, but copy_to_user() doesn't guarantee that except=
 by
> > >> chance), and that the correct VMSA behaviour is provided (e.g. when
> > >> interacting with MTE, POE, etc, while the uaccess primitives don't t=
ry
> > >> to be 100% equivalent to instructions in userspace).
> > > Agreed, but I don't think it has to emulate strictly the single-copy-=
atomic
> > > feature of STP that is used to push fp/lr into stack. In most cases, =
only one
> > > CPU will push registers to the same position on stack. And I barely u=
nderstand
> > > why other CPUs would depends on the ordering of pushing data into sta=
ck. So it
> > > means the atomicity and ordering is not so important for this scenari=
o. Regarding
> > > MTE and POE, a similar stragety to BTI and PAC can be applied: for CP=
Us and kernel
> > > with MTE and POE enabled, uprobe chooses the slower single-stepping t=
o execute
> > > STP for pushing stack.
> > >
> > >>
> > >> For those reasons, in general I don't think we should be emulating a=
ny
> > >> instruction which accesses memory, and we should not try to emulate =
the
> > >> STP, but I think it's entirely reasonable to emulate NOP.
> > >>
> > >>> In order to
> > >>> improve the performance of handling uprobe for common usecases. Thi=
s
> > >>> patch supports the emulation of Arm64 equvialents instructions of '=
nop'
> > >>> and 'push'. The benchmark results below indicates the performance g=
ain
> > >>> of emulation is obvious.
> > >>>
> > >>> On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Arm64 cores@2.4GHz.
> > >>>
> > >>> xol (1 cpus)
> > >>> ------------
> > >>> uprobe-nop:  0.916 =C2=B1 0.001M/s (0.916M/prod)
> > >>> uprobe-push: 0.908 =C2=B1 0.001M/s (0.908M/prod)
> > >>> uprobe-ret:  1.855 =C2=B1 0.000M/s (1.855M/prod)
> > >>> uretprobe-nop:  0.640 =C2=B1 0.000M/s (0.640M/prod)
> > >>> uretprobe-push: 0.633 =C2=B1 0.001M/s (0.633M/prod)
> > >>> uretprobe-ret:  0.978 =C2=B1 0.003M/s (0.978M/prod)
> > >>>
> > >>> emulation (1 cpus)
> > >>> -------------------
> > >>> uprobe-nop:  1.862 =C2=B1 0.002M/s  (1.862M/prod)
> > >>> uprobe-push: 1.743 =C2=B1 0.006M/s  (1.743M/prod)
> > >>> uprobe-ret:  1.840 =C2=B1 0.001M/s  (1.840M/prod)
> > >>> uretprobe-nop:  0.964 =C2=B1 0.004M/s  (0.964M/prod)
> > >>> uretprobe-push: 0.936 =C2=B1 0.004M/s  (0.936M/prod)
> > >>> uretprobe-ret:  0.940 =C2=B1 0.001M/s  (0.940M/prod)
> > >>>
> > >>> As shown above, the performance gap between 'nop/push' and 'ret'
> > >>> variants has been significantly reduced. Due to the emulation of 'p=
ush'
> > >>> instruction needs to access userspace memory, it spent more cycles =
than
> > >>> the other.
> > >>>
> > >>> [0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99=
zLn02ezZ5YruVuQw@mail.gmail.com/
> > >>>
> > >>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> > >>> ---
> > >>>  arch/arm64/include/asm/insn.h            | 21 ++++++++++++++++++
> > >>>  arch/arm64/kernel/probes/decode-insn.c   | 18 +++++++++++++--
> > >>>  arch/arm64/kernel/probes/decode-insn.h   |  3 ++-
> > >>>  arch/arm64/kernel/probes/simulate-insn.c | 28 ++++++++++++++++++++=
++++
> > >>>  arch/arm64/kernel/probes/simulate-insn.h |  2 ++
> > >>>  arch/arm64/kernel/probes/uprobes.c       |  2 +-
> > >>>  6 files changed, 70 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm=
/insn.h
> > >>> index 8c0a36f72d6f..a246e6e550ba 100644
> > >>> --- a/arch/arm64/include/asm/insn.h
> > >>> +++ b/arch/arm64/include/asm/insn.h
> > >>> @@ -549,6 +549,27 @@ static __always_inline bool aarch64_insn_uses_=
literal(u32 insn)
> > >>>          aarch64_insn_is_prfm_lit(insn);
> > >>>  }
> > >>>
> > >>> +static __always_inline bool aarch64_insn_is_nop(u32 insn)
> > >>> +{
> > >>> + /* nop */
> > >>> + return aarch64_insn_is_hint(insn) &&
> > >>> +        ((insn & 0xFE0) =3D=3D AARCH64_INSN_HINT_NOP);
> > >>> +}
> > >>
> > >> This looks fine, but the comment can go.
> > >
> > > Removed.
> > >
> > >>
> > >>> +static __always_inline bool aarch64_insn_is_stp_fp_lr_sp_64b(u32 i=
nsn)
> > >>> +{
> > >>> + /*
> > >>> +  * The 1st instruction on function entry often follows the
> > >>> +  * patten 'stp x29, x30, [sp, #imm]!' that pushing fp and lr
> > >>> +  * into stack.
> > >>> +  */
> > >>> + return aarch64_insn_is_stp_pre(insn) &&
> > >>> +        (((insn >> 30) & 0x03) =3D=3D  2) && /* opc =3D=3D 10 */
> > >>> +        (((insn >>  5) & 0x1F) =3D=3D 31) && /* Rn  is sp */
> > >>> +        (((insn >> 10) & 0x1F) =3D=3D 30) && /* Rt2 is x29 */
> > >>> +        (((insn >>  0) & 0x1F) =3D=3D 29);   /* Rt  is x30 */
> > >>> +}
> > >>
> > >> We have accessors for these fields. Please use them.
> > >
> > > Do you mean aarch64_insn_decode_register()?
> > >
> > >>
> > >> Regardless, as above I do not think we should have a helper this
> > >> specific (with Rn, Rt, and Rt2 values hard-coded) inside <asm/insn.h=
>.
> > >
> > > If we left necessary of emulation of STP aside, where would the best =
file to
> > > place these hard-coded decoder helper?
> > >
> > >>
> > >>>  enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
> > >>>  u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type,=
 u32 insn);
> > >>>  u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
> > >>> diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/ke=
rnel/probes/decode-insn.c
> > >>> index 968d5fffe233..df7ca16fc763 100644
> > >>> --- a/arch/arm64/kernel/probes/decode-insn.c
> > >>> +++ b/arch/arm64/kernel/probes/decode-insn.c
> > >>> @@ -73,8 +73,22 @@ static bool __kprobes aarch64_insn_is_steppable(=
u32 insn)
> > >>>   *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use=
 its slot.
> > >>>   */
> > >>>  enum probe_insn __kprobes
> > >>> -arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn =
*api)
> > >>> +arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn =
*api,
> > >>> +               bool kernel)
> > >>>  {
> > >>> + /*
> > >>> +  * While 'nop' and 'stp x29, x30, [sp, #imm]! instructions can
> > >>> +  * execute in the out-of-line slot, simulating them in breakpoint
> > >>> +  * handling offers better performance.
> > >>> +  */
> > >>> + if (aarch64_insn_is_nop(insn)) {
> > >>> +         api->handler =3D simulate_nop;
> > >>> +         return INSN_GOOD_NO_SLOT;
> > >>> + } else if (!kernel && aarch64_insn_is_stp_fp_lr_sp_64b(insn)) {
> > >>> +         api->handler =3D simulate_stp_fp_lr_sp_64b;
> > >>> +         return INSN_GOOD_NO_SLOT;
> > >>> + }
> > >>
> > >> With the STP emulation gone, you won't need the kernel parameter her=
e.>
> > >>> +
> > >>>   /*
> > >>>    * Instructions reading or modifying the PC won't work from the X=
OL
> > >>>    * slot.
> > >>> @@ -157,7 +171,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, s=
truct arch_specific_insn *asi)
> > >>>           else
> > >>>                   scan_end =3D addr - MAX_ATOMIC_CONTEXT_SIZE;
> > >>>   }
> > >>> - decoded =3D arm_probe_decode_insn(insn, &asi->api);
> > >>> + decoded =3D arm_probe_decode_insn(insn, &asi->api, true);
> > >>>
> > >>>   if (decoded !=3D INSN_REJECTED && scan_end)
> > >>>           if (is_probed_address_atomic(addr - 1, scan_end))
> > >>> diff --git a/arch/arm64/kernel/probes/decode-insn.h b/arch/arm64/ke=
rnel/probes/decode-insn.h
> > >>> index 8b758c5a2062..ec4607189933 100644
> > >>> --- a/arch/arm64/kernel/probes/decode-insn.h
> > >>> +++ b/arch/arm64/kernel/probes/decode-insn.h
> > >>> @@ -28,6 +28,7 @@ enum probe_insn __kprobes
> > >>>  arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific=
_insn *asi);
> > >>>  #endif
> > >>>  enum probe_insn __kprobes
> > >>> -arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn =
*asi);
> > >>> +arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn =
*asi,
> > >>> +               bool kernel);
> > >>>
> > >>>  #endif /* _ARM_KERNEL_KPROBES_ARM64_H */
> > >>> diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/=
kernel/probes/simulate-insn.c
> > >>> index 22d0b3252476..0b1623fa7003 100644
> > >>> --- a/arch/arm64/kernel/probes/simulate-insn.c
> > >>> +++ b/arch/arm64/kernel/probes/simulate-insn.c
> > >>> @@ -200,3 +200,31 @@ simulate_ldrsw_literal(u32 opcode, long addr, =
struct pt_regs *regs)
> > >>>
> > >>>   instruction_pointer_set(regs, instruction_pointer(regs) + 4);
> > >>>  }
> > >>> +
> > >>> +void __kprobes
> > >>> +simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
> > >>> +{
> > >>> + instruction_pointer_set(regs, instruction_pointer(regs) + 4);
> > >>> +}
> > >>
> > >> Hmm, this forgets to update the single-step state machine and PSTATE=
.BT,
> > >> and that's an extant bug in arch_uprobe_post_xol(). This can be:
> > >
> > > For emulated instruction, uprobe won't enable single-step mode of CPU=
,
> > > please check the handle_swbp() in kernel/events/uprobes.c:
> > >
> > >   if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
> > >           goto out;
> > >
> > >   if (!pre_ssout(uprobe, regs, bp_vaddr))
> > >           return;
> > >
> > > For emualted instruction, It will skip entire single-stepping and ass=
ociated
> > > exception, which typically begins with pre_ssout() and ends with
> > > arch_uprobe_post_xol(). Therefore, using instruction_pointer_set() to=
 emulate
> > > NOP is generally not a bad idea.
> > >
> > >>
> > >> | void __kprobes
> > >> | simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
> > >> | {
> > >> |  arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> > >> | }
> > >>
> > >>> +
> > >>> +void __kprobes
> > >>> +simulate_stp_fp_lr_sp_64b(u32 opcode, long addr, struct pt_regs *r=
egs)
> > >>> +{
> > >>> + long imm7;
> > >>> + u64 buf[2];
> > >>> + long new_sp;
> > >>> +
> > >>> + imm7 =3D sign_extend64((opcode >> 15) & 0x7f, 6);
> > >>> + new_sp =3D regs->sp + (imm7 << 3);
> > >>
> > >> We have accessors for these fields, please use them.
> > >
> > > Do you mean aarch64_insn_decode_immediate()?
> > >
> > >>
> > >>> +
> > >>> + buf[0] =3D regs->regs[29];
> > >>> + buf[1] =3D regs->regs[30];
> > >>> +
> > >>> + if (copy_to_user((void __user *)new_sp, buf, sizeof(buf))) {
> > >>> +         force_sig(SIGSEGV);
> > >>> +         return;
> > >>> + }
> > >>
> > >> As above, this won't interact with VMSA features (e.g. MTE, POE) in =
the
> > >> same way as an STP in userspace, and this will not have the same
> > >> atomicity properties as an STP>
> > >>> +
> > >>> + regs->sp =3D new_sp;
> > >>> + instruction_pointer_set(regs, instruction_pointer(regs) + 4);
> > >>
> > >> Likewise, this sould need ot use arm64_skip_faulting_instruction(),
> > >> though as above I think we should drop STP emulation entirely.
> > >
> > > I explain the reason why using instruction_pointer_set() under your c=
omments
> > > for simulate_nop().
> > >
> > > Thanks.
> > >
> > >>
> > >> Mark.
> > >>
> > >
> >
> > --
> > BR
> > Liao, Chang

