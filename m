Return-Path: <bpf+bounces-32521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CC490F1F4
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 17:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB3CB2130F
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 15:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3477E132112;
	Wed, 19 Jun 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwvhCsGS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA281802E;
	Wed, 19 Jun 2024 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810293; cv=none; b=ORVe6UrQnaDj942acS+9bzpL+5xoVJxuS09vFbDbPDys38qk3qxAQ6UCQ7DzIBj9xTiY2ItY2VdCVqOS3Hm6Lk/NAjj2pcK6GC0sQg5fg0bfUK1fgMt74x7zWTmcFViXcs7lQIq+hE1j+RvqUhxD4zyH13DXVO4enhlugr+YHrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810293; c=relaxed/simple;
	bh=ziZEiTYH5fjnTqIO0ARjdhsR1+c2X97yLQiZHXuuI1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxGquHe1s0R2LzWVW+NMLFIuegq7aI8HeTNKAY9zCf4AYs10SF9ChblEw21UbTB25ycwL67SAhSYEDbkzHbWtWYFBSKpa2ZqUqEJHGLH9TAitlTuXBD3zAvfP5RBISg/wd7/0lMOTYy/O5LEQiaiOdRjx3cN+2Ubq19PKk11jIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwvhCsGS; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d4430b8591so1426724b6e.2;
        Wed, 19 Jun 2024 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718810291; x=1719415091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u3/1LXDpc/LdidGTPgzfA/Qma+KyfoUBFNASBktgopo=;
        b=BwvhCsGSJxXpsJ6HglQJ7ahYZ9n/91xFWuxu4kuhvkeios9+ieN/bQ8KjUgs2Ad2U9
         D2QJbwkQENX2ZnPZHC1h5vN5xz7edPP4mhgwZXDCN+HZQb8e1QEoqC2N+FqdhUfYuLmr
         j+0H1kmHzKqkdVtOAHg/Wd7JeS5kn0kPZVcNtBcZOG+Y17ruP2ccQYLAkm2k6qzJl8D7
         K3ptJkPo5/qOZsIfNlb2ixSF1B+9Xoo4MF/Z4WYirO1PQigFJYjuqgtBEUMWVZxQkLu/
         TFgJxFQnLJGDmpVp2cSKPsHpP2z6ZbAA5LWIkDHQWWvyIMMmdMF44eKuvYYAhnG4ETVP
         Plvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718810291; x=1719415091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3/1LXDpc/LdidGTPgzfA/Qma+KyfoUBFNASBktgopo=;
        b=cIuK8goOPt48ogugCtPn7tAcZqCa7W0EEu47EEOIDj2deMdgx1X2JYZg1Esqib0hjr
         29tM1SLi9OCMsmZxbnyz6Nt4OIdMfFHkbrFGveiAcNO9Ea1QeFBPosr7ALfO7qhASH9f
         IvuFdOoL3+mfWtjJENInIlItxmlZ6c1XjMEmk2wlLsYLdnoE/ve7N6wn/R7kdjzJlX+9
         +dfjCokCAzl6Sq4QW/KtQFeY6UiU035wMXgRJxEj/3fJ/3P/Yh0h85iEyKBHPMLcCHuO
         DDBrgtBaA0/5ZGFHsHY7olLifNU3k9zx5ZIvX2MJbQewwMsWOeavkd93Ev6hYwIu3JWu
         QHHA==
X-Forwarded-Encrypted: i=1; AJvYcCXaxJk2khKHrlbyzep1kxmaya8DFXE8RfA3drFY+IFjnes4PPqvxYSFKCrc5+//63nZzv/f726XiXXrQ/gHeQXBGLv3o3qx
X-Gm-Message-State: AOJu0Yy5CRcJfQhgFntnKOkP1Q1j+aa4PNcZMZL2HZvzoIOFyAFtMeN7
	SObhJ8gz+iXBpCze+WW4LbmEe7bX+E94sfTi7B5KzSm/nHb/nxgDR8vooORzUmfnLGEVlNTcIDq
	r+VoSESnOas9wRVwCEYVg5jQ2CZE=
X-Google-Smtp-Source: AGHT+IEEUP7r4b8WYg+gkeNfxgFktVDUJfImj2VRSga7pv6tT+spIg+ShNAC3+ndd3A1b26PSN2h7AZMV1htzS52RRo=
X-Received: by 2002:a05:6808:120b:b0:3d2:2003:983a with SMTP id
 5614622812f47-3d51bb12761mr2956326b6e.59.1718810290990; Wed, 19 Jun 2024
 08:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <36075ea9-95dd-4dd6-b2b6-440916079578@nvidia.com>
