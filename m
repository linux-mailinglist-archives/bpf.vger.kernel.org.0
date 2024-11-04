Return-Path: <bpf+bounces-43922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBFD9BBD64
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 19:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389F31F23288
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF61F1CBA1A;
	Mon,  4 Nov 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="UvRpqSEj"
X-Original-To: bpf@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF118622;
	Mon,  4 Nov 2024 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745803; cv=none; b=X1IyZBr7/ePZm5iqwI2Q5/QjFHavu/8hIKlD1UgBpEtEWNOT1iTNCPxnjQJrr+sWKYGF2qaHxbcjjSGY3qGnEz1sWYsTY2rTWuc7AzB50lbGM5k3TRvG+4KKb6u5sNa1gphwbjyzJ5B3n7NHOgGTVWU2R0TQlfuq0cNDo81CxZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745803; c=relaxed/simple;
	bh=2VDcNMBQ57ajKJb2uc2U477Y7mR5hyVDtXcXisUumWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LA3m367bVwZgG5eSkOkufco/pD+gZnpsUlW646/IgKPVQX6wpwgzonG+CGXKwQO9ZPaaZt5UHukLzFR0MuTwCbpBB98zLQL7jnzOCHW+0XOhzxnd2LZaNpTB9d980/+hE46Nk0pK0MMUkJ03PIV0CBlO/oBrz0QpNUmOE7oZykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=UvRpqSEj; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 64C2342C30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1730745798; bh=ZBiSE17hrrwJpX5hNgDD0DP9xkL/hgtYPMBna+dA2Ss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UvRpqSEjjdfnKG//5rbTuqujf9l+/8qxR4QdGaat/K62RXeQabGof1/dLOmblC8dS
	 ZTgLC59m3yRcshuB6On68ttjbu62a/dL3XFTGo5JFUiE8eLN/Qh+w4JupZtmUdcyh8
	 HjmqFKhxzEYOusN27iOsbEa0i41w+AsAO0lywYvyTReRAqIhCZr2foMfwK4yCx1+0y
	 k3ehCH4nFNhCE1jqadV9ubvQuf1JAvwxb23by1r+RMkUHhkFodmjg/g1PP08bv3hmY
	 IXac9XIXJ0x9h4bcWaRTEn9hu9yXPTBHQh6/MxxgziuRc2CsCHAUPNlZ68HgTFq7OD
	 4UNkD60KcTV6A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 64C2342C30;
	Mon,  4 Nov 2024 18:43:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Joe Damato <jdamato@fastly.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: netdev@vger.kernel.org, hdanton@sina.com, pabeni@redhat.com,
 namangulati@google.com, edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
 m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
 willy@infradead.org, willemdebruijn.kernel@gmail.com, skhawaja@google.com,
 kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, Linux
 Documentation <linux-doc@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux BPF <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v5 7/7] docs: networking: Describe irq suspension
In-Reply-To: <ZykRdK6WgfR_4p5X@LQ3V64L9R2>
References: <20241103052421.518856-1-jdamato@fastly.com>
 <20241103052421.518856-8-jdamato@fastly.com> <ZyinhIlMIrK58ABF@archie.me>
 <ZykRdK6WgfR_4p5X@LQ3V64L9R2>
Date: Mon, 04 Nov 2024 11:43:17 -0700
Message-ID: <87v7x296wq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Joe Damato <jdamato@fastly.com> writes:

> On Mon, Nov 04, 2024 at 05:52:52PM +0700, Bagas Sanjaya wrote:
>> On Sun, Nov 03, 2024 at 05:24:09AM +0000, Joe Damato wrote:
>> > +It is important to note that choosing a large value for ``gro_flush_timeout``
>> > +will defer IRQs to allow for better batch processing, but will induce latency
>> > +when the system is not fully loaded. Choosing a small value for
>> > +``gro_flush_timeout`` can cause interference of the user application which is
>> > +attempting to busy poll by device IRQs and softirq processing. This value
>> > +should be chosen carefully with these tradeoffs in mind. epoll-based busy
>> > +polling applications may be able to mitigate how much user processing happens
>> > +by choosing an appropriate value for ``maxevents``.
>> > +
>> > +Users may want to consider an alternate approach, IRQ suspension, to help deal
>>                                                                      to help dealing
>> > +with these tradeoffs.
>> > +
>
> Thanks for the careful review. I read this sentence a few times and
> perhaps my English grammar isn't great, but I think it should be
> one of:
>
> Users may want to consider an alternate approach, IRQ suspension, to
> help deal with these tradeoffs.  (the original)

The original is just fine here.  Bagas, *please* do not bother our
contributors with this kind of stuff, it does not help.

jon

