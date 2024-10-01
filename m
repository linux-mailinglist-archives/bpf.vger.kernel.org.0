Return-Path: <bpf+bounces-40667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AF198BDED
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 15:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 063B7B24BAA
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 13:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BF41C4623;
	Tue,  1 Oct 2024 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aVPBOyFF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CMosy8MG"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559161C57A7
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789769; cv=none; b=EZqIVQiDjEHXdwFalYocBsgVJ/cjngiGgtbY8UmziFtHLoPTm0+FKiSf1Rl/T+qTawEd7ti2Y6GBsfcIV+blcFdCxW0JDPIBSX9zwSWbs77DwUHOuguPCSG49zurA+GeMOoc817r5jlYZBXlmmjalCU9jYGIOsn53WOD4NwgDw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789769; c=relaxed/simple;
	bh=1Q91ZtOx7WXzoCuq5xvTv6JxndWm9IVhATDFHynZAwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkWteZKi6EZ4dw0bCMpugZ8KIemZLAFKw+Vqf8E5CX/0fACYdQQ0E9GF8O5QDGN7NXTgIaSq40nR0Oa9lYzY1h2duz55MDfh485sTDm/Qf1cFzVrCUIUb8l6NTzB0ZopLphT2xrnHCByAR9JOrDJ4l9xd4GJRcHGOiMz7blO0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aVPBOyFF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CMosy8MG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 1 Oct 2024 15:36:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727789764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SIgvgdhetwAqHvFy5k54XNttIMSQkB7d/Tr1DJfFHc=;
	b=aVPBOyFFux98IBE21Pp6G8aTBmaowZ5bZAy4m8Cf3mmyrvvBBUpPUX4N6/UKPw6+Wq+1uh
	VLsgmoVKSTh1LRLuddxeVw/znCSIJRJLAqn7YnqGMFpRcHm+eqlaWXBjPMWE55QQR12Dum
	zupZ3VKrjqWEHb2fUNTgj5QiZZ+ywlYvYOuAKg+FObnrvAazCQJPyRnCLSYuJcj0QkIlBX
	Agrr0avxl26SYCjE3YxHowX8RqPuBBah7XI53im/AYAZTulks7sp5Bj2mQc40ybaaq1VJA
	w1zT+x1x6J2MAm3B26ynFFxSGJP/XnivS7WrMVpJVPG9LuuyzUVvGaY6n9b/sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727789764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SIgvgdhetwAqHvFy5k54XNttIMSQkB7d/Tr1DJfFHc=;
	b=CMosy8MG7OY0nAy8J4gZ+nFGdOOT6QSPhFL1mAXCsmMAgtHgc0Rtx7xIKBz5l6W8ypZjtt
	ENzxLKBegfEeESCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yury Vostrikov <mon@unformed.ru>
Cc: bpf@vger.kernel.org, Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: NULL pointer deref inside xdp_do_flush due to
 bpf_net_ctx_get_all_used_flush_lists
Message-ID: <20241001133603.G8j39V2l@linutronix.de>
References: <5627f6d1-5491-4462-9d75-bc0612c26a22@app.fastmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5627f6d1-5491-4462-9d75-bc0612c26a22@app.fastmail.com>

On 2024-10-01 13:30:13 [+0200], Yury Vostrikov wrote:
> Hi,
Hi,

=E2=80=A6
> I get the following backtrace instead of crash:
>=20
> [  177.216427] ------------[ cut here ]------------
=E2=80=A6
> [  177.216464] Call Trace:
> [  177.216464]  <TASK>
> [  177.216474]  efx_poll+0x178/0x380 [sfc_siena]
> [  177.216479]  netpoll_poll_dev+0x118/0x1b0
> [  177.216481]  __netpoll_send_skb+0x1ae/0x240
> [  177.216482]  netpoll_send_udp+0x2e5/0x400
> [  177.216484]  write_msg+0xeb/0x100 [netconsole]
> [  177.216486]  console_flush_all+0x261/0x440
> [  177.216489]  console_unlock+0x71/0xf0
> [  177.216490]  vprintk_emit+0x251/0x2b0
> [  177.216491]  _printk+0x48/0x50
=E2=80=A6
> I'm out of my depth figuring out why bpf_net_ctx_get() returns NULL. For =
now I'm simply running with NULL check enabled.

netpoll_send_udp() Does not assign a context and invokes a NAPI poll.
However with a budget of 0 to just clean the TX resources.
Now, the SFC driver does not clean any RX packets but invokes
xdp_do_flush() anyway which leads to the crash later on.
Are the SFC maintainer against the following:

diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet=
/sfc/efx_channels.c
index c9e17a8208a90..f3288e02c1bd8 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -1260,7 +1260,8 @@ static int efx_poll(struct napi_struct *napi, int bud=
get)
=20
 	spent =3D efx_process_channel(channel, budget);
=20
-	xdp_do_flush();
+	if (spent)
+		xdp_do_flush();
=20
 	if (spent < budget) {
 		if (efx_channel_has_rx_queue(channel) &&
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/et=
hernet/sfc/siena/efx_channels.c
index a7346e965bfe7..2b8b7c69bd7ae 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -1285,7 +1285,8 @@ static int efx_poll(struct napi_struct *napi, int bud=
get)
=20
 	spent =3D efx_process_channel(channel, budget);
=20
-	xdp_do_flush();
+	if (spent)
+		xdp_do_flush();
=20
 	if (spent < budget) {
 		if (efx_channel_has_rx_queue(channel) &&

This should fix the crash. As an alternative we could keep track of
channel->n_rx_xdp_redirect before and after the efx_process_channel()
invocation to avoid the flush if there is no XDP done.

Sebastian

