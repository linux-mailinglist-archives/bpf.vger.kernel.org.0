Return-Path: <bpf+bounces-63090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79413B025DA
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 22:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF481C47CBA
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 20:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC8E1FE451;
	Fri, 11 Jul 2025 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="MAOhYeuX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D801C84A1
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266441; cv=none; b=olnOKxdcvgKonMFizFMcrJs+fUCNrMwu+od7VpsgbqzSFIHHcA+Rv3VgYCifYtK3omnBA3v4o1jf5M58m3lVF265tpqLHWvi46bMFbjJVsThyeUTG6HS/Tl31htUv1OQ4Y7m+YlsXBM3+JlRk1colWTMcBfklsF4EEZmcg0rxwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266441; c=relaxed/simple;
	bh=EgxMiEzXV4BHBoNhQki9lRtfEJHjMHicsxYww/CypW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYrKqRN3U3qIV+rjAhiCVJDLDvWbDphzWzKvmpjXXkXDw0WlJOBrQsjmzSEaoT8xudtCMWi+K+rQ0oamq4EwZNNrtbC54ZQeggMoBYP368oxbk3LuD8jTzGGdazdEsvUgFypt8pjj+yo7+oW+JpwfCuRoSxGwhEGYy5d9YwqqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=MAOhYeuX; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e897c8ca777so2277890276.2
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 13:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1752266438; x=1752871238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdCeu7JxJv4UATclN8T/Xy1z+bkPL1FfgfG7ODF2Nis=;
        b=MAOhYeuXtiKjjsRcGhe/2bbT0Yth0IuBLXinWZ317CFvN/uvtysC+onZdG4r0I3DpF
         RtUxB4xKjIGqrLvR3N4U1b6SNjKNPRCjqrGZ12YCuc7kR74052+rZJdhLcjbKFtMwhXt
         CUozKFMjcI+Z1s8P+nsm6kz1P1RpNNZTedxiDGXVAhdpUIF2H6WSzjZbA2YWAZVLoU/K
         PFIlV349x60TR+8szKsQbfKKaFFxzmUV8B9OxESeFoi453OEvYmLdXiq8CnNDWBCvdE7
         gmgyNxhacHFD5WZZlk5xa9meV+nV1rzlpb/uVNj3Z/hOuinHo5xCsHecdcWcBB2tGsb2
         AoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752266438; x=1752871238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdCeu7JxJv4UATclN8T/Xy1z+bkPL1FfgfG7ODF2Nis=;
        b=nG0hqeSPJ9JPuaNJ+0DvU5EtqwpqUgCVvvrbJGgluywQqeEH+357lifeEKisxGiCHq
         /lsPIaS6JJL/odQRz6XtXDMMNaPZ5erUZ94LPq6/0NyBOCihddhAtF0/B4Tz8G3sBeBA
         2V7bsFaw76igPhE1e3hIixs5YqE3pBHwDrTjOChLO7W0Ecm+iDn3DFiXArPk3ei31PNw
         20zRIklUo9dlPhySRY3P0hydiyJrt+LtJ0JvzSJmNTU11/AB06Rna0UHcoZ8c7m8s5Ea
         YmHUQR9IHltH7kzGq4VRNUaGU/ff1WhryBpONAzr2KLW0mpwxHUQIRbIh9ypjqU33XH5
         cnZg==
X-Gm-Message-State: AOJu0Yx0hZSHFZPsgpKapsibRd29AOIk3R2zxZ9BmJuOCtQf5c6H+nPN
	kHjU/aiaiM17dWTDITX+LTFY6sD2nXJBJ8FDqSY6MlesAm8jnFtbs+Cfufw44WmWxprafV4DoZm
	UUCtdl5tM/8Bzu82l/CgwpBPfdBcVtZkkWu9wUFJyRjcUNEa0ozwgCyc=
