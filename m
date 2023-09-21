Return-Path: <bpf+bounces-10592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE317AA29E
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 23:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 099F1282351
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D90519478;
	Thu, 21 Sep 2023 21:23:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F919467;
	Thu, 21 Sep 2023 21:23:45 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36FC35A0;
	Thu, 21 Sep 2023 14:23:43 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-573e67cc6eeso1095284a12.2;
        Thu, 21 Sep 2023 14:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695331423; x=1695936223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsuQNfScrO1aISDB56QrSUOjSyPUGK4RVm6SJuenOrQ=;
        b=UeP0KEFbwBm58gxh8Djatm3ys/pvnHmq+eYxntPHByCjb+QroL4ljyivsoc5qsZ5cL
         9JzeKDsaqWrdgoR8mi5QU5r6XoKr6X+0lATBysdCcXhKIfyS4awqktVo/D6OAfuy208Q
         WYVSI8telR1XWp5MIlofop6GuctIIFEvb/yyTXvqikVb2uHWW1fnsZMURyMkV8hspTmH
         M2y5xZj9TUP+hap9TMSokeoJot1nMnrm9G+IxGa/zxEMXE5qO8CDe2wxk2vPUkSfT2B6
         gCZLJ2erjo5Cw9RzKRPA59jC+btA/0B5Uig3YOkF0lNbWXtCpekzDW3LSxeHuW8A1xyw
         J+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695331423; x=1695936223;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LsuQNfScrO1aISDB56QrSUOjSyPUGK4RVm6SJuenOrQ=;
        b=ktRl6p649J4xQa/vUEHB0lu1HYicmZ1yINXqzBg7smc7Vvf3Nc1H4OM8pE1AkAUmhl
         fm/60tfjhWUqFvjf7CTH3l+IE82wZ9epfyVOaNXueUGpsYn6YO8Ejee9dobI6PZpmqqR
         gZoQuc3lTrNjYLEDLVLw/lnF1GU85szR3D2rUgaI9Odi8rCRibGIbfCQBV3cOid0RFkS
         WAQ263lz5hlVHkcQpbQ84Urfpx3cLxkov8PiQsaYFEfN+7UpOBvqdYnxW6YEPoQL+YZp
         K8BslXa/RcKw+/vhrfaePEBKK7Ea8ZUCq5UtpEe74mgOin38anPo34qPYsxkL5LKAswI
         lD8Q==
X-Gm-Message-State: AOJu0Yx7jaPzRxQS+LwaNhFOJygTYMzAwvDvdL5CTDG8FxbAA8es4+2/
	wqYzjuWqHhaMMjjBCq54J3A=
X-Google-Smtp-Source: AGHT+IHJ7tlaukTyOBsERVJ1ShhMoOQgc6CcJPtJnj/0UljLR5hJEeo3wi8gYHSpKgrlBOaGIbQ56Q==
X-Received: by 2002:a17:903:187:b0:1bf:34fb:3085 with SMTP id z7-20020a170903018700b001bf34fb3085mr7829752plg.14.1695331423184;
        Thu, 21 Sep 2023 14:23:43 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00:6dc1:5d9b:f2da:8199])
        by smtp.gmail.com with ESMTPSA id z19-20020a170902ee1300b001beef2c9bffsm1990176plb.85.2023.09.21.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 14:23:41 -0700 (PDT)
Date: Thu, 21 Sep 2023 14:23:39 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Simon Horman <horms@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, 
 ast@kernel.org, 
 andrii@kernel.org, 
 jakub@cloudflare.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <650cb45ba621d_d8cff208a2@john.notmuch>
In-Reply-To: <20230921210838.GR224399@kernel.org>
References: <20230920232706.498747-1-john.fastabend@gmail.com>
 <20230920232706.498747-2-john.fastabend@gmail.com>
 <20230921210838.GR224399@kernel.org>
Subject: Re: [PATCH bpf 1/3] bpf: tcp_read_skb needs to pop skb regardless of
 seq
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simon Horman wrote:
> On Wed, Sep 20, 2023 at 04:27:04PM -0700, John Fastabend wrote:
> > Before fix e5c6de5fa0258 tcp_read_skb() would increment the tp->copied-seq
> > value. This (as described in the commit) would cause an error for apps
> > because once that is incremented the application might believe there is no
> > data to be read. Then some apps would stall or abort believing no data is
> > available.
> > 
> > However, the fix is incomplete because it introduces another issue in
> > the skb dequeue. The loop does tcp_recv_skb() in a while loop to consume
> > as many skbs as possible. The problem is the call is,
> > 
> >   tcp_recv_skb(sk, seq, &offset)
> > 
> > Where 'seq' is
> > 
> >   u32 seq = tp->copied_seq;
> > 
> > Now we can hit a case where we've yet incremented copied_seq from BPF side,
> > but then tcp_recv_skb() fails this test,
> > 
> >  if (offset < skb->len || (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))
> > 
> > so that instead of returning the skb we call tcp_eat_recv_skb() which frees
> > the skb. This is because the routine believes the SKB has been collapsed
> > per comment,
> > 
> >  /* This looks weird, but this can happen if TCP collapsing
> >   * splitted a fat GRO packet, while we released socket lock
> >   * in skb_splice_bits()
> >   */
> > 
> > This can't happen here we've unlinked the full SKB and orphaned it. Anyways
> > it would confuse any BPF programs if the data were suddenly moved underneath
> > it.
> > 
> > To fix this situation do simpler operation and just skb_peek() the data
> > of the queue followed by the unlink. It shouldn't need to check this
> > condition and tcp_read_skb() reads entire skbs so there is no need to
> > handle the 'offset!=0' case as we would see in tcp_read_sock().
> > 
> > Fixes: e5c6de5fa0258 ("bpf, sockmap: Incorrectly handling copied_seq")
> > Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> > Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> > ---
> >  net/ipv4/tcp.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 0c3040a63ebd..45e7f39e67bc 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -1625,12 +1625,11 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
> >  	u32 seq = tp->copied_seq;
> 
> Hi John,
> 
> according to clang-16, with this change seq is now set but unused.
> I guess seq can simply be removed as part of this change.

Yeah I'll send a v2. Thanks.

> 
> >  	struct sk_buff *skb;
> >  	int copied = 0;
> > -	u32 offset;
> >  
> >  	if (sk->sk_state == TCP_LISTEN)
> >  		return -ENOTCONN;
> >  
> > -	while ((skb = tcp_recv_skb(sk, seq, &offset)) != NULL) {
> > +	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
> >  		u8 tcp_flags;
> >  		int used;
> >  
> > -- 
> > 2.33.0
> > 
> > 