In-Reply-To: <36075ea9-95dd-4dd6-b2b6-440916079578@nvidia.com>
From: Sebastiano Miano <mianosebastiano@gmail.com>
Date: Wed, 19 Jun 2024 17:17:59 +0200
Message-ID: <CAMENy5rwoP0o9Gn67a-27ZXtzM7dGhJOwA4i5znihiNThR27SQ@mail.gmail.com>
Subject: Re: XDP Performance Regression in recent kernel versions
To: Tariq Toukan <tariqt@nvidia.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com, 
	hawk@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Gal Pressman <gal@nvidia.com>, amira@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 08:00, Tariq Toukan <tariqt@nvidia.com> wrote:
>
> Thanks for your report.
>
> I assume cpu util for the active core on the DUT is 100% in all cases,
> right?

Yes, that's correct.
The irq is also on the core on the right numa node, and I have
disabled CPU frequency scaling.

>
> Can you please share some more details? Like relevant ethtool counters,
> and perf top output.
>
> We'll check if this repro for us as well.

Sure, below you can find the reports for the XDP_DROP and XDP_TX cases.
I am attaching only the ones for kern v5.15 vs v6.5.

--------------------------------------------------
ethtool output (5.15) - Missing counters are zero
--------------------------------------------------
NIC statistics:
     rx_packets: 333854100
     rx_bytes: 20031246044
     tx_packets: 25
     tx_bytes: 2070
     rx_csum_unnecessary: 333854079
     rx_xdp_drop: 3753342954
     rx_xdp_redirect: 0
     rx_xdp_tx_xmit: 5582660674
     rx_xdp_tx_mpwqe: 175018775
     rx_xdp_tx_inlnw: 8970048
     rx_xdp_tx_nops: 378338337
     rx_xdp_tx_full: 0
     rx_xdp_tx_err: 0
     rx_xdp_tx_cqe: 87229072
     rx_cache_reuse: 9369255040
     rx_cache_full: 68
     rx_cache_empty: 16153471
     rx_cache_busy: 193
     rx_cache_waive: 15864256
     rx_congst_umr: 158
     ch_events: 448
     ch_poll: 151091830
     ch_arm: 301
     rx_out_of_buffer: 990473555
     rx_if_down_packets: 67469721
     rx_steer_missed_packets: 1962570491
     rx_vport_unicast_packets: 38460159194
     rx_vport_unicast_bytes: 2461450188460
     tx_vport_unicast_packets: 5582654212
     tx_vport_unicast_bytes: 334959252764
     tx_packets_phy: 5588396729
     rx_packets_phy: 97052087562
     tx_bytes_phy: 357657403514
     rx_bytes_phy: 6211329423080
     tx_mac_control_phy: 5745055
     tx_pause_ctrl_phy: 5745055
     rx_discards_phy: 58591428329
     tx_discards_phy: 0
     tx_errors_phy: 0
     rx_undersize_pkts_phy: 0
     rx_fragments_phy: 0
     rx_jabbers_phy: 0
     rx_64_bytes_phy: 97052040472
     rx_65_to_127_bytes_phy: 3
     rx_128_to_255_bytes_phy: 0
     rx_256_to_511_bytes_phy: 26
     rx_512_to_1023_bytes_phy: 0
     rx_1024_to_1518_bytes_phy: 0
     rx_1519_to_2047_bytes_phy: 0
     rx_2048_to_4095_bytes_phy: 0
     rx_4096_to_8191_bytes_phy: 0
     rx_8192_to_10239_bytes_phy: 0
     rx_prio0_bytes: 6211318150440
     rx_prio0_packets: 38460533605
     rx_prio0_discards: 58591314012
     tx_prio0_bytes: 357288052986
     tx_prio0_packets: 5582625883
     tx_global_pause: 5745042
     tx_global_pause_duration: 771103810
     ch0_events: 55
     ch0_poll: 146981606
     ch0_arm: 35
     ch0_aff_change: 6
     ch0_force_irq: 0
     ch0_eq_rearm: 0
     rx0_packets: 70812690
     rx0_bytes: 4248761400
     rx0_csum_complete: 0
     rx0_csum_complete_tail: 0
     rx0_csum_complete_tail_slow: 0
     rx0_csum_unnecessary: 70812671
     rx0_csum_unnecessary_inner: 0
     rx0_csum_none: 19
     rx0_xdp_drop: 3753342954
     rx0_xdp_redirect: 0
     rx0_lro_packets: 0
     rx0_lro_bytes: 0
     rx0_ecn_mark: 0
     rx0_removed_vlan_packets: 0
     rx0_wqe_err: 0
     rx0_mpwqe_filler_cqes: 0
     rx0_mpwqe_filler_strides: 0
     rx0_oversize_pkts_sw_drop: 0
     rx0_buff_alloc_err: 0
     rx0_cqe_compress_blks: 0
     rx0_cqe_compress_pkts: 0
     rx0_cache_reuse: 9368316609
     rx0_cache_full: 2
     rx0_cache_empty: 11519
     rx0_cache_busy: 0
     rx0_cache_waive: 0
     rx0_congst_umr: 158
     rx0_arfs_err: 0
     rx0_recover: 0
     rx0_xdp_tx_xmit: 5582664928
     rx0_xdp_tx_mpwqe: 175018908
     rx0_xdp_tx_inlnw: 8970048
     rx0_xdp_tx_nops: 378338623
     rx0_xdp_tx_full: 0
     rx0_xdp_tx_err: 0
     rx0_xdp_tx_cqes: 87229139

