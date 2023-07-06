Return-Path: <bpf+bounces-4216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4D4749908
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 12:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8AD1C20C87
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC038481;
	Thu,  6 Jul 2023 10:10:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C079FD
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 10:10:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7114F19AE
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688638205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkIoziuUXyJjhTsSanYD9B7TFUdOtgzUVXsA3+suWsM=;
	b=NtiQ8yykGq4B/Puh6EPv3EHHf0FAEO0HxPHRCOnjQpmA1imrYdeOkyoWpQznhjXUQuR4fl
	l1R8sa+S4pqj2qzb0N0pPj7J7MTaC1UWeyaC3U8BefXUiRk/VtuviiTFCVMTlB6QiLRSzY
	E6cb0lfrJMlS9onF4pBQq6Ng0zL4LKY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-NQYFdT_BNqSFRKuAkhPwxA-1; Thu, 06 Jul 2023 06:10:04 -0400
X-MC-Unique: NQYFdT_BNqSFRKuAkhPwxA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6fdb7eeafso5050821fa.2
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 03:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688638203; x=1691230203;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkIoziuUXyJjhTsSanYD9B7TFUdOtgzUVXsA3+suWsM=;
        b=HAkhSN5OATsmx6mOmEl7A5D7x6PnVXkxMLPnmogRFhvW/+nh6X/bDOkPkPRg7OXrwa
         6Jp8rF+V6BRsKBuUAiRi9LJHmv0xCFx7YkmaxxQPcHgBXbKt6M7IgZjA/nwVs/BAvH+7
         LoBFNry/d4vagks92jeNDkSxS4azY4g3nqDC73wJwrng3TpLUNz4PsXhmteh/PtZfcUL
         uadRdgo/XpeTKd1YwgjXwQOgxq8SE82YBirznHwOWBwvkcWNC2OlEtG5tuJXbR6s7LIQ
         ps8R5gTzzHhsURtD4vhwZcgKlVyudcDa3/mWtJ6zVgQgPY1HJih4ZVG0wH10n7K2moF2
         lMWQ==
X-Gm-Message-State: ABy/qLaTYRwmLHZCu0jR7RilhS83KLWab/YXq/UcuxSC839w24Esv2om
	ktvsnDQFWeQgFRis0CFdt87NP2SUgXG9L3q4SydXfisVFCp7TcNp7pt9efAUwXvL6XrQi+qpYb9
	NyhmUkxJj4Bec
X-Received: by 2002:a05:651c:120e:b0:2b6:effd:9a3b with SMTP id i14-20020a05651c120e00b002b6effd9a3bmr978015lja.24.1688638202938;
        Thu, 06 Jul 2023 03:10:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHe4yVD75ik3R3J7rIfPtRMnqfubpoVlRY8rITYFKJX2pMSqwZAp79fpCH+89ANVet1aTax5Q==
X-Received: by 2002:a05:651c:120e:b0:2b6:effd:9a3b with SMTP id i14-20020a05651c120e00b002b6effd9a3bmr977990lja.24.1688638202608;
        Thu, 06 Jul 2023 03:10:02 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709063b0300b009786ae9ed50sm593320ejf.194.2023.07.06.03.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 03:10:02 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <80792adb-ca6c-3870-8fdd-a7e814830d1f@redhat.com>
Date: Thu, 6 Jul 2023 12:10:01 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, David Ahern <dsahern@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>,
 Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 19/20] selftests/bpf: Check VLAN tag and proto
 in xdp_metadata
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-20-larysa.zaremba@intel.com>
In-Reply-To: <20230703181226.19380-20-larysa.zaremba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 03/07/2023 20.12, Larysa Zaremba wrote:
> Verify, whether VLAN tag and proto are set correctly.
> 
> To simulate "stripped" VLAN tag on veth, send test packet from VLAN
> interface.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>   .../selftests/bpf/prog_tests/xdp_metadata.c   | 21 +++++++++++++++++--
>   .../selftests/bpf/progs/xdp_metadata.c        |  4 ++++
>   2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 53b32a641e8e..50ac9f570bc5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -38,6 +38,13 @@
>   #define TX_MAC "00:00:00:00:00:01"
>   #define RX_MAC "00:00:00:00:00:02"
>   
> +#define VLAN_ID 59
> +#define VLAN_ID_STR "59"
> +#define VLAN_PROTO "802.1Q"
> +#define VLAN_PID htons(ETH_P_8021Q)
> +#define TX_NAME_VLAN TX_NAME "." VLAN_ID_STR
> +#define RX_NAME_VLAN RX_NAME "." VLAN_ID_STR
> +
>   #define XDP_RSS_TYPE_L4 BIT(3)
>   
>   struct xsk {
> @@ -215,6 +222,12 @@ static int verify_xsk_metadata(struct xsk *xsk)
>   	if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
>   		return -1;
>   
> +	if (!ASSERT_EQ(meta->rx_vlan_tag, VLAN_ID, "rx_vlan_tag"))
> +		return -1;

In other examples you are masking meta->rx_vlan_tag with VLAN_VID_MASK
(12 lower bits 0x0fff) to extract the VLAN_ID.  It would make the
selftest more correct, robust and pedagogical to also mask out the ID here.


> +
> +	if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
> +		return -1;
> +
>   	xsk_ring_cons__release(&xsk->rx, 1);
>   	refill_rx(xsk, comp_addr);
>   
> @@ -253,10 +266,14 @@ void test_xdp_metadata(void)
>   
>   	SYS(out, "ip link set dev " TX_NAME " address " TX_MAC);
>   	SYS(out, "ip link set dev " TX_NAME " up");
> -	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
> +
> +	SYS(out, "ip link add link " TX_NAME " " TX_NAME_VLAN
> +		 " type vlan proto " VLAN_PROTO " id " VLAN_ID_STR);
> +	SYS(out, "ip link set dev " TX_NAME_VLAN " up");
> +	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME_VLAN);
>   
>   	/* Avoid ARP calls */
> -	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME);
> +	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME_VLAN);
>   
>   	set_netns(rx_netns);
>   	SYS(out, "ip link set dev " RX_NAME " address " RX_MAC);
> diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> index d151d406a123..382984a5d1c9 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> @@ -23,6 +23,9 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
>   					 __u64 *timestamp) __ksym;
>   extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
>   				    enum xdp_rss_hash_type *rss_type) __ksym;
> +extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
> +					__u16 *vlan_tag,
> +					__be16 *vlan_proto) __ksym;
>   
>   SEC("xdp")
>   int rx(struct xdp_md *ctx)
> @@ -57,6 +60,7 @@ int rx(struct xdp_md *ctx)
>   		meta->rx_timestamp = 1;
>   
>   	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
> +	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tag, &meta->rx_vlan_proto);
>   
>   	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
>   }


