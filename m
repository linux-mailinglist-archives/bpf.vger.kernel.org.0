Return-Path: <bpf+bounces-13542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA637DA587
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 09:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9C92826C6
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 07:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3442363A5;
	Sat, 28 Oct 2023 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Qx1LnY+c"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769C442B
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 07:46:30 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2656F1
	for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 00:46:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53f6ccea1eeso4760196a12.3
        for <bpf@vger.kernel.org>; Sat, 28 Oct 2023 00:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698479186; x=1699083986; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=YCC0JdMebFX9RPd69GwUuJLcqb2UiYWmLDSxWD0lIsc=;
        b=Qx1LnY+cRKaZAS4uIF6ola0doODsnLR8s4WoR8OwMSEjokDJYdB7HX6uM66vrgmHFp
         1dUNTL3APs4ui5iIhgmZhl4k/FAJ/lFxkO1y8PVNjjow4iz0pjQJPnoEdu7CYiL2McwC
         lIq2llCz9ry4SmGXfdqe02MqMNMSbxxfL+H5fX4aQoW7BKntvihLD3jgIXq/8PasvXvY
         D4feQJup3ICowW1pn1RC6838j1hsZ2UcrJK+520WSKzY/u3bjetgBoACsIUxGyTaZSYL
         chmt/SsbB74LlAns8EaMDJ5X6wInH+7i3KkRyouUAfcoEoafiKg4/6FOy3/9uQhocA/P
         gJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698479186; x=1699083986;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCC0JdMebFX9RPd69GwUuJLcqb2UiYWmLDSxWD0lIsc=;
        b=MSL0Lf1bxEjlXJyxOR+pCdBZjfEUEko/lG5kZI6F3Uhr7wpvQfR+zPi2a8Vo5ApRnd
         KrlCINB/+p23ZVdQ+HU7UElT2SE0bKFNq/kCzIOz0bEBPitXUK1nEX3T6+Ff9domhlkK
         mlvJ4YGELf2r9j0f+IL1ZNNlmv8cTziJ8HTanT06LSQ2uLCfPYC/EJ4ZLh8V/mU5GTkB
         F9bivjrYP1+ziatMDDLK6APYprg5BVR9qiU7IseUWDpepcrRnrAusDR41VnRGEImxax6
         7zbR6xeooQ29yB4cKXGGEEjnE4CtBmx/dzIfl2H5dKxsjhTKGVDkSIy6Qm/227e23mZ0
         5orw==
X-Gm-Message-State: AOJu0Yw+SPHZ3NNXoQSZ3OTHRUSQ6PSO1wqa/okiGdyq8tFpyWs2QFTi
	i0h7adPniaJ/YjicnOoEWib7dQ==
X-Google-Smtp-Source: AGHT+IEcN/NmhY4nWO+1Qo5ysW5y3/XlYvhb+IVy0h+fVlnMHbGVb8lEOFug9PD4Ly2MDDE0fXwTHA==
X-Received: by 2002:a17:906:c14d:b0:9c3:8f7a:3e8a with SMTP id dp13-20020a170906c14d00b009c38f7a3e8amr3695083ejc.15.1698479186064;
        Sat, 28 Oct 2023 00:46:26 -0700 (PDT)
Received: from cloudflare.com (79.184.154.62.ipv4.supernova.orange.pl. [79.184.154.62])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709063e0500b009b8a4f9f20esm2360151eji.102.2023.10.28.00.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 00:46:25 -0700 (PDT)
References: <87o7gk18ja.fsf@cloudflare.com>
 <20231027173815.61906-1-kuniyu@amazon.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bpf@vger.kernel.org, john.fastabend@gmail.com, martin.lau@kernel.org,
 netdev@vger.kernel.org, yangyingliang@huawei.com
Subject: Re: [PATCH bpf 1/2] bpf: sockmap, af_unix sockets need to hold ref
 for pair sock
