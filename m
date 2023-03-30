Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318236D0E4D
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 21:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjC3TFz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 15:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjC3TFy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 15:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E9E2D43
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680203104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjWL/5ulXSBNWvEtpYPDT+pUxocHBbNGFxfjDnuHH+M=;
        b=ZXIvEA8xOHzc/0lT9hLiQl6yDBjgc1z3+LjloazkNQ7oNNbJL2+aZNKe9LPNLPAhJdoLDO
        TEc8RZUWF2nHSpura0PpDxzDOTsj7YtZSS5YuD0XrYMxlkwHmFvChHxVO1oqOhdvXxYaF6
        bT58zv5h0GFLIzAiY7XUohv+Y9ndgEE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-PVwR8Fb8NmeqitivfRrwwA-1; Thu, 30 Mar 2023 15:05:02 -0400
X-MC-Unique: PVwR8Fb8NmeqitivfRrwwA-1
Received: by mail-lj1-f200.google.com with SMTP id a17-20020a05651c031100b0029c8878f9cbso4464319ljp.5
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 12:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203101;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjWL/5ulXSBNWvEtpYPDT+pUxocHBbNGFxfjDnuHH+M=;
        b=AuxfzFrb72uFwJoYp9zkV5B1h2XhY9pRJ+5i92hRESqYyuPE/etsMmhV+o1vSFsl/7
         fnoUznb8ffNfwrxUjl7sM22yNd1M8sxss/9t0mku74AMeK8MYBgPvvfozMi2+IhU1/wP
         VAWzmw117IaZ+q8qA81+4qsLIjDWZpW7Dy9978QBsVfjvsTV0qLRCMI5J2E08ZbX8SOm
         Usc0e9ryV0ixWyNMZMipLeOFjOq8rH7KQ1auzXbJOmONQuq99NrlCnPjCuMBML1ZoK+S
         i9Yu0PxvQeIwwZStl31L42tPMCPg4bsjQ+wrW9VaK8ZU9bn6Leqd5L9mXM0UQ1Mx0CBN
         tSJw==
X-Gm-Message-State: AAQBX9dyJgMIpqXn7sf/kS2A0t/VuG79WwXGb7b7qpoh46bPCVKuD6uh
        ugc6wOHJ4GxDQIMqLUkpQPx2p2woBt7ARquanExqvcauSkOrIq4j9WmAp2xXrbmMd8881mhBcsM
        Ujw/fXJ6HMdrz
X-Received: by 2002:ac2:596f:0:b0:4eb:e03:9e6c with SMTP id h15-20020ac2596f000000b004eb0e039e6cmr1997556lfp.33.1680203101213;
        Thu, 30 Mar 2023 12:05:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350aLpoXMI1x1xPT2ugdceXR972Lacx2zk/SiRRmV+Uf/xnP2xCALcA41ZMbTbuQxJnhXH31Y/w==
X-Received: by 2002:ac2:596f:0:b0:4eb:e03:9e6c with SMTP id h15-20020ac2596f000000b004eb0e039e6cmr1997548lfp.33.1680203100914;
        Thu, 30 Mar 2023 12:05:00 -0700 (PDT)
Received: from [192.168.42.100] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id v28-20020ac2593c000000b004e9b42d778esm57581lfi.26.2023.03.30.12.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 12:05:00 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3423b37b-43d7-e9ee-6b1b-768b255a2773@redhat.com>
Date:   Thu, 30 Mar 2023 21:04:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net,
        anthony.l.nguyen@intel.com, yoong.siang.song@intel.com,
        boon.leong.ong@intel.com, intel-wired-lan@lists.osuosl.org,
        pabeni@redhat.com, jesse.brandeburg@intel.com, kuba@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, hawk@kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH bpf RFC-V3 0/5] XDP-hints: API change for RX-hash kfunc
 bpf_xdp_metadata_rx_hash
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
References: <168019602958.3557870.9960387532660882277.stgit@firesoul>
 <ZCXXIvvnTBch/0Oz@google.com>
In-Reply-To: <ZCXXIvvnTBch/0Oz@google.com>
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


On 30/03/2023 20.38, Stanislav Fomichev wrote:
> On 03/30, Jesper Dangaard Brouer wrote:
>> Notice targeted 6.3-rc kernel via bpf git tree.
> 
>> Current API for bpf_xdp_metadata_rx_hash() returns the raw RSS hash value,
>> but doesn't provide information on the RSS hash type (part of 6.3-rc).
> 
>> This patchset proposal is to change the function call signature via adding
>> a pointer value argument for provide the RSS hash type.
> 
>> Alternatively we disable bpf_xdp_metadata_rx_hash() in 6.3-rc, and have
>> more time to nitpick the RSS hash-type bits.
> 
> LGTM with one nit about EMIT_BTF.
> 

Great, others please review, so I can incorporate for tomorrow.
I will send a official patchset V4 tomorrow.

--Jesper

