Return-Path: <bpf+bounces-46826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA189F060F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 09:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F60283B76
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAC51A8F75;
	Fri, 13 Dec 2024 08:10:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783FA1A7270;
	Fri, 13 Dec 2024 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077452; cv=none; b=NalcIp6rwHzKuCfYI5lsPU+GEi+GC5DZkZLHas8snFjFwl+tsZ2ASsCPNwco0KM0XGGEcJcdRBthVD+iRiwiTc1oCTrkZAI/bB1Lh2VtLw8+pLroJx7/Ki4+xhbR09g3NpzpNRL8CnMv7EGvDb77OqZaaR9z+37ishlShyRsDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077452; c=relaxed/simple;
	bh=2GTcoRXXfhyN/pSs2mlfaCsRHwv13iZ7VA2Q8M1Bfnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7pfhTUz+FVUhOiC3m0mM9xkCnq9rvkvC12wkdr3WpevPI5hQ93/2Pq38Zk1r2PIDd7ZkoSbVg4LN1pbAfdQU0WgfEDCBRjQdETZpRca1400b1YSxiOUgNDTnLe0VY/vmyOSAiAT0+9h7JSlphpidRcr1Fb91oOR+smozuaXrGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af5e3.dynamic.kabel-deutschland.de [95.90.245.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D9A7861E64787;
	Fri, 13 Dec 2024 09:09:43 +0100 (CET)
Message-ID: <8d65f680-f5b9-411e-b71c-122d48240b6e@molgen.mpg.de>
Date: Fri, 13 Dec 2024 09:09:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 1/1] igc: Improve
 XDP_SETUP_PROG process
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241211134532.3489335-1-yoong.siang.song@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241211134532.3489335-1-yoong.siang.song@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Song,


Thank you for your patch. Maybe for the summary/title you could be more 
specific:

igc: Avoid unnecessary link down event in XDP_SETUP_PROG process


Am 11.12.24 um 14:45 schrieb Song Yoong Siang:
> Improve XDP_SETUP_PROG process by avoiding unnecessary link down event.
> 
> This patch is tested by using ip link set xdpdrv command to attach a simple
> XDP program which always return XDP_PASS.

return*s*

> Before this patch, attaching xdp program will cause ptp4l to lost sync for

to lose

> few seconds, as shown in ptp4l log below:
>    ptp4l[198.082]: rms    4 max    8 freq   +906 +/-   2 delay    12 +/-   0
>    ptp4l[199.082]: rms    3 max    4 freq   +906 +/-   3 delay    12 +/-   0
>    ptp4l[199.536]: port 1 (enp2s0): link down
>    ptp4l[199.536]: port 1 (enp2s0): SLAVE to FAULTY on FAULT_DETECTED (FT_UNSPECIFIED)
>    ptp4l[199.600]: selected local clock 22abbc.fffe.bb1234 as best master
>    ptp4l[199.600]: port 1 (enp2s0): assuming the grand master role
>    ptp4l[199.600]: port 1 (enp2s0): master state recommended in slave only mode
>    ptp4l[199.600]: port 1 (enp2s0): defaultDS.priority1 probably misconfigured
>    ptp4l[202.266]: port 1 (enp2s0): link up
>    ptp4l[202.300]: port 1 (enp2s0): FAULTY to LISTENING on INIT_COMPLETE
>    ptp4l[205.558]: port 1 (enp2s0): new foreign master 44abbc.fffe.bb2144-1
>    ptp4l[207.558]: selected best master clock 44abbc.fffe.bb2144
>    ptp4l[207.559]: port 1 (enp2s0): LISTENING to UNCALIBRATED on RS_SLAVE
>    ptp4l[208.308]: port 1 (enp2s0): UNCALIBRATED to SLAVE on MASTER_CLOCK_SELECTED
>    ptp4l[208.933]: rms  742 max 1303 freq   -195 +/- 682 delay    12 +/-   0
>    ptp4l[209.933]: rms  178 max  274 freq   +387 +/- 243 delay    12 +/-   0
> 
> After this patch, attaching xdp program no longer cause ptp4l to lost sync,

to lose

> as shown on ptp4l log below:
>    ptp4l[201.183]: rms    1 max    3 freq   +959 +/-   1 delay     8 +/-   0
>    ptp4l[202.183]: rms    1 max    3 freq   +961 +/-   2 delay     8 +/-   0
>    ptp4l[203.183]: rms    2 max    3 freq   +958 +/-   2 delay     8 +/-   0
>    ptp4l[204.183]: rms    3 max    5 freq   +961 +/-   3 delay     8 +/-   0
>    ptp4l[205.183]: rms    2 max    4 freq   +964 +/-   3 delay     8 +/-   0
> 
> Besides, before this patch, attaching xdp program will cause flood ping to
> loss 10 packets, as shown in ping statistics below:

