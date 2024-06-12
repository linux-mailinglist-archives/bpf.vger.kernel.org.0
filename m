Return-Path: <bpf+bounces-31964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE414905998
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 19:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549DA2847EE
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99E11822F1;
	Wed, 12 Jun 2024 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipCgHn1e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40ED28DB3;
	Wed, 12 Jun 2024 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718212044; cv=none; b=YpdWuzk5VcnwclnMLCKTzkUK2f5rk0Uc2LWzrfdWoBmM9vIFvXA4B6WGi/q8BWPZI5JgoF6013iigpBZyRTSxeTDsTJ8AQoiWiGKRS5Zo5NHzwvKlT8taugAGCNjL0ymxztL1OEbCEmNFZuZFu5LxeO5BzJNIf8dL213MB1nwIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718212044; c=relaxed/simple;
	bh=SKfMsfpuRskP07jTZ/SF0CfZ2NDTe3YEm/3ZVgENZfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgsIRE/Lutnirdh2faWtvDJKWTdu9Gpju7vf+MyuWpUOPBOrJb3MUpu/FTuTzCq19ccn1kK49So0rcFIbigZLhaIGiMCZSqiYFcg9e8rcn5y62dJWwYa2IU+bmGQY1C5w8qq2QnEfz5hvcpSrb1d0kcl+wFKDWZgQqpxWUXiCC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipCgHn1e; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f2c0b7701so71094f8f.0;
        Wed, 12 Jun 2024 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718212041; x=1718816841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocpRwy0sziQcbAmBE7fGUEw2nPXigRY3R3IXpRSwnH0=;
        b=ipCgHn1eQ+rSMNmPMdbOstbi0sIP2PygQTEmimVoCtoIHGuISwS5sev7qycV8jR+NG
         d0LX/ketYMyPpB0DruUiahzlzsSb6cAJ0JEFlAiYVipGmbcc1BuAkZgoTkTBeiV5b3jC
         6G8Sn41CcsFdWuyQIHfkLvjfTf139F62oYJiiO4FcZ/YVt6gw0TX5cmzJSqZQu8Og9JJ
         Ga6drkL65HhwhZpB4+2xr70/m6z6jh2979l+C68V6AjVkXrSP45+HCFN/tEX5ny9pavL
         Kvwukjm0YXwHrwEd+PTbQBryUV5k5VwSTbpMXYuflch/yzkjxPCKkTrYMINsdjVtmEAt
         FHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718212041; x=1718816841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocpRwy0sziQcbAmBE7fGUEw2nPXigRY3R3IXpRSwnH0=;
        b=ub8Mx3xmBAtMminwPjmDrkfBa3FbCK1mZiWK+R8cVFsKYd2Ql3+fYE+uKwz/3+K1Ks
         Kbe+6mQPjkD6wk6iodagWj8owmSJms/Y8Jd6IDQgi8v26UOD3t75lXWAz4UdOMpCMb3O
         n4QZcbDIVvtq74DeIj1q29dQq/14WfozCcg+NkWObz7g7uunxhXrFJQiQuy0VRAhENoO
         CINsR+L+4HynFZdoHK7T9bVn9sPFI+umrqwvoRd2YbTMg9gXBo8/EIoDUcqmxF8Mkqtu
         EK/5TUFU0QBbW3O9fuvkHBJX3PWGW1R6+EVYEoHV1Fg0MPD0lfnOweyzY4GZHVmaRuZT
         R1MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw1P74wX/vtylHTgaMYVIdZ8DrKDBJFRrnOsEhHQY2IRyie2DAxst8EBNvNxXaUG3s7AHsue79/kXcef2yjlotbxV0lZuZpQrWB39g
X-Gm-Message-State: AOJu0Yy0PHSWC7PYoYqc7CjtaAQAxHPWk/SLgXMA8K4WbKTGeJxwD4Ef
	wC01XeFdbSXB7BqgqIG1TLVJRcdA1YukwRVqu+2VK1CrpL56TvqnLnDZYbQQzPfUCTdL9HyNhff
	21vEUC41iL90wrs2YqX9yuCH8cl8=
