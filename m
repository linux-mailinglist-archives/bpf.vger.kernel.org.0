Return-Path: <bpf+bounces-9429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0655B797811
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFD4281955
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 16:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12774134C0;
	Thu,  7 Sep 2023 16:41:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E886D22
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 16:41:14 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1A21FCA
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 09:40:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so15436225e9.1
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694104796; x=1694709596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tx8l9tFx1Cpfum5YmdkK055RiV0va+Wb+sJbkZHksk4=;
        b=lz+EhN+houkpSqgGV8eLz4mR9xPaWnZNLgUmyu4asvrSQgFocJHZqPZZ+sh5/Jg/yp
         be4pKwYEcqvCa41hy80voJBNMusRGpiJjoO7hJ9sYwjLzulYNHF2GMPjJ1dX8CvOii1N
         cb2bDA9knLxEcsNa9boz31iS8aogP6Y3Juti6/gLRTVyTVnddxLutb2/EGWfqKOGXGnP
         y6DpTC+nR0xRMEdDP9d6T+Z9SZbkhPzyRUOGik5645eB6x8i92zi5zq6hX9AdPjR3XkK
         FG8ho8pCLEhgcLntJwf9LHMSwwfKM7TvVBRBdbfntiZzDgKSPAr4hcw2YXImCwyr5AX8
         xDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104796; x=1694709596;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tx8l9tFx1Cpfum5YmdkK055RiV0va+Wb+sJbkZHksk4=;
        b=Cu3bGvOTRyCcin0k56nuoIMbFxby41XKz3eeP974raQ0ptqA66bak+Fbkl4E8BW7OH
         yhWD5aiYvZXKUrwwY4KHNyeXiL/kr1FZ6vlrwNr714rl8QUULgxUXHVwjjguxK9wD/l9
         2J6jEcMxjobipTb+PcSQpf9ZB7ajHZkqxghPdVZ0jUXsg/k46G8WmuQGwsbwb+fl+8X+
         KX7sxAFKBjVz8yT64Jkjz77XhpQqv9PcwNFKPFRW2+tGJoA4QFjaSTgGpP1nMRSV8RFN
         QoSCWJnIieHUIuOjbgd1Josm+7CF6hAhjfTPzqEqSzxI/vamoZl3vc0UPATnZor/eHn5
         FEyg==
X-Gm-Message-State: AOJu0Yx7tJPv8sS4HqTr4zE72dViCx3fHdq166wYaPDwromaE6e+IIzs
	8KIDnCu0Aq5ej+bJnbbnjOkOMhfsCXwFxMmuZIY=
X-Google-Smtp-Source: AGHT+IFFhY8Zy9cqPoE3GPTNmExvTFZVabNoOZLwr1QncBPoYTaUE6EA7VIlpuEc3WBipmlvJ0mMvw==
X-Received: by 2002:a05:600c:1d1c:b0:401:bd94:f45b with SMTP id l28-20020a05600c1d1c00b00401bd94f45bmr2630883wms.4.1694104795449;
        Thu, 07 Sep 2023 09:39:55 -0700 (PDT)
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id l10-20020a7bc44a000000b003fedcd02e2asm3003190wmi.35.2023.09.07.09.39.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Sep 2023 09:39:55 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Andrii
 Nakryiko <andrii@kernel.org>,  bpf <bpf@vger.kernel.org>,  Heiko Carstens
 <hca@linux.ibm.com>,  Vasily Gorbik <gor@linux.ibm.com>,  Alexander
 Gordeev <agordeev@linux.ibm.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
References: <20230830011128.1415752-1-iii@linux.ibm.com>
	<20230830011128.1415752-2-iii@linux.ibm.com>
	<CANk7y0iNnOCZ_KmXBH_xJTG=BKzkDM_jZ+hc_NXcQbbZj-c33Q@mail.gmail.com>
	<mb61p5y4u3ptd.fsf@amazon.com>
	<CAADnVQ+u1hMBS3rm=meQaAgujHf6bOvONrwg6nYh1qWzVLVoAA@mail.gmail.com>
	<mb61p4jk630a9.fsf@amazon.com>
	<CAADnVQJCc6t82H+iFXvhs=mfg1DMxZ-1PS3DP5h7mtbuCW79qQ@mail.gmail.com>
