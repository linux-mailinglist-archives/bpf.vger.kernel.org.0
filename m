Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D593E6982AE
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 18:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBORvC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 12:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjBORvB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 12:51:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF623C29B
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 09:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676483415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SYt3GY5lyZNnxZGhWHCPOfmt09yQokio9neVGfzdx1g=;
        b=Q3QBLJSprPGL+COaG74YgiKyU3PSr95TNVtXxzHEWTTRINHqwVQ4OezYv5LO/lOqVtgZlT
        LRhbF9e7uFBHvZz+ROGlR5VTGCE1wMH7zWjyxagDEwrikPuZRaqD86DCBi4vdxrlMfTAek
        tSguXIZ92O5zeGSanmSfHzHHKQXu97o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-472-vR0LHY8kPuqFdBakIKOuAQ-1; Wed, 15 Feb 2023 12:50:14 -0500
X-MC-Unique: vR0LHY8kPuqFdBakIKOuAQ-1
Received: by mail-ed1-f71.google.com with SMTP id s3-20020a50ab03000000b0049ec3a108beso13173582edc.7
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 09:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYt3GY5lyZNnxZGhWHCPOfmt09yQokio9neVGfzdx1g=;
        b=ianPJVKLuxWKBJj+DY5Vf/MiaOWbzC+HCCZEGQV/N6sPimGwzNgCA3moeckQ77AaHZ
         q5HJBgS6GeO2W54KodtbbwpF5Rwgan/zpGU4digF8AUZeoG28016Yrbgbc/M6PrduAVN
         FEwyW04+edI1p66h8zkzoLA2cQQD5l1ulMf/kT4KvT73LjzWn5NVLn43wcj4K2EYu65A
         XqPqotW2aJdP6yRLwRjAakadxHbVexFx9/d5Lp4AF0I2jL+DpXzT1n1skhmXRglEW+0x
         HV9k6nUIDGhF4DWBGSwLxxQ4l+FjTBCncYnXBvZDu6SrCTxPLl5LbNlLdc1HqGPc4OYC
         mYMA==
X-Gm-Message-State: AO0yUKXLs+2O7sk/1W+YkWnU82Sccqe+2Xn8eFptvbOk6wsIuoknKKIs
        3IVM+QMiK70mx7RyRNfEMyJFAthyXSkIKjL+ersbhawge4WkRsl5ulc/QkFQYuSNvmH8hNonxZQ
        uPVbBv6EFehSb
X-Received: by 2002:a17:906:90c9:b0:8aa:502c:44d3 with SMTP id v9-20020a17090690c900b008aa502c44d3mr3476283ejw.41.1676483413268;
        Wed, 15 Feb 2023 09:50:13 -0800 (PST)
X-Google-Smtp-Source: AK7set9iIEgIIHlQTWzeKg0vskVXkoTDY8HQYB5bO3uIfG7SXwTSIum98IjhBq2cgl22xVLcdUdT4A==
X-Received: by 2002:a17:906:90c9:b0:8aa:502c:44d3 with SMTP id v9-20020a17090690c900b008aa502c44d3mr3476267ejw.41.1676483412999;
        Wed, 15 Feb 2023 09:50:12 -0800 (PST)
Received: from [192.168.42.100] (nat-cgn9-185-107-15-52.static.kviknet.net. [185.107.15.52])
        by smtp.gmail.com with ESMTPSA id b15-20020a170906660f00b00871075bfcfesm9835089ejp.133.2023.02.15.09.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 09:50:12 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <836540e1-6f8c-cbef-5415-c9ebc55d94d6@redhat.com>
Date:   Wed, 15 Feb 2023 18:50:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     brouer@redhat.com, Larysa Zaremba <larysa.zaremba@intel.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>, martin.lau@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, alexandr.lobakin@intel.com,
        xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] Re: [PATCH bpf-next V1] xdp: bpf_xdp_metadata use
 NODEV for no device support
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
References: <167645577609.1860229.12489295285473044895.stgit@firesoul>
 <Y+z9/Wg7RZ3wJ8LZ@lincoln> <c9be8991-1186-ef0f-449c-f2dd5046ca02@intel.com>
In-Reply-To: <c9be8991-1186-ef0f-449c-f2dd5046ca02@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 15/02/2023 18.11, Alexander Lobakin wrote:
> From: Zaremba, Larysa <larysa.zaremba@intel.com>
> Date: Wed, 15 Feb 2023 16:45:18 +0100
> 
>> On Wed, Feb 15, 2023 at 11:09:36AM +0100, Jesper Dangaard Brouer wrote:
>>> With our XDP-hints kfunc approach, where individual drivers overload the
>>> default implementation, it can be hard for API users to determine
>>> whether or not the current device driver have this kfunc available.
>>>
>>> Change the default implementations to use an errno (ENODEV), that
>>> drivers shouldn't return, to make it possible for BPF runtime to
>>> determine if bpf kfunc for xdp metadata isn't implemented by driver.
>>
>> I think it diverts ENODEV usage from its original purpose too much. 

Can you suggest a errno that is a better fit?

>> Maybe providing information in dmesg would be a better solution?

IMHO we really don't want to print any information in this code path, as
this is being executed as part of the BPF-prog. This will lead to
unfortunate latency issues.  Also considering the packet rates this need
to operate at.

> 
> +1, -%ENODEV shouldn't be used here. It stands for "no device", for
> example the driver probing core doesn't treat it as an error or that
> something is not supported (rather than there's no device installed
> in a slot / on a bus etc.).
> 

I wanted to choose something that isn't natural for a device driver
developer to choose as a return code.  I choose the "no device", because
the "device" driver doesn't implement this.

The important part is help ourselves (and support) to reliably determine
if a device driver implements this kfunc or not. I'm not married to the
specific errno.

I hit this issue myself, when developing these kfuncs for igc.  I was
constantly loading and unloading the driver while developing this. And
my kfunc would return -EOPNOTSUPP in some cases, and I couldn't
understand why my code changes was not working, but in reality I was
hitting the default kfunc implementation as it wasn't the correct
version of the driver I had loaded.  It would in practice have save me
time while developing...

Please suggest a better errno if the color is important to you.

>>
>>>
>>> This is intended to ease supporting and troubleshooting setups. E.g.
>>> when users on mailing list report -19 (ENODEV) as an error, then we can
>>> immediately tell them their kernel is too old.
>>
>> Do you mean driver being too old, not kernel?

Sure I guess, I do mean the driver version.

I guess you are thinking in the lines of Intel customers compiling Intel
out-of-tree kernel modules, this will also be practical and ease
troubleshooting for Intel support teams.

>>>
>>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
>>> ---
> [...]
> 
> Thanks,
> Olek
> 