to lose

>    --- 169.254.1.2 ping statistics ---
>    100000 packets transmitted, 99990 received, +6 errors, 0.01% packet loss, time 34001ms
>    rtt min/avg/max/mdev = 0.028/0.301/3104.360/13.838 ms, pipe 10, ipg/ewma 0.340/0.243 ms
> 
> After this patch, attaching xdp program no longer cause flood ping to loss

cause*s*, to lose

> any packets, as shown in ping statistics below:
>    --- 169.254.1.2 ping statistics ---
>    100000 packets transmitted, 100000 received, 0% packet loss, time 32326ms
>    rtt min/avg/max/mdev = 0.027/0.231/19.589/0.155 ms, pipe 2, ipg/ewma 0.323/0.322 ms
> 
> On the other hand, this patch is also tested with tools/testing/selftests/
> bpf/xdp_hw_metadata app to make sure XDP zero-copy is working fine with
> XDP Tx and Rx metadata. Below is the result of last packet after received
> 10000 UDP packets with interval 1 ms:
>    poll: 1 (0) skip=0 fail=0 redir=10000
>    xsk_ring_cons__peek: 1
>    0x55881c7ef7a8: rx_desc[9999]->addr=8f110 addr=8f110 comp_addr=8f110 EoP
>    rx_hash: 0xFB9BB6A3 with RSS type:0x1
>    HW RX-time:   1733923136269470866 (sec:1733923136.2695) delta to User RX-time sec:0.0000 (43.280 usec)
>    XDP RX-time:   1733923136269482482 (sec:1733923136.2695) delta to User RX-time sec:0.0000 (31.664 usec)
>    No rx_vlan_tci or rx_vlan_proto, err=-95
>    0x55881c7ef7a8: ping-pong with csum=ab19 (want 315b) csum_start=34 csum_offset=6
>    0x55881c7ef7a8: complete tx idx=9999 addr=f010
>    HW TX-complete-time:   1733923136269591637 (sec:1733923136.2696) delta to User TX-complete-time sec:0.0001 (108.571 usec)
>    XDP RX-time:   1733923136269482482 (sec:1733923136.2695) delta to User TX-complete-time sec:0.0002 (217.726 usec)
>    HW RX-time:   1733923136269470866 (sec:1733923136.2695) delta to HW TX-complete-time sec:0.0001 (120.771 usec)
>    0x55881c7ef7a8: complete rx idx=10127 addr=8f110
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
> V2 changelog:
>   - show some examples of problem in commit msg. (Vinicius)
>   - igc_close()/igc_open() are too big a hammer for installing a new XDP
>     program. Only do we we really need. (Vinicius)

The first sentence of the second item could go into the commit message 
with a note, why `igc_close()`/`igc_open()` are not needed.

> ---
>   drivers/net/ethernet/intel/igc/igc_xdp.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
> index 869815f48ac1..64b04aad614c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_xdp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
> @@ -14,6 +14,7 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
>   	bool if_running = netif_running(dev);
>   	struct bpf_prog *old_prog;
>   	bool need_update;
> +	int i;

I’d use unsigned int as it’s used to access array elements.

>   
>   	if (dev->mtu > ETH_DATA_LEN) {
>   		/* For now, the driver doesn't support XDP functionality with
> @@ -24,8 +25,13 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
>   	}
>   
>   	need_update = !!adapter->xdp_prog != !!prog;
> -	if (if_running && need_update)
> -		igc_close(dev);
> +	if (if_running && need_update) {
> +		for (i = 0; i < adapter->num_rx_queues; i++) {
> +			igc_disable_rx_ring(adapter->rx_ring[i]);
> +			igc_disable_tx_ring(adapter->tx_ring[i]);
> +			napi_disable(&adapter->rx_ring[i]->q_vector->napi);
> +		}
> +	}
>   
>   	old_prog = xchg(&adapter->xdp_prog, prog);
>   	if (old_prog)
> @@ -36,8 +42,13 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
>   	else
>   		xdp_features_clear_redirect_target(dev);
>   
> -	if (if_running && need_update)
> -		igc_open(dev);
> +	if (if_running && need_update) {
> +		for (i = 0; i < adapter->num_rx_queues; i++) {
> +			napi_enable(&adapter->rx_ring[i]->q_vector->napi);
> +			igc_enable_tx_ring(adapter->tx_ring[i]);
> +			igc_enable_rx_ring(adapter->rx_ring[i]);
> +		}
> +	}
>   
>   	return 0;
>   }


Kind regards,

Paul

