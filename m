Return-Path: <bpf+bounces-16644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E4A804109
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 22:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3297281244
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 21:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1538FA3;
	Mon,  4 Dec 2023 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXA3q2Vl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E463BB;
	Mon,  4 Dec 2023 13:40:43 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-58d3c9badf5so3395016eaf.1;
        Mon, 04 Dec 2023 13:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701726042; x=1702330842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgnlssux72HxJisuzCNboaalKapVb8OejwykiJLLAM4=;
        b=AXA3q2VlrSsIfu+q/lb/XXHSnuPsdX9T3EAHtjllCIfeSE96MSF2y27M8mhhI3uP0n
         eDu2qR9td5UEV4GmboLtBAlRQZBkA3qE5PiVCgXiCXNg93BiXgVlyCee7tFDtENQnr8n
         uxVmnOuYZyLll2g+GzXpuLsrqQQTxAUOBgy65FAKt/0c7H2uFOsguEeZqguP2g84vewf
         t3rfhmdEmDvKG4f2NkkOpDyjW+PEsMPpPd2jXR9EmVSAuUjQ2MXiDvahI8J8I/+CMWot
         KoJ0XAGdsr/Xn6Yhj/LfElAWhqXdE3K6lBUdDSu7sFFgCZihpGSgQUyR0pIpPu4LHraG
         DfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701726042; x=1702330842;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bgnlssux72HxJisuzCNboaalKapVb8OejwykiJLLAM4=;
        b=YXEwJNLJjep1HRdLLK3rmuQuav9IhkTXL1KJqsi8B9V85DrS1LRk8mnqzJ/ZVaaUE2
         3SCMv+nPKjLsmT0v90uheM38r7Bz3GLhxwwe0ZBCYKB5T9VIYXoT6vTuCjLCk7T/rwlq
         KsiNBrcPWeBMavDOsMYyg8WOf53LeXBMyAOD9+npDeY3CCpnScALT6E6Y+DUUTYfuFkX
         xDbuGFy0L0D/f/1bFR9Swnn1sAGFdz9zAUdxisRw+FIbDTL3+V21OoeVFhbXTX/n2USw
         7/6VLNdlNnB5Summb85LdIWch4YmUTrI2+YxNjQt7Phuf/X8XQjEK8I+qaVTKbSQMUaN
         bXyA==
X-Gm-Message-State: AOJu0YwS8rsbSrPARpj4KAsX9cDGduooXdyzM1uJfINgtjv5gm981JXr
	oWnRNQxLR5t3Rivjp9bGoYI=
X-Google-Smtp-Source: AGHT+IHptWCzknBSLqGfI4G/TxI2ne8LjlSHh4VPMjX/ZtAmCqymN++mJkaw1rpY8ECHo+Kw65e5PA==
X-Received: by 2002:a05:6358:7e12:b0:170:17eb:204b with SMTP id o18-20020a0563587e1200b0017017eb204bmr5104566rwm.52.1701726042279;
        Mon, 04 Dec 2023 13:40:42 -0800 (PST)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id a12-20020a63e40c000000b0059cc2f1b7basm7997694pgi.11.2023.12.04.13.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 13:40:41 -0800 (PST)
Date: Mon, 04 Dec 2023 13:40:40 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, 
 edumazet@google.com, 
 jakub@cloudflare.com, 
 martin.lau@kernel.org, 
 netdev@vger.kernel.org, 
 kuniyu@amazon.com
Message-ID: <656e4758675b9_1bd6e2086f@john.notmuch>
In-Reply-To: <20231201211453.27432-1-kuniyu@amazon.com>
References: <20231201180139.328529-2-john.fastabend@gmail.com>
 <20231201211453.27432-1-kuniyu@amazon.com>
Subject: RE: [PATCH bpf v2 1/2] bpf: syzkaller found null ptr deref in
 unix_bpf proto add
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: John Fastabend <john.fastabend@gmail.com>
> Date: Fri,  1 Dec 2023 10:01:38 -0800
> > I added logic to track the sock pair for stream_unix sockets so that we
> > ensure lifetime of the sock matches the time a sockmap could reference
> > the sock (see fixes tag). I forgot though that we allow af_unix unconnected
> > sockets into a sock{map|hash} map.
> > 
> > This is problematic because previous fixed expected sk_pair() to exist
> > and did not NULL check it. Because unconnected sockets have a NULL
> > sk_pair this resulted in the NULL ptr dereference found by syzkaller.
> > 
> > BUG: KASAN: null-ptr-deref in unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
> > Write of size 4 at addr 0000000000000080 by task syz-executor360/5073
> > Call Trace:
> >  <TASK>
> >  ...
> >  sock_hold include/net/sock.h:777 [inline]
> >  unix_stream_bpf_update_proto+0x72/0x430 net/unix/unix_bpf.c:171
> >  sock_map_init_proto net/core/sock_map.c:190 [inline]
> >  sock_map_link+0xb87/0x1100 net/core/sock_map.c:294
> >  sock_map_update_common+0xf6/0x870 net/core/sock_map.c:483
> >  sock_map_update_elem_sys+0x5b6/0x640 net/core/sock_map.c:577
> >  bpf_map_update_value+0x3af/0x820 kernel/bpf/syscall.c:167
> > 
> > We considered just checking for the null ptr and skipping taking a ref
> > on the NULL peer sock. But, if the socket is then connected() after
> > being added to the sockmap we can cause the original issue again. So
> > instead this patch blocks adding af_unix sockets that are not in the
> > ESTABLISHED state.
> 
> I'm not sure if someone has the unconnected stream socket use case
> though, can't we call additional sock_hold() in connect() by checking
> sk_prot under sk_callback_lock ?

Could be done I guess yes. I'm not sure the utility of it though. I
thought above patch was the simplest solution and didn't require touching
main af_unix code. I don't actually use the sockmap with af_unix
sockets anywhere so maybe someone who is using this can comment if
unconnected is needed?

From rcu and locking side looks like holding sk_callback_lock would
be sufficient. I was thinking it would require a rcu grace period
or something but seems not.

I guess I could improve original patch if folks want.

.John

