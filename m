Return-Path: <bpf+bounces-65584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED80B256F7
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 00:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 737087BA6A3
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75218311C3D;
	Wed, 13 Aug 2025 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQBf8BXy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D14530E833;
	Wed, 13 Aug 2025 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125396; cv=none; b=Jf72ORFRRaFky1Bi1eOMtkKf24wcs9lOzaVeK7RqqVQpdQg5JBVrmVGPDmh/+E08ZSVISvAQ0N0+suUc38HJNVZ3G1561mxs7X9rCoux3IYz3k2HkMYIG6B8RQgLnxjaTj0SSYcbN5YxfhTJcy3MpFIAvHaCZztsS+s4YhVKovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125396; c=relaxed/simple;
	bh=5IRevcqb+jm2XqmZEVUOyBf2dJpN2L5kyJyS8TjpOaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JGrAAwKziq90DX3wIP4sauaDHAPY3vKBMF+Yi+Lx/1mX70dCpWHL42dk57Xz69+Y7st3MDV+YT75l2yQXL80FGFYrDfhJHReG1uUh9IzwFDuYxctQutiDtusD+PV/gcypjRzIG+KOoXSwbFJOM6Nll3/oxxkHE6ARUf2qK46H1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQBf8BXy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2eb49b83so244838b3a.3;
        Wed, 13 Aug 2025 15:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755125394; x=1755730194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RUKwh6OXwqKnS1xV/OCLPWmpbTtVI8digmBtof10qk=;
        b=jQBf8BXy9l2Ps/o35EAlhpGBpd9szqaCcxLWBB/OpZcQBBI+cP6Cj6xDhqz8p3Dc6T
         sCl+etbyKre0Q5SIdXqWd630l4rBWtIry8mHrmcwu6RDM9BIgfc5cpuIErT3BqU18Ww2
         pdLq9w/sIJUMNzcDvx9DqMJrWhzttLb+0kvy5gwj3aJZ0cdWRbyZ7bzE0tcdLPFK+KDk
         3k/GKYR6OVpElhXKSCxZJNIvXv22QNDJuBvmk55+ffYqtTkQyQZOoJv7LqIWDrgWAiJm
         8pdb5+rE3YelbTfp18Op1n21RWyJXX497gsVePuWzLS9cdMP2dvtfiThM4VQ2pQ9Rwld
         05eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125394; x=1755730194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RUKwh6OXwqKnS1xV/OCLPWmpbTtVI8digmBtof10qk=;
        b=skIQOnsGpiLl2M1HTJP9ClKUQutuy53HUsUT9FaHYaxVVKEIxF72A6AnaYlbJ7mCuL
         6qEvTFXpUUh801I2sjKsmM9Rje5SV01ysjog7VmVhNxeBhFEc7B3hx1hQnP4/MJNeeZ+
         /bA5cwbhdaD8+is62HEBf0pDhHUW2dg2KAtSZ3+c80uXppQMDZPpYYqSedXIgddLyX+G
         z/qDYsTswCJGbQ+BlxDE6JM2R5S9V5WPPfSRLImedff3MBfm7LSRrl8jMk9bDdX5imUK
         NSmYmBfZwxbb8c3OEyxHs2RG7/OEN0BW8sfKZv40qRniz5jGuSuKHLEc1GncbIyCetNx
         k68Q==
X-Forwarded-Encrypted: i=1; AJvYcCVo9JvKDfZLeNJX7b4CPVZ/oWDKcsKSUWCd+6iiN0VTIqluu1mp+bafuP6rbmUMaiuPwzlM5GQ330LnjRnj@vger.kernel.org, AJvYcCXtQz7vwoIbrj9DjUlviugDMCckvw4Wc6mCwAKVE1BkenrKAiiNrA/HkGcUInjCUMzTNYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPdouzi6JB5FJgfULKqxbX12GYwzsMl097TDSie362hMQ8GSg
	An4CxsG+5XC3wowayrPSihJKHeMAVhMH+NEcLbg+n8Mn5Qh8w3if8qP/gQCSU5Iz6r7SQTqoOKh
	a1uM3ZTG0TfSYaZU812s1LjK09Afe8tGIXbxN
