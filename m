Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664846E4C5B
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjDQPFO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 11:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjDQPFM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 11:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7048A1A8
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681743861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJBNuSsSRPzwbnWzbfANH/a4n2dZHDD98aiqXtusCOY=;
        b=Hcr1a8qkYMNQItRsd9Nm1GFGbqWjeCxUdNWPdylliXH0oPuHcOd6MKfVWcZ2VoksL8Fpom
        E3Cnx03Ki/6jEZCjLMWfC15YOo9/0LGO/ZPBid7g1SwQMWXekHCeHgeLfkREU/PjsfOg1a
        6SknMX+E9HeJIOEEg2CQ4D5dlhp8DnA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-qJrIeOa5PCCR03ZVGC5_Rg-1; Mon, 17 Apr 2023 11:04:20 -0400
X-MC-Unique: qJrIeOa5PCCR03ZVGC5_Rg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-506a455ee4cso531147a12.3
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 08:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743859; x=1684335859;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJBNuSsSRPzwbnWzbfANH/a4n2dZHDD98aiqXtusCOY=;
        b=FzugMJcpVJkXChPMC48PL7brWpcCQuM9lgqemK79S9PRknkFIhf53x5oUokGiys+w+
         xyZ+6V4t8flWvW5kbod3VwnE0kkUtL06/qIxoOGdN5atrbuhyOhhqYQqtuV+2rfKw3Y/
         BfU6lXF15JQbBlh7wG6HS7GUyhy8zPTViDq/QH9rQhO2V0VZ/EMdxIpBrOC4xB0KaJwA
         gZs291za5qltM6olxK22cWZZAIwe/CN7sQCZzSpK/Q10lycEBFoJ6I5LvHRAbdmODvnF
         SReo79Y0F/qMTz6Dr8h/xFpkQeYHNRq8Xkz0P4b2eX+oZxcCgMN46jZJLUpbuhBi4Qwr
         hdmQ==
X-Gm-Message-State: AAQBX9dtNRwzJ+9TOs54ORjjhOPj4WegSghAIeycPQsSDHZc1F1Z+sWP
        ubIGa4EO0n4rSD/PK7KfdCXHh7CQwB6LXK8nosvN+KwiRI8EESLOkraaujLdyjsKBXMql2CXbrj
        /iyv0EL9g1fK11JXOfcJY+L01gPsj4SVOjdYmnQiJkQW+RaKXf210wT1i0m8MpsK9VWZulyA=
X-Received: by 2002:a05:6402:64b:b0:504:a360:e611 with SMTP id u11-20020a056402064b00b00504a360e611mr13762517edx.13.1681743858826;
        Mon, 17 Apr 2023 08:04:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350aGCwFvxgC+HLPcIfKk2U/Fm7fSlmjb1ietdTgyJ2DJ6npnOC/Z7W4lbiaEQlJOO6d4h9uKew==
X-Received: by 2002:a05:6402:64b:b0:504:a360:e611 with SMTP id u11-20020a056402064b00b00504a360e611mr13762480edx.13.1681743858466;
        Mon, 17 Apr 2023 08:04:18 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7df15000000b00505060e4280sm5944035edy.94.2023.04.17.08.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 08:04:18 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <0fa94fe1-c448-084f-3a3d-ab52e701c91c@redhat.com>
Date:   Mon, 17 Apr 2023 17:04:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        yoong.siang.song@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH bpf-next V1 5/5] selftests/bpf: xdp_hw_metadata track more
 timestamps
Content-Language: en-US
To:     bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <168174338054.593471.8312147519616671551.stgit@firesoul>
 <168174344813.593471.4026230439937368990.stgit@firesoul>
In-Reply-To: <168174344813.593471.4026230439937368990.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 17/04/2023 16.57, Jesper Dangaard Brouer wrote:
> To correlate the hardware RX timestamp with something, add tracking of
> two software timestamps both clock source CLOCK_TAI (see description in
> man clock_gettime(2)).
> 
> XDP metadata is extended with xdp_timestamp for capturing when XDP
> received the packet. Populated with BPF helper bpf_ktime_get_tai_ns(). I
> could not find a BPF helper for getting CLOCK_REALTIME, which would have
> been preferred. In userspace when AF_XDP sees the packet another
> software timestamp is recorded via clock_gettime() also clock source
> CLOCK_TAI.
> 
> Example output shortly after loading igc driver:
> 
>    poll: 1 (0) skip=1 fail=0 redir=2
>    xsk_ring_cons__peek: 1
>    0x12557a8: rx_desc[1]->addr=100000000009000 addr=9100 comp_addr=9000
>    rx_hash: 0x82A96531 with RSS type:0x1
>    rx_timestamp:  1681740540304898909 (sec:1681740540.3049)
>    XDP RX-time:   1681740577304958316 (sec:1681740577.3050) delta sec:37.0001 (37000059.407 usec)
>    AF_XDP time:   1681740577305051315 (sec:1681740577.3051) delta sec:0.0001 (92.999 usec)
>    0x12557a8: complete idx=9 addr=9000
> 

For QA verification testing, I want to mention that this fix[0] were
applied, in-order to get "rx_timestamp" working on igc:

  [0] 
https://lore.kernel.org/all/20230414154902.2950535-1-yoong.siang.song@intel.com/


> The first observation is that the 37 sec difference between RX HW vs XDP
> timestamps, which indicate hardware is likely clock source
> CLOCK_REALTIME, because (as of this writing) CLOCK_TAI is initialised
> with a 37 sec offset.
> 
> The 93 usec (microsec) difference between XDP vs AF_XDP userspace is the
> userspace wakeup time. On this hardware it was caused by CPU idle sleep
> states, which can be reduced by tuning /dev/cpu_dma_latency.
> 
> View current requested/allowed latency bound via:
>    hexdump --format '"%d\n"' /dev/cpu_dma_latency
> 
> More explanation of the output and how this can be used to identify
> clock drift for the HW clock can be seen here[1]:
> 
> [1] https://github.com/xdp-project/xdp-project/blob/master/areas/hints/xdp_hints_kfuncs02_driver_igc.org
> 

