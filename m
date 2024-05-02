Return-Path: <bpf+bounces-28485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A558BA424
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 01:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98B51F216E1
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 23:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE860157A5B;
	Thu,  2 May 2024 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oo2UZqqe"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103E0153501
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714693158; cv=none; b=gEZCscqEXPuuJ9C+JQ+gy8vS657Zc0QXX64Z7AAJhcZqMfeufusTPw2h1GINiyQ9JZBfomaODBz7545mZ+iFfyfL2Yl/LVRIFGmYlFCHvYPmu927e0Mj3hs/8uEiaJYSFaZLL5T/ArjVUCPJafSOcj5tF8up0kFmzkcLNbBhC5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714693158; c=relaxed/simple;
	bh=GK9xI1MmSlOzhapTknrbKNCbWi3Zk586qJQBqrNAhDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YG4zTUS4BHn2IYtHSIxoFbaqz5+vNP82ZgMN0sc2q0tfIfLifmWOQWfh4k0GmkaHhjWyYvByxScB7D2RH1KdKPS8eDnqbF3Hi6ZQLMfxBoWWPBh2Fr2sUqex2kfyrBBfFyUebL5ra4kGTtRT5c6+oyDQcCk8UXNOmwhIv5KkKJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oo2UZqqe; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc051219-5da9-4de9-87fc-82db4c870c3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714693155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+OYu68/VM5ElvGQT9jeiRSgGoDTW9xL8fqocP25lQo=;
	b=oo2UZqqeSiMX7jWWokh3AhyW36QZ46ZcR0gmtWbMcYw+86bzvQjDGiMgD0zQoecdwbgCMH
	3HRDKRdJg+8FRvBe1od249uuJEmlwX7MVbHdwi4tkaDgrq8CiQEJSBWU34w+yVqN3jOCF+
	T3pQN/PHnJu8cUjxHgBhfoDobOQiBe4=
Date: Thu, 2 May 2024 16:39:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 3/3] selftests/bpf: Add test for the use of
 new args in cong_control
To: Miao Xu <miaxu@meta.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Martin Lau <kafai@meta.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20240502042318.801932-1-miaxu@meta.com>
 <20240502042318.801932-4-miaxu@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240502042318.801932-4-miaxu@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/1/24 9:23 PM, Miao Xu wrote:
> This patch adds a selftest to show the usage of the new arguments in
> cong_control. For simplicity's sake, the testing example reuses cubic's
> kernel functions.
> ---
> Changes in v3:
> * Renamed the selftest file and the bpf struct_ops' name.
> * Minor changes such as removing unused comments.
> 
> Changes in v2:
> * Added highlights to explain major differences between the bpf program
> and tcp_cubic.c.
> * bpf_tcp_helpers.h should not be further extended, so remove the
>    dependency on this file. Use vmlinux.h instead.
> * Minor changes such as indentation.
> 
> Signed-off-by: Miao Xu <miaxu@meta.com>
> ---
>   .../selftests/bpf/progs/bpf_cc_cubic.c        | 206 ++++++++++++++++++

I just noticed that the bpf_cc_cubic is not run by the test_progs. I have added 
a test to prog_tests/bpf_tcp_ca.c to do that.

I also fixed up your SOB.

Applied. Thanks.

>   .../selftests/bpf/progs/bpf_tracing_net.h     |  10 +
>   2 files changed, 216 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c


