Return-Path: <bpf+bounces-43387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C41E79B4CD4
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 16:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4865F1F24540
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 15:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3217192D62;
	Tue, 29 Oct 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MEL6gOA5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D741191F6D
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214206; cv=none; b=GHC1/lCgG6UuX7wasFCX7FXOc1UfCYkk7dgE1MGClCZezJe8siNVLndyJb9TLz4VV7lZG6bmV++2zcb5L/gO4Jmyb3rD7Zya40XMmSdnvWGmfnNbQovdr/sEwrSbYbNEbcfnbM0Mhk4U9xEmjYo4iJIkPUj6+Az8LXkgy1xfbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214206; c=relaxed/simple;
	bh=NBSC41srgKPt9bg/2Qz/7PgkEc3c+cfTUpjZyDXQUXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCMJU7Omv76kyYXWthRhHFmBvcTIyQdJoxPsIsx8SQH54RTpJZADf3NiMtyO2i4NI5oVsTeOsYSLEFfH8Ad/ySFeua9PpNPtGYCLSkHmq0zwDAi5zV4EkyCGXj9WzJsqPnUH8EDcToaqp+4rKNygPgI9z8CvY+9Mwj7wOVB/C3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MEL6gOA5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c9978a221so60338575ad.1
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730214204; x=1730819004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agAKt0IT7G723lrXGrtqJgZBhbv7SHC0IN5lHsfmwYg=;
        b=MEL6gOA51kVLII2DrX5XlCZ45ift+ozAjPNP1QUrIAfg+Cscpr79lUtPOwcfK8UHZY
         bcFKwJf9zAK++TP9/IgY1eu1aBWMDsdxjChIfoIpGAJQXRcejE3eshWYuNORz/CfiWVo
         xdwLQiyGHL2X6Sa2uatbuFBEc7LE3UhOWf7+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730214204; x=1730819004;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agAKt0IT7G723lrXGrtqJgZBhbv7SHC0IN5lHsfmwYg=;
        b=fJAMAZgPbkOhvtNd3KClwNHZpyVX++42ior/8bfG/0z/Sl8cYF+En83S2WbdbYH/Qg
         fudu1FpGIxyh2Yh9kCz8fintMxuEZ02d8N7K2MtahT0kgGPzTXQkTjdnIIxRNWiYg4GF
         kbndFnqLs7hYXwx04lmWUVaEUNoaXg2Sonhxqhql2DvhupUZ+tUqBb1wqEwAKCXq0odn
         MPEt3QVpXo8jH3Gbj+nW4JAEHZVvOfv6Q2+gGVtWi9vg1+YPqlZ8zGQKSYsDhYwQWZxC
         67Gw+Px8y2d74zUHlLuAiJktE48jAfNNWKvi8yi+busJ9/NaxRT8IeKqIeLEqXVosDO4
         K5qw==
X-Forwarded-Encrypted: i=1; AJvYcCVqvn43H37XtnGNyypFrEnreOOND/2fxV6yNpA7BqKtcPq9dS8yIj9JMUUFYfQnGYyD4CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLlGeN1FWWjwwruuT3imXeYVG8CAb8mBvNlGhAEO/ayfJUWsQ8
	iZ0MGEPKTlNl9viqTQKDJuSg4CTJXhv7Z/J62oOSOiNyjCwXDb/zBtggZtYWAYU=
X-Google-Smtp-Source: AGHT+IFCKnHDgGtsA90IcNnhxnGU7fXTHsLH84y6r6k1evSEfeb5nttjlUCgjLc1TGCn9mq7Trci/w==
X-Received: by 2002:a17:902:7790:b0:20c:fb47:5c05 with SMTP id d9443c01a7336-210c6c6d996mr123687415ad.46.1730214202479;
        Tue, 29 Oct 2024 08:03:22 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02e941sm66967365ad.204.2024.10.29.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:03:22 -0700 (PDT)
Date: Tue, 29 Oct 2024 08:03:18 -0700
From: Joe Damato <jdamato@fastly.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"open list:BPF [MISC] :Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>, Jan Kara <jack@suse.cz>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 0/6] Suspend IRQs during application busy
 periods
Message-ID: <ZyD5Ntx_DwnQj47e@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"open list:BPF [MISC] :Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>, Jan Kara <jack@suse.cz>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20241021015311.95468-1-jdamato@fastly.com>
 <57a0e1e7-1079-4055-8072-d9105b70103f@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a0e1e7-1079-4055-8072-d9105b70103f@redhat.com>

On Tue, Oct 29, 2024 at 11:25:18AM +0100, Paolo Abeni wrote:
> On 10/21/24 03:52, Joe Damato wrote:
> > Greetings:
> > 
> > Welcome to v2, see changelog below.

[...]

> 
> The changes makes sense to me, and I could not find any obvious issue in
> the patches.

Thanks for taking a look.
 
> I think this deserve some - even basic - self-tests coverage. Note that
> you can enable GRO on veth devices to make NAPI instances avail there.
>
> Possibly you could opt for a drivers/net defaulting to veth usage and
> allowing the user to select real H/W via env variables.

Could we send a selftest in a follow up?

I am asking because we've jumped through a number of hoops to get to
this point:
  1. Added support for per-NAPI config settings [1] to address Eric's
     concern in the v1, which took several revisions and was stalled
     due to a merge window.
  2. Added support for netdev-genl to numerous drivers so that this
     would be usable in many different environments (gve, ena, tg3,
     e1000, e1000e, igc...) [2] [3] [4] [5] [6]
  3. We didn't get any feedback about adding a selftest in the RFC
     or v1 [7].

I think all busy poll methods currently in the kernel need selftests
(including the existing busy poll method) and its not clear to me
currently how much work it'll be to get veth or netdevsim working to
a point where we could re-submit this with a selftest that would be
considered reasonable enough.

FWIW, neither my previous series on the epoll ioctl nor the per NAPI
settings were rejected due to lack of selftests, but I did add a
simple selftest for the epoll ioctl later [8].

What do you think?

Could we get this merged without having to get selftests working and
come back with a selftest as separate change (like I did for the
epoll ioctl) ?

[1]: https://lore.kernel.org/lkml/20241011184527.16393-1-jdamato@fastly.com/
[2]: https://lore.kernel.org/lkml/20240930210731.1629-1-jdamato@fastly.com/
[3]: https://lore.kernel.org/lkml/20241002001331.65444-1-jdamato@fastly.com/
[4]: https://lore.kernel.org/netdev/20241009175509.31753-1-jdamato@fastly.com/
[5]: https://lore.kernel.org/netdev/20240930171232.1668-1-jdamato@fastly.com/
[6]: https://lore.kernel.org/lkml/20241028195243.52488-1-jdamato@fastly.com/
[7]: https://lore.kernel.org/all/20240823173103.94978-1-jdamato@fastly.com/
[8]: https://lore.kernel.org/netdev/171528362770.20134.14528995105510778643.git-patchwork-notify@kernel.org/T/

