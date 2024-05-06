Return-Path: <bpf+bounces-28695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD48BD491
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 20:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB9B1F22AAE
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39811158A27;
	Mon,  6 May 2024 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYu7ZL9v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F0197;
	Mon,  6 May 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020173; cv=none; b=j6DNtBamxSw+QLkdpOfZnA0EBS7WhTT97XT8zdtjvX+t4QaMnRbtiK+VjGHt7z1Valsml8QmMQIejhJvZbzsBSSOfymvgmuyxhWX/i9H7frXUh0fEDcb1Om/PwisAcPfNGr8ujRZX2cDVUDpscLeVufMd8nI6YCPuwIRuHU9ugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020173; c=relaxed/simple;
	bh=Jg7BOhMVd+5bqaLKq8JWxbODI0k/8tdTr8AXexb+oiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOfqrUXXDg/vowNOKyVpz7MAH//C/gB06aP2RtHrcrZHe1w7rnOjENOAqeGR5lMSORUo1W+XNPBsMJ08RNAiBTu50U5zAzpxjVxBRSbZP7I6P5/FKZaw8d4yPdZtVhXh0i8WnCx3mQqtuyrzLaJcNl4e8el02P+cokFUB7ySZI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYu7ZL9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E36C116B1;
	Mon,  6 May 2024 18:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715020173;
	bh=Jg7BOhMVd+5bqaLKq8JWxbODI0k/8tdTr8AXexb+oiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jYu7ZL9vGTyQrn0OwIuQzduS/GOT6CI0qudddB+4EZgwmkPGFp0A3jFcCdSyLGjdz
	 VF0hA+B77oEktUP3ahcfLUq7Xmy2rW6EGajF99f7M+LXtGM1Hw/5mc9Q3jGN3Ah+Yh
	 UCfG/JqB7h8v6JHXXqBnLFlS0YLzeyfC1dZS9RbtptdSU0o3m8ygmxqIFtE3bw8pQX
	 G7+NZ5iQKSDf+AKdJqEV7RFJ0QcQOibl0rxQmD3B1/o2b+kRoGWObYUum8ATY9PJsn
	 14yknCIXErJ0A3MUNyFogUJqMcDsg204cxqBbDYE1QWDx1FZIzlQOA4Nkk52GmTwJn
	 zFD+Xvwyzbf1A==
Date: Mon, 6 May 2024 11:29:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Magnus Karlsson
 <magnus.karlsson@intel.com>, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 7/7] xsk: use generic DMA sync shortcut
 instead of a custom one
Message-ID: <20240506112931.39614ff0@kernel.org>
In-Reply-To: <20240506094855.12944-8-aleksander.lobakin@intel.com>
References: <20240506094855.12944-1-aleksander.lobakin@intel.com>
	<20240506094855.12944-8-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 May 2024 11:48:55 +0200 Alexander Lobakin wrote:
> XSk infra's been using its own DMA sync shortcut to try avoiding
> redundant function calls. Now that there is a generic one, remove
> the custom implementation and rely on the generic helpers.
> xsk_buff_dma_sync_for_cpu() doesn't need the second argument anymore,
> remove it.

I think this is crashing xsk tests:

  [   91.048963] BUG: kernel NULL pointer dereference, address: 0000000000000464
  [   91.049412] #PF: supervisor read access in kernel mode
  [   91.049739] #PF: error_code(0x0000) - not-present page
  [   91.050057] PGD 0 P4D 0
  [   91.050221] Oops: 0000 [#1] PREEMPT SMP NOPTI
  [   91.050500] CPU: 1 PID: 114 Comm: new_name Tainted: G           OE      6.9.0-rc6-gad3c108348fd-dirty #372
  [   91.051088] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
  [   91.051649] RIP: 0010:xp_alloc+0x76/0x240
  [   91.051903] Code: 48 89 0a 48 89 00 48 89 40 08 41 c7 44 24 34 00 00 00 00 49 8b 44 24 18 48 05 00 01 00 00 49 89 04 24 49 89 44 24 10 48 8b 3b <f6> 87 64 04 00 00 20 0f 85 16 01 00 00 48 8b 44 24 08 65 48 33 04
  [   91.053055] RSP: 0018:ffff99e7c00f0b00 EFLAGS: 00010286
  [   91.053400] RAX: ffff99e7c0c9d100 RBX: ffff89a400901c00 RCX: 0000000000010000
  [   91.053838] RDX: 0000000000000000 RSI: 0000000000000010 RDI: 0000000000000000
  [   91.054277] RBP: ffff89a4026e30e0 R08: 0000000000000001 R09: 0000000000009000
  [   91.054716] R10: 779660ad50f0d4e6 R11: 79b5ce88640fb4f7 R12: ffff89a40c31d870
  [   91.055156] R13: 0000000000000020 R14: 0000000000000000 R15: ffff89a4068c6000
  [   91.055596] FS:  00007f87685bef80(0000) GS:ffff89a43bd00000(0000) knlGS:0000000000000000
  [   91.056090] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [   91.056458] CR2: 0000000000000464 CR3: 000000010229c001 CR4: 0000000000770ef0
  [   91.056904] PKRU: 55555554
  [   91.057079] Call Trace:
  [   91.057237]  <IRQ>
  [   91.057371]  ? __die_body+0x1f/0x70
  [   91.057595]  ? page_fault_oops+0x15a/0x460
  [   91.057852]  ? find_held_lock+0x2b/0x80
  [   91.058093]  ? __skb_flow_dissect+0x30f/0x1f10
  [   91.058374]  ? lock_release+0xbd/0x280
  [   91.058610]  ? exc_page_fault+0x67/0x1e0
  [   91.058859]  ? asm_exc_page_fault+0x26/0x30
  [   91.059126]  ? xp_alloc+0x76/0x240
  [   91.059341]  __xsk_rcv+0x1f0/0x360
  [   91.059558]  ? __skb_get_hash+0x5b/0x1f0
  [   91.059804]  ? __skb_get_hash+0x5b/0x1f0
  [   91.060050]  __xsk_map_redirect+0x7c/0x2c0
  [   91.060315]  ? rcu_read_lock_held_common+0x2e/0x50
  [   91.060622]  xdp_do_redirect+0x28f/0x4b0
  [   91.060871]  veth_xdp_rcv_skb+0x29e/0x930
  [   91.061126]  veth_xdp_rcv+0x184/0x290
  [   91.061358]  ? update_load_avg+0x8c/0x8c0
  [   91.061609]  ? select_task_rq_fair+0x1ff/0x15a0
  [   91.061894]  ? place_entity+0x19/0x100
  [   91.062131]  veth_poll+0x6c/0x2f0
  [   91.062343]  ? _raw_spin_unlock_irqrestore+0x27/0x50
  [   91.062653]  ? try_to_wake_up+0x261/0x8d0
  [   91.062905]  ? find_held_lock+0x2b/0x80
  [   91.063147]  __napi_poll+0x27/0x200
  [   91.063376]  net_rx_action+0x172/0x320
  [   91.063617]  __do_softirq+0xb6/0x3a3
  [   91.063843]  ? __dev_direct_xmit+0x167/0x1b0
  [   91.064114]  do_softirq.part.0+0x3b/0x70
  [   91.064373]  </IRQ>
  [   91.064511]  <TASK>
  [   91.064650]  __local_bh_enable_ip+0xbd/0xe0
  [   91.064913]  __dev_direct_xmit+0x16c/0x1b0
  [   91.065171]  xsk_generic_xmit+0x703/0xb10
  [   91.065425]  xsk_sendmsg+0x21f/0x2f0

