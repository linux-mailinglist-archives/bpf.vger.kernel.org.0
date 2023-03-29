Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAEA6CD92D
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjC2MN5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 08:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2MN4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 08:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A2219A6
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 05:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680091992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfqSumULYaFAsKVypJ7j6ZB0kW2MYs15+sCfzueyCec=;
        b=cDrUyUPk5QJMnEcGUO4r0xdEtXU8lM9gFck1ywa52FbqRKukLGsw9F15Pe3b/NxaclBk1w
        gE1yVV3sDZvjFPOK2UkjbcX4FZgy4KV34D5PSheG0rP3kH2Tf2c8oCxol7yx8YKHKWz0ct
        YNK9es59dWC7Lj/Pny4tQ+NT+oF4FIs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-MFbtTpMsMqapHWy6NBpPZw-1; Wed, 29 Mar 2023 08:13:10 -0400
X-MC-Unique: MFbtTpMsMqapHWy6NBpPZw-1
Received: by mail-ed1-f72.google.com with SMTP id fi8-20020a056402550800b004a26cc7f6cbso22048943edb.4
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 05:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680091989;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfqSumULYaFAsKVypJ7j6ZB0kW2MYs15+sCfzueyCec=;
        b=pqtW7Rqrn7GWyFd27EE+HQ59SHl/qBQOCRTQJ1ssLXEm0DITXqstfjV+Gqb14RYGha
         pr6PjW8tNq+wAitojzGp2C2R1aLV+oupdisMgSeu+We17JA3/hb3c0XyIahXLZB74YTz
         gVGngKj468Y/viQAK5PGcHWZ1hFrMPkyYWc6SWjOj5Ac6ukk4/GLIKTxIxdWYzZi/1AS
         H7y25cWCqNBtZQCL6Ow+f0oQdESS1yzOE2Yw9QJfosPYVJWDW/4F1sxpb1tvFVE0BSqY
         WmfJZ917VQwvXPvRSLCa4kbL0TpWuKn2bT9tLEO7abW0FUIpXMRaeBj5aHj9dOex4l3k
         o3+w==
X-Gm-Message-State: AAQBX9caW6u9H1wmqY2eqlGZP/AuiBX6ARj4SNrgI0BaMzIqR/JfDyah
        /jxSSQtXvEnOCcQL4liYMz8cZ9N3Ooe3/Fqax3uzkmatJp4NYywjoPbYkQPn+CGVnvUprjr7z11
        MWqpzcTUeDVx6
X-Received: by 2002:aa7:d9c7:0:b0:4fc:6a39:d2f2 with SMTP id v7-20020aa7d9c7000000b004fc6a39d2f2mr18928025eds.18.1680091989737;
        Wed, 29 Mar 2023 05:13:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZXEF/duXvlZ3J7zw4ob7Kfy/Cj7JBCPgsJbNT/6kta1V2jSXhTtIA1gCxM40SUZot2im2Vdg==
X-Received: by 2002:aa7:d9c7:0:b0:4fc:6a39:d2f2 with SMTP id v7-20020aa7d9c7000000b004fc6a39d2f2mr18928010eds.18.1680091989451;
        Wed, 29 Mar 2023 05:13:09 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id i23-20020a508717000000b004af6c5f1805sm16991525edb.52.2023.03.29.05.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 05:13:08 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <00b2e31a-4ec6-12fa-a428-38282cafbc58@redhat.com>
Date:   Wed, 29 Mar 2023 14:13:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net
Subject: Re: [xdp-hints] Re: [PATCH bpf RFC 1/4] xdp: rss hash types
 representation
Content-Language: en-US
To:     Edward Cree <ecree.xilinx@gmail.com>, bpf@vger.kernel.org
References: <168003451121.3027256.13000250073816770554.stgit@firesoul>
 <168003455815.3027256.7575362149566382055.stgit@firesoul>
 <39543d22-4e71-9696-17f8-5ae22728aa25@gmail.com>
