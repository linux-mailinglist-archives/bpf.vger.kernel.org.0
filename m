Return-Path: <bpf+bounces-61291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21937AE46D4
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 16:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCBED4A1D26
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 14:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6FB23E32B;
	Mon, 23 Jun 2025 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnJKc8IU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A80D13D24D;
	Mon, 23 Jun 2025 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688306; cv=none; b=l3XX1S4DoXQHhtysWaB4U6cLlNQlvuWRdlmUV+5Im+lIXj9dpDp7B6d5g67aZ8gjNWdpLXzhePj8Ie4wC0um24mK/eusGJUM8vl7DIUba5rf/MXuHMaxYWSREqX/fRC02wwCOHmJxs0gRyYzWsR4BY+oN6SQEsY1HIx22N0rC3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688306; c=relaxed/simple;
	bh=Ja8g6p9lOyN+QnCfnP7wTZkeB2AZpd5MJG6yaVlcCzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1iVWRUBtkuJJJ6NYyUu0IrjjxRGjNxlzl3sdAAVs7xE+FRUIfjVJXAqZkxMd6xq4ayh+5UWL3/ZD3p+XHfPKcw5LbkYSrZ9kQvd8Hhe9BdRQ6T/0gHMpJU4Mr5JUalQfIOsvmjI44nAf1h18qnFRZMk/65TuI9jKf4RdhwB+EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnJKc8IU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-236377f00easo48903625ad.1;
        Mon, 23 Jun 2025 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750688304; x=1751293104; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7SoieuEKzdWV7AgpxrwvlxhBjI8vUJ6kHqUHxuD7Mys=;
        b=QnJKc8IUOJ+w0ojdYrGPvBZ42WzyToqhx0RP4utwziTLyzRxNB2ztRgc5JrkMFwSWo
         xJBv0bi2uNm9vwx+Llx7dd60JwnbtRATzOov35h7C2kQtbDvpyL3ECho/oekQFWecC+N
         XZPUG5f7VFMWL6rbtRgNcTmMbOqSt5qX+Hz7pAW7AcCqTVo+O8biiUSN082BWoSv97C0
         mZ2ey1uk8McjQdFAensu6stZxNQyS4YNxUXpjqkxmoT3Vj1cr7Nvu7edEKbF8dy6A09Q
         qPuKywKbsAWATB//CCp3l00cKZISLU3puosnmmes/nf3nizyd/IHaQeLJT66m0zNSCxD
         kQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688304; x=1751293104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SoieuEKzdWV7AgpxrwvlxhBjI8vUJ6kHqUHxuD7Mys=;
        b=cPG+hogpcnTCs7IZVKOQinatQnI/0/pcZs881ge0Gqx3gZrxWy1KV12XokAcllSPl1
         OcKt9OxQ9oZaZ0zmKhsUsC8AC3eIxQiZE8/Ns1UuNpYfrJTSneqmcXJnrdcMgP7nvRl/
         MSsMhZwZL5x0Ipltp0Y70memBeytdMlW1qgTXXz1XQVB2+kSm8ppbrFqAZfNNS99Ay8j
         58JAeihRt6nSOaUEqrBQ5vE23dBr9l0CXVBB4RAq/SOVTDMvN2KLj1tP5sfYwoBHlMau
         ykfrMO/P+hdPW7FQaguUlJhf79Ue6gNHxP73RxbBIq2ZDBO3tF4401Sx2O+FcgMkz74p
         khZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM30T868vkSq3NGwURcs5hpbVlLStwaLNoq46LJ4kub7V0sUEQJNyLJcHX11ARYtwPGL77exVk@vger.kernel.org, AJvYcCX+GE3Kvevw2eJYUHiYWogrHRSZWHdTx218+d2rMiVwftydoZoGMPTovxvpHtYuEv6bcDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2FHPolGFtOqAul4ZVuj3yb7zOoTM5bn4UkAIuGgGTYNcs7gW
	6XJsJ6/v8QtMnK7aOiGSc0XvBcw/m9bnzHNupF97SvStM0WWj1jyTZA=
X-Gm-Gg: ASbGncsWM5EGJiE3unhmLk1bvy57yhqD284mCF7AqG286pzO6gCukNyVDuYlsbcFR0g
	bqb6Nuov62bOtARr7UptUkKISTPAMaI1Hz4Xwx1CnFsdg3kAjJWxhp0FdOU/gBAzA4HzGSoYWBc
	nQRG+VO4P4QD6jtSESnB3wIX7F+h1ihOlA8YaZomBFmMgKpBiwy0vZYUHyQ5SHnDJWjpYoVHtiS
	SAz61qhUN9RC9xOslqC7SR4MO0Pw3CbJ1WMakr70oNP6L7tfgB/K8uqNQM08Eo8LDg3jJrpGlks
	PKS1WoXkPIwzEdPILK4UBMEySxSnR5O8XfFc4hTGNsm+q/3mDLJHUUku2OhXWQBHcGa9n0hGsnt
	FgdSXN2xS/6Tm1lga0b1V+Po=
