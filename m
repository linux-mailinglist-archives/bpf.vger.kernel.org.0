Return-Path: <bpf+bounces-2500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F8972E1E3
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 13:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4F71C20937
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 11:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DBB2A9D1;
	Tue, 13 Jun 2023 11:44:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7801B290F9
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 11:44:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0022B135
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 04:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686656668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muOrkQ0RbXdbdOjxOGOSxQoru50xmWZYfqIPS4rtlo0=;
	b=YHgjQ2rVGf0UrPgSMszV9wo25XZI6ZSKXMyq47wWV47s7NyXthZdcfSiCVulwjk0ID4qpR
	fO2yn94oOp4WrJKLliJUH0JJEmASl88N02Ya8vi7ntId9DZ/YkkaJOBTxUimOzDrvPG0pM
	IWRdG5InnbtoYVsy5u+oDZsaGdQy7rI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-aOZq1PcVMfGj5B-M-iU7ig-1; Tue, 13 Jun 2023 07:44:27 -0400
X-MC-Unique: aOZq1PcVMfGj5B-M-iU7ig-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9750bb0695dso773319366b.0
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 04:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686656666; x=1689248666;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muOrkQ0RbXdbdOjxOGOSxQoru50xmWZYfqIPS4rtlo0=;
        b=OK4wRL4Wgsa/MFJSVJS9oEI7BjoQVeBXs+YoHTDdr1xiASFvxkAIvAxM2tnSaZG/aA
         6mVys7CySW+1RpTAKZLiwQVGxA5PcoIKPhVKU/JZFlJfrrzVd15WOpMIBiL9pA0a58bX
         1lybM2U4XciJyoXP0svuNUfG7+3WjWa8Z1puiMp2F3D/xFKBtfkcV3I/WZwt11q/WLO7
         jzo47s/GsyJu7OOFG4T3AmM96TQliRFh0CuEjOyxNRI7QBsNwlOboUyc8ttwvuBAL2NJ
         oLvF29kF0NRyKvJ2fe6mcfrWK7MKlZZNvyILHyR/zFUG//xEMtJPBRRUnlrZcIeLMoVy
         PpDw==
X-Gm-Message-State: AC+VfDz54tVOGqXbbN3yrCjRctHGAuPyQEznli9WIc5wv6VAKxUA3Ja6
	k734yzcQIITQ6zrchLuLHagE2/OgjsmwddqRsxnTtSb1TA8nqfsBlRgjRjSSrjbjaNzmdv70qcP
	LSh19brNU7QNj
X-Received: by 2002:a17:907:96a0:b0:982:4b35:c0b6 with SMTP id hd32-20020a17090796a000b009824b35c0b6mr272170ejc.1.1686656666052;
        Tue, 13 Jun 2023 04:44:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48aHOL0dPduaBBaezBCe329V35J0S/dnTzj9AOPQevY5O1CRbheFRzpaNtgNnJeKdlw1uEmA==
X-Received: by 2002:a17:907:96a0:b0:982:4b35:c0b6 with SMTP id hd32-20020a17090796a000b009824b35c0b6mr272152ejc.1.1686656665794;
        Tue, 13 Jun 2023 04:44:25 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090634c700b00965d4b2bd4csm6655199ejb.141.2023.06.13.04.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 04:44:25 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <42972a52-81c0-1abb-68b8-b7609c8b2a5b@redhat.com>
Date: Tue, 13 Jun 2023 13:44:23 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] samples/bpf: Remove unneeded variable
Content-Language: en-US
To: baomingtong001@208suo.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
References: <20230613091309.40755-1-luojianhong@cdjrlc.com>
 <cf01ff5fafd7d95c604e6413fb590e65@208suo.com>
In-Reply-To: <cf01ff5fafd7d95c604e6413fb590e65@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 13/06/2023 11.18, baomingtong001@208suo.com wrote:
> Fix the following coccicheck warning:
> 
> samples/bpf/xdp1_kern.c:50: Unneeded variable: "rc".
> 
> Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
> ---
>   samples/bpf/xdp1_kern.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/samples/bpf/xdp1_kern.c b/samples/bpf/xdp1_kern.c
> index d91f27cbcfa9..d426df4a9d6b 100644
> --- a/samples/bpf/xdp1_kern.c
> +++ b/samples/bpf/xdp1_kern.c
> @@ -47,18 +47,17 @@ int xdp_prog1(struct xdp_md *ctx)
>       void *data_end = &pkt[XDPBUFSIZE-1];
>       void *data = pkt;
>       struct ethhdr *eth = data;
> -    int rc = XDP_DROP;
>       long *value;
>       u16 h_proto;
>       u64 nh_off;
>       u32 ipproto;
> 
>       if (bpf_xdp_load_bytes(ctx, 0, pkt, sizeof(pkt)))
> -        return rc;
> +        return XDP_DROP;

IMHO for these error cases, we should return XDP_ABORTED instead.
This will make is easier to debug, e.g. with xdpdump[1] or xdp-monitor[2].

Reminder that drivers (usually) have a tracepoint for XDP_ABORTED
(code see trace_xdp_exception).

  [1] https://github.com/xdp-project/xdp-tools/tree/master/xdp-dump
  [2] https://github.com/xdp-project/xdp-tools/tree/master/xdp-monitor

> 
>       nh_off = sizeof(*eth);
>       if (data + nh_off > data_end)
> -        return rc;
> +        return XDP_DROP;
> 
>       h_proto = eth->h_proto;
> 
> @@ -69,7 +68,7 @@ int xdp_prog1(struct xdp_md *ctx)
>           vhdr = data + nh_off;
>           nh_off += sizeof(struct vlan_hdr);
>           if (data + nh_off > data_end)
> -            return rc;
> +            return XDP_DROP;

Use XDP_ABORTED

>           h_proto = vhdr->h_vlan_encapsulated_proto;
>       }
>       /* Handle double VLAN tagged packet */
> @@ -79,7 +78,7 @@ int xdp_prog1(struct xdp_md *ctx)
>           vhdr = data + nh_off;
>           nh_off += sizeof(struct vlan_hdr);
>           if (data + nh_off > data_end)
> -            return rc;
> +            return XDP_DROP;

Use XDP_ABORTED

>           h_proto = vhdr->h_vlan_encapsulated_proto;
>       }
> 
> @@ -94,7 +93,7 @@ int xdp_prog1(struct xdp_md *ctx)
>       if (value)
>           *value += 1;
> 
> -    return rc;
> +    return XDP_DROP;

This is correct.  Here use XDP_DROP.

>   }
> 
>   char _license[] SEC("license") = "GPL";


