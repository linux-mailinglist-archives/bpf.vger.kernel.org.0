Return-Path: <bpf+bounces-38212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4D0961968
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 23:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D132284D71
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 21:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699041D318A;
	Tue, 27 Aug 2024 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HC9rXyD4"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA317BEB4
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795412; cv=none; b=qEEHRCVU9BXWqSEimqLw5xP8mgR0KajSjtJlPcTLPvktfByRTTc1lYDFtS95GO7Et8yZ2X4+8CEG/se3ExSIH0h7Lq0jzfiNeibjus8CHk+XjX3fOH/8ltuuOiJl/uraiIlz7D0SrzTGezA9KCDXvdbEnAOTd3v8Kp5WCFD0VeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795412; c=relaxed/simple;
	bh=tTKMCtqcRQnlf/R1QbtO4jJc4MOD7HlcnhfsMdD+RX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwr5XcFxI2dJhGvcKd9qlRMBTnVNsW2+BpCyj1PK3Wa55C6V5aq1BIXy+MN/wCfAL6XWEBJClrDG5lByPJjwjjn+L8Qd54MxicN45ztyPnr8eRoEGi8XZs0kNo2SuhKG5VMdY5o/SYrEbw4bcBvL8SP3jPe4p0SvOTzsKw9kCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HC9rXyD4; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <92e329ec-b504-48fa-9ef8-83efa7e5ba6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724795408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W05anCFasN/rlTR1bYlC+7NpJpgRKnC+hsl8vBTHAyA=;
	b=HC9rXyD4D2mP7V8B+HDDJ+pi7ZI3Kp5tegOPBSQl2W5Ih6i5ffeLUBMlj3KBgJUmwFicy+
	4W6GMXHB6UHcxXnXtuX0oCPQOHhkgK+7NRIVpnwQ3rBbPZONAUgQdBLpoddKgHt6f7C7AU
	ujIw+tr1OjIyPf9Ero4IbbC80kPjmaY=
Date: Tue, 27 Aug 2024 14:50:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch net-next] tcp_bpf: remove an unused parameter for
 bpf_tcp_ingress()
To: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
 Yaxin Chen <yaxin.chen1@bytedance.com>, netdev@vger.kernel.org
References: <20240823224843.1985277-1-yaxin.chen1@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240823224843.1985277-1-yaxin.chen1@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/23/24 3:48 PM, Yaxin Chen wrote:
> Parameter flags is not used in bpf_tcp_ingress().
> 
> Reviewed-by: Cong Wang <cong.wang@bytedance.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Yaxin Chen <yaxin.chen1@bytedance.com>
> ---
>   net/ipv4/tcp_bpf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 53b0d62fd2c2..57a1614c55f9 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -30,7 +30,7 @@ void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
>   }
>   
>   static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
> -			   struct sk_msg *msg, u32 apply_bytes, int flags)
> +			   struct sk_msg *msg, u32 apply_bytes)
>   {
>   	bool apply = apply_bytes;
>   	struct scatterlist *sge;
> @@ -167,7 +167,7 @@ int tcp_bpf_sendmsg_redir(struct sock *sk, bool ingress,
>   	if (unlikely(!psock))
>   		return -EPIPE;
>   
> -	ret = ingress ? bpf_tcp_ingress(sk, psock, msg, bytes, flags) :
> +	ret = ingress ? bpf_tcp_ingress(sk, psock, msg, bytes) :

lgtm also. John and Jakub Sitnicki, please help to take a look and Ack if this 
looks good to you also.

>   			tcp_bpf_push_locked(sk, msg, bytes, flags, false);
>   	sk_psock_put(sk, psock);
>   	return ret;


