Return-Path: <bpf+bounces-5556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AADA75BA52
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 00:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5A3282099
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7731DDE6;
	Thu, 20 Jul 2023 22:14:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C69C1DDD8
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 22:14:18 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C066C171E
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 15:14:17 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53fa00ed93dso963156a12.3
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 15:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689891257; x=1690496057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDZO+z4IDTQG6wBE5pfUJb3Uo/b0UiJaJfvx9xUgju8=;
        b=i3oOe6wjb1muzBZ+xoZA/jZkhy5z8EpfN9e8r1JkPA2LqDt+BOStP8Bpy2VRn0IYmT
         UhaVhWZ9JzzKeIa3R+ULsY6I+mrRYXvWDwy+sGsjESGytCC1bO2+pUQS5SG3z+WXNO+C
         lalt+PUxzEhIKZcIHCMa8Q7zvNrGdWhVffmhRx+1lOYfPzbXldArGo/OhvSVzmr/B4UU
         JgMUS63oSvoSUEsM7GueRI+UvbjOrW01YwuphuFenwZRQvtpjMmkp+1nTN297YewZR5L
         +8s3cT7S2vn0osvca3H2y9Ts73hds9KskUUvDOYEDJisqOp7wg9Vjq2ygMlzLInfeC0u
         enkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689891257; x=1690496057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDZO+z4IDTQG6wBE5pfUJb3Uo/b0UiJaJfvx9xUgju8=;
        b=jX6PgAfYByktTW6YALBwPzCSYk0EOYvoVRlNWL9KVPJCR8qK53IA3YiVali8u7x8cS
         HPs4/k98prDjo4ZPAHzGn7qjrWHn7W6CE+Cfoj6I6OvUaqTfu2ztSJW/HT4Sv7GaiqJh
         KCs7fKOqThbEk46DKs/Dwkse/0N0HNSsj9MCBZ4qmmkue64MCxl1RSL9PYTGfR9M3S2M
         2LLGc6pzdMKNO/cxv4olP1ZDRG5qQD6tHOa5KUZP1T9YIQVLiHWqF3DgdUd8nv/vj9mK
         OHCF9hb9lru0ah4FSw16pQOO1IVVFjYPGVUaIVMYlzq9cg/vOARIqFXDcbQ3FKmbEqZb
         Q6Vw==
X-Gm-Message-State: ABy/qLbf5QPXZkweHOWDrSM/RpfWv+gNAhaGspeb7pz8hdf913hZYZL/
	imx8ky8fciz2qeYIpRB/C5vwEkk=
X-Google-Smtp-Source: APBJJlGdd1LLnEUkG6/yeHjznhvVqsQjqchOcqfb1Y4zR/q2if/xtGHP8nmI0TJ821m9Xseq8vWWt38=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:731b:0:b0:563:57ea:1d1a with SMTP id
 o27-20020a63731b000000b0056357ea1d1amr30pgc.12.1689891257270; Thu, 20 Jul
 2023 15:14:17 -0700 (PDT)
Date: Thu, 20 Jul 2023 15:14:15 -0700
In-Reply-To: <20230719183734.21681-21-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719183734.21681-1-larysa.zaremba@intel.com> <20230719183734.21681-21-larysa.zaremba@intel.com>
Message-ID: <ZLmxt3744Q1e42pT@google.com>
Subject: Re: [PATCH bpf-next v3 20/21] selftests/bpf: Check VLAN tag and proto
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

On 07/19, Larysa Zaremba wrote:
> Verify, whether VLAN tag and proto are set correctly.
> 
> To simulate "stripped" VLAN tag on veth, send test packet from VLAN
> interface.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  .../selftests/bpf/prog_tests/xdp_metadata.c   | 22 +++++++++++++++++--
>  .../selftests/bpf/progs/xdp_metadata.c        |  4 ++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 1877e5c6d6c7..6665cf0c59cc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -38,7 +38,15 @@
>  #define TX_MAC "00:00:00:00:00:01"
>  #define RX_MAC "00:00:00:00:00:02"
>  
> +#define VLAN_ID 59
> +#define VLAN_ID_STR "59"

I was looking whether we have some str(x) macro in the selftests,
but doesn't look like we have any...

> +#define VLAN_PROTO "802.1Q"
> +#define VLAN_PID htons(ETH_P_8021Q)
> +#define TX_NAME_VLAN TX_NAME "." VLAN_ID_STR
> +#define RX_NAME_VLAN RX_NAME "." VLAN_ID_STR
> +
>  #define XDP_RSS_TYPE_L4 BIT(3)
> +#define VLAN_VID_MASK 0xfff
>  
>  struct xsk {
>  	void *umem_area;
> @@ -215,6 +223,12 @@ static int verify_xsk_metadata(struct xsk *xsk)
>  	if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
>  		return -1;
>  
> +	if (!ASSERT_EQ(meta->rx_vlan_tci & VLAN_VID_MASK, VLAN_ID, "rx_vlan_tci"))
> +		return -1;
> +
> +	if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
> +		return -1;
> +
>  	xsk_ring_cons__release(&xsk->rx, 1);
>  	refill_rx(xsk, comp_addr);
>  
> @@ -248,10 +262,14 @@ void test_xdp_metadata(void)
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
>  	close_netns(tok);
>  
>  	tok = open_netns(RX_NETNS_NAME);
> diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> index d151d406a123..d3111649170e 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> @@ -23,6 +23,9 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
>  					 __u64 *timestamp) __ksym;
>  extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
>  				    enum xdp_rss_hash_type *rss_type) __ksym;
> +extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
> +					__u16 *vlan_tci,
> +					__be16 *vlan_proto) __ksym;
>  
>  SEC("xdp")
>  int rx(struct xdp_md *ctx)
> @@ -57,6 +60,7 @@ int rx(struct xdp_md *ctx)
>  		meta->rx_timestamp = 1;
>  
>  	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
> +	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tci, &meta->rx_vlan_proto);
>  
>  	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
>  }
> -- 
> 2.41.0
> 

