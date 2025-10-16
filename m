Return-Path: <bpf+bounces-71137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92291BE5123
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE1F5835D2
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C71233711;
	Thu, 16 Oct 2025 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqdExyoU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30F41E1C22
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639822; cv=none; b=OV9k20vxNuHdhYWnJnvXqlRcBYOWdw+dAUlWosD91IXCYUlQzgpUJpTj7kBOvG9pLI80RVD8uUAdhv3F5b5i3J0q/ADne11kcHWp0l3DNMkkrq+6822vqnhBd8WTdjc1z9X4f/16Uxp0oVJdRgP4yMQb3VxHPjwg6lV6bzkFUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639822; c=relaxed/simple;
	bh=Ua8YStP+e76Hibcfmx2dMSJ6dPCFsDTNa4AZ+fSahMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAQgsP+a2YUsbmDt8oGTpdMNDX43D4fmdmnZfaIUXcevEGHX/IrMQxE0W5Sxv8Y698iiTCu71EbQkxAObbnpYYZWkLcA/snYOx5Z1IumNw5Jq6Iw7IuEonseON5X+aP6JrlTukA7exzn5lccvtaoBilmt75CUriSAOmysAW+qe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqdExyoU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-269af38418aso10692905ad.1
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760639820; x=1761244620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJgaIBKzeWNMIqGONScFFlmDlMvFO1/ccN7WcTh0/cU=;
        b=hqdExyoUo/4352ERsqEPDVp6/GQ4OmMCm8n1ovS8seSnEDUPIlAM03iGNrFu9oIlyX
         FnatKALJnLyfRpDQT5NNOZ3VexTb/gF11yIWj7FPuq1pn3qdJvNL+iilvgQsP6Du09d9
         uqMNZ8yGOe7+UFnPKz0N8R7A+GZxYGse1Tvh3AZryVQwDI9NfyVu/aCpIQxOtkoXivI8
         2HVYI1VuAgVI4uO/K+InzKzLzQYrhuwNKvFs9CUfdxLqGtvZJKGuUUgtqN6IaNerLwgR
         w9Td0dASAn54d/lJuoSNWAHAGbOcEgn13HfT+5HaE16H5B2bIEaKNBryU0FGNlMiQOAV
         22/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639820; x=1761244620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJgaIBKzeWNMIqGONScFFlmDlMvFO1/ccN7WcTh0/cU=;
        b=VkSAuXOuBnMknHQLUi1fcndP4Vf4x6GXIwHDzu5R8gRETGJvYrtpJiwb1MHOmgMbPS
         E1S4kQaMGPGuIZaz0CtBKa9Ia65sB15Yfhv4iIMVp5S2PUXAc+wJM7kTq65vHaDjMOoz
         KTQvtg12YC2LVfAt+oj8zwXL4cZDZaQ/RhXvlWw9mA/Tlw40GFlorx0b6+GwxVoJbjGv
         VHXJj9sr1KtJgn4yVsBh0N1g1o5Z4oNyfQcd2ci+nJcxzCNwmtNG7iFvKvLZwPjaf6/V
         JapYKCCH6KrAgEC5nnc0PPCi5H809C5pOwrmVI+CcYu8UJj91tI9KxIZA+J8nnpqVHv/
         LnBA==
X-Forwarded-Encrypted: i=1; AJvYcCW6pRr4t1b72Z/0VxRPSlINnTwhdVer93JWf2pEieLMNyNOmY0fxvX6iTUqdKwOlJ9GVy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZ9KDK7tuvLsCORPQnMRpbGfEGbFgfclo3bZZsc/X47TCABr3
	nV+cp59aUo1Y0XxvqcY07pwgtBYhQpP533vfFwAWrGyWIM9g1aJjqW8CpKtMHsnfKJWpJnkDuIg
	GxEzUR0Ecap8ZDfeDbGRojD1jCd8MaFw=
X-Gm-Gg: ASbGncvRSosIkWjxYsHCUC4rhU0O+RhqYCBZWAdg8xCsF+GsZO3EXQETAZ1v6BDve0L
	ozQpBynPczhXFTjXk9rIvTRFOt3R0OkJUKtU5Wvs+o8PZwkjCO/wO79BOkG9T4S8tfJFjPQlvI3
	OYgN5R68LIaT6HTFXVaUiRoUd3bRCWkwWwzNZUHJMq1gfStFemKja/WRKoe9Si35AeeIwqHP7gG
	q90wNxKD596vba6FQ3AERPrxx9wsgoqaCPrVi+k28TGYKTnSMscj6mpreycY6+O7+SHU6dE3jjv
	E0a9zWSqWeQ=
X-Google-Smtp-Source: AGHT+IGNuZlgURJ5gQDt7wjFmvAX491omv2ZlCLSB5INXuwAIb1aa9hIhVpjCDD3BjLa4/y5w3EvTjEsc59rF+jf2UU=
X-Received: by 2002:a17:903:1746:b0:24e:95bb:88b1 with SMTP id
 d9443c01a7336-290caf8510cmr10300375ad.34.1760639820126; Thu, 16 Oct 2025
 11:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com> <20251008173512.731801-7-alan.maguire@oracle.com>
In-Reply-To: <20251008173512.731801-7-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 11:36:40 -0700
X-Gm-Features: AS18NWA0HnbU6g6K8rt12U2jnKqMitjYvBl-k8EGjMphVS4pd7bn0KZq8k1GhFo
Message-ID: <CAEf4BzYMsLc+BHHEOg7iXj_DqCMoj1WR_gBk_8MYUdd1+WnpKQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 06/15] bpftool: Handle multi-split BTF by
 supporting multiple base BTFs
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 10:35=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> For bpftool to be able to dump .BTF.extra data in /sys/kernel/btf_extra
> for modules, it needs to support multi-split BTF because the
> parent-child relationship of BTF extra data for modules is
>
> vmlinux BTF data
>         module BTF data
>                 module BTF extra data
>
> So for example to dump BTF extra info for xfs we would run
>
> $ bpftool btf dump -B /sys/kernel/btf/vmlinux -B /sys/kernel/btf/xfs file=
 /sys/kernel/btf_extra/xfs
>
> Multiple bases are specified with the vmlinux base BTF first (parent)
> followed by the xfs BTF (child), and finally the XFS BTF extra.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/bpftool/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

we'll need to update documentation to mention that order of -B matters
and how it is treated


> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index a829a6a49037..aa16560b4157 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -514,7 +514,8 @@ int main(int argc, char **argv)
>                         verifier_logs =3D true;
>                         break;
>                 case 'B':
> -                       base_btf =3D btf__parse(optarg, NULL);
> +                       /* handle multi-split BTF */
> +                       base_btf =3D btf__parse_split(optarg, base_btf);
>                         if (!base_btf) {
>                                 p_err("failed to parse base BTF at '%s': =
%d\n",
>                                       optarg, -errno);
> --
> 2.39.3
>

