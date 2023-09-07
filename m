Return-Path: <bpf+bounces-9451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450DE797CA1
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 21:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EAE1C20B08
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 19:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D521014012;
	Thu,  7 Sep 2023 19:20:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D513AE1
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 19:20:00 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D086AB2
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 12:19:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a9f2827131so38418266b.1
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 12:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694114397; x=1694719197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WB90aRlyOEbO662eiiTiqw5rtW9O+Ng/jP7uQCwuOUE=;
        b=hFJXZ2PWfbfLfWMT50ZhBVxMICPsGd7IBWm32BzQBG9Er76GZUTcGpwW3GT9f/7N9r
         YQVoeoe1tCAPw/EvpRGdslopYi+kjWgoXvlfASdef+Cu+TBNqfK/2dFMAnimuFP63D+z
         s9YObvCMk+8+sN/al3LjKun0Za/5rxtFXDqHS6/6bjuJPEflDymT/YrC79nXgAi6HdRs
         Jhc9JSW7XnAfi1+hnrKZO7URItd6LXg23VMO3uMNLQ0nsmLn6zh9sFxi+6YOpGUUrDbx
         Ew9c8o+mMjm4b6BU3FDDfrRfxg4Nj67hnv6YsF30qAZTbSXOUGlVNR2k9Puu2HL71HAX
         9R2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694114397; x=1694719197;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WB90aRlyOEbO662eiiTiqw5rtW9O+Ng/jP7uQCwuOUE=;
        b=eunWiinHJ9vmWG5mEZ/80KkFUeqfybI1PP1LmscO2bYI+0RR8Wa9E+ijtJDsQV18ME
         zPx+w4j23BBY2QtHljeN2CbKZ2GlNe8xjjc6HZ6nx4Q2dGVN4sSu3+6bA3sXAbw9C5+k
         FsaJilL5Vxht4ia2m3Zt29hSZtRGlvK7b5rIpHO0yVVUi0G0470gcprWrfw8oD7qbGmn
         Vi96gZ0mQ9r2tN54+ccT9lSMCCCCAXSlZQg8LLUCgLj8SQA1AXj9RmBUFev3NC1hJN+e
         meQyA6o4GiQlhwPVfMnWDk7FgszAhqPSHV0Dlnc0FeNCzJEwmUyIkSa2UgpZ1/Q6gVlM
         KcCA==
X-Gm-Message-State: AOJu0YzhzyQia8Tcy8ScNxpTnpUNMhjeAxCpnA4KXtiNOsiXAvnKwWMP
	1eNHjfb3buEgEvUKITzrtCQoNzEWawL3NcpoOhw=
X-Google-Smtp-Source: AGHT+IH8pmyh5SnCI1shvtsD9vGZlE1gCzwUrtChEAYrVUCOF/KAOY1Sc3sY9tJ4SENBjCimK9tq6Q==
X-Received: by 2002:a5d:4c85:0:b0:317:6175:95fd with SMTP id z5-20020a5d4c85000000b00317617595fdmr3717126wrs.43.1694072014912;
        Thu, 07 Sep 2023 00:33:34 -0700 (PDT)
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id ay30-20020a5d6f1e000000b0031f65cdd271sm3473536wrb.100.2023.09.07.00.33.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Sep 2023 00:33:34 -0700 (PDT)
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
Date: Thu, 07 Sep 2023 07:33:34 +0000
In-Reply-To: <CAADnVQ+u1hMBS3rm=meQaAgujHf6bOvONrwg6nYh1qWzVLVoAA@mail.gmail.com>
	(Alexei Starovoitov's message of "Wed, 6 Sep 2023 17:39:55 -0700")
Message-ID: <mb61p4jk630a9.fsf@amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 06 2023, Alexei Starovoitov wrote:

> On Fri, Sep 1, 2023 at 7:57=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
>>
>> On Fri, Sep 01 2023, Puranjay Mohan wrote:
>>
>> > The problem here is that reg->subreg_def should be set as DEF_NOT_SUBR=
EG for
>> > registers that are used as destination registers of BPF_LDX |
>> > BPF_MEMSX. I am seeing
>> > the same problem on ARM32 and was going to send a patch today.
>> >
>> > The problem is that is_reg64() returns false for destination registers
>> > of BPF_LDX | BPF_MEMSX.
>> > But BPF_LDX | BPF_MEMSX always loads a 64 bit value because of the
>> > sign extension so
>> > is_reg64() should return true.
>> >
>> > I have written a patch that I will be sending as a reply to this.
>> > Please let me know if that makes sense.
>> >
>>
>> The check_reg_arg() function will mark reg->subreg_def =3D DEF_NOT_SUBRE=
G for destination
>> registers if is_reg64() returns true for these registers. My patch below=
 make is_reg64()
>> return true for destination registers of BPF_LDX with mod =3D BPF_MEMSX.=
 I feel this is the
>> correct way to fix this problem.
>>
>> Here is my patch:
>>
>> --- 8< ---
>> From cf1bf5282183cf721926ab14d968d3d4097b89b8 Mon Sep 17 00:00:00 2001
>> From: Puranjay Mohan <puranjay12@gmail.com>
>> Date: Fri, 1 Sep 2023 11:18:59 +0000
>> Subject: [PATCH bpf] bpf: verifier: mark destination of sign-extended lo=
ad as
>>  64 bit
>>
>> The verifier can emit instructions to zero-extend destination registers
>> when the register is being used to keep 32 bit values. This behaviour is
>> enabled only when the JIT sets bpf_jit_needs_zext() -> true. In the case
>> of a sign extended load instruction, the destination register always has=
 a
>> 64-bit value, therefore the verifier should not emit zero-extend
>> instructions for it.
>>
>> Change is_reg64() to return true if the register under consideration is a
>> destination register of LDX instruction with mode =3D BPF_MEMSX.
>>
>> Fixes: 1f9a1ea821ff ("bpf: Support new sign-extension load insns")
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> ---
>>  kernel/bpf/verifier.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index bb78212fa5b2..93f84b868ccc 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3029,7 +3029,7 @@ static bool is_reg64(struct bpf_verifier_env *env,=
 struct bpf_insn *insn,
>>
>>         if (class =3D=3D BPF_LDX) {
>>                 if (t !=3D SRC_OP)
>> -                       return BPF_SIZE(code) =3D=3D BPF_DW;
>> +                       return (BPF_SIZE(code) =3D=3D BPF_DW || BPF_MODE=
(code) =3D=3D BPF_MEMSX);
>
> Looks like we have a bug here for normal LDX too.
> This 'if' condition was inserting unnecessary zext for LDX.
> It was harmless for LDX and broken for LDSX.
> Both LDX and LDSX write all bits of 64-bit register.
>
> I think the proper fix is to remove above two lines.
> wdyt?

For LDX this returns true only if it is with a BPF_DW, for others it return=
s false.
This means a zext is inserted for BPF_LDX | BPF_B/H/W.

This is not a bug because LDX writes 64 bits of the register only with BPF_=
DW.
With BPF_B/H/W It only writes the lower 32bits and needs zext for upper 32 =
bits.
On 32 bit architectures where a 64-bit BPF register is simulated with two 3=
2-bit registers,
explicit zext is required for BPF_LDX | BPF_B/H/W.

So, we should not remove this.

Thanks,
Puranjay

