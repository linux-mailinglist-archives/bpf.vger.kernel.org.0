Return-Path: <bpf+bounces-56459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C3A97AAB
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 00:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC8516AA79
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 22:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ACF2C2574;
	Tue, 22 Apr 2025 22:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrfShaRT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AD68634F;
	Tue, 22 Apr 2025 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362195; cv=none; b=HFwf3iNQxnOvTmoyxAsFNeUnKUxJdEbAthUktDIXf7L9dv2MuDK6oFloJJHvSq0KcjYEq/lBGNTrAIfESoYc5x30h3+niPTTnk5mn3pAeksP0JH0Ojt+tbira5V7f+U6XFovvvmRcg5TZH+8dW7kpvCDh+2md6ebcicLGyT4lDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362195; c=relaxed/simple;
	bh=NQVpfJugMzR1LkjV5816vnGHeZ7+wpVEURecExKe/tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys+CH+3Y97AEcqd4K+tro1yWrlZ72YfElRs+EtItC21UmuyhJMM5DkTQezmM4QY3WrYXEDIWciEXO4XkgpbBfK9R1OsaR9n3/f2OIb+1L1bTWMgSqbr7GU2pnCrLQ+yTEGNvDySEMmi+kvQort4lunLmXji0+/YfKOoz3KbvqPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrfShaRT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22423adf751so59022235ad.2;
        Tue, 22 Apr 2025 15:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745362193; x=1745966993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3cn4adHcJd/kIJjKobK35R0hnccjB466Q4g0zrjHPU=;
        b=XrfShaRTyKsY7M/ALrzHSlgB3q61ceudMPbOcDueO+HAyVbkkEKOI86Nb3u3AVy/Fx
         cu04Ke2NCN0hw0WD2RZIarcJhixs4TvAfZh1sfCG42eL+inOHawHgiQOBtwjN01FLf8V
         esuvyYO3pNd5Ri4Mh8dco45K5DZ2dULvfzdrCIb+flBo1Eg2JC2ugJ905oCAeZTVLuXx
         GjdFxNqklnm1E7m+LJp48iIU2Ny1EQ1bRFEXx1g/jBoJrRkmDUFiAlq6dHOf9S+43NGa
         xRXUGEPS4Qzhjmrom8URCaTef6IalPCb3O597VHWH2Lbujc9TVqSSjBM+uDpztTicjfW
         xdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745362193; x=1745966993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3cn4adHcJd/kIJjKobK35R0hnccjB466Q4g0zrjHPU=;
        b=WxbS8E3/EZzJ4rJI5tPHMpsR4xalvCI1dlZeHirpsGE2g3wBIu5p9XY3/vWtReANeo
         fpWo+8z9bgo4LecXn+kp2M9/vHg871P34ioPLh0kjrWWFHrhBcyhyjAlVFPyVtbTWCkx
         bLGIN1L3HvwO6kilfHJkvE1b2BXgATWcMnGWUVbzTYShmc6yrTjyKAOpLHAtBazAc9DB
         NMSq86/ctwythk8OYMq2mfK1haG8vkjgbl10ZEuDsjdNwa4vTo4RlKpzqmm2kc7iXKYr
         bmp3dZ0b17grw2dMcBglWEHkP0KZsw0J8QNgut3Ezz/z+/mIqAEAPeGL8jP2ldYscwE2
         B/BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBblF+AC6FgN3iP5IYYeVmFTLrc8YfIYE8pmE2uetN9SoRFhYSZjDkZokOScZEn+iAePE=@vger.kernel.org, AJvYcCWmcAixrMY4KjxPE6h1vWI5XRwTss2dPks21kyQG8MaatvMXYnMIAIHKlEMoBmaTh9oVsxzPGai@vger.kernel.org
X-Gm-Message-State: AOJu0YyImjFDNHpqy4zQBMOGuCPBxaPL4YqjGjexVquxIs/iIuSH0Bg4
	Jcx1mW8T3B46Crgo54tI11UCnGjxdsjtWJnoOVuGj78HWyi8iNI=
X-Gm-Gg: ASbGncsE9lTXe7XAL3db1ciWU9p3nfjqMQwgssjc62GuApINypaPNv9emJ8pTjwoKQv
	59Ms7E4g4ghjqg+XKEc1Gf98MeTlyUwXcRRwlIkLychTXT9ec4dfo8/Lc4tVEYNXZ4+4UTJVT/2
	9ISjZoG7P0mWBda5FC/eU9PWy0SloQSCHEDTCI3P5ZZ/qB06CJmIpkAOos7zkDnTb7iQeXNVGnZ
	M6XxQqAcsgJ51Wfst2/mu+DSQQIcPGxp1p1O6rqe+vgE6/lbV54qbn+CyvTWPwtR8k5pmSM2m8H
	jCMmZRyDg7mKLbYjPLtiOe7VOUFsqf63yNWOAAOF
X-Google-Smtp-Source: AGHT+IHYoc/VT/NIfCpQwnBCvJZle7AKqAnjl81ibsZtG7n4j4FPahCW7IyewqqOGI7XgO2KUItEhw==
X-Received: by 2002:a17:903:1aa6:b0:224:2201:84da with SMTP id d9443c01a7336-22c5356de05mr220609175ad.6.1745362193412;
        Tue, 22 Apr 2025 15:49:53 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbf8beaf2sm9146857b3a.5.2025.04.22.15.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:49:52 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:49:52 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Allow XDP dev bounded program to perform
 XDP_REDIRECT into maps
Message-ID: <aAgdECkTiP-po7HP@mini-arch>
References: <20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org>

On 04/22, Lorenzo Bianconi wrote:
> In the current implementation if the program is bounded to a specific
> device, it will not be possible to perform XDP_REDIRECT into a DEVMAP
> or CPUMAP even if the program is not attached to the map entry. This
> seems in contrast with the explanation available in
> bpf_prog_map_compatible routine. Fix the issue taking into account
> even the attach program type and allow XDP dev bounded program to
> perform XDP_REDIRECT into maps if the attach type is not BPF_XDP_DEVMAP
> or BPF_XDP_CPUMAP.
> 
> Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  kernel/bpf/core.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ba6b6118cf504041278d05417c4212d57be6fca0..a33175efffc377edbfe281397017eb467bfbcce9 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2358,6 +2358,26 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
>  	return 0;
>  }
>  
> +static bool bpf_prog_dev_bound_map_compatible(struct bpf_map *map,
> +					      const struct bpf_prog *prog)
> +{
> +	if (!bpf_prog_is_dev_bound(prog->aux))
> +		return true;
> +
> +	if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY)
> +		return false;

[..]

> +	if (map->map_type == BPF_MAP_TYPE_DEVMAP &&
> +	    prog->expected_attach_type != BPF_XDP_DEVMAP)
> +		return true;
> +
> +	if (map->map_type == BPF_MAP_TYPE_CPUMAP &&
> +	    prog->expected_attach_type != BPF_XDP_CPUMAP)
> +		return true;

Not sure I understand, what does it mean exactly? That it's ok to add
a dev-bound program to the dev/cpumap if the program itself is gonna
be attached only to the real device? Can you expand more on the specific
use-case?

The existing check makes sure that the dev-bound programs run only in the
contexts that have hw descriptors. devmap and cpumap don't satisfy
this constraint afaiu.

