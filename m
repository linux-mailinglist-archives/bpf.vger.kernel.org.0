Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8C862F6CB
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 15:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbiKROGl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 09:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiKROGk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 09:06:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F6A5DBBB
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 06:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668780337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLKr1m8jjPxQRRjh36786KjP2Xs3iTgpbpgt4JjXzlI=;
        b=LDrrsiNaMIkz681LqvUopTo3g84sPQpDLr5iNkLvHkpU87deII+xb06JlaHb/z3Wxx6jfi
        GE4iMqA7r1DejGBW3EpYBBUvsVZ8JHCtssvP9i8HTOhMPdoi7NarnfyhWLIYN6Wkwxlxgf
        yc2fNASkyLURDO/4XpZUQoaGOYAIK+s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-ru2SW-dFOSOtJ91UB_hfpA-1; Fri, 18 Nov 2022 09:05:36 -0500
X-MC-Unique: ru2SW-dFOSOtJ91UB_hfpA-1
Received: by mail-ed1-f70.google.com with SMTP id m13-20020a056402510d00b0046913fa9291so993988edd.6
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 06:05:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLKr1m8jjPxQRRjh36786KjP2Xs3iTgpbpgt4JjXzlI=;
        b=2ddcSanJfrTMZGIKrS0169aGx+/Agn1LYzTZLqAVtp3aGrQOjzDBSVlHl1A5BUIImC
         4i4E7wkaZadbMmAGwDHQUS+2WrDaMi8yx60z3lRB8oowOsxoJAutpybq5KL40KmjDUH2
         5MyMS6F0SgfoztpZoMot/AnwfFoPB80x714x0rcKkD7IaDWtEE/zR+duTpi6YQbqo60u
         PAL+ggNzQHnzHXpJO2gTP79MjlcJuXpn4yXiLFFh+DSxgw4JqS9+sgKvG9Sjd4QNGmBJ
         Bb3xNKM5h7A9AhGPx0dcesi8pyPWO9nhSi5/F3ViNJu8Vi1+4rRWODv/ZLam7CC3QK9t
         6pTA==
X-Gm-Message-State: ANoB5pkADbpyfTc4kaEYSbXvijch5QoWlCpod+aKgppMnQd0Bd6STRB1
        Wdb/sYoY3F5JncfvkGLmT/taTg4W1rIQ5W1RVBezL4ntt0mtj1gKNQOyReU1S7ZBN13eyuJnndB
        MY1PIK3KAtGv3
X-Received: by 2002:aa7:dbd9:0:b0:461:e8c4:d21f with SMTP id v25-20020aa7dbd9000000b00461e8c4d21fmr6377561edt.186.1668780333702;
        Fri, 18 Nov 2022 06:05:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf63VFqZxyKNew0KnlumR1thzphh/OAwj5NqyXGnv9hqfXp7EU9ZcroxigCIYHJsyFM4u5hwzg==
X-Received: by 2002:aa7:dbd9:0:b0:461:e8c4:d21f with SMTP id v25-20020aa7dbd9000000b00461e8c4d21fmr6377526edt.186.1668780333385;
        Fri, 18 Nov 2022 06:05:33 -0800 (PST)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id kx10-20020a170907774a00b0078ba492db81sm1729506ejc.9.2022.11.18.06.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:05:32 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <e26f75dd-f52f-a69b-6754-54e1fe044a42@redhat.com>
Date:   Fri, 18 Nov 2022 15:05:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
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
Subject: Re: [PATCH bpf-next 06/11] xdp: Carry over xdp metadata into skb
 context
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20221115030210.3159213-1-sdf@google.com>
 <20221115030210.3159213-7-sdf@google.com>
In-Reply-To: <20221115030210.3159213-7-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 15/11/2022 04.02, Stanislav Fomichev wrote:
> Implement new bpf_xdp_metadata_export_to_skb kfunc which
> prepares compatible xdp metadata for kernel consumption.
> This kfunc should be called prior to bpf_redirect
> or when XDP_PASS'ing the frame into the kernel (note, the drivers
> have to be updated to enable consuming XDP_PASS'ed metadata).
> 
> veth driver is amended to consume this metadata when converting to skb.
> 
> Internally, XDP_FLAGS_HAS_SKB_METADATA flag is used to indicate
> whether the frame has skb metadata. The metadata is currently
> stored prior to xdp->data_meta. bpf_xdp_adjust_meta refuses
> to work after a call to bpf_xdp_metadata_export_to_skb (can lift
> this requirement later on if needed, we'd have to memmove
> xdp_skb_metadata).
> 

I think it is wrong to refuses using metadata area (bpf_xdp_adjust_meta)
when the function bpf_xdp_metadata_export_to_skb() have been called.
In my design they were suppose to co-exist, and BPF-prog was expected to
access this directly themselves.

With this current design, I think it is better to place the struct
xdp_skb_metadata (maybe call it xdp_skb_hints) after xdp_frame (in the
top of the frame).  This way we don't conflict with metadata and
headroom use-cases.  Plus, verifier will keep BPF-prog from accessing
this area directly (which seems to be one of the new design goals).

By placing it after xdp_frame, I think it would be possible to let veth 
unroll functions seamlessly access this info for XDP_REDIRECT'ed 
xdp_frame's.

WDYT?

--Jesper

