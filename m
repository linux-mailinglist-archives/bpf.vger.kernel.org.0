Return-Path: <bpf+bounces-43274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A069B24C9
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 06:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309AE1C21153
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 05:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7D418DF64;
	Mon, 28 Oct 2024 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WVu/3owU"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CE18C924
	for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095148; cv=none; b=Y5y6/roBDURtjOMymX9La0sUbxfeJpdoOagN/NaL5978gjHo2YgnXEaGRrT7h3ldQKXpRHKzShheUsD9nQ1DrUuzrkjPQrgX7NG5OgqpR1baxeJT99zcpMK9EvK5TNau67jh9mzLx46gI5uJVXD5Ozj4xLLnUSx6xS5nV8xz+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095148; c=relaxed/simple;
	bh=GyHy2ehMiq0kSfxmRoAo1MH2MwYdvN/RRAYfkPXzTwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eckg14+ElOycNKt9lL+rfSrxS00tyO7K4H5IJmuB4i/pAsdZZNL6ZULeVjB7PM3GO+oEzODPCfC/8i1WHCTkcoSvxAbybzfVBeyJmfKlbmmH1HIbfIWeMiNjswPNVp7Q6MKA4VW9endn1Gw74YSYrbY+ErVIuM8uX40NDW3mWqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WVu/3owU; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9117f014-3ad3-4d9a-9357-4b57d376c660@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730095142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xFVZGR7EERaxw8wCgEoCpv+J0X7JC4VBGETy3usqJSY=;
	b=WVu/3owUA3h9p48LY+zfyilS6UtV9vUVknKJc8gkGgURcTNPLMJhfaw2Baqq9CE1p0fSUK
	bL6MTKKhlKD7Z+xgzdjQG7y4Hi0/z5mnOoqz3pyLv6AhRf2HmpwAhktq3PAu7Re9aQ+KOu
	4NL67pe6ZMj7KxukFQPImEGAjMG+dmc=
Date: Sun, 27 Oct 2024 22:58:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch bpf] sock_map: fix a NULL pointer dereference in
 sock_map_link_update_prog()
Content-Language: en-GB
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
 Ruan Bonan <bonan.ruan@u.nus.edu>, John Fastabend
 <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
References: <20241026185522.338562-1-xiyou.wangcong@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241026185522.338562-1-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/26/24 11:55 AM, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> The following race condition could trigger a NULL pointer dereference:
>
> sock_map_link_detach():		sock_map_link_update_prog():
>     mutex_lock(&sockmap_mutex);
>     ...
>     sockmap_link->map = NULL;
>     mutex_unlock(&sockmap_mutex);
>     				   mutex_lock(&sockmap_mutex);
> 				   ...
> 				   sock_map_prog_link_lookup(sockmap_link->map);
> 				   mutex_unlock(&sockmap_mutex);
>     <continue>
>
> Fix it by adding a NULL pointer check. In this specific case, it makes
> no sense to update a link which is being released.
>
> Reported-by: Ruan Bonan <bonan.ruan@u.nus.edu>
> Fixes: 699c23f02c65 ("bpf: Add bpf_link support for sk_msg and sk_skb progs")
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>   net/core/sock_map.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 07d6aa4e39ef..9fca4db52f57 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1760,6 +1760,10 @@ static int sock_map_link_update_prog(struct bpf_link *link,
>   		ret = -EINVAL;
>   		goto out;
>   	}
> +	if (!sockmap_link->map) {
> +		ret = -EINVAL;

Thanks for the fix. Maybe we should use -ENOENT as the return error code?
In this case, update_prog failed due to sockmap_link->map == NULL which is
equivalent to no 'entry' to update.

> +		goto out;
> +	}
>   
>   	ret = sock_map_prog_link_lookup(sockmap_link->map, &pprog, &plink,
>   					sockmap_link->attach_type);

