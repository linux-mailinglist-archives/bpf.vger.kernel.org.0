Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3CF4FDA0F
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 12:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358903AbiDLIcX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 04:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358333AbiDLHlZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 03:41:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FDF34738E
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 00:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649747867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5sAnr3icD6MJyBK8faFE8hOzFd8d3uIsnWyEnC7YcA=;
        b=aBkiayHzeOH+SGeMnkGXB3FeterqOOsN6M4+HWsZclFHGDtX1Y1k/Z1YeckG5G6+CpWfA2
        n51dQZrOoehZddX15bberASfYZOqA4BRfBYzqxyZHnkWR72GJuiSpAVVTHYQRK1HZvOlth
        kwWa2F2lShV8w0kudeM4X2pdFPgMBMs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-a6eOISFDPoqX2HMsNDgobQ-1; Tue, 12 Apr 2022 03:17:45 -0400
X-MC-Unique: a6eOISFDPoqX2HMsNDgobQ-1
Received: by mail-qk1-f197.google.com with SMTP id de26-20020a05620a371a00b00699f7065b5cso9072172qkb.5
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 00:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=v5sAnr3icD6MJyBK8faFE8hOzFd8d3uIsnWyEnC7YcA=;
        b=P6Xj3o9Y8sOA5j30AtrYk+FWBOcGP/R3Dn6g1Fm87L1b52oa0N96nFIkBoq7DSECt2
         WZ630lIZp2QvFV1/ykLBFM+32xcrpHTvCJoj+yw1VMESkYfKmBsggaY8exdkccz0tBRE
         cze9M3mgWhV5XrkR1f7ftpqlYmEAG+eUJxBx7ZDmVH2g5NAgOK2RgvNhmY52Y4ha6wB7
         hOsy4ntcH71HZemNXnkT1/kWIwGSpSjJAqlmfITK3YUHKbyWjkrhSbs79Hc30ZAWL7P0
         LTfbEt5BbJtt91m03bqTkJKEbVgwTCbPh8PMmynieoy4Zn+MtETYUeEnDjbpYvfWWuYd
         4oqQ==
X-Gm-Message-State: AOAM531ZUlwq1fQua1IXdAbqpizVnZRbrxps667hLLTC1FtzvMTrMviK
        2/7fNQEun5dzOnAnUSkBdg5D1K35N1zDC8alDWaU8WEBDzphaoXZdD3D7T/yRxKdz+sYojLPZSq
        f5bVEt5KhP3dW
X-Received: by 2002:ad4:434e:0:b0:444:4d8b:dfab with SMTP id q14-20020ad4434e000000b004444d8bdfabmr4736925qvs.60.1649747864852;
        Tue, 12 Apr 2022 00:17:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRNUgruDRs0RboO+P4hZM/BoQapjUxvCLKJWQyJAME6/ZGboeEgkF7KJcowth+MZlHXRghJQ==
X-Received: by 2002:ad4:434e:0:b0:444:4d8b:dfab with SMTP id q14-20020ad4434e000000b004444d8bdfabmr4736901qvs.60.1649747864561;
        Tue, 12 Apr 2022 00:17:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-237.dyn.eolo.it. [146.241.96.237])
        by smtp.gmail.com with ESMTPSA id bi29-20020a05620a319d00b0069c3f6adc18sm472304qkb.22.2022.04.12.00.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:17:44 -0700 (PDT)
Message-ID: <61717f91f715c757789de0122367a1f494f07407.camel@redhat.com>
Subject: Re: [PATCH net-next v4 0/3] net: atlantic: Add XDP support
From:   Paolo Abeni <pabeni@redhat.com>
To:     Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org, irusskikh@marvell.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org,
        bpf@vger.kernel.org
