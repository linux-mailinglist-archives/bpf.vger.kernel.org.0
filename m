Return-Path: <bpf+bounces-19546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7211182DC20
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 16:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14669282B73
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AEA17736;
	Mon, 15 Jan 2024 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZtTytVJd"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D64617735
	for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8af7e87c-1103-44b7-a0eb-1a28f52666a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705331380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1RAzsObhWQcy5g3DxlUhOtHaPAsORF3Ds9Wu0FjLK8=;
	b=ZtTytVJdZCf0y6ujpjh7XuO/8Qvzc0GBeVmmZudKrW6OXXI3g7qHEnYPfEVgqcX8e0r3ir
	IDNLjqjNFuYugi/QET2+gows2CivaGzJ3+pLQuIdcDp2PJRu91jYJ6mBmgA8gpQn2whnAb
	1IgtkngoGgId9D+WCYk657RnvkTOtgc=
Date: Mon, 15 Jan 2024 07:09:34 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: flaky tc_redirect/tc_redirect_dtime
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <CAADnVQJ_Xwk7xp-AybVC7dtSqRnbo1Lkw1Y+vQ+_w6UJTPvhKw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>
In-Reply-To: <CAADnVQJ_Xwk7xp-AybVC7dtSqRnbo1Lkw1Y+vQ+_w6UJTPvhKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/13/24 1:09 PM, Alexei Starovoitov wrote:
> Hi Martin,
> 
> I remember you tried to fix tc_redirect/tc_redirect_dtime flakiness,
> but it is still flaky.
> Just running test_progs -t tc_redirect/tc_redirect_dtime
> in a loop it will fail after 30-50 iterations in my VM and always with:
> 
> test_inet_dtime:PASS:setns src 0 nsec
> (network_helpers.c:253: errno: Operation now in progress) Failed to
> connect to server
> close_netns:PASS:setns 0 nsec
> test_inet_dtime:FAIL:connect_to_fd unexpected connect_to_fd: actual -1
> < expected 0
> 
> I've added this hack:
> +again:
>          nstoken = open_netns(NS_SRC);
>          if (!ASSERT_OK_PTR(nstoken, "setns src"))
>                  goto done;
> @@ -573,6 +575,11 @@ static void test_inet_dtime(int family, int type,
> const char *addr, __u16 port)
>          if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
>                  goto done;
> 
> +       if (i++ < 1000 && 0) {
> +               printf("XXXX %d\n", i);
> +               close(client_fd);
> +               goto again;
> +       }
> 
> and realized that only the first connect can succeed.
> The 2nd connect always fails.
> So I suspect bpf prog sees first stray packet, acts on it,
> but the actual connect request comes 2nd and it fails.
> 
> I tried to understand what's going on inside bpf prog,
> but the test is too complicated.
> Please take a look when you have a chance.
> 
> I also added:
> @@ -857,7 +864,7 @@ static void test_tc_redirect_dtime(struct
> netns_setup_result *setup_result)
>                  goto done;
> 
>          test_tcp_clear_dtime(skel);
> -
> +if (0) {
>          test_tcp_dtime(skel, AF_INET, true);
>          test_tcp_dtime(skel, AF_INET6, true);
>          test_udp_dtime(skel, AF_INET, true);
> @@ -878,7 +885,7 @@ static void test_tc_redirect_dtime(struct
> netns_setup_result *setup_result)
>          test_tcp_dtime(skel, AF_INET6, false);
>          test_udp_dtime(skel, AF_INET, false);
>          test_udp_dtime(skel, AF_INET6, false);
> -
> +}
> to speed up a test a bit.

Thanks for the tips to reproduce it. I will look into it.


