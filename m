Return-Path: <bpf+bounces-13420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7667D9A5A
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 15:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBF11C2106D
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A1C241FF;
	Fri, 27 Oct 2023 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Ds88vc9N"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B2B678
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 13:47:58 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B30BCA
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:47:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9936b3d0286so326950766b.0
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 06:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698414475; x=1699019275; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=U1tm69cOQKIuAU0wa8JTqJ2b4DYDoojVR4McyMO82qI=;
        b=Ds88vc9NDmRBwQ58cEf3XpARaoi1l+lCxVaSVoaLyxXeIGyZCTCEB06PLeKq5s2rU7
         cy9SGY5JJk55CX5Hng+lNSMqL+Fwa/OofeMKupTsk7kwkXngVQHATSuuzDQX2ZSLmVPn
         DLoKPVkfZXZyFlc8isPItSWMwiGKmvaTok/IUuzI/Gd/3Ime/UCGP9d2CGEwDj67kxHw
         JS8/0IJf8ZQBYWwxm+nM9iS5WeiAqXhQz6JkD4FOfg0vhqrhb0OdeAXouFsVvviRb8z3
         fqDPjJns0XoO5hkoNlFOqQ2th/focLB5cMRGqIlOVSGk3Lt+qfq3197ZWbcZ3Gqy9/aq
         O1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698414475; x=1699019275;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1tm69cOQKIuAU0wa8JTqJ2b4DYDoojVR4McyMO82qI=;
        b=AmeCzmDMvNYnHuiFK22v5n+NO0hMum+kbNqVJWCGGFQ3kdgWwuSMyJrAX7x2PPEWDZ
         L6++Gf6WnAdbT2n91gkcBShQu+3VwnV8yRfsy5dGaTytwIyEjRmYjHvbEinJ6Ni5IMu4
         m8MiGaavd8xVBngfv6TupK48l3Fpez8AVqw/0VAKCDEO1pm038tY4zZ4OmSzmcGmTqpp
         MBM3viTJuwxMXIn2LWsi5drjBopAcLeFlKLc3I987BsMcxeBVMN5bfiXITS3tEAHyAaX
         ZkpAyJSSNg5H4KcCYtJsRxW0e/Z7nH389+lbuvBmmjPXwFY4WDg5bah3F1qg/2MzcC7Z
         rCLw==
X-Gm-Message-State: AOJu0YzvIK2cMb1yfPukXJt8iSxLDVSEgW8ZSaXjp/ZRdRraDS/OmdB1
	qGWWBAOPYYBNzTa67VsYn3gLQQ==
X-Google-Smtp-Source: AGHT+IFah7FuXLQI46WtzJOR+jgG6iAxLIZ9RjCnmGOROHIvLmJVD8yp/09D/Iywu+jv4I4GGnrfRA==
X-Received: by 2002:a17:906:ee82:b0:9be:3c8e:1506 with SMTP id wt2-20020a170906ee8200b009be3c8e1506mr2299570ejb.70.1698414475403;
        Fri, 27 Oct 2023 06:47:55 -0700 (PDT)
Received: from cloudflare.com (79.184.154.62.ipv4.supernova.orange.pl. [79.184.154.62])
        by smtp.gmail.com with ESMTPSA id ov7-20020a170906fc0700b00993cc1242d4sm1206864ejb.151.2023.10.27.06.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:47:54 -0700 (PDT)
References: <20231016190819.81307-1-john.fastabend@gmail.com>
 <20231016190819.81307-2-john.fastabend@gmail.com>
 <87fs289poz.fsf@cloudflare.com> <65383999941f3_1969a2083e@john.notmuch>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangyingliang@huawei.com,
 martin.lau@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: sockmap, af_unix sockets need to hold ref
 for pair sock
