Return-Path: <bpf+bounces-77709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF76CEF3D9
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 20:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86E94301D5A5
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 19:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB45E1B81CA;
	Fri,  2 Jan 2026 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q9jTOR7p"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BCA278165
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767382572; cv=none; b=kIvcUH03sj/KH43uKbZjnXqOkoMTwF//Czv9LFXXUSgm0cJDcVvHnocEJ/2IwyrA2RpEV8RLO6m2NS8AkgQ97WV6SRv/Z224JTJVZuTbLOYy+gthpQPKiAD/UF0wTEAStYmFUKK/RJuUn/zI+/9enzjBHH9fCZdAFT0ES3G330k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767382572; c=relaxed/simple;
	bh=3cO+VfBib8WchVUvUBd8cQwhcsE6+hlvGSo2JoXPBig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HB1xR3wij3+zFzEui+xBFKr9PZM06eB/mz2IvfcwT3m1heiFOQFxJ1n7lcbsmL3HRJ6Qu1H1EXUrxR9aZk0BlYzxjJjSBiyf7yFLo9LuDjiMPJ1pcWxx4UPXxcriuaumyTa70wCo8sIug3O59IvXObOlcu/1vSipYHDwRVDxFF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q9jTOR7p; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <988dfd54-9f11-4ff1-803c-393d168a068b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767382558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqGMLYsOH1eK6u8yWgEXbjw4Z87nIOH6/YxoX0KJi5M=;
	b=q9jTOR7pz3CbrAo6xvwFmaku8zlEbvtGB3mvUFNSGGdcBxIielc+oxMT0di+Ug7MkkVWoU
	Wg5P8GYG0Qolxrpon7hXILg3uwHKw0757LPNoKzaETgkx5VqfNTA5zm7lrz4gv0rue2qXx
	7uictRfLcR/zyRZbuPuz0lQEnZdNL78=
Date: Fri, 2 Jan 2026 11:35:39 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next] bpftool: Make skeleton C++ compatible with
 explicit casts
Content-Language: en-GB
To: WanLi Niu <kiraskyler@163.com>, Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 WanLi Niu <niuwl1@chinatelecom.cn>, Menglong Dong <dongml2@chinatelecom.cn>
References: <20251231092541.3352-1-kiraskyler@163.com>
 <20251231102929.3843-1-kiraskyler@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251231102929.3843-1-kiraskyler@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 12/31/25 2:29 AM, WanLi Niu wrote:
> From: WanLi Niu <niuwl1@chinatelecom.cn>
>
> Fix C++ compilation errors in generated skeleton by adding explicit
> pointer casts and using integer subtraction for offset calculation.
>
> error: invalid conversion from 'void*' to 'trace_bpf*' [-fpermissive]
>        |         skel = skel_alloc(sizeof(*skel));
>        |                ~~~~~~~~~~^~~~~~~~~~~~~~~
>        |                          |
>        |                          void*
>
> error: invalid use of 'void'
>        |         skel->ctx.sz = (void *)&skel->links - (void *)skel;
>
> Signed-off-by: WanLi Niu <niuwl1@chinatelecom.cn>
> Co-developed-by: Menglong Dong <dongml2@chinatelecom.cn>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

For llvm22, I hacked with core_kern_overflow.lskel.h and has the following
warning/errors:

In file included from prog_tests/core_kern_overflow.cc:4:
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/core_kern_overflow.lskel.h:65:9: error: assigning to
       'struct core_kern_overflow_lskel *' from incompatible type 'void *'
    65 |         skel = skel_alloc(sizeof(*skel));
       |                ^~~~~~~~~~~~~~~~~~~~~~~~~
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/core_kern_overflow.lskel.h:68:38: error: arithmetic on pointers to void
    68 |         skel->ctx.sz = (void *)&skel->links - (void *)skel;
       |                        ~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~

Your patch fixed the issue.

But for llvm side, I got the following two more errors:

/home/yhs/work/bpf-next/tools/testing/selftests/bpf/core_kern_overflow.lskel.h:73:15: error: assigning to
       'struct core_kern_overflow_lskel__bss *' from incompatible type 'void *'
    73 |                 skel->bss = skel_prep_map_data((void *)data, 4096,
       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    74 |                                                 sizeof(data) - 1);
       |                                                 ~~~~~~~~~~~~~~~~~
/home/yhs/work/bpf-next/tools/testing/selftests/bpf/core_kern_overflow.lskel.h:223:14: error: assigning to
       'struct core_kern_overflow_lskel__bss *' from incompatible type 'void *'
   223 |         skel->bss = skel_finalize_map_data(&skel->maps.bss.initial_value,
       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   224 |                                         4096, PROT_READ | PROT_WRITE, skel->maps.bss.map_fd);
       |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

So these two issues can be fixed similar to above skel_alloc() case.

Could you fix both of them?

> ---
>   tools/bpf/bpftool/gen.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 993c7d9484a4..71446a776130 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -731,10 +731,10 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>   		{							    \n\
>   			struct %1$s *skel;				    \n\
>   									    \n\
> -			skel = skel_alloc(sizeof(*skel));		    \n\
> +			skel = (struct %1$s *)skel_alloc(sizeof(*skel));    \n\
>   			if (!skel)					    \n\
>   				goto cleanup;				    \n\
> -			skel->ctx.sz = (void *)&skel->links - (void *)skel; \n\
> +			skel->ctx.sz = (__u64)&skel->links - (__u64)skel;   \n\
>   		",
>   		obj_name, opts.data_sz);
>   	bpf_object__for_each_map(map, obj) {


