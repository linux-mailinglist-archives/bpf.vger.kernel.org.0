Return-Path: <bpf+bounces-13435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31287D9EF8
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 19:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAFE282510
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 17:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4573AC37;
	Fri, 27 Oct 2023 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fJYJV6GZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45AF2F37;
	Fri, 27 Oct 2023 17:38:32 +0000 (UTC)
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B84CE3;
	Fri, 27 Oct 2023 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698428310; x=1729964310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+kN7zJaY7hddqZrWWn7tbWJq+V91SftuZMES4mDBLgc=;
  b=fJYJV6GZx+5m4jBG0rG9YuFYx3jdv/mKGp6M9j4YvWEGqSlVWWXoA59F
   1xT8NrYCE6IFRggOVhmy22s5G4Q9rbu0QnBWunpMNhhkGkumWfyqiPEns
   SQnRrREsf2XjOjbh+RusxfQykloDnbR2QPhmjj2uAUWkIZfAMFIKjGmTS
   8=;
X-IronPort-AV: E=Sophos;i="6.03,256,1694736000"; 
   d="scan'208";a="359471154"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 17:38:28 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com (Postfix) with ESMTPS id 30893162830;
	Fri, 27 Oct 2023 17:38:26 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:37410]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.67:2525] with esmtp (Farcaster)
 id 526e1e22-743f-40b7-9429-7f38cdc42795; Fri, 27 Oct 2023 17:38:26 +0000 (UTC)
X-Farcaster-Flow-ID: 526e1e22-743f-40b7-9429-7f38cdc42795
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 27 Oct 2023 17:38:26 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 27 Oct 2023 17:38:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jakub@cloudflare.com>
CC: <bpf@vger.kernel.org>, <john.fastabend@gmail.com>,
	<martin.lau@kernel.org>, <netdev@vger.kernel.org>,
	<yangyingliang@huawei.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH bpf 1/2] bpf: sockmap, af_unix sockets need to hold ref for pair sock
