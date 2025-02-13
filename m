Return-Path: <bpf+bounces-51338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A15A33587
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 03:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C493216620C
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 02:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA9D20409D;
	Thu, 13 Feb 2025 02:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LgtwfWTg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195F35949;
	Thu, 13 Feb 2025 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413957; cv=none; b=BDMBn4Mqv6ZD+S69+cV4BBP5wRfCSEzZD+juSsUKF7Cqy9mnoXxnTRn3zKdJ2mq62C35bTxuulYW59mxgOcCWMBMRrzJAxXTQBtrPQDxCxASvHOv6bAqDg1SXUmLzyNKKzmWxQcoCxmY/MOrYQv4knTeWYgJInXcR3I24n8y9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413957; c=relaxed/simple;
	bh=mpXR5Z5b+24KS40Q+sflPsaqnxb3qXLvHDkx9+7Blc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGP17I9eMU6B5T/aEBQA6USu+aQqVTIDl3sQANSYJGBkATkPaOavUX1B9dcoo5WUrUV4qtyL68Hhk8IbDAt7wFJ5wKip3SlauK/pFgxiwtyRwQxrdhz2w1gl15COms/PqouMCpFyDri8NxAT8YqaQc2nafkhNvraz/vCON3LMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LgtwfWTg; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739413956; x=1770949956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uDx7Pec/32QhafzMHIA4UZXXRTf/UUrn5Ndsewj+63w=;
  b=LgtwfWTgD5PC2Z52tmUGkJLtR0Dbwy7AD840nZ8KUMRvCaFh/bXl08bG
   KMU+xuRMc3cZIr/rpJjLZbc2JwIZVpZ3fNYQlyBFhW3YcqS4mWuK6JmD4
   nzNJB5LiFpLPDZr4qd8ct24QBDGaBPHxK+K6bLx+AgO4eFW8kZgY8tg/Q
   o=;
X-IronPort-AV: E=Sophos;i="6.13,281,1732579200"; 
   d="scan'208";a="65550634"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:32:32 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:38744]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.31:2525] with esmtp (Farcaster)
 id 50f51949-45c1-4e8f-b9b0-30bf21009bc1; Thu, 13 Feb 2025 02:32:31 +0000 (UTC)
X-Farcaster-Flow-ID: 50f51949-45c1-4e8f-b9b0-30bf21009bc1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 02:32:30 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 02:32:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<eddyz87@gmail.com>, <edumazet@google.com>, <haoluo@google.com>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kerneljasonxing@gmail.com>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<martin.lau@linux.dev>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>, <song@kernel.org>,
	<yonghong.song@linux.dev>
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
Date: Thu, 13 Feb 2025 11:32:14 +0900
Message-ID: <20250213023214.76562-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213022501.76123-1-kuniyu@amazon.com>
References: <20250213022501.76123-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Thu, 13 Feb 2025 11:25:01 +0900
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 2ec162dd83c4..a21a147e0a86 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5303,6 +5303,12 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
> >  			return -EINVAL;
> >  		tp->bpf_sock_ops_cb_flags = val;
> >  		break;
> > +	case TCP_BPF_RTO_MAX:
> > +		if (val > TCP_RTO_MAX_SEC * MSEC_PER_SEC ||
> > +		    val < TCP_RTO_MAX_MIN_SEC * MSEC_PER_SEC)
> > +			return -EINVAL;
> > +		inet_csk(sk)->icsk_rto_max = msecs_to_jiffies(val);
> > +		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> 
> You need not define TCP_BPF_RTO_MAX because TCP_RTO_MAX is not a
> BPF specific option, and you can just reuse do_tcp_setsockopt(),
> then bpf_getsockopt() also works.
> 
> ---8<---
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2ec162dd83c4..77732f10097c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5382,6 +5382,7 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
>  	case TCP_USER_TIMEOUT:
>  	case TCP_NOTSENT_LOWAT:
>  	case TCP_SAVE_SYN:
> +	case TCP_RTO_MAX:

s/TCP_RTO_MAX/TCP_RTO_MAX_MS/ :)


>  		if (*optlen != sizeof(int))
>  			return -EINVAL;
>  		break;
> ---8<---

