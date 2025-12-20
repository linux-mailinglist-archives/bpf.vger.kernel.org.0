Return-Path: <bpf+bounces-77248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC7DCD3097
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 15:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1560D301E14E
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161A62459D1;
	Sat, 20 Dec 2025 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XptUCPOM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4DC1CEAB2
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766239660; cv=none; b=SwFdCKA+YhNVJ8tX9MptXkfPbX4y3rZLmsP5l6cY72IlvSWxvXJv6QSk07dU4TPmx7yoP2jsaNICQGWWja5dgwLc9cZuSDAgVER064dO3FeFTN9/zgiwtOXJWQqAwGDku97K5yv+drhhZzPKR0V76Lf5n1f+xHDo7Pe6Z6Cy60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766239660; c=relaxed/simple;
	bh=ppuzKfXdvO9jvlXXAJ3Z8CDIdqR8C/0djsmJ/G/zQqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPx9mhouxnh2jgFGAuAO0B1xpWxG7VThG4McWOdWBOICAUJRIPbCNuiH7NBJv5Ss7lwusvQR/6L4750Do4b/wY15OIOIFR0x8YIa8GAPoOpavMKL0Q+rzgk32r2NsNAOmNmnynRFa5wmKIkQCZACq4VEydXMnAexqG3EvlwDPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XptUCPOM; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c75fc222c3so1122226a34.0
        for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 06:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766239657; x=1766844457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tc1iEedM1caQ6hqBuO/lN1WSU9IfL3Q4FFgEU8l0tOA=;
        b=XptUCPOMIb1bEcHpbY3RoSLIaWHsW9zGToRquY/2NNLJR/KBw9qiM9q5iPIha8dhim
         x6CXG/xynfVDHsT5mbcFjaGzxIUmITxenn2NwvsToA1CfM5RmkT6bXMxm3QIDZkN3P2Q
         Qw/CkiKk5LGIqeGksVSy5/9BIY2YUA4RTxX3MDCCAaJ+f6+YvyGCBH1MbjTMHSzB972R
         ZtrJF/FufwODlD0ntGJkFtnXGWfB/tP6Iw2u+QEYayOfbz/YIOBWj2wcBMS2bHxFdU9G
         gZqHjy7q+50znKcJfSQz7Uqu4C/yJh9HrRqNN/KZSwuUySEqMEC0FJSdfeqOijTA6qxS
         FuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766239657; x=1766844457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tc1iEedM1caQ6hqBuO/lN1WSU9IfL3Q4FFgEU8l0tOA=;
        b=XOU7BKTfKycgQIDEkSbO+vL3ipD+r5YrT8gnL4H2fW+k/7yJEyQpP2uGdLcLi71Aw7
         GBbcnx2yYMsWJfihmZOs0OVqg3XerFk1BADlcsBDHfw58e+HemPwUYe18Q6KH5UzAHlR
         7gREonVn6Rt6kbG8/eh80KJurdWZ8Yx0yd76Zi1MOEa1DSO6K2kGvnAHzO0wb0d4S31+
         ufbdIDTptf7fsRyGMawGTzZp9CxH6KF74mc9KwCFPpjELroxqTmcUr/C1AfSdbmFu70p
         EWOpUTCw3ueY9qcHS5gixKttM08ji2NvNqZntVuipgma+9VUCz6u0GMy1Z9KOUjf8yBd
         Ae5g==
X-Forwarded-Encrypted: i=1; AJvYcCUXRlsAfcOAzWYTqBs4xoJFpfqoh5SCD1x+YrZusSkd0qJp6+mWbY2AIeYb5GhFNdeFM7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE7iY/vkuAqgyLTx5FPR6FP1g2J/i1mzfRl93TQ+KFw2ipiKRJ
	q26Ry89982XYxCa7yLvou6mY1KjzcnR7xfjzjdGvYDrWcDBY1ubx9tg6ogGjykLu7CuZo/KNcfS
	gulbmHcCRXA7RFZOoLVCwGOoUdEdYors=
