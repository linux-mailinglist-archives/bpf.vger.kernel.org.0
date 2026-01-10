Return-Path: <bpf+bounces-78457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4647D0D370
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 09:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FA243015EC6
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9863A2D9EF4;
	Sat, 10 Jan 2026 08:37:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6873D6F;
	Sat, 10 Jan 2026 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768034237; cv=none; b=phqKlmyDqRpJTmgTHGKTYEfqe9JzNDdu/1BSIrZMONnWtofNsIvl1P5lkLZaV6YMaGzyIfKXsje3gTR0uSJw71uaA4eVvp99ZurqAsa47aea7VLtBVwrQJWStvqk20D+TmfFuTc2crO6xoRWGTqnd2wtn6+6edah9nRN7jVOQs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768034237; c=relaxed/simple;
	bh=O/PpOg36FNM2ei1vhJaHdz1sULiLmjd+N8Mpmu1yecg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqY/tkpFFs4zQ5QiR6eBIE767u/G068ICTILeUGA/dqTjUPwY8GV9t3jHHKoAkj2fZRgpZzavQtVKRiSNSR+7K84NFNtIQ+/sjrpwakcerO+8c9hZZyLuESE1NjERYd3hYoH0ozyEi+5BN7qf0BY6fU4Ltb47qI8v6t6sdjwKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.217] (p5dc55726.dip0.t-ipconnect.de [93.197.87.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 905F42394AFD3;
	Sat, 10 Jan 2026 09:35:59 +0100 (CET)
Message-ID: <43dafae2-e1f1-44ce-91c1-7fc236966f58@molgen.mpg.de>
Date: Sat, 10 Jan 2026 09:35:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4] idpf: export RX hardware
 timestamping information to XDP
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, YiFei Zhu <zhuyifei@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>,
 intel-wired-lan@lists.osuosl.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20251223194649.3050648-1-almasrymina@google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251223194649.3050648-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mina,


Thank you for your patch. Some minor comments, should you resend.

Am 23.12.25 um 20:46 schrieb Mina Almasry via Intel-wired-lan:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> The logic is similar to idpf_rx_hwtstamp, but the data is exported
> as a BPF kfunc instead of appended to an skb to support grabbing
> timestamps in xsk packets.
> 
> A idpf_queue_has(PTP, rxq) condition is added to check the queue
> supports PTP similar to idpf_rx_process_skb_fields.
> 
> Tested using an xsk connection and checking xdp timestamps are
> retreivable in received packets.

retr*ie*vable

It’d be great if you could share the commands.

> Cc: intel-wired-lan@lists.osuosl.org
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> ---
> 
> v4: https://lore.kernel.org/netdev/20251219202957.2309698-1-almasrymina@google.com/
> - Fix indentation (lobakin)
> - I kept the (u64) casts for all bit shifted bits in idpf_xdp_get_qw3
>    and friends as I see all idpf_xdp_get_qw* functions do the cast in all
>    bit-shifted variables.
> 
> v3: https://lore.kernel.org/netdev/20251218022948.3288897-1-almasrymina@google.com/
> - Do the idpf_queue_has(PTP) check before we read qw1 (lobakin)
> - Fix _qw1 not copying over ts_low on on !__LIBETH_WORD_ACCESS systems
>    (AI)
> 
> v2: https://lore.kernel.org/netdev/20251122140839.3922015-1-almasrymina@google.com/
> - Fixed alphabetical ordering
> - Use the xdp desc type instead of virtchnl one (required some added
>    helpers)
> 
> ---
>   drivers/net/ethernet/intel/idpf/xdp.c | 31 +++++++++++++++++++++++++++
>   drivers/net/ethernet/intel/idpf/xdp.h | 20 +++++++++++++++++
>   2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
> index 958d16f87424..0916d201bf98 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.c
> +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> @@ -2,6 +2,7 @@
>   /* Copyright (C) 2025 Intel Corporation */
>   
>   #include "idpf.h"
> +#include "idpf_ptp.h"
>   #include "idpf_virtchnl.h"
>   #include "xdp.h"
>   #include "xsk.h"
> @@ -391,8 +392,38 @@ static int idpf_xdpmo_rx_hash(const struct xdp_md *ctx, u32 *hash,
>   				    pt);
>   }
>   
> +static int idpf_xdpmo_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
> +{
> +	const struct libeth_xdp_buff *xdp = (typeof(xdp))ctx;
> +	struct idpf_xdp_rx_desc desc __uninitialized;
> +	const struct idpf_rx_queue *rxq;
> +	u64 cached_time, ts_ns;
> +	u32 ts_high;
> +
> +	rxq = libeth_xdp_buff_to_rq(xdp, typeof(*rxq), xdp_rxq);
> +
> +	if (!idpf_queue_has(PTP, rxq))
> +		return -ENODATA;
> +
> +	idpf_xdp_get_qw1(&desc, xdp->desc);
> +
> +	if (!(idpf_xdp_rx_ts_low(&desc) & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
> +		return -ENODATA;
> +
> +	cached_time = READ_ONCE(rxq->cached_phc_time);
> +
> +	idpf_xdp_get_qw3(&desc, xdp->desc);
> +
> +	ts_high = idpf_xdp_rx_ts_high(&desc);
> +	ts_ns = idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
> +
> +	*timestamp = ts_ns;
> +	return 0;
> +}
> +
>   static const struct xdp_metadata_ops idpf_xdpmo = {
>   	.xmo_rx_hash		= idpf_xdpmo_rx_hash,
> +	.xmo_rx_timestamp	= idpf_xdpmo_rx_timestamp,

Append the unit?

>   };
>   
>   void idpf_xdp_set_features(const struct idpf_vport *vport)
> diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
> index 479f5ef3c604..1748a0d73547 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.h
> +++ b/drivers/net/ethernet/intel/idpf/xdp.h
> @@ -112,11 +112,13 @@ struct idpf_xdp_rx_desc {
>   	aligned_u64		qw1;
>   #define IDPF_XDP_RX_BUF		GENMASK_ULL(47, 32)
>   #define IDPF_XDP_RX_EOP		BIT_ULL(1)
> +#define IDPF_XDP_RX_TS_LOW	GENMASK_ULL(31, 24)
>   
>   	aligned_u64		qw2;
>   #define IDPF_XDP_RX_HASH	GENMASK_ULL(31, 0)
>   
>   	aligned_u64		qw3;
> +#define IDPF_XDP_RX_TS_HIGH	GENMASK_ULL(63, 32)
>   } __aligned(4 * sizeof(u64));
>   static_assert(sizeof(struct idpf_xdp_rx_desc) ==
>   	      sizeof(struct virtchnl2_rx_flex_desc_adv_nic_3));
> @@ -128,6 +130,8 @@ static_assert(sizeof(struct idpf_xdp_rx_desc) ==
>   #define idpf_xdp_rx_buf(desc)	FIELD_GET(IDPF_XDP_RX_BUF, (desc)->qw1)
>   #define idpf_xdp_rx_eop(desc)	!!((desc)->qw1 & IDPF_XDP_RX_EOP)
>   #define idpf_xdp_rx_hash(desc)	FIELD_GET(IDPF_XDP_RX_HASH, (desc)->qw2)
> +#define idpf_xdp_rx_ts_low(desc)	FIELD_GET(IDPF_XDP_RX_TS_LOW, (desc)->qw1)
> +#define idpf_xdp_rx_ts_high(desc)	FIELD_GET(IDPF_XDP_RX_TS_HIGH, (desc)->qw3)
>   
>   static inline void
>   idpf_xdp_get_qw0(struct idpf_xdp_rx_desc *desc,
> @@ -149,6 +153,9 @@ idpf_xdp_get_qw1(struct idpf_xdp_rx_desc *desc,
>   	desc->qw1 = ((const typeof(desc))rxd)->qw1;
>   #else
>   	desc->qw1 = ((u64)le16_to_cpu(rxd->buf_id) << 32) |
> +		    ((u64)rxd->ts_low << 24) |
> +		    ((u64)rxd->fflags1 << 16) |
> +		    ((u64)rxd->status_err1 << 8) |
>   		    rxd->status_err0_qw1;
>   #endif
>   }
> @@ -166,6 +173,19 @@ idpf_xdp_get_qw2(struct idpf_xdp_rx_desc *desc,
>   #endif
>   }
>   
> +static inline void
> +idpf_xdp_get_qw3(struct idpf_xdp_rx_desc *desc,
> +		 const struct virtchnl2_rx_flex_desc_adv_nic_3 *rxd)
> +{
> +#ifdef __LIBETH_WORD_ACCESS
> +	desc->qw3 = ((const typeof(desc))rxd)->qw3;
> +#else
> +	desc->qw3 = ((u64)le32_to_cpu(rxd->ts_high) << 32) |
> +		    ((u64)le16_to_cpu(rxd->fmd6) << 16) |
> +		    le16_to_cpu(rxd->l2tag1);
> +#endif

It’s done elsewhere in the file, but I wonder why use the preprocessor 
and not plain C code, and let the linker(?) remove the unneeded branch?

> +}
> +
>   void idpf_xdp_set_features(const struct idpf_vport *vport);
>   
>   int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp);


Kind regards,

Paul

