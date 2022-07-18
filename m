Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A05A577F9F
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 12:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiGRK1z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 06:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiGRK1y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 06:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E99241CFD0
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658140070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zTvLGom1z3KDpMzi4xf3TL6/9N/66sWg3tYC4NjdkXY=;
        b=SMIY7h2ie6kyNkiQMxWrGomUPO0xuUJwRWEmmsI8ndJe6W4etuuhn32rt07lbW8RKAHG0U
        KfJW++i7qLIQf47rl+RCxm1QMy1ZPXkWs3rm3aYxAA90XIoE1ZAogn0Nw8NRf+aO7fS5sL
        /zYKsHuWIiK9+8mVoqoR+bzXpZfsBqY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-woiksXRuPgWz6Cku_jml4A-1; Mon, 18 Jul 2022 06:27:49 -0400
X-MC-Unique: woiksXRuPgWz6Cku_jml4A-1
Received: by mail-wm1-f69.google.com with SMTP id r10-20020a05600c284a00b003a2ff6c9d6aso7308157wmb.4
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 03:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=zTvLGom1z3KDpMzi4xf3TL6/9N/66sWg3tYC4NjdkXY=;
        b=MsR9N79kn1wXsDwRumfbsF8mAk9ijcUHJMTRBf/GPsyU+CeR+Mld78KNN0/I33V6mv
         ib5VVtDrUbbaF0NAFJmsDyvj7QTMW75nZpPgNufz+a2Tzenwl/vQgPpQFd76p+o8CWoO
         wc1mTsPrFHvLqbI/YpJdBrNWxGpLcqxLEuBnGF022hPetGD3k/Ez9SNEjFussOEM42sl
         iRCfA7kzRRVs9yfJONZHF2ytWAL3QEJu+S3G9CimFAkBFMRc2SluOBc+FN218VsZTq6e
         IT2lXd02jCc3u0uDgyodqYcUsNGSWE0T4fyRDDoUR00KPODpdfL2Fw3S2ChWdU+Bqvj8
         81Nw==
X-Gm-Message-State: AJIora9vsLIQP3ZoLMpw8yOiDxZeLrQzxT6upUWNJu1x+PLD0KAKctzZ
        aSaCeuC0OxRk0s0XEtd4Y7oX5G5ME0BXMzzvzR8v1Kg1Ze5baBqTFd7y9zMf05RNyLpZiLCTdW6
        ksWFRjkAsuN8Q
X-Received: by 2002:a05:600c:1551:b0:3a2:f373:c97b with SMTP id f17-20020a05600c155100b003a2f373c97bmr25145877wmg.16.1658140068161;
        Mon, 18 Jul 2022 03:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vqAP0kFoNTIJAjocumBwoLvBB1c7xm9Qj+BKtDDdBvAAP2MWb7Z+60BO6VXKaQJUECqYutHw==
X-Received: by 2002:a05:600c:1551:b0:3a2:f373:c97b with SMTP id f17-20020a05600c155100b003a2f373c97bmr25145864wmg.16.1658140067987;
        Mon, 18 Jul 2022 03:27:47 -0700 (PDT)
Received: from ?IPV6:2a01:b340:64:d3ca:188c:3c48:3209:7784? ([2a01:b340:64:d3ca:188c:3c48:3209:7784])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c1d1300b003a300452f7esm14307439wms.28.2022.07.18.03.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 03:27:47 -0700 (PDT)
Message-ID: <28345284-2a75-f9d5-284b-35189afe301e@redhat.com>
Date:   Mon, 18 Jul 2022 11:27:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
Subject: Re: [PATCH RFC bpf-next 7/9] i40e: add XDP-hints handling
Content-Language: en-US
From:   Maryam Tahhan <mtahhan@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org
Cc:     xdp-hints@xdp-project.net
References: <165643378969.449467.13237011812569188299.stgit@firesoul>
 <165643386896.449467.16847946958931423319.stgit@firesoul>
 <431a0822-5aa7-b5e0-2389-bb8c66f42e8f@redhat.com>
