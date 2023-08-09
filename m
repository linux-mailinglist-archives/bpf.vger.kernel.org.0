Return-Path: <bpf+bounces-7373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E53F776489
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 17:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D44281CD8
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED931BB55;
	Wed,  9 Aug 2023 15:56:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C8E18AE4;
	Wed,  9 Aug 2023 15:56:26 +0000 (UTC)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4402D2698;
	Wed,  9 Aug 2023 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691596567; x=1723132567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SsgNs8WP7Va7/HPmzzpveitPd422Cl33ClfKs6muCY8=;
  b=DHFk60Fga6jL5POkjcp2KhSALBJofqV3R2ze8tdgMKXbCLLsRwLEsdGh
   OFEQyS7RqIhFeEWNAq3m54u3wJ/2ck1dEw3KjPnJwLEmLnCP4GUlJwAz5
   Zg6F17GaIglCDcCIXtbDTDhB3XYCSBsNeR3YO577gbFUCSAWNJFX/z5Br
   s=;
X-IronPort-AV: E=Sophos;i="6.01,159,1684800000"; 
   d="scan'208";a="597758339"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:56:04 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-153b24bc.us-east-1.amazon.com (Postfix) with ESMTPS id 400C7C1540;
	Wed,  9 Aug 2023 15:55:59 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 15:55:50 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Wed, 9 Aug 2023 15:55:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lmb@isovalent.com>
CC: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <martin.lau@kernel.org>,
	<martin.lau@linux.dev>, <memxor@gmail.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH bpf-next] net: Fix slab-out-of-bounds in inet[6]_steal_sock
Date: Wed, 9 Aug 2023 08:55:38 -0700
Message-ID: <20230809155538.67000-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAN+4W8hMpL3+vNOrBBRw01tD6OxQ-Yy8OWpq9nRtiyjm0GgE4g@mail.gmail.com>
References: <CAN+4W8hMpL3+vNOrBBRw01tD6OxQ-Yy8OWpq9nRtiyjm0GgE4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.106.100.32]
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 9 Aug 2023 16:08:31 +0100
> On Wed, Aug 9, 2023 at 3:39 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >
> > On 8/9/23 1:33 AM, Lorenz Bauer wrote:
> > > Kumar reported a KASAN splat in tcp_v6_rcv:
> > >
> > >    bash-5.2# ./test_progs -t btf_skc_cls_ingress
> > >    ...
> > >    [   51.810085] BUG: KASAN: slab-out-of-bounds in tcp_v6_rcv+0x2d7d/0x3440
> > >    [   51.810458] Read of size 2 at addr ffff8881053f038c by task test_progs/226
> > >
> > > The problem is that inet[6]_steal_sock accesses sk->sk_protocol without
> > > accounting for request sockets. I added the check to ensure that we only
> > > every try to perform a reuseport lookup on a supported socket.
> > >
> > > It turns out that this isn't necessary at all. struct sock_common contains
> > > a skc_reuseport flag which indicates whether a socket is part of a
> >
> > Does it go back to the earlier discussion
> > (https://lore.kernel.org/bpf/7188429a-c380-14c8-57bb-9d05d3ba4e5e@linux.dev/)
> > that the sk->sk_reuseport is 1 from sk_clone for TCP_ESTABLISHED? It works
> > because there is sk->sk_reuseport"_cb" check going deeper into
> > reuseport_select_sock() but there is an extra inet6_ehashfn for all TCP_ESTABLISHED.
> 
> Sigh, I'd forgotten about this...
> 
> For the TPROXY TCP replacement use case we sk_assign the SYN to the
> listener, which creates the reqsk. We can let follow up packets pass
> without sk_assign since they will match the reqsk and convert to a
> fullsock via the usual route. At least that is what the test does. I'm
> not even sure what it means to redirect a random packet into an
> established TCP socket TBH. It'd probably be dropped?
> 
> For UDP, I'm not sure whether we even get into this situation? Doesn't
> seem like UDP sockets are cloned from each other, so we also shouldn't
> end up with a reuseport flag set erroneously.
> 
> Things we could do if necessary:
> 1. Reset the flag in inet_csk_clone_lock like we do for SOCK_RCU_FREE

I think we can't do this as sk_reuseport is inherited to twsk and used
in inet_bind_conflict().


> 2. Duplicate the cb check into inet[6]_steal_sock

or 3. Add sk_fullsock() test ?

