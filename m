Return-Path: <bpf+bounces-60834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 730B8ADDAD9
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 19:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA74188CB20
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 17:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493F9233133;
	Tue, 17 Jun 2025 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJNftMsV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A395139579;
	Tue, 17 Jun 2025 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182389; cv=none; b=lVdEhlI61kVgW1T6sN1Ek+N9cqVjWKiAbl4rdTllQWKGv1Nxh/T8BhnvgG2fPcClxpUpyTwkrtG3+NKeFP0XfyDtMI8IKyDslHNa2CjVOKLSHsdJLlBC5x0ygfBufYfxu9GNmOKcnQ2n1vgEklT5Tam25sAW3q1v740JLSJvDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182389; c=relaxed/simple;
	bh=AGTAs+SaRwCqKmyGKi1DQSPWTJgPZNTZZIrUheRQ+Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exsjnyfz+G75q3P+3JxOKWlwKxPFKBk2b/JTUfJTkDrJLcHHTsiwHul0JoANmx9YY/eCW7/9g2HYj2DHDCkRJDcoXZspU31OEgAHTqr7Urq9/W0uG6BUIMLoFkXJVcnSotX202eFBsgAodvMDI59lB9VGSDXkqgzSMKuNYjeiiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJNftMsV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234d3261631so40448855ad.1;
        Tue, 17 Jun 2025 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750182387; x=1750787187; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QbKZDrjbpSz17YIKWDnzjh4xG+/qeb2jfb4vbQkRNXU=;
        b=jJNftMsV3oXm91mtWhxzmSXqxlVKM+BJmbOu2+aXRb8qlKx9qTI8IovteyGa2hahPB
         KjSQMKL4igjYVRgruJ1kvktNgOWuAD5sxgSIC2IivLY36lnGU0UAq4lvLXfRaoZlRt8u
         lp409skwOF2OocBZt2i9V92gxd1Xerizd8jcq33VvMFg8WJDLS2ZAfDI4ZDFbwoFAQrv
         ujPPVmSkJ5F9Rte+I8zfgFYwF+eClDEIFQyyiIbLOTnHQnaKbtycFFf8Z74doFTvEuhH
         /XEkDqU5IJX527fLhi5pRvZ8yt4zrML+Rhgu8+uI0ITqfQOhoLC6pQX//lNJPl52TCHE
         5ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750182387; x=1750787187;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbKZDrjbpSz17YIKWDnzjh4xG+/qeb2jfb4vbQkRNXU=;
        b=HHyld60KvRPmlhNoUZfvdFkdaY1tt0/dcNtabuu5umTP/PuiVIOkYubDq8eormwXkv
         TNq/uItoY7rxljiFdpXaJFeyQIPAOq1l02f7fUctFfR0F6szdeeudoPKzCaFgTlqjnsp
         DAfQmSufdUNbuv5KcXwOdDcVdW9LQanYPjQJ+pmll2YaQjlXKvyE4UpwV0EjWCsCXBTj
         m1YV7v0R3LVo6AUw+hXzYqH/gr4mcCtnPix7gfNGiXkJfiElEorDIEP8+RPWjV0lnzmB
         WbN4CPYc/L1Y566gPG4rQWgi3d6XLpn8CxrO0kF4I3941cIdPlrxYY1pZZmj49eVlbA2
         pOOg==
X-Forwarded-Encrypted: i=1; AJvYcCUTx1CXNxfvaBkPimFuZ5w5sSuolie7VSaiC26hXR9CiL1AmM+sIGsmuSQuzMXErACDmDI=@vger.kernel.org, AJvYcCV/4Y3C8h5gIPVU7RhayHevVBVaRoX/sPVtqPKDsErJquGajWu7ngwkFroYRKo5UDTOGWE4X916@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5mxAHgxlxP9Jd/IT0U6Tr8tOsOj+bCARQ0Q/f+bJaKtYjPZJL
	9xafKGBV9p0WkJ4yyqzn6mHbl1SI5qNzoTl/Il7Ii72ZanO74jRGahU=
