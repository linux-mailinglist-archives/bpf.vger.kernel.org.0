Return-Path: <bpf+bounces-14287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E057E1F5F
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 12:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4526B28121F
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BAC18053;
	Mon,  6 Nov 2023 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bqvfUgCt"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F681EB2E
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 11:06:37 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254A4125
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 03:06:34 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso7087299a12.1
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 03:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1699268792; x=1699873592; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=YsCfIzoWq/DxNOmh9DbcaajzQhp4aRngc923rsmMCv8=;
        b=bqvfUgCtCRDAJXa5LuHYMiLhd8RtGLYyriubGzzPVIq2HbNNd90QvAqYmJ5G6BavtI
         B/SWAZqcNb8+Gr1gxVKENuR3P9cP4Qkq6N0SpRyU/i7jz17HbU7ajh2/33PD/YJ4Ex+t
         45hNuSeaPDZ6+GJLbyL1FlJyf80q/87N0gSsTkifC4bfm/u/Y1TUAdrdVK51f6A1fprl
         tBCRZxhw3Olkz3ZfmI4Aw44qelQ+WyyZmGp6b1yIa9FUGBmyy9UMcf7WMchMXK8ITePR
         ydJlxGKcYy5BizucNqKaDeXJ0cVuXj9E1UYjslw/aGoRbq9nnCjD/uPvBvUwzKk92bE1
         Y7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699268792; x=1699873592;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsCfIzoWq/DxNOmh9DbcaajzQhp4aRngc923rsmMCv8=;
        b=CVM0i5Ht4dosI9ul8MiJxHsV4LB0ErtlSAQNmehXt39gAySb4VGPlgun/WcpVFojP5
         KFTsdAqOHLZohmL8f6DYEg54Z1JSQvadU1I2EcBeuDQ8K364Vi/PNpKgvKziG1W3jOUM
         D+Ma+NvoKejX7YUkAqAIdHJF5zJTkhlJGBIUUmx0aB5ojbWjkgO/stHO8UivG9DrUp9M
         egiWFj6OCDk1HZEoxwyFZ+aPIMcI95o5cc4tqcyIcY/CXSKxzcc8zmJB85fol4UjO7Dz
         VXLmdrC0mIVZsdcFV2KrO8fkOc2ss8SkUao/d02FUypE262u7UUIPRlVGh96y/sr6j/3
         F88A==
X-Gm-Message-State: AOJu0YwzHXPA6iJRJ6Epe3M/FfXNI3Hm4RUOV6ThJD7biaxW8yvObiN2
	PFhADzhKEnTBOrVlNwgqAq/CyA==
X-Google-Smtp-Source: AGHT+IFmzejF8EeJpiWfAzNEb/ZoYcAaES3e9lV+rsP7bNqs+8npIe6IFO13AjfCninjPtv1NEkM2g==
X-Received: by 2002:a50:9356:0:b0:543:56c8:f84b with SMTP id n22-20020a509356000000b0054356c8f84bmr14221590eda.19.1699268792483;
        Mon, 06 Nov 2023 03:06:32 -0800 (PST)
Received: from cloudflare.com (79.184.209.104.ipv4.supernova.orange.pl. [79.184.209.104])
        by smtp.gmail.com with ESMTPSA id v19-20020a50d093000000b005434095b179sm4269555edd.92.2023.11.06.03.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 03:06:31 -0800 (PST)
References: <87o7gk18ja.fsf@cloudflare.com>
 <20231027173815.61906-1-kuniyu@amazon.com> <87jzr71967.fsf@cloudflare.com>
 <6545bc9f7e443_3358c208ae@john.notmuch>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, bpf@vger.kernel.org,
 martin.lau@kernel.org, netdev@vger.kernel.org, yangyingliang@huawei.com
Subject: Re: [PATCH bpf 1/2] bpf: sockmap, af_unix sockets need to hold ref
 for pair sock
