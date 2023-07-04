Return-Path: <bpf+bounces-3963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4610A746F54
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 13:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F431C20446
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3FD5680;
	Tue,  4 Jul 2023 11:03:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DA9539E
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 11:03:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456F8FC
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 04:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688468622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkIQtT7fkEw20o8Q57TiLOVB+SLOAMJBhpTw+/UA+lQ=;
	b=AdqtOcU2nUD35LpJssVYvmVY2VELquomq8VVmcpWgILcSBJGvy9J1EwmBPVatX1DetttHN
	vosUf+FQ0BEuagq6UhQgOCmWVvK7x7pi6Q1xjY8Ta5HIzO4jdpZau3zO+4hJHVFveibn7X
	99uTCmByvbC/vXWQbCEqmX5GwGWJ6ZE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-xrcMLHdpOvqjjfwjwGsN_Q-1; Tue, 04 Jul 2023 07:03:41 -0400
X-MC-Unique: xrcMLHdpOvqjjfwjwGsN_Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31429e93f26so1991312f8f.2
        for <bpf@vger.kernel.org>; Tue, 04 Jul 2023 04:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688468620; x=1691060620;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkIQtT7fkEw20o8Q57TiLOVB+SLOAMJBhpTw+/UA+lQ=;
        b=GCuyeSuOTR8aXPJMqpN5YI7yqGEaJMhIBvAXagY/O7sk7n0zoNMVH6T7x9ECV39iUV
         HQwBJfnlvOxT9TSBmWTOH4o9aZoXLQMcJ0OZLNvdsEEyBwywCDBYnrd+317B3t22+/aF
         IAEBjWDdS+rBJq9Z26/2Lw1vKcDnY+3kJ5N/tcW/6/b34E5g0B9OTH/RAiDBJiRXeutb
         7kpNn+5gRIO6gfKZGw2PXA1u11qQdP99S7tsylj0esf5lI1lEnRDxS5tjES5LYmzYBub
         0vRQrsTYC961uKDyy9dRQ26XXqeQChlutRZ8eEDct5+k2/C8CdMGULTJRenvieznUAbk
         q5sg==
X-Gm-Message-State: ABy/qLYUlAh2XTmlkKtiisiqjYk9PqLMHswuzL189QV5Fv7arnoBkqFm
	H/wpgmFL7JaA11mVmoyhWgqBSFlDReZKCHNC9aKkKkElbP2N+VKPuDYIyLmsagy5kn3HNKqzWrd
	oxDDlio/CaoLf
X-Received: by 2002:adf:dfd2:0:b0:314:1c51:18 with SMTP id q18-20020adfdfd2000000b003141c510018mr10286138wrn.70.1688468620328;
        Tue, 04 Jul 2023 04:03:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEZcKXe8KQolcHrsJt7dZ+zDCkP8OEpkpyB112fx1VeZ9iWuFZ5lBwBA+XrdKJxckcobKwa6A==
X-Received: by 2002:adf:dfd2:0:b0:314:1c51:18 with SMTP id q18-20020adfdfd2000000b003141c510018mr10286126wrn.70.1688468620064;
        Tue, 04 Jul 2023 04:03:40 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d4b4c000000b0031434936f0dsm6274425wrs.68.2023.07.04.04.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 04:03:39 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <8c4da3c2-bc18-5fe9-2189-4b22cc910a25@redhat.com>
Date: Tue, 4 Jul 2023 13:03:37 +0200
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
Subject: Re: [PATCH bpf-next v2 16/20] selftests/bpf: Add flags and new hints
 to xdp_hw_metadata
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-17-larysa.zaremba@intel.com>
In-Reply-To: <20230703181226.19380-17-larysa.zaremba@intel.com>
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
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 613321eb84c1..d234cbcc9103 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -19,6 +19,9 @@
>   #include "xsk.h"
>   
>   #include <error.h>
> +#include <linux/kernel.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
>   #include <linux/errqueue.h>
>   #include <linux/if_link.h>
>   #include <linux/net_tstamp.h>
> @@ -150,21 +153,34 @@ static __u64 gettime(clockid_t clock_id)
>   	return (__u64) t.tv_sec * NANOSEC_PER_SEC + t.tv_nsec;
>   }
>   
> +#define VLAN_PRIO_MASK		GENMASK(15, 13) /* Priority Code Point */
> +#define VLAN_CFI_MASK		GENMASK(12, 12) /* Canonical Format / Drop Eligible Indicator */
> +#define VLAN_VID_MASK		GENMASK(11, 0)	/* VLAN Identifier */
> +static void print_vlan_tag(__u16 tag)
> +{
> +	__u16 vlan_id = FIELD_GET(VLAN_VID_MASK, tag);
> +	__u8 pcp = FIELD_GET(VLAN_PRIO_MASK, tag);
> +	bool cfi = FIELD_GET(VLAN_CFI_MASK, tag);
> +
> +	printf("PCP=%u, CFI=%d, VID=0x%X\n", pcp, cfi, vlan_id);
> +}
> +

Shouldn't we use DEI instead of CFI ?

This is new code, and CFI have been deprecated (it was only relevant for
IEEE 802.5 Token Ring LAN).

--Jesper


