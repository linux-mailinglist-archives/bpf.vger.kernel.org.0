Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65609692213
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 16:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjBJPYv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 10:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjBJPYu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 10:24:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588BC75F42
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 07:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676042627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWOkmCoae5bj7doNl9U80aK5H1Z/48L9J7BCWykdr7Y=;
        b=BV/KNEPZzdn/yt3eLLHRabCt/LZ8NLTGf4cs/L2865f7LbapqCDMmkYg5mJvNocBrb2uEP
        tflyvJQvBs6hujJYGJXJtyoZ6rzF3PFmhJZcvk06mUXjtvkz/Zsg7c3Bedxs8+mUvkQDsx
        6nWy2yb552Do66SSIHrc0wEqv8DpANQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-wfljqPvsM1SCyztHgEqfig-1; Fri, 10 Feb 2023 10:23:46 -0500
X-MC-Unique: wfljqPvsM1SCyztHgEqfig-1
Received: by mail-ed1-f71.google.com with SMTP id z19-20020a05640235d300b004aaca83cd87so3764689edc.20
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 07:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWOkmCoae5bj7doNl9U80aK5H1Z/48L9J7BCWykdr7Y=;
        b=nyEV1o/tswGprHSqqBUVIEqnKr18Bf7bCb0sG9TzHW9bkYTqE+qQXGBOqurWseDSPP
         WIqQmcKR7tSPMdVlLLN4Mt+PwOSvg79hlC/joZAOafA7l91vFcDOZrAOWhlBjLS9cFhS
         DMto/uVovmqFV/0nNt6IgkZ6bdpbo8BPYAbGFy4rNIIswWbyfbeWwesysEp6gaCNWPYD
         TiB4h5o3RYtbEgab3/f7lDOE/1zJrLZVE+EkScmXS3hu5f5AEPI3ki4GufcPSUpYwQWp
         4sPO4dIS/saMgxEpHQUiurZgjudK7lwBX+gK0P9GN1BP0Q0PT/XmX+urEQ6sWsFhVT7D
         CgNw==
X-Gm-Message-State: AO0yUKXPEzGpKyj9l2vl+qVt95vo32qhBv0m2Lw2yPIJpoOzZRIO4XcQ
        y5iZUCk7icKz8bJfDhfrse6DkGMuVXCxxKXauwksOs5rNzGT0zSZ55qcm3RbIMQPwiu9kO+DBKi
        +5PbZkMpl11r2H8RyODbN7R2Q6K0GXsO4rXc3ixeGW25Bfd46kHSAFSrFtwdAf9FYiIt1
X-Received: by 2002:a17:907:9c04:b0:8ae:27d1:511a with SMTP id ld4-20020a1709079c0400b008ae27d1511amr11276173ejc.61.1676042625139;
        Fri, 10 Feb 2023 07:23:45 -0800 (PST)
X-Google-Smtp-Source: AK7set/Dv0ROzBQbObyzo0Y2IdUhDynWiuzWOvrXTZsWu/DA//Xm5WEuTrVPmZF2W0ITkYnPV8JMOg==
X-Received: by 2002:a17:907:9c04:b0:8ae:27d1:511a with SMTP id ld4-20020a1709079c0400b008ae27d1511amr11276151ejc.61.1676042624873;
        Fri, 10 Feb 2023 07:23:44 -0800 (PST)
Received: from [192.168.42.100] (nat-cgn9-185-107-15-52.static.kviknet.net. [185.107.15.52])
        by smtp.gmail.com with ESMTPSA id op5-20020a170906bce500b0088e682e3a4csm2485103ejb.185.2023.02.10.07.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 07:23:44 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <c40de89d-2977-5c8d-e049-006df2431f47@redhat.com>
Date:   Fri, 10 Feb 2023 16:23:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        yoong.siang.song@intel.com, anthony.l.nguyen@intel.com,
        intel-wired-lan@lists.osuosl.org, xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next V1] igc: enable and fix RX hash usage by netstack
