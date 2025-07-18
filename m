Return-Path: <bpf+bounces-63741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7DFB0A810
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 17:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD7116FFA1
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 15:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B93D2E06ED;
	Fri, 18 Jul 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLhtIPdR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3D29B8C2
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752854297; cv=none; b=r/lv4GA7x9PF34GnR4R6mVPAtAzaGsnkuvkaA3kQsB4DHbsJVCa4ToUzyiz3L/7TN+XZFFBLHDQPJNlGHD3GNO/TBkc7+ke9bPie/FuiGAIenClxlQ/emBZ6UQWfiEX8QU7gGENuH09CuMXd9er7PmbxLxZlF03MEx47Vd1QJic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752854297; c=relaxed/simple;
	bh=pGievnSHYwDT2zQH6Gy2qXs8cB2Em+ROw2V+aMepeuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCjCTrYJW2bm8CkzuqmojpzYowBcrOZPUyAkpp4uudIUclUpqWUor03Nyw5c/NygMUe4o9jnDye9bcJ/IgBM5AovGXu61d3IcrFGYw+bMmWx+wcNEBXK1aUEjgs2pGd7H1dYNVTCj05WuybiDYhwyBQ0KZ6Wx9jVxweZiwbm0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLhtIPdR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0df6f5758so365143266b.0
        for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752854294; x=1753459094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXXLtwUI72ZnS2eqEfajp2lgoMycOH+HzA8sAylIbGw=;
        b=KLhtIPdRIwU2sT2hy5mr0W+TWW8LC/DER8ZhGr8KDykFpiQB2p+n5GwBQKnNqOSPsP
         8xaqh8gjuz8RQE5ZGzvTo99wnbdzVBrhZkHOAMelENNx/NFQoU/mRSaRoD0j6lBqvfut
         yw1Qb0524sBVGm+q+MLfWM9nbui+ItHkPnb+hv3k4Kh03VE3QNLfzBR6nIkefdp/nT9C
         DWgzKYOokvKvINhwDe+o79jrfG9u7JAPVfRCTjNyWNKmhdhOkhEsGoDMtecViSK0IZda
         fVfdpVKZJtmGQwU2t5fIvPnjX1n5HVZXnSIhZf2Cd14E6X55X0RbttZkbxwja4fiN1/4
         3ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752854294; x=1753459094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXXLtwUI72ZnS2eqEfajp2lgoMycOH+HzA8sAylIbGw=;
        b=UTRmniC+tTm8Nbq36oxV2qqPkDNd/DGz4R1og4KopQUZ+ttkNxgvdL1lSBz8W8j2hE
         EGDG1Wi4JkLl9Oj3NlJm5fMaQulWyTRC5OIE0y8XFjdgl9SF+gE8xHZIWzxMiGuXhsbP
         H5boz9fcjUauS9v2ytRPyO1/RIv85hyHsVwktZRtRvp7ZsQbtddc13ZrUEeZTzsFea37
         rxAd4hSNhEf5lPDZAGP3o6atgP8KV8b4vDn+yKdQMl1r5d1cUv8Sket/EbNP68/oJzeD
         Iqyooe5RQv6WQ9EUrz7vHXncPwkhlqKNkdNNb5Z8cb51K4kiDQK8C7GuFdeBodICf1lk
         JuGQ==
X-Gm-Message-State: AOJu0YyVmnBc7uiygtVk8pQYfQduJiNaE33Em0+TrC1K+1PWw+xDK6D1
	ENFWfR+3IQiKXtCLo/6vUS6I5YDIZMflO2JYELPGVE2+ENeXb+acPDI5MdObprmiV/J/KIr28a8
	HoK5b6n+8O7UHaJb5uN1jrvs03G3eKe8=
X-Gm-Gg: ASbGncvCaqrqQ8xFxw8kF5+9Sb1R3XJC6W+umQzd7+2rMBnHb5Bmt2gYvOutJ32AGHS
	sf6AORsSCTWtyNLHCzlnr+1Jz9TJPJ5kNhkCA/TzOoxbLZ4HjYqSktuNE+bS8B213nwSLSaS3pB
	F7aEGqY50FHVQ88uSwo73Pt4Ken8gdx4kULECSKrU9mu2BdEnuBq6LPdcAfdmLNMYGBCPzsMNcL
	4WYpw==
X-Google-Smtp-Source: AGHT+IGBuWkH1Nr8cohz4CWVmKGiCMcqgsCFtk/EMW2Gzktzcsj7ZVi1rnDDNwviEKEiMEF+u+keNgpl5YlOKtDpRs4=
X-Received: by 2002:a17:907:869f:b0:ae0:6a5a:4cd4 with SMTP id
 a640c23a62f3a-ae9cdda4340mr1044320566b.12.1752854293768; Fri, 18 Jul 2025
 08:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717193756.37153-1-leon.hwang@linux.dev> <20250717193756.37153-3-leon.hwang@linux.dev>
In-Reply-To: <20250717193756.37153-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 18 Jul 2025 08:57:58 -0700
X-Gm-Features: Ac12FXwbyxilVD8xt6TSM4_dP7W19R58NPNxFWtPCqQZ-CW4g5PaUseHOOk5S98
Message-ID: <CAEf4BzYNRwgqbBN3QiPxMbsbtYOoV1Da3mqMhtgE8jPw6eYUXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf, libbpf: Support BPF_F_CPU for
 percpu_array map
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 12:38=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
> This patch adds libbpf support for the BPF_F_CPU flag in percpu_array map=
s,
> introducing the following APIs:
>
> 1. bpf_map_update_elem_opts(): update with struct bpf_map_update_elem_opt=
s
> 2. bpf_map_lookup_elem_opts(): lookup with struct bpf_map_lookup_elem_opt=
s
> 3. bpf_map__update_elem_opts(): high-level wrapper with input validation
> 4. bpf_map__lookup_elem_opts(): high-level wrapper with input validation
>
> Behavior:
>
> * If opts->cpu =3D=3D (u32)~0, the update is applied to all CPUs.
> * Otherwise, it applies only to the specified CPU.
> * Lookup APIs retrieve values from the target CPU when BPF_F_CPU is used.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---

please use "libbpf: " prefix, not "bpf,libbpf:"


Then see my comment on flags vs separate field for cpu passing. If we
go with just using flags, then I'd probably drop all the new libbpf
APIs, because we already have bpf_map_lookup_elem_flags() and
bpf_map_update_elem() (the latter accepts flags), so as far as
low-level API we are good.

The comment describing the new BPF_F_CPU flag is good, so let's add
it, but place it into bpf_map__lookup_elem() description (which, btw,
also accepts flags, so no changes to API itself is necessary). Same
for bpf_map__update_elem().

validate_map_op() logic will stay, but just will extract cpu from flags, ri=
ght?

So overall less API churn, but same possibilities for users (plus we
get better documentation, which is always nice).

>  tools/lib/bpf/bpf.c           | 23 ++++++++++++++
>  tools/lib/bpf/bpf.h           | 36 +++++++++++++++++++++-
>  tools/lib/bpf/libbpf.c        | 56 +++++++++++++++++++++++++++++++----
>  tools/lib/bpf/libbpf.h        | 53 ++++++++++++++++++++++++++++-----
>  tools/lib/bpf/libbpf.map      |  5 ++++
>  tools/lib/bpf/libbpf_common.h | 14 +++++++++
>  6 files changed, 173 insertions(+), 14 deletions(-)
>

[...]

