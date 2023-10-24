Return-Path: <bpf+bounces-13164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BFA7D5D56
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C0E9B21118
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 21:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6810B3FB3E;
	Tue, 24 Oct 2023 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9l9tEGd"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9EF3F4B9;
	Tue, 24 Oct 2023 21:39:41 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC43133;
	Tue, 24 Oct 2023 14:39:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-578b4981526so2996375a12.0;
        Tue, 24 Oct 2023 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698183579; x=1698788379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1u7rF7+PGWtn6vzNDUNMiLZSr1ajMAb4nv6c8JYWc8=;
        b=b9l9tEGdDWf2ksHMYSmeoJH3MfKXmuRa+EXt1o6IZJ73qxWEiiqpBXq1Tiq8ax0kcf
         T9YZdX20QErAgyXZjGPTivis1068UNyP9ZvOSefa7OK2fwH25nV5iwMaq/ycx1AFnXnv
         99oMGxoHDtPb2pR37FE+cjNZf/mcKs8DYKoomlM5PenL8poNJ4irwzO6R7UzdPpAtCTU
         JvEFDuL6PVsYO9ru8kjlR81m+T3v6GkGFkVNE1+CV5a33hKHW9LgkasRjj/UJiNpDtru
         HUzqeWvxqa8LB8yPoWcW25trQ/V+CdpsQm+5mKJ7g7sDra8k0r596ZLh2OAC/qo9N8gp
         KU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183579; x=1698788379;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D1u7rF7+PGWtn6vzNDUNMiLZSr1ajMAb4nv6c8JYWc8=;
        b=i1odewG2LuivGgDMt2WSoqOkVEGlCc/x3Lq/A/5em+aPQB6Haj8p/gFLrdsCAYhkBw
         PXwtEkB4sdBIRTXHSZbtVysA+Kn4/cltsNUZklBpogEZ+HMPkbYAOiEVJCW6nQP6oXqP
         dXbHA14GVUt2Rt89OgrkJMN+cp/8uFdTveusiNnfC0aj6vWy0Xn+GAajaHWUMGCsogsn
         eIDoFFdhsDl9RtOG1DX1WXjInLqVq7banImuNjwzKwi+t9PAMpxlVn6nWrDv/YHLO/h2
         fL+1iqCOEwxoYj44Z1nBI9WA0yzK0mXSN4qjp+O+vsuhGW5bSm6Yc5nTrwKRg4MWffAB
         SwoQ==
X-Gm-Message-State: AOJu0YzfFiJ1zzHUBWEoR0lBH3E/AXrfz/RL0x3PA20JTa77YoUtDdR+
	b2DIRaJ26ERQzKqLS3Z3QvOCpQrnLCM=
X-Google-Smtp-Source: AGHT+IErWIx/T2oqalrOl3Y2VjgChfN1KyoME8Ff38az/+SbFKhCVHZnv6s1e1WkUFVFBc2tngRWBg==
X-Received: by 2002:a05:6a20:8401:b0:17a:d72a:629c with SMTP id c1-20020a056a20840100b0017ad72a629cmr4903527pzd.37.1698183579369;
        Tue, 24 Oct 2023 14:39:39 -0700 (PDT)
Received: from localhost ([98.97.36.36])
        by smtp.gmail.com with ESMTPSA id z21-20020aa79f95000000b0069323619f69sm8279085pfr.143.2023.10.24.14.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:39:38 -0700 (PDT)
Date: Tue, 24 Oct 2023 14:39:37 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 yangyingliang@huawei.com, 
 martin.lau@kernel.org