Date: Thu, 07 Sep 2023 16:39:54 +0000
In-Reply-To: <CAADnVQJCc6t82H+iFXvhs=mfg1DMxZ-1PS3DP5h7mtbuCW79qQ@mail.gmail.com>
	(Alexei Starovoitov's message of "Thu, 7 Sep 2023 08:36:36 -0700")
Message-ID: <mb61pv8cm0wf9.fsf@amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 07 2023, Alexei Starovoitov wrote:

> On Thu, Sep 7, 2023 at 12:33=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
>>
>> On Wed, Sep 06 2023, Alexei Starovoitov wrote:
>>
>> > On Fri, Sep 1, 2023 at 7:57=E2=80=AFAM Puranjay Mohan <puranjay12@gmai=
l.com> wrote:
>> >>
>> >> On Fri, Sep 01 2023, Puranjay Mohan wrote:
>> >>
>> >> > The problem here is that reg->subreg_def should be set as DEF_NOT_S=
UBREG for
>> >> > registers that are used as destination registers of BPF_LDX |
>> >> > BPF_MEMSX. I am seeing
>> >> > the same problem on ARM32 and was going to send a patch today.
>> >> >
>> >> > The problem is that is_reg64() returns false for destination regist=
ers
>> >> > of BPF_LDX | BPF_MEMSX.
>> >> > But BPF_LDX | BPF_MEMSX always loads a 64 bit value because of the
>> >> > sign extension so
>> >> > is_reg64() should return true.
>> >> >
>> >> > I have written a patch that I will be sending as a reply to this.
>> >> > Please let me know if that makes sense.
>> >> >
>> >>
>> >> The check_reg_arg() function will mark reg->subreg_def =3D DEF_NOT_SU=
BREG for destination
>> >> registers if is_reg64() returns true for these registers. My patch be=
low make is_reg64()
>> >> return true for destination registers of BPF_LDX with mod =3D BPF_MEM=
SX. I feel this is the
>> >> correct way to fix this problem.
>> >>
>> >> Here is my patch:
>> >>
>> >> --- 8< ---
>> >> From cf1bf5282183cf721926ab14d968d3d4097b89b8 Mon Sep 17 00:00:00 2001
>> >> From: Puranjay Mohan <puranjay12@gmail.com>
>> >> Date: Fri, 1 Sep 2023 11:18:59 +0000
>> >> Subject: [PATCH bpf] bpf: verifier: mark destination of sign-extended=
 load as
>> >>  64 bit
>> >>
>> >> The verifier can emit instructions to zero-extend destination registe=
rs
>> >> when the register is being used to keep 32 bit values. This behaviour=
 is
>> >> enabled only when the JIT sets bpf_jit_needs_zext() -> true. In the c=
ase
>> >> of a sign extended load instruction, the destination register always =
has a
>> >> 64-bit value, therefore the verifier should not emit zero-extend
>> >> instructions for it.
>> >>
>> >> Change is_reg64() to return true if the register under consideration =
is a
>> >> destination register of LDX instruction with mode =3D BPF_MEMSX.
>> >>
>> >> Fixes: 1f9a1ea821ff ("bpf: Support new sign-extension load insns")
>> >> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> >> ---
>> >>  kernel/bpf/verifier.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> >> index bb78212fa5b2..93f84b868ccc 100644
>> >> --- a/kernel/bpf/verifier.c
>> >> +++ b/kernel/bpf/verifier.c
>> >> @@ -3029,7 +3029,7 @@ static bool is_reg64(struct bpf_verifier_env *e=
nv, struct bpf_insn *insn,
>> >>
>> >>         if (class =3D=3D BPF_LDX) {
>> >>                 if (t !=3D SRC_OP)
>> >> -                       return BPF_SIZE(code) =3D=3D BPF_DW;
>> >> +                       return (BPF_SIZE(code) =3D=3D BPF_DW || BPF_M=
ODE(code) =3D=3D BPF_MEMSX);
>> >
>> > Looks like we have a bug here for normal LDX too.
>> > This 'if' condition was inserting unnecessary zext for LDX.
>> > It was harmless for LDX and broken for LDSX.
>> > Both LDX and LDSX write all bits of 64-bit register.
>> >
>> > I think the proper fix is to remove above two lines.
>> > wdyt?
>>
>> For LDX this returns true only if it is with a BPF_DW, for others it ret=
urns false.
>> This means a zext is inserted for BPF_LDX | BPF_B/H/W.
>>
>> This is not a bug because LDX writes 64 bits of the register only with B=
PF_DW.
>> With BPF_B/H/W It only writes the lower 32bits and needs zext for upper =
32 bits.
>
> No. The interpreter writes all 64-bit for any LDX insn.
> All JITs must do it as well.
>
>> On 32 bit architectures where a 64-bit BPF register is simulated with tw=
o 32-bit registers,
>> explicit zext is required for BPF_LDX | BPF_B/H/W.
>
> zext JIT-aid done by the verifier has nothing to do with 32-bit architect=
ure.
> It's necessary on 64-bit as well when HW doesn't automatically zero out
> upper 32-bit like it does on arm64 and x86-64

Yes, I agree that zext JIT-aid is required for all 32-bit architectures and=
 some 64-bit architectures
that can't automatically zero out the upper 32-bits.
Basically any architecture that sets bpf_jit_needs_zext() -> true.

>> So, we should not remove this.
>
> I still think we should.

If we remove this then some JITs will not zero extend the upper 32-bits for=
 BPF_LDX | BPF_B/H/W.

My understanding is that Verifier sets prog->aux->verifier_zext if it emits=
 zext instructions. If the verifier
doesn't emit zext for LDX but sets prog->aux->verifier_zext that would caus=
e wrong behavior for some JITs:

Example code from ARM32 jit doing BPF_LDX | BPF_MEM | BPF_B:

case BPF_B:
		/* Load a Byte */
		emit(ARM_LDRB_I(rd[1], rm, off), ctx);
		if (!ctx->prog->aux->verifier_zext)
			emit_a32_mov_i(rd[0], 0, ctx);
		break;

Here if ctx->prog->aux->verifier_zext is set by the verifier, and zext was =
not emitted for LDX, JIT will not zero
the upper 32-bits.

RISCV32, PowerPC32, x86-32 JITs have similar code paths. Only MIPS32 JIT ze=
ro-extends for LDX without checking=20=20
prog->aux->verifier_zext.

So, if we want to stop emitting zext for LDX then we would need to modify a=
ll these JITs to always zext for LDX.

Let me know if my understanding has some gaps, also if we decide to remove =
it, I am happy to send patches for it
and fix the JITs that need modifications.

Thanks,
Puranjay

