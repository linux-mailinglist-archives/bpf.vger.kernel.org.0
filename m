Return-Path: <bpf+bounces-37215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989699524D1
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 23:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543212889A3
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 21:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BD21C824F;
	Wed, 14 Aug 2024 21:31:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4721A7346D
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723671117; cv=none; b=PEMExPqxp/MJJhhSMoFv+RRl1Iiup6EblsVXqW4apXtYM+Kk1dZ9WC7tBWaOy343gMVB9ItBSv++3JZ4PX3FrKZm78/Ma9bmFZz97pmJWlvYstLojvL/nKh0CxKnvU3w8gAzK1/KwBCc8sKBD+JQZEKfGRkCyVMPL+SsK5EEi20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723671117; c=relaxed/simple;
	bh=xfEBLG4z8nZQGFB1Jw+jIczsBqp+PVT9lc1UGJEzzdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AixJ1EF5dkUVEzfvwxKgqGu8dCuVvaGd3l/qEsMhxa2RvuvGW0WF/t2UzpB8AEd2j9HPLsDNbuZGbQHGpLnFKlyX4xpfLyjsDMty5UwTqqeerRU5RmzIBpqRury+4Vb5/mAfdKPGcz7V5RJK5x3YCL3hp1yFDrdyvGj5Q0GuBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-pmh1yFBwNIyWfEv750N8oA-1; Wed,
 14 Aug 2024 17:30:31 -0400
X-MC-Unique: pmh1yFBwNIyWfEv750N8oA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3997718EB234;
	Wed, 14 Aug 2024 21:30:28 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C94F196BE80;
	Wed, 14 Aug 2024 21:30:19 +0000 (UTC)
Date: Wed, 14 Aug 2024 23:30:17 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, dsahern@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Subject: Re: [PATCH] bpf: Fix bpf_get/setsockopt to tos not take effect when
 TCP over IPv4 via INET6 API
Message-ID: <Zr0h6a_ExRhw8Mxh@hog>
References: <20240814084504.22172-1-zhoufeng.zf@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240814084504.22172-1-zhoufeng.zf@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

2024-08-14, 16:45:04 +0800, Feng zhou wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78a6f746ea0b..9798537044be 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5399,7 +5399,7 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
>  			  char *optval, int *optlen,
>  			  bool getopt)
>  {
> -	if (sk->sk_family != AF_INET)
> +	if (sk->sk_family != AF_INET && !is_tcp_sock_ipv6_mapped(sk))
>  		return -EINVAL;

I don't think this works when CONFIG_IPV6=m, because then
is_tcp_sock_ipv6_mapped will be part of the module and not usable in
net/core/filter.c. Stuff like this is usually done through ipv6_stub.

-- 
Sabrina


