Return-Path: <bpf+bounces-22324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E8B85BFFC
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 16:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1499284E51
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEAC76047;
	Tue, 20 Feb 2024 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dTrbqXLc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1kfZv9oQ"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B047602A;
	Tue, 20 Feb 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443132; cv=none; b=uztYGi8L+YlEEwCa27seH3ttGfpKe/iZmwf4cJbAMb3ysWjsFCoLtCeZHWuJJL2LwhjisYIHf9JMnqeGuigPRI6mxl00FopVl/0iEFgsNs99e2FPg/rFTzOASZVufbtzPut7smzXOQAiXPxxfsQk6Bg+WO71RRTzJtpoQ9Iu9Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443132; c=relaxed/simple;
	bh=6ech/PEhJDQEwCIpjvyq59hk10aKaaCGBDEhyusDcPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5T2oB74QaqkQq5//YMOle1H28gQZtTa/v5Cjkrx91c3y9/GARBflQCgoNzDaNSnw0OHc7+2jY8684BxZY1TIMY4a+awMhvjJZ1qtbrQCnheTWDloRm9UEmNHY1jQyCUsZCouBdptZA9kxFF3WPR4tHpwlZeJDl0L3Hm+05Ssnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dTrbqXLc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1kfZv9oQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 16:32:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708443128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVP2rsPhM53x+ceiqRGWvvmw5DZQWdOcX0FyAtmF2+E=;
	b=dTrbqXLcBY8Ii+cuYpGP5bLrT4EU/02KkVhrL5GloVuhUQXZBasT6XqfN8GN64K7LfQI6C
	cxncbL9Q+Mn7tqL7kDjE3s6IUd/tGxFBO6okK/3PdNBkMkieVZyWtwmSdOdMhgkrmVXYqv
	k2FOP8wTkOf6M630DZNmq1HhJaPVgzYsv9qc8w41tSxnWfgJaHfRGONOKfTxbWGfb/D/xK
	7lQ0/ZhpfFbPJgthAhZOo+Lq9I4owipkHXXe4o+Bn2dpD/ItAHbFSZMKCi5GW46pl755rM
	I8VhYYc2iI+IK9C1W9UNcmbXIZ8r8unKpLxW5f+7DJAGBU+V8SOHo7YvF11KJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708443128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVP2rsPhM53x+ceiqRGWvvmw5DZQWdOcX0FyAtmF2+E=;
	b=1kfZv9oQvpjjyl4zOATuO0S9i1Y/OXrWTMeTmenKldNGvVEv1qTD4X94POOop44XBUiMVy
	y9BlfIsLhi9vuwDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240220153206.AUZ_zP24@linutronix.de>
References: <87le7ndo4z.fsf@toke.dk>
 <20240214163607.RjjT5bO_@linutronix.de>
 <87jzn5cw90.fsf@toke.dk>
 <20240216165737.oIFG5g-U@linutronix.de>
 <87ttm4b7mh.fsf@toke.dk>
 <04d72b93-a423-4574-a98e-f8915a949415@kernel.org>
 <20240220101741.PZwhANsA@linutronix.de>
 <0b1c8247-ccfb-4228-bd64-53583329aaa7@kernel.org>
 <20240220120821.1Tbz6IeI@linutronix.de>
 <07620deb-2b96-4bcc-a045-480568a27c58@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <07620deb-2b96-4bcc-a045-480568a27c58@kernel.org>

On 2024-02-20 13:57:24 [+0100], Jesper Dangaard Brouer wrote:
> > so I replaced nr_cpu_ids with 64 and bootet maxcpus=3D64 so that I can =
run
> > xdp-bench on the ixgbe.
> >=20
>=20
> Yes, ixgbe HW have limited TX queues, and XDP tries to allocate a
> hardware TX queue for every CPU in the system.  So, I guess you have too
> many CPUs in your system - lol.
>=20
> Other drivers have a fallback to a locked XDP TX path, so this is also
> something to lookout for in the machine with i40e.

this locked XDP TX path starts at 64 but xdp_progs are rejected > 64 * 2.

> > so. i40 send, ixgbe receive.
> >=20
> > -t 2
> >=20
> > | Summary                 2,348,800 rx/s                  0 err/s
> > |   receive total         2,348,800 pkt/s         2,348,800 drop/s     =
           0 error/s
