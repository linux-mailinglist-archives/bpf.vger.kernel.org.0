Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE81C5B39C1
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 15:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiIINs7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiIINst (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 09:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12C311B75A
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 06:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662731314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YImNobrFe/WhuWDTj42TmI0iV1ssLlERqxsuvNWDERI=;
        b=OJDq9yKdq7I7U3NdVH3sP1Pti7pNYtw/V/yK90sIJGNJxPAKgtBo19jFqRDy7KbElVDwbm
        ebv/duF8vnNIgUB6LLhqJySOLIPUdVS7JN+gCjlsm12qR15oJL66YmGAhHTE9u3MQ+fDBh
        M08hTBcEHU0cfu77asqIRl0iM6Uge4U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-316-b5sg6FpvP0KI1RwCMYmVOg-1; Fri, 09 Sep 2022 09:48:33 -0400
X-MC-Unique: b5sg6FpvP0KI1RwCMYmVOg-1
Received: by mail-ej1-f71.google.com with SMTP id gs35-20020a1709072d2300b00730e14fd76eso1052980ejc.15
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 06:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=YImNobrFe/WhuWDTj42TmI0iV1ssLlERqxsuvNWDERI=;
        b=lMe2yL0IkOuZccAwtdER/fpv4DAtCIK3lPHMMgTVXXQSBrQB2m9U6iKUaGmohUfEUQ
         RwhjG9nBdOSaTV7anK385c3bFsJFfMqNVW7foSpaGL2Bz5L8Elq7mGxNUZ/a+E32S/bt
         q2KOY6fQOgZmWrv/NGb+mJV3H0PbqU/SDwEW0fy6E4Dd7MK0tmw2Xh1Z0w0/ShcECysj
         c7giB3JI1uR4zPc3elQxKtDs2icYt/RWjzMe5m8/6FertpdfFPkDsXONkWOCpT+agg8V
         jnUvLuNhUaXcso0NCHY2yeIS4pJI+bblpT5Ew3NjcTH3MbzRuCf1r6aKqmQAvht3/Hy/
         h7VQ==
X-Gm-Message-State: ACgBeo1YLxnOHblAjnGE5gkG4PxORmsKTfRYL2Z7btlAl2Lio5RBSHQf
        XCmcVwFWqS+Wy6p0tX8JocwYLUOR+MGCg2ETj/gDLdwnQ+UVwIg52DsnkqbeQPqtVtHfCp9Rgtn
        ni1LEdj+DWZRx
X-Received: by 2002:a05:6402:2786:b0:448:e15d:ab0e with SMTP id b6-20020a056402278600b00448e15dab0emr11602229ede.91.1662731311938;
        Fri, 09 Sep 2022 06:48:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6N5xVGmsWUYQGhRgZqvZxQk2yqsaCgbYWlCDEXeY7sJ7OUl4WVZyP0sxTnug/6kY7xRheOcA==
X-Received: by 2002:a05:6402:2786:b0:448:e15d:ab0e with SMTP id b6-20020a056402278600b00448e15dab0emr11602201ede.91.1662731311724;
        Fri, 09 Sep 2022 06:48:31 -0700 (PDT)
Received: from [192.168.41.81] (83-90-141-187-cable.dk.customer.tdc.net. [83.90.141.187])
        by smtp.gmail.com with ESMTPSA id kw4-20020a170907770400b0073dcdf9b0bcsm338050ejc.17.2022.09.09.06.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 06:48:31 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <434a45f6-aaf6-3bf0-8efe-c28a6c8b604d@redhat.com>
Date:   Fri, 9 Sep 2022 15:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Cc:     brouer@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        xdp-hints@xdp-project.net, larysa.zaremba@intel.com,
        memxor@gmail.com, Lorenzo Bianconi <lorenzo@kernel.org>,
        mtahhan@redhat.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dave@dtucker.co.uk, Magnus Karlsson <magnus.karlsson@intel.com>,
        bjorn@kernel.org
Subject: Re: [xdp-hints] [PATCH RFCv2 bpf-next 00/18] XDP-hints: XDP gaining
 access to HW offload hints via BTF
Content-Language: en-US
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
References: <166256538687.1434226.15760041133601409770.stgit@firesoul>
 <20220908093043.274201-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220908093043.274201-1-alexandr.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 08/09/2022 11.30, Alexander Lobakin wrote:
> From: Jesper Dangaard Brouer <brouer@redhat.com>
> Date: Wed, 07 Sep 2022 17:45:00 +0200
> 
>> This patchset expose the traditional hardware offload hints to XDP and
>> rely on BTF to expose the layout to users.
>>
[...]
>> The main different from RFC-v1:
>>   - Drop idea of BTF "origin" (vmlinux, module or local)
>>   - Instead to use full 64-bit BTF ID that combine object+type ID
>>
>> I've taken some of Alexandr/Larysa's libbpf patches and integrated
>> those.
> 
> Not sure if it's okay to inform the authors about the fact only
> after sending? Esp from the eeeh... "incompatible" implementation?

Just to be clear: I have made sure that developers of the patches
maintain authorship (when applied to git via the From: line) and I've
Cc'ed the developers directly.  I didn't Cc you directly as I knew you
would be included via XDP-hints list, and I didn't directly use one of
your patches.

> I realize it's open code, but this looks sorta depreciatingly.

After discussions with Larysa on pre-patchset, I was convinced of the
idea of a full 64-bit BTF ID.  Thus, I took those patches and carried
them in my patchset, instead of reimplementing the same myself.
Precisely out of respect for Larysa's work as I wanted to give her
credit for coding this.

I'm very interested in collaborating.  That is why I have picked up
patches from your patchset and are carrying them forward.  I could just
as easily reimplemented them myself.

--Jesper

