Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8221C450A68
	for <lists+bpf@lfdr.de>; Mon, 15 Nov 2021 18:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhKORE0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 12:04:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232148AbhKORDv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Nov 2021 12:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636995654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cW5g5aKagFne/G1zoQiQ/IlBuxC8PWxj81b/2xSsnGA=;
        b=da2wxkWcnf39Gzh3i9QyEDofBiLKYWLLTCRyR2ibV+oiXmexOurWL1dU6vtlpK17NTu8/a
        rTBnWgrQ9UUkxJxkIgP0az6PQoTItYOPjrlzC46Y8J30SVSXTThdhj5z4ikGo/bodlyO1j
        SMCFIDvStdRR9SCi3z7mEqSPUuHksEI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-PSPWb0qUNDqWsfQLZr3Qtw-1; Mon, 15 Nov 2021 12:00:53 -0500
X-MC-Unique: PSPWb0qUNDqWsfQLZr3Qtw-1
Received: by mail-ed1-f69.google.com with SMTP id m17-20020aa7d351000000b003e7c0bc8523so2897512edr.1
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 09:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cW5g5aKagFne/G1zoQiQ/IlBuxC8PWxj81b/2xSsnGA=;
        b=NO7z7EN1zutNL2mRYoaoY1ajk845vDmFIVpkCjeeOvlul5gvbhQ+53k+ZRdEdNNiJt
         HUxsKMf1NYOK7ThcWlGNy1nANt6tx4TAwly0rpsWwYazomXzHHA2y8njtvtcn0XS5bZl
         hqD8Rngkf8s1qyRknoBCGF5CgyH5kIZd2Ie0l7/qU2IJIt6Xoxza8KFWte4bzAtmv5zL
         TJrbT3T3LpLMfqQHMRRZaRCgLTzUlFvCqx3C1j3cIOGaDNID01/CvM+lElO77EvajHSQ
         e1W+NojyllaMfoFm6BW6g11nrwLl39bskgS6qeK8ytXBYWBJnsGDVb8gaeU9DlUdWZuw
         tK0A==
X-Gm-Message-State: AOAM532I3UXpJ84aD4KnwtHHm/QmsrOPjD/+S7g/wLSgI562h9r+u1Ul
        OEFIGv+V+L3hKBB7i02YrIROJ1BvbGObTfppNKLzLJdyOUewbGehIfNghogSphvInPh/OXNKkzU
        KdgbptkUlnP4R
X-Received: by 2002:a05:6402:2930:: with SMTP id ee48mr180543edb.295.1636995646259;
        Mon, 15 Nov 2021 09:00:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMVIJavaf4gkAWe6IN+a6weW9PtLJUKb1ISowQrePYSqAlho9vOKV2oQiFDGjYHBQudfZ+WQ==
X-Received: by 2002:a05:6402:2930:: with SMTP id ee48mr180487edb.295.1636995645919;
        Mon, 15 Nov 2021 09:00:45 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-229-135.dyn.eolo.it. [146.241.229.135])
        by smtp.gmail.com with ESMTPSA id e7sm8070952edk.3.2021.11.15.09.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 09:00:45 -0800 (PST)
Message-ID: <1b9bf5f4327699c74f93c297433012400769a60f.camel@redhat.com>
Subject: Re: [RFC PATCH 2/2] bpf: let bpf_warn_invalid_xdp_action() report
 more info
From:   Paolo Abeni <pabeni@redhat.com>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Date:   Mon, 15 Nov 2021 18:00:44 +0100
In-Reply-To: <8735nxo08o.fsf@toke.dk>
References: <cover.1636987322.git.pabeni@redhat.com>
         <c48e1392bdb0937fd33d3524e1c955a1dae66f49.1636987322.git.pabeni@redhat.com>
         <8735nxo08o.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2021-11-15 at 17:24 +0100, Toke Høiland-Jørgensen wrote:
> Paolo Abeni <pabeni@redhat.com> writes:
> 
> > In non trivial scenarios, the single action id is not sufficient
> > to identify the program causing the warning. Let's additionally
> > include the program id, the attach type and the relevant device
> > name.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  drivers/net/ethernet/amazon/ena/ena_netdev.c           | 2 +-
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c          | 2 +-
> >  drivers/net/ethernet/cavium/thunder/nicvf_main.c       | 2 +-
> >  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c         | 2 +-
> >  drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c       | 2 +-
> >  drivers/net/ethernet/freescale/enetc/enetc.c           | 2 +-
> >  drivers/net/ethernet/intel/i40e/i40e_txrx.c            | 2 +-
> >  drivers/net/ethernet/intel/i40e/i40e_xsk.c             | 2 +-
> >  drivers/net/ethernet/intel/ice/ice_txrx.c              | 2 +-
> >  drivers/net/ethernet/intel/ice/ice_xsk.c               | 2 +-
> >  drivers/net/ethernet/intel/igb/igb_main.c              | 2 +-
> >  drivers/net/ethernet/intel/igc/igc_main.c              | 2 +-
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c          | 2 +-
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c           | 2 +-
> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c      | 2 +-
> >  drivers/net/ethernet/marvell/mvneta.c                  | 2 +-
> >  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c        | 2 +-
> >  drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 2 +-
> >  drivers/net/ethernet/mellanox/mlx4/en_rx.c             | 2 +-
> >  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c       | 2 +-
> >  drivers/net/ethernet/netronome/nfp/nfp_net_common.c    | 2 +-
> >  drivers/net/ethernet/qlogic/qede/qede_fp.c             | 2 +-
> >  drivers/net/ethernet/sfc/rx.c                          | 2 +-
> >  drivers/net/ethernet/socionext/netsec.c                | 2 +-
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c      | 2 +-
> >  drivers/net/ethernet/ti/cpsw_priv.c                    | 2 +-
> >  drivers/net/hyperv/netvsc_bpf.c                        | 2 +-
> >  drivers/net/tun.c                                      | 2 +-
> >  drivers/net/veth.c                                     | 4 ++--
> >  drivers/net/virtio_net.c                               | 4 ++--
> >  drivers/net/xen-netfront.c                             | 2 +-
> >  include/linux/filter.h                                 | 2 +-
> >  kernel/bpf/cpumap.c                                    | 4 ++--
> >  kernel/bpf/devmap.c                                    | 4 ++--
> >  net/core/dev.c                                         | 2 +-
> >  net/core/filter.c                                      | 6 +++---
> >  36 files changed, 42 insertions(+), 42 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > index 7d5d885d85d5..3b46f1df5609 100644
> > --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > @@ -434,7 +434,7 @@ static int ena_xdp_execute(struct ena_ring *rx_ring, struct xdp_buff *xdp)
> >  		xdp_stat = &rx_ring->rx_stats.xdp_pass;
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(verdict);
> > +		bpf_warn_invalid_xdp_action(rx_ring->netdev, xdp_prog, verdict);
> >  		xdp_stat = &rx_ring->rx_stats.xdp_invalid;
> >  	}
> >  
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > index c8083df5e0ab..52fad0fdeacf 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> > @@ -195,7 +195,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
> >  		*event |= BNXT_REDIRECT_EVENT;
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(bp->dev, xdp_prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(bp->dev, xdp_prog, act);
> > diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > index bb45d5df2856..30450efccad7 100644
> > --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > @@ -590,7 +590,7 @@ static inline bool nicvf_xdp_rx(struct nicvf *nic, struct bpf_prog *prog,
> >  		nicvf_xdp_sq_append_pkt(nic, sq, (u64)xdp.data, dma_addr, len);
> >  		return true;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(action);
> > +		bpf_warn_invalid_xdp_action(nic->netdev, prog, action);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(nic->netdev, prog, action);
> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > index 6b2927d863e2..39fafb7d43b2 100644
> > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > @@ -2623,7 +2623,7 @@ static u32 dpaa_run_xdp(struct dpaa_priv *priv, struct qm_fd *fd, void *vaddr,
> >  		}
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(xdp_act);
> > +		bpf_warn_invalid_xdp_action(priv->net_dev, xdp_prog, xdp_act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(priv->net_dev, xdp_prog, xdp_act);
> > diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> > index 714e961e7a77..f113469bd479 100644
> > --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> > +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> > @@ -374,7 +374,7 @@ static u32 dpaa2_eth_run_xdp(struct dpaa2_eth_priv *priv,
> >  		dpaa2_eth_xdp_enqueue(priv, ch, fd, vaddr, rx_fq->flowid);
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(xdp_act);
> > +		bpf_warn_invalid_xdp_action(priv->net_dev, xdp_prog, xdp_act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(priv->net_dev, xdp_prog, xdp_act);
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 504e12554079..eacb41f86bdb 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -1547,7 +1547,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
> >  
> >  		switch (xdp_act) {
> >  		default:
> > -			bpf_warn_invalid_xdp_action(xdp_act);
> > +			bpf_warn_invalid_xdp_action(rx_ring->ndev, prog, xdp_act);
> >  			fallthrough;
> >  		case XDP_ABORTED:
> >  			trace_xdp_exception(rx_ring->ndev, prog, xdp_act);
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > index 10a83e5385c7..b399ca649f09 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> > @@ -2322,7 +2322,7 @@ static int i40e_run_xdp(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
> >  		result = I40E_XDP_REDIR;
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(rx_ring->netdev, xdp_prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  out_failure:
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index ea06e957393e..945b1bb9c6f4 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -176,7 +176,7 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
> >  			goto out_failure;
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(rx_ring->netdev, xdp_prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  out_failure:
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > index bc3ba19dc88f..56940bb908bc 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > @@ -561,7 +561,7 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> >  			goto out_failure;
> >  		return ICE_XDP_REDIR;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(rx_ring->netdev, xdp_prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  out_failure:
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index ff55cb415b11..eb68a5824e9a 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -482,7 +482,7 @@ ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> >  			goto out_failure;
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(rx_ring->netdev, xdp_prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  out_failure:
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > index 836be0d3b291..bdce483d4c0e 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -8422,7 +8422,7 @@ static struct sk_buff *igb_run_xdp(struct igb_adapter *adapter,
> >  		result = IGB_XDP_REDIR;
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(adapter->netdev, xdp_prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  out_failure:
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > index 8e448288ee26..4ea212ddcc9b 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -2231,7 +2231,7 @@ static int __igc_xdp_run_prog(struct igc_adapter *adapter,
> >  		return IGC_XDP_REDIRECT;
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(adapter->netdev, prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  out_failure:
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > index 0f9f022260d7..265bc52aacf8 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > @@ -2235,7 +2235,7 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
> >  		result = IXGBE_XDP_REDIR;
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(rx_ring->netdev, xdp_prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  out_failure:
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > index db2bc58dfcfd..b3fd8e5cd85b 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > @@ -131,7 +131,7 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
> >  			goto out_failure;
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(rx_ring->netdev, xdp_prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  out_failure:
> > diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> > index d81811ab4ec4..757fe0dace88 100644
> > --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> > +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> > @@ -1070,7 +1070,7 @@ static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_adapter *adapter,
> >  			goto out_failure;
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(rx_ring->netdev, xdp_prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  out_failure:
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> > index 5a7bdca22a63..c457a765a828 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -2212,7 +2212,7 @@ mvneta_run_xdp(struct mvneta_port *pp, struct mvneta_rx_queue *rxq,
> >  			mvneta_xdp_put_buff(pp, rxq, xdp, sinfo, sync);
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(pp->dev, prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(pp->dev, prog, act);
> > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > index 2b18d89d9756..e7b7200af5c3 100644
> > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > @@ -3820,7 +3820,7 @@ mvpp2_run_xdp(struct mvpp2_port *port, struct bpf_prog *prog,
> >  		}
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(port->dev, prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(port->dev, prog, act);
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > index 0cc6353254bf..7c4068c5d1ac 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > @@ -1198,7 +1198,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
> >  		put_page(page);
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(pfvf->netdev, prog, act);
> >  		break;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(pfvf->netdev, prog, act);
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > index 650e6a1844ae..8cfc649f226b 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > @@ -812,7 +812,7 @@ int mlx4_en_process_rx_cq(struct net_device *dev, struct mlx4_en_cq *cq, int bud
> >  				trace_xdp_exception(dev, xdp_prog, act);
> >  				goto xdp_drop_no_cnt; /* Drop on xmit failure */
> >  			default:
> > -				bpf_warn_invalid_xdp_action(act);
> > +				bpf_warn_invalid_xdp_action(dev, xdp_prog, act);
> >  				fallthrough;
> >  			case XDP_ABORTED:
> >  				trace_xdp_exception(dev, xdp_prog, act);
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > index 2f0df5cc1a2d..338d65e2c9ce 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > @@ -151,7 +151,7 @@ bool mlx5e_xdp_handle(struct mlx5e_rq *rq, struct mlx5e_dma_info *di,
> >  		rq->stats->xdp_redirect++;
> >  		return true;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(rq->netdev, prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  xdp_abort:
> > diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> > index 850bfdf83d0a..56ef3d64e30d 100644
> > --- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> > +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
> > @@ -1944,7 +1944,7 @@ static int nfp_net_rx(struct nfp_net_rx_ring *rx_ring, int budget)
> >  							    xdp_prog, act);
> >  				continue;
> >  			default:
> > -				bpf_warn_invalid_xdp_action(act);
> > +				bpf_warn_invalid_xdp_action(dp->netdev, xdp_prog, act);
> >  				fallthrough;
> >  			case XDP_ABORTED:
> >  				trace_xdp_exception(dp->netdev, xdp_prog, act);
> > diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
> > index 065e9004598e..32c6e14814bb 100644
> > --- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
> > +++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
> > @@ -1152,7 +1152,7 @@ static bool qede_rx_xdp(struct qede_dev *edev,
> >  		qede_rx_bd_ring_consume(rxq);
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(edev->ndev, prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(edev->ndev, prog, act);
> > diff --git a/drivers/net/ethernet/sfc/rx.c b/drivers/net/ethernet/sfc/rx.c
> > index 606750938b89..2375cef577e4 100644
> > --- a/drivers/net/ethernet/sfc/rx.c
> > +++ b/drivers/net/ethernet/sfc/rx.c
> > @@ -338,7 +338,7 @@ static bool efx_do_xdp(struct efx_nic *efx, struct efx_channel *channel,
> >  		break;
> >  
> >  	default:
> > -		bpf_warn_invalid_xdp_action(xdp_act);
> > +		bpf_warn_invalid_xdp_action(efx->net_dev, xdp_prog, xdp_act);
> >  		efx_free_rx_buffers(rx_queue, rx_buf, 1);
> >  		channel->n_rx_xdp_bad_drops++;
> >  		trace_xdp_exception(efx->net_dev, xdp_prog, xdp_act);
> > diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
> > index de7d8bf2c226..25dcd8eda5fc 100644
> > --- a/drivers/net/ethernet/socionext/netsec.c
> > +++ b/drivers/net/ethernet/socionext/netsec.c
> > @@ -933,7 +933,7 @@ static u32 netsec_run_xdp(struct netsec_priv *priv, struct bpf_prog *prog,
> >  		}
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(priv->ndev, prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(priv->ndev, prog, act);
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index d3f350c25b9b..4cb34001c9ac 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -4690,7 +4690,7 @@ static int __stmmac_xdp_run_prog(struct stmmac_priv *priv,
> >  			res = STMMAC_XDP_REDIRECT;
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(priv->dev, prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(priv->dev, prog, act);
> > diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
> > index ecc2a6b7e28f..e9fdf60ba1a8 100644
> > --- a/drivers/net/ethernet/ti/cpsw_priv.c
> > +++ b/drivers/net/ethernet/ti/cpsw_priv.c
> > @@ -1360,7 +1360,7 @@ int cpsw_run_xdp(struct cpsw_priv *priv, int ch, struct xdp_buff *xdp,
> >  		xdp_do_flush_map();
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(ndev, prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(ndev, prog, act);
> > diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
> > index aa877da113f8..7856905414eb 100644
> > --- a/drivers/net/hyperv/netvsc_bpf.c
> > +++ b/drivers/net/hyperv/netvsc_bpf.c
> > @@ -68,7 +68,7 @@ u32 netvsc_run_xdp(struct net_device *ndev, struct netvsc_channel *nvchan,
> >  		break;
> >  
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(ndev, prog, act);
> >  	}
> >  
> >  out:
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index fecc9a1d293a..0d47d34ba4e7 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1546,7 +1546,7 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
> >  	case XDP_PASS:
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(tun->dev, xdp_prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(tun->dev, xdp_prog, act);
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 50eb43e5bf45..f64dbd8b6403 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -651,7 +651,7 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
> >  			rcu_read_unlock();
> >  			goto xdp_xmit;
> >  		default:
> > -			bpf_warn_invalid_xdp_action(act);
> > +			bpf_warn_invalid_xdp_action(rq->dev, xdp_prog, act);
> >  			fallthrough;
> >  		case XDP_ABORTED:
> >  			trace_xdp_exception(rq->dev, xdp_prog, act);
> > @@ -801,7 +801,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
> >  		rcu_read_unlock();
> >  		goto xdp_xmit;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(rq->dev, xdp_prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(rq->dev, xdp_prog, act);
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 1771d6e5224f..105cd413df52 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -812,7 +812,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
> >  			rcu_read_unlock();
> >  			goto xdp_xmit;
> >  		default:
> > -			bpf_warn_invalid_xdp_action(act);
> > +			bpf_warn_invalid_xdp_action(vi->dev, xdp_prog, act);
> >  			fallthrough;
> >  		case XDP_ABORTED:
> >  			trace_xdp_exception(vi->dev, xdp_prog, act);
> > @@ -1025,7 +1025,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> >  			rcu_read_unlock();
> >  			goto xdp_xmit;
> >  		default:
> > -			bpf_warn_invalid_xdp_action(act);
> > +			bpf_warn_invalid_xdp_action(vi->dev, xdp_prog, act);
> >  			fallthrough;
> >  		case XDP_ABORTED:
> >  			trace_xdp_exception(vi->dev, xdp_prog, act);
> > diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> > index 911f43986a8c..7b7eb617051a 100644
> > --- a/drivers/net/xen-netfront.c
> > +++ b/drivers/net/xen-netfront.c
> > @@ -930,7 +930,7 @@ static u32 xennet_run_xdp(struct netfront_queue *queue, struct page *pdata,
> >  		break;
> >  
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(queue->info->netdev, prog, act);
> >  	}
> >  
> >  	return act;
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index 24b7ed2677af..c21d14fe0156 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -1030,7 +1030,7 @@ void xdp_do_flush(void);
> >   */
> >  #define xdp_do_flush_map xdp_do_flush
> >  
> > -void bpf_warn_invalid_xdp_action(u32 act);
> > +void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog, u32 act);
> >  
> >  #ifdef CONFIG_INET
> >  struct sock *bpf_run_sk_reuseport(struct sock_reuseport *reuse, struct sock *sk,
> > diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> > index 585b2b77ccc4..f7359bcb8fa3 100644
> > --- a/kernel/bpf/cpumap.c
> > +++ b/kernel/bpf/cpumap.c
> > @@ -195,7 +195,7 @@ static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
> >  			}
> >  			return;
> >  		default:
> > -			bpf_warn_invalid_xdp_action(act);
> > +			bpf_warn_invalid_xdp_action(skb->dev,
> >  rcpu->prog, act);
> 
> I'm not sure if including the device from the map run points is the
> right thing to do: the error message refers to "driver unsupported"
> actions which is not the case for these instances. So I think it would
> make more sense to not include the device for these, and adjust the
> error message correspondingly.
> 
> >  			fallthrough;
> >  		case XDP_ABORTED:
> >  			trace_xdp_exception(skb->dev, rcpu->prog, act);
> > @@ -254,7 +254,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
> >  			}
> >  			break;
> >  		default:
> > -			bpf_warn_invalid_xdp_action(act);
> > +			bpf_warn_invalid_xdp_action(xdpf->dev_rx, rcpu->prog, act);
> >  			fallthrough;
> >  		case XDP_DROP:
> >  			xdp_return_frame(xdpf);
> > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > index f02d04540c0c..79bcf2169881 100644
> > --- a/kernel/bpf/devmap.c
> > +++ b/kernel/bpf/devmap.c
> > @@ -348,7 +348,7 @@ static int dev_map_bpf_prog_run(struct bpf_prog *xdp_prog,
> >  				frames[nframes++] = xdpf;
> >  			break;
> >  		default:
> > -			bpf_warn_invalid_xdp_action(act);
> > +			bpf_warn_invalid_xdp_action(dev, xdp_prog, act);
> >  			fallthrough;
> >  		case XDP_ABORTED:
> >  			trace_xdp_exception(dev, xdp_prog, act);
> > @@ -507,7 +507,7 @@ static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dtab_netdev
> >  		__skb_push(skb, skb->mac_len);
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(dst->dev, dst->xdp_prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(dst->dev, dst->xdp_prog, act);
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 15ac064b5562..cf2691d17dd2 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4824,7 +4824,7 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
> >  	case XDP_PASS:
> >  		break;
> >  	default:
> > -		bpf_warn_invalid_xdp_action(act);
> > +		bpf_warn_invalid_xdp_action(skb->dev, xdp_prog, act);
> >  		fallthrough;
> >  	case XDP_ABORTED:
> >  		trace_xdp_exception(skb->dev, xdp_prog, act);
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 3ba584bb23f8..348e392a337f 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -8179,13 +8179,13 @@ static bool xdp_is_valid_access(int off, int size,
> >  	return __is_valid_xdp_access(off, size);
> >  }
> >  
> > -void bpf_warn_invalid_xdp_action(u32 act)
> > +void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog, u32 act)
> >  {
> >  	const u32 act_max = XDP_REDIRECT;
> >  
> > -	pr_warn_once("%s XDP return value %u, expect packet loss!\n",
> > +	pr_warn_once("%s XDP return value %u on prog %d dev %s attach type %d, expect packet loss!\n",
> >  		     act > act_max ? "Illegal" : "Driver unsupported",
> > -		     act);
> > +		     act, prog->aux->id, dev->name, prog->expected_attach_type);
> 
> This will only ever trigger once per reboot even if the message differs,
> right? Which makes it less useful as a debugging aid; so I'm not sure if
> it's really worth it with this intrusive change unless we also do
> something to add a proper debugging aid (like a tracepoint)...

Yes, the idea would be to add a tracepoint there, if there is general
agreement about this change.

I think this patch is needed because the WARN_ONCE splat gives
implicitly information about the related driver and attach type.
Replacing with a simple printk we lose them.

Cheers,

Paolo