Content-Language: en-US
To:     bpf@vger.kernel.org
References: <167604167956.1726972.7266620647404438534.stgit@firesoul>
In-Reply-To: <167604167956.1726972.7266620647404438534.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 10/02/2023 16.07, Jesper Dangaard Brouer wrote:
> When function igc_rx_hash() was introduced in v4.20 via commit 0507ef8a0372
> ("igc: Add transmit and receive fastpath and interrupt handlers"), the
> hardware wasn't configured to provide RSS hash, thus it made sense to not
> enable net_device NETIF_F_RXHASH feature bit.
> 
> The NIC hardware was configured to enable RSS hash info in v5.2 via commit
> 2121c2712f82 ("igc: Add multiple receive queues control supporting"), but
> forgot to set the NETIF_F_RXHASH feature bit.
>

Sending this fix against bpf-next, as I found this issue while playing
with implementing XDP-hints kfunc for xmo_rx_hash. I will hopefully send
kfunc patches next week, on top of this.IMHO this fix isn't very 
critical and I hope it can simply go though the
bpf-next tree as it would ease followup kfunc patches.


> The original implementation of igc_rx_hash() didn't extract the associated
> pkt_hash_type, but statically set PKT_HASH_TYPE_L3. The largest portions of
> this patch are about extracting the RSS Type from the hardware and mapping
> this to enum pkt_hash_types. This were based on Foxville i225 software user
> manual rev-1.3.1 and tested on Intel Ethernet Controller I225-LM (rev 03).
> 
> For UDP it's worth noting that RSS (type) hashing have been disabled both for
> IPv4 and IPv6 (see IGC_MRQC_RSS_FIELD_IPV4_UDP + IGC_MRQC_RSS_FIELD_IPV6_UDP)
> because hardware RSS doesn't handle fragmented pkts well when enabled (can
> cause out-of-order). This result in PKT_HASH_TYPE_L3 for UDP packets, and
> hash value doesn't include UDP port numbers. Not being PKT_HASH_TYPE_L4, have
> the effect that netstack will do a software based hash calc calling into
> flow_dissect, but only when code calls skb_get_hash(), which doesn't
> necessary happen for local delivery.
>


Intel QA tester wanting to verify this patch can use the small bpftrace
tool I wrote and placed here:

 
https://github.com/xdp-project/xdp-project/blob/master/areas/hints/monitor_skb_hash_on_dev.bt

Failure scenarios:

$ sudo ./monitor_skb_hash_on_dev.bt igc1
Attaching 2 probes...
Monitor net_device: igc1
Hit Ctrl-C to end.
IFNAME           HASH      Hash-type:L4    Software-hash
igc1             00000000  0               0
igc1             00000000  0               0
igc1             00000000  0               0
^C


Example output with patch:

$ sudo ./monitor_skb_hash_on_dev.bt igc1
Attaching 2 probes...
Monitor net_device: igc1
Hit Ctrl-C to end.
IFNAME           HASH      Hash-type:L4    Software-hash
igc1             FEF98EFE  0               0
igc1             00000000  0               0
igc1             00000000  0               0
igc1             FEF98EFE  0               0
igc1             FEF98EFE  0               0
igc1             FEF98EFE  0               0
igc1             310AF9EA  1               0
igc1             A229FA51  1               0

The repeating hash FEF98EFE is UDP packets that as desc note doesn't
have Hash-type:L4.  The UDP has is repeating as port numbers aren't part
of the hash, and I was sending to same IP. The hash values with L4=1
were TCP packets.

Hope this eases QA work.

> Fixes: 2121c2712f82 ("igc: Add multiple receive queues control supporting")
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |   52 +++++++++++++++++++++++++++++
>   drivers/net/ethernet/intel/igc/igc_main.c |   35 +++++++++++++++++---
>   2 files changed, 83 insertions(+), 4 deletions(-)

--Jesper

