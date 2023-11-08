Return-Path: <bpf+bounces-14457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAEB7E5014
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 06:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DFE1C20D01
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 05:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2456C8C4;
	Wed,  8 Nov 2023 05:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="B+8dp0+1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A887CA4C
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 05:38:44 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EA9D79
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 21:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=gMKlirG0RrqHuigobtL+LWhHvBf5G8HCE6qH311lAcc=; b=B+8dp0+1Mp5tRmkGs649Fosm2M
	ojDz090h6ehadSVCKp+bvhJFfYEgynLsna0q3CIBHkCTH11GVE7gjanRzegcg4gEycDaC87NP934v
	go3U7k1c9Qf317xkjApd2oNBPHcorK1WR1EBCr11V/Q1rYZZQF6tIOCtktSyPy10sUr5m38HM5iKl
	UP4BDEgai4+DXPkkK4CjPx7+cXrntuFlL906vOx5UnByM6actgY+LFeaMChP2LmhNTSzS/uaDu47j
	nUqlAG4CceCxaPjR4AVrbeVr3jUAovRlEFQuCo9tlXNIweFnIk+GYIYZ5MJQCRS4gN2MSxgwLAox/
	6AzvmVYw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r0bGy-0009DX-2F; Wed, 08 Nov 2023 06:38:40 +0100
Received: from [194.230.147.75] (helo=localhost.localdomain)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r0bGx-000Itd-J4; Wed, 08 Nov 2023 06:38:39 +0100
Subject: Re: [PATCH bpf-next v3] libbpf: Fix potential uninitialized tail
 padding with LIBBPF_OPTS_RESET
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231107201511.2548645-1-yonghong.song@linux.dev>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <332d7a0b-d763-2e6f-3c70-e8e73de1b5a2@iogearbox.net>
Date: Wed, 8 Nov 2023 06:38:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231107201511.2548645-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27086/Tue Nov  7 09:39:18 2023)

On 11/7/23 9:15 PM, Yonghong Song wrote:
> Martin reported that there is a libbpf complaining of non-zero-value tail
> padding with LIBBPF_OPTS_RESET macro if struct bpf_netkit_opts is modified
> to have a 4-byte tail padding. This only happens to clang compiler.
> The commend line is: ./test_progs -t tc_netkit_multi_links
> Martin and I did some investigation and found this indeed the case and
> the following are the investigation details.

[...]

Too bad we need this detour, but fix lgtm, thanks!

> diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
> index b7060f254486..8fe248e14eb6 100644
> --- a/tools/lib/bpf/libbpf_common.h
> +++ b/tools/lib/bpf/libbpf_common.h
> @@ -79,11 +79,14 @@
>    */
>   #define LIBBPF_OPTS_RESET(NAME, ...)					    \
>   	do {								    \
> -		memset(&NAME, 0, sizeof(NAME));				    \
> -		NAME = (typeof(NAME)) {					    \
> -			.sz = sizeof(NAME),				    \
> -			__VA_ARGS__					    \
> -		};							    \
> +		typeof(NAME) ___##NAME = ({ 				    \
> +			memset(&___##NAME, 0, sizeof(NAME));		    \
> +			(typeof(NAME)) {				    \
> +				.sz = sizeof(NAME),			    \
> +				__VA_ARGS__				    \
> +			};						    \
> +		});							    \
> +		memcpy(&NAME, &___##NAME, sizeof(NAME));		    \
>   	} while (0)
>   
>   #endif /* __LIBBPF_LIBBPF_COMMON_H */
> 


