Return-Path: <bpf+bounces-33803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D529268F3
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A091C24552
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 19:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1759F18E778;
	Wed,  3 Jul 2024 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I86QyVMY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7PY0MxsU"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5828379;
	Wed,  3 Jul 2024 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720034483; cv=none; b=KHZkzpjz7/tAK8lxN83JoblM3U8+TSEd17SQsKZDby53VEVsaEpTJNfoEbAy/f/ddWHPY9Fhsc7emOH2KBoHXYY5fw6GIZ95jShojTlqxZ1k/6JyTBstHGHOHFAt1GJMks8SZIbf6qCUXRtVl2ThLaN/L306f5k9tMmGJjvxcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720034483; c=relaxed/simple;
	bh=jbfswEjE098uwifNuTZ2TUhmUNT+QU+FOSpeU/E5/58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XITPQhtW0JrDq8LCLfJZ2oGo0oaq6pDRZYSwsWRLVKWxryC1MXEaCFlhKr0Nu4nttsUSsLzVrSRKROu6W7zpvMeXLwAzxSbRPcU9WxrD9/GqXgxDuOC4g0LbTGt5080Ho6BtS70x5whGGFN9B9FPtBYceBArwj8UowAkaow4wRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I86QyVMY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7PY0MxsU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 3 Jul 2024 21:21:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720034480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbfswEjE098uwifNuTZ2TUhmUNT+QU+FOSpeU/E5/58=;
	b=I86QyVMYcQquWhKfSLZXZRMN2bvlXC98lDY+PRXMJbP20Wl2V3B42EYtOQSivUxI6Mu6pw
	WCDC0jLEtPa/WJUTYQb0MTfnlD5h9VZOGGOlSiv648mRp2V7hmRZM8A8gxX3r8OdSXA+x3
	Y/h9yzh2ZLBmWx87D/5W9EGcpiNFzZdT60tUS5K2qcXV0x7S5atrupuFvZw3djExbXlvWQ
	YbGovgiLg/8mQSWHs2R8swm+aI1c7ZO7DidffIEw0ocjiBVUXh+KSPh3J4W/sTpIEhJ8aJ
	Ht5tMcxLLmdTcKgbtlTAAzB/7PJ0o+SCRXL5vlO9u4iwRoJHlahpk427WcG11A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720034480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbfswEjE098uwifNuTZ2TUhmUNT+QU+FOSpeU/E5/58=;
	b=7PY0MxsUjPmTkB+jYWiulmfRCv39xKX4xKDIFKERYgrAuUPNXyRHe/zzCxHOkNXA9zLmnZ
	SXxEQe0dyCkBj8DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH net-net] tun: Assign missing bpf_net_context.
Message-ID: <20240703192118.RIqHj9kS@linutronix.de>
References: <000000000000adb970061c354f06@google.com>
 <20240702114026.1e1f72b7@kernel.org>
 <20240703122758.i6lt_jii@linutronix.de>
 <20240703120143.43cc1770@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240703120143.43cc1770@kernel.org>

On 2024-07-03 12:01:43 [-0700], Jakub Kicinski wrote:
> On Wed, 3 Jul 2024 14:27:58 +0200 Sebastian Andrzej Siewior wrote:
> > During the introduction of struct bpf_net_context handling for
> > XDP-redirect, the tun driver has been missed.
> >=20
> > Set the bpf_net_context before invoking BPF XDP program within the TUN
> > driver.
>=20
> Sorry if I'm missing the point but I think this is insufficient.
> You've covered the NAPI-like entry point to the Rx stack in your
> initial work, but there's also netif_receive_skb() which drivers=20
> may call outside of NAPI, simply disabling BH before the call.

Ah okay. I've been looking at a few callers and they ended up in NAPI
but if you say and I also noticed the one in TUN=E2=80=A6

> The only concern in that case is that we end up in do_xdp_generic(),
> and there's no bpf_net_set_ctx() anywhere on the way. So my intuition
> would be to add the bpf_net_set_ctx() inside the if(xdp_prog) in
> do_xdp_generic(). "XDP generic" has less stringent (more TC-like)=20
> perf requirements, so setting context once per packet should be fine.
> And it will also cover drivers like TUN which use both
> netif_receive_skb() and call do_xdp_generic(), in a single place.

Yeah, sounds good. I would remove the wrapper in tun_get_user() and then
add one to do_xdp_generic().

Sebastian

