Return-Path: <bpf+bounces-5552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEA775BA39
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 00:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9702820B3
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572F41DDCD;
	Thu, 20 Jul 2023 22:00:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F3168C3
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 22:00:51 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E79B3
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 15:00:50 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55b523cf593so645545a12.1
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689890450; x=1690495250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hADfCxRGZSt9D8QG04rRkop9kt9mQlGVKYblmDaonRg=;
        b=jBLKm/wBWpLpdN4dqYZlt2rXIkCNjNWRf23pBBUW6iVcfHSONsRI9zp6ammvJSU/eh
         hlSY9IaDGmF5CnU44oBoOUwu/Jd0/Zcp5SULJuC3P6kLNLHzOpBsLV3aWybHMViLbtCy
         eHF6BpztH/5KGMMVHpO1ZBe2lWiaZ6MVbVWgnB5j4Qi2Ee8CZ7tnd3oFxw70ZzZk66pk
         +w7xNa+79vX3J6CZ9wbSx48UzlhKim1hbx9hiLmg9VqOWb0Sgr1rmwLabs5B0CpSQtSA
         BItOc5IsYAoBbAPed0GUVLkuyaamNjVMjNc5pta9GOHjQa/aevmZmsJxChCLhhp1Rp7Y
         OVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689890450; x=1690495250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hADfCxRGZSt9D8QG04rRkop9kt9mQlGVKYblmDaonRg=;
        b=WN6uHBbFIztjVxHX4HCKxunRNMxo2tiwDPw967s7s87U570ClKGThawXZGPhRVylWT
         8BPM4NNOrAiiNvR/gfqcQFPYXemcxGsC0Iw7I0MIR4bDTHvi5Z+kp1sfJuM+GKn9LCx4
         PjK9XaCAOAHVAhYhCaL5DRiQeBrsWy3NmdprwxHjJBAPx4+Hiu8brosZD6v1mP5i9vRI
         yeedSakXougJZkY33o/LH8iUHKXrxwvX2c24RvG+MA14RKwW30/ZU273phqcpLqH6Jdi
         xvRGfnx/1YwKPBb2AwfuJGeAcnvno4Y7V9ihZTZt2XU+NesfLs62cPgv2pg3bh75FmYr
         z7jg==
X-Gm-Message-State: ABy/qLYhgSjj6x1BepFP88WBLO/VHTa4ngW/iSJYVcbW/8743TUKXrkS
	12f8yrGDsnKilYBhHkj1mSpBx30=
X-Google-Smtp-Source: APBJJlH93GVWXH4uQALd7c6jceVUi46tUCIAoF1+B4uEWXWwArFp/HEzRPwcgbxmOGSh6mZyCQmdH/k=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7f5a:0:b0:560:63a2:d39e with SMTP id
 p26-20020a637f5a000000b0056063a2d39emr85pgn.0.1689890449711; Thu, 20 Jul 2023
 15:00:49 -0700 (PDT)
Date: Thu, 20 Jul 2023 15:00:48 -0700
In-Reply-To: <20230719183734.21681-17-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719183734.21681-1-larysa.zaremba@intel.com> <20230719183734.21681-17-larysa.zaremba@intel.com>
Message-ID: <ZLmukOljt4ujHLH6@google.com>
Subject: Re: [PATCH bpf-next v3 16/21] selftests/bpf: Add flags and new hints
 to xdp_hw_metadata
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Anatoly Burakov <anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>, 
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>, 
	xdp-hints@xdp-project.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/19, Larysa Zaremba wrote:
> Add hints added in the previous patches (VLAN tag and checksum)
> to the xdp_hw_metadata program.
> 
> Also, to make metadata layout more straightforward, add flags field
> to pass information about validity of every separate hint separately.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

with a small nit below

> ---
>  .../selftests/bpf/progs/xdp_hw_metadata.c     | 37 +++++++--
>  tools/testing/selftests/bpf/xdp_hw_metadata.c | 79 +++++++++++++++++--
>  tools/testing/selftests/bpf/xdp_metadata.h    | 31 +++++++-
>  3 files changed, 135 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> index 63d7de6c6bbb..75a61317668d 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> @@ -20,6 +20,12 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
>  					 __u64 *timestamp) __ksym;
>  extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
>  				    enum xdp_rss_hash_type *rss_type) __ksym;
> +extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
> +					__u16 *vlan_tci,
> +					__be16 *vlan_proto) __ksym;
> +extern int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
> +				    enum xdp_csum_status *csum_status,
> +				    union xdp_csum_info *csum_info) __ksym;
>  
>  SEC("xdp")
>  int rx(struct xdp_md *ctx)
> @@ -84,15 +90,36 @@ int rx(struct xdp_md *ctx)
>  		return XDP_PASS;
>  	}
>  
> +	meta->hint_valid = 0;
> +
>  	err = bpf_xdp_metadata_rx_timestamp(ctx, &meta->rx_timestamp);
> -	if (!err)
> +	if (err) {
> +		meta->rx_timestamp_err = err;
> +	} else {
> +		meta->hint_valid |= XDP_META_FIELD_TS;
>  		meta->xdp_timestamp = bpf_ktime_get_tai_ns();
> +	}

