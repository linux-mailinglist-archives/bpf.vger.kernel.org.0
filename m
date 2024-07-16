Return-Path: <bpf+bounces-34922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1586932EFF
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 19:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD53B23046
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 17:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF1B19FA6C;
	Tue, 16 Jul 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8KPJHI3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715ADFC19;
	Tue, 16 Jul 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721150637; cv=none; b=Gi8NAokRa3JfyA+H0yVk/PpzjuYc2haympHaD13TpJcKedIiTtCSjqEwrM4PjF/36Zm5XgI/l66DSL4RZA7P+qToQmDC6j7kr82JUojGFnIfGZy9qN29uoqvukjL7KlQfr7/nv8QsdHdZdK+0X5VY7SP4AdctnmVFqWRsV7iSuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721150637; c=relaxed/simple;
	bh=/xP5Jro7wMkLVgFJ8HnjrfPBNX+zInQ71kWrXc22cGA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ra+vi788Cba/DI7rBkhn4P8isPmWA3uZ8PjlR3DnCCqk1jj9a9SdQXrEMlus6Q9upV09ywAE5wsW+02+FoUqsfVh7H5nSjcre0y2dV80JRQ4gMCHwUO/TyDNIVO48QiwGYYUCAP5n8Efc2Ath4BaQ+qRroRznF53mUr8lFMYPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8KPJHI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B27C116B1;
	Tue, 16 Jul 2024 17:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721150636;
	bh=/xP5Jro7wMkLVgFJ8HnjrfPBNX+zInQ71kWrXc22cGA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=O8KPJHI3/QYIw6FTGBaE1XrPPicfbScfK2h3/htxTu0ZtL7mCfcj0hTKeZ4P4tB4v
	 9wdCz9g2Tdrg3UsOPExrMpkL5HwiWbYesEYt4QCBhEseE7bXQt0VMbJF3zcx5W4T2J
	 SUSibMRbG4GyT5XCBi/btl4MPqEdbdRs0gGTQkUzAMMDR/2AdcpPfcNBvX5TWTiWV0
	 atZK1T+CFol7P6NcI9TFKlNkH7WbpC2c6RF+OQnrVn84vBRkKY61Zl0Z9pW4cSsjfu
	 GPMohU3o+Af8S9PCPW87fT8W/YB1YOyHrQf57QwEAdODMoMtyPTZ8CeooV6KFjxMxV
	 1IVDx/VvZed7g==
Message-ID: <0284ae6e-0187-4a72-a855-ba1afeb9af2e@kernel.org>
Date: Tue, 16 Jul 2024 18:23:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [RFC PATCH bpf-next 1/3] bpftool: add net attach/detach command
 to tcx prog
To: Tao Chen <chen.dylane@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240715113704.1279881-1-chen.dylane@gmail.com>
 <20240715113704.1279881-2-chen.dylane@gmail.com>
Content-Language: en-GB
In-Reply-To: <20240715113704.1279881-2-chen.dylane@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-07-15 12:37 UTC+0100 ~ Tao Chen <chen.dylane@gmail.com>
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
>  # bpftool net attach tcxingress name tc_prog dev lo
>  # bpftool net
> 	...
> 	tc:
> 	lo(1) tcx/ingress tc_prog prog_id 29
> 
>  # bpftool net detach tcxingress dev lo
>  # bpftool net
> 	...
> 	tc:
>  # bpftool net attach tcxingress name tc_prog dev lo
>  # bpftool net
> 	tc:
> 	lo(1) tcx/ingress tc_prog prog_id 29
> 
> Test environment: ubuntu_22_04, 6.7.0-060700-generic
> 
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
> ---
>  tools/bpf/bpftool/net.c | 52 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index 968714b4c3d4..be7fd76202f1 100644
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
> +	[NET_ATTACH_TYPE_TCX_INGRESS]	= "tcxingress",
> +	[NET_ATTACH_TYPE_TCX_EGRESS]	= "tcxegress",


Hi, thanks for this work!

I wonder whether "tcx_ingress" and "tcx_egress" might be more readable?
I know we don't have underscores for XDP types but I'd be tempted to add
it for the tcx types, what do you think?


