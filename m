Return-Path: <bpf+bounces-14201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9067E0D80
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 04:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5761C21172
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 03:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6838C522F;
	Sat,  4 Nov 2023 03:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ur6+zHTs"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446131FDD;
	Sat,  4 Nov 2023 03:38:12 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ADCBF;
	Fri,  3 Nov 2023 20:38:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso2136591a12.1;
        Fri, 03 Nov 2023 20:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699069090; x=1699673890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvHNtf6AhG9/naNnzoB56G+IN7g811kIBPIbnd0C8h4=;
        b=Ur6+zHTsNsSVpMHk5JOACMQFj2UmZmnFXDbxJ74bTLt312BeN6a3AC3cJoBynUCK6l
         ZabVfw2/bXMjIjPGkn+3uYBtKOWVfPDf48sFBI+eTG2r65qoSd43I0hgp+4+F6qHNV+k
         1Tz6XGaEFZen+Ps996B78k84XxmTNmVhhGQZsVnkYUK8p/REq7r0vjgUv9Ak21CPIXug
         kgMuUNdOeHnwMEXr1qFc7nNdIxiwObrMNsv9luRYwgN4Gz0jZsRv85d69j5p/mVnX3UP
         5tv4W8sXaSryCcGyrF2s1mkhGSVgX8mK3yYYQSTmZ/dxEPT3s+7qAab2sqvCJ8DIQ/rx
         MvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699069090; x=1699673890;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DvHNtf6AhG9/naNnzoB56G+IN7g811kIBPIbnd0C8h4=;
        b=uxXm65kru1SGvGADISW/LbbJjqmk33lkRKTYhqURKh3suKoX/6G4lFZ5SNiq2vy5KJ
         DIrsKz6m7+zJ7CY93lMnIMPBaDE0aa5kr2wvvi4pKJwgxthJbUjGYC2vpO24kpEFEd2d
         nuVhdLnGyLT6+Zs7DgoUEyelW8UjnOIpHB41PO16vV7iktXWyvU/NIprVMcykPZEK4OY
         Xk2DtrBTclT4v8XCku/Y1s7B/1haQafrgnszGZscJowS4TNH6CiyuUKc5r+J6qQ25B9B
         2qcIxfvKXFNdVc9Cpa6HiArQDaC+YhtKRbFcNBtZhdzJBVsFEYlvuhA7963iY5AptglW
         WBwA==
X-Gm-Message-State: AOJu0YzKafNw9hBumyvWSGhbddFcyNqcyAHHBEnVyGyyyIhDXRT0lRux
	u7f5PUG5XdJFU0lUC54orvie6cATzfA=
X-Google-Smtp-Source: AGHT+IFcm7ZpQCnxmm4We79G2P70V+eGGxYM78pOELrK4ix42ud5l13GNNPjeuSSk6sa7Vrf7DpMTQ==
X-Received: by 2002:a05:6a21:193:b0:16a:b651:dcd6 with SMTP id le19-20020a056a21019300b0016ab651dcd6mr31773082pzb.7.1699069089886;
        Fri, 03 Nov 2023 20:38:09 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00::41f])
        by smtp.gmail.com with ESMTPSA id h25-20020aa786d9000000b006be047268d5sm2145790pfo.174.2023.11.03.20.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 20:38:08 -0700 (PDT)
Date: Fri, 03 Nov 2023 20:38:07 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bpf@vger.kernel.org, 
 john.fastabend@gmail.com, 
 martin.lau@kernel.org, 
 netdev@vger.kernel.org, 
 yangyingliang@huawei.com
Message-ID: <6545bc9f7e443_3358c208ae@john.notmuch>
In-Reply-To: <87jzr71967.fsf@cloudflare.com>
References: <87o7gk18ja.fsf@cloudflare.com>
 <20231027173815.61906-1-kuniyu@amazon.com>
 <87jzr71967.fsf@cloudflare.com>
