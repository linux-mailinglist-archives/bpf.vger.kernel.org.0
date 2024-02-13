Return-Path: <bpf+bounces-21854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C28A8534D7
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 16:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3011F2A5E9
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE155E3D8;
	Tue, 13 Feb 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KFV+Fpse";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8hJZn3Rn"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573A5F464
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838662; cv=none; b=bb7E9qOqpg2T/8miyG8ceKthh2tY8HUIwetUcfKcKwwKbnoLqlPZreuQ5V2miQ4L0j/C8S2jvdWr79TnKNI57pbijxW0+6C74+m+D7UfurGGe8iYw4pWwYUvgTRvD/S6IQ9pF5QGmm2RVSMwxuwT7UYEVV9VAz0L81nqbrkrtrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838662; c=relaxed/simple;
	bh=9ae0zowv+FTf0BV8OjscX4XRBQWzmt7lzbPqlldx+Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCUjEFPRuVjtX90uZbotbl22FhUqYJcmAyl8G9H+8zsAdTwnYIXfplIx0sGt+6kZGvgO4v/qjoWPZqN4d+D1TQsrbaVXfOPFJQUQyZnlMKshbXkWzphJpqDu2HZeOyCHNLNQXgj20CkvS0lJITiILfY/H5GDNifhd0JbaOClZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KFV+Fpse; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8hJZn3Rn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 16:37:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707838659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2ngj868D78B9u/COwd4+ahxj2/ZFyZcKLQyGahMiC8=;
	b=KFV+FpseNZg7ZA7ZqX/oZ+6o+ZVjAS2iVuJNkBxITF3fKJ7MqC3W7kvvmhviZ4Y9WkfGYP
	VMHsrGV59Z/ICjDfuuCE2lQgBRjFHf2YWcObSkl+IeFgJSg6qhxedxJCdlgXV5LTJ9Vyqa
	6z7rYFayb9NLD+IbXFvuWnEecCZMSx7wZEDiZdCNbZEArUYGm4d0M9oyKwvDrPnEoTuZR6
	aJcbAcjUC8240bj0WkLSat+Ws0vke93a36wPGa6eljyRwGQZgyfEiuD8hPWsITZM1u+Ga3
	m7LSl3i8Vx2jWWdD0SJ/aQ+9IH/yAN9wrvouAVEh+eAj3k2ZHTfiqzsupSo9+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707838659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2ngj868D78B9u/COwd4+ahxj2/ZFyZcKLQyGahMiC8=;
	b=8hJZn3RnlKj8ZNAbZGcpJrW+tOa2XjNRgRFL2QYF1u2j0OGn/a+toHjEM1uyTTE6FQz0OI
	jCQYOgAcyogbjoAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: bpf@vger.kernel.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH bpf] xsk: Add truesize to skb_add_rx_frag().
Message-ID: <20240213153737.6ukdoJKc@linutronix.de>
References: <20240202163221.2488589-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202163221.2488589-1-bigeasy@linutronix.de>

On 2024-02-02 17:32:20 [+0100], To bpf@vger.kernel.org wrote:
> xsk_build_skb() allocates a page and adds it to the skb via
> skb_add_rx_frag() and specifies 0 for truesize. This leads to a warning
> in skb_add_rx_frag() with CONFIG_DEBUG_NET enabled because size is
> larger than truesize.
> 
> Increasing truesize requires to add the same amount to socket's
> sk_wmem_alloc counter in order not to underflow the counter during
> release in the destructor (sock_wfree()).
> 
> Pass the size of the allocated page as truesize to skb_add_rx_frag().
> Add this mount to socket's sk_wmem_alloc counter.
> 
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Is this stuck somewhere or just waiting for review/ etc?
Patchwork says new and the ci failure on s390x seems unrelated.

Sebastian

