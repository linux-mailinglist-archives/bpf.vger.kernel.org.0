Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15E569BBA7
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 20:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBRTwp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Feb 2023 14:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBRTwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Feb 2023 14:52:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60970125BF
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 11:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676749916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jx6T743echyIrkeXGF6irLdkrvJq/F4CIpXSF+GVavE=;
        b=cYt1ugAx5EkiU1df96Au57hFPOyfIG+6LciqntXOQRTE+hBtd6/zl5m4ouh+SvzaaFKCsz
        ut3JJTT2J4ALRgRbknFbUToxnGFF9w53dJ5YqJvpiPu8THv/Kk0NGVoKPsT0Kr2CA0Uho0
        qMp/zjBe/senh2R8SbfPzPQHk7MUZEM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-269-t_ZTv7IAPD2q-mTzr1TaVw-1; Sat, 18 Feb 2023 14:51:47 -0500
X-MC-Unique: t_ZTv7IAPD2q-mTzr1TaVw-1
Received: by mail-ed1-f71.google.com with SMTP id ez8-20020a056402450800b004acd97105ffso1731832edb.19
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 11:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jx6T743echyIrkeXGF6irLdkrvJq/F4CIpXSF+GVavE=;
        b=ukBVIBw2hutkAQ2chW6p8ANirI1cp9gQTP0N2F3j7e6zb1S5OrbjPTNx0bdKjaehbI
         N/LVEmi+sSzk+iPuEHEy34rQ1JAaOfke6e2Z7OHT8MG1JGTjzmcChHXFwGd9TN31eFqa
         72PuaQuMZI8Xj4Wfx8pWmYR/CfflavYSRSbPLFzyJzRDPQ31Dfdmr4h5QDjC46NsL0q7
         Aq6TFS3LDvt5pr/aePWoOjHMMQ2p+CsvQFU5wgCR6+szjsKPp1HFSo+cz03VY1MS2l6c
         +pL4PTE9fhi96dSkB0ceoystImO/Md046fPO1UDtBBBTIsBVHAEG/oj26cs2oYqna3Pg
         TvjQ==
X-Gm-Message-State: AO0yUKUCgdePGrNobW4VhA37Nz6Fr4wzlZLzJLbNA9OBsFDTeI8apC/t
        CbrPxhlePBgVTZmAIGzGJNLcOwu0Li/TCgCGuwurQqenwDBlUQp43pWZIKvMAru9eMFI/fxfdnX
        WUKhEoNaDiJ2a
X-Received: by 2002:a17:906:5e42:b0:878:4e5a:18b8 with SMTP id b2-20020a1709065e4200b008784e5a18b8mr3925882eju.66.1676749906325;
        Sat, 18 Feb 2023 11:51:46 -0800 (PST)
X-Google-Smtp-Source: AK7set/3W8hwok4bX5UVtqdvkS2nXqk1Es/q8aSEbc2knNOLLh9wPd7/gg4Y76HMjmnnXmLLc6Knsw==
X-Received: by 2002:a17:906:5e42:b0:878:4e5a:18b8 with SMTP id b2-20020a1709065e4200b008784e5a18b8mr3925863eju.66.1676749906043;
        Sat, 18 Feb 2023 11:51:46 -0800 (PST)
Received: from [192.168.42.100] (nat-cgn9-185-107-15-52.static.kviknet.net. [185.107.15.52])
        by smtp.gmail.com with ESMTPSA id ad24-20020a170907259800b0087bdac06a3bsm3713637ejc.2.2023.02.18.11.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 11:51:45 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3bf858ee-d1d1-0ae1-7673-9f9e11e7ca9e@redhat.com>
Date:   Sat, 18 Feb 2023 20:51:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>, martin.lau@kernel.org,
        ast@kernel.org, alexandr.lobakin@intel.com,
        yoong.siang.song@intel.com, anthony.l.nguyen@intel.com,
        intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
        pmenzel@molgen.mpg.de, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH bpf-next V2] igc: enable and fix RX hash usage by netstack
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
References: <167656636587.1912541.8039324850101942090.stgit@firesoul>
 <571350f8-3302-abc5-505a-8e5b1f77defe@iogearbox.net>
In-Reply-To: <571350f8-3302-abc5-505a-8e5b1f77defe@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 17/02/2023 21.59, Daniel Borkmann wrote:
> On 2/16/23 5:52 PM, Jesper Dangaard Brouer wrote:
>> When function igc_rx_hash() was introduced in v4.20 via commit 0507ef8a0372
>> ("igc: Add transmit and receive fastpath and interrupt handlers"), the
>> hardware wasn't configured to provide RSS hash, thus it made sense to not
>> enable net_device NETIF_F_RXHASH feature bit.
>>
>> The NIC hardware was configured to enable RSS hash info in v5.2 via commit
>> 2121c2712f82 ("igc: Add multiple receive queues control supporting"), but
>> forgot to set the NETIF_F_RXHASH feature bit.
>>
>> The original implementation of igc_rx_hash() didn't extract the associated
>> pkt_hash_type, but statically set PKT_HASH_TYPE_L3. The largest portions of
>> this patch are about extracting the RSS Type from the hardware and mapping
>> this to enum pkt_hash_types. This was based on Foxville i225 software user
>> manual rev-1.3.1 and tested on Intel Ethernet Controller I225-LM (rev 03).
>>
>> For UDP it's worth noting that RSS (type) hashing have been disabled both for
>> IPv4 and IPv6 (see IGC_MRQC_RSS_FIELD_IPV4_UDP + IGC_MRQC_RSS_FIELD_IPV6_UDP)
>> because hardware RSS doesn't handle fragmented pkts well when enabled (can
>> cause out-of-order). This results in PKT_HASH_TYPE_L3 for UDP packets, and
>> hash value doesn't include UDP port numbers. Not being PKT_HASH_TYPE_L4, have
>> the effect that netstack will do a software based hash calc calling into
>> flow_dissect, but only when code calls skb_get_hash(), which doesn't
>> necessary happen for local delivery.
>>
>> Fixes: 2121c2712f82 ("igc: Add multiple receive queues control supporting")
>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> 
> I presume this should go via net-next, not bpf-next? (Didn't find specific
> dependencies, so moved to patchwork netdev bucket..)

Thanks for letting me/us know.

I posted against bpf-next, because I have patches (for kfunc XDP-hints)
that depend on this patch.  As we are at rc8, netdev maintainers feel
free to simply drop the patch as the patch isn't critical.  I will just
include this patch as part of my kfunc XDP-hints series later.

--Jesper





