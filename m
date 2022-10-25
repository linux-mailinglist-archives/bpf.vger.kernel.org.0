Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D654E60CB72
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 14:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiJYMBl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 08:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJYMBj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 08:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C577E838
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 05:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666699296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3NP8R3IYLYmihDVV7WTD3Rj7jwPsio2DD4wfaKkI+8g=;
        b=OHAfDx4DUhklVk3bF9Xg4GK3yzeAvR0kVhflgYWA5Q6Dc4ueU6LBHyW9oeOBdDTld5CZRo
        XLvpVttbjP11k9cT8OVWsD8/I4vsMaLKapsolD79w0yicksigTM/WRRQsKZtHd3s6Ae/K6
        VwV9gTWbWJKku3/N5Y58ZsxgeezKnOw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-130-p2M0IV7lN8Gnq5c9WcKCqQ-1; Tue, 25 Oct 2022 08:01:26 -0400
X-MC-Unique: p2M0IV7lN8Gnq5c9WcKCqQ-1
Received: by mail-ed1-f71.google.com with SMTP id l18-20020a056402255200b0045d2674d1a0so11661480edb.0
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 05:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NP8R3IYLYmihDVV7WTD3Rj7jwPsio2DD4wfaKkI+8g=;
        b=hgd6gYdUx+Df2v1WR9gqDlL3qKwc8EP8gqTckzghdCNzza6HBOeuYVjfMsCU6PVQQO
         FyS0mDq8RT7idS6P1S+HBNdvF/7I62aIHo1u8EEZJ1h2E/NhfVWhk7qF/hwVf1TNAzeW
         nG0UBpdci9Y+/n73N/A7toI0EZOhdvGBqQ2Cfc7cBouJVJFBEBU1z1IMApNqwDLkAIbm
         7Xoolh3F4ol46f/uvSpjMUuMVNfLyKW/RgtLYAtx1yxWyvPaHm9ZzYCjj/x6Vv9rCgzj
         31Gq4F4c+l1RFJ5JIp48qKVvPEJN4am6IA/dKqdLd+YQP2noZvngg9J2eNoLW4Hl8lve
         AooA==
X-Gm-Message-State: ACrzQf10QXSsfCKozPerpoQK12+xfkFPenJeir7RhLbIFaJ3j7PCKlKs
        4IvYyMiH0VrnKkOGA0APTMTWtyZHafiZ1BqGa0bEEaozjg66qzoFPRdiVMdJZ0Dgv3aNbzLRufz
        xw5kPW2JcNF0b
X-Received: by 2002:a05:6402:371b:b0:460:ff7d:f511 with SMTP id ek27-20020a056402371b00b00460ff7df511mr25245226edb.148.1666699285908;
        Tue, 25 Oct 2022 05:01:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4ByvT9CqolkhMMGCNXFGUXy8yFRrjzmrcPaD532k849sniIIwZYUM7s8f6bl8PHwOomnxrwg==
X-Received: by 2002:a05:6402:371b:b0:460:ff7d:f511 with SMTP id ek27-20020a056402371b00b00460ff7df511mr25245210edb.148.1666699285731;
        Tue, 25 Oct 2022 05:01:25 -0700 (PDT)
Received: from [192.168.41.200] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id d25-20020aa7d699000000b00461c375d88csm1473403edr.97.2022.10.25.05.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:01:24 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <62d3043f-51cc-b003-1a43-43550641cfd9@redhat.com>
Date:   Tue, 25 Oct 2022 14:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Cc:     brouer@redhat.com, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/1] docs: BPF_MAP_TYPE_CPUMAP
Content-Language: en-US
To:     mtahhan@redhat.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221021093050.2711300-1-mtahhan@redhat.com>
In-Reply-To: <20221021093050.2711300-1-mtahhan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 21/10/2022 11.30, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_CPUMAP including
> kernel version introduced, usage and examples.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   Documentation/bpf/map_cpumap.rst | 166 +++++++++++++++++++++++++++++++
>   1 file changed, 166 insertions(+)
>   create mode 100644 Documentation/bpf/map_cpumap.rst

I was about to complain that this needed to be linked in file 
Documentation/bpf/maps.rst, but it seems it gets wildcard included.

I see Toke already gave you some feedback to address, so I'll wait for 
the next version to review.

--Jesper

