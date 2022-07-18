Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2D4577ECB
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 11:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiGRJjC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 05:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiGRJip (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 05:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ECAF1ADB9
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658137123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6S7vWV6CH/Jlwkpy/Zv9SGCaVUBqz0UpDbTFe7FRECs=;
        b=DmjWT6L9QCuibuJN71+fqThQVFet68l2CIemDMu8saVV61rFU1x/VYkVtQOLt2Srp+5bSO
        516AYZ8eUL05clW+hueekfEy5AZO2p+XVEjR2mNXaToIawKlgB1IJT3lSvvptTB8DT0alh
        2A+FFs8iziZ7BYiqv5nKScxOd45gF1U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-yKghyjpEMla1VsdE-218pg-1; Mon, 18 Jul 2022 05:38:30 -0400
X-MC-Unique: yKghyjpEMla1VsdE-218pg-1
Received: by mail-wm1-f72.google.com with SMTP id 189-20020a1c02c6000000b003a2d01897e4so4182291wmc.9
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 02:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=6S7vWV6CH/Jlwkpy/Zv9SGCaVUBqz0UpDbTFe7FRECs=;
        b=xDmq8QHKZO82hqTLefAPIAN+JmcDrJerxW6aRJ86lkRSQ1IuuCUIr9kXYYVBgKCgLh
         3k/Q4ayt5I7r3C8YAr4rl/LwOYXm6KyfSYmQocHSphII1EdJMyPqyWXMDcscUpjlj8S3
         QYx/mWyZgi1wJvr9zCIAxwcRGxwelm4UIj2uvT6uOGg5YN3re6QORMrqI5ARp7gWZ5pA
         hRsDC0++rvA+9wWYSPeJneaRFnFaNWdy13Q2wIKjt2UWXpMwP1rZJ1vDarXJVkBkmxmd
         age+GrSc2K3YNof8GVnJisJQM9l7HF7B0PM+4Q47ghqFS77VdESRlNrTI0ITfHCj8kBU
         TMwQ==
X-Gm-Message-State: AJIora9l+YiVvcw/07/qDTFaWseT2VPZr5oPMNOkGN+mBNK6r5zA2BId
        WdP6WYwFpNfhUI4/t/r+lbOhuLnTkdBmQgSh61tZlRxsrmT6h9WcD7hy5V4GA3V/EIfaZowOdo+
        BDD7KtuIGgk9Z
X-Received: by 2002:a05:600c:34c4:b0:3a2:e259:925b with SMTP id d4-20020a05600c34c400b003a2e259925bmr24821446wmq.99.1658137108853;
        Mon, 18 Jul 2022 02:38:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tTzXBv0PCOwa5kAfrHYd/xKUB7mxTcRK1rTRJ6HJ7dabb9Iv+6xfkRIOEPF2jqCUJqe1lkRw==
X-Received: by 2002:a05:600c:34c4:b0:3a2:e259:925b with SMTP id d4-20020a05600c34c400b003a2e259925bmr24821439wmq.99.1658137108673;
        Mon, 18 Jul 2022 02:38:28 -0700 (PDT)
Received: from ?IPV6:2a01:b340:64:d3ca:188c:3c48:3209:7784? ([2a01:b340:64:d3ca:188c:3c48:3209:7784])
        by smtp.gmail.com with ESMTPSA id q5-20020a1c4305000000b003a2d6c623f3sm17795654wma.19.2022.07.18.02.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 02:38:28 -0700 (PDT)
Message-ID: <431a0822-5aa7-b5e0-2389-bb8c66f42e8f@redhat.com>
Date:   Mon, 18 Jul 2022 10:38:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
Subject: Re: [PATCH RFC bpf-next 7/9] i40e: add XDP-hints handling
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org
Cc:     xdp-hints@xdp-project.net
References: <165643378969.449467.13237011812569188299.stgit@firesoul>
 <165643386896.449467.16847946958931423319.stgit@firesoul>
Content-Language: en-US
From:   Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <165643386896.449467.16847946958931423319.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 28/06/2022 17:31, Jesper Dangaard Brouer wrote:

<snip>

> +
> +static inline void i40e_process_xdp_hints(struct i40e_ring *rx_ring,
> +					  union i40e_rx_desc *rx_desc,
> +					  struct xdp_buff *xdp,
> +					  u64 qword)
> +{
> +	u32 rx_status = (qword & I40E_RXD_QW1_STATUS_MASK) >>
> +			I40E_RXD_QW1_STATUS_SHIFT;
> +	u32 tsynvalid = rx_status & I40E_RXD_QW1_STATUS_TSYNVALID_MASK;
> +	u32 tsyn = (rx_status & I40E_RXD_QW1_STATUS_TSYNINDX_MASK) >>
> +		   I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT;
> +	u64 tsyn_ts;
> +
> +	struct i40e_rx_ptype_decoded ptype;
> +	struct xdp_hints_i40e *xdp_hints;
> +	struct xdp_hints_common *common;
> +	u32 btf_id = btf_id_xdp_hints_i40e;
> +	u32 btf_sz = sizeof(*xdp_hints);
> +	u32 f1 = 0, f2, f3, f4, f5 = 0;
> +	u8 rx_ptype;
> +
> +	if (!(rx_ring->netdev->features & NETIF_F_XDP_HINTS))
> +		return;
> +
> +	/* Driver have xdp headroom when using build_skb */
> +	if (unlikely(!ring_uses_build_skb(rx_ring)))
> +		return;
> +
> +	xdp_hints = xdp->data - btf_sz;
> +	common = &xdp_hints->common;
> +
> +	if (unlikely(tsynvalid)) {
> +		struct xdp_hints_i40e_timestamp *hints;
> +
> +		tsyn_ts = i40e_ptp_rx_hwtstamp_raw(rx_ring->vsi->back, tsyn);
> +		btf_id = btf_id_xdp_hints_i40e_timestamp;
> +		btf_sz = sizeof(*hints);
> +		hints = xdp->data - btf_sz;
> +		hints->rx_timestamp = ns_to_ktime(tsyn_ts);
> +		f1 = HINT_FLAG_RX_TIMESTAMP;
> +	}
> +
> +	/* ptype needed by both hash and checksum code */
> +	rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >> I40E_RXD_QW1_PTYPE_SHIFT;
> +	ptype = decode_rx_desc_ptype(rx_ptype);
> +
> +	f2 = i40e_rx_hash_xdp(rx_ring, rx_desc, xdp, qword, xdp_hints, ptype);
> +	f3 = i40e_rx_checksum_xdp(rx_ring->vsi, qword, xdp_hints, ptype);
> +	f4 = xdp_hints_set_rxq(common, rx_ring->queue_index);
> +
> +	if (unlikely(qword & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT))) {
> +		__le16 vlan_tag = rx_desc->wb.qword0.lo_dword.l2tag1;
> +
> +		f5 = xdp_hints_set_vlan(common, le16_to_cpu(vlan_tag),
> +				   htons(ETH_P_8021Q));
> +	}
> +
> +	xdp_hints_set_flags(common, (f1 | f2 | f3 | f4 | f5));
> +	common->btf_id = btf_id;
> +	xdp->data_meta = xdp->data - btf_sz;

I think it might be worth considering leaving a predefined size space in 
the headroom before the data (but after the metadata) for encapsulation 
headers that may be applied to the packet as it transitions to it's 
final destination through a host. In other words starting the metadata 
further up so that the BTF id resides at a known offset from data.

Say for example a bpf program that inserts vlan/vxlan tags/headers on 
received packets on a host should have enough space to apply that vlan 
tag without having to copy the metadata and shift it before it does that.

Or maybe there was something that was already accounting for this in the 
design and I missed it. Would really appreciate a pointer in that case.


