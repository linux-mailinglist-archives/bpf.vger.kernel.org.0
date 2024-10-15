Return-Path: <bpf+bounces-42021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA5499E91E
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812581F236AA
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 12:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947B11F4FBD;
	Tue, 15 Oct 2024 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY2EWXdA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168251EBA12;
	Tue, 15 Oct 2024 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994318; cv=none; b=g/OGfOExH61Z7N00+ZjiaCLiEa7MzCF6Dp+Clbs+2uuhzIZnnDmbGDQPZkJLf1+ecBsZ3fLPImd06NU1RnrYah9d2zQv5Ua16yULov5+VpPTU75hWHpGZD8E2AeQoHNCRbB0DjDtWmUNW85s20vymd0UhzitumVuO2KQL7aDZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994318; c=relaxed/simple;
	bh=L9y9LhgVbtXtCJLQ+SqlqMstU/OUmA+S4rCHfFpeW9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzmPQI9QVKIjZRk6XvD1x4rSrzeLVmSr1vqdL+gQhIXHWcMvYaTaslsORDS8Q16g/FyQRydeJUBO2j1xEg5q8sNyaDVZ4lCVLcpenVoeUnlD+PXFjji5aL9EUlufsuJ4/uv8QhLGYRHMPE52XuL7iVZMFAY4sGEThAVpW/rW1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY2EWXdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC27C4CECF;
	Tue, 15 Oct 2024 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728994317;
	bh=L9y9LhgVbtXtCJLQ+SqlqMstU/OUmA+S4rCHfFpeW9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DY2EWXdAox7pZL9DABK9p6Cs6SLUFc6tl1csk/KCkp4j6vcFKtWVyCo8lJ5cyrctL
	 7p2sBh6vMu4WRYnGNoKG3QixDqLRYYoZqdk4Vnsupwc2X4y4/V5E6P0s+Req4gsmGE
	 g5xF+XgvTF0NCFA3SoVObE1T6mvdTAvU2gryxBQiZ4LqiSxrYtZlwWRR1jTkn+Vyaj
	 Wpy9lbQK18xg4fH3qBzR75Ork6wFFNGswShjyudt8ZSax6RBEt1mzPE5o0IsxoIWOm
	 K+mNH7keZsaVLE/vfzBUijZoWWHj5yfW1WlUB1BYuO5PEUGSMDqAQT98eq1ucpZ4M0
	 An6e9zP1Kkjug==
Message-ID: <fe9261d8-1e1d-4060-9a7e-1902d75cff7a@kernel.org>
Date: Tue, 15 Oct 2024 13:11:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: optimize if statement code
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241015110944.6975-1-liujing@cmss.chinamobile.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241015110944.6975-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

2024-10-15 19:09 UTC+0800 ~ Liu Jing <liujing@cmss.chinamobile.com>
> Since both conditions are used to check whether len is valid, we can combine the two conditions into a single if statement
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> ---
>   tools/bpf/bpftool/feature.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index 4dbc4fcdf473..0121e0fd6949 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c
> @@ -158,10 +158,9 @@ static int get_vendor_id(int ifindex)
>   
>   	len = read(fd, buf, sizeof(buf));
>   	close(fd);
> -	if (len < 0)
> -		return -1;
> -	if (len >= (ssize_t)sizeof(buf))
> +	if ((len < 0) || (len >= (ssize_t)sizeof(buf)))
>   		return -1;
> +
>   	buf[len] = '\0';
>   
>   	return strtol(buf, NULL, 0);


Thanks. I'm not strictly opposed to the change, but it doesn't bring 
much value in my opinion. I don't think this will "optimize" the 
statement beyond what the compiler does already.

Quentin