Subject: Re: [PATCH bpf 1/2] bpf: sockmap, af_unix sockets need to hold ref
 for pair sock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> On Fri, Oct 27, 2023 at 10:38 AM -07, Kuniyuki Iwashima wrote:
> > From: Jakub Sitnicki <jakub@cloudflare.com>
> > Date: Fri, 27 Oct 2023 15:32:15 +0200
> >> On Tue, Oct 24, 2023 at 02:39 PM -07, John Fastabend wrote:
> >> > Jakub Sitnicki wrote:
> >> >> On Mon, Oct 16, 2023 at 12:08 PM -07, John Fastabend wrote:
> >> >> > AF_UNIX sockets are a paired socket. So sending on one of the pairs
> >> >> > will lookup the paired socket as part of the send operation. It is
> >> >> > possible however to put just one of the pairs in a BPF map. This
> >> >> > currently increments the refcnt on the sock in the sockmap to
> >> >> > ensure it is not free'd by the stack before sockmap cleans up its
> >> >> > state and stops any skbs being sent/recv'd to that socket.
> >> >> >
> >> >> > But we missed a case. If the peer socket is closed it will be
> >> >> > free'd by the stack. However, the paired socket can still be
> >> >> > referenced from BPF sockmap side because we hold a reference
> >> >> > there. Then if we are sending traffic through BPF sockmap to
> >> >> > that socket it will try to dereference the free'd pair in its
> >> >> > send logic creating a use after free.  And following splat,
> >> >> >
> >> >> >    [59.900375] BUG: KASAN: slab-use-after-free in sk_wake_async+0x31/0x1b0
> >> >> >    [59.901211] Read of size 8 at addr ffff88811acbf060 by task kworker/1:2/954
> >> >> >    [...]
> >> >> >    [59.905468] Call Trace:
> >> >> >    [59.905787]  <TASK>
> >> >> >    [59.906066]  dump_stack_lvl+0x130/0x1d0
> >> >> >    [59.908877]  print_report+0x16f/0x740
> >> >> >    [59.910629]  kasan_report+0x118/0x160
> >> >> >    [59.912576]  sk_wake_async+0x31/0x1b0
> >> >> >    [59.913554]  sock_def_readable+0x156/0x2a0
> >> >> >    [59.914060]  unix_stream_sendmsg+0x3f9/0x12a0
> >> >> >    [59.916398]  sock_sendmsg+0x20e/0x250
> >> >> >    [59.916854]  skb_send_sock+0x236/0xac0
> >> >> >    [59.920527]  sk_psock_backlog+0x287/0xaa0
> >> >> 
> >> >> Isn't the problem here that unix_stream_sendmsg doesn't grab a ref to
> >> >> peer sock? Unlike unix_dgram_sendmsg which uses the unix_peer_get
> >> >> helper.
> >> >
> >> > It does by my read. In unix_stream_connect we have,
> >> >
> >> > 	sock_hold(sk);
> >> > 	unix_peer(newsk)	= sk;
> >> > 	newsk->sk_state		= TCP_ESTABLISHED;
> >> >
> >> > where it assigns the peer sock. unix_dgram_connect() also calls
> >> > sock_hold() but through the path that does the socket lookup, such as
> >> > unix_find_other().
> >> >
> >> > The problem I see is before the socket does the kfree on the
> >> > sock we need to be sure the backlog is canceled and the skb list
> >> > ingress_skb is purged. If we don't ensure this then the redirect
> >> > will 
> >> >
> >> > My model is this,
> >> >
> >> >          s1            c1
> >> > refcnt    1             1
> >> > connect   2             2
> >> > psock     3             3
> >> > send(s1) ...
> >> > close(s1) 2             1 <- close drops psock count also
> >> > close(c1) 0             0
> >> >
> >> > The important bit here is the psock has a refcnt on the
> >> > underlying sock (psock->sk) and wont dec that until after
> >> > cancel_delayed_work_sync() completes. This ensures the
> >> > backlog wont try to sendmsg() on that sock after we free
> >> > it. We also check for SOCK_DEAD and abort to avoid sending
> >> > over a socket that has been marked DEAD.
> >> >
> >> > So... After close(s1) the only thing keeping that sock
> >> > around is c1. Then we close(c1) that call path is
> >> >
> >> >  unix_release
> >> >    close() 
> >> >    unix_release_sock()
> >> >      skpair = unix_peer(sk);
> >> >      ...
> >> >      sock_put(skpair);  <- trouble here
> >> >
> >> > The release will call sock_put() on the pair socket and
> >> > dec it to 0 where it gets free'd through sk_free(). But
> >> > now the trouble is we haven't waited for cancel_delayed_work_sync()
> >> > on the c1 socket yet so backlog can still run. When it does
> >> > run it may try to send a pkg over socket s1. OK right up until
> >> > the sendmsg(s1, ...) does a peer lookup and derefs the peer
> >> > socket. The peer socket was free'd earlier so use after free. 
> >> >
> >> > The question I had originally was this is odd, we are allowing
> >> > a sendmsg(s1) over a socket while its in unix_release(). We
> >> > used to take the sock lock from the backlog that was dropped
> >> > in the name of performance, but it creates these races.
> >> >
> >> > Other fixes I considered. First adding sock lock back to
> >> > backlog. But that punishes the UDP and TCP cases that don't
> >> > have this problem. Set the SOCK_DEAD flag earlier or check
> >> > later but this just makes the race smaller doesn't really
> >> > eliminate it.
> >> >
> >> > So this patch is what I came up with. 
> >> 
> >> What I was getting at is that we could make it safe to call sendmsg on a
> >> unix stream sock while its peer is being release. And not just for
> >> sockmap. I expect io_uring might have the same problem. But I didn't
> >> actually check yet.
> >> 
> >> For that we could keep a ref to peer for the duration of sendmsg call,
> >> like unix dgram does. Then 'other' doesn't become a stale pointer before
> >> we're done with it.
> >> 
> >> Bumping ref count on each sendmsg is not free, but maybe its
> >> acceptable. Unix dgram sockets live with it.
> >
> > The reason why only dgram sk needs sock_hold() for each sendmsg() is
> > that dgram sk can send data without connect().  unix_peer_get() in
> > unix_dgram_sendmsg() is to reuse the same code when peer is not set.
> >
> > unix_stream_sendmsg() already holds a necessary refcnt and need not
> > use sock_hold() there.
> >
> > The user who touches a peer without lookup must hold refcnt beforehand.

