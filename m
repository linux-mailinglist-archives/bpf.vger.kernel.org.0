Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140486DFB1D
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 18:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjDLQTF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 12:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDLQTD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 12:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6867EF8
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 09:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681316270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qnf9yElTQYFqrnMLB45LKI8SRk00USkcv5dSbMkmIug=;
        b=DvnolR8YX++WOjUDP1uLvjIxl9ptFSaVicRPN0VStYaiq/dTrBmE+k2A+MwSjYuPP4paoG
        4khaYjgUEgQl4tZ5/Ph4GMTi4bG5flaySvWW7XpUt8oMsAWbQblfYCgLnDxPU07O9VlVmr
        dVs5cOqTXXLSrPjVF7/oPAlebeZSBgw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-Akk6q137PUqz5KNq7lws-w-1; Wed, 12 Apr 2023 12:17:47 -0400
X-MC-Unique: Akk6q137PUqz5KNq7lws-w-1
Received: by mail-ed1-f72.google.com with SMTP id d2-20020a50f682000000b0050503f2097aso1336022edn.14
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 09:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681316266; x=1683908266;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnf9yElTQYFqrnMLB45LKI8SRk00USkcv5dSbMkmIug=;
        b=B1D4hliwDJrbvimH6IkE3DvbmAHUnYYqCasjFLgOo/lVKEZ25DJjCysORFoQE1CLOL
         jw1zxZeuf4UEvvhx2Gnepe8b4956YskJKsK+ETNP5BE4VSbYCCb0qsde7aGUM4rY72R9
         DrAJKjMFN37Y7MmXfddDUpSQHyNYxIT3XVcgf+ij7DvjAZywkdKcWTUE2Q3Ilq2N1/Dw
         K5Z7+hO56l02v955u1CKuW+Ow/rXvFdBiLRSK6qgTtSG/dWFPOG3FDqoFtSbAoS90GDS
         +pkNWWLBNCLcxVF0CCmZPKhyYBjIqFrNUWTKyRyxKsfcZq0VZr6Evo1+JCgu+aMS0i8j
         1Q2A==
X-Gm-Message-State: AAQBX9fUFnTBd2Ows9JaXqro9yWE6BRTC+qdtShYbkuWKnUAg6J+bSHg
        kP/iiyS7IVDjP+pMQoB+gbZp4lcG/yoeDvt6swE4Hv3x6itwiZv7VKWrnefOn2rHebLBVaZ/LlD
        u8HqP1eR3zZ5c
X-Received: by 2002:a17:906:3e1b:b0:947:4481:105b with SMTP id k27-20020a1709063e1b00b009474481105bmr6122411eji.3.1681316266557;
        Wed, 12 Apr 2023 09:17:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZkmzRiKnM5DrNfQCtjR0yrisjPx1y54Hxkhfskk9JB9nxG0DC8iSLZdPvUzGtB9AGnC+h9og==
X-Received: by 2002:a17:906:3e1b:b0:947:4481:105b with SMTP id k27-20020a1709063e1b00b009474481105bmr6122388eji.3.1681316266222;
        Wed, 12 Apr 2023 09:17:46 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id hs40-20020a1709073ea800b009351546fb54sm7328025ejc.28.2023.04.12.09.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 09:17:45 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <867e3607-52e0-8c02-8dbb-92bb997f079e@redhat.com>
Date:   Wed, 12 Apr 2023 18:17:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, bpf@vger.kernel.org,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        alexandr.lobakin@intel.com, larysa.zaremba@intel.com,
        xdp-hints@xdp-project.net, anthony.l.nguyen@intel.com,
        yoong.siang.song@intel.com, boon.leong.ong@intel.com,
        intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
        jesse.brandeburg@intel.com, kuba@kernel.org, edumazet@google.com,
        john.fastabend@gmail.com, hawk@kernel.org, davem@davemloft.net,
        tariqt@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
        linux-rdma@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH bpf V7 1/7] selftests/bpf: xdp_hw_metadata default disable
 bpf_printk
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <168098183268.96582.7852359418481981062.stgit@firesoul>
 <168098188134.96582.7870014252568928901.stgit@firesoul>
 <CAKH8qBu2ieR+puSkF30-df3YikOvDZErxc2qjjVXPPAvCecihA@mail.gmail.com>
 <402a3c73-d26d-3619-d69a-c90eb3f0e9ee@redhat.com>
 <ZDbXEqQc3MpKPmGv@google.com>
In-Reply-To: <ZDbXEqQc3MpKPmGv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 12/04/2023 18.06, Stanislav Fomichev wrote:
> On 04/12, Jesper Dangaard Brouer wrote:
>> On 12/04/2023 00.42, Stanislav Fomichev wrote:
>>> On Sat, Apr 8, 2023 at 12:24 PM Jesper Dangaard Brouer
>>>>
[...]
>>>
>>> Are you planning to eventually do somethike similar to what I've
>>> mentioned in [0]? If not, should I try to send a patch?
>>
>> See next patch:
>>   - [PATCH bpf V7 2/7] selftests/bpf: Add counters to xdp_hw_metadata
>>
>> where I add these counters :-)
> 
> Oh, nice, let me take a look. I was assuming v7 is mostly the same as
> v6..
>   

Alexei explicitly asked for these changes to be included in V7.
Notice, I've already send out a [V8] (addressing Simon's notes).
Please take a look at V8 instead of V7.
We are at RC6 and I hope we soon have something we can agree on.


[V8] 
https://lore.kernel.org/all/168130333143.150247.11159481574477358816.stgit@firesoul/

[patchwork] 
https://patchwork.kernel.org/project/netdevbpf/list/?series=739144&state=%2A&archive=both


--Jesper

