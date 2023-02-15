Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C06986B3
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 21:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBOU7U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 15:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjBOU6u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 15:58:50 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E82474FC
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 12:56:24 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id d8-20020a17090ad98800b002344fa17c8bso29536pjv.5
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 12:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AqB4pINdNzS4KXBU1HVzIQeT1d3bTTzim33HM8HN9Oo=;
        b=neERpAoNhz/rKy8beHLhJDusjoY2Jq/IhPwNWa21vgnVNv2oYc48yAQ3imqGg8cGie
         /dvmTBU1SCOV3pJGVxzHu70DUhwYadpsEPWaNzYh0A82HNWTIgV9WcBQdf+RG2MEzxBF
         JSFSXyI+nhr25ejjaSAQBNlGiKGrVw9f6QxDjhJFsqcPb761jC+XZzXzU+VGdW2Q2Iqa
         3god3DjYLUSy+ezZVumgetAcBvIokAkqFS94EpkRYX/GKEaPI3axwbTsuCW8t7H1tZ54
         JvstPWZdka0RBDYuI/6QhFcHxGDdbWpA6UzqfoB8y+Jp3g4mgbQYsCjgykN+xO/uhh9g
         uj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqB4pINdNzS4KXBU1HVzIQeT1d3bTTzim33HM8HN9Oo=;
        b=YzsJNlZui13PArVom9c3Mzq9PA2oj+IoOvUYmNeisPJDISfBMRCjqTPqwPNcMQi3b5
         ClL14nUak+Ctwxj8gFIVlTBJ40PEAtjjpK96TY5XmfplJsCKcuNNU8162l8mwF0LFYT7
         qON3fHJGavRXfzwi2PqIlWcyjdMvnYtledSY4EeGyK5j2VfFMgiPOCJlz3J7jCCf+Y0r
         N2GHGuxqQaXGgMX7dypeE4Cl8CJh74pWByj913713gJzHYPyCnazW6t/nNrOICIMi5fB
         GgkNBk9P6t++yfCE8ht3aKzBgqnaVLSusF9ROKzaiGoRxSCoEmPS+/lrb4gBEPD7/OwI
         L6Vw==
X-Gm-Message-State: AO0yUKX2nKAawLdkB0jethU/f4qFbsgLP9geBMQlP9o88qWRSZXMhXHT
        pDFtCOeh2fbi6ukuTZJMKVA=
X-Google-Smtp-Source: AK7set/IDaCIw10JXWAskgnA/V+KPAfa011RlEopANbsLbz09GbdZp/rSpJTpSIT+O8KoaNJQMcsOw==
X-Received: by 2002:a17:902:da90:b0:192:5ec4:6656 with SMTP id j16-20020a170902da9000b001925ec46656mr4517123plx.3.1676494536466;
        Wed, 15 Feb 2023 12:55:36 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e8::1452? ([2620:10d:c090:400::5:1af8])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b0019aa7d89f06sm5698130plg.30.2023.02.15.12.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:55:35 -0800 (PST)
Message-ID: <c1c484f2-cfcb-6e9b-86d9-dbe3ac6cf7de@gmail.com>
Date:   Wed, 15 Feb 2023 12:55:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next 1/7] bpf: Create links for BPF struct_ops maps.
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-2-kuifeng@meta.com> <Y+xF8k8RMiG0xBDY@google.com>
 <9204de1c-9d98-fe87-77f8-04554210e479@gmail.com>
 <f45c69b1-1bb6-35a0-9100-bd0df732fa2b@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <f45c69b1-1bb6-35a0-9100-bd0df732fa2b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2/15/23 12:30, Martin KaFai Lau wrote:
> On 2/15/23 10:04 AM, Kui-Feng Lee wrote:
>>>> +    int err;
>>>> +
>>>> +    map = bpf_map_get(attr->link_create.prog_fd);
>>>
>>> bpf_map_get can fail here?
>>
>>
>> We have already verified the `attach_type` of the link before calling 
>> this function, so an error should not occur. If it does happen, 
>> however, something truly unusual must be happening. To ensure maximum 
>> protection and avoid this issue in the future, I will add a check 
>> here as well.
>
> bpf_map_get() could fail. A valid attach_type does not mean prog_fd 
> (actually map_fd here) is also valid.

You are right! I must mess up with the update one.

I will add a check.


