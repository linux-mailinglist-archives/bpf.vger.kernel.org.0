Return-Path: <bpf+bounces-35095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C2C937A9F
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 18:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A05AB23C30
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BE82E414;
	Fri, 19 Jul 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RArnkbmf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B3210FF;
	Fri, 19 Jul 2024 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405845; cv=none; b=ZWOpMT/udWDOdFnSBmnEVDxe1BKXXhVPk1TUvnNdwYXYgfsGZjIpxIXs0zEXjPWbrrlqe8Q0cF0V1SU2BtADAboNgxJWxAbhvdslD+cIZtRMokt6As1Hn1O6EIrQnw7nPcUQBA4OCDOTjyZ63E3VMR/IQz4XFsppkA0OSgklwvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405845; c=relaxed/simple;
	bh=FBGPPW5pTaEP4QF7BB5oWnaKdqn9hVpVZ+c6VKNI7zI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZsGzXvNYxmuDvVzdmRiFKiv1JEHu/spwvmsHd8KE5YJ0ygr3PgPtfNLDRPljkKHC/1+TGDUg6qT+bLIAO2UmT9bmQBdvCL98u0TtB7PsFOpYsZfotpXI7UvTxKccHCPClHijsQ/FKtptQEz3ox/ERoj4ReU1R0gCHNFSvaUxrIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RArnkbmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5ADC32782;
	Fri, 19 Jul 2024 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721405845;
	bh=FBGPPW5pTaEP4QF7BB5oWnaKdqn9hVpVZ+c6VKNI7zI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=RArnkbmfZWwFcYPsciTc3fmZqXvpE207P11ONVJD0RkU1xtUDLqpQ4zHsdT7FpFqe
	 G0JFctY6qbb4+uYm/hCWDG9MyvG2eeEzPtenrnSnxOOFUeUgZN6e0g1U+hH7hoQcwg
	 +76Lo45Bgzr3LDnfj+ai3CVDIj1sxxv7ouajOVcCrLwU8RNGoXaR0HTFseYr0hdCZt
	 Ab5/+WP/M/4DIr9Gb1GKeJSGYOXFejvQ35Tbr0jBuCT8YUjEzWakaSZN3rckelc+ND
	 n6it7nujfGpVGprLWCZbBCTrsYDyjxGTQ/CKzjJhTEdMzEJvQYXFQuyXKKUJNrYvcH
	 qjt/iW/TRBmpg==
Message-ID: <fa9bb6d5-7a72-4d77-8862-d8489a759506@kernel.org>
Date: Fri, 19 Jul 2024 17:17:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [v2 PATCH bpf-next 2/4] bpftool: add net attach/detach command to
 tcx prog
