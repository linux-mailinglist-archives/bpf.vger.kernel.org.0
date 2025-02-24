Return-Path: <bpf+bounces-52398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F4A42916
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814297A56E2
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 17:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605E22641F0;
	Mon, 24 Feb 2025 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCNY/Mzv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA49262D37;
	Mon, 24 Feb 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417286; cv=none; b=c/ih9EhxYzEa3lMjRaoDccseF4BFmbjoQ8PHxC1g0ZJe478QveVZhS+YS84DpQrzZTkwv9A+QpBqaTwZbfsDCvHnpY2Z7V8QB8CDowsde0kiQtKMr1/44ENlMUlSswmtFuDItlwsrWc9UTH3k0fkaaCqH2fNoQmnQniYQoWdLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417286; c=relaxed/simple;
	bh=gZ/60pQGfPHcDbNWoh9hwuZHc1QKAlEJbSSImLK0ISU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WK9oG9JzawNfrcVqKPtNM6AHVtkkWy81W7CdEJQUFAgo3XEqsSlM9lNV5iLfhmk2mxU/6S9+yrHAAXPs4QmLFIU3hUw/SH4ioIeNITXVXfCrhqYS7Hj5yscEef+REGi8bfKwXBwmuAuGjbdaNHhofeDoOo2EQtQbVIjOwun3v2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCNY/Mzv; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be6fdeee35so907913685a.1;
        Mon, 24 Feb 2025 09:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740417284; x=1741022084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NJFv2sRe5sNDuKfZTnRa+Yu9FtU3aInI73rlmPJFCkQ=;
        b=FCNY/Mzv6qc3AP1xWnlItDyCor3bn1w1s4epKaJ5z7LHIliYmjeGvRkFlbdvxZxnGH
         t699Lz2dNqBpM6G8pQsbF4wpQ9f02cxkcFq8Yte9VcV9JdrYuAW84wKE9tJiyk12rBVY
         1Eg0WrFCHS6oSPaH1vH8CfwSCnvMXJqTehRX2tRFDjGYWSHGqhBp/T3NnkpCqHStSnl4
         EzN4iLxrhwmiGackhMiEVF669yAbWOXmTyugL9rq/2iLkTluQnoiVhvuX1EgP4Z56R/3
         uxccTyT0pLLGD/mLBfYG2EgWOHTP8lA5yjhrpkTF9cWI2q/NIdDavPtaaL0CMdFCWnD1
         vwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740417284; x=1741022084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJFv2sRe5sNDuKfZTnRa+Yu9FtU3aInI73rlmPJFCkQ=;
        b=knfILxwEztIe962SbKJcBAHCpalVY3Sv9u0VJ52wlvIyBNBGB9u/sUEk5khawlcvC+
         rlkZaTKRP79GcwXXUI0ygCoABnP0Nwb+VUuQrTT9qo6kMo6JHu5WtrHISlkZTl9CSng5
         dtqw2b7ezY+rlFMgVtKZAAZ4GX3TgjeQp5RKjHAfaJo2sOsnSy/nfYOUwcXXzbkz/ioV
         igR6gnnO1fzuUHnUAWpXLliJGpJY3jpeZEwL5R1mkuZ4q1bClzbE8Bw/h0Md8R5o8TBd
         DA8U9pVmduO3hN3PidDIuQ4umuQbm6nLKvZuxTiwfNAgQnsavkadSt52Bn5djQDL6HM5
         y9ew==
X-Forwarded-Encrypted: i=1; AJvYcCUXy5LUOGlSZmNFXcGK7nMvcjaJBoyUpqDQXzUKXw6xdoHFZUshmJf0ITQeVANmm5ULJZ8=@vger.kernel.org, AJvYcCV4hWDA+uEeHqLKWwJs5iFrH1F+3aDCPaKf2gn8Q8ZaLPHbnGvEPEOUH8Zqcm31zgC8LcdwYbATdXtWoHEq@vger.kernel.org, AJvYcCXt9/I6gdAuUTIqdV6bg6rH5CxNfTKsJEG7CwnqhgIXMnEY7RY2WMX6SXOE1ooJ3+kJcEPzhS/q@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLW/n4t2lfxPzjPJu0uoluaCaSdZVLm3AlyLF+08/H2NgOlo3
	gr7NqWQK+7khdOfk4y7a27Eu8uurvrC1rDeQ9bIJ87DDovfLgaaYaOWnIIf0WTHpkZrZkg1vFcY
	k+MQ0dXDiX9IWZwlkyXTGJxoqf2A=
