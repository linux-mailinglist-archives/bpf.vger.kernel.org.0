Return-Path: <bpf+bounces-39728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A04B2976C50
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 16:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A63A1F243F8
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 14:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961D91B5801;
	Thu, 12 Sep 2024 14:40:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E7C3D556;
	Thu, 12 Sep 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152059; cv=none; b=mrMG4ZDpD2fzVdMwto1dEzOXPwee8+6YMF5uF7zmsktlfrGvwQDP31L9KXCzT+TjEypwNU9Kv2Q7axz7r/6mTX7X78v37TuMUy9HQoEMmTeqpe6QTmz1Kna5O0jEcowYzP5EBKrZ8z5HXkqlMOSVv3sO2tkUoNNjiIZt+tm4YhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152059; c=relaxed/simple;
	bh=5Q8EeO7IWmCisueTMEdgf82zML0ivjll3WApTztREac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMk9RcaJQlI2jixtquynndJmOi0o+Apc6stSjFsUVVcYB5c+aclR8niFeCutYQw/DRBZQHE5gqPaZgMBnJ74PsdJwwDwSeWBgghai7TXwsY283nhAlLB3h6tEnvM1SH9mbzTA9H66k+/eZhZnN/Heg7z+8Fq5Ht3eB+NAmR+qTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8a706236bfso80554666b.0;
        Thu, 12 Sep 2024 07:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726152056; x=1726756856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLdXsCii9/gYxEQoBDMcsRP0n0Dk6hYYTZqqP6ceFgo=;
        b=wBrfdE6Lde9BgOCsBTqha9NJbYBbYfLbuudsp73OrvTw28RsjDvW0lqMRw0W6UvUK5
         B9pNbxF2rA7Gc+kDBFLNKVHntr8W6CJ5Y0AayKsZKL2yzarhaWu6rvMQ9jD5UNdjRchP
         +wbQ0eHyJjG9bU7NyiWIg4QIUUdwNng/6q93zRtdhTnLYGl4f3n+bHosqC21e3HJx89g
         /hWq/cQdbG4r+X7MDUbr54n439bQrvEDwHVPshlCGo8K+CUB4Xpl85YNRbdUoMDhY/Zn
         TEQNlZMZ16BRY9zC4tEcrEzEm5VwG7iu8ccIwra7+xsZw+NEdJkrRsZSklhOnoaSd9X4
         hEbA==
X-Forwarded-Encrypted: i=1; AJvYcCV7zqvtxxrSdoVdoA9NcttgZVwrTeEdPMpRU77+segt/vEKyndBhfx3yhEZRDnLcry44BY=@vger.kernel.org, AJvYcCWjckjTofl4H5IkaT+KH+EZBMTH74wnee1z1eSyGnQ3H1rGYy8C8hMIS7va/r/M9kr0+QZXTXKG@vger.kernel.org, AJvYcCXoZOlbilEFjD7mcV/CsPPjqDbzpMT2FE517GgXC5jEv5b2EfFEW6PvSm73txVSwKSwFTjuW+TeBX+fW0qv@vger.kernel.org
X-Gm-Message-State: AOJu0YxCbGIKLrrD1BZABDStT123Bs+c0ORJEN5c2WKYx17ipAoVy1K+
	rTf21WLcSc+njqmiuqGtXYs5bOO6WUCa6pX4is+9DF8PgnQrQBbY
X-Google-Smtp-Source: AGHT+IG93XXZFGRrW1suIchQ7gpC2xDF1Q80orW3dYtGvyPa0Qg72wWYtsceWm22Zo5WWSgNGWmTCA==
X-Received: by 2002:a05:6402:2551:b0:5c3:cb45:2e with SMTP id 4fb4d7f45d1cf-5c413e0577fmr3046068a12.5.1726152055771;
        Thu, 12 Sep 2024 07:40:55 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8cdebsm6544247a12.95.2024.09.12.07.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:40:55 -0700 (PDT)
Date: Thu, 12 Sep 2024 07:40:52 -0700
From: Breno Leitao <leitao@debian.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>, andrii@kernel.org, ast@kernel.org,
	syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH net-net] tun: Assign missing bpf_net_context.
Message-ID: <20240912-polite-wooden-jellyfish-acae2f@leitao>
References: <000000000000adb970061c354f06@google.com>
 <20240702114026.1e1f72b7@kernel.org>
 <20240703122758.i6lt_jii@linutronix.de>
 <20240703120143.43cc1770@kernel.org>
 <20240912-simple-fascinating-mackerel-8fe7c0@devvm32600>
 <20240912122847.x70_LgN_@linutronix.de>
 <20240912-hypnotic-messy-leopard-f1d2b0@leitao>
 <9a2a1cce-8d92-4d10-87ea-4cdf1934d5fb@linux.dev>
 <20240912-organic-spoonbill-of-discourse-ad2e6e@leitao>
 <20240912143029.x5iudw-g@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912143029.x5iudw-g@linutronix.de>

On Thu, Sep 12, 2024 at 04:30:29PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-09-12 07:19:54 [-0700], Breno Leitao wrote:
> > Hello Vadim,
> > 
> > On Thu, Sep 12, 2024 at 02:32:55PM +0100, Vadim Fedorenko wrote:
> > > On 12/09/2024 14:17, Breno Leitao wrote:
> > > > @@ -72,6 +73,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
> > > >   	struct net_device *peer;
> > > >   	int len = skb->len;
> > > > +	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
> > > >   	rcu_read_lock();
> > > 
> > > Hi Breno,
> > > 
> > > looks like bpf_net_ctx should be set under rcu read lock...
> > 
> > Why exactly?
> > 
> > I saw in some examples where bpf_net_ctx_set() was set inside the
> > rcu_read_lock(), but, I was not able to come up with justification to do
> > the same. Would you mind elaborating why this might be needed inside the
> > lock?
> 
> It might have been done due to simpler nesting or other reasons but
> there is no requirement to do this under RCU protection. The assignment
> and cleanup is always performed task-local.

Thanks. I will keep it out of the RCU lock then, as in the patch above.

--breno

