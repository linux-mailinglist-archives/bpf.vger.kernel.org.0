Return-Path: <bpf+bounces-4086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B3C748AC7
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 19:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A221528105D
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1379134C0;
	Wed,  5 Jul 2023 17:41:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FA913AC4
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 17:41:42 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640A719B
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 10:41:40 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53ba38cf091so1159866a12.1
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688578900; x=1691170900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9S+Xr0t/BGcRCRuHCsJ4yWPie+az1SFAg+/NRAZYg+I=;
        b=uN8qhhLsVJSrIMqLii5OJl3/Y7ULh3SSEBT4+1KLzRcP4qXPtl7SYrpN0FyH8z7es9
         pJ5rt/iBzJZOSmavYdzKx0A5MSWEj+1Ykqkhx0nt3Hkm1BaFeE5Rco5vO78fUHzMdEhW
         IAqM5gQOgBZG7+nQl1rc5sPMQz89RrFhShtAkJMmzKH6zR0vSZ0RKl7+lr5f1OQ5mFm4
         suv3s8IFGmTsj1AsEPyYd4MJ5sG4Rh26uMv3LeUoGtMWQcWql249brji/XWXEPM7t/3E
         fd/ua9dM/rVujGoQobvuJ+nnmdaDI1KAsBFDuvQUU7BSeOrIu8/VjDJYtsLa0U2xoFBE
         DXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688578900; x=1691170900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9S+Xr0t/BGcRCRuHCsJ4yWPie+az1SFAg+/NRAZYg+I=;
        b=eSYd2WzcKEH1pQXCDOnIEMOpABxrJBw75jsNnQ39WsEMXyu9rXmmo/PK2S+RC/mvNA
         x+Fr/TsXJCu2XN9l7yzsXlcnxIQhIA/X0WP95Rz24RYqV8ClfH5fjvKm7dZcFtu0mTVl
         gqbccnPlDz6ulmbg2YeOYGT+8HQvp5cS9mnbNrfnjaaX8OZl+QNKDtWxb0sFqYImryAU
         GkrRAuZThaf+7uPaaOWOaS93sct7NA6++I5dIVZF05arG3KwOOHIcawrym7KIeuo5BiM
         KdQmieXxBxf8fueU2ZFE33lZXHViUxJfCxCvaps/giUx4ueIIHb9bSxsTBY0iicFraMv
         oAYw==
X-Gm-Message-State: ABy/qLbwZu7andekBHmoRGxRhJfwFDKxSjzS41SPAdBFTvVfMZnEJD0c
	o/gxytbECVgzzZaoFemJlfBN7bo=
X-Google-Smtp-Source: APBJJlHolmtBN/SZfPcDmIcx6c31OXRjPp30/EY0hD/eS9YT0a8RfCK/0JeKpb5dYkOPN8kKIrt/iIM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:d785:b0:263:49d3:8024 with SMTP id
 z5-20020a17090ad78500b0026349d38024mr2165485pju.1.1688578899900; Wed, 05 Jul
 2023 10:41:39 -0700 (PDT)
Date: Wed, 5 Jul 2023 10:41:38 -0700
In-Reply-To: <20230703181226.19380-20-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230703181226.19380-1-larysa.zaremba@intel.com> <20230703181226.19380-20-larysa.zaremba@intel.com>
Message-ID: <ZKWrUra5lTFL+kea@google.com>
Subject: Re: [PATCH bpf-next v2 19/20] selftests/bpf: Check VLAN tag and proto
 in xdp_metadata
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/03, Larysa Zaremba wrote:
> Verify, whether VLAN tag and proto are set correctly.
> 
> To simulate "stripped" VLAN tag on veth, send test packet from VLAN
> interface.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  .../selftests/bpf/prog_tests/xdp_metadata.c   | 21 +++++++++++++++++--
>  .../selftests/bpf/progs/xdp_metadata.c        |  4 ++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 53b32a641e8e..50ac9f570bc5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -38,6 +38,13 @@
>  #define TX_MAC "00:00:00:00:00:01"
>  #define RX_MAC "00:00:00:00:00:02"
>  
> +#define VLAN_ID 59
> +#define VLAN_ID_STR "59"
> +#define VLAN_PROTO "802.1Q"
> +#define VLAN_PID htons(ETH_P_8021Q)
> +#define TX_NAME_VLAN TX_NAME "." VLAN_ID_STR
> +#define RX_NAME_VLAN RX_NAME "." VLAN_ID_STR
> +
>  #define XDP_RSS_TYPE_L4 BIT(3)
>  
>  struct xsk {
> @@ -215,6 +222,12 @@ static int verify_xsk_metadata(struct xsk *xsk)
>  	if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
>  		return -1;
>  
> +	if (!ASSERT_EQ(meta->rx_vlan_tag, VLAN_ID, "rx_vlan_tag"))
> +		return -1;
> +
> +	if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
> +		return -1;
> +
>  	xsk_ring_cons__release(&xsk->rx, 1);
>  	refill_rx(xsk, comp_addr);
>  
> @@ -253,10 +266,14 @@ void test_xdp_metadata(void)
>  
>  	SYS(out, "ip link set dev " TX_NAME " address " TX_MAC);
>  	SYS(out, "ip link set dev " TX_NAME " up");
> -	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
> +
> +	SYS(out, "ip link add link " TX_NAME " " TX_NAME_VLAN
> +		 " type vlan proto " VLAN_PROTO " id " VLAN_ID_STR);
> +	SYS(out, "ip link set dev " TX_NAME_VLAN " up");
> +	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME_VLAN);
>  
>  	/* Avoid ARP calls */
> -	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME);
> +	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME_VLAN);
>  
>  	set_netns(rx_netns);
>  	SYS(out, "ip link set dev " RX_NAME " address " RX_MAC);
> diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> index d151d406a123..382984a5d1c9 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> @@ -23,6 +23,9 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
>  					 __u64 *timestamp) __ksym;
>  extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
>  				    enum xdp_rss_hash_type *rss_type) __ksym;
> +extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
> +					__u16 *vlan_tag,
> +					__be16 *vlan_proto) __ksym;
>  
>  SEC("xdp")
>  int rx(struct xdp_md *ctx)
> @@ -57,6 +60,7 @@ int rx(struct xdp_md *ctx)
>  		meta->rx_timestamp = 1;
>  
>  	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
> +	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tag, &meta->rx_vlan_proto);
>  
>  	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
>  }
> -- 
> 2.41.0
> 