Maybe we can call bpf_ktime_get_tai_ns unconditionally? Then it will
match the rest formatting-wise (no {}).

meta->xdp_timestamp = bpf_ktime_get_tai_ns();

err = bpf_xdp_metadata_rx_timestamp(ctx, &meta->rx_timestamp);
if (err)
	meta->rx_timestamp_err = err;
else
	meta->hint_valid |= XDP_META_FIELD_TS;

WDYT?

> +
> +	err = bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash,
> +				       &meta->rx_hash_type);
> +	if (err)
> +		meta->rx_hash_err = err;
>  	else
> -		meta->rx_timestamp = 0; /* Used by AF_XDP as not avail signal */
> +		meta->hint_valid |= XDP_META_FIELD_RSS;
>  
> -	err = bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
> -	if (err < 0)
> -		meta->rx_hash_err = err; /* Used by AF_XDP as no hash signal */
> +	err = bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tci,
> +					   &meta->rx_vlan_proto);
> +	if (err)
> +		meta->rx_vlan_tag_err = err;
> +	else
> +		meta->hint_valid |= XDP_META_FIELD_VLAN_TAG;
> +
> +	err = bpf_xdp_metadata_rx_csum(ctx, &meta->rx_csum_status,
> +				       (void *)&meta->rx_csum_info);
> +	if (err)
> +		meta->rx_csum_err = err;
> +	else
> +		meta->hint_valid |= XDP_META_FIELD_CSUM;
>  
>  	__sync_add_and_fetch(&pkts_redir, 1);
>  	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 613321eb84c1..a045de7dc910 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -19,6 +19,9 @@
>  #include "xsk.h"
>  
>  #include <error.h>
> +#include <linux/kernel.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
>  #include <linux/errqueue.h>
>  #include <linux/if_link.h>
>  #include <linux/net_tstamp.h>
> @@ -150,21 +153,70 @@ static __u64 gettime(clockid_t clock_id)
>  	return (__u64) t.tv_sec * NANOSEC_PER_SEC + t.tv_nsec;
>  }
>  
> +#define VLAN_PRIO_MASK		GENMASK(15, 13) /* Priority Code Point */
> +#define VLAN_DEI_MASK		GENMASK(12, 12) /* Drop Eligible Indicator */
> +#define VLAN_VID_MASK		GENMASK(11, 0)	/* VLAN Identifier */
> +static void print_vlan_tci(__u16 tag)
> +{
> +	__u16 vlan_id = FIELD_GET(VLAN_VID_MASK, tag);
> +	__u8 pcp = FIELD_GET(VLAN_PRIO_MASK, tag);
> +	bool dei = FIELD_GET(VLAN_DEI_MASK, tag);
> +
> +	printf("PCP=%u, DEI=%d, VID=0x%X\n", pcp, dei, vlan_id);
> +}
> +
> +#define XDP_CHECKSUM_VALID_NUM_MASK	GENMASK(2, 0)
> +#define XDP_CHECKSUM_PARTIAL		BIT(3)
> +#define XDP_CHECKSUM_COMPLETE		BIT(4)
> +
> +struct partial_csum_info {
> +	__u16 csum_start;
> +	__u16 csum_offset;
> +};
> +
> +static void print_csum_state(__u32 status, __u32 info)
> +{
> +	u8 csum_num = status & XDP_CHECKSUM_VALID_NUM_MASK;
> +
> +	printf("Checksum status: ");
> +	if (status != XDP_CHECKSUM_PARTIAL &&
> +	    status & ~(XDP_CHECKSUM_COMPLETE | XDP_CHECKSUM_VALID_NUM_MASK))
> +		printf("cannot be interpreted, status=0x%X\n", status);
> +
> +	if (status == XDP_CHECKSUM_PARTIAL) {
> +		struct partial_csum_info *partial_info = (void *)&info;
> +
> +		printf("partial, csum_start=%u, csum_offset=%u\n",
> +		       partial_info->csum_start, partial_info->csum_offset);
> +		return;
> +	}
> +
> +	if (status & XDP_CHECKSUM_COMPLETE)
> +		printf("complete, checksum=0x%X%s", info,
> +		       csum_num ? ", " : "\n");
> +
> +	if (csum_num > 1)
> +		printf("%u consecutive checksums are verified\n", csum_num);
> +	else if (csum_num)
> +		printf("outermost checksum is verified\n");
> +}
> +
>  static void verify_xdp_metadata(void *data, clockid_t clock_id)
>  {
>  	struct xdp_meta *meta;
>  
>  	meta = data - sizeof(*meta);
>  
> -	if (meta->rx_hash_err < 0)
> -		printf("No rx_hash err=%d\n", meta->rx_hash_err);
> -	else
> +	if (meta->hint_valid & XDP_META_FIELD_RSS)
>  		printf("rx_hash: 0x%X with RSS type:0x%X\n",
>  		       meta->rx_hash, meta->rx_hash_type);
> +	else
> +		printf("No rx_hash, err=%d\n", meta->rx_hash_err);
> +
> +	if (meta->hint_valid & XDP_META_FIELD_TS) {
> +		printf("rx_timestamp:  %llu (sec:%0.4f)\n", meta->rx_timestamp,
> +		       (double)meta->rx_timestamp / NANOSEC_PER_SEC);
>  
> -	printf("rx_timestamp:  %llu (sec:%0.4f)\n", meta->rx_timestamp,
> -	       (double)meta->rx_timestamp / NANOSEC_PER_SEC);
> -	if (meta->rx_timestamp) {
>  		__u64 usr_clock = gettime(clock_id);
>  		__u64 xdp_clock = meta->xdp_timestamp;
>  		__s64 delta_X = xdp_clock - meta->rx_timestamp;
> @@ -179,8 +231,23 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
>  		       usr_clock, (double)usr_clock / NANOSEC_PER_SEC,
>  		       (double)delta_X2U / NANOSEC_PER_SEC,
>  		       (double)delta_X2U / 1000);
> +	} else {
> +		printf("No rx_timestamp, err=%d\n", meta->rx_timestamp_err);
>  	}
>  
> +	if (meta->hint_valid & XDP_META_FIELD_VLAN_TAG) {
> +		printf("rx_vlan_proto: 0x%X\n", ntohs(meta->rx_vlan_proto));
> +		printf("rx_vlan_tci: ");
> +		print_vlan_tci(meta->rx_vlan_tci);
> +	} else {
> +		printf("No rx_vlan_tci or rx_vlan_proto, err=%d\n",
> +		       meta->rx_vlan_tag_err);
> +	}
> +
> +	if (meta->hint_valid & XDP_META_FIELD_CSUM)
> +		print_csum_state(meta->rx_csum_status, meta->rx_csum_info);
> +	else
> +		printf("Checksum was not checked, err=%d\n", meta->rx_csum_err);
>  }
>  
>  static void verify_skb_metadata(int fd)
> diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
> index 6664893c2c77..95e7b53d6bfb 100644
> --- a/tools/testing/selftests/bpf/xdp_metadata.h
> +++ b/tools/testing/selftests/bpf/xdp_metadata.h
> @@ -17,12 +17,41 @@
>  #define ETH_P_8021AD 0x88A8
>  #endif
>  
> +#ifndef BIT
> +#define BIT(nr)			(1 << (nr))
> +#endif
> +
> +enum xdp_meta_field {
> +	XDP_META_FIELD_TS	= BIT(0),
> +	XDP_META_FIELD_RSS	= BIT(1),
> +	XDP_META_FIELD_VLAN_TAG	= BIT(2),
> +	XDP_META_FIELD_CSUM	= BIT(3),
> +};
> +
>  struct xdp_meta {
> -	__u64 rx_timestamp;
> +	union {
> +		__u64 rx_timestamp;
> +		__s32 rx_timestamp_err;
> +	};
>  	__u64 xdp_timestamp;
>  	__u32 rx_hash;
>  	union {
>  		__u32 rx_hash_type;
>  		__s32 rx_hash_err;
>  	};
> +	union {
> +		struct {
> +			__u16 rx_vlan_tci;
> +			__be16 rx_vlan_proto;
> +		};
> +		__s32 rx_vlan_tag_err;
> +	};
> +	union {
> +		struct {
> +			__u32 rx_csum_status;
> +			__u32 rx_csum_info;
> +		};
> +		__s32 rx_csum_err;
> +	};
> +	enum xdp_meta_field hint_valid;
>  };
> -- 
> 2.41.0
> 

