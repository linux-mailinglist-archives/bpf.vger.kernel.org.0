Return-Path: <bpf+bounces-71990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E2DC0496C
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 08:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081DA3A8CD0
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 06:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D30277C98;
	Fri, 24 Oct 2025 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxXrZGDW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7033985
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289038; cv=none; b=T4avPFvyEjCrSMQ3/X7Aj7Pp11Ddzrp8itjK7RGphZdr9xSJ03L00X2oM5BWCTEALRzI33+6VEXXW2p5+3nkh9Ab074JYaxywRXRiGfc+tKgn+RR7RUXQrNXXUUPvo8h1R4uGaK8baLMPtUluUQ5G9eoipfdf0umpq/KMMPvfMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289038; c=relaxed/simple;
	bh=l27XdHQbBM+7OkmY+JBO6NcVOae8OD6osrJX9LZz7Ig=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZJShTcPpPqqKYSg0FjEAta7y5Aap2HqA5IFllzOweOTp2e04TlP804wTx2Wbpwrur98xVppFs1Ntel/+CnQF8hxViCTToJ4w1D3Sl+J0LFTYuqJiksHBCx8Kumpz8MRYH7+7YGXawrLaIWw054SBEAm5/yO3TZeBbdS9Uv4NnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxXrZGDW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso1099851f8f.0
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 23:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761289035; x=1761893835; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ORMJ7BlrHXqNeSTsxJ4qy2dmyq6fW2e6Eo8f/etUvO4=;
        b=WxXrZGDW5ptcP3JI4+bdKvuYLMOOm0sKsV1617oZDPOq4otBUlkyOTMC1SMetgZK98
         4AIZsDC47DLX3IVnsqNRQtZtPICgv9RRfkw71kqUlVq2QHfgjtGyDBLoioX9Rdh9GLSg
         xe67v2HFx9WPb8qYtqFCw9B24Av6fEql2o3K87mrRAPCij7t7+MmFLa2uO4PcOOrUiFy
         5dKpEjL3qVbDFB30skXXrXww6lN7VmvNd3ceagRQh11WJUlHdbGn5+kvq0VlkpGl0Iat
         1+tDvQyZTKnpJVCSNm6L2hMEdUUuDpTWN56mV35mPNWTI9uFsGtwIJpggWglaeg3U7fW
         uEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761289035; x=1761893835;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORMJ7BlrHXqNeSTsxJ4qy2dmyq6fW2e6Eo8f/etUvO4=;
        b=vFouGG0a825RldPVefL5w8wfZBWsQ2zNTDtlj/54TdLO4ucfvG/3EbyLiHevBkHygZ
         2Cw/dgXj9OescgfHJDTUN4cDy+/jAI5E/TthRtbF9/UinZKrBMU4cRP4L7BphE0tgUDT
         2ikV3HveBRrn86Qc4NHNyha+eT/Izyys5UpYbv9VGw/qB/tw/08y7Sqa1wfHT59qVQj+
         3oY2jwp58uvo0tFopdnsQkf/62P1G31DqKOa84J4k7RdpdWq/WvcvDF1vi9ECCRZOgh3
         7dVkpclk5cS23HmkIJHV2hpIiqMm4m07mQGenfZhJxkKqFOA3F6/2yR5piEOHmLC81A3
         L/1w==
X-Forwarded-Encrypted: i=1; AJvYcCWxYFREeJ8ROnWtM19mlS+Y1yQbvjJDmOzpbg5Hel7M7DFxEnM/feVtnM6AICEAyYdBEHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZa9NS23U5J7GjERAs0fBeaGZgV1O4vcvo/3a99qVMFIPwFPBe
	ikWGm+n900EQeIFd4lBuziCCDy3iQVHwTl0m+5u8PahhrT7xYY2Ng5gb
X-Gm-Gg: ASbGncuKOMVMwiQ35ASAoslTReb3ascgvW4qjaRiq3G1/EKYP/OdSTjqz/f8YrjPQae
	+3SrHZR8BhxFObTDpNC813nxfYHg1P89jvJSS6+K/2nGvurLhrHOo4ysCI8ivoQiUqEzoiT70NT
	DUKVXR5zJMxtgeaQn3un98Fwyyf/lWTWjtqYrWTvC7T9NAF8cwF9ejIe7+KrvQ5Kvv4OVZ4q8ux
	g++iM6GwIpYrCzk5UquKExv2tiWl1I5AprGk4tePX86aYWYOl1aLXFbyU+NtSTPoEflo36PtSQT
	G7g/uMRhI4UWhzfdabyjoY2LTJbzaQ4Fcy3EvEp+iFVCda6lLPuywLgCEQaJqv/g3AqNhcBuFZW
	iEaxDNCdxuuH5l5fGbbxJzVKvCvJMJ16RPpfn7RPBnOLQ0e0Ufg==
X-Google-Smtp-Source: AGHT+IHpUTilMgnX8ETVEknhaI2lHNfs+gF9oo5RMnpwrwZ3GZ6FYDuD6jwow1gnOGUua1J45MTuTA==
X-Received: by 2002:a05:6000:40db:b0:427:2e8:fe48 with SMTP id ffacd0b85a97d-4298a040682mr3178731f8f.4.1761289035317;
        Thu, 23 Oct 2025 23:57:15 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898eac60sm7545816f8f.39.2025.10.23.23.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 23:57:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 24 Oct 2025 08:57:13 +0200
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Subject: Re: [PATCH] libbpf: optimize the redundant code in the
 bpf_object__init_user_btf_maps() function.
Message-ID: <aPsjSZtNxeQK239J@krava>
References: <20251024060720.634826-1-jianyungao89@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024060720.634826-1-jianyungao89@gmail.com>

On Fri, Oct 24, 2025 at 02:07:20PM +0800, Jianyun Gao wrote:
> In the elf_sec_data() function, the input parameter 'scn' will be
> evaluated. If it is NULL, then it will directly return NULL. Therefore,
> the return value of the elf_sec_data() function already takes into
> account the case where the input parameter scn is NULL. Therefore,
> subsequently, the code only needs to check whether the return value of
> the elf_sec_data() function is NULL.
> 
> Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b90574f39d1c..9e66104a61eb 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2988,15 +2988,15 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
>  	int nr_types, i, vlen, err;
>  	const struct btf_type *t;
>  	const char *name;
> -	Elf_Data *data;
> +	Elf_Data *scn_data;

makes sense to me, but this rename breaks compilation later on

libbpf.c:3027:53: error: ‘data’ undeclared (first use in this function)

jirka

>  	Elf_Scn *scn;
>  
>  	if (obj->efile.btf_maps_shndx < 0)
>  		return 0;
>  
>  	scn = elf_sec_by_idx(obj, obj->efile.btf_maps_shndx);
> -	data = elf_sec_data(obj, scn);
> -	if (!scn || !data) {
> +	scn_data = elf_sec_data(obj, scn);
> +	if (!scn_data) {
>  		pr_warn("elf: failed to get %s map definitions for %s\n",
>  			MAPS_ELF_SEC, obj->path);
>  		return -EINVAL;
> -- 
> 2.34.1
> 