In-Reply-To: <39543d22-4e71-9696-17f8-5ae22728aa25@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 29/03/2023 10.10, Edward Cree wrote:
> On 28/03/2023 21:15, Jesper Dangaard Brouer wrote:
>> Hardware RSS types are differently encoded for each hardware NIC. Most
>> hardware represent RSS hash type as a number. Determining L3 vs L4 often
>> requires a mapping table as there often isn't a pattern or sorting
>> according to ISO layer.
>>
>> The patch introduce a XDP RSS hash type (xdp_rss_hash_type) that can both
>> be seen as a number that is ordered according by ISO layer, and can be bit
>> masked to separate IPv4 and IPv6 types for L4 protocols. Room is available
>> for extending later while keeping these properties. This maps and unifies
>> difference to hardware specific hashes.
> 
> Would it be better to make use of the ETHTOOL_GRXFH defines (stuff
>   like UDP_V6_FLOW, RXH_L4_B_0_1 etc.)?  Seems like that could allow
>   for some code reuse in drivers.

Thanks for the point to ethtool defines.
I can see that these are used when configuring the hardware RSS hash the
NIC should calculate.

From: include/uapi/linux/ethtool.h
  /* L3-L4 network traffic flow hash options */
  #define	RXH_L2DA	(1 << 1)
  #define	RXH_VLAN	(1 << 2)
  #define	RXH_L3_PROTO	(1 << 3)
  #define	RXH_IP_SRC	(1 << 4)
  #define	RXH_IP_DST	(1 << 5)
  #define	RXH_L4_B_0_1	(1 << 6) /* src port in case of TCP/UDP/SCTP */
  #define	RXH_L4_B_2_3	(1 << 7) /* dst port in case of TCP/UDP/SCTP */
  #define	RXH_DISCARD	(1 << 31)

I notice that I forgot about VLAN tag (RXH_VLAN) also can be part of the
hash calc in my proposed design.

It is interpreting to follow the possible ethool cmd->flow_type's:

  /* L2-L4 network traffic flow types */
  #define	TCP_V4_FLOW	0x01	/* hash or spec (tcp_ip4_spec) */
  #define	UDP_V4_FLOW	0x02	/* hash or spec (udp_ip4_spec) */
  #define	SCTP_V4_FLOW	0x03	/* hash or spec (sctp_ip4_spec) */
  #define	AH_ESP_V4_FLOW	0x04	/* hash only */
  #define	TCP_V6_FLOW	0x05	/* hash or spec (tcp_ip6_spec; nfc only) */
  #define	UDP_V6_FLOW	0x06	/* hash or spec (udp_ip6_spec; nfc only) */
  #define	SCTP_V6_FLOW	0x07	/* hash or spec (sctp_ip6_spec; nfc only) */
  #define	AH_ESP_V6_FLOW	0x08	/* hash only */
  #define	AH_V4_FLOW	0x09	/* hash or spec (ah_ip4_spec) */
  #define	ESP_V4_FLOW	0x0a	/* hash or spec (esp_ip4_spec) */
  #define	AH_V6_FLOW	0x0b	/* hash or spec (ah_ip6_spec; nfc only) */
  #define	ESP_V6_FLOW	0x0c	/* hash or spec (esp_ip6_spec; nfc only) */
  #define	IPV4_USER_FLOW	0x0d	/* spec only (usr_ip4_spec) */
  #define	IP_USER_FLOW	IPV4_USER_FLOW
  #define	IPV6_USER_FLOW	0x0e	/* spec only (usr_ip6_spec; nfc only) */
  #define	IPV4_FLOW	0x10	/* hash only */
  #define	IPV6_FLOW	0x11	/* hash only */
  #define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
  /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
  #define	FLOW_EXT	0x80000000
  #define	FLOW_MAC_EXT	0x40000000
  /* Flag to enable RSS spreading of traffic matching rule (nfc only) */
  #define	FLOW_RSS	0x20000000

It is clear that we need to support TCP+UDP+SCTP.

I assume the IPSEC is AH (Authentication Header) and ESP ( Encapsulating 
Security Payload.  Thus, (like I found with mlx5) we also need IPSET and 
maybe a bit (or number) for each protocol AH or ESP.

Both ah_ip4_spec and esp_ip4_spec points to ethtool.h struct:

/**
  * struct ethtool_ah_espip4_spec - flow specification for IPsec/IPv4
  * @ip4src: Source host
  * @ip4dst: Destination host
  * @spi: Security parameters index
  * @tos: Type-of-service
  *
  * This can be used to specify an IPsec transport or tunnel over IPv4.
  */
  struct ethtool_ah_espip4_spec {
	__be32	ip4src;
	__be32	ip4dst;
	__be32	spi;
	__u8    tos;
  };

Which confirms that it is the SPI that is the extra part of the hash.

--Jesper

