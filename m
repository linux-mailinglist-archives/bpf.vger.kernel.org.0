Return-Path: <bpf+bounces-61217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE73AE2585
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 00:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A267E7B1F5D
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 22:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B045242D9D;
	Fri, 20 Jun 2025 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWXZfIxU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59724233721;
	Fri, 20 Jun 2025 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750458034; cv=none; b=jjI6ywthmx7OclVuEmtMHx27bQnbsNhGNVZ3Z9u1sUyUUAb7GfDy56x90Kq0cMal0kCMRsYhOI1ZQkiJK+/SNujGBD5NNMtBJWIsopHRqdyZvq6+N9xzcc3+OOAFEoQII49DvdsiBmzZGGD0EhrLQJyixyDWOizVRvGgeVeQg9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750458034; c=relaxed/simple;
	bh=3pUIOcQNUUkvmULbS/HU3spk89w9s+yI4Q70q5/OXm8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=N8K2nwMN/NI/IZ0K9f9WVfeXbUA/O92VTybnuZB8wHJr1pu8Gce1Gsx1vJ850eFDOvjSQGzpv16YV4HgFteSJQN7pGQYP5hBQrehrFlN9bjd9v0F+d1HbvEhmbx+SmaU7YYWisNQUqEga1Yb6WIGoK6NmeBJcvfkfWZzxwtwOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWXZfIxU; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71173646662so24150947b3.2;
        Fri, 20 Jun 2025 15:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750458031; x=1751062831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ghc8gOZ0/DUlUqFMh+/E61H1ztiwVWcBAsR1etA3/w=;
        b=bWXZfIxUodLiCMEw84yLEJYfKli3v+Y6Sm4+MGi3BOTo/5/x8FlPKs4gdJP+3UszeL
         /mE591WB+ASBlUp0/puoNoxCXfvWO1V4OFJwfp592witxcmbxFKw3Ioy4U6/jhws5cir
         YBfV49X4NFeHu/bMMhIpeNUQbqJTflhoeqnZ7P1rc75dJf4ORPpWOejw6q38H4NnNA29
         e30paSb9omH5GRcgtVYTEfThZyt7SXl1GmFaEBU5fVfQ5o+xy2zK9UWiqo5UdLZEUniC
         +M0vWHrNQB8J/VGw0Mncp0oQ7f8ocnggzgCfHwSrxNB9kdALqubeDsHIJGBc89qW6zOZ
         pp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750458031; x=1751062831;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ghc8gOZ0/DUlUqFMh+/E61H1ztiwVWcBAsR1etA3/w=;
        b=g+s5rPFzbNioHC8TJbW50HNfnnPNIR6DwqWUdbTTntGS0fMoVvKVudlJEhg98pi31L
         zXhKSQKl4Qfm6c2AryywvKIwwkFn3FTvM0jUfWHxvjCNbUhWk302sY7AyAy50egyq19N
         p+OUwscuzqSa9jh7wAOuCPZcb7vQCR7S5tZdJfo/Z7faScLMTL3snD95pkWXnl39j2Gq
         9YB/qlWxWCz60YLRtXJcwrydc4y69WWgmiH2GHW4xv7bCCuRh7NccwkvqdZvM7CDxBR8
         ndZ0duG98ztuCLVvHybh7G0ApunjfRQxZ9AKR5TN2W2UATDkNU/T2G+vkaOJw2b5Hq0B
         8mrg==
X-Forwarded-Encrypted: i=1; AJvYcCVled0RmZ4lY58EnhBo3QjGmBPvICuBhCIYU5ikjtqrEF9den0bc2zDJBkwCtrxULrhNqg=@vger.kernel.org, AJvYcCWCSeObtjXxVh1ktWGy3wji8vw2XZqy21ZPi+mTdqVoPFywCSxeNozdLI/6gIqqaFKTpq80hbbx@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw3QpVhLr9uHTGDbkV/WbRqDWv0Rk2/bXOX/ffQY+iQ/BTRAC4
	psd0BuF94jvuFwgBM2ySLkRQa5uJjF0DWi/awNeA7iAzXVvxmZf99KR3/FSIjA==
