Return-Path: <bpf+bounces-6469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8362376A0B8
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 20:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4780A2811BF
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 18:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCD01DDC7;
	Mon, 31 Jul 2023 18:56:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD54657
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 18:56:52 +0000 (UTC)
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576A510E;
	Mon, 31 Jul 2023 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690829811; x=1722365811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KgHdVHc/hO61gi3jtEwr/ThEEHnRD/FgvDGcT1bbm/0=;
  b=WErx9+vYg1HelrcrcFaxLQ2N5NxYMmMMXkCQjICHNviAvSu9m2J8JMtM
   74vyZ/7ItlsxforjVo2epkDBtAtwi18oAKeZYCv+SR8UYG7caMuix81LX
   MJPFs42j0DeaoPAOAAscygG7WSTpoItCc+6MMnvyFaL6YKBqdZOwDyaFE
   o=;
X-IronPort-AV: E=Sophos;i="6.01,245,1684800000"; 
   d="scan'208";a="1145993431"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 18:56:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com (Postfix) with ESMTPS id 53DD2344059;
	Mon, 31 Jul 2023 18:56:43 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 18:56:40 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 18:56:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lmb@isovalent.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<martin.lau@kernel.org>, <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next] net: remove duplicate INDIRECT_CALLABLE_DECLARE of udp[6]_ehashfn
Date: Mon, 31 Jul 2023 11:56:27 -0700
Message-ID: <20230731185627.11008-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731-indir-call-v1-1-4cd0aeaee64f@isovalent.com>
References: <20230731-indir-call-v1-1-4cd0aeaee64f@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.27]
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 31 Jul 2023 11:42:53 +0200
> There are already INDIRECT_CALLABLE_DECLARE in the hashtable
> headers, no need to declare them again.
> 
> Fixes: 0f495f761722 ("net: remove duplicate reuseport_lookup functions")
> Suggested-by: Martin Lau <martin.lau@linux.dev>
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
> As pointed out by Martin there are some duplicate macro invocations
> in my recent SO_REUSEPORT support for sk_assign patchset.
> 
> Remove the declarations in the .c files.
> ---
>  net/ipv4/inet_hashtables.c  | 2 --
>  net/ipv6/inet6_hashtables.c | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 6a872b8fb0d3..7876b7d703cb 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -333,8 +333,6 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> -INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
> -
>  /**
>   * inet_lookup_reuseport() - execute reuseport logic on AF_INET socket if necessary.
>   * @net: network namespace.
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index 7c9700c7c9c8..b0e8d278e8a9 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -112,8 +112,6 @@ static inline int compute_score(struct sock *sk, struct net *net,
>  	return score;
>  }
>  
> -INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
> -
>  /**
>   * inet6_lookup_reuseport() - execute reuseport logic on AF_INET6 socket if necessary.
>   * @net: network namespace.
> 
> ---
> base-commit: fb213ecbb8ac56b2d5569737f59126e91f87829a
> change-id: 20230731-indir-call-f1474e314184
> 
> Best regards,
> -- 
> Lorenz Bauer <lmb@isovalent.com>