--------------------------------------------------
perf top output (5.15) - XDP_DROP
--------------------------------------------------
19.27%  [kernel]                  [k] mlx5e_skb_from_cqe_mpwrq_linear
11.74%  [kernel]                  [k] mlx5e_handle_rx_cqe_mpwrq
9.82%   [kernel]                  [k] mlx5e_xdp_handle
9.43%   [kernel]                  [k] mlx5e_alloc_rx_mpwqe
9.29%   bpf_prog_xdp_basic_prog   [k] bpf_prog_5f76c01f0ff23233_xdp_basic_prog
7.06%   [kernel]                  [k] mlx5e_page_release_dynamic
6.95%   [kernel]                  [k] mlx5e_poll_rx_cq
5.89%   [kernel]                  [k] dma_sync_single_for_cpu
5.21%   [kernel]                  [k] dma_sync_single_for_device
4.12%   [kernel]                  [k] mlx5e_free_rx_mpwqe
1.65%   [kernel]                  [k] mlx5e_poll_ico_cq
1.60%   [kernel]                  [k] mlx5e_napi_poll
1.59%   [kernel]                  [k] bpf_get_smp_processor_id
0.94%   [kernel]                  [k] bpf_dispatcher_xdp_func
0.91%   [kernel]                  [k] net_rx_action
0.90%   bpf_prog_xdp_dispatcher   [k] bpf_prog_17d608957d1f805a_xdp_dispatcher
0.90%   [kernel]                  [k] bpf_dispatcher_xdp
0.64%   [kernel]                  [k] mlx5e_post_rx_mpwqes
0.64%   [kernel]                  [k] mlx5e_poll_xdpsq_cq
0.37%   [kernel]                  [k] __softirqentry_text_start

--------------------------------------------------
perf top output (5.15) - XDP_TX
--------------------------------------------------
13.84%  bpf_prog_xdp_swap_macs_prog  [k]
bpf_prog_0a3ad412f28cbb6d_xdp_swap_macs_prog
11.43%  [kernel]                     [k] mlx5e_xmit_xdp_buff
10.69%  [kernel]                     [k] mlx5e_skb_from_cqe_mpwrq_linear
9.79%  [kernel]                      [k] mlx5e_xmit_xdp_frame_mpwqe
8.35%  [kernel]                      [k] mlx5e_handle_rx_cqe_mpwrq
6.34%  [kernel]                      [k] dma_sync_single_for_device
6.20%  [kernel]                      [k] mlx5e_poll_rx_cq
5.62%  [kernel]                      [k] mlx5e_page_release_dynamic
5.33%  [kernel]                      [k] mlx5e_xdp_handle
5.21%  [kernel]                      [k] mlx5e_alloc_rx_mpwqe
4.47%  [kernel]                      [k] mlx5e_free_xdpsq_desc
3.26%  [kernel]                      [k] dma_sync_single_for_cpu
1.47%  [kernel]                      [k] mlx5e_xmit_xdp_frame_check_mpwqe
1.22%  [kernel]                      [k] mlx5e_poll_xdpsq_cq
0.95%  [kernel]                      [k] net_rx_action
0.90%  [kernel]                      [k] bpf_get_smp_processor_id
0.80%  [kernel]                      [k] mlx5e_napi_poll
0.69%  [kernel]                      [k] mlx5e_xdp_mpwqe_session_start
0.63%  [kernel]                      [k] mlx5e_poll_ico_cq
0.49%  [kernel]                      [k] bpf_dispatcher_xdp
0.47%  [kernel]                      [k] bpf_dispatcher_xdp_func

---------------------------------------------------------------------------------------