X-Google-Smtp-Source: AGHT+IF6i/9rOTQn8J5yC8Fx5GLun/9Lsr/TuKsqzaOBhS6jPcIbntvNFNRfMpWlhzoOGcnxRnlWYQ==
X-Received: by 2002:a17:902:e54e:b0:234:d292:be95 with SMTP id d9443c01a7336-237d9b1809cmr164690135ad.42.1750688303418;
        Mon, 23 Jun 2025 07:18:23 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d875a7b5sm84498755ad.256.2025.06.23.07.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:18:22 -0700 (PDT)
Date: Mon, 23 Jun 2025 07:18:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, bjorn@kernel.org,
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	joe@dama.to, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
Message-ID: <aFliLQiRusx_SzQ4@mini-arch>
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org>
 <aFVvcgJpw5Cnog2O@mini-arch>
 <CAL+tcoAm-HitfFS+N+QRzECp5X0-X0FuGQEef5=e6cB1c_9UoA@mail.gmail.com>
 <aFWQoXrkIWF2LnRn@mini-arch>
 <CAL+tcoB-5Gt1_sJ_9-EjH5Nm_Ri+8+3QqFvapnLLpC5y4HW63g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoB-5Gt1_sJ_9-EjH5Nm_Ri+8+3QqFvapnLLpC5y4HW63g@mail.gmail.com>

On 06/21, Jason Xing wrote:
> On Sat, Jun 21, 2025 at 12:47 AM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
> >
> > On 06/21, Jason Xing wrote:
> > > On Fri, Jun 20, 2025 at 10:25 PM Stanislav Fomichev
> > > <stfomichev@gmail.com> wrote:
> > > >
> > > > On 06/19, Jakub Kicinski wrote:
> > > > > On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > > > > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
> > > > > >     rcu_read_lock();
> > > > > >  again:
> > > > > >     list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > > > > -           if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
> > > > > > +           int max_budget = READ_ONCE(xs->max_tx_budget);
> > > > > > +
> > > > > > +           if (xs->tx_budget_spent >= max_budget) {
> > > > > >                     budget_exhausted = true;
> > > > > >                     continue;
> > > > > >             }
> > > > > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > > > >  static int __xsk_generic_xmit(struct sock *sk)
> > > > > >  {
> > > > > >     struct xdp_sock *xs = xdp_sk(sk);
> > > > > > -   u32 max_batch = TX_BATCH_SIZE;
> > > > > > +   u32 max_budget = READ_ONCE(xs->max_tx_budget);
> > > > >
> > > > > Hm, maybe a question to Stan / Willem & other XSK experts but are these
> > > > > two max values / code paths really related? Question 2 -- is generic
> > > > > XSK a legit optimization target, legit enough to add uAPI?
> > > >
> > > > 1) xsk_tx_peek_desc is for zc case and xsk_build_skb is copy mode;
> > > > whether we want to affect zc case given the fact that Jason seemingly
> > > > cares about copy mode is a good question.
> > >
> > > Allow me to ask the similar question that you asked me before: even though I
> > > didn't see the necessity to set the max budget for zc mode (just
> > > because I didn't spot it happening), would it be better if we separate
> > > both of them because it's an uAPI interface. IIUC, if the setsockopt
> > > is set, we will not separate it any more in the future?
> > >
> > > We can keep using the hardcoded value (32) in the zc mode like
> > > before and __only__ touch the copy mode? Later if someone or I found
> > > the significance of making it tunable, then another parameter of
> > > setsockopt can be added? Does it make sense?
> >
> > Related suggestion: maybe we don't need this limit at all for the copy mode?
> > If the user, with a socket option, can arbitrarily change it, what is the
> > point of this limit? Keep it on the zc side to make sure one socket doesn't
> > starve the rest and drop from the copy mode.. Any reason not to do it?
> 
> Thanks for bringing up the same question that I had in this thread. I
> saw the commit[1] mentioned it is used to avoid the burst as DPDK
> does, so my thought is that it might be used to prevent such a case
> where multiple sockets try to send packets through a shared umem
> nearly at the same time?
>
> Making it tunable is to provide a chance to let users seek for a good
> solution that is the best fit for them. It doesn't mean we
> allow/expect to see the burst situation.

The users can choose to moderate their batches by submitting less
with each sendmsg call. I see why having a batch limit might be useful for
zerocopy to tx in batches to interleave multiple sockets, but not
sure how this limit helps for the copy mode. Since we are not running
qdisc layer on tx, we don't really have a good answer for multiple
sockets sharing the same device/queue..