To: Tao Chen <chen.dylane@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240717174749.1511366-1-chen.dylane@gmail.com>
Content-Language: en-GB
In-Reply-To: <20240717174749.1511366-1-chen.dylane@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/07/2024 18:47, Tao Chen wrote:
> Now, attach/detach tcx prog supported in libbpf, so we can add new
> command 'bpftool attach/detach tcx' to attach tcx prog with bpftool
> for user.
> 
>  # bpftool prog load tc_prog.bpf.o /sys/fs/bpf/tc_prog
>  # bpftool prog show
> 	...
> 	192: sched_cls  name tc_prog  tag 187aeb611ad00cfc  gpl
> 	loaded_at 2024-07-11T15:58:16+0800  uid 0
> 	xlated 152B  jited 97B  memlock 4096B  map_ids 100,99,97
> 	btf_id 260
>  # bpftool net attach tcx_ingress name tc_prog dev lo
>  # bpftool net
> 	...
> 	tc:
> 	lo(1) tcx/ingress tc_prog prog_id 29
> 
>  # bpftool net detach tcx_ingress dev lo
>  # bpftool net
> 	...
> 	tc:
>  # bpftool net attach tcx_ingress name tc_prog dev lo
>  # bpftool net
> 	tc:
> 	lo(1) tcx/ingress tc_prog prog_id 29
> 
> Test environment: ubuntu_22_04, 6.7.0-060700-generic
> 
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  tools/bpf/bpftool/net.c | 43 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index 1b9f4225b394..60b0af40109a 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -67,6 +67,8 @@ enum net_attach_type {
>  	NET_ATTACH_TYPE_XDP_GENERIC,
>  	NET_ATTACH_TYPE_XDP_DRIVER,
>  	NET_ATTACH_TYPE_XDP_OFFLOAD,
> +	NET_ATTACH_TYPE_TCX_INGRESS,
> +	NET_ATTACH_TYPE_TCX_EGRESS,
>  };
>  
>  static const char * const attach_type_strings[] = {
> @@ -74,6 +76,8 @@ static const char * const attach_type_strings[] = {
>  	[NET_ATTACH_TYPE_XDP_GENERIC]	= "xdpgeneric",
>  	[NET_ATTACH_TYPE_XDP_DRIVER]	= "xdpdrv",
>  	[NET_ATTACH_TYPE_XDP_OFFLOAD]	= "xdpoffload",
> +	[NET_ATTACH_TYPE_TCX_INGRESS]	= "tcx_ingress",
> +	[NET_ATTACH_TYPE_TCX_EGRESS]	= "tcx_egress",
>  };
>  
>  static const char * const attach_loc_strings[] = {
> @@ -647,6 +651,32 @@ static int do_attach_detach_xdp(int progfd, enum net_attach_type attach_type,
>  	return bpf_xdp_attach(ifindex, progfd, flags, NULL);
>  }
>  
> +static int get_tcx_type(enum net_attach_type attach_type)
> +{
> +	switch (attach_type) {
> +	case NET_ATTACH_TYPE_TCX_INGRESS:
> +		return BPF_TCX_INGRESS;
> +	case NET_ATTACH_TYPE_TCX_EGRESS:
> +		return BPF_TCX_EGRESS;
> +	default:
> +		return __MAX_BPF_ATTACH_TYPE;


Can we return -1 here instead, please? In the current code, we validate
the attach_type before entering this function and the "default" case is
never reached, it's only here to discard compiler's warning. But if we
ever reuse this function elsewhere, this could cause bugs: if the header
file used for compiling the bpftool binary is not in sync with the
header corresponding to the running kernel, __MAX_BPF_ATTACH_TYPE could
correspond to a newly introduced type, and bpftool/libbpf would try to
use that to attach the program, instead of detecting an error.


> +	}
> +}
> +
> +static int do_attach_tcx(int progfd, enum net_attach_type attach_type, int ifindex)
> +{
> +	int type = get_tcx_type(attach_type);
> +
> +	return bpf_prog_attach(progfd, ifindex, type, 0);
> +}
> +
> +static int do_detach_tcx(int targetfd, enum net_attach_type attach_type)
> +{
> +	int type = get_tcx_type(attach_type);
> +
> +	return bpf_prog_detach(targetfd, type);
> +}
> +
>  static int do_attach(int argc, char **argv)
>  {
>  	enum net_attach_type attach_type;
> @@ -692,6 +722,11 @@ static int do_attach(int argc, char **argv)
>  	case NET_ATTACH_TYPE_XDP_OFFLOAD:
>  		err = do_attach_detach_xdp(progfd, attach_type, ifindex, overwrite);
>  		break;
> +	/* attach tcx prog */
> +	case NET_ATTACH_TYPE_TCX_INGRESS:
> +	case NET_ATTACH_TYPE_TCX_EGRESS:
> +		err = do_attach_tcx(progfd, attach_type, ifindex);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -738,6 +773,11 @@ static int do_detach(int argc, char **argv)
>  		progfd = -1;
>  		err = do_attach_detach_xdp(progfd, attach_type, ifindex, NULL);
>  		break;
> +	/* detach tcx prog */
> +	case NET_ATTACH_TYPE_TCX_INGRESS:
> +	case NET_ATTACH_TYPE_TCX_EGRESS:
> +		err = do_detach_tcx(ifindex, attach_type);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -944,7 +984,8 @@ static int do_help(int argc, char **argv)
>  		"       %1$s %2$s help\n"
>  		"\n"
>  		"       " HELP_SPEC_PROGRAM "\n"
> -		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload }\n"
> +		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload | tcx_ingress\n"
> +		"			 | tcx_egress }\n"

                 ^^^^^^^^^^^^^^^^^^^^^^^
This indent space between the quote and the pipe needs to be spaces
instead of three tabs, please.

The rest of the patches looks good, thank you!

Quentin


