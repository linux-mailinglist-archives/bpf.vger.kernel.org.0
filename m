Return-Path: <bpf+bounces-45818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF78C9DB527
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 10:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A6E1B26218
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E88158534;
	Thu, 28 Nov 2024 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGxRlGDB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0A157469;
	Thu, 28 Nov 2024 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787937; cv=none; b=cLzm8grRk7xAb19XTLaUntNajZ2GPPz7zZ58bus3Lp/myOamC1gPV6yH9Jl367loRBFoKT8HMtr3IoZ3MkTJeRP/7LZAXiMYY8Dz//6YC6Gfh3vC41W24KL/Y6wIIvp+yALcnmcRKgASi5yhAiTbX230YYUtfel0EBQ22FwFqvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787937; c=relaxed/simple;
	bh=RtFHV+7hsw/yZmKt2RkM3VWEnMq//B6X9xSdsYGDMD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fw1brgNd6gfKFPUsFz5aZ/ncxH8A4RfpT3jGk4Bp0qRKy4IVqmC6vM41toTs/TJCeVRIXvRt5wCICQFZ3uFIy8+ki06c4CDA6PlacV0/jC9Clt+0BimTdSVJ8bIaD6nlVmXNG1n6nOmipOdrAEUb1JvmrCq0FQ0mFKQUcdO2Seo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGxRlGDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56794C4CECE;
	Thu, 28 Nov 2024 09:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732787936;
	bh=RtFHV+7hsw/yZmKt2RkM3VWEnMq//B6X9xSdsYGDMD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bGxRlGDBo5zObY3gsauAzj72o3ELJkRGbUhHyUlN1EUxw58SSpFdAb0kjjuZH61uG
	 XpzZBJRbI/6FAzmcgf5+9mwPa9p0SZEEKob/Kh6plsjSzzcyCrc11aNwE/pWoKWDgw
	 eU8yRczQxIl/tFLAm516YT3kSvFoJA092FInRV+brwXGP7XjOKHr7rRGGhcGHcpMD8
	 Ve4WQV0+d70LoQNa8anJX4g2dFp9SYRryACbCfZdy9Ihh4HuvA2+Id64vpJYhEyYIw
	 XZPHsd/NbA6v7b0VSdjfP5LHH8p2t/yAvHSLKLMmGmco5bw0vnqXoorIZzNQVhjsRf
	 nPcXX7g3w5HNw==
Message-ID: <0370e35c-a06b-40dd-90b4-50cc30db224c@kernel.org>
Date: Thu, 28 Nov 2024 09:58:52 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/bpf: bpftool:Fix the wrong format specifier
To: liujing <liujing@cmss.chinamobile.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128025551.2868-1-liujing@cmss.chinamobile.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241128025551.2868-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Please drop the "tools/bpf: " part of the prefix in your patch title,
it's enough to keep "bpftool: ".


2024-11-28 10:55 UTC+0800 ~ liujing <liujing@cmss.chinamobile.com>
> The output format of unsigned int should be %u, and the output
> format of int should be %d, so fix it.
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> diff --git a/tools/bpf/bpftool/netlink_dumper.c b/tools/bpf/bpftool/netlink_dumper.c
> index 5f65140b003b..97e1e1dbc842 100644
> --- a/tools/bpf/bpftool/netlink_dumper.c
> +++ b/tools/bpf/bpftool/netlink_dumper.c
> @@ -45,7 +45,7 @@ static int do_xdp_dump_one(struct nlattr *attr, unsigned int ifindex,
>  	NET_START_OBJECT;
>  	if (name)
>  		NET_DUMP_STR("devname", "%s", name);
> -	NET_DUMP_UINT("ifindex", "(%d)", ifindex);
> +	NET_DUMP_UINT("ifindex", "(%u)", ifindex);
>  
>  	if (mode == XDP_ATTACHED_MULTI) {
>  		if (json_output) {
> @@ -168,7 +168,7 @@ int do_filter_dump(struct tcmsg *info, struct nlattr **tb, const char *kind,
>  		NET_START_OBJECT;
>  		if (devname[0] != '\0')
>  			NET_DUMP_STR("devname", "%s", devname);
> -		NET_DUMP_UINT("ifindex", "(%u)", ifindex);
> +		NET_DUMP_UINT("ifindex", "(%d)", ifindex);
>  		NET_DUMP_STR("kind", " %s", kind);
>  		ret = do_bpf_filter_dump(tb[TCA_OPTIONS]);
>  		NET_END_OBJECT_FINAL;


Thanks for this. The second chunk is not enough to fix the format
specifier cleanly, because NET_DUMP_UINT() may end up calling:

	jsonw_printf(self, "%"PRIu64, num);

So you probably need to add a NET_DUMP_INT() wrapper and call it here.

There's also another occurrence of the macro called on a signed
"ifindex" in net.c, in __show_dev_tc_bpf(), using "(%u)". Let's fix it
in the same patch, please?

Thanks,
Quentin

