Return-Path: <bpf+bounces-55327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07248A7BE0F
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 15:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8111887DA0
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 13:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8627F1F239B;
	Fri,  4 Apr 2025 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hexFYUyR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IprLCLqr"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1A1F0E31;
	Fri,  4 Apr 2025 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743773853; cv=none; b=ZOimkZK97qNK/3rfNvX0mFKiVZZf2hLNSmTRDVRUlChTFJbxRHuqx9AnLUhcz5PG9WebgWcgmI65DFpH+7g8MQWWUDum0YOaKIEGrOuMwtUBEEXcwf3oKdPGzKoR5a/H7dnXbqRcx/b8xfXs+gtOOazXoQhFkQsRBVjRiZF2UyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743773853; c=relaxed/simple;
	bh=OEQ9GwNGPOJ++ALYGegXZs/OFMv5p/4dKMJh9bUysIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INaDvv/jVITthRwWY+ISm22mqu2pqiInQIKhWsVCmyxdDYpC06ZS0mB34mQnhCIMC4zmqZVNUQCix1C834bc8Wj65A6Du7YaA1hautCx1CEUV0R0w8DBGLaMhxs6bPlnG2FlNRTiYGtCGY9K3ieIy5cn8WY4F4gh6iaUeQ93E7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hexFYUyR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IprLCLqr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 4 Apr 2025 15:37:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743773849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ar/tUV/xMvmsShBDJvAOaiQqbfbyRlHruYDviOiFDzA=;
	b=hexFYUyRK9IYtuiLaqYGXRtPr03xJqwgZjOep56joqe7m0KwlXp+3itgY/s4F6Ibz0F5lA
	ZvckogkQDImhzyZ9Waq1AYBcgGY81S2cs/pBGZISuMEpFX4r7aMYaoMl2fpEfKd6KOh4DZ
	5RANWvapqrlxgYUV65Yeni+AuECMxBjCgbonJhEgeIZpz3svULRtv5SzE+XlBYZtO3nzA0
	UnsjxYYjRIKczks1HGiLVCrp6oQPM7bJDU9FBvmHbFCq0LXsQ+bYsk+xF6VfU41fUm4OwY
	+UKxg24W+lsGgJjVjxJ/lPc984FHr8tJN/ptQvUb6hSWT46Qbu6HZqTRI1z/6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743773849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ar/tUV/xMvmsShBDJvAOaiQqbfbyRlHruYDviOiFDzA=;
	b=IprLCLqr73vzH/sc/2EC2x7pnchrHQ1VX/tUbxpaaI/LRfSPMSX8VdKaBLCtr4yV7/RvWW
	cGU/2E65M7PYJbAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Subject: Re: [PATCH stable] xdp: Reset bpf_redirect_info before running a
 xdp's BPF prog.
Message-ID: <20250404133727.x0uxWUPR@linutronix.de>
References: <20250317133813.OwHVKUKe@linutronix.de>
 <2025031733-collide-dad-203a@gregkh>
 <20250317140849.H4eSnqFl@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317140849.H4eSnqFl@linutronix.de>

On 2025-03-17 15:08:52 [+0100], To Greg KH wrote:
> > > I added the commit introducing map redirects as the origin of the
> > > problem which is v4.14-rc1. The code is a bit different there it seems
> > > to work similar.
> > 
> > What stable tree(s) is this for?  Just 6.6.y?  Why not older ones?
> 
> I didn't say just v6.6.y. The commit introducing the problem is in
> v4.14-rc1 so I would say all the way down for the supported trees. Just
> let me know if it does not apply for some of the older kernel.

This wasn't picked up yet. Is it the merge window or something wrong
with the submission?
 
Sebastian