X-Gm-Gg: ASbGncuAGzHeE2GX8/pBS/LxWbwchf1wp8hMrxedax30IzMqI6sqwkPB0k3WPe/BkNY
	ejABmzjTwRSrr0s+glu/5xPaGW2mOJleT95zw6vRw1iQF9+/X27AMcCr/YF35SPLCdVoGsgl5wH
	VGTj8Gif5ha8cX/xVDLCt2b43iaLtB8nguTfAPRxpVNmDYAvdhCmapkrKoLD+nIPFY6gRNP+yXp
	BvRGywdsOHyWLs/qNEsDMhK7gzdMy6/Uw==
X-Google-Smtp-Source: AGHT+IHVGTCyOG2gBPnGX+e1Psv6H7tAAIWyPZVUPFiu0KiK9i+AFx4HEc1N+nroIdiO3ju8MU6+zdqoJyXSuLk2dJ0=
X-Received: by 2002:a17:903:244e:b0:240:934f:27ac with SMTP id
 d9443c01a7336-2445868e726mr11087275ad.33.1755125393683; Wed, 13 Aug 2025
 15:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813200912.3523279-1-yuka@yuka.dev> <20250813200912.3523279-2-yuka@yuka.dev>
In-Reply-To: <20250813200912.3523279-2-yuka@yuka.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Aug 2025 15:49:39 -0700
X-Gm-Features: Ac12FXwwZuXTqkg_1s1VJsOHqdFQSHcKDpdsgO3MNXSQXopNcD2lt06Fn77MYQ0
Message-ID: <CAEf4Bzbw_02vrhUa+JEmuqo3snuf5xjNVL1wOu0BT1Z_MZ5S0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: fix reuse of DEVMAP
To: Yureka Lilian <yuka@yuka.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:09=E2=80=AFPM Yureka Lilian <yuka@yuka.dev> wrote=
:
>
> Previously, re-using pinned DEVMAP maps would always fail, because
> get_map_info on a DEVMAP always returns flags with BPF_F_RDONLY_PROG set,
> but BPF_F_RDONLY_PROG being set on a map during creation is invalid.
>
> Thus, ignore the BPF_F_RDONLY_PROG flag on both sides when checking for
> compatibility with an existing DEVMAP.
>
> Ignoring it on both sides ensures that it continues to work on older
> kernels which don't set BPF_F_RDONLY_PROG on get_map_info.
>
> The same problem is handled in a third-party ebpf library:
> - https://github.com/cilium/ebpf/issues/925
> - https://github.com/cilium/ebpf/pull/930
>
> Fixes: 0cdbb4b09a06 ("devmap: Allow map lookups from eBPF")
> Signed-off-by: Yureka Lilian <yuka@yuka.dev>
> ---
>  tools/lib/bpf/libbpf.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index d41ee26b9..049b0c400 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5076,6 +5076,7 @@ static bool map_is_reuse_compat(const struct bpf_ma=
p *map, int map_fd)
>  {
>         struct bpf_map_info map_info;
>         __u32 map_info_len =3D sizeof(map_info);
> +       __u32 map_flags_for_check =3D map->def.map_flags;
>         int err;
>
>         memset(&map_info, 0, map_info_len);
> @@ -5088,11 +5089,22 @@ static bool map_is_reuse_compat(const struct bpf_=
map *map, int map_fd)
>                 return false;
>         }
>
> +       /* get_map_info on a DEVMAP will always return flags with
> +        * BPF_F_RDONLY_PROG set, but it will never be set on a map
> +        * being created.
> +        * Thus, ignore the BPF_F_RDONLY_PROG flag on both sides when
> +        * checking for compatibility with an existing DEVMAP.
> +        */
> +       if (map->def.type =3D=3D BPF_MAP_TYPE_DEVMAP || map->def.type =3D=
=3D BPF_MAP_TYPE_DEVMAP_HASH) {
> +               map_info.map_flags |=3D BPF_F_RDONLY_PROG;
> +               map_flags_for_check |=3D BPF_F_RDONLY_PROG;
> +       }

can we instead clear BPF_F_RDONLY_PROG in map_info.map_flags? and then
keep using map->def.map_flags directly

pw-bot: cr


> +
>         return (map_info.type =3D=3D map->def.type &&
>                 map_info.key_size =3D=3D map->def.key_size &&
>                 map_info.value_size =3D=3D map->def.value_size &&
>                 map_info.max_entries =3D=3D map->def.max_entries &&
> -               map_info.map_flags =3D=3D map->def.map_flags &&
> +               map_info.map_flags =3D=3D map_flags_for_check &&
>                 map_info.map_extra =3D=3D map->map_extra);
>  }
>
> --
> 2.50.1
>

