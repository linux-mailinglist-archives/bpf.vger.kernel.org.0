Return-Path: <bpf+bounces-42587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF579A5FB8
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 11:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2FB3B21062
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 09:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBBF1E25FE;
	Mon, 21 Oct 2024 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS1keIz7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B9B1E0DDA
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501781; cv=none; b=fITjDYn5gTe0WC5lnN5tI/vyH+qTV18zV6GjOSKS4EiKcB0V3KIKzTxUDoRDtiPkjNREQ9W/kOgHjdJR5N0WqZEF6IMVp/C5sc/L363nMY24xXzyERHRCVqpwdD7rnnWIGFJxiHjlksrGux6xcrM6TQuMYuxjLK9EFzIGVmP2tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501781; c=relaxed/simple;
	bh=bqe0tuY1ihBF1ZiYXFX9kAewNJsG/o9RxJVoULD/Pug=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSrtl88eUANtiWNEFOJAOgKRE1Zz58VjEQJW6AgLyNimI5ttbCTmrDTqUJ2u6h11LlJs4Q53fvT/Uth9cFeuADVbp1LgQMyLZY8vaRTYjzgi8ThwrCHpPfFXHHMakBkpTMjMR4Fod7Su3ZfHS41gUSvWCMiJmF4EcF0oT71VLKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aS1keIz7; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53a097aa3daso3898996e87.1
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729501777; x=1730106577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDr0rt3YkD89Dr1mGI3trYknpe9GWmBs4jGzO5dLeX8=;
        b=aS1keIz7G3nZ4ma9+0OYvbQwqRzumywiaULmVJx7EKdJLKsUqNJq7ZsBJ26VF/ceMa
         OL5Dz1TxM+hp8lz9CMPxup1YcoQIXR5jFBQVFTzgPAJpiV9jE9k4Iqxe8bttk10sC4iH
         8ycCpvyLm6XO58eJR79KuxB9T3DOntgKYCZ/yDHb/wJwuI72sSAKxSFX9wdSqyUov6g3
         NWzwWTga6u+/QPgkbgvNkxXo8WnhLssnsBk7wF0FDn2SLwko0mIl5moqCJP0Amy/MMYY
         p780O3f66fwpNv5Kd1B8rwtayl+yl/lROR5Zmnr72by1Koecmpbmbmp3RKF7pa5VpZ2X
         c6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729501777; x=1730106577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDr0rt3YkD89Dr1mGI3trYknpe9GWmBs4jGzO5dLeX8=;
        b=qgb8MrG1PX+nCNKHF6RoT/rIvRvpGEJ7fPVJ7hao5l73e2QeomMvqLUNEbfxIkmiD5
         MjFwHu7pXMT4u3dnkqEIoS73kpoWmiWMf8jU8GEMdIDe1XbFPva3STvPCYLgT1oYatlf
         6kPTprHAcn+Bt8urD7M4guHdzzisgib06DfuJC0cni0m3qG7G+fr2yy7XErETkxOg5WI
         CXwlU3Rdzv3X0uojONs30Pllc6LaWQM7hM6iHcSncQG+O57z/xfW2OJGyx+Ywe44k2JL
         jwJuIKrA1lU0QBsCh9mpyXOr62grZ9yZzTvHXJWsUQ0Z8U+F0FjQWTH+j0lGkMu9MZsv
         RGHA==
X-Gm-Message-State: AOJu0YwNwzjB3qOpuod0M8sjs86h09vY/1k8a6kToI4D13ut1i2fUlCg
	t1o8YSh6yA9Q5i0NHL287MyQy+8ZT11JXIcct+ux15OX8qoIjDMQ
X-Google-Smtp-Source: AGHT+IEOK/hKN5uJDLBNego36YBnBCJ8o3NnV9gwA21Chk3LZuRzN/8bdyfiwTI6bmDBfc1BfIYPNw==
X-Received: by 2002:a05:6512:4017:b0:539:a924:74ba with SMTP id 2adb3069b0e04-53a154a2c0bmr4683024e87.56.1729501776863;
        Mon, 21 Oct 2024 02:09:36 -0700 (PDT)
Received: from krava (85-193-35-184.rib.o2.cz. [85.193.35.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91559b33sm178224666b.116.2024.10.21.02.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:09:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Oct 2024 11:09:33 +0200
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	John Fastabend <john.fastabend@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, houtao1@huawei.com,
	xukuohai@huawei.com
Subject: Re: [PATCH bpf v2 3/7] bpf: Preserve param->string when parsing
 mount options
Message-ID: <ZxYaTSRE1N59vscc@krava>
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
 <20241021014004.1647816-4-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021014004.1647816-4-houtao@huaweicloud.com>

On Mon, Oct 21, 2024 at 09:40:00AM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> In bpf_parse_param(), keep the value of param->string intact so it can
> be freed later. Otherwise, the kmalloc area pointed to by param->string
> will be leaked as shown below:
> 
> unreferenced object 0xffff888118c46d20 (size 8):
>   comm "new_name", pid 12109, jiffies 4295580214
>   hex dump (first 8 bytes):
>     61 6e 79 00 38 c9 5c 7e                          any.8.\~
>   backtrace (crc e1b7f876):
>     [<00000000c6848ac7>] kmemleak_alloc+0x4b/0x80
>     [<00000000de9f7d00>] __kmalloc_node_track_caller_noprof+0x36e/0x4a0
>     [<000000003e29b886>] memdup_user+0x32/0xa0
>     [<0000000007248326>] strndup_user+0x46/0x60
>     [<0000000035b3dd29>] __x64_sys_fsconfig+0x368/0x3d0
>     [<0000000018657927>] x64_sys_call+0xff/0x9f0
>     [<00000000c0cabc95>] do_syscall_64+0x3b/0xc0
>     [<000000002f331597>] entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> Fixes: 6c1752e0b6ca ("bpf: Support symbolic BPF FS delegation mount options")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

nice, I saw that memleak report recently and couldn't make sense of it ;-)

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  kernel/bpf/inode.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index d8fc5eba529d..9aaf5124648b 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -880,7 +880,7 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		const struct btf_type *enum_t;
>  		const char *enum_pfx;
>  		u64 *delegate_msk, msk = 0;
> -		char *p;
> +		char *p, *str;
>  		int val;
>  
>  		/* ignore errors, fallback to hex */
> @@ -911,7 +911,8 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  			return -EINVAL;
>  		}
>  
> -		while ((p = strsep(&param->string, ":"))) {
> +		str = param->string;
> +		while ((p = strsep(&str, ":"))) {
>  			if (strcmp(p, "any") == 0) {
>  				msk |= ~0ULL;
>  			} else if (find_btf_enum_const(info.btf, enum_t, enum_pfx, p, &val)) {
> -- 
> 2.29.2
> 

