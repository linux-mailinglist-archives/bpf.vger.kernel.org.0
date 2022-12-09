Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B55664815E
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 12:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiLILLy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 06:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLILLx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 06:11:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B252A5E9FB
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 03:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670584263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jE6Vr9F6IeGxtuQrcm6iX33balN6CUxBy/zMSS4pEK4=;
        b=Nd+h8ZjIGTFtfNePHj3h0nDhZBmrQTpOAt9kZCiqf222kgudokBnka62NL96VN60s9VMNd
        VaNIdZBkHUE2X/IbDfzqfeTpA/O7T42RPyOshi5kqlTTAEOOrq0IeIdkYdbt6vBOShU0y8
        iIdmQhmcyMHMa274CSoGLZxr+LJ0hMQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-137-eOePR_SfOpimq4FFfkO2QA-1; Fri, 09 Dec 2022 06:11:02 -0500
X-MC-Unique: eOePR_SfOpimq4FFfkO2QA-1
Received: by mail-ed1-f70.google.com with SMTP id w22-20020a056402269600b0046b00a9ee5fso1184214edd.2
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 03:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jE6Vr9F6IeGxtuQrcm6iX33balN6CUxBy/zMSS4pEK4=;
        b=y6B4gqpgPxpNSCqTGJFqoZUvSuCSM7hbcw8eGt1AS1YFtS7HrEob4z5CLITqNer//8
         AGC4A/DoKkAotTs1KjdOKikBqQMH9dLZ+q+Pmm2kF3MA4J3GNTBfhbcCLGXIvmXcDRFi
         vIv2pdB8bOnxsA52sbFbuzlOG1cGmCi5mhl7lb9Lip89ciaoFL1KEkuJDw3DNCc14E/8
         7dTCYPhHbKvVNic5+NKe3d/rervOHI+30DdPm6XwpR5ryN4yIFH359VNL8zHR0mzvauU
         j8A4ovg4hAi2gJ79O2oQwASli2HrmJnCKi5s25127tsR6cYuXq2c7q1Dvmf/ScQv1409
         V+0w==
X-Gm-Message-State: ANoB5pmkZE6F8nO3r8VjUDxnJoo+Sqrnx2haIHGZPMyUFHvNreyRwV3r
        q8Md/YUqwmTKECioDPoviQ4RdMXPqepqmCe/X7nNubCUk4Lj/ENEvXEEoAI/tvugngSrzYg6Dq/
        9YjyLiPP6JsX3
X-Received: by 2002:a17:906:a0d4:b0:7ad:9f03:b330 with SMTP id bh20-20020a170906a0d400b007ad9f03b330mr4610190ejb.62.1670584261395;
        Fri, 09 Dec 2022 03:11:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4ElsBLxzKJG5vL8JnhEQ9VfVgdKAWRF7Ozd6jNwS2dlIKePCJQ2Hw+qwhb3AfXEVccBU1Fkw==
X-Received: by 2002:a17:906:a0d4:b0:7ad:9f03:b330 with SMTP id bh20-20020a170906a0d400b007ad9f03b330mr4610161ejb.62.1670584261096;
        Fri, 09 Dec 2022 03:11:01 -0800 (PST)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id d10-20020a50f68a000000b0045b3853c4b7sm515238edn.51.2022.12.09.03.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 03:11:00 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <f2c89c57-c377-2f8e-fb4d-b047e58d3d38@redhat.com>
Date:   Fri, 9 Dec 2022 12:10:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Cc:     brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 03/12] bpf: XDP metadata RX kfuncs
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20221206024554.3826186-1-sdf@google.com>
 <20221206024554.3826186-4-sdf@google.com>
In-Reply-To: <20221206024554.3826186-4-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 06/12/2022 03.45, Stanislav Fomichev wrote:
> There is an ndo handler per kfunc, the verifier replaces a call to the
> generic kfunc with a call to the per-device one.
> 
> For XDP, we define a new kfunc set (xdp_metadata_kfunc_ids) which
> implements all possible metatada kfuncs. Not all devices have to
> implement them. If kfunc is not supported by the target device,
> the default implementation is called instead.
> 
> Upon loading, if BPF_F_XDP_HAS_METADATA is passed via prog_flags,
> we treat prog_index as target device for kfunc resolution.
> 

[...cut...]
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 5aa35c58c342..2eabb9157767 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -74,6 +74,7 @@ struct udp_tunnel_nic_info;
>   struct udp_tunnel_nic;
>   struct bpf_prog;
>   struct xdp_buff;
> +struct xdp_md;
>   
>   void synchronize_net(void);
>   void netdev_set_default_ethtool_ops(struct net_device *dev,
> @@ -1611,6 +1612,10 @@ struct net_device_ops {
>   	ktime_t			(*ndo_get_tstamp)(struct net_device *dev,
>   						  const struct skb_shared_hwtstamps *hwtstamps,
>   						  bool cycles);
> +	bool			(*ndo_xdp_rx_timestamp_supported)(const struct xdp_md *ctx);
> +	u64			(*ndo_xdp_rx_timestamp)(const struct xdp_md *ctx);
> +	bool			(*ndo_xdp_rx_hash_supported)(const struct xdp_md *ctx);
> +	u32			(*ndo_xdp_rx_hash)(const struct xdp_md *ctx);
>   };
>   

Would it make sense to add a 'flags' parameter to ndo_xdp_rx_timestamp
and ndo_xdp_rx_hash ?

E.g. we could have a "STORE" flag that asks the kernel to store this
information for later. This will be helpful for both the SKB and
redirect use-cases.
For redirect e.g into a veth, then BPF-prog can use the same function
bpf_xdp_metadata_rx_hash() to receive the RX-hash, as it can obtain the
"stored" value (from the BPF-prog that did the redirect).

(p.s. Hopefully a const 'flags' variable can be optimized when unrolling
to eliminate store instructions when flags==0)

>   /**
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 55dbc68bfffc..c24aba5c363b 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -409,4 +409,33 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>   
>   #define DEV_MAP_BULK_SIZE XDP_BULK_QUEUE_SIZE
>   
> +#define XDP_METADATA_KFUNC_xxx	\
> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_TIMESTAMP_SUPPORTED, \
> +			   bpf_xdp_metadata_rx_timestamp_supported) \
> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_TIMESTAMP, \
> +			   bpf_xdp_metadata_rx_timestamp) \
> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH_SUPPORTED, \
> +			   bpf_xdp_metadata_rx_hash_supported) \
> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
> +			   bpf_xdp_metadata_rx_hash) \
> +
> +enum {
> +#define XDP_METADATA_KFUNC(name, str) name,
> +XDP_METADATA_KFUNC_xxx
> +#undef XDP_METADATA_KFUNC
> +MAX_XDP_METADATA_KFUNC,
> +};
> +
> +#ifdef CONFIG_NET
> +u32 xdp_metadata_kfunc_id(int id);
> +#else
> +static inline u32 xdp_metadata_kfunc_id(int id) { return 0; }
> +#endif
> +
> +struct xdp_md;
> +bool bpf_xdp_metadata_rx_timestamp_supported(const struct xdp_md *ctx);
> +u64 bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx);
> +bool bpf_xdp_metadata_rx_hash_supported(const struct xdp_md *ctx);
> +u32 bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx);
> +

