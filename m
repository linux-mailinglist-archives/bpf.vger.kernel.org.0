Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB2565D8F
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 20:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiGDSoN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jul 2022 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiGDSoM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 14:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D16C36418
        for <bpf@vger.kernel.org>; Mon,  4 Jul 2022 11:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656960250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XeGRpP6ZId+7T6ByVHweuCJUQTeXWvQUlmQR22hrw0=;
        b=eJjxJMTBDDCYTQ7Fy9rVo02zrgZNmjEtJMgnBNe0jpfXLYZROF5nhnrRjGq6Knp3jsmC/a
        RF0qIeYVeDRFd3SADEccwIgPADtpt2Hbe78C8HJOZ0Px9kcb1b9m+Lp/v7MxfwBe11gjr5
        n3t9skz855onq2sajKWi87tznkGZe8g=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-3y3nNP7RN-6F7GZrqMet2A-1; Mon, 04 Jul 2022 14:44:09 -0400
X-MC-Unique: 3y3nNP7RN-6F7GZrqMet2A-1
Received: by mail-lf1-f71.google.com with SMTP id j12-20020a056512028c00b00482dd0d9748so351421lfp.8
        for <bpf@vger.kernel.org>; Mon, 04 Jul 2022 11:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=/XeGRpP6ZId+7T6ByVHweuCJUQTeXWvQUlmQR22hrw0=;
        b=HexSG88P98VErWZvGHmwGFl0Q6Ym3wKZ+PLXCpGCWRAeA7j5QOSlifVIPBootKLxqE
         JX72iXla5xcyH3AZWVHAs9zFewq8ukzirv41ax1lT7nbp/Md+AmBYKj4b64KNXrJfpjb
         ffBmp+IaYWXk7V7eDEuxUeTgU9jbP5rofInF1nvSrJm15W1quRHsSYlHy6tlEmoHePU1
         DcgUG/OklH3N8YjVNv/U+PZRqOxTLgsKArl3l5JEuWvVs6CnUAtArtC0D1h2kmKljk2y
         1G71SdXQnslrIVdBaGmBc5Gk25GAV8FXO8l9cbPW3WPmvVz7DBowT3dav48wW3oJre3g
         MdsQ==
X-Gm-Message-State: AJIora/fXw6cEPm57Hh+v4S0Jazk8puIYnf3JnHujwAn2HFzukFZG/61
        KrL+LKGeNV77sufB1sUoI+rlUBL7a0DBO2MkHeT8sRz4T2XOyu4bihyt1aZTFeteFb7KKYH1vrv
        9d+1JW4mzZbDN
X-Received: by 2002:a2e:a786:0:b0:25b:c51a:2c0b with SMTP id c6-20020a2ea786000000b0025bc51a2c0bmr17302936ljf.215.1656960248338;
        Mon, 04 Jul 2022 11:44:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sUjZDQTJKS/cC/EbwD6uXZ8y+pFvj472qgkIKZD5nHhQ69eebfOBxPU6CyfijqaCYd1r2I6g==
X-Received: by 2002:a2e:a786:0:b0:25b:c51a:2c0b with SMTP id c6-20020a2ea786000000b0025bc51a2c0bmr17302926ljf.215.1656960248133;
        Mon, 04 Jul 2022 11:44:08 -0700 (PDT)
Received: from [192.168.0.50] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id c2-20020ac25f62000000b00478f3fe716asm5254746lfc.200.2022.07.04.11.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 11:44:07 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <263b8398-01fa-a8df-09d9-69bd8e49bc1e@redhat.com>
Date:   Mon, 4 Jul 2022 20:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Cc:     brouer@redhat.com, "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>, Xdp <xdp-newbies@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests, bpf: remove AF_XDP samples
Content-Language: en-US
To:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <20220630093717.8664-1-magnus.karlsson@gmail.com>
 <fa929729-6122-195f-aa4b-e5d3fedb1887@redhat.com>
 <CAJ8uoz2KmpVf7nkJXUsHhmOtS2Td+rMOX8-PRqzz9QxJB-tZ3g@mail.gmail.com>
In-Reply-To: <CAJ8uoz2KmpVf7nkJXUsHhmOtS2Td+rMOX8-PRqzz9QxJB-tZ3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 30/06/2022 16.20, Magnus Karlsson wrote:
> On Thu, Jun 30, 2022 at 3:44 PM Jesper Dangaard Brouer
> <jbrouer@redhat.com> wrote:
>>
>>
>> On 30/06/2022 11.37, Magnus Karlsson wrote:
>>> From: Magnus Karlsson <magnus.karlsson@intel.com>
>>>
>>> Remove the AF_XDP samples from samples/bpf as they are dependent on
>>> the AF_XDP support in libbpf. This support has now been removed in the
>>> 1.0 release, so these samples cannot be compiled anymore. Please start
>>> to use libxdp instead. It is backwards compatible with the AF_XDP
>>> support that was offered in libbpf. New samples can be found in the
>>> various xdp-project repositories connected to libxdp and by googling.
>>>
>>> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
>>
>> Will you (or Maciej) be submitting these samples to XDP-tools[1] which
>> is the current home for libxdp or maybe BPF-examples[2] ?
>>
>>    [1] https://github.com/xdp-project/xdp-tools
>>    [2] https://github.com/xdp-project/bpf-examples
>>
>> I know Toke is ready to take over maintaining these, but we will
>> appreciate someone to open a PR with this code...
>>
>>> ---
>>>    MAINTAINERS                     |    2 -
>>>    samples/bpf/Makefile            |    9 -
>>>    samples/bpf/xdpsock.h           |   19 -
>>>    samples/bpf/xdpsock_ctrl_proc.c |  190 ---
>>>    samples/bpf/xdpsock_kern.c      |   24 -
>>>    samples/bpf/xdpsock_user.c      | 2019 -------------------------------
>>>    samples/bpf/xsk_fwd.c           | 1085 -----------------
>>
>> The code in samples/bpf/xsk_fwd.c is interesting, because it contains a
>> buffer memory manager, something I've seen people struggle with getting
>> right and performant (at the same time).
> 
> I can push xsk_fwd to BPF-examples. Though I do think that xdpsock has
> become way too big to serve as a sample. It slowly turned into a catch
> all demonstrating every single feature of AF_XDP. We need a minimal
> example and then likely other samples for other features that should
> be demoed. So I suggest that xdpsock dies here and we start over with
> something minimal and use xsk_fwd for the forwarding and mempool
> example.

I trust that we in bpf-examples[0] will see a PR with this from 
you/Intel, so:

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>


> Toke, I think you told me at Recipes in Paris that someone from RedHat
> was working on an example. Did I remember correctly?
> 
>> You can get my ACK if someone commits to port this to [1] or [2], or a
>> 3rd place that have someone what will maintain this in the future.
>>

[0] https://github.com/xdp-project/bpf-examples/