Hi, we probably do need to get a fix for this. syzkaller hit it again
and anyways it likely will crash some real systems if folks try to use
it with enough systems.

> 
> Right. And this ownership scheme works well for unix stream because, as
> John nicely explained, we serialize close() and sendmsg() ops with sock
> lock.
> 
> Here, however, we have a case of deferred work which holds a ref to sock
> but does not grab the sock lock. While it is doing its thing, the sk
> gets closed/released and we drop the skpair ref. And bam, UAF.
> 
> If it wasn't for the reference cycle between sk and skpair, we could
> defer the skpari ref drop until sk_destruct callback. But we can't.
> 
> If grabbing a ref on skpair on each sendmsg turns out to be not a viable
> option, I didn't run any benchmarks so can't say what's the penatly
> like, the next best thing is RCU.

I think it really would be best to stay out of the presumably hotpath
here if we can.

I had considered marking the socket SOCK_RCU_FREE which should then
wait an rcu grace period. But then it wasn't clear to me that would
completely solve the race. The psock still needs to do the 
cancel_delayed_work_sync() and this is also done from the rcu call
back on the psock. Withtout the extra reference iirc the concern
was we would basically have two rcu callbacks running that have
an ordering requirement which I don't think is ensured.

> 
> If we can protect the skpair pointer with RCU, the memory it points to
> will stay valid until unix_stream_sendmsg is done with it. I have not
> given this approach a shot, so there might be something in the way.
> 
> [...]

Thanks,
John

