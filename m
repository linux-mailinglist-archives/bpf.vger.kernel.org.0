Return-Path: <bpf+bounces-2952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7149737443
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 20:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5FB41C20D7C
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9617717FF0;
	Tue, 20 Jun 2023 18:32:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1417ACF;
	Tue, 20 Jun 2023 18:31:59 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2857C10C2;
	Tue, 20 Jun 2023 11:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1687285910; x=1718821910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kP7uUg6bTWjebzwk/DY0XKPv7AdGZoJ1Fbg26s6nHds=;
  b=LOGDrxLLJUW8VtKNdaNrtYOFvUnws2nfn2luYVhxhsP465psYu09U1w3
   Qw8bwGNBkKVGMsIEHMQ47npNXpRWfvmqMf3Xq1NfMdjZR1UtfnVY1nWcN
   AhDWjVVp7mzEZcGjd07FLavq8wYcpwiLS73BMKbpJ8obYNGn5nscjbkbu
   E=;
X-IronPort-AV: E=Sophos;i="6.00,257,1681171200"; 
   d="scan'208";a="11370153"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 18:31:46 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id 630E546DFB;
	Tue, 20 Jun 2023 18:31:39 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Jun 2023 18:31:38 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.26;
 Tue, 20 Jun 2023 18:31:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lmb@isovalent.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <hemanthmalla@gmail.com>,
	<joe@wand.net.nz>, <john.fastabend@gmail.com>, <jolsa@kernel.org>,
	<kpsingh@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<martin.lau@linux.dev>, <mykolal@fb.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sdf@google.com>, <shuah@kernel.org>, <song@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <yhs@fb.com>
Subject: Re: [PATCH bpf-next v2 3/6] net: remove duplicate reuseport_lookup functions
Date: Tue, 20 Jun 2023 11:31:23 -0700
Message-ID: <20230620183123.74585-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAN+4W8ge-ZQjins-E1=GHDnsi9myFqt7pwNqMkUQHZOPHQhFvQ@mail.gmail.com>
References: <CAN+4W8ge-ZQjins-E1=GHDnsi9myFqt7pwNqMkUQHZOPHQhFvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.106.101.48]
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 20 Jun 2023 15:26:05 +0100
> On Tue, Jun 13, 2023 at 7:57 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > The assignment to result below is buggy.  Let's say SO_REUSEPROT group
> > have TCP_CLOSE and TCP_ESTABLISHED sockets.
> >
> >   1. Find TCP_CLOSE sk and do SO_REUSEPORT lookup
> >   2. result is not NULL, but the group has TCP_ESTABLISHED sk
> >   3. result = result
> >   4. Find TCP_ESTABLISHED sk, which has a higher score
> >   5. result = result (TCP_CLOSE) <-- should be sk.
> >
> > Same for v6 function.
> 
> Thanks for your explanation, I think I get it now. I misunderstood
> that you were worried about returning TCP_ESTABLISHED instead of
> TCP_CLOSE, but it's exactly the other way around.
> 
> I have a follow up question regarding the existing code:
> 
>     result = lookup_reuseport(net, sk, skb,
>                     saddr, sport, daddr, hnum);
>     /* Fall back to scoring if group has connections */
>     if (result && !reuseport_has_conns(sk))
>         return result;
> 
>     result = result ? : sk;
>     badness = score;
> 
> Assuming that result != NULL but reuseport_has_conns() == true, we use
> the reuseport socket as the result, but assign the score of sk to
> badness. Shouldn't we use the score of the reuseport socket?

Good point.  This is based on an assumption that all SO_REUSEPORT
sockets have the same score, which is wrong for two corner cases
if reuseport_has_conns() == true :

  1) SO_INCOMING_CPU is set
     -> selected sk might have +1 score

  2) BPF prog returns ESTABLISHED and/or SO_INCOMING_CPU sk
     -> selected sk will have more than 8

Using the old score could trigger more lookups depending on the
order that sockets are created.

  sk -> sk (SO_INCOMING_CPU) -> sk (ESTABLISHED)
  |     |
  `-> select the next SO_INCOMING_CPU sk
        |
	`-> select itself (We should save this lookup)

So, yes, we should update badness like

  if (unlikely(result)) {
      badness = compute_score(result, ...);
  } else {
      result = sk;
      badness = score;
  }

