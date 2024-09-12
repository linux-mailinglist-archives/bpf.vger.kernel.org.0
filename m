Return-Path: <bpf+bounces-39700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8930976383
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 09:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710D628658F
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 07:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0405418E052;
	Thu, 12 Sep 2024 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq7uRh1H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A018890E
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127606; cv=none; b=ix3sFN/4FDMxAMTib85yl/UtNHDw6TfJTDphEjDEB1Lhsy+7dtk0hTJxxXCO57hcdq7EflM1MFnWvh+0k53xd1EyhzSe8292mRo29lA+xFh8jnWf9Pr8eaKvMANeKHX296QRHZGI39zEcNnx0FuoL1u9n8788QDLKZJxfG7YpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127606; c=relaxed/simple;
	bh=Ea5WU9XUon9aZBeGs+y4oZdzot7GZsBtYg8sEB/unQ8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCXGkVrDY63OtswlByXKvBvOgD8J8LPuOCaP8XKRoeJORwTpZ88wa4HIq0oLuwXbDANGmfjft3TDZw7IQJJSAs6e3rWUPuO+hoSzmdb6dVwl5g2N0jt/XZltXEfmUZwUcKFIYeafpzI7HE7TR25e3DR4xX4hnEE0Bm1CZHRki+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lq7uRh1H; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c1120a32so509800f8f.1
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726127603; x=1726732403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=joNi8MtewToSIsr/AdNqeNaylN+Ft6luQjnRIKc0Itw=;
        b=Lq7uRh1HZkBl3ZnbaE/451eHbGVDl4ntqSSR5wVyA6xygK96yTG5uj9M0gC8ocpAcZ
         XisCUFUEQK7k4nji808HmBUcihSDF46U+Qj95DEgP5BKPMocHE/eByi9hW7fon4i/8xD
         rLtsurIF9ntiKcEzmsmSsmXcAvSqyeFtyRJvHNoWMeXVI+H0k9llRTAw3VclmP1I1CAD
         h5lUB9HxqiWx7qYORqUXOAqO8yr7hjbudJzk88UBtfi1Uzw/k2dtZwACQZSUSoVSBwBN
         iLQAq6HAhsbMuU9cCU1qwNBsCPP0izmSVFBGW/28ISv2ZTsiAv1Y60tZJinx+ZMG9OAw
         oobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726127603; x=1726732403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joNi8MtewToSIsr/AdNqeNaylN+Ft6luQjnRIKc0Itw=;
        b=Sy+aaXIgt75SZN35IguxC5KFZ1ogTNKZfnNO+edDjYq6ZEsGgykYlOcapmT6tHtD6I
         paFEwYwEjCgesRnfIepYLPVZ5YO+//NqOydGt3SDRwz4iYjXV+u9f4EdtHfEhoN1lcMO
         JLwBXdUpSrFU/gwlENm9n7Kur084D3C+VWKBzVhmQpaEDJVymrCUJAbofsC5DvrF/jMG
         ke2JiErbCvNZKC3x6CrDfme+kH3QzDfGYfNGvlZwBQ8YEmT1Va6jCV3/Bvyda3hc++5Y
         giKF9eS9ZGAadxlNAGwZShMnclx6ITMNxKf+B8qfxlPsVHjBxeLs6vyQBh1XX6T3zlix
         +0Nw==
X-Gm-Message-State: AOJu0Yy4+APNps8OAVBkUb1V11XeP//zRBue2vvHoLGtD5Hvk07K8+gg
	5b7FqZtiU/66+Wko8LP2KD9P5UCMhIA3H3Mt7C3w4/DJPLZKEv91
X-Google-Smtp-Source: AGHT+IHoAz0rBP0UX5Bpbw8bSJitJa6xNfUbL8fsYVXif/EheNLG6ddbaysWSqyaPQ8kgqrALaQcSQ==
X-Received: by 2002:adf:eec5:0:b0:378:7dc1:b22 with SMTP id ffacd0b85a97d-378c2cd3db2mr1104437f8f.12.1726127602718;
        Thu, 12 Sep 2024 00:53:22 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb43d73sm170702135e9.24.2024.09.12.00.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:53:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Sep 2024 09:53:20 +0200
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Amery Hung <amery.hung@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>, houtao1@huawei.com,
	xukuohai@huawei.com
Subject: Re: [PATCH bpf-next 2/2] bpf: Call the missed kfree() when there is
 no special field in btf
Message-ID: <ZuKd8B6NTFVBsxDM@krava>
References: <20240912012845.3458483-1-houtao@huaweicloud.com>
 <20240912012845.3458483-3-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912012845.3458483-3-houtao@huaweicloud.com>

On Thu, Sep 12, 2024 at 09:28:45AM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Call the missed kfree() in btf_parse_struct_metas() when there is no
> special field in btf, otherwise will get the following kmemleak report:
> 
> unreferenced object 0xffff888101033620 (size 8):
>   comm "test_progs", pid 604, jiffies 4295127011
>   ......
>   backtrace (crc e77dc444):
>     [<00000000186f90f3>] kmemleak_alloc+0x4b/0x80
>     [<00000000ac8e9c4d>] __kmalloc_cache_noprof+0x2a1/0x310
>     [<00000000d99d68d6>] btf_new_fd+0x72d/0xe90
>     [<00000000f010b7f8>] __sys_bpf+0xec3/0x2410
>     [<00000000e077ed6f>] __x64_sys_bpf+0x1f/0x30
>     [<00000000a12f9e55>] x64_sys_call+0x199/0x9f0
>     [<00000000f3029ea6>] do_syscall_64+0x3b/0xc0
>     [<000000005640913a>] entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> Fixes: 7a851ecb1806 ("bpf: Search for kptrs in prog BTF structs")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/btf.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 59b4f7265761..31eae516f701 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5572,8 +5572,10 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
>  		aof->ids[aof->cnt++] = i;
>  	}

I was wondering we could get away without the initial kmalloc and
let the first krealoc do the first allocation, but it might need
some other extra checks, so not sure it's worth it

in any case this lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

>  
> -	if (!aof->cnt)
> +	if (!aof->cnt) {
> +		kfree(aof);
>  		return NULL;
> +	}
>  	sort(&aof->ids, aof->cnt, sizeof(aof->ids[0]), btf_id_cmp_func, NULL);
>  
>  	for (i = 1; i < n; i++) {
> -- 
> 2.29.2
> 

