Return-Path: <bpf+bounces-12312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CD47CB01D
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 18:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971402814D4
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DAD2E642;
	Mon, 16 Oct 2023 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z4/KbDyR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657D30D0C;
	Mon, 16 Oct 2023 16:46:26 +0000 (UTC)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77BC1A63B;
	Mon, 16 Oct 2023 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697474785; x=1729010785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bq7RCfKU4ckrmiszPJvMeQ7TgL9PxzUxAwdnf3cz+x8=;
  b=Z4/KbDyRMB7AHbzp9coLYrA4r096Tr/4kJP5bbhV+pMPhVZ2paXikNNa
   GMkbx7knQvAimCQ+W8l6E96t70b0p71Rt2MwAMwMpYJSO6hgLEA1AlPRd
   QD15F3e9ZoiZyPOsTUg2KTFT/yOd0hA+NbSH4yCGKgowPUNodntsm43Va
   0=;
X-IronPort-AV: E=Sophos;i="6.03,229,1694736000"; 
   d="scan'208";a="160281536"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 16:46:21 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id BEF2FC0155;
	Mon, 16 Oct 2023 16:46:19 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:62506]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.42:2525] with esmtp (Farcaster)
 id 12b44c11-b47e-4375-acfd-00f44b761278; Mon, 16 Oct 2023 16:46:19 +0000 (UTC)
X-Farcaster-Flow-ID: 12b44c11-b47e-4375-acfd-00f44b761278
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 16 Oct 2023 16:46:17 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 16 Oct 2023 16:46:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <martin.lau@linux.dev>,
	<mykolal@fb.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sdf@google.com>, <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie generation/validation SOCK_OPS hooks.
Date: Mon, 16 Oct 2023 09:46:06 -0700
Message-ID: <20231016164606.29484-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <652d46664a3db_1980fa29460@willemb.c.googlers.com.notmuch>
References: <652d46664a3db_1980fa29460@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.29]
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 16 Oct 2023 10:19:18 -0400
> Kuniyuki Iwashima wrote:
> > Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
> > for the connection request until a valid ACK is responded to the SYN+ACK.
> > 
> > The cookie contains two kinds of host-specific bits, a timestamp and
> > secrets, so only can it be validated by the generator.  It means SYN
> > Cookie consumes network resources between the client and the server;
> > intermediate nodes must remember which nodes to route ACK for the cookie.
> > 
> > SYN Proxy reduces such unwanted resource allocation by handling 3WHS at
> > the edge network.  After SYN Proxy completes 3WHS, it forwards SYN to the
> > backend server and completes another 3WHS.  However, since the server's
> > ISN differs from the cookie, the proxy must manage the ISN mappings and
> > fix up SEQ/ACK numbers in every packet for each connection.  If a proxy
> > node is down, all the connections through it are also down.  Keeping a
> > state at proxy is painful from that perspective.
> > 
> > At AWS, we use a dirty hack to build truly stateless SYN Proxy at scale.
> > Our SYN Proxy consists of the front proxy layer and the backend kernel
> > module.  (See slides of netconf [0], p6 - p15)
> > 
> > The cookie that SYN Proxy generates differs from the kernel's cookie in
> > that it contains a secret (called rolling salt) (i) shared by all the proxy
> > nodes so that any node can validate ACK and (ii) updated periodically so
> > that old cookies cannot be validated.  Also, ISN contains WScale, SACK, and
> > ECN, not in TS val.  This is not to sacrifice any connection quality, where
> > some customers turn off the timestamp option due to retro CVE.
> 
> If easier: I think it should be possible to make the host secret
> readable and writable with CAP_NET_ADMIN, to allow synchronizing
> between hosts.

I think the idea is doable for syncookie_secret and syncookie6_secret.
However, the cookie timestamp is generated based on jiffies that cannot
be written.

[ I answered sharing secrets would resolve our issue at netconf, but
  I was wrong. ]


> For similar reasons as suggested here, a rolling salt might be
> useful more broadly too.

Maybe we need not use jiffies and can create a worker to update the
secret periodically if it's not configured manually.

The problem here would be that we need to update/read u64[4] atomically
if we want to use SipHash or HSipHash.  Maybe this also can be changed.

But, we still want to use BPF as we need to encode (at least) WS and
SACK bits in ISN, not TS and use different MSS candidates rather than
msstab.

Also, in our use case, the validation for cookie itself is done in
the front proxy layer, and the kernel will do more light-weight
validation like checking if the cookie is forwarded from trusted
nodes.  Then, we can prevent invalid ACK from flowing through the
backend and consuming some networking entries, and the backend need
not do full validation.

With BPF, we can get such flexibility at encoding and validation, and
making cookie generation algorithm private could be good for security.

