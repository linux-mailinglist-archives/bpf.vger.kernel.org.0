Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5125F55BE
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 15:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJENnu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 09:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJENnt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 09:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BFF6372
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664977427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GsSbujtCTt+IW+d/rBXbBcKeW+BBGKycYoOIn8QFlQI=;
        b=jUcbz4Gm1vnl8N5JnrH4g1lqpGijg+124lZpGav6nirRWYD1SxlQzHlLMKwoh57J3TyFg+
        ibfTWWzmRMhnPCaVql2NuSMTjIIdCBW53joHV/RtVSBFgMLVf+gNqoAbPnTW/z7e5uASad
        DhykHhk2Ng8admXciQC1MbzJevnA7AM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-265-Uquk02vwNqepZq3OpHOfeA-1; Wed, 05 Oct 2022 09:43:46 -0400
X-MC-Unique: Uquk02vwNqepZq3OpHOfeA-1
Received: by mail-ej1-f72.google.com with SMTP id sh33-20020a1709076ea100b0078d28567b70so1164526ejc.16
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 06:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=GsSbujtCTt+IW+d/rBXbBcKeW+BBGKycYoOIn8QFlQI=;
        b=UVnln13yL3VmQEDg+IHUvZl9UGqRRAcdhZ+NJ6KqxY6IAwTCToSq76ThZiU1PK80Kk
         r0XBdHbuww3yNOYgSgD8ptF3PZB6+P5ZrGAVgxgj3pzGGYldf0F832U/T7HhxibFoRZR
         OEuZbomgrde5oGGxfUdb1Hvzd6Qrkb3zyGt6KC0vYy0V++mZ6K7frS6uicGp89GoEzGB
         bLGcyj77bUK+ortZKO+ouGhRr/ebhUZOaFG09q18JnFHFayoLL4kEOEDXLEpxQhZmeNm
         o2u3qS229lG2aXNgUDV6QayIqnEa0QGM08ind+821eUR5HPoXciC9BWqfY8iRQuc0Lwo
         3Jug==
X-Gm-Message-State: ACrzQf3jbkKjuEPGZ5cNS64OGob6+rGTA/xNfV9PkX7RrNsC3Zz4CsGN
        VNk2kuzr+GvczV3cLDHl3p2G8svhPPdN2zPSzsk0sBE6LRjCNG1Gq/wW5PoybCMwqP39z91dNTh
        C1bud99vjjh5D
X-Received: by 2002:a05:6402:3806:b0:450:bad8:8cd5 with SMTP id es6-20020a056402380600b00450bad88cd5mr29071230edb.305.1664977425132;
        Wed, 05 Oct 2022 06:43:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4tKV4IdZ6t5ipdEbNxxbfP4IIcnxZBulYixB9jOklWI6+RrrOCPSFkdrSDcafwl7LtCwE9+g==
X-Received: by 2002:a05:6402:3806:b0:450:bad8:8cd5 with SMTP id es6-20020a056402380600b00450bad88cd5mr29071198edb.305.1664977424819;
        Wed, 05 Oct 2022 06:43:44 -0700 (PDT)
Received: from [192.168.41.81] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id la3-20020a170907780300b00781dbdb292asm8634645ejc.155.2022.10.05.06.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 06:43:44 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <404395ad-ad96-d300-a7fe-1116c9fd7b57@redhat.com>
Date:   Wed, 5 Oct 2022 15:43:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Cc:     brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        xdp-hints@xdp-project.net, larysa.zaremba@intel.com,
        memxor@gmail.com, Lorenzo Bianconi <lorenzo@kernel.org>,
        mtahhan@redhat.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dave@dtucker.co.uk, Magnus Karlsson <magnus.karlsson@intel.com>,
        bjorn@kernel.org
Subject: Re: [PATCH RFCv2 bpf-next 00/18] XDP-hints: XDP gaining access to HW
 offload hints via BTF
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
References: <166256538687.1434226.15760041133601409770.stgit@firesoul>
 <Yzt2YhbCBe8fYHWQ@google.com>
 <35fcfb25-583a-e923-6eee-e8bbcc19db17@redhat.com>
 <CAKH8qBuYVk7QwVOSYrhMNnaKFKGd7M9bopDyNp6-SnN6hSeTDQ@mail.gmail.com>
 <5ccff6fa-0d50-c436-b891-ab797fe7e3c4@linux.dev>
In-Reply-To: <5ccff6fa-0d50-c436-b891-ab797fe7e3c4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 05/10/2022 02.25, Martin KaFai Lau wrote:
> For rx hwtimestamp, the value could be just 0 if a specific hw/driver 
> cannot provide it for all packets while some other hw can.

Keep in mind that we want to avoid having to write a (64-bit) zero into
the metadata for rx_hwtimestamp, for every packet that doesn't carry a
timestamp.  It essentially reverts back to clearing memory like with
SKBs, due to performance overhead we don't want to go that path again!

There are multiple ways to avoid having to zero init the memory.

In this patchset I have choosen have the traditional approach of flags
(u32) approach located in xdp_hints_common, e.g. setting a flag if the
field is valid (p.s. John Fastabend convinced me of this approach ;-)).
But COMBINED with: some BTF ID layouts doesn't contain some fields e.g.
the rx_timestamp, thus the code have no reason to query those flag fields.


I am intrigued to find a way to leverage bpf_core_field_exists() some
more (as proposed by Stanislav).  (As this can allow for dead-code
elimination).

--Jesper

