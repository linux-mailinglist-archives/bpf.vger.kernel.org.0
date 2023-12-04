Return-Path: <bpf+bounces-16652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEAC8041BE
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8171C20BBE
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 22:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BE835EEF;
	Mon,  4 Dec 2023 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SbbfFc4D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E431BE;
	Mon,  4 Dec 2023 14:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701729483; x=1733265483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dwkr9KYSNSzaL4w3kfbjs29Z/+yP3ST41k4GVMQExoY=;
  b=SbbfFc4DUe9pPJ1Yyjk8y91Zm5njSraf5ft9XVp5WDGesLtOGse1LYxV
   4Em3quVt4rbYmZustH6NS27+2HkXpwhDQ/DIyfBf0JrVqZhp3twqg8T+/
   tUCksfuZ6jxDFwq1Oo+KLSIF/rE17Ef/kJ7EgiAN3/YJheCOp04zHdrjO
   s=;
X-IronPort-AV: E=Sophos;i="6.04,250,1695686400"; 
   d="scan'208";a="371785886"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 22:38:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 4A90F494EC;
	Mon,  4 Dec 2023 22:37:57 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:62971]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.6:2525] with esmtp (Farcaster)
 id dea74d02-02c6-410a-9b58-14b60520c01f; Mon, 4 Dec 2023 22:37:57 +0000 (UTC)
X-Farcaster-Flow-ID: dea74d02-02c6-410a-9b58-14b60520c01f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 4 Dec 2023 22:37:57 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.0.105) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Mon, 4 Dec 2023 22:37:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <john.fastabend@gmail.com>
CC: <bpf@vger.kernel.org>, <edumazet@google.com>, <jakub@cloudflare.com>,
	<kuniyu@amazon.com>, <martin.lau@kernel.org>, <netdev@vger.kernel.org>,
	<cong.wang@bytedance.com>, <jiang.wang@bytedance.com>
Subject: RE: [PATCH bpf v2 1/2] bpf: syzkaller found null ptr deref in unix_bpf proto add
Date: Tue, 5 Dec 2023 07:37:38 +0900
Message-ID: <20231204223738.62315-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <656e4758675b9_1bd6e2086f@john.notmuch>
References: <656e4758675b9_1bd6e2086f@john.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

+cc Cong and Jiang, as potential users of AF_UNIX sockmap w/ unconnected
SOCK_STREAM sockets

https://lore.kernel.org/netdev/20231201180139.328529-1-john.fastabend@gmail.com/

From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 04 Dec 2023 13:40:40 -0800
> Kuniyuki Iwashima wrote:
> > From: John Fastabend <john.fastabend@gmail.com>
> > Date: Fri,  1 Dec 2023 10:01:38 -0800
> > > I added logic to track the sock pair for stream_unix sockets so that we
> > > ensure lifetime of the sock matches the time a sockmap could reference
> > > the sock (see fixes tag). I forgot though that we allow af_unix unconnected
> > > sockets into a sock{map|hash} map.
> > > 
> > > This is problematic because previous fixed expected sk_pair() to exist
> > > and did not NULL check it. Because unconnected sockets have a NULL
> > > sk_pair this resulted in the NULL ptr dereference found by syzkaller.
> > > 
> > > BUG: KASAN: null-ptr-deref in unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
> > > Write of size 4 at addr 0000000000000080 by task syz-executor360/5073
> > > Call Trace:
> > >  <TASK>
> > >  ...
> > >  sock_hold include/net/sock.h:777 [inline]
> > >  unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
> > >  sock_map_init_proto net/core/sock_map.c:190 [inline]
> > >  sock_map_link+0xb87/0x1100 net/core/sock_map.c:294
> > >  sock_map_update_common+0xf6/0x870 net/core/sock_map.c:483
> > >  sock_map_update_elem_sys+0x5b6/0x640 net/core/sock_map.c:577
> > >  bpf_map_update_value+0x3af/0x820 kernel/bpf/syscall.c:167
> > > 
> > > We considered just checking for the null ptr and skipping taking a ref
> > > on the NULL peer sock. But, if the socket is then connected() after
> > > being added to the sockmap we can cause the original issue again. So
> > > instead this patch blocks adding af_unix sockets that are not in the
> > > ESTABLISHED state.
> > 
> > I'm not sure if someone has the unconnected stream socket use case
> > though, can't we call additional sock_hold() in connect() by checking
> > sk_prot under sk_callback_lock ?
> 
> Could be done I guess yes. I'm not sure the utility of it though. I
> thought above patch was the simplest solution and didn't require touching
> main af_unix code. I don't actually use the sockmap with af_unix
> sockets anywhere so maybe someone who is using this can comment if
> unconnected is needed?
> 
> From rcu and locking side looks like holding sk_callback_lock would
> be sufficient. I was thinking it would require a rcu grace period
> or something but seems not.
> 
> I guess I could improve original patch if folks want.
> 
> .John