X-Gm-Gg: ASbGncvTzX8EJNT9KEX8OPfOkovtqF82RecZ+CDPwvfCEc+67kPgBZ4+lJ2DERdHkdQ
	pDWfxgYt68LGOsarPJB4KpailFfviZl1yyuYB3d7J+o7oPR11ueCh5c7n8tD/SkTqBUa55mrs9X
	8n8ZuXyN4n/slLVASzN4aHB7EkfKAoPgnmM+ww35NCC3z32ZvK40oWYz08Lj2DxhbNyIWixwbzi
	FTz8HGC
X-Google-Smtp-Source: AGHT+IFqxgdaqyq7dDfOcIcYIu74TqNN5bG7fwUAb/a3u4dxbFT7+HbI4XewTpeTt9+IUxZpa+ME1UCXKVj/TljTW5I=
X-Received: by 2002:a05:690c:4c0a:b0:710:ea78:8ff with SMTP id
 00721157ae682-717d5dac0ffmr85444937b3.23.1752266438070; Fri, 11 Jul 2025
 13:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711201159.75592-1-emil@etsalapatis.com>
In-Reply-To: <20250711201159.75592-1-emil@etsalapatis.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Fri, 11 Jul 2025 16:40:27 -0400
X-Gm-Features: Ac12FXzBaAMj2hCM8B7oVPAEiHsy-QkUbzsIsRko5Ztg975v3boAoRmFVptpNxs
Message-ID: <CABFh=a59MYYVXKzKAjPUbEKkBxMGzMuNC=7Njoe5YeiZraAnbA@mail.gmail.com>
Subject: Re: [PATCH] bpf/verifier: factor BPF_F_TEST_RND_HI32 flag check out
 of opt_subreg_zext_lo32_rnd_hi32
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, memxor@gmail.com, 
	yonghong.song@linux.dev, sched-ext@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch is wrong, please disregard. Sorry about the noise.

On Fri, Jul 11, 2025 at 4:12=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> BPF programs can be loaded with the BPF_F_TEST_RND_HI32 flag to instruct
> the verifier to randomize the high 32 bits of a register being used as a
> subregister. This is done in the opt_subreg_zext_lo32_rnd_hi32 pass that
> scans the BPF program instruction by instruction, regardless of whether
> the flag is set or not, and testing the flag on every iteration. However,
> the flag is not modified at verification time, and the function is a no-o=
p
> if it is unset.
>
> Gate the randomization pass behind a single flag check instead of
> testing the flag in the main loop of the pass.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  kernel/bpf/verifier.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e2fcea860755..dc0981205d6a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21062,9 +21062,7 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct b=
pf_verifier_env *env,
>         int i, patch_len, delta =3D 0, len =3D env->prog->len;
>         struct bpf_insn *insns =3D env->prog->insnsi;
>         struct bpf_prog *new_prog;
> -       bool rnd_hi32;
>
> -       rnd_hi32 =3D attr->prog_flags & BPF_F_TEST_RND_HI32;
>         zext_patch[1] =3D BPF_ZEXT_REG(0);
>         rnd_hi32_patch[1] =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, 0);
>         rnd_hi32_patch[2] =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
> @@ -21080,9 +21078,6 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct b=
pf_verifier_env *env,
>                         u8 code, class;
>                         u32 imm_rnd;
>
> -                       if (!rnd_hi32)
> -                               continue;
> -
>                         code =3D insn.code;
>                         class =3D BPF_CLASS(code);
>                         if (load_reg =3D=3D -1)
> @@ -24700,7 +24695,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr, __u3
>          * insns could be handled correctly.
>          */
>         if (ret =3D=3D 0 && !bpf_prog_is_offloaded(env->prog->aux)) {
> -               ret =3D opt_subreg_zext_lo32_rnd_hi32(env, attr);
> +               if (attr->prog_flags & BPF_F_TEST_RND_HI32)
> +                       ret =3D opt_subreg_zext_lo32_rnd_hi32(env, attr);
> +
>                 env->prog->aux->verifier_zext =3D bpf_jit_needs_zext() ? =
!ret
>                                                                      : fa=
lse;
>         }
> --
> 2.49.0
>

