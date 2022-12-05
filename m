Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C39642A8E
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 15:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiLEOng (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 09:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiLEOng (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 09:43:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6789638A4
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 06:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670251360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+Nn9oZzRPd+dclMheKaP6+41PPnTOwIaPu+0F6iS0c=;
        b=KNrcY1ypb7NLvmazp5kdhWmlHCXt3dmWdu+10rY6pbxGisXIPoJ2xOHx6sOPEDROSZ4aD8
        WqqDS+pwwFj9SPsrt9cMdDgDStJRhCA6iF6YZl+ZQglLJiFprKK40UhbXCpbQZLX+aPfG5
        N6/PkuBLF6KtRgiJh2SJXMspQr+cSUo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-QZtMPMJiNbKhK5T14dGKZg-1; Mon, 05 Dec 2022 09:42:39 -0500
X-MC-Unique: QZtMPMJiNbKhK5T14dGKZg-1
Received: by mail-ej1-f70.google.com with SMTP id gn36-20020a1709070d2400b007ba3374574dso7603128ejc.23
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 06:42:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+Nn9oZzRPd+dclMheKaP6+41PPnTOwIaPu+0F6iS0c=;
        b=c8tfwnJnZDajLFAwcFGFXo0E8noUSNJjvcEMxerwuxZGkx9Oi1GVTePf9qfb778arY
         0GEQzwjrW1ZMK6iCPpiaie4pqHZ0izC6JzdxzEQoFrKnHFgTtGLIkBMfBx/LE8fQEMdz
         Hjan2/+kkzN5ZfCRTg9fCNGR4B95g5JoauVR4Ht2g1ylIIovi7cu3u/3kPod6i+DgU9g
         mabNMJLaWxkTdRfrvkuSzUsQcFJ9a9dXB1iGU5hjPJP5ZOFvsAyoM1hVLGQWcJgv5+T+
         IXNYdUl2Xx/CbsaaNY/+fd2mCth6wV2jPPTxo5+nIvVNU6+KYI9FJ7Cxpds9Ao+gPP9Z
         R1CQ==
X-Gm-Message-State: ANoB5pmvy5TcJZ5rtf5bYSV3Poa4pECKtz5ifBFNb0+MpqdZdTg3PYzQ
        OxSP0GApfGX/55XJrGoMzkERvChjPmCABvdTotXm1HxIhWhYx4QmyV4m/uClj4TxVNCZuDwrG+d
        MSS6iyIBpwyg=
X-Received: by 2002:a17:906:6417:b0:7ae:937f:2c38 with SMTP id d23-20020a170906641700b007ae937f2c38mr54577823ejm.201.1670251355573;
        Mon, 05 Dec 2022 06:42:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6M3KqgSSWvjMkHJ/C72aqj2lvcGjz5kwNGOTKFnWPWCPzpNYHP3GL7MRWYy4fo0hmdZLqj+w==
X-Received: by 2002:a17:906:6417:b0:7ae:937f:2c38 with SMTP id d23-20020a170906641700b007ae937f2c38mr54577799ejm.201.1670251355365;
        Mon, 05 Dec 2022 06:42:35 -0800 (PST)
Received: from [192.168.0.111] (185-219-167-248-static.vivo.cz. [185.219.167.248])
        by smtp.gmail.com with ESMTPSA id l2-20020a056402124200b004615f7495e0sm6331338edw.8.2022.12.05.06.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 06:42:34 -0800 (PST)
Message-ID: <3c14edd8-ebb5-7e65-dfe1-7328aef73d97@redhat.com>
Date:   Mon, 5 Dec 2022 15:42:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <cover.1669787912.git.vmalik@redhat.com>
 <e7d42f8f48ab4323ba460b4c843c27f3c475f106.1669787912.git.vmalik@redhat.com>
 <CA+khW7jZmPQpJrAN4JEbMPC=SN+iwj6-tBW6wvd=UKoeeq07Eg@mail.gmail.com>
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <CA+khW7jZmPQpJrAN4JEbMPC=SN+iwj6-tBW6wvd=UKoeeq07Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/1/22 20:26, Hao Luo wrote:
> On Tue, Nov 29, 2022 at 10:54 PM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> When attaching fentry/fexit/fmod_ret/lsm to a function located in a
>> module without specifying the target program, the verifier tries to find
>> the address to attach to in kallsyms. This is always done by searching
>> the entire kallsyms, not respecting the module in which the function is
>> located.
>>
>> This approach causes an incorrect attachment address to be computed if
>> the function to attach to is shadowed by a function of the same name
>> located earlier in kallsyms.
>>
>> Since the attachment must contain the BTF of the program to attach to,
>> we may extract the module name from it (if the attach target is a
>> module) and search for the function address in the correct module.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
> 
> Looks like we need to define a trivial
> kallsyms_lookup_name_in_module() in !CONFIG_MODULES. With that added,
> this patch looks good to me.

Right, I missed that, thanks! I'll fix it and post v3 soon.

> 
> Acked-by: Hao Luo <haoluo@google.com>
> 

