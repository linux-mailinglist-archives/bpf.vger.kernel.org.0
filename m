Return-Path: <bpf+bounces-12586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440D47CE44E
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 19:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC881281CA3
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB0E3E48C;
	Wed, 18 Oct 2023 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HfQsmEMP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E23D995;
	Wed, 18 Oct 2023 17:20:56 +0000 (UTC)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0553AA8;
	Wed, 18 Oct 2023 10:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697649653; x=1729185653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X/1Xxr46ErROCK/1+Qc7d09MaDcu5nyq7Q1m3vZNadc=;
  b=HfQsmEMPOxBzkcKXGEGMBo5BBCFXjP8UuogRhI3xUvoNwkX4KWyS4cs8
   pb2/a6En1VgMWdh0CZwgIP6xVJxKhkOIUZ+fzlMcW6cCjIuT/xQtt9/U0
   ULjea+WLWgPyWK5ZDsssPVUqWuoda3DNE+fOQvDUt4N/GTqDkx1Nahizl
   s=;
X-IronPort-AV: E=Sophos;i="6.03,235,1694736000"; 
   d="scan'208";a="678540945"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 17:20:43 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com (Postfix) with ESMTPS id CEB73A072C;
	Wed, 18 Oct 2023 17:20:41 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:33747]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.42:2525] with esmtp (Farcaster)
 id 7a00f9c2-5dad-40ef-a1a8-0a06c60411d8; Wed, 18 Oct 2023 17:20:40 +0000 (UTC)
X-Farcaster-Flow-ID: 7a00f9c2-5dad-40ef-a1a8-0a06c60411d8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 18 Oct 2023 17:20:39 +0000
Received: from 88665a182662.ant.amazon.com.com (10.111.146.69) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.37;
 Wed, 18 Oct 2023 17:20:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<haoluo@google.com>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kpsingh@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <mykolal@fb.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@google.com>,
	<song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie generation/validation SOCK_OPS hooks.
Date: Wed, 18 Oct 2023 10:20:27 -0700
Message-ID: <20231018172027.9936-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iLZDvqrGy9UJ39a49O3NLT74r+5FXfh7u3SxSSm60BJmA@mail.gmail.com>
References: <CANn89iLZDvqrGy9UJ39a49O3NLT74r+5FXfh7u3SxSSm60BJmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.111.146.69]
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Oct 2023 10:02:51 +0200
> On Wed, Oct 18, 2023 at 8:19 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >
> > On 10/17/23 9:48 AM, Kuniyuki Iwashima wrote:
> > > From: Martin KaFai Lau <martin.lau@linux.dev>
> > > Date: Mon, 16 Oct 2023 22:53:15 -0700
> > >> On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
> > >>> Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
> > >>> After 3WHS, the proxy restores SYN and forwards it and ACK to the backend
> > >>> server.  Our kernel module works at Netfilter input/output hooks and first
> > >>> feeds SYN to the TCP stack to initiate 3WHS.  When the module is triggered
> > >>> for SYN+ACK, it looks up the corresponding request socket and overwrites
> > >>> tcp_rsk(req)->snt_isn with the proxy's cookie.  Then, the module can
> > >>> complete 3WHS with the original ACK as is.
> > >>
> > >> Does the current kernel module also use the timestamp bits differently?
> > >> (something like patch 8 and patch 10 trying to do)
> > >
> > > Our SYN Proxy uses TS as is.  The proxy nodes generate a random number
> > > if TS is in SYN.
> > >
> > > But I thought someone would suggest making TS available so that we can
> > > mock the default behaviour at least, and it would be more acceptable.
> > >
> > > The selftest uses TS just to strengthen security by validating 32-bits
> > > hash.  Dropping a part of hash makes collision easier to happen, but
> > > 24-bits were sufficient for us to reduce SYN flood to the managable
> > > level at the backend.
> >
> > While enabling bpf to customize the syncookie (and timestamp), I want to explore
> > where can this also be done other than at the tcp layer.
> >
> > Have you thought about directly sending the SYNACK back at a lower layer like
> > tc/xdp after receiving the SYN?

Yes.  Actually, at netconf I mentioned the cookie generation hook will not
be necessary and should be replaced with XDP.


> > There are already bpf_tcp_{gen,check}_syncookie
> > helper that allows to do this for the performance reason to absorb synflood. It
> > will be natural to extend it to handle the customized syncookie also.

Maybe we even need not extend it and can use XDP as said below.


> >
> > I think it should already be doable to send a SYNACK back with customized
> > syncookie (and timestamp) at tc/xdp today.
> >
> > When ack is received, the prog@tc/xdp can verify the cookie. It will probably
> > need some new kfuncs to create the ireq and queue the child socket. The bpf prog
> > can change the ireq->{snd_wscale, sack_ok...} if needed. The details of the
> > kfuncs need some more thoughts. I think most of the bpf-side infra is ready,
> > e.g. acquire/release/ref-tracking...etc.
> >
> 
> I think I mostly agree with this.

I didn't come up with kfunc to create ireq and queue it to listener, so
cookie_v[46]_check() were best place for me to extend easily, but now it
sounds like kfunc would be the way to go.

Maybe we can move the core part of cookie_v[46]_check() except for kernel
cookie's validation to __cookie_v[46]_check() and expose a wrapper of it
as kfunc ?

Then, we can look up sk and pass the listener, skb, and flags (for sack_ok,
etc) to the kfunc.  (It could still introduce some conflicts with Eric's
patch though...)


> 
> I am rebasing  a patch adding usec resolution to TCP TS,
> that we used for about 10 years at Google, because it is time to upstream it.
> 
> I am worried about more changes/conflicts caused by Kuniyuki patch set...

