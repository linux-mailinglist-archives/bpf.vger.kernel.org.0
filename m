Return-Path: <bpf+bounces-42490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF69A9A4A5A
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 01:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4BC286A51
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 23:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F14191F8F;
	Fri, 18 Oct 2024 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YkdOtbVo"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D91917EE
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729295857; cv=none; b=rLjhiorQpktj/l+B5Fw+cqXMWseenG/PTmnC9ParLqNQBNKO5nl8a1wPF2beiS4SBeoEtMHLCB42GSnUpEqKGwF9Y5in0iKW+v8grcxeloNowOv20LPkjAKBfkIaqspbIcC1A08JqGWs7WKok9Fzze73mxs4Ohn3utB+1Jf8sXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729295857; c=relaxed/simple;
	bh=/LHSdJHkp1l77T+lIpZRGhDuFNKfe0atYWZA1rVZ40s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1m4iPQP5LLwWgUMJ1UR+1KcukOrG+BPKcuVI62K7Hsp63yXd/fmQmg8NCbipqxqq2KWOszvhHEVay5YOWu7Uai/fRlZz4FymY7ycKesPQKUu5mBBmS0LJCZmTF+ibNlhxX5CNJUdiHJisP4/WRNqZgdsOSR3LQD2WXj6ePuGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YkdOtbVo; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <18cb274a-a214-42c0-bcec-cbda34703893@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729295852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amGDfV5HdFNuReXcjkk4EaaJ7Bh/Ri0Tvnzi7osykXQ=;
	b=YkdOtbVocWMr74bXPrrLp9BXcB80E0e5dh/zolhPL4gFKP1jxrWrisN/Xcmy2DHXt5jvcY
	2vCJQMHWqVSCTDu2oqd+UWEY/gJy/Y3KRsG6aRqAY0m8jYcLpyGDWTvuOPzF7iRMeGmhKB
	C4twQLIBTLFaAYtP4NjNTPvkMeW5hOg=
Date: Fri, 18 Oct 2024 16:57:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/6] selftests/bpf: add missing ns cleanups in
 btf_skc_cls_ingress
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lorenz Bauer <lmb@cloudflare.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241016-syncookie-v1-0-3b7a0de12153@bootlin.com>
 <20241016-syncookie-v1-2-3b7a0de12153@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241016-syncookie-v1-2-3b7a0de12153@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/16/24 11:35 AM, Alexis Lothoré (eBPF Foundation) wrote:
> btf_skc_cls_ingress.c currently runs two subtests, and create a
> dedicated network namespace for each, but never cleans up the created
> namespace once the test has ended.
> 
> Add missing namespace cleanup after each namespace to avoid accumulating
> namespaces for each new subtest. While at it, switch namespace
> management to netns_{new,free}
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
>   .../selftests/bpf/prog_tests/btf_skc_cls_ingress.c | 31 ++++++++++++++--------
>   1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
> index 5d8d7736edc095b647ca3fbc12cac0440b60140e..8d1fa8806cdda088d264b44104f7c80726b025e2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
> @@ -17,32 +17,34 @@
>   #include "test_progs.h"
>   #include "test_btf_skc_cls_ingress.skel.h"
>   
> +#define TEST_NS "skc_cls_ingress"
> +
>   static struct test_btf_skc_cls_ingress *skel;
>   static struct sockaddr_in6 srv_sa6;
>   static __u32 duration;
>   
> -static int prepare_netns(void)
> +static struct netns_obj *prepare_netns(void)
>   {
>   	LIBBPF_OPTS(bpf_tc_hook, qdisc_lo, .attach_point = BPF_TC_INGRESS);
>   	LIBBPF_OPTS(bpf_tc_opts, tc_attach,
>   		    .prog_fd = bpf_program__fd(skel->progs.cls_ingress));
> +	struct netns_obj *ns = NULL;
>   
> -	if (CHECK(unshare(CLONE_NEWNET), "create netns",
> -		  "unshare(CLONE_NEWNET): %s (%d)",
> -		  strerror(errno), errno))
> -		return -1;
> +	ns = netns_new(TEST_NS, true);
> +	if (!ASSERT_OK_PTR(ns, "create and join netns"))
> +		return ns;
>   
>   	if (CHECK(system("ip link set dev lo up"),
>   		  "ip link set dev lo up", "failed\n"))

nit. netns_new() takes care of "lo up" also, so the above can be removed.

test_progs.c has restore_netns() after each test, so the netns was not cleaned 
up. The second unshare should have freed the earlier netns also.

Using netns_new() removed the boiler plate codes. It is nice to see this change 
here regardless.

> -		return -1;
> +		goto free_ns;
>   
>   	qdisc_lo.ifindex = if_nametoindex("lo");
>   	if (!ASSERT_OK(bpf_tc_hook_create(&qdisc_lo), "qdisc add dev lo clsact"))
> -		return -1;
> +		goto free_ns;
>   
>   	if (!ASSERT_OK(bpf_tc_attach(&qdisc_lo, &tc_attach),
>   		       "filter add dev lo ingress"))
> -		return -1;
> +		goto free_ns;
>   
>   	/* Ensure 20 bytes options (i.e. in total 40 bytes tcp header) for the
>   	 * bpf_tcp_gen_syncookie() helper.
> @@ -50,9 +52,13 @@ static int prepare_netns(void)
>   	if (write_sysctl("/proc/sys/net/ipv4/tcp_window_scaling", "1") ||
>   	    write_sysctl("/proc/sys/net/ipv4/tcp_timestamps", "1") ||
>   	    write_sysctl("/proc/sys/net/ipv4/tcp_sack", "1"))
> -		return -1;
> +		goto free_ns;
> +
> +	return ns;
>   
> -	return 0;
> +free_ns:
> +	netns_free(ns);
> +	return NULL;
>   }



