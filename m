Return-Path: <bpf+bounces-4084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42F3748AA6
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 19:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6302810D6
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 17:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C078913AF3;
	Wed,  5 Jul 2023 17:32:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CFE13AE8
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 17:32:25 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4C1BEA
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 10:31:49 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55afcc54d55so1162896a12.0
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688578309; x=1691170309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uAllegANh0wecO8quStfyUYqqh/4wE1uob2jJG1C+pU=;
        b=BMkvre6ubBI7GfbFOLTTKaMAOWH+AoIIm/6LH7VNPMHkSCZcsj8jEu0w4Lr9kH5UTl
         olKlyXJndJOsMqDUYROFQxkhD7FxgY6VcV/JXUqSne7nJMbPZYxcWHrl0qV+mJfIdKRC
         jsltyhmsAzyOAuEXjYVamop6Q1Kj03piJGE4UqNeOdbGudOnNFWt+UIaxyxRbR6gEZp7
         uxa5nPZELHNWOJgQhuDdgsZv0bwdxo4BTLyLrDnmBrOHmMnN34miIb+HMBOH6FWmv4SX
         KMrgkTELrVb9bqijP8X+hl00QinirpNFtWPUISkkl/dp0Pt2B/08wJeTI06XA4Mv3/ni
         Upzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688578309; x=1691170309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAllegANh0wecO8quStfyUYqqh/4wE1uob2jJG1C+pU=;
        b=bEdYExF0TewFrl18f5gqGaEya0PHcIy0Xe3pijneUDNDLs/B64AVcTwGu784iNCqBp
         MEijFVE2tbbndJTn3EYr1DZH9EQ0c93PzhrxI7m6P9uM1IN/sRfIp1CsU1uQROsu19cM
         LlfmPxtiTVubuGGidMibkGZY8u7b/gbBK1M7lAAG2wux9QBKwqscHig1QsJFchEFkofs
         s1bjh2XQdth3bOUYyynwHre7DWc/hotLBC9xEap1uxgiG/v+FfI4NnZispoFHLdeHLR7
         VNflKKJh0DatiE2KXalwQinWm5s9YruBcSSZsOtnb6DKTPSdng3eKXnXcxGdHFWdb745
         ftlA==
X-Gm-Message-State: ABy/qLYWUbxiVc1gv02hG7zHWWjfZRg29gkn03uyTkg5ROUOeDSnOmhs
	Q41a0QAbSB6p+A0YYkEJCdOaRWY=
X-Google-Smtp-Source: APBJJlFxtH8vPv9ha+Sonx0ulVsAGnHbzZ8OIby+hQXM1P4BTVj0mKPOsyjnwy8v/GMkZo+sb4gWKe8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:f696:b0:263:3727:6045 with SMTP id
 cl22-20020a17090af69600b0026337276045mr2142917pjb.4.1688578308779; Wed, 05
 Jul 2023 10:31:48 -0700 (PDT)
Date: Wed, 5 Jul 2023 10:31:47 -0700
In-Reply-To: <20230703181226.19380-15-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230703181226.19380-1-larysa.zaremba@intel.com> <20230703181226.19380-15-larysa.zaremba@intel.com>
Message-ID: <ZKWpA053I0inPs3x@google.com>
Subject: Re: [PATCH bpf-next v2 14/20] selftests/bpf: Allow VLAN packets in xdp_hw_metadata
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

On 07/03, Larysa Zaremba wrote:
> Make VLAN c-tag and s-tag XDP hint testing more convenient
> by not skipping VLAN-ed packets.
> 
> Allow both 802.1ad and 802.1Q headers.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  tools/testing/selftests/bpf/progs/xdp_hw_metadata.c | 10 +++++++++-
>  tools/testing/selftests/bpf/xdp_metadata.h          |  8 ++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> index b2dfd7066c6e..63d7de6c6bbb 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> @@ -26,15 +26,23 @@ int rx(struct xdp_md *ctx)
>  {
>  	void *data, *data_meta, *data_end;
>  	struct ipv6hdr *ip6h = NULL;
> -	struct ethhdr *eth = NULL;
>  	struct udphdr *udp = NULL;
>  	struct iphdr *iph = NULL;
>  	struct xdp_meta *meta;
> +	struct ethhdr *eth;
>  	int err;
>  
>  	data = (void *)(long)ctx->data;
>  	data_end = (void *)(long)ctx->data_end;
>  	eth = data;
> +
> +	if (eth + 1 < data_end && (eth->h_proto == bpf_htons(ETH_P_8021AD) ||
> +				   eth->h_proto == bpf_htons(ETH_P_8021Q)))
> +		eth = (void *)eth + sizeof(struct vlan_hdr);
> +
> +	if (eth + 1 < data_end && eth->h_proto == bpf_htons(ETH_P_8021Q))
> +		eth = (void *)eth + sizeof(struct vlan_hdr);
> +
>  	if (eth + 1 < data_end) {
>  		if (eth->h_proto == bpf_htons(ETH_P_IP)) {
>  			iph = (void *)(eth + 1);
> diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
> index 938a729bd307..6664893c2c77 100644
> --- a/tools/testing/selftests/bpf/xdp_metadata.h
> +++ b/tools/testing/selftests/bpf/xdp_metadata.h
> @@ -9,6 +9,14 @@
>  #define ETH_P_IPV6 0x86DD
>  #endif
>  
> +#ifndef ETH_P_8021Q
> +#define ETH_P_8021Q 0x8100
> +#endif
> +
> +#ifndef ETH_P_8021AD
> +#define ETH_P_8021AD 0x88A8
> +#endif
> +
>  struct xdp_meta {
>  	__u64 rx_timestamp;
>  	__u64 xdp_timestamp;
> -- 
> 2.41.0
> 