>  };
>  
>  static const char * const attach_loc_strings[] = {
> @@ -647,6 +651,32 @@ static int do_attach_detach_xdp(int progfd, enum net_attach_type attach_type,
>  	return bpf_xdp_attach(ifindex, progfd, flags, NULL);
>  }
>  
> +static int get_tcx_type(enum net_attach_type attach_type)
> +{
> +	int type = 0;
> +
> +	if (attach_type == NET_ATTACH_TYPE_TCX_INGRESS)
> +		type |= BPF_TCX_INGRESS;
> +	else if (attach_type == NET_ATTACH_TYPE_TCX_EGRESS)
> +		type |= BPF_TCX_EGRESS;


Why the logical OR in this function? This seems to be copied from the
XDP code, where we need to set flags. Here we just need the type, if I
remember correctly, so we could have:

	switch (attach_type) {
	case (NET_ATTACH_TYPE_TCX_INGRESS):
		return BPF_TXC_INGRESS;
	case (NET_ATTACH_TYPE_TCX_EGRESS):
		return BPF_TCX_EGRESS;
	}

(or if/else, works as well) which would be easier to understand in my
opinion.

> +
> +	return type;
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
> @@ -694,6 +724,15 @@ static int do_attach(int argc, char **argv)
>  		goto cleanup;
>  	}
>  
> +	/* attach tcx prog */
> +	if (is_prefix("tcx", attach_type_strings[attach_type]))
> +		err = do_attach_tcx(progfd, attach_type, ifindex);
> +	if (err) {
> +		p_err("interface %s attach failed: %s",
> +		      attach_type_strings[attach_type], strerror(-err));
> +		goto cleanup;
> +	}


This introduces a second check on "err" in the function: if we attach an
XDP program we'll try to attach then check "err" twice. Same for a TCX
program, we'll check "err" before even trying to attach.

I understand this replicates what we do for XDP, but I'm not sure the
sequential calls to 'is_prefix("...")' is the cleanest approach. We
should probably change the XDP case a bit and integrate with TCX better.
Expanding the different attach types is more verbose, but remains the
most straightforward way in my opinion.

	switch (attach_type) {
	case NET_ATTACH_TYPE_XDP:
	case NET_ATTACH_TYPE_XDP_GENERIC:
	case NET_ATTACH_TYPE_XDP_DRIVER:
	case NET_ATTACH_TYPE_XDP_OFFLOAD:
		err = do_attach_xdp(...);
		break;
	case NET_ATTACH_TYPE_TCX_INGRESS:
	case NET_ATTACH_TYPE_TCX_EGRESS:
		err = do_attach_tcx(...);
		break;
	}

	// Single check on "err" for both XDP and TCX here;
	// Or moving it to the switch statement if checks/error messages
	// needed to be different, but that's not the case in your patch
	if (err) {
		p_err(...);
		goto cleanup;
	}


> +
>  	if (json_output)
>  		jsonw_null(json_wtr);
>  cleanup:
> @@ -732,6 +771,16 @@ static int do_detach(int argc, char **argv)
>  		return err;
>  	}
>  
> +	/* detach tcx prog */
> +	if (is_prefix("tcx", attach_type_strings[attach_type]))
> +		err = do_detach_tcx(ifindex, attach_type);
> +
> +	if (err < 0) {
> +		p_err("interface %s detach failed: %s",
> +		      attach_type_strings[attach_type], strerror(-err));
> +		return err;
> +	}


Same here.


> +
>  	if (json_output)
>  		jsonw_null(json_wtr);
>  
> @@ -928,7 +977,8 @@ static int do_help(int argc, char **argv)
>  		"       %1$s %2$s help\n"
>  		"\n"
>  		"       " HELP_SPEC_PROGRAM "\n"
> -		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload }\n"
> +		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload | tcxingress\n"
> +		"			| tcxegress}\n"


Please use spaces only for indent inside of the string, and add a space
before the ending '}'.


>  		"       " HELP_SPEC_OPTIONS " }\n"
>  		"\n"
>  		"Note: Only xdp, tcx, tc, netkit, flow_dissector and netfilter attachments\n"


