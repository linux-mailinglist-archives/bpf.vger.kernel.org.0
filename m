Return-Path: <bpf+bounces-44669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019939C634A
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 22:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B8D2845E3
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 21:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C69A21A4AD;
	Tue, 12 Nov 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIcIqKXt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B319219E34
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 21:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731446489; cv=none; b=uNCaWKlXoK4qC+glAm2D5uM/5/FcGH7AqJXWDluzdV9on0kYId1EFx4J3BsTT2Sv4Kx1D77lPJQPVsxFNwZkVbLBXi+OkkF9PgfMGiUJIAqqQLpVruhXUwG9j/VZYvG1yqccX87hrUQTxTPmgCUI/HIznzQt8xdJ1C403PwVkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731446489; c=relaxed/simple;
	bh=Ip4jE4grlOKu6KKbVH3geo0mBwOHx0Yh0de/886RRFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qXUqWw0pwdM+rvZjUibeVyUdb81D/rCS8cZ/Amr0rAuSHTqF1gB0C5zt5mnjNMUw+TahC8ricAJEXQayfpEUSURyvHHMYIsKLn2FUDEnzgMHlxYqUzTdSVNCJTfEFCXlghQos6LbjPLebZf3UkUP2cCCziNoboaqtA05WlmEP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIcIqKXt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21116b187c4so49405075ad.3
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 13:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731446488; x=1732051288; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pxc1lGqMB+oV9iZk6O4r71XR2J4vzCBliDHAexxqcYs=;
        b=YIcIqKXtnR/SSexv8ef1W7KOihDV7LoSeNTqbayiO3xIt4GjK9USc1D1CCJFSmb0sP
         0ZC9VKlVdO9xtH4U4t19wpcw7kZOrRlIyGSLu10nYpWDbvdws/2CziSt+ig/yEBT3vf+
         ZJmo0G+pgRA6wGSRiAMMbN3uFvLGOrdxd0TKW/9XR5qqK3grMnur6JoEgjARJPhpvypB
         A38y1Tf3xfNFBxhC2IEAWW9zGb/u447YdFJfFlPR+dZBS6su7YvB9jNEEb5y5F3JUHAU
         KE4YEpd6cSo8m0JgyfhNAIcIB6KuHSgJYftCRj1OoMcbWW4XkFZYPzFGqxyQTiVwwoBP
         5yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731446488; x=1732051288;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxc1lGqMB+oV9iZk6O4r71XR2J4vzCBliDHAexxqcYs=;
        b=nz+Q5hTbmReboCNmUCBX0xBzytVmN+XW8mVzL1RncjaF4x4N0dsaKXVAQ4WMEM84pf
         UDAY84BFTG9fbUJOvarVnN57s6xN72VsbS5mTKT8DvrcOXF+BCXHrBUrnb0Cvxbgrq8O
         55g6MdUXv6XNLQhLtyBGLMfgcyTb1Ouv5x+8LSbEGLFhcfT9gGg55JplXWqipMsstFL1
         jcI8vBFJcCm9RUBqDkHDL5Efd7qijWWFuSfSMoxBKb3d/uVa7opfWuJlHGWags5B3bIp
         z5W6kW6VKajIqxnLOzlI6QhWw5zloylnN2PJyt62VScR51Btixc6a2pQSjzlelWI5Rp7
         Uv6g==
X-Forwarded-Encrypted: i=1; AJvYcCUfoqzKBS1PEKtNcBPxE3PWJWRM2xrGtTD2UBj956J9H9kRgfr9DFjwwfZM8XwEjwWdOBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23I86Oh1Fg35/b6aj08O+DNinAaEPjiiIKfs62AOyn5ZNDUhN
	n2pQtqZnFDk9sQPlA+jDMr+VnyPUUFoWnn7Yojz3h4pJxikKJzRb