X-Gm-Gg: AY/fxX5Yb+SiWbElu8s7uA5NOAoQqKKgB1P6ceCqEsfRUSyaWiSdfR2qnO3/Z4Kox58
	HgmrXQ9k9sTuJNpxFX9QJaHR/y5hMCmaG0RYKYKAoqxGkXV7fexcwqT4IpPqp1GbSOVeL7w3JLa
	5P1NBYEMM/K4FEmxukPXaS1aX0/MEQeydeYJN1jmbkTRAyhjkLs3dnjS/qVnWTevtPNZdJMP3bm
	Y4yhKWGCG9JgFJGZR8vyh8AkfOlaubiGhziknEu3PACeNvm8Na6k2ATS1VEn2sbRBEe6Y8=
X-Google-Smtp-Source: AGHT+IFKJvWy/VbyNKsiekvuWECXFOl3II4PdAI1c5BeYHGXBeL5yRX9cLnJ1GnL00cdoCslt6FVO9gv5pYDRsHn0iU=
X-Received: by 2002:a05:6808:c1ae:b0:442:e596:1189 with SMTP id
 5614622812f47-457b223fceemr2941683b6e.45.1766239656930; Sat, 20 Dec 2025
 06:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217061435.802204-1-duanchenghao@kylinos.cn> <20251217061435.802204-7-duanchenghao@kylinos.cn>
In-Reply-To: <20251217061435.802204-7-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Sat, 20 Dec 2025 22:07:25 +0800
X-Gm-Features: AQt7F2qcrrU65Yn384r_DbQIv295t02mQ5NXmH0yR08XLRQSjXo2M45Sl0nHU1M
Message-ID: <CAEyhmHRbacxpfTkPJq4MerBupH0bJkFfx8xGUvHMvGOzDDJUow@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] LoongArch: BPF: Enhance the bpf_arch_text_poke() function
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: yangtiezhu@loongson.cn, rostedt@goodmis.org, mhiramat@kernel.org, 
	mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, 
	zhangtianyang@loongson.cn, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, youling.tang@linux.dev, 
	jianghaoran@kylinos.cn, vincent.mc.li@gmail.com, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 2:15=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> Enhance the bpf_arch_text_poke() function to enable accurate location
> of BPF program entry points.
>
> When modifying the entry point of a BPF program, skip the move t0, ra
> instruction to ensure the correct logic and copy of the jump address.
>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 3dbabacc8856..0c16a1b18e8f 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1290,6 +1290,10 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_pok=
e_type old_t,
>                        void *new_addr)

The signature of bpf_arch_text_poke() was changed in v6.19 ([1]), please re=
base.

  [1]: https://github.com/torvalds/linux/commit/ae4a3160d19cd16b874737ebc17=
98c7bc2fe3c9e

>  {
>         int ret;
> +       unsigned long size =3D 0;
> +       unsigned long offset =3D 0;
> +       char namebuf[KSYM_NAME_LEN];
> +       void *image =3D NULL;
>         bool is_call;
>         u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D INSN=
_NOP};
>         u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D INSN=
_NOP};
> @@ -1297,9 +1301,18 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_pok=
e_type old_t,
>         /* Only poking bpf text is supported. Since kernel function entry
>          * is set up by ftrace, we rely on ftrace to poke kernel function=
s.
>          */
> -       if (!is_bpf_text_address((unsigned long)ip))
> +       if (!__bpf_address_lookup((unsigned long)ip, &size, &offset, name=
buf))
>                 return -ENOTSUPP;
>
> +       image =3D ip - offset;
> +       /* zero offset means we're poking bpf prog entry */
> +       if (offset =3D=3D 0)
> +               /* skip to the nop instruction in bpf prog entry:
> +                * move t0, ra
> +                * nop
> +                */
> +               ip =3D image + LOONGARCH_INSN_SIZE;
> +
>         is_call =3D old_t =3D=3D BPF_MOD_CALL;
>         ret =3D emit_jump_or_nops(old_addr, ip, old_insns, is_call);
>         if (ret)
> --
> 2.25.1
>

