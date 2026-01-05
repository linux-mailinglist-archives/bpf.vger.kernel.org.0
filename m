Return-Path: <bpf+bounces-77800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9D4CF3083
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 11:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 249B830E231B
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B53168FA;
	Mon,  5 Jan 2026 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJRgwPNv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBCE3161BD;
	Mon,  5 Jan 2026 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609604; cv=none; b=jqWX8uY+f7kXk59AVqz3cOYGvWbEh5ZgQstEhSzBDHbh9s1yKXNQEBBVIC9IFiINg6w4rrh44lkUF2eVBu+hJXKYoyRGeZ4NHZbD78M7tsz0smAsc5Id6lEvfjIafwKtq6sNnVX5yRIV5HGXyn3CvjwhCIuCH25i1vrFw717SkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609604; c=relaxed/simple;
	bh=h7TQZbRFy0uXUBt40iNG6WS7vvo9zqeFJrG/4NGqFjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esqOVKzsbXJB9k3B8/OmwhxQSCYLW71DvBiPRaAp4JEYLYKFFjsud3tQEz9zw8rOXzIbyjfDWVVoL0Z0XIn4IO1ynPwiqti0ePAatLTZBf09MxEGMrRMy/46FU0tOc1rNYIQcZDI5EWAfUjpjXdhejPrrvqs7DoeNnW2dkQmYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJRgwPNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF3EC116D0;
	Mon,  5 Jan 2026 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767609603;
	bh=h7TQZbRFy0uXUBt40iNG6WS7vvo9zqeFJrG/4NGqFjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iJRgwPNvglD1duGkXUiFXZhRkDsrcfnOujWpVzuh0AK6igS3cMfvzhAPNmEc2xOjg
	 gTWdooH2UazbC7kk6S0mO+CO/hM3kRDtDe8rvyMMgwLLBi6yi3DkQpAAyIV5uJThHR
	 tsRIcCSAOA6PobDI7m2465yJql+FYTZUBb7VHlXgZcXpt7OKJSbNr0N/yrm5YLedXs
	 oAhjVKVElQq13GGK3d5S0fEyQLTWPWSehDxHsgaJT5Aexpe2HLL4YaSDUisqWiDKzr
	 6Yu1VQgC8RMIh2OaHH7NTOU6BozoZffIIht3G4wX8YcV9EFjuQvACvNbHg2iXP0y5V
	 RRQiUWMZZ0jTQ==
Message-ID: <f3ab8c9f-3bb9-4427-8b43-c1ed9d488970@kernel.org>
Date: Mon, 5 Jan 2026 10:39:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next] bpftool: Make skeleton C++ compatible with
 explicit casts
To: WanLi Niu <kiraskyler@163.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 WanLi Niu <niuwl1@chinatelecom.cn>, Menglong Dong <dongml2@chinatelecom.cn>
References: <20260104021402.2968-1-kiraskyler@163.com>
 <20260105071231.2501-1-kiraskyler@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260105071231.2501-1-kiraskyler@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/01/2026 07:12, WanLi Niu wrote:
> From: WanLi Niu <niuwl1@chinatelecom.cn>
> 
> Fix C++ compilation errors in generated skeleton by adding explicit
> pointer casts and using integer subtraction for offset calculation.
> 
> Use struct outer::inner syntax under __cplusplus to access nested skeleton map
> structs, ensuring C++ compilation compatibility while preserving C support
> 
> error: invalid conversion from 'void*' to '<obj_name>*' [-fpermissive]
>       |         skel = skel_alloc(sizeof(*skel));
>       |                ~~~~~~~~~~^~~~~~~~~~~~~~~
>       |                          |
>       |                          void*
> 
> error: arithmetic on pointers to void
>       |         skel->ctx.sz = (void *)&skel->links - (void *)skel;
>       |                        ~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~
> 
> error: assigning to 'struct <obj_name>__<ident> *' from incompatible type 'void *'
>       |                 skel-><ident> = skel_prep_map_data((void *)data, 4096,
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                                 sizeof(data) - 1);
>       |                                                 ~~~~~~~~~~~~~~~~~
> 
> error: assigning to 'struct <obj_name>__<ident> *' from incompatible type 'void *'
>       |         skel-><ident> = skel_finalize_map_data(&skel->maps.<ident>.initial_value,
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                         4096, PROT_READ | PROT_WRITE, skel->maps.<ident>.map_fd);
>       |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Minimum reproducer:
> 
> 	$ cat test.bpf.c
> 	int val; // placed in .bss section
> 
> 	#include "vmlinux.h"
> 	#include <bpf/bpf_helpers.h>
> 
> 	SEC("raw_tracepoint/sched_wakeup_new") int handle(void *ctx) { return 0; }
> 
> 	$ cat test.cpp
> 	#include <cerrno>
> 
> 	extern "C" {
> 	#include "test.bpf.skel.h"
> 	}
> 
> 	$ bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
> 	$ clang -g -O2 -target bpf -c test.bpf.c -o test.bpf.o
> 	$ bpftool gen skeleton test.bpf.o -L  > test.bpf.skel.h
> 	$ g++ -c test.cpp -I.


I tried it and could confirm that the warnings are gone.


> Signed-off-by: WanLi Niu <niuwl1@chinatelecom.cn>
> Co-developed-by: Menglong Dong <dongml2@chinatelecom.cn>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you!

