Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE1F6C4FCC
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 16:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjCVP6c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 11:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCVP6b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 11:58:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D806486C
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679500662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sigT2R9uIcwlR9W7ZCCufyIQLe9oLQ0ypEEE7tJ90Yo=;
        b=BJlNMk1XeSdyKqSveLKGjoZWqXyNikqr2T1QHL/zi4v58Kn3oENvs+MjjHfDUcZYDlmwvH
        5n9Ih9RVLCd5sEzfN02M2qXUS7V6trXOKnnlK16VxxXOgqpuF9ia12Z7se8BZrq4d7JtSZ
        pju4ZMJFMM7gawqVn8slzMXbjlrKIXQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-2dw2786yNIerjYq-X-6hdA-1; Wed, 22 Mar 2023 11:57:40 -0400
X-MC-Unique: 2dw2786yNIerjYq-X-6hdA-1
Received: by mail-ed1-f71.google.com with SMTP id t26-20020a50d71a000000b005003c5087caso26194705edi.1
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 08:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679500659;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sigT2R9uIcwlR9W7ZCCufyIQLe9oLQ0ypEEE7tJ90Yo=;
        b=riZR0t9wIsm4awfbDiR9iQ2wgHvPLkNm01ChdhKKRm6NDsjvvZnwslOKWTjZHJtg8W
         FLlcdy46V15tOcOt+BYUFhpqUrPPTh/D5QfdlAmo3PntPF8vXb9Ky4K8QvDjHnwtPlwe
         h6QpRP8hG6A/nbj7WYmEs8+YsVqSMSnVSorqSDKDuOW2tuYEIudOuZozKL8eitSeGbfU
         RLIGpVnnFn4qDS9NQj9p3dg36fkOL3kaqIqLklQLTT/tSGluIhw9Mg4h9FtLkQLSdxD+
         fLKjamGugBFRdzvfMItqYDXs/FkQWR30Pz815i1mcmqnpbjpmzbti0r7MrVJkHW89gBp
         XL1Q==
X-Gm-Message-State: AO0yUKW3Z2DVEH5tY0GRumKb99NgtX3b1z87YCqaB88NTuwKOklgq2p/
        0Goy/91L71F59HXrnSGs5l7e2xvK3boVuRKL52XH7b+LV/oKKwD1H87Nxi4vcOkZ8aMZaFcB4oI
        RrpsBl8ijgU6k
X-Received: by 2002:a17:906:1853:b0:92f:fc08:bb0a with SMTP id w19-20020a170906185300b0092ffc08bb0amr7172256eje.37.1679500659688;
        Wed, 22 Mar 2023 08:57:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set9fkk/QFCBQcadzxl/lPAWqLf42GpkbOwji4VtQJtZYST5h158xmD4SDUjEKLyq/7tc1ZJzmw==
X-Received: by 2002:a17:906:1853:b0:92f:fc08:bb0a with SMTP id w19-20020a170906185300b0092ffc08bb0amr7172228eje.37.1679500659403;
        Wed, 22 Mar 2023 08:57:39 -0700 (PDT)
Received: from [192.168.42.100] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906c00800b008e1509dde19sm7321305ejz.205.2023.03.22.08.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 08:57:38 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <b12c88b4-6921-8a12-e8c5-8ec950ec8d48@redhat.com>
Date:   Wed, 22 Mar 2023 16:57:36 +0100
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
To:     Stanislav Fomichev <sdf@google.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <167906343576.2706833.17489167761084071890.stgit@firesoul>
 <167906361094.2706833.8381428662566265476.stgit@firesoul>
 <ZBTX7CBzNk9SaWgx@google.com>
 <8edd0206-0f2a-d5e7-27de-a0a9cc92526e@redhat.com>
 <CAKH8qBvm24VJS4RMNUjHi24LqpYJnOYs_Md-J3FCEvp2vm7rcg@mail.gmail.com>
In-Reply-To: <CAKH8qBvm24VJS4RMNUjHi24LqpYJnOYs_Md-J3FCEvp2vm7rcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 21/03/2023 19.45, Stanislav Fomichev wrote:
> On Tue, Mar 21, 2023 at 6:32 AM Jesper Dangaard Brouer
> <jbrouer@redhat.com> wrote:
>>
>>
>>
>> On 17/03/2023 22.13, Stanislav Fomichev wrote:
>>> On 03/17, Jesper Dangaard Brouer wrote:
>>>> When driver developers add XDP-hints kfuncs for RX hash it is
>>>> practical to print the return code in bpf_printk trace pipe log.
>>>
>>>> Print hash value as a hex value, both AF_XDP userspace and bpf_prog,
>>>> as this makes it easier to spot poor quality hashes.
>>>
>>>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
>>>
>>> Acked-by: Stanislav Fomichev <sdf@google.com>
>>>
>>> (with a small suggestion below, maybe can do separately?)
>>>
>>>> ---
>>>>    .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |    9 ++++++---
>>>>    tools/testing/selftests/bpf/xdp_hw_metadata.c      |    5 ++++-
>>>>    2 files changed, 10 insertions(+), 4 deletions(-)
>> [...]
>>>> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c
>>>> b/tools/testing/selftests/bpf/xdp_hw_metadata.c
>>>> index 400bfe19abfe..f3ec07ccdc95 100644
>>>> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
>>>> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
>>>> @@ -3,6 +3,9 @@
>>>>    /* Reference program for verifying XDP metadata on real HW.
>>>> Functional test
>>>>     * only, doesn't test the performance.
>>>>     *
>>>
>>> [..]
>>>
>>>> + * BPF-prog bpf_printk info outout can be access via
>>>> + * /sys/kernel/debug/tracing/trace_pipe
>>>
>>> Maybe we should just dump the contents of
>>> /sys/kernel/debug/tracing/trace for every poll cycle?
>>>
>>
>> I think this belongs to a separate patch.
> 
> SG. If you prefer to keep the comment let's also s/outout/outPut/.

Sorry, missed this... will fix in V3

> 
>>> We can also maybe enable tracing in this program transparently?
>>> I usually forget 'echo 1 >
>>> /sys/kernel/debug/tracing/events/bpf_trace/bpf_trace_printk/enable'
>>> myself :-)
>>>
>> What is this trick?
> 
> On the recent kernels I think this event has to be explicitly enabled
> for bpf_prink() to work? Not sure.

The output still work for me then I have zero in 
/sys/kernel/debug/tracing/events/bpf_trace/bpf_trace_printk/enable

> That's why having something like enable_tracing() and dump_trace()
> here might be helpful for whoever is running the prog.
> 

