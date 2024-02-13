Return-Path: <bpf+bounces-21856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F03D853585
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 17:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BB0286314
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4400B5F546;
	Tue, 13 Feb 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B8wT7sqh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zsjFXq2B"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643955F840
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840157; cv=none; b=FNqXaeKFzfaym/5thcczCa0NKQldyM8Q3dMlRhCpUtEElMBRpr+iZTiBVqECa6cmzCk62RpHcTsbW+v2p5ZTb6xZpWNxuH0UQraP8Bdf9ego+uX4ZiYE4YxMh06AIbVLvIO8xtAfHIMz3SlY3Uzf3nwB+CoJxMRs6MPPz+AqEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840157; c=relaxed/simple;
	bh=dR92rEtjB75iQqCYK+kNpyl/CaW+tl9mW/7ugxflidc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHNhjcqUPA5ybDkAkz8EOQB2nbrtq4c2fWSNSp63QBomoMWdeGrj1hfLPCtQue0hnqPyS/ePwBn/hDfDMX72c3YYWRAYirwPWii5dx+8fNG9rscMSdoxY/9NyzobWdfk8Rcks6HBBo+GxJ353Z/4ihGC45CoP26glYr31h3/KHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B8wT7sqh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zsjFXq2B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 17:02:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707840154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XzgW3/q3FeNgEgc7D0nIRX/bFstqI9WR0tSvMwzg8bo=;
	b=B8wT7sqhXJ19BUs5Dthb8gelihSmiVgRlsL1bdcoiI4HZDZJy/IaLGWb2maZSBPp4+MccI
	BAvZ2ws4SuSNBeUPUgAfyDf3g8LR+3EuFlpFfWxnJjH2Y9cpc/ylZ9EvddBnZJdc/khWHG
	jUJ88bkM9GYEYOmTcBuHkN7QXTAO7pD+yYdkdGU/GK1HzPW7efOuqKxzPvC6ei3zXkoq6o
	284OZxhaGIc3Q5maTRrJuYLc6yxhL8iGj4JtN6IoPAgLUjcrwvi9df6Fvg4F5GlGoq/xfi
	wL1TG2V0syXylfs5KC10fZuaZqAaLi01DEi6IR4H1D4MedrGRx1QhbAo0b1Ovw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707840154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XzgW3/q3FeNgEgc7D0nIRX/bFstqI9WR0tSvMwzg8bo=;
	b=zsjFXq2B9rpuLogTY1Xxd6XogBD3tpRydEEfBhBNZvkuAHUzaScaiklnVwGYEusMr1e4DK
	GJ4wQW5ec61OWrAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, daniel@iogearbox.net,
	ast@kernel.org, andrii@kernel.org
Subject: Re: [PATCH bpf] xsk: Add truesize to skb_add_rx_frag().
Message-ID: <20240213160233.zNJ2bbMQ@linutronix.de>
References: <20240202163221.2488589-1-bigeasy@linutronix.de>
 <20240213153737.6ukdoJKc@linutronix.de>
 <ZcuR0bm73CNKpCLR@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZcuR0bm73CNKpCLR@boxer>

On 2024-02-13 16:59:13 [+0100], Maciej Fijalkowski wrote:
> I acked it week ago or so, maybe bpf maintainers missed it as I don't see
> them being CCed? Adding in now.

Thank you. They did not pop up on get_maintainer so I did not add them. 

Sebastian

