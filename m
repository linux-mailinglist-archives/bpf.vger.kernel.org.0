Return-Path: <bpf+bounces-39715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A76976926
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 14:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4ED61C23592
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 12:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB691A4E80;
	Thu, 12 Sep 2024 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wK4MuNj6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3zV2dOXt"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D12F1A0BEE;
	Thu, 12 Sep 2024 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726144132; cv=none; b=srcFlk6cNyPjnMA2obWaBex18OfboJsyUU9aOoYA6uhtlZW6GR71HAoSz89d7hopCbwWxV2x+Ptedw0f3GkTKi0dvUDZ6v2jhI0jx74sTBCUsI6FPm423GnQ06ddb+Qjp74p0CKvWQwKOdwX5JP/ySiBBOSyNyBNyIhqZ3iUU4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726144132; c=relaxed/simple;
	bh=m0ipOqG6MW2dNKERRWywqNGBIxidZ5+s5VOAIb/Tfhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfB/RihjygIuPp89mxsBmfmQrUOfxTi5obvGGSv8uzIaw/jb2OuDzT0V327IpKd27NhLojYcQbJpOzI91S2u7dGmbt1T9+EyJ+wF3Fjjjlh6RxiiwpI4obLZBIBuvEn06Huyo01SxhaqXk718PHwoKCFzWpoU0Otpg/iTo4QRts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wK4MuNj6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3zV2dOXt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Sep 2024 14:28:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726144129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HMbQ5wV8vf2Nm/7RjLSdhxJBLrcV/qVUrcxoqXcD+8E=;
	b=wK4MuNj6KQPQpQbzWffOtY0pJHYwl+nho726eiZBSmKlO2U29FRxI+adMH+nqAUhVyuQp5
	pUrPe6I6ZK//I6ILat/Sjx4lhn8Q9Nq4n7c64+T1fwY/5gY3UDYaMWj/7ED3hPMWknfQTq
	uxO/IGNQVxuMEb2iCwdDqt1HlezFPnXCy/nGT9SInlkavzcaBpEHfSNuWKZeq++U8fd7PQ
	h1xGKxUO6vJcBZjEmBSZofR+FICib6KOi56dDAMHvqhwEvyD1B7AR3Kl81pECGm2EL4Tjq
	Fp88iInUpjAeiGhyaix1IkcGqxlle8KAqPu3s8si2lDIfoLjbSJCIx99MOkGyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726144129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HMbQ5wV8vf2Nm/7RjLSdhxJBLrcV/qVUrcxoqXcD+8E=;
	b=3zV2dOXtDquWz0hnlrLEveEQ0VloOdcb9xwkDMwcUCrD0iT7RJiVirKwRirG63OrFLrRXE
	L/pxzmAFGA5c6GDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, andrii@kernel.org, ast@kernel.org,
	syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH net-net] tun: Assign missing bpf_net_context.
Message-ID: <20240912122847.x70_LgN_@linutronix.de>
References: <000000000000adb970061c354f06@google.com>
 <20240702114026.1e1f72b7@kernel.org>
 <20240703122758.i6lt_jii@linutronix.de>
 <20240703120143.43cc1770@kernel.org>
 <20240912-simple-fascinating-mackerel-8fe7c0@devvm32600>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912-simple-fascinating-mackerel-8fe7c0@devvm32600>

On 2024-09-12 05:06:36 [-0700], Breno Leitao wrote:
> Hello Sebastian, Jakub,
Hi,

> I've seen some crashes in 6.11-rc7 that seems related to 401cb7dae8130
> ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.").
> 
> Basically bpf_net_context is NULL, and it is being dereferenced by
> bpf_net_ctx->ri.kern_flags (offset 0x38) in the following code.
> 
> 	static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
> 	{
> 		struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
> 		if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
> 
> That said, it means that bpf_net_ctx_get() is returning NULL.
> 
> This stack is coming from the bpf function bpf_redirect()
> 	BPF_CALL_2(bpf_redirect, u32, ifindex, u64, flags)
> 	{
> 	      struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
> 
> 
> Since I don't think there is XDP involved, I wondering if we need some
> preotection before calling bpf_redirect()

This origins in netkit_xmit(). If my memory serves me, then Daniel told
me that netkit is not doing any redirect and therefore does not need
"this". This must have been during one of the first "designs"/ versions. 

If you are saying, that this is possible then something must be done.
Either assign a context or reject the bpf program.

Sebastian

