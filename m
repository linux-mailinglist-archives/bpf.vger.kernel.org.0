Return-Path: <bpf+bounces-12460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB597CC90F
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E33281B63
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F162D050;
	Tue, 17 Oct 2023 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RK7uoGXT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4565E2D024;
	Tue, 17 Oct 2023 16:48:28 +0000 (UTC)
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC2894;
	Tue, 17 Oct 2023 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697561307; x=1729097307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z04JNrT1PBI+7Zlnd2sqQ/cmOtWQZGnINwY4nQzU69w=;
  b=RK7uoGXTA/w0QQIVXxpVS0DF3xjtAmy3+sI7UHM4t8oYxMehMVHuN7kv
   FOaJ2FFIqDLHCeNrfZ5dDaoRPR+lJ6bXeYTI9JLct/XG0KGegkBN/8JvH
   lGxt5pbOarMkv9qFigTv0oJLf8mKVGzb5a+98jxjg9inaRB56e8MP3MMJ
   o=;
X-IronPort-AV: E=Sophos;i="6.03,232,1694736000"; 
   d="scan'208";a="613916456"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 16:48:25 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 62467A2563;
	Tue, 17 Oct 2023 16:48:20 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:65273]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.182:2525] with esmtp (Farcaster)
 id a56480ac-c8fc-463d-a6d2-ea6235505d1b; Tue, 17 Oct 2023 16:48:19 +0000 (UTC)
X-Farcaster-Flow-ID: a56480ac-c8fc-463d-a6d2-ea6235505d1b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 16:48:19 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 16:48:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <haoluo@google.com>, <john.fastabend@gmail.com>,
	<jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <mykolal@fb.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@google.com>,
	<song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v1 bpf-next 00/11] bpf: tcp: Add SYN Cookie generation/validation SOCK_OPS hooks.
Date: Tue, 17 Oct 2023 09:48:07 -0700
Message-ID: <20231017164807.19824-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <9666242b-d899-c428-55bd-14f724cc4ffd@linux.dev>
References: <9666242b-d899-c428-55bd-14f724cc4ffd@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.38]
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Mon, 16 Oct 2023 22:53:15 -0700
> On 10/13/23 3:04 PM, Kuniyuki Iwashima wrote:
> > Under SYN Flood, the TCP stack generates SYN Cookie to remain stateless
> > After 3WHS, the proxy restores SYN and forwards it and ACK to the backend
> > server.  Our kernel module works at Netfilter input/output hooks and first
> > feeds SYN to the TCP stack to initiate 3WHS.  When the module is triggered
> > for SYN+ACK, it looks up the corresponding request socket and overwrites
> > tcp_rsk(req)->snt_isn with the proxy's cookie.  Then, the module can
> > complete 3WHS with the original ACK as is.
> 
> Does the current kernel module also use the timestamp bits differently? 
> (something like patch 8 and patch 10 trying to do)

Our SYN Proxy uses TS as is.  The proxy nodes generate a random number
if TS is in SYN.

But I thought someone would suggest making TS available so that we can
mock the default behaviour at least, and it would be more acceptable.

The selftest uses TS just to strengthen security by validating 32-bits
hash.  Dropping a part of hash makes collision easier to happen, but
24-bits were sufficient for us to reduce SYN flood to the managable
level at the backend.


> 
> > 
> > This way, our SYN Proxy does not manage the ISN mappings and can stay
> > stateless.  It's working very well for high-bandwidth services like
> > multiple Tbps, but we are looking for a way to drop the dirty hack and
> > further optimise the sequences.
> > 
> > If we could validate an arbitrary SYN Cookie on the backend server with
> > BPF, the proxy would need not restore SYN nor pass it.  After validating
> > ACK, the proxy node just needs to forward it, and then the server can do
> > the lightweight validation (e.g. check if ACK came from proxy nodes, etc)
> > and create a connection from the ACK.
> > 
> > This series adds two SOCK_OPS hooks to generate and validate arbitrary
> > SYN Cookie.  Each hook is invoked if BPF_SOCK_OPS_SYNCOOKIE_CB_FLAG is
> > set to the listening socket in advance by bpf_sock_ops_cb_flags_set().
> > 
> > The user interface looks like this:
> > 
> >    BPF_SOCK_OPS_GEN_SYNCOOKIE_CB
> > 
> >      input
> >      |- bpf_sock_ops.sk           : 4-tuple
> >      |- bpf_sock_ops.skb          : TCP header
> >      |- bpf_sock_ops.args[0]      : MSS
> >      `- bpf_sock_ops.args[1]      : BPF_SYNCOOKIE_XXX flags
> > 
> >      output
> >      |- bpf_sock_ops.replylong[0] : ISN (SYN Cookie) ------.
> >      `- bpf_sock_ops.replylong[1] : TS value -----------.  |
> >                                                         |  |
> >    BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB                      |  |
> >                                                         |  |
> >      input                                              |  |
> >      |- bpf_sock_ops.sk           : 4-tuple             |  |
> >      |- bpf_sock_ops.skb          : TCP header          |  |
> >      |- bpf_sock_ops.args[0]      : ISN (SYN Cookie) <-----'
> >      `- bpf_sock_ops.args[1]      : TS value <----------'
> > 
> >      output
> >      |- bpf_sock_ops.replylong[0] : MSS
> >      `- bpf_sock_ops.replylong[1] : BPF_SYNCOOKIE_XXX flags
> > 
> > To establish a connection from SYN Cookie, BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB
> > hook must set a valid MSS to bpf_sock_ops.replylong[0], meaning that
> > BPF_SOCK_OPS_GEN_SYNCOOKIE_CB hook must encode MSS to ISN or TS val to be
> > restored in the validation hook.
> > 
> > If WScale, SACK, and ECN are detected to be available in SYN packet, the
> > corresponding flags are passed to args[0] of BPF_SOCK_OPS_GEN_SYNCOOKIE_CB
> > so that bpf prog need not parse the TCP header.  The same flags can be set
> > to replylong[0] of BPF_SOCK_OPS_CHECK_SYNCOOKIE_CB to enable each feature
> > on the connection.
> > 
> > For details, please see each patch.  Here's an overview:
> > 
> >    patch 1 - 4 : Misc cleanup
> >    patch 5, 6  : Add SOCK_OPS hook (only ISN is available here)
> >    patch 7, 8  : Make TS val available as the second cookie storage
> >    patch 9, 10 : Make WScale, SACK, and ECN configurable from ACK
> >    patch 11    : selftest, need some help from BPF experts...
> 
> I cannot reprod the issue. Commented in patch 11.
> 
> I only scanned through the high level of the patchset. will take a closer look. 
> Thanks.

I'll wait your review before posting v2.
Thank you!

