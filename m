Return-Path: <bpf+bounces-76101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA77CA6F39
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 10:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE03338A41EA
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FA6343D78;
	Fri,  5 Dec 2025 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VqR7xi3b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UQTDx2A2"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0371345CB7;
	Fri,  5 Dec 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764921505; cv=none; b=X5oFb5xvdnj1TqRIfmq+PtTbJYxNFEL7Yk65r7jXVPJ0tQowviKFUAhkUj2VzEXDn7/y4abXLXIRZZLuWXseQ/HQJ8cgqMN6m4694iNQ1WpC0Y7DZYVhYq6p0ZF79s5U4mDWjXus+ysKhQoV475f1l2ubz/CkGyg9+TfC7PJsAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764921505; c=relaxed/simple;
	bh=GdSs4IOZtRfzPzISB8KAXBPj9abiDx7Q+sT4nyxgnlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0Bm7/WlmiR1qN52hbmNUGh92cMg8WqJvpXXvcup39NRQLh9DTNIT3dm/iPSKOdpQ+cilah7wgHtTQoPH22dvP9w2p742X5kQVNyO8ghawByAkEupOi2RSnFyEIsG4DJTuXLoHZm+uaP/1dm3a5wHId1CLqr/KZJ2+qvHCSkC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VqR7xi3b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UQTDx2A2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 5 Dec 2025 08:58:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764921487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iVl92zKa3BsxR82OA+CaLiMB0c3yaThaQXm87jGM70=;
	b=VqR7xi3bnEZyhYAlLO7xyuUU+/jVU3SxgWxz5Hk81iier/vba0fuJdIdyFvt7oSQC0BSlz
	4sDSI2H7vMYDZYOym8t3czEDzPE/wLxGffm1jVax6GUwXmGEoLGLClvp0iKOpGDN556Spg
	0NnnwBfOcL5eE2ToKmdSKK7dNFIsbJ9bG+xx6WT97NxjGJEJLe6fILuYMi6eiwp5kUfKHZ
	nTS2wyo5TUbD7aQGWFVfkEF2XxSsne/Fwf1KCD1N697YTFX/WeYiBDteb657BZmXWn50i/
	+i/QFJpAbSezKvQsSY6HnnZ9ul4B3nmdZ/LlQZhILNj+S3V2AjK0XSpX+ch86g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764921487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iVl92zKa3BsxR82OA+CaLiMB0c3yaThaQXm87jGM70=;
	b=UQTDx2A2zNWnEUQpO1czFg5NKl3RS5ecDJUYU3XMiMzHI9Jxv8Inqh8y17FZFZgZtnpofI
	a2HmilpdNKLgV5Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jon Kohler <jon@nutanix.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v2 5/9] tun: use bulk NAPI cache allocation in
 tun_xdp_one
Message-ID: <20251205075805.vW4ShQvN@linutronix.de>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <20251125200041.1565663-6-jon@nutanix.com>
 <CACGkMEsDCVKSzHSKACAPp3Wsd8LscUE0GO4Ko9GPGfTR0vapyg@mail.gmail.com>
 <CF8FF91A-2197-47F7-882B-33967C9C6089@nutanix.com>
 <c04b51c6-bc03-410e-af41-64f318b8960f@kernel.org>
 <20251203084708.FKvfWWxW@linutronix.de>
 <CA37D267-2A2F-47FD-8BAF-184891FE1B7E@nutanix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA37D267-2A2F-47FD-8BAF-184891FE1B7E@nutanix.com>

On 2025-12-03 15:35:24 [+0000], Jon Kohler wrote:
> Thanks, Sebastian - so if I=E2=80=99m reading this correct, it *is* fine =
to do
> the two following patterns, outside of NAPI:
>=20
>    local_bh_disable();
>    skb =3D napi_build_skb(buf, len);
>    local_bh_enable();
>=20
>    local_bh_disable();
>    napi_consume_skb(skb, 1);
>    local_bh_enable();
>=20
> If so, I wonder if it would be cleaner to have something like
>    build_skb_bh(buf, len);
>=20
>    consume_skb_bh(skb, 1);
>=20
> Then have those methods handle the local_bh enable/disable, so that
> the toggle was a property of a call, not a requirement of the call?=20

Having budget =3D 0 would be for non-NAPI users. So passing the 1 is
superfluous. You goal seems to be to re-use napi_alloc_cache. Right? And
this is better than skb_pool?

There is already napi_alloc_skb() which expects BH to be disabled and
netdev_alloc_skb() (and friends) which do disable BH if needed. I don't
see an equivalent for non-NAPI users. Haven't checked if any of these
could replace your napi_build_skb().

Historically non-NAPI users would be IRQ users and those can't do
local_bh_disable(). Therefore there is dev_kfree_skb_irq_reason() for
them. You need to delay the free for two reasons.
It seems pure software implementations didn't bother so far.

It might make sense to do napi_consume_skb() similar to
__netdev_alloc_skb() so that also budget=3D0 users fill the pool if this
is really a benefit.

Sebastian