Date:   Tue, 12 Apr 2022 09:17:37 +0200
In-Reply-To: <20220408181714.15354-1-ap420073@gmail.com>
References: <20220408181714.15354-1-ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2022-04-08 at 18:17 +0000, Taehee Yoo wrote:
> This patchset is to make atlantic to support multi-buffer XDP.
> 
> The first patch implement control plane of xdp.
> The aq_xdp(), callback of .xdp_bpf is added.
> 
> The second patch implements data plane of xdp.
> XDP_TX, XDP_DROP, and XDP_PASS is supported.
> __aq_ring_xdp_clean() is added to receive and execute xdp program.
> aq_nic_xmit_xdpf() is added to send packet by XDP.
> 
> The third patch implements callback of .ndo_xdp_xmit.
> aq_xdp_xmit() is added to send redirected packets and it internally
> calls aq_nic_xmit_xdpf().
> 
> Memory model is MEM_TYPE_PAGE_ORDER0 so it doesn't reuse rx page when
> XDP_TX, XDP_PASS, XDP_REDIRECT.
> 
> Default the maximum rx frame size is 2K.
> If xdp is attached, size is changed to about 3K.
> It can be reused when XDP_DROP, and XDP_ABORTED.
> 
> Atlantic driver has AQ_CFG_RX_PAGEORDER option and it will be always 0
> if xdp is attached.
> 
> LRO will be disabled if XDP program supports only single buffer.
> 
> AQC chip supports 32 multi-queues and 8 vectors(irq).
> There are two options.
> 1. under 8 cores and maximum 4 tx queues per core.
> 2. under 4 cores and maximum 8 tx queues per core.
> 
> Like other drivers, these tx queues can be used only for XDP_TX,
> XDP_REDIRECT queue. If so, no tx_lock is needed.
> But this patchset doesn't use this strategy because getting hardware tx
> queue index cost is too high.
> So, tx_lock is used in the aq_nic_xmit_xdpf().
> 
> single-core, single queue, 80% cpu utilization.
> 
>   30.75%  bpf_prog_xxx_xdp_prog_tx  [k] bpf_prog_xxx_xdp_prog_tx
>   10.35%  [kernel]                  [k] aq_hw_read_reg <---------- here
>    4.38%  [kernel]                  [k] get_page_from_freelist
> 
> single-core, 8 queues, 100% cpu utilization, half PPS.
> 
>   45.56%  [kernel]                  [k] aq_hw_read_reg <---------- here
>   17.58%  bpf_prog_xxx_xdp_prog_tx  [k] bpf_prog_xxx_xdp_prog_tx
>    4.72%  [kernel]                  [k] hw_atl_b0_hw_ring_rx_receive
> 
> Performance result(64 Byte)
> 1. XDP_TX
>   a. xdp_geieric, single core
>     - 2.5Mpps, 100% cpu
>   b. xdp_driver, single core
>     - 4.5Mpps, 80% cpu
>   c. xdp_generic, 8 core(hyper thread)
>     - 6.3Mpps, 5~10% cpu
>   d. xdp_driver, 8 core(hyper thread)
>     - 6.3Mpps, 5% cpu
> 
> 2. XDP_REDIRECT
>   a. xdp_generic, single core
>     - 2.3Mpps
>   b. xdp_driver, single core
>     - 4.5Mpps
> 
> v4:
>  - Fix compile warning
> 
> v3:
>  - Change wrong PPS performance result 40% -> 80% in single
>    core(Intel i3-12100)
>  - Separate aq_nic_map_xdp() from aq_nic_map_skb()
>  - Drop multi buffer packets if single buffer XDP is attached
>  - Disable LRO when single buffer XDP is attached
>  - Use xdp_get_{frame/buff}_len()
> 
> v2:
>  - Do not use inline in C file
> 
> Taehee Yoo (3):
>   net: atlantic: Implement xdp control plane
>   net: atlantic: Implement xdp data plane
>   net: atlantic: Implement .ndo_xdp_xmit handler
> 
>  .../net/ethernet/aquantia/atlantic/aq_cfg.h   |   1 +
>  .../ethernet/aquantia/atlantic/aq_ethtool.c   |   8 +
>  .../net/ethernet/aquantia/atlantic/aq_main.c  |  87 ++++
>  .../net/ethernet/aquantia/atlantic/aq_main.h  |   2 +
>  .../net/ethernet/aquantia/atlantic/aq_nic.c   | 137 ++++++
>  .../net/ethernet/aquantia/atlantic/aq_nic.h   |   5 +
>  .../net/ethernet/aquantia/atlantic/aq_ring.c  | 415 ++++++++++++++++--
>  .../net/ethernet/aquantia/atlantic/aq_ring.h  |  17 +
>  .../net/ethernet/aquantia/atlantic/aq_vec.c   |  23 +-
>  .../net/ethernet/aquantia/atlantic/aq_vec.h   |   6 +
>  .../aquantia/atlantic/hw_atl/hw_atl_a0.c      |   6 +-
>  .../aquantia/atlantic/hw_atl/hw_atl_b0.c      |  10 +-
>  12 files changed, 675 insertions(+), 42 deletions(-)
> 
@Igor: this should address you concerns on v2, could you please have a
look?

Thanks!

Paolo

