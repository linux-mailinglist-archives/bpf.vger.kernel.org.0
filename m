Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43D9639F88
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 03:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiK1Cm4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Nov 2022 21:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiK1Cmz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Nov 2022 21:42:55 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC7A2DCE
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 18:42:54 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x66so9154457pfx.3
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 18:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Tz/+T15ncgjnb3tugK7B/UmrZmcShT9NhAk5/KUADg=;
        b=PY4HBY2LWQ+atx1bwo0EnNzRZEhzmPE3/GAh2jzjqSbhXgYnTY8WZ+ZevEf/Ms0RmY
         rpFKQtEGH9Idpet8XBmFGIF2xBtSGMX+lBNY943Mxze5KKC0PQSSXegF4hQvik019B7O
         53WGl823qAx4jAwbo/mc7L4Rs9kAlH9m/+KXy9FCMlpwrLMg93OJL6h1IwWoB7f/Pe0A
         TT4y64i/IaYOIxuqHJwCjfWCzpHnOFyCjaMsD7cEgych05Vzav7qLKdGtgBKKQgBab6O
         RPpKE9031bv/yJ0J/GsQYEJbNh2rbZhZyDqdRwfjgl4gzob5an/Veqz5XrgLwsHg1RAc
         Z5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Tz/+T15ncgjnb3tugK7B/UmrZmcShT9NhAk5/KUADg=;
        b=6a7RhU2EOZd8Oc1H2F39bwVLBITKfEil8rY7vW60UPJBCp3vAOlBi2Ttl5mXqqS0+Q
         09OW/wzHAp3Qcj5JsageMH0VAi/rg+vEWKawa8w7dWLkcrod2FgWBapxYtgauZxd70SV
         QCghk5fA4TNlgHWfDV/GbGbOekJxh6KhGRpn274epzdu1DIaSJEe7/yc08EEjKsPb7v9
         wDAo9RZtClndH5wGECxnQhwwJihisIqMoVRodM84sTibMD3EEomBRWc3mxRrgCMVApuj
         5AUvO+mBqioi1WV7TZA4SB4lOQMI02TPnNclAEezOwSP+gP8axiniOCzsjvJOnbKd2G8
         3glg==
X-Gm-Message-State: ANoB5pkP594EcZ1MHC0kt+5owmix+wZEF/0vXNvvZlvaZf3k3oqv0ZxL
        s8/q6lG+R4fp40TYdkG97QY=
X-Google-Smtp-Source: AA0mqf7E8NGWoE0gaFEXtDrQGVDkAjLUSvBrHtiaazET3EX3p6DvZypa+8dtEjQZg3wnhxD1I3lKew==
X-Received: by 2002:a63:4046:0:b0:460:fa0c:ab73 with SMTP id n67-20020a634046000000b00460fa0cab73mr25542467pga.315.1669603373992;
        Sun, 27 Nov 2022 18:42:53 -0800 (PST)
Received: from [192.168.255.10] ([43.132.98.43])
        by smtp.gmail.com with ESMTPSA id y6-20020a626406000000b005745a586badsm6760365pfb.218.2022.11.27.18.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 18:42:53 -0800 (PST)
Message-ID: <94b5a28c-56dd-74a1-e4f5-5b5c2ffeca2a@gmail.com>
Date:   Mon, 28 Nov 2022 10:42:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH bpf 1/2] bpf: Check timer_off for map_in_map only when map
 value have timer
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20221126105351.2578782-1-hengqi.chen@gmail.com>
 <20221126105351.2578782-2-hengqi.chen@gmail.com>
 <CAADnVQJ8B0oDss95P+qfQx7r0Xr8RmY-_9dAincqESzyD+ZG+w@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <CAADnVQJ8B0oDss95P+qfQx7r0Xr8RmY-_9dAincqESzyD+ZG+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Alexei:

On 2022/11/28 08:44, Alexei Starovoitov wrote:
> On Sat, Nov 26, 2022 at 2:54 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> The timer_off value could be -EINVAL or -ENOENT when map value of
>> inner map is struct and contains no bpf_timer. The EINVAL case happens
>> when the map is created without BTF key/value info, map->timer_off
>> is set to -EINVAL in map_create(). The ENOENT case happens when
>> the map is created with BTF key/value info (e.g. from BPF skeleton),
>> map->timer_off is set to -ENOENT as what btf_find_timer() returns.
>> In bpf_map_meta_equal(), we expect timer_off to be equal even if
>> map value does not contains bpf_timer. This rejects map_in_map created
>> with BTF key/value info to be updated using inner map without BTF
>> key/value info in case inner map value is struct. This commit lifts
>> such restriction.
> 
> Sorry, but I prefer to label this issue as 'wont-fix'.
> Mixing BTF enabled and non-BTF inner maps is a corner case

We do have such usecase. The BPF progs and maps are pinned to bpffs
using BPF object file. And the map_in_map is updated by some other
process which don't have access to such BTF info.

> that is not worth fixing.

Is there a way to get this fixed for v5.x series only ?

> At some point we will require all programs and maps to contain BTF.
> It's necessary for introspection.

We don't care much about BTF for introspection. In production, we always
have a version field and some reserved fields in the map value for backward
compatibility. The interpretation of such map values are left to upper layer.

> The maps as blobs of data should not be used.
> Much so adding support for mixed use as inner maps.
