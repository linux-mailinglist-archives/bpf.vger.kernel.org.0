Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931E16C32EF
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 14:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCUNdE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 09:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCUNdE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 09:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118832ED45
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 06:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679405539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XAb2uxPKaKIV+ehim9J4b/qc8T7HsQ8APwR4QoSZVhY=;
        b=GZ1kaYSN1GJqzuxJCpSJLjQ93DiXhBrM/LdhvcqPxKvd9bDOkkGac1uj0lUDOvFhb40PFz
        Kp6JYWxcKsCOwuA5+WQTMCvdXkYPOnTo3Bp/LM1JhT6oY9jMVjDENSd0Ez+pJTKNPTsIgx
        mo8qTHm2T7qHg/NsVt+nGNwZbMC2ewg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-OMWp0hKvPwizUr8-GblZYA-1; Tue, 21 Mar 2023 09:32:11 -0400
X-MC-Unique: OMWp0hKvPwizUr8-GblZYA-1
Received: by mail-ed1-f71.google.com with SMTP id m18-20020a50d7d2000000b00501dfd867a4so2064766edj.20
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 06:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679405529;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAb2uxPKaKIV+ehim9J4b/qc8T7HsQ8APwR4QoSZVhY=;
        b=yf68C57c4isP+wrQGUoGEDdwA3rCqyxacmdjE+Tl0kMwB/T9PXwdG/Go76IpN0XTIR
         oLdeUptyRjIvfE60CYaxeEgIbBMtiXQfCVJjSGTgE5jNz+1jF/HX4KAZr2VkomPP0uAF
         cYDHq7Z8f6H/8fWEO46DFUt778Sz+EXL+YwC0x9X+Zl4OIa38IoBiIx8sywK+gZYDhv5
         P71cIPh8qAp99X04uX++jRCCYR2zC2ErR0z8JpPViCROMIFjTFre36LP37h8xYnis+dX
         Ha2CL46/c9Klj//gbyOjGadv2TcuYVr3xfkj7Y8Xeoos6n9i1LVqcnpd9uPfZA9VV2Ag
         3dTQ==
X-Gm-Message-State: AO0yUKWP+ifXVERq6kSkXl0Hw+OTkYshoWwt2Q4IVFmaIULj+lw6z+kP
        ac5vNumrPlbKQ/HQVl85RbcUrQpfMgBEgUMNkDveOYgMjywSbWMZF8z1YilVg4o4AwiInSv2R/K
        j4BS4c3YdepM7
X-Received: by 2002:a17:906:14c2:b0:932:35b1:47f8 with SMTP id y2-20020a17090614c200b0093235b147f8mr2654432ejc.34.1679405529044;
        Tue, 21 Mar 2023 06:32:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set81J2bqWCjI8tdWygfhO8d83WHUen2iHUass/RxzdNgyGmELyDyU0u1VQUNZ+2byG3sKFHSwg==
X-Received: by 2002:a17:906:14c2:b0:932:35b1:47f8 with SMTP id y2-20020a17090614c200b0093235b147f8mr2654413ejc.34.1679405528787;
        Tue, 21 Mar 2023 06:32:08 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id lt11-20020a170906fa8b00b008e54ac90de1sm5790753ejb.74.2023.03.21.06.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 06:32:08 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <8edd0206-0f2a-d5e7-27de-a0a9cc92526e@redhat.com>
Date:   Tue, 21 Mar 2023 14:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        martin.lau@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        alexandr.lobakin@intel.com, larysa.zaremba@intel.com,
        xdp-hints@xdp-project.net, anthony.l.nguyen@intel.com,
        yoong.siang.song@intel.com, boon.leong.ong@intel.com
Subject: Re: [PATCH bpf-next V1 4/7] selftests/bpf: xdp_hw_metadata RX hash
 return code info
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>
References: <167906343576.2706833.17489167761084071890.stgit@firesoul>
 <167906361094.2706833.8381428662566265476.stgit@firesoul>
 <ZBTX7CBzNk9SaWgx@google.com>
In-Reply-To: <ZBTX7CBzNk9SaWgx@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 17/03/2023 22.13, Stanislav Fomichev wrote:
> On 03/17, Jesper Dangaard Brouer wrote:
>> When driver developers add XDP-hints kfuncs for RX hash it is
>> practical to print the return code in bpf_printk trace pipe log.
> 
>> Print hash value as a hex value, both AF_XDP userspace and bpf_prog,
>> as this makes it easier to spot poor quality hashes.
> 
>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>
> 
> (with a small suggestion below, maybe can do separately?)
> 
>> ---
>>   .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |    9 ++++++---
>>   tools/testing/selftests/bpf/xdp_hw_metadata.c      |    5 ++++-
>>   2 files changed, 10 insertions(+), 4 deletions(-)
[...]
>> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c 
>> b/tools/testing/selftests/bpf/xdp_hw_metadata.c
>> index 400bfe19abfe..f3ec07ccdc95 100644
>> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
>> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
>> @@ -3,6 +3,9 @@
>>   /* Reference program for verifying XDP metadata on real HW. 
>> Functional test
>>    * only, doesn't test the performance.
>>    *
> 
> [..]
> 
>> + * BPF-prog bpf_printk info outout can be access via
>> + * /sys/kernel/debug/tracing/trace_pipe
> 
> Maybe we should just dump the contents of
> /sys/kernel/debug/tracing/trace for every poll cycle?
> 

I think this belongs to a separate patch.

> We can also maybe enable tracing in this program transparently?
> I usually forget 'echo 1 >
> /sys/kernel/debug/tracing/events/bpf_trace/bpf_trace_printk/enable'
> myself :-)
> 
What is this trick?

--Jesper