--------------------------------------------------
ethtool output (6.5) - Missing counters are zero
--------------------------------------------------
NIC statistics:
     rx_packets: 7282880
     rx_bytes: 436973482
     tx_packets: 42
     tx_bytes: 3556
     rx_csum_unnecessary: 7282816
     rx_xdp_drop: 7783331724
     rx_xdp_redirect: 0
     rx_xdp_tx_xmit: 46956452544
     rx_xdp_tx_mpwqe: 4401807536
     rx_xdp_tx_inlnw: 46951234092
     rx_xdp_tx_nops: 4988835176
     rx_xdp_tx_full: 0
     rx_xdp_tx_err: 0
     rx_xdp_tx_cqe: 733694572
     rx_pp_alloc_fast: 3641784
     rx_pp_alloc_slow: 8
     rx_pp_alloc_slow_high_order: 0
     rx_pp_alloc_empty: 8
     rx_pp_alloc_refill: 0
     rx_pp_alloc_waive: 0
     rx_pp_recycle_cached: 3641280
     ch_events: 505
     ch_poll: 855423286
     rx_out_of_buffer: 534918379
     rx_if_down_packets: 4044804
     rx_steer_missed_packets: 298
     rx_vport_unicast_packets: 287214261626
     rx_vport_unicast_bytes: 18381712744116
     tx_vport_unicast_packets: 46956452544
     tx_vport_unicast_bytes: 2817387157674
     tx_packets_phy: 47000866603
     rx_packets_phy: 728277471186
     tx_bytes_phy: 3008055468662
     rx_bytes_phy: 46609758231313
     tx_mac_control_phy: 44414017
     tx_pause_ctrl_phy: 44414017
     rx_discards_phy: 441063206498
     rx_64_bytes_phy: 728277470842
     rx_65_to_127_bytes_phy: 133
     rx_128_to_255_bytes_phy: 0
     rx_256_to_511_bytes_phy: 211
     rx_512_to_1023_bytes_phy: 0
     rx_1024_to_1518_bytes_phy: 0
     rx_1519_to_2047_bytes_phy: 0
     rx_2048_to_4095_bytes_phy: 0
     rx_4096_to_8191_bytes_phy: 0
     rx_8192_to_10239_bytes_phy: 0
     rx_buffer_passed_thres_phy: 1192226
     rx_prio0_bytes: 46609758231313
     rx_prio0_packets: 287214264688
     rx_prio0_discards: 441063206498
     tx_prio0_bytes: 3005212971574
     tx_prio0_packets: 46956452586
     tx_global_pause: 44414017
     tx_global_pause_duration: 5961284324
     ch0_events: 120
     ch0_poll: 855423025
     ch0_arm: 100
     ch0_aff_change: 0
     ch0_force_irq: 0
     ch0_eq_rearm: 0
     rx0_packets: 7282880
     rx0_bytes: 436973482
     rx0_csum_complete: 0
     rx0_csum_complete_tail: 0
     rx0_csum_complete_tail_slow: 0
     rx0_csum_unnecessary: 7282816
     rx0_csum_unnecessary_inner: 0
     rx0_csum_none: 64
     rx0_xdp_drop: 7783331724
     rx0_xdp_redirect: 0
     rx0_lro_packets: 0
     rx0_lro_bytes: 0
     rx0_gro_packets: 0
     rx0_gro_bytes: 0
     rx0_gro_skbs: 0
     rx0_gro_match_packets: 0
     rx0_gro_large_hds: 0
     rx0_ecn_mark: 0
     rx0_removed_vlan_packets: 0
     rx0_wqe_err: 0
     rx0_mpwqe_filler_cqes: 0
     rx0_mpwqe_filler_strides: 0
     rx0_oversize_pkts_sw_drop: 0
     rx0_buff_alloc_err: 0
     rx0_cqe_compress_blks: 0
     rx0_cqe_compress_pkts: 0
     rx0_congst_umr: 0
     rx0_arfs_err: 0
     rx0_recover: 0
     rx0_pp_alloc_fast: 3641784
     rx0_pp_alloc_slow: 8
     rx0_pp_alloc_slow_high_order: 0
     rx0_pp_alloc_empty: 8
     rx0_pp_alloc_refill: 0
     rx0_pp_alloc_waive: 0
     rx0_pp_recycle_cached: 3641280
     rx0_pp_recycle_cache_full: 0
     rx0_pp_recycle_ring: 0
     rx0_pp_recycle_ring_full: 0
     rx0_pp_recycle_released_ref: 0
     rx0_xdp_tx_xmit: 46956452544
     rx0_xdp_tx_mpwqe: 4401807536
     rx0_xdp_tx_inlnw: 46951234092
     rx0_xdp_tx_nops: 4988835176
     rx0_xdp_tx_full: 0
     rx0_xdp_tx_err: 0
     rx0_xdp_tx_cqes: 733694572

