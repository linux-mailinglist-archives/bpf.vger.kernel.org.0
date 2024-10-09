Return-Path: <bpf+bounces-41320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD52995C9C
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 02:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFDE284659
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 00:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922E318EBF;
	Wed,  9 Oct 2024 00:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="L/ZtzLJH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07D2EAD2;
	Wed,  9 Oct 2024 00:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435553; cv=none; b=ZVtTfr/mP7Z9CIVbyZAkQU1gRihd7lQ4iP0/PyjrUg/NDx1o0UDhY2OsMeLc0aNECCp5MWIU3fvmwuOUCuqIr5taPzGrnvlZgIETnff8Q17Y5Uh22anOqoBO/c7/O8SEP4NRxfSf709Xjtb4i6g3YBcY1QppSN/fqZmVt70mi8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435553; c=relaxed/simple;
	bh=SUHcnqAr8yhu077rKx9IiGHuJXgRJPVcwk783FOMTck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u97LpZ3rY8qLu4wX7PIWgkHwRV2UnwUMfzPs1UTS8QyYV9Te9qt3+FikTHBLxBF1Jstx6WLeFask8V40N/J8C93+kTSEgk558DpJfGgDIvZ6Qvmtyp/QqfSg+94iAsoSAc5BdAKyl1RimMYvVQpRIDlxwP/+wH6wx7dZhmRq/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=L/ZtzLJH; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728435551; x=1759971551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UmGmVF0qSS3224D/cSwIPdCaKUsdhZx5Q13P7JykaYA=;
  b=L/ZtzLJHww1QRWR91/B+zHM0PF1AquUIff7rHIKcAeCvop0GKtePPZkK
   TBjATC6bOslxXQ1VAS+kdRL8XdN+3UY0Ky98bPPYmE3EbO8CaBfnymwiV
   fkYQ2DuyFK0ovmuVUl3uwluxF+b2yWm0/vhu/wb/6d56DNRRP5ReFqBCO
   g=;
X-IronPort-AV: E=Sophos;i="6.11,188,1725321600"; 
   d="scan'208";a="374484136"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 00:59:06 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:43078]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id 04d2f9e0-b978-40f4-a80f-8044b4c2cc65; Wed, 9 Oct 2024 00:59:06 +0000 (UTC)
X-Farcaster-Flow-ID: 04d2f9e0-b978-40f4-a80f-8044b4c2cc65
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 00:59:04 +0000
Received: from 88665a182662.ant.amazon.com (10.88.149.159) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 00:59:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<eddyz87@gmail.com>, <edumazet@google.com>, <haoluo@google.com>,
	<john.fastabend@gmail.com>, <jolsa@kernel.org>, <kernelxing@tencent.com>,
	<kpsingh@kernel.org>, <kuba@kernel.org>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
	<song@kernel.org>, <willemb@google.com>, <willemdebruijn.kernel@gmail.com>,
	<yonghong.song@linux.dev>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next 1/9] net-timestamp: add bpf infrastructure to allow exposing more information later
Date: Tue, 8 Oct 2024 17:58:46 -0700
Message-ID: <20241009005846.40046-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241008095109.99918-2-kerneljasonxing@gmail.com>
References: <20241008095109.99918-2-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue,  8 Oct 2024 17:51:01 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Implement basic codes so that we later can easily add each tx points.
> Introducing BPF_SOCK_OPS_ALL_CB_FLAGS used as a test statement can help use
> control whether to output or not.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/uapi/linux/bpf.h       |  5 ++++-
>  net/core/skbuff.c              | 18 ++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  5 ++++-
>  3 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c6cd7c7aeeee..157e139ed6fc 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6900,8 +6900,11 @@ enum {
>  	 * options first before the BPF program does.
>  	 */
>  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
> +	/* Call bpf when the kernel is generating tx timestamps.
> +	 */
> +	BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG = (1<<7),
>  /* Mask of all currently supported cb flags */
> -	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
> +	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,

I remember this change makes two selftests fail and needs diff
in this link.
https://lore.kernel.org/bpf/20231016161134.25365-1-kuniyu@amazon.com/

Also, adding a bpf selftest or extending some for this series
would be nice.

