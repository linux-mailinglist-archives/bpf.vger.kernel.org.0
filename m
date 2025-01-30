Return-Path: <bpf+bounces-50090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E95A22767
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 02:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1047A262F
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D964594A;
	Thu, 30 Jan 2025 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH8s0o/h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F152E822;
	Thu, 30 Jan 2025 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738199704; cv=none; b=NvXLplVRQTopsqoL7xeJK5m9IH/euJUijxTsjOwsmFVgRaBsdsUy5EfuAfvce0XMIBhMrqRibX2dHei5YC9JZ0T98UmZ/ZCyGwtHSNM67kDIt5WdonmtgzWiCQeknEvVXT97qmT8CfrwRUbC2Q1l7FJqR7IUetFhU0NKpvbOIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738199704; c=relaxed/simple;
	bh=FZNjlG0LP2vC/Ut4yUAu2ih857dBojr6Itm/8rGld9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IthFdVgkbE0MCKq2RiwBKkfhAhu1RXxLVLDfg7qu1us90EIkghuVINO74YRFBJ2f/x/yLtapPJAT4aVx932W4TKHT1foLAtnnDFhZ6zM1nvQ0MOOkYP3WWzsx7N/lsdSU6BElB1/D34mkt5UIdfM1dd6rdkIlreNoUIm60SbBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH8s0o/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845ACC4CED1;
	Thu, 30 Jan 2025 01:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738199703;
	bh=FZNjlG0LP2vC/Ut4yUAu2ih857dBojr6Itm/8rGld9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OH8s0o/hkA5lCKpWe0gqnz6PH44dRKunHZTuRdEr7gGvolDQmJ8gdhVuAE2ojbjhw
	 jrVDbLQ187rgcUX9vAOPwnR3nQgxvm/8C15jxoxQE7Mc+OedmDku0kffIfqnPBS5cg
	 /5zH6KgaR4GpYoQDsq03fh2b4rd2J3rGEtjD3IfM3STNbavsGZAoUslrE6mqjW3nGy
	 vxJLL4DUOCMd1fCDiIWKYAgNXbXXBXf+aZ73Df9bDwmjjS/tC6nIVqX11fld20G06j
	 HPlZbILaPP7xYeDLf5Yi5XCyCEzPmsPoZfOZ6juHT5HNXAswYopaUvi3ZUiMMJ0tar
	 /bnR9XKmoLAsw==
Date: Wed, 29 Jan 2025 17:15:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Cc: alexanderduyck@fb.com, alexandr.lobakin@intel.com,
 andrew+netdev@lunn.ch, ast@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
 hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com, ronak.doshi@broadcom.com, u9012063@gmail.com
Subject: Re: [PATCH net v2] vmxnet3: Fix tx queue race condition with XDP
Message-ID: <20250129171501.7d120cae@kernel.org>
In-Reply-To: <20250129181703.148027-1-sankararaman.jayaraman@broadcom.com>
References: <20250127143635.623dc3b0@kernel.org>
	<20250129181703.148027-1-sankararaman.jayaraman@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jan 2025 23:47:03 +0530 Sankararaman Jayaraman wrote:
> If XDP traffic runs on a CPU which is greater than or equal to
> the number of the Tx queues of the NIC, then vmxnet3_xdp_get_tq()
> always picks up queue 0 for transmission as it uses reciprocal scale
> instead of simple modulo operation.
>=20
> vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() use the above
> returned queue without any locking which can lead to race conditions
> when multiple XDP xmits run in parallel on different=C2=A0CPU's.
>=20
> This patch uses a simple module scheme when the current CPU equals or
> exceeds the number of Tx queues on the NIC. It also adds locking in
> vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() functions.
>=20
> Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
> Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.co=
m>
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>

Please add a --- separator between commit message and change log

> Changes v1-> v2:
> Retained the copyright dates as it is.
> Used spin_lock()/spin_unlock() instead of spin_lock_irqsave().=20

Wrong way around AFAICT. The lock is taken on the xmit path,
and driver supports netpoll. But this path won't be called
from IRQ. So the right type of call is very likely _irq().

Please do not post next version of the patch in reply to previous
posting. Instead add to the change log a lore link to previous
posting. See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#changes=
-requested
Actually, also make sure you read at least the tl;dr section, too.

> @@ -226,6 +231,7 @@ vmxnet3_xdp_xmit(struct net_device *dev,
>  	struct vmxnet3_adapter *adapter =3D netdev_priv(dev);
>  	struct vmxnet3_tx_queue *tq;
>  	int i;
> +	struct netdev_queue *nq;

Reverse length order. So:

 	struct vmxnet3_adapter *adapter =3D netdev_priv(dev);
 	struct vmxnet3_tx_queue *tq;
+	struct netdev_queue *nq;
 	int i;
--=20
pw-bot: cr