X-Gm-Gg: ASbGncu04hEZyvOYMKis+Q6DEPbnrJZspECO0b/A98WQcBflzhG5cEkKL+HsRCSTnV1
	xzmNYh0n5XskX+WmdcweXg2+a18YE7O4a1ekww59QuG38BDymblK0lx6tX9Rf+55aHj9EtW8l/e
	HSwOmQ2WPhTIg8nafM8z12wurGkPmYZwmKb85C9DIcuwQ7NodQx0WpSLi1ZpUfj7NQI1q3uf889
	ci6W0xUJka2qFWj4n6o9Q8zzCxJZSiPSjU8GVlZOiv7U4MSRBzktldArWFf5R8NUInVj19b75Md
	ZmzyyYmfqexk14zEBculPJJpTE5wjkmNB7lObEDeRNi0vJCQ3Mcc0jAa90KdmlfvVwgLF+IUTcK
	4hY7k9O3Y74MfQOp6PYwKA0Q=
X-Google-Smtp-Source: AGHT+IFmMmrMXrosZFn0bZHKFaaDWKCAlVN4xRtanNs1vQqa6x9Zgvi0MSFQaG7/NpUx+zMWUnZE4Q==
X-Received: by 2002:a17:90b:35c9:b0:313:5d2f:54fc with SMTP id 98e67ed59e1d1-313f1ca7fefmr23912898a91.10.1750182387302;
        Tue, 17 Jun 2025 10:46:27 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365de783a8sm82866045ad.99.2025.06.17.10.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 10:46:26 -0700 (PDT)
Date: Tue, 17 Jun 2025 10:46:26 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 0/2] net: xsk: add two sysctl knobs
Message-ID: <aFGp8tXaL7NCORhk@mini-arch>
References: <20250617002236.30557-1-kerneljasonxing@gmail.com>
 <aFDAwydw5HrCXAjd@mini-arch>
 <CAL+tcoDYiwH8nz5u=sUiYucJL+VkGx4M50q9Lc2jsPPupZ2bFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDYiwH8nz5u=sUiYucJL+VkGx4M50q9Lc2jsPPupZ2bFg@mail.gmail.com>

On 06/17, Jason Xing wrote:
> Hi Stanislav,
> 
> On Tue, Jun 17, 2025 at 9:11 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 06/17, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Introduce a control method in the xsk path to let users have the chance
> > > to tune it manually.
> >
> > Can you expand more on why the defaults don't work for you?
> 
> We use a user-level tcp stack with xsk to transmit packets that have
> higher priorities than other normal kernel tcp flows. It turns out
> that enlarging the number can minimize times of triggering sendto
> sysctl, which contributes to faster transmission. it's very easy to
> hit the upper bound (namely, 32) if you log the return value of
> sendto. I mentioned a bit about this in the second patch, saying that
> we can have a similar knob already appearing in the qdisc layer.
> Furthermore, exposing important parameters can help applications
> complete their AI/auto-tuning to judge which one is the best fit in
> their production workload. That is also one of the promising
> tendencies :)
> 
> >
> > Also, can we put these settings into the socket instead of (global/ns)
> > sysctl?
> 
> As to MAX_PER_SOCKET_BUDGET, it seems not easy to get its
> corresponding netns? I have no strong opinion on this point for now.

I'm suggesting something along these lines (see below). And then add
some way to configure it (plus, obviously, set the default value
on init). There is also a question on whether you need separate
values for MAX_PER_SOCKET_BUDGET and TX_BATCH_SIZE, and if yes,
then why.

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72c000c0ae5f..fb2caec9914d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -424,7 +424,7 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
 	rcu_read_lock();
 again:
 	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
-		if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
+		if (xs->tx_budget_spent >= xs->max_tx_budget) {
 			budget_exhausted = true;
 			continue;
 		}
@@ -779,7 +779,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 static int __xsk_generic_xmit(struct sock *sk)
 {
 	struct xdp_sock *xs = xdp_sk(sk);
-	u32 max_batch = TX_BATCH_SIZE;
 	bool sent_frame = false;
 	struct xdp_desc desc;
 	struct sk_buff *skb;
@@ -797,7 +796,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		goto out;
 
 	while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool)) {
-		if (max_batch-- == 0) {
+		if (xs->max_tx_budget-- == 0) {
 			err = -EAGAIN;
 			goto out;
 		}

