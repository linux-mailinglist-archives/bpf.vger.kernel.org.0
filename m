Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C006269E9FD
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 23:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBUWUQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 17:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBUWUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 17:20:16 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6252629152
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 14:20:15 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q5so6682304plh.9
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 14:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0pPAHA+K8DXlhYZZ0GIB+Drt4eql/EQhRkaunmpr0E=;
        b=fkzhokgSTicfu/HGNFGMJj0pTT/7X0qZ/h05FOJOcwAAv7NXWiBI+mULrpybdfxmUX
         wF7Owp6qhGGTaKfFP/OUXg8E9l3UU0ftOJgZShdIUf45fyS6/NxwYwEx2sf8fZlBddyc
         d/qjcRsqgUboDv1kYUSwOdXkzWy4WJle9Gzori8qE3XIQJC+05UuDYXsGJR8DWUaTa+a
         FCJdVyDEy3OybC5LIFrVbWKqRKlRr6PqcVFOe1yiEJHVvB4nRveKPnwVSzVihrzCLf4d
         rT9Ikuk4snXpm14PYMCAyP7LZyVmUL3pbLcwY5H3G6rMfiAL8DxmmxUCFZvwCWEqvX83
         RXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0pPAHA+K8DXlhYZZ0GIB+Drt4eql/EQhRkaunmpr0E=;
        b=2rrr46ooYxppTOnQP98Zz51cLvwrr0jNZQWQHLkvH5jbGv72qig2f6YO0gqR84c6Ps
         8f24f/mARPpsUj6Bc4iE8FaCkfQkFrIfk6J5FfcZ5/MVi1RAwcMEUx+Vm7IKdD/VDQXw
         QC1Z1AHDBK60r9ERR3mJF9UrYSR39BhfUmlbMr1b3KLM7nbu0JoTEYA9izDQg7FFtQpY
         rwoL66O61yaB1Iq/FzI0hgSHUwiyNFXr7JjnFTZwPoqL5s/juNtQpdebFEPHkjgR5gfT
         LdXf3btAXehn3st5D9DqV2goV7PPJi6XR1S+eL1AA/y9LWEWgCeRnWXngqvsmPASJF9u
         9KAg==
X-Gm-Message-State: AO0yUKWxZPp05pfb01+I68synK3rSAVijSktHiFEcMxBD4lQXAPm/0bw
        5lgYU24ZZ9Ul6wylyLmlwI0=
X-Google-Smtp-Source: AK7set8OHzu4pi9WVrGRVDGnG0aSTXCqMsu+KnZ3qg/J1w/vvS15r4iLcEgScNeJ2r5zXjnevfnggw==
X-Received: by 2002:a17:90b:350f:b0:234:b786:6867 with SMTP id ls15-20020a17090b350f00b00234b7866867mr7178375pjb.36.1677018014828;
        Tue, 21 Feb 2023 14:20:14 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e1::1308? ([2620:10d:c090:400::5:fde1])
        by smtp.gmail.com with ESMTPSA id js10-20020a17090b148a00b002367325203fsm3262694pjb.50.2023.02.21.14.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 14:20:14 -0800 (PST)
Message-ID: <fcef9223-7733-c20b-9cb7-9da868fe3faa@gmail.com>
Date:   Tue, 21 Feb 2023 14:20:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next 6/7] libbpf: Update a bpf_link with another
 struct_ops.
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-7-kuifeng@meta.com>
 <CAEf4BzaKRd2jif4XeKJ1s8Dfpp-wQyTTbXpF-Not6A5kpOGYqQ@mail.gmail.com>
 <e3c8beb3-5ff7-9de2-b4a8-3b23a111198f@gmail.com>
 <CAEf4Bzap2F1E09Lw8fv+akZ8_RymuxzCTCO1O4yi7rqaqkPGeQ@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4Bzap2F1E09Lw8fv+akZ8_RymuxzCTCO1O4yi7rqaqkPGeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/17/23 17:10, Andrii Nakryiko wrote:
> On Fri, Feb 17, 2023 at 4:22 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 2/16/23 14:48, Andrii Nakryiko wrote:
>>> On Tue, Feb 14, 2023 at 2:17 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>>>>
>>>> Introduce bpf_link__update_struct_ops(), which will allow you to
>>>> effortlessly transition the struct_ops map of any given bpf_link into
>>>> an alternative.
>>>>
>>>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>>>> ---
>>>>    tools/lib/bpf/libbpf.c   | 35 +++++++++++++++++++++++++++++++++++
>>>>    tools/lib/bpf/libbpf.h   |  1 +
>>>>    tools/lib/bpf/libbpf.map |  1 +
>>>>    3 files changed, 37 insertions(+)
>>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index 1eff6a03ddd9..6f7c72e312d4 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -11524,6 +11524,41 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>>>           return &link->link;
>>>>    }
>>>>
>>>> +/*
>>>> + * Swap the back struct_ops of a link with a new struct_ops map.
>>>> + */
>>>> +int bpf_link__update_struct_ops(struct bpf_link *link, const struct bpf_map *map)
>>>
>>> we have bpf_link__update_program(), and so the generic counterpart for
>>> map-based links would be bpf_link__update_map(). Let's call it that.
>>> And it shouldn't probably assume so much struct_ops specific things.
>>
>> Sure
>>
>>>
>>>> +{
>>>> +       struct bpf_link_struct_ops_map *st_ops_link;
>>>> +       int err, fd;
>>>> +
>>>> +       if (!bpf_map__is_struct_ops(map) || map->fd == -1)
>>>> +               return -EINVAL;
>>>> +
>>>> +       /* Ensure the type of a link is correct */
>>>> +       if (link->detach != bpf_link__detach_struct_ops)
>>>> +               return -EINVAL;
>>>> +
>>>> +       err = bpf_map__update_vdata(map);
>>>
>>> it's a bit weird we do this at attach time, not when bpf_map is
>>> actually instantiated. Should we move this map contents initialization
>>> to bpf_object__load() phase? Same for bpf_map__attach_struct_ops().
>>> What do we lose by doing it after all the BPF programs are loaded in
>>> load phase?
>>
>> With the current behavior (w/o links), a struct_ops will be registered
>> when updating its value.  If we move bpf_map__update_vdata() to
>> bpf_object__load(), a congestion control algorithm will be activated at
>> the moment loading it before attaching it.  However, we should activate
>> an algorithm at attach time.
>>
> 
> Of course. But I was thinking to move `bpf_map_update_elem(map->fd,
> &zero, st_ops->kern_vdata, 0);` part out of bpf_map__update_vdata()
> and make update_vdata() just prepare st_ops->kern_vdata only.

Ok! I will rename it as bpf_map_prepare_vdata(), and call 
bpf_map_update_elem() separately.

