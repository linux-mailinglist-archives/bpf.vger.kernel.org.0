Return-Path: <bpf+bounces-72306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D1EC0CF95
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 11:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C5C34F1D28
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A116F2F6918;
	Mon, 27 Oct 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdVrRUDs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059592F360B;
	Mon, 27 Oct 2025 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761561229; cv=none; b=PQwpzMBXUh0dMBdWrY0FonBz2+7FxzTN180F800041nk49HKDmQdUbIOVWrB7ucCJUdgnpWKqM+lMfp8O9SAvLnAsz1bxL0xJ78GXV+VKSX2uPVQOmZpZytvUtn5KAloMBIdtL9509OkhBm+A/48IMmLfAkXEjg/JRxne1yR67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761561229; c=relaxed/simple;
	bh=JXuWKSrzcDSwniRxFWm8IG0GNaZwFfl7ZGK7XaiPnvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPOQGxmIRaCfeExQNeJ3TxGbKJnf96X5+AX8VwvB8BB+hczVl7DgHKKH5G4hSriq+rKhFJzUNUaMzqF0OBIjzw9LAz9AdMIpF0MyYkMlErP04B9GtRfZ7/Txx97CHsmETxVvu3n3C9agaEC2VlSWKC7ztOplJ81r26OL7qgw4Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdVrRUDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E9EC4CEF1;
	Mon, 27 Oct 2025 10:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761561228;
	bh=JXuWKSrzcDSwniRxFWm8IG0GNaZwFfl7ZGK7XaiPnvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZdVrRUDsSx6LWw0pOykHp3JSOzbDaU4Vxus8G6LJ2fHF+6PXVeyH7DB4yG7193TMO
	 OMbk6AxfolYHXOzOEk568xXsyAW+BVWanifXoXPBGqAwWvcCyficWTV6xOpeqiMMme
	 GhCuApJKVKrGs9j6Li3ZyT3+Fq2pb/mtDS6V7TKyeJj5ylhZGRrkBTUyGObKYPfz6o
	 /ZEos0jzBmSHhNMRdg5Xfb2wZiXpDWTOovCzlC2esmS1WopS/WdskFTUiFBbu+gLoO
	 zHUDhITb53djtZoJ9atVIyTaA426P0rUYV5ViwGfKusdBiI5/Fjac/sGAzdVpo3zfP
	 KT8enjjrwvjiA==
Message-ID: <a862beed-3361-4f78-b412-87b78095ac84@kernel.org>
Date: Mon, 27 Oct 2025 11:33:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V1 2/3] veth: stop and start all TX queue in netdev
 down/up
To: Jakub Kicinski <kuba@kernel.org>, Chris Arges <carges@cloudflare.com>
Cc: netdev@vger.kernel.org, makita.toshiaki@lab.ntt.co.jp,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 ihor.solodrai@linux.dev, toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
 <176123157775.2281302.5972243809904783041.stgit@firesoul>
 <20251024175402.397c05a9@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20251024175402.397c05a9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 25/10/2025 02.54, Jakub Kicinski wrote:
> On Thu, 23 Oct 2025 16:59:37 +0200 Jesper Dangaard Brouer wrote:
>> The veth driver started manipulating TXQ states in commit
>> dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring
>> to reduce TX drops").
>>
>> Other drivers manipulating TXQ states takes care of stopping
>> and starting TXQs in NDOs.  Thus, adding this to veth .ndo_open
>> and .ndo_stop.
> 
> Kinda, but taking a device up or down resets the qdisc, IIRC.
> 
> So stopping the qdisc for real drivers is mostly a way to make sure
> that there's nothing entering the xmit handler as the driver dismantles
> its state.
> 
> I'm not sure if this is an official rule, but I'm under the impression
> that stopping the queues or carrier loss (and
> netif_tx_stop_all_queues(peer) in close() is stopping peer's Tx queue
> on carrier loss) is inadvisable as it may lead to old packets getting
> transmitted when carrier comes back.
> 
> IOW based on the commit msg - I'm not sure this patch is needed..

During incident, when doing ip link set 'down' flushed all packets in
the qdisc, but the TXQs were not reset (started again) on link 'up'.
  Thus, the qdisc would fill-up again and block all packets on interface.
  Chris also tried to replace the qdisc, but the TXQ was still in stopped
mode QUEUE_STATE_DRV_XOFF state.

This was the origin of the patch, that we could not recover the machine
from this state.  Thus, the idea of starting all queue on link 'up',
would give us a recovery mechanism.  With dev_watchdog this change isn't
really needed.
As you mention this may lead to old packets getting transmitted when
carrier comes back, which would be a changed behavior, that we don't
want in a fixes patch.  So, I will drop this patch.

--Jesper



