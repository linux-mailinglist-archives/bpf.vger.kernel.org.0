Return-Path: <bpf+bounces-35202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93744938688
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 00:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14C01F2117A
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 22:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9918810979;
	Sun, 21 Jul 2024 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMtdlbcz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CECDF78
	for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721601917; cv=none; b=hKqztuPVb+FzhqqBlD1sw0v+WNupUL7GJd7EhxU+ugKNsKBpM7HBpNVpcymOo5P5Y18E1Raa+eSvGD8s1+S6kyHHptoSxSS7SU8IsYJb/WVqiQ3TyUaGOCVmfSUlBR2CP47qvyANwx8T1kzfZ7oKIBW1Er0ZrH4URgTmLBPVSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721601917; c=relaxed/simple;
	bh=XAB61vLKJWnDQlcFZR7bf5Sq7OYUpOASYDv2+D+ZFO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7mrgPBTlUchaZM21L+3cSotWIKTceRyT0D6T7Yh/oGeoz1pHRs8CcO2bcayA81UkEe93yQImWTc8qcXOGYKbP04+hP9bPr3xUe6h+Gr7KwKQfPQE5re14bsdIG8r4IV9Cm88BnLKaP5/8LBcvmYplDaP0duPEcpFjUoLSUibXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMtdlbcz; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso1288768276.1
        for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 15:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721601915; x=1722206715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KImFB+SXLsoOxEFt5UuwpafcPo5jSSvyoPC95qiitmw=;
        b=EMtdlbczPnM+KjrUv5Qz3jUOdrI92nyreG4VQoB9ubEdWBrw4/2+mMSshf6pDzNPkv
         WgcDx9bdVDPnvF+riFGTrZ/Hyg0iwCup72zBxbfqLGKVOICh8/r14adrmTZaOlcwXUY8
         rKWEKQc2b55Wlh0XGb1MWcYj9mEwo+tqa8/uvTuUq97i8pfY0lwzrGfk3t2gjigTdgDh
         fH365ZbhkCTgI1CV7D/pF57vQKAdsDSXo3V0xbalxEutUSny+IkKLY7pngaUDzQMVjgm
         9eZqhSUuudhDJC/aP9oZr5xN2M7IWKcA0TEmvZ3fe+bjtxXSvW93q5GhlqkUSiqRbYkO
         BeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721601915; x=1722206715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KImFB+SXLsoOxEFt5UuwpafcPo5jSSvyoPC95qiitmw=;
        b=Bw8TNOtD8xWAbHCnLM6oXw9jnzNUqSsx8G17EM+RgkAqqik5bDZL9UB/uou1BvJhPX
         LDst4zxWMyRmL0Vxzs3dhP4pMy2vUJu/6uCBFBgwKRWEsNHDUi7bL9JTev8V5SP/irLL
         NkLOmb+GyE5QVbBk2m98Bgznw5c0iypYTxF/BRYLeDubesbRIrxis8wyJpOlz2N8BxIA
         T8RaceJtI0OILAUf6wlP/btOgXzkLZsPux4nDuSpaOCMUOisqqeML3/xdYhgHsREw0Wb
         yF71dhT5j4wNOwPmLI1ITnGqOPcOQhQe/moYyNEoAdUXScOy3r4rkftqbC9zWO00OoEM
         gd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLBDpMo5plcoq7CwckD95gfncUxGx6NaTSPTCvdKKyoOAV0f58fEbt4R1jKkHFCGf/CCz3mlSsTbPiqWmqF2MZQ9aE
X-Gm-Message-State: AOJu0YxpP3yylr/D7QGIMMr2JP4YGOEiP7B0cmhtEKgvSaw6xmV4JM/7
	9sAN98MIpLhD+EHTKAyeQ7utmXnVsDMjNuTng++Il4Yn5u2/VAStel/LkAhvQyoN/LGA0tRyGfC
	bbfHYrRnEcP/Y+IIYqAe872rU278=
X-Google-Smtp-Source: AGHT+IEXEhS4il9O4HiQcLX8Nw3RGKpo9YAEEBnYEsfJ5+/jEDb9u8VDy2aksWJ26btRZCRGD/H07koWeT/HmOl/hzg=
X-Received: by 2002:a05:690c:4589:b0:66a:b6d2:c184 with SMTP id
 00721157ae682-66ab6d2c901mr60003197b3.16.1721601914698; Sun, 21 Jul 2024
 15:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720062233.2319723-2-martin.lau@linux.dev> <202407202244.HvnUVyjM-lkp@intel.com>
In-Reply-To: <202407202244.HvnUVyjM-lkp@intel.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 21 Jul 2024 15:45:04 -0700
Message-ID: <CAMB2axM565hLp1uuYggcEEPDA8y0NCpTn8gESmn6cPuyWfELJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Check unsupported ops from the
 bpf_struct_ops's cfi_stubs
To: kernel test robot <lkp@intel.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 7:45=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Martin,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Martin-KaFai-Lau/b=
pf-Check-unsupported-ops-from-the-bpf_struct_ops-s-cfi_stubs/20240720-14431=
3
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20240720062233.2319723-2-martin.=
lau%40linux.dev
> patch subject: [PATCH bpf-next 1/3] bpf: Check unsupported ops from the b=
pf_struct_ops's cfi_stubs
> config: i386-randconfig-001-20240720 (https://download.01.org/0day-ci/arc=
hive/20240720/202407202244.HvnUVyjM-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240720/202407202244.HvnUVyjM-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407202244.HvnUVyjM-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    kernel/bpf/bpf_struct_ops.c: In function 'bpf_struct_ops_supported':
> >> kernel/bpf/bpf_struct_ops.c:1045:48: warning: dereferencing 'void *' p=
ointer
>      void *func_ptr =3D *(void **)(&st_ops->cfi_stubs[moff]);
>                                                    ^
>
>
> vim +1045 kernel/bpf/bpf_struct_ops.c
>
>   1042
>   1043  int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops,=
 u32 moff)
>   1044  {
> > 1045          void *func_ptr =3D *(void **)(&st_ops->cfi_stubs[moff]);

The compiler warning can be fixed with:
void *func_ptr =3D *(void **)(st_ops->cfi_stubs + moff);

The patch looks good to me. I tested it with bpf qdisc, and it does
what it is supposed to do by prohibiting users to attach to an
operator whose cfi stub is not defined.

Thanks,
Amery


>   1046
>   1047          return func_ptr ? 0 : -ENOTSUPP;
>   1048  }
>   1049
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