X-Gm-Gg: ASbGncvI+aIR8SB4Cj6gcXSRi/AXmk24iLIhpJQHNvzHgb+mdPXzIpQQG5ICI5YKdFF
	OvA3HQL7KM3NKAC+MmUj4nbBwsEBQzke92y45tfQAvA7sK9DBsyxb9bO/MvsNkNbO/ObgMfmxeA
	XEoMG9fqLQTg==
X-Google-Smtp-Source: AGHT+IH/Xed1bhDry9SC0hcfGPFO3s0go6hZSqTqhwLcMNUSsf5ZuwLICj++B+Yj1hmx4K/qqdzZ/phnn4riUyrQ2vA=
X-Received: by 2002:a05:620a:4143:b0:7c0:ab74:eefd with SMTP id
 af79cd13be357-7c0cef0b343mr1863584785a.31.1740417284105; Mon, 24 Feb 2025
 09:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222093007.3607691-1-wangliang74@huawei.com>
 <CAJ8uoz1fZ3zYVKergPn-QYRQEpPfC_jNgtY3wzoxxJWFF22LKA@mail.gmail.com> <Z7yXhHezJTgYh76T@mini-arch>
In-Reply-To: <Z7yXhHezJTgYh76T@mini-arch>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 24 Feb 2025 18:14:33 +0100
X-Gm-Features: AWEUYZmZmVfLSXv628Ijcc-OVmT7wr2Z7KMdXDQdb9K-axbmTon1GMe_HQAfX5Q
Message-ID: <CAJ8uoz12bmCPsr_LFwCDypiwzmH+U7TeLqqykgRhp=8vKX4nQw@mail.gmail.com>
Subject: Re: [PATCH net] xsk: fix __xsk_generic_xmit() error code when cq is full
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Wang Liang <wangliang74@huawei.com>, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 17:00, Stanislav Fomichev <stfomichev@gmail.com> wrote:
>
> On 02/24, Magnus Karlsson wrote:
> > On Sat, 22 Feb 2025 at 10:18, Wang Liang <wangliang74@huawei.com> wrote:
> > >
> > > When the cq reservation is failed, the error code is not set which is
> > > initialized to zero in __xsk_generic_xmit(). That means the packet is not
> > > send successfully but sendto() return ok.
> > >
> > > Set the error code and make xskq_prod_reserve_addr()/xskq_prod_reserve()
> > > return values more meaningful when the queue is full.
> >
> > Hi Wang,
> >
> > I agree that this would have been a really good idea if it was
> > implemented from day one, but now I do not dare to change this since
> > it would be changing the uapi. Let us say you have the following quite
> > common code snippet for sending a packet with AF_XDP in skb mode:
> >
> > err = sendmsg();
> > if (err && err != -EAGAIN && err != -EBUSY)
> >     goto die_due_to_error;
> > continue with code
> >
> > This code would with your change go and die suddenly when the
> > completion ring is full instead of working. Maybe there is a piece of
> > code that cleans the completion ring after these lines of code and
> > next time sendmsg() is called, the packet will get sent, so the
> > application used to work.
> >
> > So I say: let us not do this. But if anyone has another opinion, please share.
>
> Can we return -EBUSY from this 'if (xsk_cq_reserve_addr_locked())' case as
> well?

That is a good idea! Though I would return -EAGAIN. When -EBUSY is
returned, the buffer was consumed but not sent. But -EAGAIN means that
the user just has to perform then sendmsg() again and that is exactly
what the user has to do here too.

