Return-Path: <bpf+bounces-31575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E692590012D
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 12:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFCB1F23790
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AB217BB2E;
	Fri,  7 Jun 2024 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NId5d2UM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236B17DE36
	for <bpf@vger.kernel.org>; Fri,  7 Jun 2024 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757456; cv=none; b=mCiIhLiqrpRgv1QY9Y1D0a4HhYh6dOQne1nCVp5fKfp69LOG70L7xMwp7J/7tuFATcMaNxpIRDA3y4zpa8gmOgNyLvM6iLFcwcpBnxlP+CZRSsDHFLx74h8NjT+a5FVWV1oyAfRi2BHoUX4TcvM3S7+OnZ594feLI7XZEB0VrV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757456; c=relaxed/simple;
	bh=hAq7+1undHUFYFCqcnoAMTdLw9SmRAo8a8OqzNssYMs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z1xpY88RA1aHYNoaqfQQ4mZ3PR/bObBxVaEIzsk0WYYrSoy3tCAA326p4V4qOOtmfpFYiBQiS2x7g9jY0y5apNuIIkZ8H0y1Mgnf3Z/UXBqbg4qIUL242C2ZW+9muDa6T43CA2JAwq80r3ROI8XJlXwAskRr0PA/8ZCfYPii3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NId5d2UM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A678C2BBFC;
	Fri,  7 Jun 2024 10:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717757456;
	bh=hAq7+1undHUFYFCqcnoAMTdLw9SmRAo8a8OqzNssYMs=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=NId5d2UMHqMtLeJqw38Bkotk7MvRWH6UOWQXjrFX5FdK+nnweA5dUcCRCwSQTBsbY
	 6cM+ippAtLJzYVIDfxAUWodd+kXQ2/Jvtz0aAHQpkJMzMX/iX+/ak5yLU2OZPnxloe
	 +QBCzcrS3u0MO6KNObWg8TdKmGFZAIhKeh/Xnqv4xcK/nH+NaLWpXNk8UMKY2EsK++
	 Zq5LJx0nO4CV+5jTOtZ75Ta0YGeSaq2PSu4miMu747iADWiTDq5FE6X0vQmQ1kbdUP
	 wbDX/lbjs6syCnNCKiTS2/ANhsGhFmPPT82j6O8ns4dtnDphVsuugXPoOwYzQgXVrL
	 TqG2MgIj59fPA==
Message-ID: <e7ca0725-9cf7-49e3-b362-93430e3c649f@kernel.org>
Date: Fri, 7 Jun 2024 11:50:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v2] bpftool: Query only cgroup-related attach types
To: Kenta Tada <tadakentaso@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
References: <20240607102148.151272-1-tadakentaso@gmail.com>
Content-Language: en-GB
In-Reply-To: <20240607102148.151272-1-tadakentaso@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-06-07 11:21 UTC+0100 ~ Kenta Tada <tadakentaso@gmail.com>
> When CONFIG_NETKIT=y,
> bpftool-cgroup shows error even if the cgroup's path is correct:
> 
> $ bpftool cgroup tree /sys/fs/cgroup
> CgroupPath
> ID       AttachType      AttachFlags     Name
> Error: can't query bpf programs attached to /sys/fs/cgroup: No such device or address
> 
> From strace and kernel tracing, I found netkit returned ENXIO and this command failed.
> I think this AttachType(BPF_NETKIT_PRIMARY) is not relevant to cgroup.
> 
> bpftool-cgroup should query just only cgroup-related attach types.
> 
> v1->v2:
>   - used an array of cgroup attach types
> 
> Signed-off-by: Kenta Tada <tadakentaso@gmail.com>
> ---
>  tools/bpf/bpftool/cgroup.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index af6898c0f388..afab728468bf 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -19,6 +19,38 @@
>  
>  #include "main.h"
>  
> +static const int cgroup_attach_types[] = {
> +	BPF_CGROUP_INET_INGRESS,
> +	BPF_CGROUP_INET_EGRESS,
> +	BPF_CGROUP_INET_SOCK_CREATE,
> +	BPF_CGROUP_INET_SOCK_RELEASE,
> +	BPF_CGROUP_INET4_BIND,
> +	BPF_CGROUP_INET6_BIND,
> +	BPF_CGROUP_INET4_POST_BIND,
> +	BPF_CGROUP_INET6_POST_BIND,
> +	BPF_CGROUP_INET4_CONNECT,
> +	BPF_CGROUP_INET6_CONNECT,
> +	BPF_CGROUP_UNIX_CONNECT,
> +	BPF_CGROUP_INET4_GETPEERNAME,
> +	BPF_CGROUP_INET6_GETPEERNAME,
> +	BPF_CGROUP_UNIX_GETPEERNAME,
> +	BPF_CGROUP_INET4_GETSOCKNAME,
> +	BPF_CGROUP_INET6_GETSOCKNAME,
> +	BPF_CGROUP_UNIX_GETSOCKNAME,
> +	BPF_CGROUP_UDP4_SENDMSG,
> +	BPF_CGROUP_UDP6_SENDMSG,
> +	BPF_CGROUP_UNIX_SENDMSG,
> +	BPF_CGROUP_UDP4_RECVMSG,
> +	BPF_CGROUP_UDP6_RECVMSG,
> +	BPF_CGROUP_UNIX_RECVMSG,
> +	BPF_CGROUP_SOCK_OPS,
> +	BPF_CGROUP_DEVICE,
> +	BPF_CGROUP_SYSCTL,
> +	BPF_CGROUP_GETSOCKOPT,
> +	BPF_CGROUP_SETSOCKOPT,
> +	BPF_LSM_CGROUP
> +};
> +
>  #define HELP_SPEC_ATTACH_FLAGS						\
>  	"ATTACH_FLAGS := { multi | override }"
>  
> @@ -183,11 +215,11 @@ static int count_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
>  
>  static int cgroup_has_attached_progs(int cgroup_fd)
>  {
> -	enum bpf_attach_type type;
> +	unsigned int i = 0;
>  	bool no_prog = true;
>  
> -	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
> -		int count = count_attached_bpf_progs(cgroup_fd, type);
> +	for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {


Thanks, it looks better that way.


> +		int count = count_attached_bpf_progs(cgroup_fd, cgroup_attach_types[i]);
>  
>  		if (count < 0 && errno != EINVAL)


I think the "errno != EINVAL" exception was here to allow iterating over
unsupported attach types for the queries. Now that we only do supported
types, we can probably remove it and return if "(count < 0)".


>  			return -1;


