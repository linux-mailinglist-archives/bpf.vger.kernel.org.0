Return-Path: <bpf+bounces-12161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FA37C8D7D
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 21:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4E91C21280
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 19:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450A121A17;
	Fri, 13 Oct 2023 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gzNszQcc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27CFEC6;
	Fri, 13 Oct 2023 19:06:53 +0000 (UTC)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383AE83;
	Fri, 13 Oct 2023 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697224013; x=1728760013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=he7EuLQE2J6ALW3zxIo3s6w071Tk72Yp4IF1VczmS5I=;
  b=gzNszQccYFtm0iFUfZZ6noBkLrqD/wl0w/u0UmU9F2IQGdB1RPwq/moP
   4Tx9E40mgHVYl8Y/YK63aaAr9vG4xKCfeAh4xnkfON3D9QEStKw6e4+2B
   99XzCRKEFjgkSg164qqoHo5+H1i0/OZbQ1FjNTQ6Ype3DN7CiMubQnVaA
   w=;
X-IronPort-AV: E=Sophos;i="6.03,223,1694736000"; 
   d="scan'208";a="245469703"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 19:06:50 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
	by email-inbound-relay-iad-1a-m6i4x-54a853e6.us-east-1.amazon.com (Postfix) with ESMTPS id 2925348808;
	Fri, 13 Oct 2023 19:06:48 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 13 Oct 2023 19:06:42 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.37;
 Fri, 13 Oct 2023 19:06:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daan.j.demeyer@gmail.com>, <daniel@iogearbox.net>, <kernel-team@meta.com>,
	<netdev@vger.kernel.org>, <sfr@canb.auug.org.au>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH bpf-next] net/bpf: Avoid unused "sin_addr_len" warning when CONFIG_CGROUP_BPF is not set
Date: Fri, 13 Oct 2023 12:06:23 -0700
Message-ID: <20231013190623.46904-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231013185702.3993710-1-martin.lau@linux.dev>
References: <20231013185702.3993710-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.60]
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Fri, 13 Oct 2023 11:57:02 -0700
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> It was reported that there is a compiler warning on the unused variable
> "sin_addr_len" in af_inet.c when CONFIG_CGROUP_BPF is not set.
> This patch is to address it similar to the ipv6 counterpart
> in inet6_getname(). It is to "return sin_addr_len;"
> instead of "return sizeof(*sin);".
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/bpf/20231013114007.2fb09691@canb.auug.org.au/
> Cc: Daan De Meyer <daan.j.demeyer@gmail.com>
> Fixes: fefba7d1ae19 ("bpf: Propagate modified uaddrlen from cgroup sockaddr programs")
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> ---
>  net/ipv4/af_inet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 7e27ad37b939..5ce275b2d7ef 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -814,7 +814,7 @@ int inet_getname(struct socket *sock, struct sockaddr *uaddr,
>  	}
>  	release_sock(sk);
>  	memset(sin->sin_zero, 0, sizeof(sin->sin_zero));
> -	return sizeof(*sin);
> +	return sin_addr_len;
>  }
>  EXPORT_SYMBOL(inet_getname);
>  
> -- 
> 2.34.1

