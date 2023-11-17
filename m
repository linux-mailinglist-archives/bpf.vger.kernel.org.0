Return-Path: <bpf+bounces-15218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D2C7EEAB5
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 02:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6F07B20B3E
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 01:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30EE138F;
	Fri, 17 Nov 2023 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgRObeCY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDD71A8;
	Thu, 16 Nov 2023 17:32:53 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so1173458a12.2;
        Thu, 16 Nov 2023 17:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700184773; x=1700789573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hu/ZPQV80A4ISgZrwoGV5UgX5RK6K+Si4rWx0zCLHuc=;
        b=DgRObeCY2B2RY/QWfPXsZ0ec5mVQO8S5a07iXR8s7/omzVMLwXRs0e13bibb91a4n8
         4t1WOfaPu6M4AgOA5MjCk8NMiip5c2JOMhimGZq3fxp7/smnyVWTmvZlJHGOhJ99JHXa
         2J21mYi+dGtQtHVvFWZ0Or2XJ+YSwR2LbjHrVBK92csOqrh+e8hXgyjic44fZ53T3c80
         FDiigeJwYw0apzPbPfR4sgsxIGNZAq9I9M9ECQXnkTeeDSOvnmxyVqOyc99SoSAqLJmn
         cxJGmR+CttE94vPgAYlZjCS0Cl0VVQNvAnnwQCJujm1Ih0gdDrL7uKCGowiNFC4q6dNt
         f0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700184773; x=1700789573;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hu/ZPQV80A4ISgZrwoGV5UgX5RK6K+Si4rWx0zCLHuc=;
        b=Pkpyz3v567T/mxW3Z+dJ4/F4jEpVV1teSG2e5nRFUi5KTa25KKxYY9FNzS1Lr2BS4m
         tOrHHvCWVMk7wL497NdW3ZbiGLC/fi5vhKpiYvL4I9KCMwhXbcD3BnEyXFKDnCRSFBei
         HhEh/fzbW4pg5b79QkHKiqTZElh3AurqKNBayNUK87D+AWs40BLCBasyVB1XsmsV24x5
         4nIOMD6P1kN9EFrtWeVPTUPwOUAYpR6c5qjcSXNsJDXFhXoxm1vqrDf63o2Ox2P/uHTw
         mPhZpaJQGkj8lZ0gXjj9fxMu/QCjQzpamjmBgGNKi5TjC3KbI32wjOvt9B5uN5Y7zpJ/
         uUMQ==
X-Gm-Message-State: AOJu0YxgaVUFcVsARWZ/taRMf0oQTKki9x1IJ4XdFAzY2LIiIEwbivQl
	8YtTEmtAxtnOCPcKRNjXPDE=
X-Google-Smtp-Source: AGHT+IElEsWtMyi+Au04aGz/UC7A60cwpWW3SkM12tnJDAjm16MTW66txPqgPSmqELnre4Wn6EXTsA==
X-Received: by 2002:a05:6a20:7d93:b0:188:1125:88bd with SMTP id v19-20020a056a207d9300b00188112588bdmr558627pzj.43.1700184773019;
        Thu, 16 Nov 2023 17:32:53 -0800 (PST)
Received: from localhost ([2605:59c8:148:ba10:5efa:e403:ded8:175e])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709028c8a00b001a9b29b6759sm289132plo.183.2023.11.16.17.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 17:32:51 -0800 (PST)
Date: Thu, 16 Nov 2023 17:32:50 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Pengcheng Yang <yangpc@wangsu.com>, 
 'John Fastabend' <john.fastabend@gmail.com>, 
 'Jakub Sitnicki' <jakub@cloudflare.com>, 
 'Eric Dumazet' <edumazet@google.com>, 
 'Jakub Kicinski' <kuba@kernel.org>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <6556c2c238099_537dc208ab@john.notmuch>
In-Reply-To: <000101da17b9$36951720$a3bf4560$@wangsu.com>
References: <1699962120-3390-1-git-send-email-yangpc@wangsu.com>
 <1699962120-3390-3-git-send-email-yangpc@wangsu.com>
 <6554713028d5b_3733620856@john.notmuch>
 <000101da17b9$36951720$a3bf4560$@wangsu.com>
Subject: Re: [PATCH bpf-next 2/3] tcp: Add the data length in skmsg to SIOCINQ
 ioctl
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Pengcheng Yang wrote:
> John Fastabend <john.fastabend@gmail.com> wrote:
> > Pengcheng Yang wrote:
> > > SIOCINQ ioctl returns the number unread bytes of the receive
> > > queue but does not include the ingress_msg queue. With the
> > > sk_msg redirect, an application may get a value 0 if it calls
> > > SIOCINQ ioctl before recv() to determine the readable size.
> > >
> > > Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> > 
> > This will break the SK_PASS case I believe. Here we do
> > not update copied_seq until data is actually copied into user
> > space. This also ensures tcp_epollin_ready works correctly and
> > tcp_inq. The fix is relatively recent.
> > 
> >  commit e5c6de5fa025882babf89cecbed80acf49b987fa
> >  Author: John Fastabend <john.fastabend@gmail.com>
> >  Date:   Mon May 22 19:56:12 2023 -0700
> > 
> >     bpf, sockmap: Incorrectly handling copied_seq
> > 
> > The previous patch increments the msg_len for all cases even
> > the SK_PASS case so you will get double counting.
> 
> You are right, I missed the SK_PASS case of skb stream verdict.
> 
> > 
> > I was starting to poke around at how to fix the other cases e.g.
> > stream parser is in use and redirects but haven't got to it  yet.
> > By the way I think even with this patch epollin_ready is likely
> > not correct still. We observe this as either failing to wake up
> > or waking up an application to early when using stream parser.
> > 
> > The other thing to consider is redirected skb into another socket
> > and then read off the list increment the copied_seq even though
> > they shouldn't if they came from another sock?  The result would
> > be tcp_inq would be incorrect even negative perhaps?
> > 
> > What does your test setup look like? Simple redirect between
> > two TCP sockets? With or without stream parser? My guess is we
> > need to fix underlying copied_seq issues related to the redirect
> > and stream parser case. I believe the fix is, only increment
> > copied_seq for data that was put on the ingress_queue from SK_PASS.
> > Then update previous patch to only incrmeent sk_msg_queue_len()
> > for redirect paths. And this patch plus fix to tcp_epollin_ready
> > would resolve most the issues. Its a bit unfortunate to leak the
> > sk_sg_queue_len() into tcp_ioctl and tcp_epollin but I don't have
> > a cleaner idea right now.
> > 
> 
> What I tested was to use msg_verdict to redirect between two sockets
> without stream parser, and the problem I encountered is that msg has
> been queued in psock->ingress_msg, and the application has been woken up
> by epoll (because of sk_psock_data_ready), but the ioctl(FIONREAD) returns 0.

Yep makes sense.

> 
> The key is that the rcv_nxt is not updated on ingress redirect, or we only need
> to update rcv_nxt on ingress redirect, such as in bpf_tcp_ingress() and
> sk_psock_skb_ingress_enqueue() ?
> 

I think its likely best not to touch rcv_nxt. 'rcv_nxt' is used in
the tcp stack to calculate lots of things. If you just bump it and
then ever received an actual TCP pkt you would get some really
odd behavior because seq numbers and rcv_nxt would be unrelated then.

The approach you have is really the best bet IMO, but mask out
the increment msg_len where its not needed. Then it should be OK.

Mixing ingress redirect and TCP sending/recv pkts doesn't usually work
very well anyway but I still think leaving rcv_nxt alone is best.

