Return-Path: <bpf+bounces-50210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F94A23B50
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 10:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DE8162B7F
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 09:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590AA18871F;
	Fri, 31 Jan 2025 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcydh1KL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C916A956;
	Fri, 31 Jan 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738315388; cv=none; b=KSQRm7MUdoszeDUwgr1i1ghQmPiLxbNQDRpveRPyF2idUOEZLwjsa9sirXWoB90a4sX8vJnh1fHMvshG4JXny3MQOq4+OzK1fTFkRJO+7eo4K3UGWTOIn6H2FS/0YHYX9LD42rLof4Tcz15B7jLX47wO6Fds6vV5ttFQHB/+tkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738315388; c=relaxed/simple;
	bh=KeHvGWciRrSfx4bampdiqa3DbAYAgVZ+5Dzn1wpMkn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBebwEOyboNfdC3bWJoetE1BTTgCjsLiy2juHNY8LyUzMxsER8YFqhLgdmv0LfQlKKulBWrySEd8IzNug8KPOR72+LQrG1/HJ3EMSo5kPk60/Z6dhd+Ubqs8hOPaoI6SIZcWNaeGkHqVkDpqBRM6ZS8SnfUnNrv8rVhj7JXalCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcydh1KL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C43C4CED1;
	Fri, 31 Jan 2025 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738315388;
	bh=KeHvGWciRrSfx4bampdiqa3DbAYAgVZ+5Dzn1wpMkn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcydh1KLVhW5vOLrLDl8pPo1/yDX9hLZWajBhUZ/VAbmtdQEUmuJ7jZapLo/s9Atg
	 7BiqZ3RclVh4m3qYiQvzxDClEHydjQgmvrPb0P4GuKBUQQT0kN132EhLDht4VxofxI
	 TFD6ljQoTLUBhpMHE3oTmM1RMYhwJWleaAXBmxauUPIaHnk5cy0E67twifeW6hhwXZ
	 n3dlPrhzhjqvwBh5c7MIX9axMC9ur7VqvrYMHy2PD5qbT6U/enCkuCkRWdWoxnbsGW
	 Ia9xIP3eSpv28R82lQ/KZ3PSZZKAfowR4lRg+LqGDM2HlK7IoKzwfJmzDUg4G5PXOv
	 cNK1zka+khWqg==
Date: Fri, 31 Jan 2025 09:23:03 +0000
From: Simon Horman <horms@kernel.org>
To: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, alexanderduyck@fb.com,
	alexandr.lobakin@intel.com, andrew+netdev@lunn.ch, ast@kernel.org,
	bcm-kernel-feedback-list@broadcom.com, bpf@vger.kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
	hawk@kernel.org, john.fastabend@gmail.com, pabeni@redhat.com,
	ronak.doshi@broadcom.com, u9012063@gmail.com
Subject: Re: [PATCH net v3] vmxnet3: Fix tx queue race condition with XDP
Message-ID: <20250131092303.GC24105@kernel.org>
References: <20250131042340.156547-1-sankararaman.jayaraman@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250131042340.156547-1-sankararaman.jayaraman@broadcom.com>

On Fri, Jan 31, 2025 at 09:53:41AM +0530, Sankararaman Jayaraman wrote:
> If XDP traffic runs on a CPU which is greater than or equal to
> the number of the Tx queues of the NIC, then vmxnet3_xdp_get_tq()
> always picks up queue 0 for transmission as it uses reciprocal scale
> instead of simple modulo operation.
> 
> vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() use the above
> returned queue without any locking which can lead to race conditions
> when multiple XDP xmits run in parallel on different CPU's.
> 
> This patch uses a simple module scheme when the current CPU equals or
> exceeds the number of Tx queues on the NIC. It also adds locking in
> vmxnet3_xdp_xmit() and vmxnet3_xdp_xmit_frame() functions.
> 
> Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
> Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
> ---
> v3:
>   - In vmxnet3_xdp_xmit_frame(), use the irq version of spin lock 
>   - Fixed the ordering of local variables in vmxnet3_xdp_xmit()
> v2: https://lore.kernel.org/netdev/20250129181703.148027-1-sankararaman.jayaraman@broadcom.com/
>   - Retained the earlier copyright dates as it is a bug fix
>   - Used spin_lock()/spin_unlock() instead of spin_lock_irqsave()
> v1: https://lore.kernel.org/netdev/20250124090211.110328-1-sankararaman.jayaraman@broadcom.com/
> 
>  drivers/net/vmxnet3/vmxnet3_xdp.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>


