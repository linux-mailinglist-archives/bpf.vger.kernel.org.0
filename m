Return-Path: <bpf+bounces-61174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F97AE1D44
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 16:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931E57A3ABE
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 14:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C73A290D83;
	Fri, 20 Jun 2025 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b12NawZn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C47237708;
	Fri, 20 Jun 2025 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429558; cv=none; b=XHvFLRe0OMbD9cYlbNslNL5TVRfl9grcJLfpDATVCI/ncbo+ZtwM2wrYpgYj3PdEy/1BskqPHcX7DFXaaQU0JZ+k3hGVyNnW+6E4pUGjvedZKGFfPGM4fCBHDGTM9uqH56aHy9F70zNhKRu65os96HyKqILgcxXEIetH54Jrq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429558; c=relaxed/simple;
	bh=fRMQdvjZ8yoFE451awnv4ngfHqVahpVyU08RAxzf2ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElJo+cGYSSzM5x1scD69qrBgrACX/gWOBpjQEmYwP4iXgSc905LIMM4XSaxnlfFs0eAkUcmGfmKDuvtrPEB+1w5njzExRhKgVb4JBRjhPIIcmQ1bssq24n258NiFpNuXfOeuwyh7RfxunaFVLGH5gF8Nc6pLnQzph1e+RRA7S8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b12NawZn; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso2171417a91.0;
        Fri, 20 Jun 2025 07:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750429556; x=1751034356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZulnvmbPp0e7G5fm5a5Hu6trUAX/RE3SimOYUWQq4Rg=;
        b=b12NawZnNSdkdaSIh5jFrfFinAEPdglQ9TJvCR2i7/uq9F5EuvtQd7JPB7FTJ3pDJe
         lTJE9lRyueipUuey5wRHeoFaBS6q7y+WYi3/JB4Ci1wlNt93z0XG0Pe33jeXY8VozgzS
         41mOuieR6R0kjtSOrb8Xt7ggtdaLzkVoKIz8OtlqNeIySJUlaFYntJuzqfCeiMXiX/iW
         8CSg0EcUKdpS6J5w56Tj/0cpIiQ3m3u2kqpHyJjpvmUua0qLRl79/mKLw1EKr9o6YTSw
         C46lHCzcz9hLSdu6SLTwmyki1LKXJ36KPgTkRe2F/RtWqgs2aWmQwOEDPqg4+t1FOehR
         tGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750429556; x=1751034356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZulnvmbPp0e7G5fm5a5Hu6trUAX/RE3SimOYUWQq4Rg=;
        b=r6b5V6+bykYjvD/oBNP1hwVpQFwhosp4lVnmhu7FvDlOC0z+poC9HHlYYQqPI900Jk
         QKi0OwzQOvEtByRI76PVOKGJhAAKtCdoZ7DKjIj3xNFZ7P+7Z88WkG+V85Uw9AKSKRgM
         mQ9cDq5zWt5fh11592BtdxKyyCeGlNZBUqb6A3li6ueZv8CxrSrswlTL9o4lc4lNM95T
         sRpuSfhz4wLW3ZgzGSLXR01phr9Y+xQq71Uc0Xw+hA709Q5fUzrGwIu53hjlOuaOtskt
         z2Ll0Q7fMuc1sen2yDUqkj+tqNcmsPYBUVBuoHCm70kqYDEZsLQXO2XDmHFsWpUaeQ8W
         JfdA==
X-Forwarded-Encrypted: i=1; AJvYcCWCof0NVj1J48SePxfqRBPj/fXDb8bKcoebJwqCrlmuqfI9oamrbDzzNzQEgD1vwiMoymunu7dC@vger.kernel.org, AJvYcCWuYAhvyBuDzqVmy6/QPvC4SmylNmnOHn6FltR31c6IdwkqxcYMJ/n1gvmeH6xs4r06YUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt9GuOOnplAuPyboHQwAyusqSKrHwFqKxOha19RWzEIykG4KFg
	wRxc1nT0oZekGlFhxHqat17S/sN2FIpKS/ZYMmzUcpGQ6KNZLl8iCME=
X-Gm-Gg: ASbGnctXXL+GiJtlqS3EA+QbYLs+we6PqqCAF7sTd7DB1NS8Dx1NZ3XZMGifjjeg/Uo
	ubdaMuSHRAEujGcAtZEMJbBWiIKPj8DXtJCvL+30qfByvvqHOZwzVMyEEtYbpKZDTbB2AJt94nI
	TCowfCtXulW6+7gNyKP4u9GoLWz8byjajUNCjJsN+0Yd1TuG54t/XCUkaXP0TWa2nijMu33aqgY
	JI/xBt4EuEh6tK1RPLdPexCfNrIR0MKAff1EMSsAwk30dLEc+a5vN7Mx1WY1leJyO5cVjl/S5Xx
	IyPV1ZZ02vGIB3p5DTs5XXbRV7QJMB2p8VFFYJJD7JBKr4F7DWiYgHx0GRBoex6bU8mWA0mmYnp
	FlQXRf271PZq+Dd0PadPBWZ0=
X-Google-Smtp-Source: AGHT+IFNJusKxfr5mKPjRkcQBUy6wFvWqWVc/l98db/XSc9Tsoqe+NBk1q6dS+HId1dLO3ockwzhxw==
X-Received: by 2002:a17:90b:278b:b0:30e:8c5d:8ed with SMTP id 98e67ed59e1d1-3159d7c8d9cmr4854920a91.19.1750429555945;
        Fri, 20 Jun 2025 07:25:55 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3158a2f3358sm4779624a91.30.2025.06.20.07.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 07:25:55 -0700 (PDT)
Date: Fri, 20 Jun 2025 07:25:54 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, bjorn@kernel.org,
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	joe@dama.to, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
Message-ID: <aFVvcgJpw5Cnog2O@mini-arch>
References: <20250619090440.65509-1-kerneljasonxing@gmail.com>
 <20250619080904.0a70574c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250619080904.0a70574c@kernel.org>

On 06/19, Jakub Kicinski wrote:
> On Thu, 19 Jun 2025 17:04:40 +0800 Jason Xing wrote:
> > @@ -424,7 +421,9 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc)
> >  	rcu_read_lock();
> >  again:
> >  	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > -		if (xs->tx_budget_spent >= MAX_PER_SOCKET_BUDGET) {
> > +		int max_budget = READ_ONCE(xs->max_tx_budget);
> > +
> > +		if (xs->tx_budget_spent >= max_budget) {
> >  			budget_exhausted = true;
> >  			continue;
> >  		}
> > @@ -779,7 +778,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> >  static int __xsk_generic_xmit(struct sock *sk)
> >  {
> >  	struct xdp_sock *xs = xdp_sk(sk);
> > -	u32 max_batch = TX_BATCH_SIZE;
> > +	u32 max_budget = READ_ONCE(xs->max_tx_budget);
> 
> Hm, maybe a question to Stan / Willem & other XSK experts but are these
> two max values / code paths really related? Question 2 -- is generic
> XSK a legit optimization target, legit enough to add uAPI?

1) xsk_tx_peek_desc is for zc case and xsk_build_skb is copy mode;
whether we want to affect zc case given the fact that Jason seemingly
cares about copy mode is a good question.

2) I do find it surprising as well. Recent busy polling patches were
also using/targeting copy mode. But from my pow, if people use it, I see
no reason to make it more usable.

