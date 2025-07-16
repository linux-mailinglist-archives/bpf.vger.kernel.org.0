Return-Path: <bpf+bounces-63425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7378B074DC
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 13:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C73C1C26322
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 11:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681052F4310;
	Wed, 16 Jul 2025 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeZYPos5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90212EF292;
	Wed, 16 Jul 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665649; cv=none; b=QqvgEBywwmUonMhkJdnUupZ+lHFlCpHP3W8hb+s60McfsSwatB+Ee7+WnITb0Ku9jhfrM/V8pjWAtkEUrf7sutEGPIut8DnQEQFcCNyqtqreN6O/mhSjKJ6rQyy2i7FHEb/bfMkj6fAYVGuUIdR84PwsQ9eC7DIU0IbLBFcMYPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665649; c=relaxed/simple;
	bh=KWyn0SNq2GNipqxpl7WVzEfJ1H93KzyTOZdOdF3jxY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1j/M37374wKV6zF7JE/9s1l9msTBWZZMMNNiD4xZ3KnHRHhuSkdRp9nM5QZqdVF3kU0eDJRlzN5nmKn/3mica/pUXZhyAoGtS5qeelqQm0aBo7BMzLZ3LvhnIHpdAhNxqm5lfsqwnCGza5JVZbhuQaQlpp0MMCkCUMeU4+oLE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeZYPos5; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-615a68bd0efso75042eaf.2;
        Wed, 16 Jul 2025 04:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752665645; x=1753270445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAcVyiKfBCpz2acqj/YrO+QxAOg+5ZsQwlmATYrqxAY=;
        b=PeZYPos5k0cnqMO8S2wI7sW9P8LO5UjYW69MZmR9vHmOO4QjmdfWbkGxwXY1JnP6AI
         ktUs0O++8DY1qI2CZ1AHT3uEIbsEJG6oBOu8fxWL3cdprTf2b8DtjvV8pfPdCJpqmy+7
         vUFBDLrjzCgTd6+0xvMwQxTkdCacTtXQTiKIamfSn6xblzfx3mN9WN+6AJLjkJE+4IAU
         l90xSmlOsC9OXyNhR6DPfcKpcFm/CRwUAoyqBTWFFVbbUvx132qP94noL/+dBIJ4p6d5
         h4osMoYM+qVlf1UGOFTI9ilEY6ylK9EDLl+NE7MtjbOHZe8KwpPyx73niscd3PBzL6gd
         OBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752665645; x=1753270445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAcVyiKfBCpz2acqj/YrO+QxAOg+5ZsQwlmATYrqxAY=;
        b=L4Dkjjvl6S7JER+Y0jNsN+wDmRxwqbW6VNPB/O2JsrcR8z3OBmvzDVgvpaYRPISI/v
         K7hhjydLjoMtDif/fqjdNWSkz5+t82KBGeCY0cizfCI9JUUgWpDVrvRBBctVj5rYAlsJ
         AFMe0w24R4CGBQ3ORor9XTy4luWHZVyDBvb5eKrWMffxf7fRRzjfXyQLqlKpEp33G8++
         a1myj6prbh2Yckx2mSdaUgO/JWeRb7v7UW5IWgdzAtkKLjLCFnBntqO5qoUkq4IPUULN
         bbM0wdPyHeFcorRe8tHjz884V5jOD9tDPbsdoLNxUIzvIRGpRJA8oSib6jTcAPa1ejEy
         t9gw==
X-Forwarded-Encrypted: i=1; AJvYcCV5jxK/C6K1NMN0cFy+SBcFgXO28h46xnb3ZTc6yejGeOMYUgvRJsWasWT6eKgOd6ddNSw=@vger.kernel.org, AJvYcCVsycd3mNirmoa70msggnWm4GjVDsXrS3WB0+G9sFFpuWowdMwz3uhwK42XoxUr7eRGAPPinFBEKYfCOG0+@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7VuWBA1PhWjCu/Vo+L4C18DM+LH1EcuP8UpZXv+zDKMLxcLo
	cTWEUKYSb2ZdOXS84Ia4DI4Yh9e4fAGRzqMZMejQEpzR5JXDwZE76Wk58N6FhJ7Pl96EHSQCeGZ
	OjxkD3uul0sCKsvZ4s+dWyNCOXtS0SSs=