Date: Mon, 06 Nov 2023 11:15:41 +0100
In-reply-to: <6545bc9f7e443_3358c208ae@john.notmuch>
Message-ID: <87h6lzjg3r.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 03, 2023 at 08:38 PM -07, John Fastabend wrote:
> Jakub Sitnicki wrote:
>> On Fri, Oct 27, 2023 at 10:38 AM -07, Kuniyuki Iwashima wrote:
>> > From: Jakub Sitnicki <jakub@cloudflare.com>
>> > Date: Fri, 27 Oct 2023 15:32:15 +0200
>> >> On Tue, Oct 24, 2023 at 02:39 PM -07, John Fastabend wrote:
>> >> > Jakub Sitnicki wrote:
>> >> >> On Mon, Oct 16, 2023 at 12:08 PM -07, John Fastabend wrote:
>> >> >> > AF_UNIX sockets are a paired socket. So sending on one of the pairs
>> >> >> > will lookup the paired socket as part of the send operation. It is
>> >> >> > possible however to put just one of the pairs in a BPF map. This
>> >> >> > currently increments the refcnt on the sock in the sockmap to
>> >> >> > ensure it is not free'd by the stack before sockmap cleans up its
>> >> >> > state and stops any skbs being sent/recv'd to that socket.
>> >> >> >
>> >> >> > But we missed a case. If the peer socket is closed it will be
>> >> >> > free'd by the stack. However, the paired socket can still be
>> >> >> > referenced from BPF sockmap side because we hold a reference
>> >> >> > there. Then if we are sending traffic through BPF sockmap to
>> >> >> > that socket it will try to dereference the free'd pair in its
>> >> >> > send logic creating a use after free.  And following splat,
>> >> >> >
>> >> >> >    [59.900375] BUG: KASAN: slab-use-after-free in sk_wake_async+0x31/0x1b0
>> >> >> >    [59.901211] Read of size 8 at addr ffff88811acbf060 by task kworker/1:2/954
>> >> >> >    [...]
>> >> >> >    [59.905468] Call Trace:
>> >> >> >    [59.905787]  <TASK>
>> >> >> >    [59.906066]  dump_stack_lvl+0x130/0x1d0
>> >> >> >    [59.908877]  print_report+0x16f/0x740
>> >> >> >    [59.910629]  kasan_report+0x118/0x160
>> >> >> >    [59.912576]  sk_wake_async+0x31/0x1b0
>> >> >> >    [59.913554]  sock_def_readable+0x156/0x2a0
>> >> >> >    [59.914060]  unix_stream_sendmsg+0x3f9/0x12a0
>> >> >> >    [59.916398]  sock_sendmsg+0x20e/0x250
>> >> >> >    [59.916854]  skb_send_sock+0x236/0xac0
>> >> >> >    [59.920527]  sk_psock_backlog+0x287/0xaa0
>> >> >> 
>> >> >> Isn't the problem here that unix_stream_sendmsg doesn't grab a ref to
>> >> >> peer sock? Unlike unix_dgram_sendmsg which uses the unix_peer_get
>> >> >> helper.
>> >> >
>> >> > It does by my read. In unix_stream_connect we have,
>> >> >
>> >> > 	sock_hold(sk);
>> >> > 	unix_peer(newsk)	= sk;
>> >> > 	newsk->sk_state		= TCP_ESTABLISHED;
>> >> >
>> >> > where it assigns the peer sock. unix_dgram_connect() also calls
>> >> > sock_hold() but through the path that does the socket lookup, such as
>> >> > unix_find_other().
>> >> >
>> >> > The problem I see is before the socket does the kfree on the
>> >> > sock we need to be sure the backlog is canceled and the skb list
>> >> > ingress_skb is purged. If we don't ensure this then the redirect
>> >> > will 
>> >> >
>> >> > My model is this,
>> >> >
>> >> >          s1            c1
>> >> > refcnt    1             1
>> >> > connect   2             2
>> >> > psock     3             3
>> >> > send(s1) ...
>> >> > close(s1) 2             1 <- close drops psock count also
>> >> > close(c1) 0             0
>> >> >
>> >> > The important bit here is the psock has a refcnt on the
>> >> > underlying sock (psock->sk) and wont dec that until after
>> >> > cancel_delayed_work_sync() completes. This ensures the
>> >> > backlog wont try to sendmsg() on that sock after we free
>> >> > it. We also check for SOCK_DEAD and abort to avoid sending
>> >> > over a socket that has been marked DEAD.
>> >> >
>> >> > So... After close(s1) the only thing keeping that sock
>> >> > around is c1. Then we close(c1) that call path is
>> >> >
>> >> >  unix_release
>> >> >    close() 
>> >> >    unix_release_sock()
>> >> >      skpair = unix_peer(sk);
>> >> >      ...
>> >> >      sock_put(skpair);  <- trouble here
>> >> >
>> >> > The release will call sock_put() on the pair socket and
>> >> > dec it to 0 where it gets free'd through sk_free(). But
>> >> > now the trouble is we haven't waited for cancel_delayed_work_sync()
>> >> > on the c1 socket yet so backlog can still run. When it does
>> >> > run it may try to send a pkg over socket s1. OK right up until
>> >> > the sendmsg(s1, ...) does a peer lookup and derefs the peer
>> >> > socket. The peer socket was free'd earlier so use after free. 
>> >> >
>> >> > The question I had originally was this is odd, we are allowing
>> >> > a sendmsg(s1) over a socket while its in unix_release(). We
>> >> > used to take the sock lock from the backlog that was dropped
>> >> > in the name of performance, but it creates these races.
>> >> >
>> >> > Other fixes I considered. First adding sock lock back to
>> >> > backlog. But that punishes the UDP and TCP cases that don't
>> >> > have this problem. Set the SOCK_DEAD flag earlier or check
>> >> > later but this just makes the race smaller doesn't really
>> >> > eliminate it.
>> >> >
>> >> > So this patch is what I came up with. 
>> >> 
>> >> What I was getting at is that we could make it safe to call sendmsg on a
>> >> unix stream sock while its peer is being release. And not just for
>> >> sockmap. I expect io_uring might have the same problem. But I didn't
>> >> actually check yet.
>> >> 
>> >> For that we could keep a ref to peer for the duration of sendmsg call,
>> >> like unix dgram does. Then 'other' doesn't become a stale pointer before
>> >> we're done with it.
>> >> 
>> >> Bumping ref count on each sendmsg is not free, but maybe its
>> >> acceptable. Unix dgram sockets live with it.
>> >
>> > The reason why only dgram sk needs sock_hold() for each sendmsg() is
>> > that dgram sk can send data without connect().  unix_peer_get() in
>> > unix_dgram_sendmsg() is to reuse the same code when peer is not set.
>> >
>> > unix_stream_sendmsg() already holds a necessary refcnt and need not
>> > use sock_hold() there.
>> >
>> > The user who touches a peer without lookup must hold refcnt beforehand.
>
> Hi, we probably do need to get a fix for this. syzkaller hit it again
> and anyways it likely will crash some real systems if folks try to use
> it with enough systems.
>
>> 
>> Right. And this ownership scheme works well for unix stream because, as
>> John nicely explained, we serialize close() and sendmsg() ops with sock
>> lock.
>> 
>> Here, however, we have a case of deferred work which holds a ref to sock
>> but does not grab the sock lock. While it is doing its thing, the sk
>> gets closed/released and we drop the skpair ref. And bam, UAF.
>> 
>> If it wasn't for the reference cycle between sk and skpair, we could
>> defer the skpari ref drop until sk_destruct callback. But we can't.
>> 
>> If grabbing a ref on skpair on each sendmsg turns out to be not a viable
>> option, I didn't run any benchmarks so can't say what's the penatly
>> like, the next best thing is RCU.
>
> I think it really would be best to stay out of the presumably hotpath
> here if we can.
>
> I had considered marking the socket SOCK_RCU_FREE which should then
> wait an rcu grace period. But then it wasn't clear to me that would
> completely solve the race. The psock still needs to do the 
> cancel_delayed_work_sync() and this is also done from the rcu call
> back on the psock. Withtout the extra reference iirc the concern
> was we would basically have two rcu callbacks running that have
> an ordering requirement which I don't think is ensured.
>

I've checked io_uring and it keeps a ref to the related file for the
lifetime the I/O request. So I think we are good there and it's only
sockmap that is "bleeding".

I agree it would be best not to hamper unix_stream sendmsg performance.

At the same time, I think we can easily make the extra ref grab in
unix_stream_sendmsg optional, keeping the fast path fast (modulo 2x a
branch op).

I realize RCU would be a bigger, riskier overhaul. Perhaps not worth it,
if there are no benefits for "the regular" unix_stream users.

If we can avoid managing more state in psock, that would be my
preference. But I don't want to block any fixes that users are waiting
for.

