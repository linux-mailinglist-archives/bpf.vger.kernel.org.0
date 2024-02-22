Return-Path: <bpf+bounces-22491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB3285F434
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 10:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD48628569C
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844E0374E0;
	Thu, 22 Feb 2024 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rIC0iFWR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7xUmYqaI"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959953838B;
	Thu, 22 Feb 2024 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593759; cv=none; b=A1ZeiDXuYR4sjHb8po/ulUeFsC7MveO4NFt85iHyz2MxvGz0M9ENzdtKhTYuJwj9g9iPBcnl/w8LPdmorF1zxzTcezJay1grAAofEuVcdahMzbNpI6zt6eBmlIRe1M+lH1f5QFQHLyU5wFA4xpY4HVEzpFoCtfwbdeVb6QYVx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593759; c=relaxed/simple;
	bh=9BFN7pdM5ZiSYcyNtkGJiWMLZMBNY1e9xqb+dHzidrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNXeVfU+IwdobHTJNQiWIbiR6jC1yEZohETN87BOYD7gTcGt4DjU690k5q8WyXbcv3NgvvaMVimg2dmXVhm4zgOjHX8GEd//Z/UEUbmXL8UUTtrJftEJ37Soz3xP/fs64jHvR79jgbrqtjPtE1aciEktCXnRIiYmX66aZG28aJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rIC0iFWR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7xUmYqaI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 10:22:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708593749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1fPJ8v6VtMyFAD7TZCdGsonAeaTkgM50Hs3d6uZdpc=;
	b=rIC0iFWRbA70BAIMZFDVCY4wOcxTXH/Q+JstWNEz5vZXuULNXUNDqrgblKRwOBoaHzprK5
	Uc3zoNqpnFCXYK1bUu8M6onWwjrXz2/T9ZPGpoSs/3YUSOvTAi1Hen+p1UA6qCPrElt0B+
	lbUBOnc1cjNHlHoRDJQNVsZhDtnt3rwx8q3Q9HZAsAOZJ/My3R42FyykDd9gmI/TWeB9uK
	ddJYPUHWNAf9VXqMZFfPoev7yYLz2EAFF3yt6FP3ta91yWUGYZ+z6fHfh2H6nBRJDjOHDl
	WhBZWrZxfTKwfi6D35rn4pkVPrnLb5zqP1at4UQDtMjHYwEKi2peHUGIZe7wPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708593749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1fPJ8v6VtMyFAD7TZCdGsonAeaTkgM50Hs3d6uZdpc=;
	b=7xUmYqaINZ08xgXM3cYazNFbOtxe4tA5jb9p/sQIP8L18PNlfORFkPSfUtMFc7a+VpGMQP
	I+5LFUUGY+0SpxCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240222092228.4ACXUrvU@linutronix.de>
References: <20240214163607.RjjT5bO_@linutronix.de>
 <87jzn5cw90.fsf@toke.dk>
 <20240216165737.oIFG5g-U@linutronix.de>
 <87ttm4b7mh.fsf@toke.dk>
 <04d72b93-a423-4574-a98e-f8915a949415@kernel.org>
 <20240220101741.PZwhANsA@linutronix.de>
 <0b1c8247-ccfb-4228-bd64-53583329aaa7@kernel.org>
 <20240220120821.1Tbz6IeI@linutronix.de>
 <07620deb-2b96-4bcc-a045-480568a27c58@kernel.org>
 <20240220153206.AUZ_zP24@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240220153206.AUZ_zP24@linutronix.de>

On 2024-02-20 16:32:08 [+0100], To Jesper Dangaard Brouer wrote:
> >=20
> >  Ethtool(i40e2) stat:     15028585 (  15,028,585) <=3D tx-0.packets /sec
> >  Ethtool(i40e2) stat:     15028589 (  15,028,589) <=3D tx_packets /sec
>=20
> -t1 in ixgbe
> Show adapter(s) (eth1) statistics (ONLY that changed!)
> Ethtool(eth1    ) stat:    107857263 (    107,857,263) <=3D tx_bytes /sec
> Ethtool(eth1    ) stat:    115047684 (    115,047,684) <=3D tx_bytes_nic =
/sec
> Ethtool(eth1    ) stat:      1797621 (      1,797,621) <=3D tx_packets /s=
ec
> Ethtool(eth1    ) stat:      1797636 (      1,797,636) <=3D tx_pkts_nic /=
sec
> Ethtool(eth1    ) stat:    107857263 (    107,857,263) <=3D tx_queue_0_by=
tes /sec
> Ethtool(eth1    ) stat:      1797621 (      1,797,621) <=3D tx_queue_0_pa=
ckets /sec
=E2=80=A6
> while sending with ixgbe while running perf top on the box:
> | Samples: 621K of event 'cycles', 4000 Hz, Event count (approx.): 499793=
76685 lost: 0/0 drop: 0/0
> | Overhead  CPU  Command          Shared Object             Symbol
> |   31.98%  000  kpktgend_0       [kernel]                  [k] xas_find
> |    6.72%  000  kpktgend_0       [kernel]                  [k] pfn_to_dm=
a_pte
> |    5.63%  000  kpktgend_0       [kernel]                  [k] ixgbe_xmi=
t_frame_ring
> |    4.78%  000  kpktgend_0       [kernel]                  [k] dma_pte_c=
lear_level
> |    3.16%  000  kpktgend_0       [kernel]                  [k] __iommu_d=
ma_unmap

I disabled the iommu and I get to

Ethtool(eth1    ) stat:     14158562 (     14,158,562) <=3D tx_packets /sec
Ethtool(eth1    ) stat:     14158685 (     14,158,685) <=3D tx_pkts_nic /sec

looks like a small improvement=E2=80=A6 It is not your 15 but close. -t2 do=
es
improve the situation. There is a warning from DMA mapping code but ;)

> > --Jesper

Sebastian