X-Google-Smtp-Source: AGHT+IERoFKlnMaUF+4foCYqq43qTtaHP4TR84rV3QZZFDG2tb5uh4VE5BV3+RDtYRHCD1c49Em/Q15dWxNBGcUASIE=
X-Received: by 2002:adf:f748:0:b0:35f:10b2:b588 with SMTP id
 ffacd0b85a97d-360718defc4mr314071f8f.18.1718212040907; Wed, 12 Jun 2024
 10:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <illfkwuxwq3adca2h4shibz2xub62kku3g2wte4sqp7xj7cwkb@ckn3qg7zxjuv> <c6fsgv7bjt2d2ejz2uuin2g475fkvpyenp32wehdqlcf6ihqgx@5gicsaw4u37f>
In-Reply-To: <c6fsgv7bjt2d2ejz2uuin2g475fkvpyenp32wehdqlcf6ihqgx@5gicsaw4u37f>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Jun 2024 10:07:09 -0700
Message-ID: <CAADnVQK6Vh-pv_ewS0RjBBfL5KUsMXpdMNFvv5F0OPWzABEsAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/3] arm64/cfi,bpf: Use DEFINE_CFI_TYPE in arm64
To: Maxwell Bland <mbland@motorola.com>
Cc: "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 8:32=E2=80=AFAM Maxwell Bland <mbland@motorola.com>=
 wrote:
>
> Corrects Puranjay Mohan's commit to adopt Mark Rutland's
> suggestion of using a C CFI type macro in kCFI+BPF.
>
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> ---
>  arch/arm64/kernel/alternative.c | 46 ++++-----------------------------
>  1 file changed, 5 insertions(+), 41 deletions(-)
>
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternat=
ive.c
> index 1715da7df137..d7a58eca7665 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -8,6 +8,7 @@
>
>  #define pr_fmt(fmt) "alternatives: " fmt
>
> +#include <linux/cfi_types.h>
>  #include <linux/init.h>
>  #include <linux/cpu.h>
>  #include <linux/elf.h>
> @@ -302,53 +303,16 @@ EXPORT_SYMBOL(alt_cb_patch_nops);
>
>  #ifdef CONFIG_CFI_CLANG
>  struct bpf_insn;
> -
>  /* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
>  extern unsigned int __bpf_prog_runX(const void *ctx,
>                                     const struct bpf_insn *insn);
> -
> -/*
> - * Force a reference to the external symbol so the compiler generates
> - * __kcfi_typid.
> - */
> -__ADDRESSABLE(__bpf_prog_runX);
> -
> -/* u32 __ro_after_init cfi_bpf_hash =3D __kcfi_typeid___bpf_prog_runX; *=
/
> -asm (
> -"      .pushsection    .data..ro_after_init,\"aw\",@progbits   \n"
> -"      .type   cfi_bpf_hash,@object                            \n"
> -"      .globl  cfi_bpf_hash                                    \n"
> -"      .p2align        2, 0x0                                  \n"
> -"cfi_bpf_hash:                                                 \n"
> -"      .word   __kcfi_typeid___bpf_prog_runX                   \n"
> -"      .size   cfi_bpf_hash, 4                                 \n"
> -"      .popsection                                             \n"
> -);
> -
> +DEFINE_CFI_TYPE(cfi_bpf_hash, __bpf_prog_runX);
>  /* Must match bpf_callback_t */
>  extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
> -
> -__ADDRESSABLE(__bpf_callback_fn);
> -
> -/* u32 __ro_after_init cfi_bpf_subprog_hash =3D __kcfi_typeid___bpf_call=
back_fn; */
> -asm (
> -"      .pushsection    .data..ro_after_init,\"aw\",@progbits   \n"
> -"      .type   cfi_bpf_subprog_hash,@object                    \n"
> -"      .globl  cfi_bpf_subprog_hash                            \n"
> -"      .p2align        2, 0x0                                  \n"
> -"cfi_bpf_subprog_hash:                                         \n"
> -"      .word   __kcfi_typeid___bpf_callback_fn                 \n"
> -"      .size   cfi_bpf_subprog_hash, 4                         \n"
> -"      .popsection                                             \n"
> -);
> -
> +DEFINE_CFI_TYPE(cfi_bpf_subprog_hash, __bpf_callback_fn);
>  u32 cfi_get_func_hash(void *func)
>  {
> -       u32 hash;
> -
> -       if (get_kernel_nofault(hash, func - cfi_get_offset()))
> -               return 0;
> -
> -       return hash;
> +       u32 *hashp =3D func - cfi_get_offset();
> +       return READ_ONCE(*hashp);

Please avoid the code churn.
Just squash it into the previous patch.

pw-bot: cr