--------------------------------------------------
perf top output (6.5) - XDP_DROP
--------------------------------------------------
27.63%  [kernel]                [k] mlx5e_skb_from_cqe_mpwrq_linear
12.61%  [kernel]                [k] mlx5e_handle_rx_cqe_mpwrq
8.38%  [kernel]                 [k] mlx5e_rx_cq_process_basic_cqe_comp
7.06%  [kernel]                 [k] page_pool_put_defragged_page
6.45%  [kernel]                 [k] mlx5e_xdp_handle
5.36%  bpf_prog_xdp_basic_prog  [k] bpf_prog_5f76c01f0ff23233_xdp_basic_prog
4.95%  [kernel]                 [k] dma_sync_single_for_device
4.89%  [kernel]                 [k] page_pool_alloc_pages
4.36%  [kernel]                 [k] mlx5e_alloc_rx_mpwqe
3.70%  [kernel]                 [k] dma_sync_single_for_cpu
2.71%  [kernel]                 [k] mlx5e_page_release_fragmented.isra.0
2.09%  [kernel]                 [k] bpf_dispatcher_xdp_func
1.95%  [kernel]                 [k] mlx5e_free_rx_mpwqe
1.10%  [kernel]                 [k] mlx5e_poll_ico_cq
1.07%  [kernel]                 [k] bpf_get_smp_processor_id
1.05%  [kernel]                 [k] mlx5e_napi_poll
0.85%  [kernel]                 [k] mlx5e_poll_xdpsq_cq
0.61%  [kernel]                 [k] net_rx_action
0.58%  bpf_prog_xdp_dispatcher  [k] bpf_prog_17d608957d1f805a_xdp_dispatcher
0.57%  [kernel]                 [k] bpf_dispatcher_xdp
0.53%  [kernel]                 [k] mlx5e_post_rx_mpwqes
0.27%  [kernel]                 [k] __do_softirq
0.25%  [kernel]                 [k] mlx5e_poll_tx_cq

--------------------------------------------------
perf top output (6.5) - XDP_TX
--------------------------------------------------
19.60%  [kernel]                    [k] mlx5e_xdp_mpwqe_add_dseg
14.61%  [kernel]                    [k] mlx5e_skb_from_cqe_mpwrq_linear
11.55%  [kernel]                    [k] mlx5e_xmit_xdp_buff
5.85%  [kernel]                     [k] mlx5e_handle_rx_cqe_mpwrq
5.73%  bpf_prog_xdp_swap_macs_prog  [k] bpf_prog_0a3a_xdp_swap_macs_prog
5.09%  [kernel]                     [k] mlx5e_free_xdpsq_desc
5.08%  [kernel]                     [k] dma_sync_single_for_device
4.66%  [kernel]                     [k] mlx5e_xmit_xdp_frame_mpwqe
3.64%  [kernel]                     [k] mlx5e_rx_cq_process_basic_cqe_comp
3.34%  [kernel]                     [k] page_pool_put_defragged_page
3.04%  [kernel]                     [k] mlx5e_xdp_handle
3.03%  [kernel]                     [k] mlx5e_page_release_fragmented.isra.0
2.56%  [kernel]                     [k] dma_sync_single_for_cpu
2.15%  [kernel]                     [k] mlx5e_alloc_rx_mpwqe
1.96%  [kernel]                     [k] page_pool_alloc_pages
1.06%  [kernel]                     [k] mlx5e_xmit_xdp_frame_check_mpwqe
1.02%  [kernel]                     [k] bpf_dispatcher_xdp_func
1.01%  [kernel]                     [k] mlx5e_free_rx_mpwqe
0.84%  [kernel]                     [k] mlx5e_poll_xdpsq_cq
0.62%  [kernel]                     [k] mlx5e_xdpsq_get_next_pi
0.53%  [kernel]                     [k] mlx5e_poll_ico_cq
0.48%  [kernel]                     [k] bpf_get_smp_processor_id
0.48%  [kernel]                     [k] net_rx_action
0.36%  [kernel]                     [k] mlx5e_napi_poll
0.32%  [kernel]                     [k] mlx5e_xdp_mpwqe_complete
0.25%  [kernel]                     [k] bpf_dispatcher_xdp
0.22%  bpf_prog_xdp_dispatcher      [k] bpf_prog_17d6_xdp_dispatcher
0.21%  [kernel]                     [k] mlx5e_post_rx_mpwqes
0.11%  [kernel]                     [k] __do_softirq