X-Google-Smtp-Source: AGHT+IFVe2NkxWhMJwh831VEPl3i8HPdoLnc6BQBJF3JypJ9NXqKai6dhaxpYKpBs904z40dgvxi0A==
X-Received: by 2002:a17:902:c949:b0:20c:637e:b28 with SMTP id d9443c01a7336-21183e12174mr235812725ad.39.1731446487598;
        Tue, 12 Nov 2024 13:21:27 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e4168bsm97744625ad.150.2024.11.12.13.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 13:21:26 -0800 (PST)
Message-ID: <cd904b908d0d84c4f8454683495977f64d081004.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add bpf_get_cpu_cycles kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,  Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Mykola Lysenko <mykolal@fb.com>, Jakub
 Kicinski <kuba@kernel.org>
Cc: x86@kernel.org, bpf@vger.kernel.org, Martin KaFai Lau
 <martin.lau@linux.dev>
Date: Tue, 12 Nov 2024 13:21:21 -0800
In-Reply-To: <20241109004158.2259301-1-vadfed@meta.com>
References: <20241109004158.2259301-1-vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-08 at 16:41 -0800, Vadim Fedorenko wrote:
> New kfunc to return ARCH-specific timecounter. For x86 BPF JIT converts
> it into rdtsc ordered call. Other architectures will get JIT
> implementation too if supported. The fallback is to
> __arch_get_hw_counter().
>=20
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---

Aside from a note below, I think this patch is in good shape.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 06b080b61aa5..4f78ed93ee7f 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2126,6 +2126,26 @@ st:			if (is_imm8(insn->off))
>  		case BPF_JMP | BPF_CALL: {
>  			u8 *ip =3D image + addrs[i - 1];
> =20
> +			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
> +			    imm32 =3D=3D BPF_CALL_IMM(bpf_get_cpu_cycles)) {
> +				/* Save RDX because RDTSC will use EDX:EAX to return u64 */
> +				emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
> +				if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
> +					EMIT_LFENCE();
> +				EMIT2(0x0F, 0x31);
> +
> +				/* shl RDX, 32 */
> +				maybe_emit_1mod(&prog, BPF_REG_3, true);
> +				EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32);
> +				/* or RAX, RDX */
> +				maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_3, true);
> +				EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF_REG_3));
> +				/* restore RDX from R11 */
> +				emit_mov_reg(&prog, true, BPF_REG_3, AUX_REG);

Note: The default implementation of this kfunc uses __arch_get_hw_counter()=
,
      which is implemented as `(u64)rdtsc_ordered() & S64_MAX`.
      Here we don't do `& S64_MAX`.
      The masking in __arch_get_hw_counter() was added by this commit:
      77750f78b0b3 ("x86/vdso: Fix gettimeofday masking").
      Also, the default implementation does not issue `lfence`.
      Not sure if this makes any real-world difference.

> +
> +				break;
> +			}
> +
>  			func =3D (u8 *) __bpf_call_base + imm32;
>  			if (tail_call_reachable) {
>  				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);

[...]

> @@ -20488,6 +20510,12 @@ static int fixup_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>  						node_offset_reg, insn, insn_buf, cnt);
>  	} else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_=
ctx] ||
>  		   desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_cast]) {
> +		if (!verifier_inlines_kfunc_call(env, imm)) {
> +			verbose(env, "verifier internal error: kfunc id %d is not defined in =
checker\n",
> +				desc->func_id);
> +			return -EFAULT;
> +		}
> +

Nit: still think that moving this check as the first conditional would
     have been better:

     if (verifier_inlines_kfunc_call(env, imm)) {
        if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_kern_ctx=
] ||
           desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_cast]) {
           // ...
        } else {
           // report error
        }
     } else if (...) {
       // ... rest of the cases
     }

>  		insn_buf[0] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>  		*cnt =3D 1;
>  	} else if (is_bpf_wq_set_callback_impl_kfunc(desc->func_id)) {



