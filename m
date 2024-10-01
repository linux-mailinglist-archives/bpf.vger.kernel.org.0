Return-Path: <bpf+bounces-40671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B8998BEEA
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 16:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763B11C233B3
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 14:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54EA1C57A9;
	Tue,  1 Oct 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p4ZIHCEl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1JWBfOdi"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624C2AF17
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791483; cv=none; b=JuDj/eEOs0U3lfr2zlFIfqUgiPAI+VcIFYcDopxGooY31/VY8C/Oened9HWDZKtn6QRQHkRU8ppVdwxgqINA9BZ0s5K6o9Bp8bo+gslvasZN1bGc5jh8+Ue8QXX1940pVO83j2uYLSqvtl+irqh89lAFK9BicuSKO07wpHAvR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791483; c=relaxed/simple;
	bh=ZFdXkhMUj9GD2GHdj00FzANmjnv3IWoZu8+AK3lowHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pz2DJK3MDMqPrqLwCcDVjnN2YuKa20guIR+75So9TGDXoXxEudtjhwNSk5NKvi2OIQ3jeyjZTVSZxyH/+o39vHkUJpTttBVjbkGRtaTHPoryxoB3ZG/CpHivrjYCfo6b4+9sp2ggmXHC1hzS6Hyf7i9F9YByL+8F1NkeV8ULi6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p4ZIHCEl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1JWBfOdi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 1 Oct 2024 16:04:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727791479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOWL0pkSqtCwv82iKPagcQ7HoH3kxw/UV9I6nXHtXGs=;
	b=p4ZIHCEl4RekjwzJtSc+RjN/S3aGom8GowU3MyP0IotI8QalXXu7CS+UTcBV97mP+3PRFE
	jDlufmiurYg3B45i/1ne7SNaKCsva7e3vW69a4v2S5U8f/XxLqclP0gdCTULroGTyrF1kE
	3/zvHWLSJ8q57XmCow6QtQxjXcYqZNiPRm0hvk50nlk86Av2AHGsNHDYJtMRbVCFF48lmd
	fqFhpfF4HotQGKU3uuIv9bVDgzaO2tuSzGOhoeGHBC9kYScW4Y5uhEfmUcsBXvoLDZYXjn
	QhU1fpXMdaBqt39x/ZKYMwaw3shevC6CW8rN4R9uwEvdizC5BdzV8/0IfeXLLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727791479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOWL0pkSqtCwv82iKPagcQ7HoH3kxw/UV9I6nXHtXGs=;
	b=1JWBfOdi5t7p6SL5bUu74N+kYQJqpnfcdDhsKTldAERvpWrmQVLnfE8d10DLRyUrIK/IcX
	QelKoIZfOBabpQAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Yury Vostrikov <mon@unformed.ru>, bpf@vger.kernel.org,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: NULL pointer deref inside xdp_do_flush due to
 bpf_net_ctx_get_all_used_flush_lists
Message-ID: <20241001140438.mq8L_5Zh@linutronix.de>
References: <5627f6d1-5491-4462-9d75-bc0612c26a22@app.fastmail.com>
 <20241001133603.G8j39V2l@linutronix.de>
 <09947f9d-0694-fad6-661a-0b24db9aa47a@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09947f9d-0694-fad6-661a-0b24db9aa47a@gmail.com>

On 2024-10-01 15:01:25 [+0100], Edward Cree wrote:
> On 01/10/2024 14:36, Sebastian Andrzej Siewior wrote:
> > diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
> > index c9e17a8208a90..f3288e02c1bd8 100644
> > --- a/drivers/net/ethernet/sfc/efx_channels.c
> > +++ b/drivers/net/ethernet/sfc/efx_channels.c
> > @@ -1260,7 +1260,8 @@ static int efx_poll(struct napi_struct *napi, int budget)
> >  
> >  	spent = efx_process_channel(channel, budget);
> >  
> > -	xdp_do_flush();
> > +	if (spent)
> > +		xdp_do_flush();
> >  
> >  	if (spent < budget) {
> >  		if (efx_channel_has_rx_queue(channel) &&
> 
> Seems reasonable to me.
> Another alternative is to look at budget rather than spent,
>  as that seems like the condition that drives whether we
>  have a real XDP.

If you prefer. What are chances that you had budget but cleaned nothing?

> -ed

Sebastian

