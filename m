Return-Path: <bpf+bounces-61045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 703BAAE0045
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F4018983C7
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E622E266573;
	Thu, 19 Jun 2025 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="KhOTjIus"
X-Original-To: bpf@vger.kernel.org
Received: from dane.soverin.net (dane.soverin.net [185.233.34.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0F265630;
	Thu, 19 Jun 2025 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322731; cv=none; b=r6FtnICMKZ3ij0ppYTVnnBymf+uT72Oca5BrAxNDuB6H4a0HoTlmFTFL33GmftBY/lsFZ0eK/LnM4PlzGuwQo+0Fm3vgdnassEYKZBuhN8DSKTccB1R/OR/YoULvk8nR65Y4lPH+BHridKyHDI/CrDq5WY2mYyWsl+Wimm7S8nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322731; c=relaxed/simple;
	bh=XLG2cZcQLhx33DVj14NNeTv+QvUPGw8VQgW7jRag7q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFC6CEHXnw5I0q/K/zBTSHDCiGbZWoo/aeWtwQjEQLz71esIIMDDdxYCVixpW4RC8seXJSOW+L2JjsNY4zhgDd4qQzC4/rMUE3yFruGB8OAstfA1OHuFWFMysNPRayyIRjBcGTfjVm5XTUjNo0rQgGnA5s67Zgyyku8gSvkLL6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=KhOTjIus; arc=none smtp.client-ip=185.233.34.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Received: from smtp.soverin.net (unknown [10.10.4.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by dane.soverin.net (Postfix) with ESMTPS id 4bNDhH6KQpz1HSZ;
	Thu, 19 Jun 2025 08:45:19 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.100]) by soverin.net (Postfix) with ESMTPSA id 4bNDhH2XXSzQ4;
	Thu, 19 Jun 2025 08:45:19 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=KhOTjIus;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1750322719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ErW2j+mManyJQM93IRatKSVT+nS/i3cLFDxhg+A0SH4=;
	b=KhOTjIus5IhKLEu3NQgD51ii5zQKI2gZ8O/ya1kD4Nt36TT2aqkVZ75BZKwRvFqHg4kwc0
	jBXNadfybHvHhOuyb4Zl0FAiVBZxPfVpc+zWkcXOhVEuKtTMqeht0ithVDAL0IhiEJLmFW
	KjvFARXu4XckZfUyvlN4e6B51vIkUm7YwgJtSnxAmfQGX0YmslfqC/m1QQa3GPc9bQ2mbu
	gQHPPM42yJvKaxkoFozd/cjtAgbfQpAy7sX3TAdteoB0XAKFE4975H85KXR/PHLe8EQ2eq
	ZNo6YceLirVVsJYKOf5LbNe/jntEjvQoPD3FDGNghgCzvCx6pjhnKARZmvB/+Q==
X-CM-Analysis: v=2.4 cv=UsCZN/wB c=1 sm=1 tr=0 ts=6853ce1f a=IkcTkHD0fZMA:10 a=Byx-y9mGAAAA:8 a=VwQbUJbxAAAA:8 a=alrKA13-IdtXP1y8yCkA:9 a=QEXdDO2ut3YA:10
Message-ID: <e938ef54-3ea0-4325-9860-477561af6042@qmon.net>
Date: Thu, 19 Jun 2025 09:45:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATH v2] bpftool: Fix memory leak in dump_xx_nlmsg on realloc
 failure
To: chenyuan <chenyuan_fl@163.com>, ast@kernel.org, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 chenyuan <chenyuan@kylinos.cn>
References: <20250619031037.39068-1-chenyuan_fl@163.com>
 <20250619065713.65824-1-chenyuan_fl@163.com>
From: Quentin Monnet <qmo@qmon.net>
Content-Language: en-GB
In-Reply-To: <20250619065713.65824-1-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham

2025-06-19 14:57 UTC+0800 ~ chenyuan <chenyuan_fl@163.com>
> From: chenyuan <chenyuan@kylinos.cn>
> 
> In function dump_xx_nlmsg(), when realloc() fails to allocate memory,
> the original pointer to the buffer is overwritten with NULL. This causes
> a memory leak because the previously allocated buffer becomes unreachable
> without being freed.
> 
> Fix: 7900efc19214 ("tools/bpf: bpftool: improve output format for bpftool net")


Fixes: 7900efc19214 ("tools/bpf: bpftool: improve output format for bpftool net")

(Not "Fix:")


> Signed-off-by: chenyuan <chenyuan@kylinos.cn>
> ---
>  tools/bpf/bpftool/net.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index 64f958f437b0..1abedfe6f33f 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -366,17 +366,18 @@ static int dump_link_nlmsg(void *cookie, void *msg, struct nlattr **tb)
>  {
>  	struct bpf_netdev_t *netinfo = cookie;
>  	struct ifinfomsg *ifinfo = msg;
> +	struct ip_devname_ifindex *tmp;
>  
>  	if (netinfo->filter_idx > 0 && netinfo->filter_idx != ifinfo->ifi_index)
>  		return 0;
>  
>  	if (netinfo->used_len == netinfo->array_len) {
> -		netinfo->devices = realloc(netinfo->devices,
> -			(netinfo->array_len + 16) *
> +		tmp = realloc(netinfo->devices, (netinfo->array_len + 16) *
>  			sizeof(struct ip_devname_ifindex));


Nit: Can you please break the line after the comma rather than after the '*' sign,
like in dump_class_qdisc_nlmsg()?

Otherwise looks good, thanks for this! You can add my tag for v3:

Reviewed-by: Quentin Monnet <qmo@kernel.org>