Date: Fri, 27 Oct 2023 10:38:15 -0700
Message-ID: <20231027173815.61906-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o7gk18ja.fsf@cloudflare.com>
References: <87o7gk18ja.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.9]
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 27 Oct 2023 15:32:15 +0200
> On Tue, Oct 24, 2023 at 02:39 PM -07, John Fastabend wrote:
> > Jakub Sitnicki wrote:
> >> On Mon, Oct 16, 2023 at 12:08 PM -07, John Fastabend wrote:
> >> > AF_UNIX sockets are a paired socket. So sending on one of the pairs
> >> > will lookup the paired socket as part of the send operation. It is
> >> > possible however to put just one of the pairs in a BPF map. This
> >> > currently increments the refcnt on the sock in the sockmap to
> >> > ensure it is not free'd by the stack before sockmap cleans up its
> >> > state and stops any skbs being sent/recv'd to that socket.
> >> >
> >> > But we missed a case. If the peer socket is closed it will be
> >> > free'd by the stack. However, the paired socket can still be
> >> > referenced from BPF sockmap side because we hold a reference
> >> > there. Then if we are sending traffic through BPF sockmap to
> >> > that socket it will try to dereference the free'd pair in its
> >> > send logic creating a use after free.  And following splat,
> >> >
> >> >    [59.900375] BUG: KASAN: slab-use-after-free in sk_wake_async+0x31/0x1b0
> >> >    [59.901211] Read of size 8 at addr ffff88811acbf060 by task kworker/1:2/954
> >> >    [...]
> >> >    [59.905468] Call Trace:
> >> >    [59.905787]  <TASK>
> >> >    [59.906066]  dump_stack_lvl+0x130/0x1d0
> >> >    [59.908877]  print_report+0x16f/0x740
> >> >    [59.910629]  kasan_report+0x118/0x160
> >> >    [59.912576]  sk_wake_async+0x31/0x1b0
> >> >    [59.913554]  sock_def_readable+0x156/0x2a0
> >> >    [59.914060]  unix_stream_sendmsg+0x3f9/0x12a0
> >> >    [59.916398]  sock_sendmsg+0x20e/0x250
> >> >    [59.916854]  skb_send_sock+0x236/0xac0
> >> >    [59.920527]  sk_psock_backlog+0x287/0xaa0
> >> 
> >> Isn't the problem here that unix_stream_sendmsg doesn't grab a ref to
> >> peer sock? Unlike unix_dgram_sendmsg which uses the unix_peer_get
> >> helper.
> >
> > It does by my read. In unix_stream_connect we have,
> >
> > 	sock_hold(sk);
> > 	unix_peer(newsk)	= sk;
> > 	newsk->sk_state		= TCP_ESTABLISHED;
> >
> > where it assigns the peer sock. unix_dgram_connect() also calls
> > sock_hold() but through the path that does the socket lookup, such as
> > unix_find_other().
> >
> > The problem I see is before the socket does the kfree on the
> > sock we need to be sure the backlog is canceled and the skb list
> > ingress_skb is purged. If we don't ensure this then the redirect
> > will 
> >
> > My model is this,
> >
> >          s1            c1
> > refcnt    1             1
> > connect   2             2
> > psock     3             3
> > send(s1) ...
> > close(s1) 2             1 <- close drops psock count also
> > close(c1) 0             0
> >
> > The important bit here is the psock has a refcnt on the
> > underlying sock (psock->sk) and wont dec that until after
> > cancel_delayed_work_sync() completes. This ensures the
> > backlog wont try to sendmsg() on that sock after we free
> > it. We also check for SOCK_DEAD and abort to avoid sending
> > over a socket that has been marked DEAD.
> >
> > So... After close(s1) the only thing keeping that sock
> > around is c1. Then we close(c1) that call path is
> >
> >  unix_release
> >    close() 
> >    unix_release_sock()
> >      skpair = unix_peer(sk);
> >      ...
> >      sock_put(skpair);  <- trouble here
> >
> > The release will call sock_put() on the pair socket and
> > dec it to 0 where it gets free'd through sk_free(). But
> > now the trouble is we haven't waited for cancel_delayed_work_sync()
> > on the c1 socket yet so backlog can still run. When it does
> > run it may try to send a pkg over socket s1. OK right up until
> > the sendmsg(s1, ...) does a peer lookup and derefs the peer
> > socket. The peer socket was free'd earlier so use after free. 
> >
> > The question I had originally was this is odd, we are allowing
> > a sendmsg(s1) over a socket while its in unix_release(). We
> > used to take the sock lock from the backlog that was dropped
> > in the name of performance, but it creates these races.
> >
> > Other fixes I considered. First adding sock lock back to
> > backlog. But that punishes the UDP and TCP cases that don't
> > have this problem. Set the SOCK_DEAD flag earlier or check
> > later but this just makes the race smaller doesn't really
> > eliminate it.
> >
> > So this patch is what I came up with. 
> 
> What I was getting at is that we could make it safe to call sendmsg on a
> unix stream sock while its peer is being release. And not just for
> sockmap. I expect io_uring might have the same problem. But I didn't
> actually check yet.
> 
> For that we could keep a ref to peer for the duration of sendmsg call,
> like unix dgram does. Then 'other' doesn't become a stale pointer before
> we're done with it.
> 
> Bumping ref count on each sendmsg is not free, but maybe its
> acceptable. Unix dgram sockets live with it.

The reason why only dgram sk needs sock_hold() for each sendmsg() is
that dgram sk can send data without connect().  unix_peer_get() in
unix_dgram_sendmsg() is to reuse the same code when peer is not set.

unix_stream_sendmsg() already holds a necessary refcnt and need not
use sock_hold() there.

The user who touches a peer without lookup must hold refcnt beforehand.


> 
> With a patch like below, I'm no longer able to trigger an UAF splat.
> 
> WDYT?
> 
> ---8<---
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 3e8a04a13668..48cf19ea9294 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2198,7 +2198,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>  		goto out_err;
>  	} else {
>  		err = -ENOTCONN;
> -		other = unix_peer(sk);
> +		other = unix_peer_get(sk);
>  		if (!other)
>  			goto out_err;
>  	}
> @@ -2282,6 +2282,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>  	}
>  #endif
>  
> +	sock_put(other);
>  	scm_destroy(&scm);
>  
>  	return sent;
> @@ -2294,6 +2295,8 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>  		send_sig(SIGPIPE, current, 0);
>  	err = -EPIPE;
>  out_err:
> +	if (other)
> +		sock_put(other);
>  	scm_destroy(&scm);
>  	return sent ? : err;
>  }