> > |     cpu:0               2,348,800 pkt/s         2,348,800 drop/s     =
           0 error/s
> > |   xdp_exception                 0 hit/s
> >=20
>=20
> This is way too low, with i40e sending.
>=20
> On my system with only -t 1 my i40e driver can send with approx 15Mpps:
>=20
>  Ethtool(i40e2) stat:     15028585 (  15,028,585) <=3D tx-0.packets /sec
>  Ethtool(i40e2) stat:     15028589 (  15,028,589) <=3D tx_packets /sec

-t1 in ixgbe
Show adapter(s) (eth1) statistics (ONLY that changed!)
Ethtool(eth1    ) stat:    107857263 (    107,857,263) <=3D tx_bytes /sec
Ethtool(eth1    ) stat:    115047684 (    115,047,684) <=3D tx_bytes_nic /s=
ec
Ethtool(eth1    ) stat:      1797621 (      1,797,621) <=3D tx_packets /sec
Ethtool(eth1    ) stat:      1797636 (      1,797,636) <=3D tx_pkts_nic /sec
Ethtool(eth1    ) stat:    107857263 (    107,857,263) <=3D tx_queue_0_byte=
s /sec
Ethtool(eth1    ) stat:      1797621 (      1,797,621) <=3D tx_queue_0_pack=
ets /sec

-t i40e
Ethtool(eno2np1 ) stat:           90 (             90) <=3D port.rx_bytes /=
sec
Ethtool(eno2np1 ) stat:            1 (              1) <=3D port.rx_size_12=
7 /sec
Ethtool(eno2np1 ) stat:            1 (              1) <=3D port.rx_unicast=
 /sec
Ethtool(eno2np1 ) stat:     79554379 (     79,554,379) <=3D port.tx_bytes /=
sec
Ethtool(eno2np1 ) stat:      1243037 (      1,243,037) <=3D port.tx_size_64=
 /sec
Ethtool(eno2np1 ) stat:      1243037 (      1,243,037) <=3D port.tx_unicast=
 /sec
Ethtool(eno2np1 ) stat:           86 (             86) <=3D rx-32.bytes /sec
Ethtool(eno2np1 ) stat:            1 (              1) <=3D rx-32.packets /=
sec
Ethtool(eno2np1 ) stat:           86 (             86) <=3D rx_bytes /sec
Ethtool(eno2np1 ) stat:            1 (              1) <=3D rx_cache_waive =
/sec
Ethtool(eno2np1 ) stat:            1 (              1) <=3D rx_packets /sec
Ethtool(eno2np1 ) stat:            1 (              1) <=3D rx_unicast /sec
Ethtool(eno2np1 ) stat:     74580821 (     74,580,821) <=3D tx-0.bytes /sec
Ethtool(eno2np1 ) stat:      1243014 (      1,243,014) <=3D tx-0.packets /s=
ec
Ethtool(eno2np1 ) stat:     74580821 (     74,580,821) <=3D tx_bytes /sec
Ethtool(eno2np1 ) stat:      1243014 (      1,243,014) <=3D tx_packets /sec
Ethtool(eno2np1 ) stat:      1243037 (      1,243,037) <=3D tx_unicast /sec

mine is slightly slower. But this seems to match what I see on the RX
side.

> At this level, if you can verify that CPU:60 is 100% loaded, and packet
> generator is sending more than rx number, then it could work as a valid
> experiment.

i40e receiving on 8:
%Cpu8  :  0.0 us,  0.0 sy,  0.0 ni, 84.8 id,  0.0 wa,  0.0 hi, 15.2 si,  0.=
0 st=20

ixgbe receiving on 13:
%Cpu13 :  0.0 us,  0.0 sy,  0.0 ni, 56.7 id,  0.0 wa,  0.0 hi, 43.3 si,  0.=
0 st=20

looks idle. On the sending side kpktgend_0 is always at 100%.

> > -t 18
> > | Summary                 7,784,946 rx/s                  0 err/s
> > |   receive total         7,784,946 pkt/s         7,784,946 drop/s     =
           0 error/s
> > |     cpu:60              7,784,946 pkt/s         7,784,946 drop/s     =
           0 error/s
> > |   xdp_exception                 0 hit/s
> >=20
> > after t18 it drop down to 2,=E2=80=A6
> > Now I got worse than before since -t8 says 7,5=E2=80=A6 and it did 8,4 =
in the
> > morning. Do you have maybe a .config for me in case I did not enable the
> > performance switch?
> >=20
>=20
> I would look for root-cause with perf record +
>  perf report --sort cpu,comm,dso,symbol --no-children