In-Reply-To: <431a0822-5aa7-b5e0-2389-bb8c66f42e8f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 18/07/2022 10:38, Maryam Tahhan wrote:
> On 28/06/2022 17:31, Jesper Dangaard Brouer wrote:
> 
> <snip>
> 
>> +
>> +static inline void i40e_process_xdp_hints(struct i40e_ring *rx_ring,
>> +                      union i40e_rx_desc *rx_desc,
>> +                      struct xdp_buff *xdp,
>> +                      u64 qword)
>> +{
>> +    u32 rx_status = (qword & I40E_RXD_QW1_STATUS_MASK) >>
>> +            I40E_RXD_QW1_STATUS_SHIFT;
>> +    u32 tsynvalid = rx_status & I40E_RXD_QW1_STATUS_TSYNVALID_MASK;
>> +    u32 tsyn = (rx_status & I40E_RXD_QW1_STATUS_TSYNINDX_MASK) >>
>> +           I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT;
>> +    u64 tsyn_ts;
>> +
>> +    struct i40e_rx_ptype_decoded ptype;
>> +    struct xdp_hints_i40e *xdp_hints;
>> +    struct xdp_hints_common *common;
>> +    u32 btf_id = btf_id_xdp_hints_i40e;
>> +    u32 btf_sz = sizeof(*xdp_hints);
>> +    u32 f1 = 0, f2, f3, f4, f5 = 0;
>> +    u8 rx_ptype;
>> +
>> +    if (!(rx_ring->netdev->features & NETIF_F_XDP_HINTS))
>> +        return;
>> +
>> +    /* Driver have xdp headroom when using build_skb */
>> +    if (unlikely(!ring_uses_build_skb(rx_ring)))
>> +        return;
>> +
>> +    xdp_hints = xdp->data - btf_sz;
>> +    common = &xdp_hints->common;
>> +
>> +    if (unlikely(tsynvalid)) {
>> +        struct xdp_hints_i40e_timestamp *hints;
>> +
>> +        tsyn_ts = i40e_ptp_rx_hwtstamp_raw(rx_ring->vsi->back, tsyn);
>> +        btf_id = btf_id_xdp_hints_i40e_timestamp;
>> +        btf_sz = sizeof(*hints);
>> +        hints = xdp->data - btf_sz;
>> +        hints->rx_timestamp = ns_to_ktime(tsyn_ts);
>> +        f1 = HINT_FLAG_RX_TIMESTAMP;
>> +    }
>> +
>> +    /* ptype needed by both hash and checksum code */
>> +    rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >> 
>> I40E_RXD_QW1_PTYPE_SHIFT;
>> +    ptype = decode_rx_desc_ptype(rx_ptype);
>> +
>> +    f2 = i40e_rx_hash_xdp(rx_ring, rx_desc, xdp, qword, xdp_hints, 
>> ptype);
>> +    f3 = i40e_rx_checksum_xdp(rx_ring->vsi, qword, xdp_hints, ptype);
>> +    f4 = xdp_hints_set_rxq(common, rx_ring->queue_index);
>> +
>> +    if (unlikely(qword & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT))) {
>> +        __le16 vlan_tag = rx_desc->wb.qword0.lo_dword.l2tag1;
>> +
>> +        f5 = xdp_hints_set_vlan(common, le16_to_cpu(vlan_tag),
>> +                   htons(ETH_P_8021Q));
>> +    }
>> +
>> +    xdp_hints_set_flags(common, (f1 | f2 | f3 | f4 | f5));
>> +    common->btf_id = btf_id;
>> +    xdp->data_meta = xdp->data - btf_sz;
> 
> I think it might be worth considering leaving a predefined size space in 
> the headroom before the data (but after the metadata) for encapsulation 
> headers that may be applied to the packet as it transitions to it's 
> final destination through a host. In other words starting the metadata 
I meant xdp_hints rather than metadata here...

> further up so that the BTF id resides at a known offset from data.
> 
> Say for example a bpf program that inserts vlan/vxlan tags/headers on 
> received packets on a host should have enough space to apply that vlan 
> tag without having to copy the metadata and shift it before it does that.

  xdp_hints here also

> 
> Or maybe there was something that was already accounting for this in the 
> design and I missed it. Would really appreciate a pointer in that case.
> 
> 

