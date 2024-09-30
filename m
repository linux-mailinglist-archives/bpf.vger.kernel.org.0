Return-Path: <bpf+bounces-40579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E2598A6AB
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89357281C09
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45925190497;
	Mon, 30 Sep 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSTrroLb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0EB190067
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727705382; cv=none; b=JMY3k+9IxGSp35ipJZ2m0pc9lDgiBF39CpC7rSBEZTWhOrNPHDR4OCkicd9ouUfPFvEVR6yAUPhANXVtUzJj//0jVTI2avracESjdNRrnl6yqywpXq/CY2+EzoJ3w8Z0DC9JGNMM6qktFZyM8kIkyLZZSXxpVsTz/lHk+I3gd7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727705382; c=relaxed/simple;
	bh=HeOyOKsf8pRgrkeCQSA1mwUSVi1FuBH5iTWJLa28jwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqgXgvhzssYkJqvrDZdpK2jbTjpX5yvcocLrJ6arj0Sqgz97BS6yh77yx5H6CH7w46ZBnlfCfjvb15X5m+KRKyvpXyAPaj8HHFmJ642nM4bFcTOOOeVGhvjP44ZBpi1RRxXmlQk12dQ1mf/CvfhZn9kaxfwUx8Y8XFZqe0R/6wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSTrroLb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b4a090f3eso241605ad.1
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727705381; x=1728310181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqn1/zvUNvgOnZjVoe25EBepMi00YwZEPhcWt2gT9XU=;
        b=rSTrroLbpQlsDO7bs7PGO1gCdVux4uPzJ7luYhhGujrLLI3lKZD75LcX+MJXp5uu5X
         ntsoogB7V8CfEvpZEOb9rTm6357nFn5zWPuac5v6u9weJVVuCXoyMRpfGIBsRRz6Xz23
         h2+SR8OJjvNZbtKOCX0gvub+ZMrB0+HwIFs+4joZh6dGhKrfPF7lAgUl9kaDbf+qFudS
         9Up3h+MpbgMAVznPuAfp2ta4CbpwSAXTtnNy7hp+bnGNp0wK2ZoQuxDN6ekZt24h6/z+
         Hbqp9lVDb9CZJIu5R8pABwoPjn0cJTqyw8D4WlNs0qf4tuZv2/4ypIigKUicGWVwKmx7
         dvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727705381; x=1728310181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wqn1/zvUNvgOnZjVoe25EBepMi00YwZEPhcWt2gT9XU=;
        b=vgF/M3/s+jldyR1BLPeoQqD0QHuPV5fy4wC/X9ZJLDCbyMEt9rAa0CeHfch55Lvajy
         +UzGETAmJ9wmqm5wCirXypPCUacFAC/GUktOuvJ2PgYCoaVAkrC5gEDuU0n/cFJNo5uB
         5AhA/s5rJdwaW9ji2OCme8nLevw/TxgXcdUBPzIKgVf8x+QRbNKv+kh6VQ2iHW6hYM3m
         y/xwg+geYHrkGiDwFzfWAYrhBcdq42m4XW8bBhkY8iV8l2ivm/1La4c9Z41PjV8W2IDx
         prZM9d4gIvjaJP1Z2EpKx+s+JQJWEBU07edfSj3ioI/75I8QxE2PNFuSv3iWpmj4dm3u
         1rkg==
X-Gm-Message-State: AOJu0Yyp/RRZj6g8SDQ+rkaPw97LrKDqjidvJcL/HhvzeOByg2Og9ojF
	rk0B2PkAo0iPm3HkuvfIndol+ygK9tOB1GRZOeEAqMVouhrihIMv4v5QGSkqe64UNh9z8XVwNLT
	mIljqUnJBzgo3IwE3sJCCvr6nIEI34Xyxgoc9
X-Google-Smtp-Source: AGHT+IF34ciHfAc7kI+eD3PvlZ3/dCHbYxRF1NJ06ceLxk/6js/ELEHY9i+95Fn9r5YkPzQ7SS+RTovk0wDQKN3Q2Z8=
X-Received: by 2002:a17:902:fb04:b0:20b:428a:3102 with SMTP id
 d9443c01a7336-20b57f3c63cmr3316265ad.24.1727705380306; Mon, 30 Sep 2024
 07:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929170219.1881536-1-jrife@google.com> <cb613257-75c5-4bcf-9daa-c3f5d9a83186@iogearbox.net>
In-Reply-To: <cb613257-75c5-4bcf-9daa-c3f5d9a83186@iogearbox.net>
From: Jordan Rife <jrife@google.com>
Date: Mon, 30 Sep 2024 07:09:28 -0700
Message-ID: <CADKFtnS7va+Q5qSd6e+k2Vq+z6Oc+ba_zFoTdLhWmt03TMLu-Q@mail.gmail.com>
Subject: Re: [PATCH v1] bpf: Prevent infinite loops with bpf_redirect_peer
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> No, as you mentioned, there are plenty of other misconfiguration
> possibilities in and
> outside bpf where something can loop in the stack (or where you can lock
> yourself
> out e.g. drop-all).

I wasn't sure if it should be possible to lock up the kernel with such
a combination of BPF programs. If this is the view generally, then
fair enough I suppose. Maybe this is my ignorance showing, but my
understanding is that with BPF generally we go to great lengths to
make sure things don't block (e.g. making sure a BPF program
terminates eventually) to avoid locking up the kernel. By extension,
should it not also be impossible to block indefinitely in
__netif_receive_skb_core with a combination of two BPF programs that
create a cycle with bpf_redirect_peer? It seems like there are other
provisions in place to avoid misconfiguration or buggy combinations of
programs from breaking things too badly such as the
dev_xmit_recursion() check in __bpf_tx_skb().

> if (dev_xmit_recursion()) {
>   net_crit_ratelimited("bpf: recursion limit reached on datapath, buggy bpf program?\n");
>   kfree_skb(skb);
>   return -ENETDOWN;
> }

-Jordan