X-Gm-Gg: ASbGncs0tLsiBu8wrlKOs24B3Q1oBycZDp9qy1LM5LpPDfp4MxgshZohTvySnyHUamc
	ZScc7gztPyxIt9K6neqO7Zc2zQ0GsS6rXj74BL2t/qj1Q16eUDciOK3MOSg9vd9OD5rZjCC2zQz
	PbSz35/eyPJ4fls7fn2blcpRWr4evWblJkrBk0BFx+YJTwgED9ewYjcZ5mpBk5G5XRQm2CVfOxs
	KAO62gPNtHQbzoECMrARmCR5LUCHH7/i6J6ynL39bBhS+UQRjr4dmahgoRhHFr9NLnB/Le+KBA5
	zGstZfqT4I2FfIfQ3DFKHNkjgB91uKkrkCAYuttGrcLpLlKax9WWjw/dDcyqEJEHgbU/n7OUz2k
	VYnCzve8njsHTBftQk5nBprm8fm6fyC40ewxhKnD2W67AZcmXjCsk
X-Google-Smtp-Source: AGHT+IEoKhRPTvmwpz4pucYlxRuD0UmltMwN0ii0+0f/q9fkhv4JdF/pjmtY82xg3UYFKCXpG5cUhg==
X-Received: by 2002:a05:690c:6:b0:70e:a1e:d9f8 with SMTP id 00721157ae682-712c64f520amr61934367b3.22.1750458031084;
        Fri, 20 Jun 2025 15:20:31 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4c1d4basm5884857b3.110.2025.06.20.15.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 15:20:30 -0700 (PDT)
Date: Fri, 20 Jun 2025 18:20:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 bjorn@kernel.org, 
 magnus.karlsson@intel.com, 
 maciej.fijalkowski@intel.com, 
 jonathan.lemon@gmail.com, 
 sdf@fomichev.me, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 joe@dama.to, 
 willemdebruijn.kernel@gmail.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>, 
 magnus.karlsson@gmail.com, 
 skhawaja@google.com
Message-ID: <6855deade401b_1ca4329456@willemb.c.googlers.com.notmuch>
In-Reply-To: <aFVvcgJpw5Cnog2O@mini-arch>
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org>
 <aFVvcgJpw5Cnog2O@mini-arch>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stanislav Fomichev wrote:
> On 06/19, Jakub Kicinski wrote:
> > On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
> > >  	rcu_read_lock();
> > >  again:
> > >  	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > > -		if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
> > > +		int max_budget = READ_ONCE(xs->max_tx_budget);
> > > +
> > > +		if (xs->tx_budget_spent >= max_budget) {
> > >  			budget_exhausted = true;
> > >  			continue;
> > >  		}
> > > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > >  static int __xsk_generic_xmit(struct sock *sk)
> > >  {
> > >  	struct xdp_sock *xs = xdp_sk(sk);
> > > -	u32 max_batch = TX_BATCH_SIZE;
> > > +	u32 max_budget = READ_ONCE(xs->max_tx_budget);
> > 
> > Hm, maybe a question to Stan / Willem & other XSK experts but are these
> > two max values / code paths really related? Question 2 -- is generic
> > XSK a legit optimization target, legit enough to add uAPI?
> 
> 1) xsk_tx_peek_desc is for zc case and xsk_build_skb is copy mode;
> whether we want to affect zc case given the fact that Jason seemingly
> cares about copy mode is a good question.

The two constants seem to be only tangentially created.

If there is fear that one tunable modifies both, it is simple enough
to remove the unnecessary dependency and only tune the first.
 
> 2) I do find it surprising as well. Recent busy polling patches were
> also using/targeting copy mode. But from my pow, if people use it, I see
> no reason to make it more usable.

That's a very fair question.

Jason, have you tried XDP_ZEROCOPY? It's quite plausible that that
would address your issue.

I have had a use for copy mode, but that was rather obscure. A small
packet workload where copy cost is negligible, and with copy mode it
was easy to make to reinstate flow steering in XDP to specific XSKs,
akin to

https://lore.kernel.org/netdev/65c0f032ac71a_7396029419@willemb.c.googlers.com.notmuch/

The main issue with that remained that driver copy mode also implies
the slower generic copy based Tx path, which goes through the full
dev_queue_xmit stack.

