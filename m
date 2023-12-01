Return-Path: <bpf+bounces-16469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CEB801501
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 22:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4AF281C7C
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 21:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26D259B40;
	Fri,  1 Dec 2023 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dI6+AVs2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E465FD67;
	Fri,  1 Dec 2023 13:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701465307; x=1733001307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ioc4eUF5pNt+IQLXF9dzCWjQLoXaZhmv9ENZ3g9ja8I=;
  b=dI6+AVs2PwQnFKkw+x/Q7FDhJ7GaQetwrnlUtevMR4wXipxt0Md9Ddf5
   eSVqoiHGjLfmpZza0v2ufFanmXZRhsTmaHrNqiZsTMNAKCOWe9TgPLKxz
   cfKkAY5ZyBuERJOrOAt9KF5MLV5ZTR/tdLw8uYjeqZGG3hNCQSn8ZLCmS
   o=;
X-IronPort-AV: E=Sophos;i="6.04,242,1695686400"; 
   d="scan'208";a="47724183"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 21:15:06 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id CD4B580668;
	Fri,  1 Dec 2023 21:15:05 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:17218]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.224:2525] with esmtp (Farcaster)
 id 4057116d-8d11-4d05-94fd-222369fe7c3b; Fri, 1 Dec 2023 21:15:05 +0000 (UTC)
X-Farcaster-Flow-ID: 4057116d-8d11-4d05-94fd-222369fe7c3b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 1 Dec 2023 21:15:05 +0000
Received: from 88665a182662.ant.amazon.com (10.118.249.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Dec 2023 21:15:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <john.fastabend@gmail.com>
CC: <bpf@vger.kernel.org>, <edumazet@google.com>, <jakub@cloudflare.com>,
	<martin.lau@kernel.org>, <netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: [PATCH bpf v2 1/2] bpf: syzkaller found null ptr deref in unix_bpf proto add
Date: Fri, 1 Dec 2023 13:14:53 -0800
Message-ID: <20231201211453.27432-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231201180139.328529-2-john.fastabend@gmail.com>
References: <20231201180139.328529-2-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: John Fastabend <john.fastabend@gmail.com>
Date: Fri,  1 Dec 2023 10:01:38 -0800
> I added logic to track the sock pair for stream_unix sockets so that we
> ensure lifetime of the sock matches the time a sockmap could reference
> the sock (see fixes tag). I forgot though that we allow af_unix unconnected
> sockets into a sock{map|hash} map.
> 
> This is problematic because previous fixed expected sk_pair() to exist
> and did not NULL check it. Because unconnected sockets have a NULL
> sk_pair this resulted in the NULL ptr dereference found by syzkaller.
> 
> BUG: KASAN: null-ptr-deref in unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
> Write of size 4 at addr 0000000000000080 by task syz-executor360/5073
> Call Trace:
>  <TASK>
>  ...
>  sock_hold include/net/sock.h:777 [inline]
>  unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
>  sock_map_init_proto net/core/sock_map.c:190 [inline]
>  sock_map_link+0xb87/0x1100 net/core/sock_map.c:294
>  sock_map_update_common+0xf6/0x870 net/core/sock_map.c:483
>  sock_map_update_elem_sys+0x5b6/0x640 net/core/sock_map.c:577
>  bpf_map_update_value+0x3af/0x820 kernel/bpf/syscall.c:167
> 
> We considered just checking for the null ptr and skipping taking a ref
> on the NULL peer sock. But, if the socket is then connected() after
> being added to the sockmap we can cause the original issue again. So
> instead this patch blocks adding af_unix sockets that are not in the
> ESTABLISHED state.

I'm not sure if someone has the unconnected stream socket use case
though, can't we call additional sock_hold() in connect() by checking
sk_prot under sk_callback_lock ?