X-Gm-Gg: ASbGncvULx3LuhqN8423BMuAkglIY7hMtvtZ9EahaqPfcmiFuyjoOT3O0nNzT81x6Al
	z8hLzTPAf9wXk4492OyUXWgVqPsPB6EAVRdjC2EmhlYVKKBib/aKmYytbkJ0OXDWpmdkOi/hS6v
	SdL59WLXvt9iW1nTCF9vtABVY5s15E+FtZhGeOvU4QwajgBGMkv1NXlJ8MlJSrtwm1622NNYmRg
	Zkk0pc=
X-Google-Smtp-Source: AGHT+IHjUVB8DeJdmYYw68fY49A7S/gg5agMGiXYQe6PaBXLkFDQIAda+1U9vHi8M4p8rSdTkAvaO5Tapl1Fhp1drXM=
X-Received: by 2002:a05:6808:7003:b0:41b:3d20:a094 with SMTP id
 5614622812f47-41d049968dbmr1654821b6e.25.1752665644606; Wed, 16 Jul 2025
 04:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709055029.723243-1-duanchenghao@kylinos.cn> <20250709055029.723243-2-duanchenghao@kylinos.cn>
In-Reply-To: <20250709055029.723243-2-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Wed, 16 Jul 2025 19:33:51 +0800
X-Gm-Features: Ac12FXweD0Sx1J-1wZxPububLXCVBHc4Mt7YozKGWOCrJj4wKvG6dPBm5LpT0qo
Message-ID: <CAEyhmHSB32tPYbUKqqxFWQqnyDGcNPQsCqBKGdNRrn+U+jMimw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] LoongArch: Add the function to generate the beq
 and bne assembly instructions.
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yangtiezhu@loongson.cn, chenhuacai@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, kernel@xen0n.name, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	guodongtai@kylinos.cn, youling.tang@linux.dev, jianghaoran@kylinos.cn, 
	Youling Tang <tangyouling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 1:50=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos.=
cn> wrote:
>
> Add branch jump function:
> larch_insn_gen_beq
> larch_insn_gen_bne
>

Please drop the period from subject line.
The commit message is kind of vague...

Maybe:
    LoongArch: Add larch_insn_gen_{beq,bne} helpers

    Add larch_insn_gen_beq() and larch_insn_gen_bne() helpers
    which will be used in BPF trampoline implementation.


> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Co-developed-by: Youling Tang <tangyouling@kylinos.cn>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  arch/loongarch/include/asm/inst.h |  2 ++
>  arch/loongarch/kernel/inst.c      | 28 ++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/a=
sm/inst.h
> index 3089785ca..2ae96a35d 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -511,6 +511,8 @@ u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int =
imm);
>  u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
>  u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, =
int imm);
>  u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, in=
t imm);
> +u32 larch_insn_gen_beq(enum loongarch_gpr rd, enum loongarch_gpr rj, int=
 imm);
> +u32 larch_insn_gen_bne(enum loongarch_gpr rd, enum loongarch_gpr rj, int=
 imm);
>
>  static inline bool signed_imm_check(long val, unsigned int bit)
>  {
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> index 14d7d700b..674e3b322 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -336,3 +336,31 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum =
loongarch_gpr rj, int imm)
>
>         return insn.word;
>  }
> +
> +u32 larch_insn_gen_beq(enum loongarch_gpr rd, enum loongarch_gpr rj, int=
 imm)
> +{
> +       union loongarch_instruction insn;
> +
> +       if ((imm & 3) || imm < -SZ_128K || imm >=3D SZ_128K) {
> +               pr_warn("The generated beq instruction is out of range.\n=
");
> +               return INSN_BREAK;
> +       }
> +
> +       emit_beq(&insn, rj, rd, imm >> 2);
> +
> +       return insn.word;
> +}
> +
> +u32 larch_insn_gen_bne(enum loongarch_gpr rd, enum loongarch_gpr rj, int=
 imm)
> +{
> +       union loongarch_instruction insn;
> +
> +       if ((imm & 3) || imm < -SZ_128K || imm >=3D SZ_128K) {
> +               pr_warn("The generated bne instruction is out of range.\n=
");
> +               return INSN_BREAK;
> +       }
> +
> +       emit_bne(&insn, rj, rd, imm >> 2);
> +
> +       return insn.word;
> +}
> --
> 2.43.0
>

