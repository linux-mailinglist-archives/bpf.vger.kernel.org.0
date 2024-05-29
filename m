Return-Path: <bpf+bounces-30866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE3B8D3F82
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 22:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1981F2204F
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 20:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67E51C68BE;
	Wed, 29 May 2024 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moZPBij4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECA11A38C9
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 20:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014179; cv=none; b=YptlY1Aog2vpjjx6SjKwv5AAwTyrI60FlzCAydUXib6FGSMWK6G5tHf6qN0gjQAirNVTlrBKl2D7ifkNmUL42/wIGtkpKSHenMc4G16N9WCLSjZevVUCV5yCJtJZwQHqQnjJuFvm7gfqCc8g1t3HuAGykDxC+rVsvoESX3e+iFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014179; c=relaxed/simple;
	bh=VV9+g0CMEKgL8FarInqmbVVALwa0fLGDGFPYT0LbRec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uaj2qcFvJTwubA9AGGi5yExWIzdwEmtoGyHA/iw6iYcUde40wxN8o96lG7k6uKT4gsai91fpAVW5IRjy9i8373XjDcSr0JaH3xst01dFUljJdl/FJZSOOJZ4vFXGDNCNP3zQ8/AVeP3j7Nxz/NpAnb4VYGKWsII8mDUasjkaOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moZPBij4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DAFC32786;
	Wed, 29 May 2024 20:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717014178;
	bh=VV9+g0CMEKgL8FarInqmbVVALwa0fLGDGFPYT0LbRec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=moZPBij4O9JxGiSyqp2VG37kAtL2cGWl9N46c/DseuJeaFsjjVYkqUSm4W/YwZiJg
	 ZAyzR228Nvu+N4ADiOgYRjGJHikfpyW2lcqD6skdK3/v+Z+x7RKolSvGT4u/OWREsa
	 myw1qL0I6JcjL8WAPf/yLSMQ7kEjJ6DcixNAVC8ejF5vqGXucdJHLT00CE4RlZoDKi
	 yFZ5i1PdoUPbSWGdYfRxpVPQpKjtkwC5mjOZLv7wCmQBguU7TPQJWIl6FSXt5P1e5t
	 KLTPRwuom2jyV+fberVA94qTgReB/FQxgm1lBV6c4r5GQkf+n/EvDUTP7YfkT/hbiN
	 RnURdKtYH0s3Q==
Message-ID: <ce5befac-f227-4d2a-bf4b-14e8c7d49052@kernel.org>
Date: Wed, 29 May 2024 21:22:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] bpftool: Query only cgroup-related attach types
To: Kenta Tada <tadakentaso@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
References: <20240529131028.41200-1-tadakentaso@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240529131028.41200-1-tadakentaso@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/05/2024 14:10, Kenta Tada wrote:
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
> Signed-off-by: Kenta Tada <tadakentaso@gmail.com>
> ---
>  tools/bpf/bpftool/cgroup.c | 47 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index af6898c0f388..bb2703aa4756 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -19,6 +19,39 @@
>  
>  #include "main.h"
>  
> +static const bool cgroup_attach_types[] = {
> +	[BPF_CGROUP_INET_INGRESS] = true,
> +	[BPF_CGROUP_INET_EGRESS] = true,
> +	[BPF_CGROUP_INET_SOCK_CREATE] = true,
> +	[BPF_CGROUP_INET_SOCK_RELEASE] = true,
> +	[BPF_CGROUP_INET4_BIND] = true,
> +	[BPF_CGROUP_INET6_BIND] = true,
> +	[BPF_CGROUP_INET4_POST_BIND] = true,
> +	[BPF_CGROUP_INET6_POST_BIND] = true,
> +	[BPF_CGROUP_INET4_CONNECT] = true,
> +	[BPF_CGROUP_INET6_CONNECT] = true,
> +	[BPF_CGROUP_UNIX_CONNECT] = true,
> +	[BPF_CGROUP_INET4_GETPEERNAME] = true,
> +	[BPF_CGROUP_INET6_GETPEERNAME] = true,
> +	[BPF_CGROUP_UNIX_GETPEERNAME] = true,
> +	[BPF_CGROUP_INET4_GETSOCKNAME] = true,
> +	[BPF_CGROUP_INET6_GETSOCKNAME] = true,
> +	[BPF_CGROUP_UNIX_GETSOCKNAME] = true,
> +	[BPF_CGROUP_UDP4_SENDMSG] = true,
> +	[BPF_CGROUP_UDP6_SENDMSG] = true,
> +	[BPF_CGROUP_UNIX_SENDMSG] = true,
> +	[BPF_CGROUP_UDP4_RECVMSG] = true,
> +	[BPF_CGROUP_UDP6_RECVMSG] = true,
> +	[BPF_CGROUP_UNIX_RECVMSG] = true,
> +	[BPF_CGROUP_SOCK_OPS] = true,
> +	[BPF_CGROUP_DEVICE] = true,
> +	[BPF_CGROUP_SYSCTL] = true,
> +	[BPF_CGROUP_GETSOCKOPT] = true,
> +	[BPF_CGROUP_SETSOCKOPT] = true,
> +	[BPF_LSM_CGROUP] = true,
> +	[__MAX_BPF_ATTACH_TYPE] = false,
> +};


Thanks for this!

I can't say I'm glad to see another version of the list of
cgroup-related attach types (in addition to HELP_SPEC_ATTACH_TYPES and
to the manual page). But the alternative would be to explicitly skip
BPF_NETKIT_PRIMARY, which is not great, either. Too bad we don't have a
way to check whether the type is cgroup-related in libbpf or from the
bpf.h headers; but I don't think there's much interest to add it there,
so we'll probably have the array. We should account for it in
tools/testing/selftests/bpf/test_bpftool_synctypes.py, but I can do this
as a follow-up if you don't feel like messing up with the Python script.


> +
>  #define HELP_SPEC_ATTACH_FLAGS						\
>  	"ATTACH_FLAGS := { multi | override }"
>  
> @@ -187,14 +220,16 @@ static int cgroup_has_attached_progs(int cgroup_fd)
>  	bool no_prog = true;
>  
>  	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
> -		int count = count_attached_bpf_progs(cgroup_fd, type);
> +		if (cgroup_attach_types[type]) {


Please change here:

                int count;

                if (!cgroup_attach_types[type])
                        continue;

And no need to further indent the rest of the block.


> +			int count = count_attached_bpf_progs(cgroup_fd, type);
>  
> -		if (count < 0 && errno != EINVAL)
> -			return -1;
> +			if (count < 0 && errno != EINVAL)
> +				return -1;
>  
> -		if (count > 0) {
> -			no_prog = false;
> -			break;
> +			if (count > 0) {
> +				no_prog = false;
> +				break;
> +			}
>  		}
>  	}
>  


