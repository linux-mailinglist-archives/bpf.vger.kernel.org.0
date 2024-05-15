Return-Path: <bpf+bounces-29763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C0F8C673F
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 15:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64C81F23E79
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 13:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D5C8595C;
	Wed, 15 May 2024 13:22:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D014AB4
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779349; cv=none; b=ZmLV5UWq4v0dNGlV150I9GvUzJpJs9U6wQL5rNlo4/vJnZ47oFQv4PsPmR7d8sGMNqOJNOfRxwRaS/nPrtZMVRfetyc7l5l7oE5uE9oEr0gdw6DTh3ZsvXaQQXIM5RfmkuIj3nHOy04loUX2/cDu/SoKwgPJ7y8YJvDwmelcE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779349; c=relaxed/simple;
	bh=RJnqrLOgZUrBJQdEuSpIRPT7WLVXp1L28Dwu+Iwbyzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=inupMEa1Mo6NXDJHNvIxb2V0g5RXPAeWRVhOzAo/rGiX5yVvCnIgcMWLBBLYmTjx0ai1lxoVtatCUFv/irs97wq9pshhNnei4mNHkJElcfHYxKw3ZTVRtZnthG3SgXBiE6t3B5LLtjJVMXJjnfb8H+go2eZWI+ZEwwCFEWRVo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VfYlC2fLYzCrsW;
	Wed, 15 May 2024 21:21:11 +0800 (CST)
Received: from kwepemd100012.china.huawei.com (unknown [7.221.188.214])
	by mail.maildlp.com (Postfix) with ESMTPS id B83D2180080;
	Wed, 15 May 2024 21:22:25 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemd100012.china.huawei.com (7.221.188.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 15 May 2024 21:22:25 +0800
Message-ID: <2fc3b4da-7218-4a79-aef3-152297c37926@huawei.com>
Date: Wed, 15 May 2024 21:22:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] MAINTAINERS: Update ARM64 BPF JIT maintainer
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, <bpf@vger.kernel.org>, Zi Shen Lim
	<zlim.lnx@gmail.com>
CC: <puranjay12@gmail.com>
References: <20240514183914.27737-1-puranjay@kernel.org>
Content-Language: en-US
From: Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <20240514183914.27737-1-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100012.china.huawei.com (7.221.188.214)

On 5/15/2024 2:39 AM, Puranjay Mohan wrote:
> Zi Shen Lim is not actively doing kernel development and has decided to
> tranfer the responsibility of maintaining the JIT to me.
> 
> Add myself as the maintainer for BPF JIT for ARM64 and remove Zi Shen
> Lim.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Zi Shen Lim <zlim.lnx@gmail.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 05720fcc95cb..95beaf4dccf7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3722,7 +3722,7 @@ F:	arch/arm/net/
>   BPF JIT for ARM64
>   M:	Daniel Borkmann <daniel@iogearbox.net>
>   M:	Alexei Starovoitov <ast@kernel.org>
> -M:	Zi Shen Lim <zlim.lnx@gmail.com>
> +M:	Puranjay Mohan <puranjay@kernel.org>
>   L:	bpf@vger.kernel.org
>   S:	Supported
>   F:	arch/arm64/net/

Ah, I've been working on arm64 bpf jit since 2 years ago, added arm64 bpf
trampoline, cpuv4 insns, and helped to review patches. I would appreciate
it if I could be also added as a reviewer or maintainer.