Date: Fri, 27 Oct 2023 15:32:15 +0200
In-reply-to: <65383999941f3_1969a2083e@john.notmuch>
Message-ID: <87o7gk18ja.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 24, 2023 at 02:39 PM -07, John Fastabend wrote:
> Jakub Sitnicki wrote:
>> On Mon, Oct 16, 2023 at 12:08 PM -07, John Fastabend wrote:
>> > AF_UNIX sockets are a paired socket. So sending on one of the pairs
>> > will lookup the paired socket as part of the send operation. It is
>> > possible however to put just one of the pairs in a BPF map. This
>> > currently increments the refcnt on the sock in the sockmap to
>> > ensure it is not free'd by the stack before sockmap cleans up its
>> > state and stops any skbs being sent/recv'd to that socket.
>> >
>> > But we missed a case. If the peer socket is closed it will be
>> > free'd by the stack. However, the paired socket can still be
>> > referenced from BPF sockmap side because we hold a reference
>> > there. Then if we are sending traffic through BPF sockmap to
>> > that socket it will try to dereference the free'd pair in its
>> > send logic creating a use after free.  And following splat,
>> >
>> >    [59.900375] BUG: KASAN: slab-use-after-free in sk_wake_async+0x31/0x1b0
>> >    [59.901211] Read of size 8 at addr ffff88811acbf060 by task kworker/1:2/954
>> >    [...]
>> >    [59.905468] Call Trace:
>> >    [59.905787]  <TASK>
>> >    [59.906066]  dump_stack_lvl+0x130/0x1d0
>> >    [59.908877]  print_report+0x16f/0x740
>> >    [59.910629]  kasan_report+0x118/0x160
>> >    [59.912576]  sk_wake_async+0x31/0x1b0
>> >    [59.913554]  sock_def_readable+0x156/0x2a0
>> >    [59.914060]  unix_stream_sendmsg+0x3f9/0x12a0
>> >    [59.916398]  sock_sendmsg+0x20e/0x250
>> >    [59.916854]  skb_send_sock+0x236/0xac0
>> >    [59.920527]  sk_psock_backlog+0x287/0xaa0
>> 
>> Isn't the problem here that unix_stream_sendmsg doesn't grab a ref to
>> peer sock? Unlike unix_dgram_sendmsg which uses the unix_peer_get
>> helper.
>
> It does by my read. In unix_stream_connect we have,
>
> 	sock_hold(sk);
> 	unix_peer(newsk)	= sk;
> 	newsk->sk_state		= TCP_ESTABLISHED;
>
> where it assigns the peer sock. unix_dgram_connect() also calls
> sock_hold() but through the path that does the socket lookup, such as
> unix_find_other().
>
> The problem I see is before the socket does the kfree on the
> sock we need to be sure the backlog is canceled and the skb list
> ingress_skb is purged. If we don't ensure this then the redirect
> will 
>
> My model is this,
>
>          s1            c1
> refcnt    1             1
> connect   2             2
> psock     3             3
> send(s1) ...
> close(s1) 2             1 <- close drops psock count also
> close(c1) 0             0
>
> The important bit here is the psock has a refcnt on the
> underlying sock (psock->sk) and wont dec that until after
> cancel_delayed_work_sync() completes. This ensures the
> backlog wont try to sendmsg() on that sock after we free
> it. We also check for SOCK_DEAD and abort to avoid sending
> over a socket that has been marked DEAD.
>
> So... After close(s1) the only thing keeping that sock
> around is c1. Then we close(c1) that call path is
>
>  unix_release
>    close() 
>    unix_release_sock()
>      skpair = unix_peer(sk);
>      ...
>      sock_put(skpair);  <- trouble here
>
> The release will call sock_put() on the pair socket and
> dec it to 0 where it gets free'd through sk_free(). But
> now the trouble is we haven't waited for cancel_delayed_work_sync()
> on the c1 socket yet so backlog can still run. When it does
> run it may try to send a pkg over socket s1. OK right up until
> the sendmsg(s1, ...) does a peer lookup and derefs the peer
> socket. The peer socket was free'd earlier so use after free. 
>
> The question I had originally was this is odd, we are allowing
> a sendmsg(s1) over a socket while its in unix_release(). We
> used to take the sock lock from the backlog that was dropped
> in the name of performance, but it creates these races.
>
> Other fixes I considered. First adding sock lock back to
> backlog. But that punishes the UDP and TCP cases that don't
> have this problem. Set the SOCK_DEAD flag earlier or check
> later but this just makes the race smaller doesn't really
> eliminate it.
>
> So this patch is what I came up with. 

What I was getting at is that we could make it safe to call sendmsg on a
unix stream sock while its peer is being release. And not just for
sockmap. I expect io_uring might have the same problem. But I didn't
actually check yet.

For that we could keep a ref to peer for the duration of sendmsg call,
like unix dgram does. Then 'other' doesn't become a stale pointer before
we're done with it.

Bumping ref count on each sendmsg is not free, but maybe its
acceptable. Unix dgram sockets live with it.

With a patch like below, I'm no longer able to trigger an UAF splat.

WDYT?

---8<---

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3e8a04a13668..48cf19ea9294 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2198,7 +2198,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out_err;
 	} else {
 		err = -ENOTCONN;
-		other = unix_peer(sk);
+		other = unix_peer_get(sk);
 		if (!other)
 			goto out_err;
 	}
@@ -2282,6 +2282,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 #endif
 
+	sock_put(other);
 	scm_destroy(&scm);
 
 	return sent;
@@ -2294,6 +2295,8 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		send_sig(SIGPIPE, current, 0);
 	err = -EPIPE;
 out_err:
+	if (other)
+		sock_put(other);
 	scm_destroy(&scm);
 	return sent ? : err;
 }

