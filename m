Return-Path: <bpf+bounces-37348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A2E953EB1
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 03:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE46A1C21225
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 01:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE031803A;
	Fri, 16 Aug 2024 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Njirvktu"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC3B664;
	Fri, 16 Aug 2024 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723770380; cv=none; b=D8zb8Ggpoz1E5nJEWcSIu4+7Ii+ZRSJEKdvmbomg41jeTVoujLMMX//eFCr09GsLBKMDlFEZvT3MGMsr82E7Qvmd2H4XJPqwecg2WQwdfkM76e0Ki3lgWB2kCsN0hUDhavz0COB9Djw65kjDm2N10FHxUcq4KpHd2NGgrolv3+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723770380; c=relaxed/simple;
	bh=WOXZJW84ynJSFfpNkX4zLGzaLsDTmegbH86Is33NezY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTPuWnSJIYtiv0JiUME/k4UL/V3ObnSXh8nmIx+kP8hUgKcdPECeAwGyMmr68TWr0UYT0vNVWBXBSLyn72oOd/KAOQZUAVCVWLeuKkcCBZVl8LATisbG45282c0JYT3Nl4e3uybnBcU+wPklF5eQzC8seG2Q+LzOfebLSt+Ytgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Njirvktu; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <be4d3e00-de84-420b-9979-277ecc9df6ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723770376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BL1lkFeKf4t8gBk76y4Qplq54IJRsbkvrXvzvPSFgRo=;
	b=NjirvktuzHYJxzLLCwfCuMbwbEsCPPFPKnLn2zI0Yxfc6KPXB1CTJRCPW2lyjKWWK4gZMz
	OUPwBgm5ExS8tVX1A+z+hLkwmWRZjcLfOkta1Lz2kr1Be/BrH+v1Lz9MGOW68RqLqJzZr2
	bsM+fxATMwAUW1/FgHV/9CslOkDmYLM=
Date: Thu, 15 Aug 2024 18:06:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: cg_skb add get classid helper
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20240814095038.64523-1-zhoufeng.zf@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240814095038.64523-1-zhoufeng.zf@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/14/24 2:50 AM, Feng zhou wrote:
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> At cg_skb hook point, can get classid for v1 or v2, allowing
> users to do more functions such as acl.
> 
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
>   net/core/filter.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78a6f746ea0b..d69ba589882f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -8111,6 +8111,12 @@ cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_get_listener_sock_proto;
>   	case BPF_FUNC_skb_ecn_set_ce:
>   		return &bpf_skb_ecn_set_ce_proto;
> +	case BPF_FUNC_get_cgroup_classid:
> +		return &bpf_get_cgroup_classid_proto;
> +#endif
> +#ifdef CONFIG_CGROUP_NET_CLASSID
> +	case BPF_FUNC_skb_cgroup_classid:
> +		return &bpf_skb_cgroup_classid_proto;

With this bpf_skb_cgroup_classid_proto, is the above 
bpf_get_cgroup_classid_proto necessary?
The cg_skb hook must have a skb->sk.

Please add a selftest and tag the subject with bpf-next.

pw-bot: cr

>   #endif
>   	default:
>   		return sk_filter_func_proto(func_id, prog);


