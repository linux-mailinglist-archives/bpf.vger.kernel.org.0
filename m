Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAAB682D2F
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 14:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjAaNBo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 08:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjAaNBj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 08:01:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E24C4940C
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 05:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675170055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kVKjWSpLDvuDVRuKElJrADcF9968GW/ss8fqJreCpew=;
        b=L8bXjGx+VwWLo3SQebyP58X2EuMw2P0ggOUrx0mrQEgdJNV+7hJ5GGip2pFUZtOzQ0j36s
        7aihnNUn1A9HuqGdJQoMxkwDC2e5wAiwx2gfkj3dFPTlBUtMgYUMmOH3Ku1FgWcagZNX3/
        JRzw59xny1jPA735piPln/E+OuZSv7g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-NMJdZzuIPMalVc1z-Tix5Q-1; Tue, 31 Jan 2023 08:00:46 -0500
X-MC-Unique: NMJdZzuIPMalVc1z-Tix5Q-1
Received: by mail-ej1-f69.google.com with SMTP id p16-20020a170906499000b0088c5a527c89so1267104eju.23
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 05:00:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVKjWSpLDvuDVRuKElJrADcF9968GW/ss8fqJreCpew=;
        b=tlCM5+yqpB1IK3vwZnJdD7/9u8WczZEATX44cZ5gNR/laowEvsyhJKpgHLfNPO9eZK
         CibTIToBioTr4ACEmXMFflILlTVi90SEf6dssVbjM89lOUwTHtXs7oQwATQKodZAwCqb
         b2eXTlkJU55FByy2rhzWwGWRaPRqN8a4JHzTW/twREP0+RAJwNdpcu+1jOJktsum62CF
         CpU5alXbPdpRT4pwWKFJIgRFqs2ufh/7FdoNQJ2KHiB1ukftVQvhDwOA86jBddfoVauy
         XSyQefhWsateig1LuZTbeZQzNzru/Ph0RB558bTlAyTtn1fJcj7MP+563N1L8OibPQ/a
         y4wA==
X-Gm-Message-State: AFqh2ko7VAVxvMsqc3tkngPlBPNruMyEORQFwoobTV3ovxl8R5XjLMP5
        j5MaMACN98Z2JL3urC0yJwU5uOHtUsChSRIWOdQhQ6Z1uvUsfij27B0W4gnHU/Yy7NXwtgpngDF
        WXFdL231WlmAJ
X-Received: by 2002:a05:6402:ea8:b0:494:fae3:c0df with SMTP id h40-20020a0564020ea800b00494fae3c0dfmr57280463eda.12.1675170035486;
        Tue, 31 Jan 2023 05:00:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvjR0KBlMU07/4Dzba2ATiXXKwyxEnlo1bOIaf+RRpi4wGrC/+v9rKvrKEe+/uXtZnBYML+Hg==
X-Received: by 2002:a05:6402:ea8:b0:494:fae3:c0df with SMTP id h40-20020a0564020ea800b00494fae3c0dfmr57280438eda.12.1675170035201;
        Tue, 31 Jan 2023 05:00:35 -0800 (PST)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906139900b0087b3d555d2esm7237432ejc.33.2023.01.31.05.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:00:34 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <839c6cbb-1572-b3a8-57eb-2aa2488101dd@redhat.com>
Date:   Tue, 31 Jan 2023 14:00:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        martin.lau@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, dsahern@gmail.com,
        willemb@google.com, void@manifault.com, kuba@kernel.org,
        xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] [PATCH bpf-next RFC V1] selftests/bpf:
 xdp_hw_metadata clear metadata when -EOPNOTSUPP
Content-Language: en-US
To:     Stanislav Fomichev <sdf@google.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <167482734243.892262.18210955230092032606.stgit@firesoul>
 <87cz70krjv.fsf@toke.dk>
 <CAKH8qBtc0TRorF2zsD0dZjgredpzcmczK=KMgt1mpEX_mQG2Kg@mail.gmail.com>
In-Reply-To: <CAKH8qBtc0TRorF2zsD0dZjgredpzcmczK=KMgt1mpEX_mQG2Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 27/01/2023 18.18, Stanislav Fomichev wrote:
> On Fri, Jan 27, 2023 at 5:58 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> Jesper Dangaard Brouer <brouer@redhat.com> writes:
>>
>>> The AF_XDP userspace part of xdp_hw_metadata see non-zero as a signal of
>>> the availability of rx_timestamp and rx_hash in data_meta area. The
>>> kernel-side BPF-prog code doesn't initialize these members when kernel
>>> returns an error e.g. -EOPNOTSUPP.  This memory area is not guaranteed to
>>> be zeroed, and can contain garbage/previous values, which will be read
>>> and interpreted by AF_XDP userspace side.
>>>
>>> Tested this on different drivers. The experiences are that for most
>>> packets they will have zeroed this data_meta area, but occasionally it
>>> will contain garbage data.
>>>
>>> Example of failure tested on ixgbe:
>>>   poll: 1 (0)
>>>   xsk_ring_cons__peek: 1
>>>   0x18ec788: rx_desc[0]->addr=100000000008000 addr=8100 comp_addr=8000
>>>   rx_hash: 3697961069
>>>   rx_timestamp:  9024981991734834796 (sec:9024981991.7348)
>>>   0x18ec788: complete idx=8 addr=8000
>>>
>>> Converting to date:
>>>   date -d @9024981991
>>>   2255-12-28T20:26:31 CET
>>>
>>> I choose a simple fix in this patch. When kfunc fails or isn't supported
>>> assign zero to the corresponding struct meta value.
>>>
>>> It's up to the individual BPF-programmer to do something smarter e.g.
>>> that fits their use-case, like getting a software timestamp and marking
>>> a flag that gives the type of timestamp.
>>>
>>> Another possibility is for the behavior of kfunc's
>>> bpf_xdp_metadata_rx_timestamp and bpf_xdp_metadata_rx_hash to require
>>> clearing return value pointer.
>>
>> I definitely think we should leave it up to the BPF programmer to react
>> to failures; that's what the return code is there for, after all :)
> 
> +1

+1 I agree.
We should keep this default functions as simple as possible, for future
"unroll" of BPF-bytecode.

I the -EOPNOTSUPP case (default functions for drivers not implementing
kfunc), will likely be used runtime by BPF-prog to determine if the
hardware have this offload hint, but it comes with the overhead of a
function pointer call.

I hope we can somehow BPF-bytecode "unroll" these (default functions) at
BPF-load time, to remove this overhead, and perhaps even let BPF
bytecode do const propagation and code elimination?


> Maybe we can unconditionally memset(meta, sizeof(*meta), 0) in
> tools/testing/selftests/bpf/progs/xdp_hw_metadata.c?
> Since it's not a performance tool, it should be ok functionality-wise.

I know this isn't a performance test, but IMHO always memsetting
metadata area is a misleading example.  We know from experience that
developer simply copy-paste code examples, even quick-n-dirty testing
example code.

The specific issue in this example can lead to hard-to-find bugs, as my
testing shows it is only occasionally that data_meta area contains
garbage. We could do a memset, but it deserves a large code comment, why
this is needed, so people copy-pasting understand. I choose current
approach to keep code close to code people will copy-paste.

--Jesper

