Return-Path: <bpf+bounces-12068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E097C75B8
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 20:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B75F282A9F
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 18:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDD83A26D;
	Thu, 12 Oct 2023 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="d9kWHJgs"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E688374F6;
	Thu, 12 Oct 2023 18:12:08 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17528CA;
	Thu, 12 Oct 2023 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697134325; x=1728670325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eauz8HygDKnC71SVXX9udbFeg4RQQoUgaF7M/rkoS9M=;
  b=d9kWHJgskFLOeeT/130WGppRNTFvlf2s0arR496WasD+ICLRmvuBT+9c
   LbS8ujXUjUOZ2igzc+4qoM/PWnYiuqhDA6P+bqhd4OH8tzS57NJGRhIiu
   Sh7gk//D0t3VHPytHPc1GA+om4xtIRYsFAhAy0p6gCDEYnzkkjKli+gau
   g=;
X-IronPort-AV: E=Sophos;i="6.03,219,1694736000"; 
   d="scan'208";a="361594727"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 18:12:02 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id BB44B804CB;
	Thu, 12 Oct 2023 18:12:00 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 12 Oct 2023 18:11:53 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 12 Oct 2023 18:11:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <daan.j.demeyer@gmail.com>
CC: <bpf@vger.kernel.org>, <kernel-team@meta.com>, <martin.lau@linux.dev>,
	<netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: [PATCH bpf-next v2] Only run BPF cgroup unix sockaddr recvmsg() hooks on named sockets
Date: Thu, 12 Oct 2023 11:11:42 -0700
Message-ID: <20231012181142.60636-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231012085216.219918-1-daan.j.demeyer@gmail.com>
References: <20231012085216.219918-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.8]
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Thu, 12 Oct 2023 10:52:13 +0200
> Changes since v1:
> 
> * Added missing Signed-off-by tag

You can put these after --- so that it will disappear when merged.


> 
> We should not run the recvmsg() hooks on unnamed sockets as we do
> not run them on unnamed sockets in the other hooks either. We may
> look into relaxing this later but for now let's make sure we are
> consistent and not run the hooks on unnamed sockets anywhere.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  net/unix/af_unix.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index e10d07c76044..81fb8bddaff9 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2416,9 +2416,10 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
>  	if (msg->msg_name) {
>  		unix_copy_addr(msg, skb->sk);

How is an unnamed socket set to skb->sk ?


> 
> -		BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
> -						      msg->msg_name,
> -						      &msg->msg_namelen);
> +		if (msg->msg_namelen > 0)
> +			BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
> +							      msg->msg_name,
> +							      &msg->msg_namelen);
>  	}
> 
>  	if (size > skb->len - skip)
> @@ -2773,9 +2774,10 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>  					 state->msg->msg_name);
>  			unix_copy_addr(state->msg, skb->sk);
> 
> -			BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
> -							      state->msg->msg_name,
> -							      &state->msg->msg_namelen);
> +			if (state->msg->msg_namelen > 0)
> +				BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
> +								      state->msg->msg_name,
> +								      &state->msg->msg_namelen);
> 
>  			sunaddr = NULL;
>  		}
> --
> 2.41.0
> 