Date: Sat, 28 Oct 2023 09:33:21 +0200
In-reply-to: <20231027173815.61906-1-kuniyu@amazon.com>
Message-ID: <87jzr71967.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 27, 2023 at 10:38 AM -07, Kuniyuki Iwashima wrote:
> From: Jakub Sitnicki <jakub@cloudflare.com>
> Date: Fri, 27 Oct 2023 15:32:15 +0200
>> On Tue, Oct 24, 2023 at 02:39 PM -07, John Fastabend wrote:
>> > Jakub Sitnicki wrote:
>> >> On Mon, Oct 16, 2023 at 12:08 PM -07, John Fastabend wrote:
>> >> > AF_UNIX sockets are a paired socket. So sending on one of the pairs
>> >> > will lookup the paired socket as part of the send operation. It is
>> >> > possible however to put just one of the pairs in a BPF map. This
>> >> > currently increments the refcnt on the sock in the sockmap to
>> >> > ensure it is not free'd by the stack before sockmap cleans up its
>> >> > state and stops any skbs being sent/recv'd to that socket.
>> >> >
>> >> > But we missed a case. If the peer socket is closed it will be
>> >> > free'd by the stack. However, the paired socket can still be
>> >> > referenced from BPF sockmap side because we hold a reference
>> >> > there. Then if we are sending traffic through BPF sockmap to
>> >> > that socket it will try to dereference the free'd pair in its
>> >> > send logic creating a use after free.  And following splat,
>> >> >
>> >> >    [59.900375] BUG: KASAN: slab-use-after-free in sk_wake_async+0x31/0x1b0
>> >> >    [59.901211] Read of size 8 at addr ffff88811acbf060 by task kworker/1:2/954
>> >> >    [...]
>> >> >    [59.905468] Call Trace:
>> >> >    [59.905787]  <TASK>
>> >> >    [59.906066]  dump_stack_lvl+0x130/0x1d0
>> >> >    [59.908877]  print_report+0x16f/0x740
>> >> >    [59.910629]  kasan_report+0x118/0x160
>> >> >    [59.912576]  sk_wake_async+0x31/0x1b0
>> >> >    [59.913554]  sock_def_readable+0x156/0x2a0
>> >> >    [59.914060]  unix_stream_sendmsg+0x3f9/0x12a0
>> >> >    [59.916398]  sock_sendmsg+0x20e/0x250
>> >> >    [59.916854]  skb_send_sock+0x236/0xac0
>> >> >    [59.920527]  sk_psock_backlog+0x287/0xaa0
>> >> 
>> >> Isn't the problem here that unix_stream_sendmsg doesn't grab a ref to
>> >> peer sock? Unlike unix_dgram_sendmsg which uses the unix_peer_get
>> >> helper.
>> >
>> > It does by my read. In unix_stream_connect we have,
>> >
>> > 	sock_hold(sk);
>> > 	unix_peer(newsk)	= sk;
>> > 	newsk->sk_state		= TCP_ESTABLISHED;
>> >
>> > where it assigns the peer sock. unix_dgram_connect() also calls
>> > sock_hold() but through the path that does the socket lookup, such as
>> > unix_find_other().
>> >
>> > The problem I see is before the socket does the kfree on the
>> > sock we need to be sure the backlog is canceled and the skb list
>> > ingress_skb is purged. If we don't ensure this then the redirect
>> > will 
>> >
>> > My model is this,
>> >
>> >          s1            c1
>> > refcnt    1             1
>> > connect   2             2
>> > psock     3             3
>> > send(s1) ...
>> > close(s1) 2             1 <- close drops psock count also
>> > close(c1) 0             0
>> >
>> > The important bit here is the psock has a refcnt on the
>> > underlying sock (psock->sk) and wont dec that until after
>> > cancel_delayed_work_sync() completes. This ensures the
>> > backlog wont try to sendmsg() on that sock after we free
>> > it. We also check for SOCK_DEAD and abort to avoid sending
>> > over a socket that has been marked DEAD.
>> >
>> > So... After close(s1) the only thing keeping that sock
>> > around is c1. Then we close(c1) that call path is
>> >
>> >  unix_release
>> >    close() 
>> >    unix_release_sock()
>> >      skpair = unix_peer(sk);
>> >      ...
>> >      sock_put(skpair);  <- trouble here
>> >
>> > The release will call sock_put() on the pair socket and
>> > dec it to 0 where it gets free'd through sk_free(). But
>> > now the trouble is we haven't waited for cancel_delayed_work_sync()
>> > on the c1 socket yet so backlog can still run. When it does
>> > run it may try to send a pkg over socket s1. OK right up until
>> > the sendmsg(s1, ...) does a peer lookup and derefs the peer
>> > socket. The peer socket was free'd earlier so use after free. 
>> >
>> > The question I had originally was this is odd, we are allowing
>> > a sendmsg(s1) over a socket while its in unix_release(). We
>> > used to take the sock lock from the backlog that was dropped
>> > in the name of performance, but it creates these races.
>> >
>> > Other fixes I considered. First adding sock lock back to
>> > backlog. But that punishes the UDP and TCP cases that don't
>> > have this problem. Set the SOCK_DEAD flag earlier or check
>> > later but this just makes the race smaller doesn't really
>> > eliminate it.
>> >
>> > So this patch is what I came up with. 
>> 
>> What I was getting at is that we could make it safe to call sendmsg on a
>> unix stream sock while its peer is being release. And not just for
>> sockmap. I expect io_uring might have the same problem. But I didn't
>> actually check yet.
>> 
>> For that we could keep a ref to peer for the duration of sendmsg call,
>> like unix dgram does. Then 'other' doesn't become a stale pointer before
>> we're done with it.
>> 
>> Bumping ref count on each sendmsg is not free, but maybe its
>> acceptable. Unix dgram sockets live with it.
>
> The reason why only dgram sk needs sock_hold() for each sendmsg() is
> that dgram sk can send data without connect().  unix_peer_get() in
> unix_dgram_sendmsg() is to reuse the same code when peer is not set.
>
> unix_stream_sendmsg() already holds a necessary refcnt and need not
> use sock_hold() there.
>
> The user who touches a peer without lookup must hold refcnt beforehand.

Right. And this ownership scheme works well for unix stream because, as
John nicely explained, we serialize close() and sendmsg() ops with sock
lock.

Here, however, we have a case of deferred work which holds a ref to sock
but does not grab the sock lock. While it is doing its thing, the sk
gets closed/released and we drop the skpair ref. And bam, UAF.

If it wasn't for the reference cycle between sk and skpair, we could
defer the skpari ref drop until sk_destruct callback. But we can't.

If grabbing a ref on skpair on each sendmsg turns out to be not a viable
option, I didn't run any benchmarks so can't say what's the penatly
like, the next best thing is RCU.

If we can protect the skpair pointer with RCU, the memory it points to
will stay valid until unix_stream_sendmsg is done with it. I have not
given this approach a shot, so there might be something in the way.

[...]

