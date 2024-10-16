Return-Path: <bpf+bounces-42165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D6E9A0404
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 10:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E031F21C01
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 08:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F245E1D0F6B;
	Wed, 16 Oct 2024 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POXDQra0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7718B473;
	Wed, 16 Oct 2024 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066682; cv=none; b=fjxXv8SaTQf+A8PETi4LLIORHF7CNlYBQlJUnjLVf6b9/EjKU1VAr56svYSWwEQbEDMKknLdN15qPFOuIXSJJzorsUNvbLKJfMjfRtjvcj3Ts6LCjZX9fbfRuxRrZFFZ37mTlQ/aowMja0xNQrG/yGm3hps8IBv0i1qFD5Twa8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066682; c=relaxed/simple;
	bh=3Uo4v+DhY1rytKo/d2qT4xDi/EGMFOqYzxgD/ykmqt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boOx3yQ/q2YWYEIL76Og8y6Dd/NrPxBli+SUZio4n/EJ+nhKYhGyqMpfndet+w58KLsZf/I3TymvE+Ezrf6iwS9/qGg6AFplyjuraYkINSO4i9LJU2dSjBXRtYgYC3aWrNDuyaOWrrDiuTgJBmJnwRKQg434SuE0s+BqnuEw8Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POXDQra0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cbb1cf324so38111965ad.0;
        Wed, 16 Oct 2024 01:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729066680; x=1729671480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O+aFwqqe3bKe3QaDd2umFSDmDQHhmD3ojzrekfvViq0=;
        b=POXDQra00mmrkSMcxHYM7szJRML9Vx5FGc2mi95zGrGPql4EJR2ECrL5hfXqn8OPaT
         tjjX4+r8nG9i85rKUPAucrDo1r2wyBhBtbZTninCMI3+5EVOWPvZuK5EBKu4hjUXEgdd
         NhC7arzt9eFVoN4RiTIlwUvYyul/hMMjYhYzyboo3WExACU70ftLhW+NlYnRugJnCOvX
         XM2xPrDjI5tTbVNeY3dB7YdyK63DQKsiAPDWsWKL8FhSWLhSH+3e1QCZPcvdOqUXG22I
         CJgpeMMU3aXhtxDCBAabLhQXafmcD+u6jwMmpNuXFM5lmtoYDzixPkb0Fa9qWGnXPjj3
         IiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066680; x=1729671480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+aFwqqe3bKe3QaDd2umFSDmDQHhmD3ojzrekfvViq0=;
        b=dU7cL7LRyOl3s8i9cpBktsrfKO8hpdq1ydKgDDSE6RO5xXBagt8o5r9j+h0sP0xqFY
         bu+eSH7xiCbSZ6/lIa1wdRsNkJmu8o/aUqaO0k56jdMwkQYSf5dmqFUR0ELz/jpKdkjc
         Pj5IutEPlACxZCITX5y+9K+93vEmPgn4H0aJIBs1mnWic29TDC0Z8GRBtbj41voBmXdD
         DzXmDbswEPsoZGN26AdreMXx6TG3sgsBqu9EuZPSvYqPmtTllhr7mWn6YhiDyRixrTDi
         moVdydKWdqt8C3HOM4t3P83ueQmoBsUUV+jokouQSVcjvD2IB19YAFeC3EVWsd5uXkrV
         RI9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlQIZgZwC8nGo5Ee6yQ5gCfoYJg1D51G26gsfXSNFXvyYpI4x2R4KfTGBubtGCgrSGwcvWgNPBgVWsxS9U@vger.kernel.org, AJvYcCUutf24a1WGg/iREtLCTlIDYwjSvReP35rw9s8b2twxkboSR41lvFVrzilBy+W5GYzMwvs=@vger.kernel.org, AJvYcCXs28rWcm/2W9nijl1Sa20vuJREtAuS2xGPQFTjlzwK0T/ROYHHApvPLcT7rS8D9fmDLGf8J/lbro/U@vger.kernel.org
X-Gm-Message-State: AOJu0YyCuXXMdRfgneSrljDo+4Zr+xXufEIalkttkeNEeP4gtv/FMcsb
	YXB0Uvj/kTcLuMGFTK/CFqlr2EBycJyaTW3quSGssmWBjR5XXtg8
X-Google-Smtp-Source: AGHT+IF2m0+T57hEwmVg2D9hXBXfDI7JhyTccIZn9PK6qkXOBNr29tA7C0vJEGQQE0XsBYfU2h6thQ==
X-Received: by 2002:a17:903:228b:b0:20c:be0e:d47e with SMTP id d9443c01a7336-20d27f42066mr42039665ad.56.1729066680493;
        Wed, 16 Oct 2024 01:18:00 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d18036251sm24008565ad.172.2024.10.16.01.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:18:00 -0700 (PDT)
Date: Wed, 16 Oct 2024 08:17:51 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, Jussi Maki <joamaki@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next 1/3] bonding: return detailed error when loading
 native XDP fails
Message-ID: <Zw92r9UUBexrm1Oa@fedora>
References: <20241016031649.880-1-liuhangbin@gmail.com>
 <20241016031649.880-2-liuhangbin@gmail.com>
 <b223add3-169a-4753-bdac-9f4cfc95eb97@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b223add3-169a-4753-bdac-9f4cfc95eb97@iogearbox.net>

On Wed, Oct 16, 2024 at 09:59:01AM +0200, Daniel Borkmann wrote:
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index b1bffd8e9a95..f0f76b6ac8be 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -5676,8 +5676,11 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
> >   	ASSERT_RTNL();
> > -	if (!bond_xdp_check(bond))
> > +	if (!bond_xdp_check(bond)) {
> > +		BOND_NL_ERR(dev, extack,
> > +			    "No native XDP support for the current bonding mode");
> >   		return -EOPNOTSUPP;
> > +	}
> >   	old_prog = bond->xdp_prog;
> >   	bond->xdp_prog = prog;
> 
> LGTM, but independent of these I was more thinking whether something like this
> could do the trick (only compile tested). That way you also get the fallback
> without changing anything in the core XDP code.

Yes, I also thought about do fallback on bonding. But Nikolay suggested
just use extack msg[1], and Jakub think this is report by QE rather than
a real user. So I think we can use extack first, and convert to auto
fallback on bonding if a real user complains. What do you think?

[1] https://lore.kernel.org/netdev/8088f2a7-3ab1-4a1e-996d-c15703da13cc@blackwall.org/
[2] https://lore.kernel.org/netdev/20241015085121.5f22e96f@kernel.org/

Thanks
Hangbin