Message-ID: <65383999941f3_1969a2083e@john.notmuch>
In-Reply-To: <87fs289poz.fsf@cloudflare.com>
References: <20231016190819.81307-1-john.fastabend@gmail.com>
 <20231016190819.81307-2-john.fastabend@gmail.com>
 <87fs289poz.fsf@cloudflare.com>
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
> On Mon, Oct 16, 2023 at 12:08 PM -07, John Fastabend wrote:
> > AF_UNIX sockets are a paired socket. So sending on one of the pairs
> > will lookup the paired socket as part of the send operation. It is
> > possible however to put just one of the pairs in a BPF map. This
> > currently increments the refcnt on the sock in the sockmap to
> > ensure it is not free'd by the stack before sockmap cleans up its
> > state and stops any skbs being sent/recv'd to that socket.
> >
> > But we missed a case. If the peer socket is closed it will be
> > free'd by the stack. However, the paired socket can still be
> > referenced from BPF sockmap side because we hold a reference
> > there. Then if we are sending traffic through BPF sockmap to
> > that socket it will try to dereference the free'd pair in its
> > send logic creating a use after free.  And following splat,
> >
> >    [59.900375] BUG: KASAN: slab-use-after-free in sk_wake_async+0x31/0x1b0
> >    [59.901211] Read of size 8 at addr ffff88811acbf060 by task kworker/1:2/954
> >    [...]
> >    [59.905468] Call Trace:
> >    [59.905787]  <TASK>
> >    [59.906066]  dump_stack_lvl+0x130/0x1d0
> >    [59.908877]  print_report+0x16f/0x740
> >    [59.910629]  kasan_report+0x118/0x160
> >    [59.912576]  sk_wake_async+0x31/0x1b0
> >    [59.913554]  sock_def_readable+0x156/0x2a0
> >    [59.914060]  unix_stream_sendmsg+0x3f9/0x12a0
> >    [59.916398]  sock_sendmsg+0x20e/0x250
> >    [59.916854]  skb_send_sock+0x236/0xac0
> >    [59.920527]  sk_psock_backlog+0x287/0xaa0
> 
> Isn't the problem here that unix_stream_sendmsg doesn't grab a ref to
> peer sock? Unlike unix_dgram_sendmsg which uses the unix_peer_get
> helper.

It does by my read. In unix_stream_connect we have,

	sock_hold(sk);
	unix_peer(newsk)	= sk;
	newsk->sk_state		= TCP_ESTABLISHED;

where it assigns the peer sock. unix_dgram_connect() also calls
sock_hold() but through the path that does the socket lookup, such as
unix_find_other().

The problem I see is before the socket does the kfree on the
sock we need to be sure the backlog is canceled and the skb list
ingress_skb is purged. If we don't ensure this then the redirect
will 

My model is this,

         s1            c1
refcnt    1             1
connect   2             2
psock     3             3
send(s1) ...
close(s1) 2             1 <- close drops psock count also
close(c1) 0             0

The important bit here is the psock has a refcnt on the
underlying sock (psock->sk) and wont dec that until after
cancel_delayed_work_sync() completes. This ensures the
backlog wont try to sendmsg() on that sock after we free
it. We also check for SOCK_DEAD and abort to avoid sending
over a socket that has been marked DEAD.

So... After close(s1) the only thing keeping that sock
around is c1. Then we close(c1) that call path is

 unix_release
   close() 
   unix_release_sock()
     skpair = unix_peer(sk);
     ...
     sock_put(skpair);  <- trouble here

The release will call sock_put() on the pair socket and
dec it to 0 where it gets free'd through sk_free(). But
now the trouble is we haven't waited for cancel_delayed_work_sync()
on the c1 socket yet so backlog can still run. When it does
run it may try to send a pkg over socket s1. OK right up until
the sendmsg(s1, ...) does a peer lookup and derefs the peer
socket. The peer socket was free'd earlier so use after free. 

The question I had originally was this is odd, we are allowing
a sendmsg(s1) over a socket while its in unix_release(). We
used to take the sock lock from the backlog that was dropped
in the name of performance, but it creates these races.

Other fixes I considered. First adding sock lock back to
backlog. But that punishes the UDP and TCP cases that don't
have this problem. Set the SOCK_DEAD flag earlier or check
later but this just makes the race smaller doesn't really
eliminate it.

So this patch is what I came up with. 

> 
> >
> > To fix let BPF sockmap hold a refcnt on both the socket in the
> > sockmap and its paired socket.  It wasn't obvious how to contain
> > the fix to bpf_unix logic. The primarily problem with keeping this
> > logic in bpf_unix was: In the sock close() we could handle the
> > deref by having a close handler. But, when we are destroying the
> > psock through a map delete operation we wouldn't have gotten any
> > signal thorugh the proto struct other than it being replaced.
> > If we do the deref from the proto replace its too early because
> > we need to deref the skpair after the backlog worker has been
> > stopped.
> >
> > Given all this it seems best to just cache it at the end of the
> > psock and eat 8B for the af_unix and vsock users.
> >
> > Fixes: 94531cfcbe79 ("af_unix: Add unix_stream_proto for sockmap")
> > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > ---
> 
> [...]



