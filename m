Return-Path: <bpf+bounces-5557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA6775BA54
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 00:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD3B2820A2
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962681DDE1;
	Thu, 20 Jul 2023 22:14:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70326168C3
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 22:14:38 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E50171E
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 15:14:37 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55be4f03661so972961a12.1
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689891277; x=1690496077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntAPyIcMbj4x2RdnE4QWJ5FnaEQOtZId8qQ+eDe+suw=;
        b=2+e4wlpBPGsDpkyw9CWHUhUURlWwywpD9mLf9/RBs1kZ8I0EHM8GFP0kqUHjLBcgnz
         GFnq5AWj7J7LoL/lcihBMgvlTppJkp978bgwidS+pSzERqqVPAmvnYZ1OOqW6B53PHI2
         a4PqOh82SNuR6MmQUuG7pjquwvMJYeyp2xYQ2/Z1XjWtTEwbz4n/SOBasMM4oQvuOxF8
         L706QxaAyVlF9w+Ey+PMmd5QG7b5M4ASTxtsrm335ulibPXAOXznvyKyPxnj9GXEw0P8
         w+Fxp4fl8CEj2VR+2GsBGpU5KuYDPb11xZ475wFcZTzvOGhKFSqmxcWJpsZVhmQy8EDI
         Sd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689891277; x=1690496077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntAPyIcMbj4x2RdnE4QWJ5FnaEQOtZId8qQ+eDe+suw=;
        b=FMd5XYxaAjM9jEX7cUAYIIkpvJNDNON1IjUliVDL1ucQwgGfPJgIOGzyQQoWVPr2gC
         yNEcTl9VXzUdSdDrb/Ukd4E6b1o+E5T1cMwv05Q4g8yFsCQzIRTbZ6q4xfKy3t26/IP6
         91M8wtCjFQi14w4CzyGMwSqckjG7qj5Qy+S9XcNOzv+ijmRat6ecvduE4P7VdI7aoiFc
         vpk0cc5hOYoTtE/7xO4sPutZVQWZrzC/cp4YvlgIMYOJVNqqYhK/VAuItOgOQb0OxRwP
         KkW4DQqJD+2TXIwLr+HlupoPWhm5KpW/Yu/n2cltM7m8NkrKT5AvflE++B1FyKiDywOj
         cBuw==
X-Gm-Message-State: ABy/qLZkYNgu3nEGkmcEI5+vK0h0EHBZcoAMr71XkjzGe1wZla8P5ZJl
	Mekx3VZq9DtUzlcFdy8p6gBWD64=
X-Google-Smtp-Source: APBJJlEMcGX2ZkdXhS334WMXGI7SezRrsjD1b1FT17XrD7DpNm7fvdr043HoswPQetYExgcds8n3skw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7448:0:b0:557:531e:34c7 with SMTP id
 e8-20020a637448000000b00557531e34c7mr27pgn.11.1689891276612; Thu, 20 Jul 2023
 15:14:36 -0700 (PDT)
Date: Thu, 20 Jul 2023 15:14:34 -0700
In-Reply-To: <20230719183734.21681-22-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719183734.21681-1-larysa.zaremba@intel.com> <20230719183734.21681-22-larysa.zaremba@intel.com>
Message-ID: <ZLmxyqiAuLHUzztt@google.com>
Subject: Re: [PATCH bpf-next v3 21/21] selftests/bpf: check checksum state in xdp_metadata
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
> Verify, whether kfunc in xdp_metadata test correctly returns partial
> checksum status and offsets.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  .../selftests/bpf/prog_tests/xdp_metadata.c   | 30 +++++++++++++++++++
>  .../selftests/bpf/progs/xdp_metadata.c        |  6 ++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 6665cf0c59cc..c0ce66703696 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -47,6 +47,7 @@
>  
>  #define XDP_RSS_TYPE_L4 BIT(3)
>  #define VLAN_VID_MASK 0xfff
> +#define XDP_CHECKSUM_PARTIAL BIT(3)
>  
>  struct xsk {
>  	void *umem_area;
> @@ -168,6 +169,32 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
>  	}
>  }
>  
> +struct partial_csum_info {
> +	__u16 csum_start;
> +	__u16 csum_offset;
> +};
> +
> +static bool assert_checksum_ok(struct xdp_meta *meta)
> +{
> +	struct partial_csum_info *info;
> +	u32 csum_start, csum_offset;
> +
> +	if (!ASSERT_EQ(meta->rx_csum_status, XDP_CHECKSUM_PARTIAL,
> +		       "rx_csum_status"))
> +		return false;
> +
> +	csum_start = sizeof(struct ethhdr) + sizeof(struct iphdr);
> +	csum_offset = offsetof(struct udphdr, check);
> +	info = (void *)&meta->rx_csum_info;
> +
> +	if (!ASSERT_EQ(info->csum_start, csum_start, "rx csum_start"))
> +		return false;
> +	if (!ASSERT_EQ(info->csum_offset, csum_offset, "rx csum_offset"))
> +		return false;
> +
> +	return true;
> +}
> +
>  static int verify_xsk_metadata(struct xsk *xsk)
>  {
>  	const struct xdp_desc *rx_desc;
> @@ -229,6 +256,9 @@ static int verify_xsk_metadata(struct xsk *xsk)
>  	if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
>  		return -1;
>  
> +	if (!assert_checksum_ok(meta))
> +		return -1;
> +
>  	xsk_ring_cons__release(&xsk->rx, 1);
>  	refill_rx(xsk, comp_addr);
>  
> diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> index d3111649170e..e79667a0726e 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> @@ -26,6 +26,9 @@ extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
>  extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
>  					__u16 *vlan_tci,
>  					__be16 *vlan_proto) __ksym;
> +extern int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
> +				    enum xdp_csum_status *csum_status,
> +				    union xdp_csum_info *csum_info) __ksym;
>  
>  SEC("xdp")
>  int rx(struct xdp_md *ctx)
> @@ -62,6 +65,9 @@ int rx(struct xdp_md *ctx)
>  	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
>  	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tci, &meta->rx_vlan_proto);
>  
> +	bpf_xdp_metadata_rx_csum(ctx, &meta->rx_csum_status,
> +				 (void *)&meta->rx_csum_info);
> +
>  	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
>  }
>  
> -- 
> 2.41.0
> 

