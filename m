Return-Path: <bpf+bounces-44707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CEE9C66BC
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 02:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DCD7B25AB5
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 01:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE7E273F9;
	Wed, 13 Nov 2024 01:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mddemNtl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF0B29A5
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461520; cv=none; b=eLvNRNvs9E3/6/IE13rammCE/y8+O57lWc8VwJhnEVljF1QfvUE81ELfx1zRWg3wmEglkTHcbDnpOSj5oFLk8ojA7TdzoX5waVBluNo7vnG+Jbafm8pTFs/fP9Zb6pLSjNghywGGz6kYm1IjxbZ4jH9KSQsAF7TINkMwPwaj4vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461520; c=relaxed/simple;
	bh=QVLyZOCxUKi/K8cAFGP0IVfdpcYBCvBxiRM9kOla8cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5ktCrXhdaioeTDoTfR+qPOriYXro5RgJ31er2p7qtz3YkU45+HG/u881Oj6xJyw0GYXoN+OpBpYiGBilSIdFWhNmD7moMZN+OWNZU3Dz+AoFbRt4krUAYChBPBNEdHvmuR0YEOKFi9VyURk2vL0nLaus2NB9lluJZzn3n804A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mddemNtl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so3951819f8f.1
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 17:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731461517; x=1732066317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHejYUW1WRl+1dFWcbyatQwE21oahwQ6h6szAkm68oE=;
        b=mddemNtlyDLrXWDYgRoppc25S4YxDbvXwTLErk7t9ufsHO6kxu2SbcfYsmmxIRC11h
         xjh/80IMivhaHHa76IbCS1fdMMquofHlehIvUbYX25cpywP/fxmwllvMmamQrrudOQR+
         JYMGl+t4mxnOANSvqA+7uW9uba00J87KOY59mu3NyE3Y2EzxwqHQroq5VNO+T4cRp7ct
         7bDekCep1vFEI1Mx+60VV6onURu12ojnI27aueGjfjtChrZnJlKZeT99NTIl2rXXz5YJ
         omXA3oBbweU4T4oiqPRjC4b1FE8A9/uBw+BiH6JdZM6p9iuUSclzqpXIi2wRP1Fz73Cx
         dqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731461517; x=1732066317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHejYUW1WRl+1dFWcbyatQwE21oahwQ6h6szAkm68oE=;
        b=tOfXfwsZwgGMJz/mkwWo9vMewhLD7Lz/x5Lgscy4SrsDpluv/vHZkdz0eY1PQ5YgD/
         yVuigRCZBptND3EpB/FJQ1CEgViC4HfOJ3lbiK3hb1DxiVnZLzZlKlEGBpocHT2tvg8e
         0XW5c7ThD8ddF4kzcCt/aUgbeQcSyWjxmVbuW90Z5v6pQ6RNV4trmzOSBZbMg11iO3fd
         u7ZhGg5MlxGP0zZg7hTNOj0ZUZIIILMEs9wqK1I8S2l549pFAKcFYODbFwELKbCKbxwR
         852a3enh+IPf/Cq02wbJGeHVLEOUGJQhqeXDjRutctK9B9mpMb/gRNozcHDjfClrB+am
         uGeQ==
X-Gm-Message-State: AOJu0Yz3KX2D95mm0AykKh8IUAmyr4+2CmZse9jyoIoCTzGv5tLKLQX4
	+9L4H1nIjps9UK0hCtG96E1MVbYjzmQOaV87SKP3HBE2JzOV+8rh72N4ypgSNOaVfN6Ndq/G4yS
	jLPdgWBZrAwOkayvILrVUqYMQodw=
X-Google-Smtp-Source: AGHT+IG6/mQ+XlMTicVyyFvHhvcfc0zjJR2nchmVPSJyh34j2siJjfAnuInnbnMdLXUA6sQv9EGxH4ZPOJnoe9Sv0dI=
X-Received: by 2002:a05:6000:4605:b0:37d:5436:4a1 with SMTP id
 ffacd0b85a97d-381f18673c6mr13698372f8f.3.1731461516923; Tue, 12 Nov 2024
 17:31:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107134529.8602-1-leon.hwang@linux.dev> <20241107134529.8602-2-leon.hwang@linux.dev>
In-Reply-To: <20241107134529.8602-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Nov 2024 17:31:46 -0800
Message-ID: <CAADnVQLvt3T5X3wev2fZ1pvwqzJ0_tB-DXxTdBp8GOo+DP_c9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf, x64: Propagate tailcall info only
 for subprogs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 5:46=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> In x64 JIT, propagate tailcall info only for subprogs, not for helpers
> or kfuncs.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  arch/x86/net/bpf_jit_comp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 06b080b61aa57..eb08cc6d66401 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2124,10 +2124,11 @@ st:                     if (is_imm8(insn->off))
>
>                         /* call */
>                 case BPF_JMP | BPF_CALL: {
> +                       bool pseudo_call =3D src_reg =3D=3D BPF_PSEUDO_CA=
LL;
>                         u8 *ip =3D image + addrs[i - 1];
>
>                         func =3D (u8 *) __bpf_call_base + imm32;
> -                       if (tail_call_reachable) {
> +                       if (pseudo_call && tail_call_reachable) {
>                                 LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->sta=
ck_depth);
>                                 ip +=3D 7;
>                         }

I've applied this patch with this tweak:
if (src_reg =3D=3D BPF_PSEUDO_CALL && tail_call_reachable)

I don't see much value in patch 2.
The tail_call feature is an old approach. It is now causing
maintenance issues with other features.
I'd rather not touch anything tail call related.
So I dropped patch 2.

I'd like to see proper indirect goto and indirect call
support being developed further.
Anton started working on it, but dropped the ball.
We need to commandeer the patches.

