Return-Path: <bpf+bounces-12339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AE37CB2F0
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476BB1C203B2
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 18:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B073399F;
	Mon, 16 Oct 2023 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Hht5bf0/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67539339A0;
	Mon, 16 Oct 2023 18:47:37 +0000 (UTC)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C825F95;
	Mon, 16 Oct 2023 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697482056; x=1729018056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7TJEGpOwCAxzI4XV3ABARA6tp/krpOLVs/AWw7/MQLY=;
  b=Hht5bf0/r/43xaVFAXNORk5y3/o12SMhT9hIvqmXwpUxIthMsIVrpwnG
   gFpbrWM88EUjUnTRMHuqIAa06TDh5go0C0wD2eKddXV10mNUP8gQUciOA
   IpUBZQFUi3TolD+dzaFvLN8j2ZZlet/+vgk+/GXt0G+24HUd/46pInU2P
   o=;
X-IronPort-AV: E=Sophos;i="6.03,230,1694736000"; 
   d="scan'208";a="370196283"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 18:47:30 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com (Postfix) with ESMTPS id BC049A7C94;
	Mon, 16 Oct 2023 18:47:27 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:6918]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.44:2525] with esmtp (Farcaster)
 id 75cf5d43-6e29-423a-acc8-43c887aab6e6; Mon, 16 Oct 2023 18:47:26 +0000 (UTC)
X-Farcaster-Flow-ID: 75cf5d43-6e29-423a-acc8-43c887aab6e6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 16 Oct 2023 18:47:24 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Mon, 16 Oct 2023 18:47:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <bpf@vger.kernel.org>, <daan.j.demeyer@gmail.com>, <kernel-team@meta.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] Only run BPF cgroup unix sockaddr recvmsg() hooks on named sockets
Date: Mon, 16 Oct 2023 11:47:14 -0700
Message-ID: <20231016184714.42177-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <eb4bd204-17b1-f0cb-93dd-d74999ddb265@linux.dev>
References: <eb4bd204-17b1-f0cb-93dd-d74999ddb265@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.29]
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
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
Date: Mon, 16 Oct 2023 11:33:36 -0700
> On 10/12/23 11:11 AM, Kuniyuki Iwashima wrote:
> > From: Daan De Meyer <daan.j.demeyer@gmail.com>
> > Date: Thu, 12 Oct 2023 10:52:13 +0200
> >> Changes since v1:
> >>
> >> * Added missing Signed-off-by tag
> > 
> > You can put these after --- so that it will disappear when merged.
> > 
> > 
> >>
> >> We should not run the recvmsg() hooks on unnamed sockets as we do
> >> not run them on unnamed sockets in the other hooks either. We may
> >> look into relaxing this later but for now let's make sure we are
> >> consistent and not run the hooks on unnamed sockets anywhere.
> >>
> >> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> >> ---
> >>   net/unix/af_unix.c | 14 ++++++++------
> >>   1 file changed, 8 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> >> index e10d07c76044..81fb8bddaff9 100644
> >> --- a/net/unix/af_unix.c
> >> +++ b/net/unix/af_unix.c
> >> @@ -2416,9 +2416,10 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
> >>   	if (msg->msg_name) {
> >>   		unix_copy_addr(msg, skb->sk);
> > 
> > How is an unnamed socket set to skb->sk ?
> 
> I had a similar question. Most likely socketpair? Please add an explanation in 
> the commit message in v3. Please also help to add a selftest for this case.

Ah exactly, socketpair() for SOCK_STREAM does it.


> 
> > 
> > 
> >>
> >> -		BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
> >> -						      msg->msg_name,
> >> -						      &msg->msg_namelen);
> >> +		if (msg->msg_namelen > 0)
> >> +			BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
> >> +							      msg->msg_name,
> >> +							      &msg->msg_namelen);
> >>   	}
> >>
> >>   	if (size > skb->len - skip)
> >> @@ -2773,9 +2774,10 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
> >>   					 state->msg->msg_name);
> >>   			unix_copy_addr(state->msg, skb->sk);
> >>
> >> -			BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
> >> -							      state->msg->msg_name,
> >> -							      &state->msg->msg_namelen);
> >> +			if (state->msg->msg_namelen > 0)
> >> +				BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
> >> +								      state->msg->msg_name,
> >> +								      &state->msg->msg_namelen);
> >>
> >>   			sunaddr = NULL;
> >>   		}
> >> --
> >> 2.41.0