while sending with ixgbe while running perf top on the box:
| Samples: 621K of event 'cycles', 4000 Hz, Event count (approx.): 49979376=
685 lost: 0/0 drop: 0/0
| Overhead  CPU  Command          Shared Object             Symbol
|   31.98%  000  kpktgend_0       [kernel]                  [k] xas_find
|    6.72%  000  kpktgend_0       [kernel]                  [k] pfn_to_dma_=
pte
|    5.63%  000  kpktgend_0       [kernel]                  [k] ixgbe_xmit_=
frame_ring
|    4.78%  000  kpktgend_0       [kernel]                  [k] dma_pte_cle=
ar_level
|    3.16%  000  kpktgend_0       [kernel]                  [k] __iommu_dma=
_unmap
|    2.30%  000  kpktgend_0       [kernel]                  [k] fq_ring_fre=
e_locked
|    1.99%  000  kpktgend_0       [kernel]                  [k] __domain_ma=
pping
|    1.82%  000  kpktgend_0       [kernel]                  [k] iommu_dma_a=
lloc_iova
|    1.80%  000  kpktgend_0       [kernel]                  [k] __iommu_map
|    1.72%  000  kpktgend_0       [kernel]                  [k] iommu_pgsiz=
e.isra.0
|    1.70%  000  kpktgend_0       [kernel]                  [k] __iommu_dma=
_map
|    1.63%  000  kpktgend_0       [kernel]                  [k] alloc_iova_=
fast
|    1.59%  000  kpktgend_0       [kernel]                  [k] _raw_spin_l=
ock_irqsave
|    1.32%  000  kpktgend_0       [kernel]                  [k] iommu_map
|    1.30%  000  kpktgend_0       [kernel]                  [k] iommu_dma_m=
ap_page
|    1.23%  000  kpktgend_0       [kernel]                  [k] intel_iommu=
_iotlb_sync_map
|    1.21%  000  kpktgend_0       [kernel]                  [k] xa_find_aft=
er
|    1.17%  000  kpktgend_0       [kernel]                  [k] ixgbe_poll
|    1.06%  000  kpktgend_0       [kernel]                  [k] __iommu_unm=
ap
|    1.04%  000  kpktgend_0       [kernel]                  [k] intel_iommu=
_unmap_pages
|    1.01%  000  kpktgend_0       [kernel]                  [k] free_iova_f=
ast
|    0.96%  000  kpktgend_0       [pktgen]                  [k] pktgen_thre=
ad_worker

the i40e box while sending:
|Samples: 400K of event 'cycles:P', 4000 Hz, Event count (approx.): 8051244=
3924 lost: 0/0 drop: 0/0
|Overhead  CPU  Command          Shared Object         Symbol
|  24.04%  000  kpktgend_0       [kernel]              [k] i40e_lan_xmit_fr=
ame
|  17.20%  019  swapper          [kernel]              [k] i40e_napi_poll
|   4.84%  019  swapper          [kernel]              [k] intel_idle_irq
|   4.20%  019  swapper          [kernel]              [k] napi_consume_skb
|   3.00%  000  kpktgend_0       [pktgen]              [k] pktgen_thread_wo=
rker
|   2.76%  008  swapper          [kernel]              [k] i40e_napi_poll
|   2.36%  000  kpktgend_0       [kernel]              [k] dma_map_page_att=
rs
|   1.93%  019  swapper          [kernel]              [k] dma_unmap_page_a=
ttrs
|   1.70%  008  swapper          [kernel]              [k] intel_idle_irq
|   1.44%  008  swapper          [kernel]              [k] __udp4_lib_rcv
|   1.44%  008  swapper          [kernel]              [k] __netif_receive_=
skb_core.constprop.0
|   1.40%  008  swapper          [kernel]              [k] napi_build_skb
|   1.28%  000  kpktgend_0       [kernel]              [k] kfree_skb_reason
|   1.27%  008  swapper          [kernel]              [k] ip_rcv_core
|   1.19%  008  swapper          [kernel]              [k] inet_gro_receive
|   1.01%  008  swapper          [kernel]              [k] kmem_cache_free.=
part.0

> --Jesper

Sebastian

