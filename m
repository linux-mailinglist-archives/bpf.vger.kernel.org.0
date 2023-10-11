Return-Path: <bpf+bounces-11944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DAB7C5A4F
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 19:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F653282656
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088DE3994A;
	Wed, 11 Oct 2023 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vcAb4y4W"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25349A41;
	Wed, 11 Oct 2023 17:35:47 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4B7E3;
	Wed, 11 Oct 2023 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697045745; x=1728581745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=frjHI9ddst3f8PxeQu1ZvawNbZ4ccQ7c9yX6fhgSKSs=;
  b=vcAb4y4WKuYk9vj2/UeS47wGjbNErHG3bUR57IFQHgeM3KR6xg1iD3UA
   CCuh1QlvyWbzOPLKnPWgB1WEngLUQVzNkRPFN4VP2+YbJQxYTq+nK1l4P
   zx9LLjTELV6qLHrJ/G1va4JJcrt4x4Df17+S79gCa+fKtLzoxWoZ+G5it
   c=;
X-IronPort-AV: E=Sophos;i="6.03,216,1694736000"; 
   d="scan'208";a="35167844"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 17:35:42 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
	by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 20EDD48670;
	Wed, 11 Oct 2023 17:35:38 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 11 Oct 2023 17:35:38 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 11 Oct 2023 17:35:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <daan.j.demeyer@gmail.com>
CC: <bpf@vger.kernel.org>, <kernel-team@meta.com>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH bpf-next v10 2/9] bpf: Propagate modified uaddrlen from cgroup sockaddr programs
Date: Wed, 11 Oct 2023 10:35:28 -0700
Message-ID: <20231011173528.41599-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231011170321.73950-3-daan.j.demeyer@gmail.com>
References: <20231011170321.73950-3-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.62]
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Wed, 11 Oct 2023 19:03:11 +0200
[...]
> @@ -1483,11 +1488,18 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>  	if (!ctx.uaddr) {
>  		memset(&unspec, 0, sizeof(unspec));
>  		ctx.uaddr = (struct sockaddr *)&unspec;
> -	}
> +		ctx.uaddrlen = 0;
> +	} else
> +		ctx.uaddrlen = *uaddrlen;
>  
>  	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> -	return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> -				     0, flags);
> +	ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> +				    0, flags);
> +
> +	if (!ret && uaddrlen)

nit: no need to check uaddrlen here or maybe check ctx.uaddrlen.


> +		*uaddrlen = ctx.uaddrlen;
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_addr);
> 

