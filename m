Return-Path: <bpf+bounces-50055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022D1A22547
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 21:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3591648B0
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 20:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4AB1E25FE;
	Wed, 29 Jan 2025 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pNbGK+GP"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A11DF979
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 20:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738184363; cv=none; b=IAht/fUwPy7LQWtHpfW7WgWRJj+VYPWMeWL54qOdeHw7qHdtN3p1ZR1C0lfPmtEjVvDHLPlO/mU3Xq+MLXSxp8HoVmeebh6jP98lOQn1gaJwqHIxGOHZqYxj2IEt0SFXwkYHMus/GO23vYm60Wdx9ihf8e7CA5MsDoI6NBzd02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738184363; c=relaxed/simple;
	bh=FNfIA3wa4FIwFZvQfK61DVFKd40O61ZMQ2IUoSkZ5hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3/dsyCiQqPW5lRFVN/WgncNTwa2YTuyhcPeB8SOrMBPeag5pMypYIwtJLv7CLKaAIdriyPZJ5XBpaRy37LbmSBSgOm8xI2wqSN4uKOWQBdYqt0eQ0W9DS29DVYFMBQI1wS1anMdkY4kL73DkBPxavJw7QWDMSsLjRujB0SLyHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pNbGK+GP; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0ed5524b-0338-45cf-9220-18a9d62cc263@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738184344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsCZgFBpLdhi6Ijj1lR6Glu3Hhh81/PJdxrfnauPggA=;
	b=pNbGK+GPKJkf1LsIhYz12+6QPL2QKk5XBFu9fqB6oRj17YELEdNcoUlQJKxPMjFErvXY30
	6uDR2lHJPfWX7QaRhrjRZc5HS+iwQgbaQMOFdwXIuA0c0VHLX/Zxr053FG8Lf618hBXUT1
	3Ambt+TlSedf2E6pdNmn2FvK8tkUL9U=
Date: Wed, 29 Jan 2025 12:58:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] ipv4, bpf: Introduced to support the ULP to get or
 set sockets
To: zhangmingyi <zhangmingyi5@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, yanan@huawei.com, wuchangye@huawei.com,
 xiesongyang@huawei.com, liuxin350@huawei.com, liwei883@huawei.com,
 tianmuyang@huawei.com
References: <20250127090724.3168791-1-zhangmingyi5@huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250127090724.3168791-1-zhangmingyi5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/27/25 1:07 AM, zhangmingyi wrote:
> We want call bpf_setsockopt to replace the kernel module in the TCP_ULP
> case. The purpose is to customize the behavior in connect and sendmsg.
> We have an open source community project kmesh (kmesh.net). Based on
> this, we refer to some processes of tcp fastopen to implement delayed
> connet and perform HTTP DNAT when sendmsg.In this case, we need to parse
> HTTP packets in the bpf program and set TCP_ULP for the specified socket.

The ulp could be a kernel module. Which ulp is needed in your use case?

> Note that tcp_getsockopt and tcp_setsockopt support TCP_ULP, while
> bpf_getsockopt and bpf_setsockopt do not support TCP_ULP.
> I'm not sure why there is such a difference, but I noticed that

You are right that bpf_get/setsockopt should be able to support most of the 
TCP_* optname.

After looking at tcp_set_ulp, I believe TCP_ULP is one of the few exceptions. I 
didn't drill down further and I stopped at __tcp_ulp_find_autoload which I 
believe it might_sleep. The BPF programs that support bpf_setsockopt cannot 
sleep. Take a look at how do_tcp_setsockopt(TCP_CONGESTION) is done.

pw-bot: cr

> tcp_setsockopt is called in bpf_setsockopt.I think we can add the
> handling of this case.
> 
> zhangmingyi (2):
>    ipv4, bpf: Introduced to support the ULP to get or set sockets
>    add selftest for TCP_ULP in bpf_setsockopt
> 
>   net/core/filter.c                             |  1 +
>   .../selftests/bpf/progs/setget_sockopt.c      | 21 ++++++++++++++++---
>   2 files changed, 19 insertions(+), 3 deletions(-)
> 


