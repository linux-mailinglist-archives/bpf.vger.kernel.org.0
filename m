Return-Path: <bpf+bounces-61634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29CEAE93CC
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 03:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282FD5A70C8
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 01:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC691BCA1C;
	Thu, 26 Jun 2025 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQAzvPHF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D89189F56;
	Thu, 26 Jun 2025 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750901958; cv=none; b=VTOf3FIck/geq7kBL2Gaccpn6/l7iGiFrB7p5/MTqaKtFsTGdioPPqDWvO+4vyan56dsTzGxPA/4QTYr3bjH9Y26T+Lq0CfzQopKIsaaIWTJKBXOuh2Mt2nmVRGGvF7v10aArFK6yaL9Y9Q8f4mA5mVOHjRpF37ggPt1b/kDK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750901958; c=relaxed/simple;
	bh=OoPZ/xKEZhH4/ie5suCdrwcei67FVrAhuZ8OTbN6fD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4+f2FlLQK9q3xmi7nusYzkwHwQ2w+xyEv9CRsv1RVrmPp/69ST5CWCMJgO/YlBoEHL180mw+uaq1fA6RRn5+BQQHDKyVrHzAr1qLD1L3XdfFwZXQ5ccFV1mTwBledxKeshTg4yTfNtXO68AynBo0Dq4qcLJTiDZDrthaMyEtbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQAzvPHF; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-611998766c0so297054eaf.1;
        Wed, 25 Jun 2025 18:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750901956; x=1751506756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SA6izG67AC7Rft8ICsngF2Dm1AqxKaO0/xyCqToZhWA=;
        b=dQAzvPHFxNHReUHUzPodTLoIvQX0TvB9fAbq8X3p7lW592s6e9zRGXKouFKh/RhFoF
         4otucVbXyiLoSvuAMe5ayMjdXJmBaGbfLQcVAbfEXJMOggDCzxHInmzGdc9S9d2KODEH
         ByobP9WFvGZ31Dr3HRgHxrYmGiXWaDSItYZlWaeM/dbMzkbYePo0TgRf49p/siyI+0lI
         nygCxncEwNmJi8L80D37PMAVL7PvsySL1pW6lml1lewt5QW3x4UKRjyVeLACa0g3Z60n
         jXklBsz5nDZFUmdE0YodPqrVnY8kEgFZ+zAdHbZPI2nxop9HXuwYWhfB+k+H1nE8FeTC
         g72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750901956; x=1751506756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SA6izG67AC7Rft8ICsngF2Dm1AqxKaO0/xyCqToZhWA=;
        b=CBiiVO3izrEOlC+aG9HHL0Yme2U27x0roc9qpMOOggVpVHc4Je0GJSxb3jH4mUnZqz
         3VmO+5blBBGKsobJHrvAWhUtlHCwINvjP4YdKHxjXmQ9F8W6hC7Y3YsAzXa6qva81m7z
         5OOKlDvabxDCdriNAQjbn/hI7r6ZPAAmBiVFmT74+BrIUAz3djV21Q34hEygHrU/iYmk
         lIHjzKtcpZlnhdg26XHyr9svqs0EIevCvoTn50/HD44/lW/u8Xh967Ej1pD99KrDo8dP
         1b0HyeuroHE+thIEAUoU+G242NIrfNUteMMFZD2rR1yZvmhUn6XiCxN28E6EV5KZXKuz
         V+3A==
X-Forwarded-Encrypted: i=1; AJvYcCU8fIDkaduXPmEQ6tjWcORE6Zxi+0PdlFgmnY4hJhmDZgaZ3dKn7vyDQD8OxBtZ9TRbP2A=@vger.kernel.org, AJvYcCWe0QsV6nWRHb+mgzTCXoUPQJNzZft64Bh2+in5C3Yi+U6YNS5EETAOm9Qa0X1/strPx6hw+hKeGdZXFJdj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw48zvZNejCbOQvLn5eYbrRDsCPaglYPf74vMAuO/VeXRLX0uUS
	uuBD1F4aTMX538RxzczyPtsRYj7l8SQqOKMisaa7VTAbfJoOGg3+a0velXFiAB4Pr35jfm9jGAb
	/wHo7wosareIL6R3WNyhterN2CJ/E48I=
X-Gm-Gg: ASbGncvd0uzEzaxfSHweFS4j1nxVKci2mRuvVGeF4zcqC+UAm5RxFtQo6jBnAF7Q8ST
	HBcepoRWLSuZUMPBTYmyxqd7z+yTtgZiGK2fi53XrlkRdDAcaeA/SAUqUr6zKlyZ9lDp923ocr1
	Kj5FxIlNS/dDJOQ4j/z3X3gA857toTKmqnrXKlmhH4Rdk=
