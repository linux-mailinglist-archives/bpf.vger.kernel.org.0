Return-Path: <bpf+bounces-37307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB2E953C93
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4EA286523
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C15514F117;
	Thu, 15 Aug 2024 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsupeYqw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18FD14D702
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757136; cv=none; b=IucvuEK8Hd6rIzGPEFJry8wlSTXred+89LbacCbk9FzYBxxyqD4emn/3KRqJH38YNxIv/JMmv1ZSsHe0HYEP0dts5yw/nkvshlgCneh4KnoWDN4kZ2SXQ0OdYfC2kSjxCmC3bWW6lr6O0Q4lT8AM8sUGNSpqHNmRNlUeDjoH4ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757136; c=relaxed/simple;
	bh=I8LkLYHOlEgS2CDC5TVHHLhPzK03hibfYucZuKywQjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pesnMX+jeNbT5U78FeOa/0QjSRo/JsMo8lIOcgF8wtsyf53XwQV6+LZgFVsyuHmm4LzCfhogF7xX9Ik2NlekftXP0kkDapDyovsq1QLhJIyJ196KR4958noOGHuB1C+cwTPwPCBTGaZzaMv9ifjavpD2eHkHEHsKSUoMky7XI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsupeYqw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc692abba4so11742725ad.2
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 14:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723757134; x=1724361934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2f1cGhczNOX+mqQgzr/9O4MKDayAKTaWFSwSVp6fI2I=;
        b=VsupeYqwB1OZxgnWY6B+PX/NGBQMJY2Ik0zoaqOP2Uu9GVQCuLDkzRKInIO1OdSNUx
         pG4vq+QjDNbM7b/dWCU1rLIsbQBowf2cwbAhO/hppvOvQ4ruxQDDBCBLSo33HQSfPhMl
         oGIcXXg0GU4OhvHDVccJLDsTkFp71vNTIEbHVQZkUFNKGDl0B+WqEjIbzEsPHlXQ3hBl
         GO5qax4C5zThWSM4iJYns12R5ynb2YUy4wvaesZ9Vcg4BE+afEPhV2Qev5U+aedtIrWz
         9hGOb5po5x1O1PAHELThCT76Zyemxuva+rV7/+7Zf1e9COO6uaQtwcSADXl+XLr23/Ro
         3M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723757134; x=1724361934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2f1cGhczNOX+mqQgzr/9O4MKDayAKTaWFSwSVp6fI2I=;
        b=wJlXqE9OegqWaPW5FimMMC2nmubCnLl1JCUP5DxMykzTNLchUGGf+TE/sfuMGrxd/q
         YbJxnZ3aigNWlaqyLHY7mEdR8d/CugcpXDjVac23p0Wyr07oGDQEpFeryvCOLCgH+oEL
         yCiHfChErx0xARFSNzZeWTquGefhHAo6EVQ+Y5FJB1CfzUR5YI04xBk5wgX+QjAEIb/g
         71bqLZFNnxvFh3UHiQZdl5/mo4Pk012Yz5h2xbsnxDQx7+1c7/8ALNrkmwX7pGhtwAJh
         ZNx+3ELKHey9q0UqumTLBlMZOPtBle3WPBWSAnllyJgoxaTqA95sZxYal9Hu/u+Zlwul
         BN0Q==
X-Gm-Message-State: AOJu0YxQ80++HH2odH6M/7k9FSuxdK3TzxZA7V25amNw07u8kqzRbXl5
	OKCmg6yz/8Z/3Ysl4ybPc9sfng8SiVHukorFaJG6hGm08nSIDdm2dG8z1H0nMUCc8Am6hJxg06J
	JcffWjyhH8PtbGTxsjgUGEk2C+E8=
X-Google-Smtp-Source: AGHT+IE9wR4y+THmMT+ASwzstDV6V+7hXMYpf8IExnFiODzntS9yeUiZvSQsvhxD1nautj1FwSOPAUQqU0btm1EHA0Q=
X-Received: by 2002:a17:90a:1307:b0:2bf:8824:c043 with SMTP id
 98e67ed59e1d1-2d3dfc66d3cmr1158736a91.18.1723757133857; Thu, 15 Aug 2024
 14:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812234356.2089263-1-eddyz87@gmail.com> <20240812234356.2089263-3-eddyz87@gmail.com>
In-Reply-To: <20240812234356.2089263-3-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 14:25:21 -0700
Message-ID: <CAEf4BzZDvYEB-qF75vpMbbYLN9rFiTegBsxBXvMxq-UsbANRaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: mark bpf_cast_to_kern_ctx and
 bpf_rdonly_cast as KF_NOCSR
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 4:44=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> do_misc_fixups() relaces bpf_cast_to_kern_ctx() and bpf_rdonly_cast()
> by a single instruction "r0 =3D r1". This clearly follows nocsr contract.
> Mark these two functions as KF_NOCSR, in order to use them in
> selftests checking KF_NOCSR behaviour for kfuncs.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/helpers.c  | 4 ++--
>  kernel/bpf/verifier.c | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)

Isn't it now "bpf fastcall" and not "nocsr"? Shouldn't the flag and
verifier code reflect this updated terminology?

>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index d02ae323996b..cda3c326eeb1 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2987,8 +2987,8 @@ BTF_ID(func, bpf_cgroup_release_dtor)
>  #endif
>
>  BTF_KFUNCS_START(common_btf_ids)
> -BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx)
> -BTF_ID_FLAGS(func, bpf_rdonly_cast)
> +BTF_ID_FLAGS(func, bpf_cast_to_kern_ctx, KF_NOCSR)
> +BTF_ID_FLAGS(func, bpf_rdonly_cast, KF_NOCSR)
>  BTF_ID_FLAGS(func, bpf_rcu_read_lock)
>  BTF_ID_FLAGS(func, bpf_rcu_read_unlock)
>  BTF_ID_FLAGS(func, bpf_dynptr_slice, KF_RET_NULL)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c579f74be3f9..88e583a37296 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16159,7 +16159,8 @@ static u32 kfunc_nocsr_clobber_mask(struct bpf_kf=
unc_call_arg_meta *meta)
>  /* Same as verifier_inlines_helper_call() but for kfuncs, see comment ab=
ove */
>  static bool verifier_inlines_kfunc_call(struct bpf_kfunc_call_arg_meta *=
meta)
>  {
> -       return false;
> +       return meta->func_id =3D=3D special_kfunc_list[KF_bpf_cast_to_ker=
n_ctx] ||
> +              meta->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_cast=
];
>  }
>
>  /* GCC and LLVM define a no_caller_saved_registers function attribute.
> --
> 2.45.2
>