X-Google-Smtp-Source: AGHT+IFOwGEPnagR6chR2pgl9dZj8xnYqBB6sJKwhM8ym0W00BxzcsnReqW2Qj8u0WxKmR2qxqDwdA4Jl8mCypuNnQs=
X-Received: by 2002:a05:6871:8117:b0:2ea:6ec5:f182 with SMTP id
 586e51a60fabf-2efb29c36d7mr3665910fac.38.1750901956008; Wed, 25 Jun 2025
 18:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618105048.1510560-1-duanchenghao@kylinos.cn> <20250618105048.1510560-2-duanchenghao@kylinos.cn>
In-Reply-To: <20250618105048.1510560-2-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 26 Jun 2025 09:39:04 +0800
X-Gm-Features: Ac12FXyvsWhMw83Xbvuq3TX3OUb846H4mw0SBKx4nYB1SN5YUlkOtRBLdFMmCo8
Message-ID: <CAEyhmHTA+6RdD4CbQuMn2E887Z3E6RudJQb3Wnmqosj1ozrXPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] LoongArch: BPF: The operation commands needed to
 add a trampoline
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

On Wed, Jun 18, 2025 at 6:51=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> Add branch jump function:
> larch_insn_gen_beq
> larch_insn_gen_bne
>
> Add instruction copy function: larch_insn_text_copy
>

Please rewrite the commit message properly.
These functions are generic, so you can drop the `BPF` prefix from subject =
line.

> Co-developed-by: George Guo <guodongtai@kylinos.cn>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> Co-developed-by: Youling Tang <tangyouling@kylinos.cn>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  arch/loongarch/include/asm/inst.h |  3 ++
>  arch/loongarch/kernel/inst.c      | 57 +++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/a=
sm/inst.h
> index 3089785ca..88bb73e46 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -497,6 +497,7 @@ void arch_simulate_insn(union loongarch_instruction i=
nsn, struct pt_regs *regs);
>  int larch_insn_read(void *addr, u32 *insnp);
>  int larch_insn_write(void *addr, u32 insn);
>  int larch_insn_patch_text(void *addr, u32 insn);
> +int larch_insn_text_copy(void *dst, void *src, size_t len);
>
>  u32 larch_insn_gen_nop(void);
>  u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
> @@ -511,6 +512,8 @@ u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int =
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
> index 14d7d700b..7423b0772 100644
> --- a/arch/loongarch/kernel/inst.c
> +++ b/arch/loongarch/kernel/inst.c
> @@ -4,6 +4,7 @@
>   */
>  #include <linux/sizes.h>
>  #include <linux/uaccess.h>
> +#include <linux/set_memory.h>
>
>  #include <asm/cacheflush.h>
>  #include <asm/inst.h>
> @@ -218,6 +219,34 @@ int larch_insn_patch_text(void *addr, u32 insn)
>         return ret;
>  }
>
> +int larch_insn_text_copy(void *dst, void *src, size_t len)
> +{
> +       unsigned long flags;

Initialize flags ?

> +       size_t wlen =3D 0;
> +       size_t size;
> +       void *ptr;
> +       int ret =3D 0;
> +
> +       set_memory_rw((unsigned long)dst, round_up(len, PAGE_SIZE) / PAGE=
_SIZE);
> +       raw_spin_lock_irqsave(&patch_lock, flags);
> +       while (wlen < len) {
> +               ptr =3D dst + wlen;
> +               size =3D min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
> +                            len - wlen);
> +
> +               ret =3D copy_to_kernel_nofault(ptr, src + wlen, size);

I am not familiar with this mm thing, but looking at other callsites
of copy_to_kernel_nofault(),
it seems like you can do this copy cross page boundaries.

> +               if (ret) {
> +                       pr_err("%s: operation failed\n", __func__);
> +                       break;
> +               }
> +               wlen +=3D size;
> +       }
> +       raw_spin_unlock_irqrestore(&patch_lock, flags);
> +       set_memory_rox((unsigned long)dst, round_up(len, PAGE_SIZE) / PAG=
E_SIZE);
> +

Do we need flush_icache_range() here ?

> +       return ret;
> +}
> +
>  u32 larch_insn_gen_nop(void)
>  {
>         return INSN_NOP;
> @@ -336,3 +365,31 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum =
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
> +       emit_beq(&insn, rd, rj, imm >> 2);
> +

This does NOT match emit_beq's signature, should be:
    emit_beq(&insn, rj, rd, imm >> 2);

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

