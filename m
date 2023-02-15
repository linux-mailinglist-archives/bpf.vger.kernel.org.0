Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FC46987BA
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 23:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBOWVD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 17:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOWVC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 17:21:02 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE6E25941
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 14:21:01 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id i18so170809pli.3
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 14:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqXfX8v+xWMTHGf3BmHlQmgzP8hPkQH+NLzWYL4gRYI=;
        b=opmlyhNHQCGyN8EfVpBnqWjx/b3BJiPZu36pqZWHyOe7Cr8zAx+Fkr1a4JbSkV3OKc
         8AuiHmW/oNcG6lBDBx4OYPwql0m7/xOPeh9TsE+Jq8lPdPFx8dJBfkf5R+P4flJxO9en
         SVGpNCCRyo2Upa3M3TFElUw1/hgHNLWsrA4pA7SRPMPrAzP4xDRimcm6knVFeLjvnnQJ
         z0Nk2uaioHnEdNEc92FmOo15DYJED4gd5clHn1m24P1vNdrtzQRV/1Tosu5Af8/RPi9I
         xl65LBKC0YWfATKm1QEg1RWqIYaAfpbcwU1zibi/GXvUpS/bky69YROPQA+aupQ2Q/fd
         kBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqXfX8v+xWMTHGf3BmHlQmgzP8hPkQH+NLzWYL4gRYI=;
        b=U9qq72rV/4qjDxFNdprXs+Fr/8knvmnHADr1m2CtsgPZxV6NMbdEmGX7Ey4/xrUQSR
         ycQyfzPJ2lo/9OT17qrdqu+F9SDgd75AAFatTzkEfnywM1arg9tAbwydcy9gA9N7GKHK
         ukRxK+Wrib9MKYbcz+7Hhnrt9gL4V6IWnMEqOgROku3N/qIA9u1aM3r+czP6bKlIq8wj
         vdsi+FdlLJ50cwJWc54eYuFyizud2zHCylf5NLFelVcANUx0m/1EZRYzRnWF3qF7/5bv
         nTnTX6h4ZTTnJLeQiHE+Yr9ZZQwfZLmAYU2tE5pT6H43cFidVhoTZMaMb2StwHkvQT6Q
         nenA==
X-Gm-Message-State: AO0yUKUxJqDzsJyuGagbBXYPfKuEfrL46+i+4CFuoFZQId5Ndi+JHzui
        ygxJDC/gJ46bO/xF/XbSDIE=
X-Google-Smtp-Source: AK7set/T0o6l3gPil8r7BvHO7B551BnW8qk2YeByAbcSNMpAvhCAeORg4RcAsmORsEjqSBI8EjLaLw==
X-Received: by 2002:a17:902:da84:b0:196:f00:c8f9 with SMTP id j4-20020a170902da8400b001960f00c8f9mr4717787plx.10.1676499661224;
        Wed, 15 Feb 2023 14:21:01 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e8::1452? ([2620:10d:c090:400::5:1af8])
        by smtp.gmail.com with ESMTPSA id iw3-20020a170903044300b0019ab3308554sm4352523plb.85.2023.02.15.14.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 14:21:00 -0800 (PST)
Message-ID: <08f81013-d073-6616-aa8b-6c54216f291a@gmail.com>
Date:   Wed, 15 Feb 2023 14:20:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next 4/7] libbpf: Create a bpf_link in
 bpf_map__attach_struct_ops().
Content-Language: en-US, en-ZW
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-5-kuifeng@meta.com> <Y+xKOq4gW58IDMWE@google.com>
 <7149cfe4-7ae4-a8e9-6f85-38e488080f28@gmail.com>
 <CAKH8qBvUhDrMjveh-_MZPkcy9sUf2UJ1kL1sx=Tt+yWwf+XBtQ@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAKH8qBvUhDrMjveh-_MZPkcy9sUf2UJ1kL1sx=Tt+yWwf+XBtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 2/15/23 10:48, Stanislav Fomichev wrote:
> On Wed, Feb 15, 2023 at 10:44 AM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>> On 2/14/23 18:58, Stanislav Fomichev wrote:
>>> On 02/14, Kui-Feng Lee wrote:
>>>> bpf_map__attach_struct_ops() was creating a dummy bpf_link as a
>>>> placeholder, but now it is constructing an authentic one by calling
>>>> bpf_link_create() if the map has the BPF_F_LINK flag.
>>>
>>>> You can flag a struct_ops map with BPF_F_LINK by calling
>>>> bpf_map__set_map_flags().
>>>
>>>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>>>> ---
>>>>    tools/lib/bpf/libbpf.c | 73 +++++++++++++++++++++++++++++++++---------
>>>>    1 file changed, 58 insertions(+), 15 deletions(-)
>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index 75ed95b7e455..1eff6a03ddd9 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -11430,29 +11430,41 @@ struct bpf_link *bpf_program__attach(const
>>>> struct bpf_program *prog)
>>>>        return link;
>>>>    }
>>>
>>>> +struct bpf_link_struct_ops_map {
>>>> +    struct bpf_link link;
>>>> +    int map_fd;
>>>> +};
>>>
>>> Ah, ok, now you're adding bpf_link_struct_ops_map. I guess I'm now
>>> confused why you haven't done it in the first patch :-/
>>
>> Just won't to mix the libbpf part and kernel part in one patch.
> 
> Ah, shoot, I completely missed that it's libbpf. So in this case, can
> we use the same strategy for the kernel links? Instead of a union,
> have an outer struct + container_of? If not, why not?

The reason I use `container_of` here is we need both FDs in libbpf to 
keep it as consistent with its existing behavior as possible.  The value 
of the struct_ops map should be deleted if a bpf_link is detached.

Back to your question.  We can go the `container_of` approach.  Only 
concern I have is additional few bytes although it is not a big issue. I 
will move to this approach in the next version.

> 
> 
>>
>>>
>>> And what are these fake bpf_links? Can you share more about it means?
>>
>> For the next version, I will detail it in the commit log. In a nutshell,
>> before this point, there was no bpf_link for struct_ops. Libbpf
>> attempted to create an equivalent interface to other BPF programs by
>> providing a simulated bpf_link instead of a true one from the kernel;
>> that fake bpf_link stores FDs associated with struct_ops maps rather
>> than real bpf_links.
>>
>>
>>>
>>>> +
>>>>    static int bpf_link__detach_struct_ops(struct bpf_link *link)
>>>>    {
>>>> +    struct bpf_link_struct_ops_map *st_link;
>>>>        __u32 zero = 0;
>>>
>>>> -    if (bpf_map_delete_elem(link->fd, &zero))
>>>> +    st_link = container_of(link, struct bpf_link_struct_ops_map, link);
>>>> +
>>>> +    if (st_link->map_fd < 0) {
>>>> +        /* Fake bpf_link */
>>>> +        if (bpf_map_delete_elem(link->fd, &zero))
>>>> +            return -errno;
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    if (bpf_map_delete_elem(st_link->map_fd, &zero))
>>>> +        return -errno;
>>>> +
>>>> +    if (close(link->fd))
>>>>            return -errno;
>>>
>>>>        return 0;
>>>>    }
>>>
>>>> -struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>>> +/*
>>>> + * Update the map with the prepared vdata.
>>>> + */
>>>> +static int bpf_map__update_vdata(const struct bpf_map *map)
>>>>    {
>>>>        struct bpf_struct_ops *st_ops;
>>>> -    struct bpf_link *link;
>>>>        __u32 i, zero = 0;
>>>> -    int err;
>>>> -
>>>> -    if (!bpf_map__is_struct_ops(map) || map->fd == -1)
>>>> -        return libbpf_err_ptr(-EINVAL);
>>>> -
>>>> -    link = calloc(1, sizeof(*link));
>>>> -    if (!link)
>>>> -        return libbpf_err_ptr(-EINVAL);
>>>
>>>>        st_ops = map->st_ops;
>>>>        for (i = 0; i < btf_vlen(st_ops->type); i++) {
>>>> @@ -11468,17 +11480,48 @@ struct bpf_link
>>>> *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>>>            *(unsigned long *)kern_data = prog_fd;
>>>>        }
>>>
>>>> -    err = bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
>>>> +    return bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
>>>> +}
>>>> +
>>>> +struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>>> +{
>>>> +    struct bpf_link_struct_ops_map *link;
>>>> +    int err, fd;
>>>> +
>>>> +    if (!bpf_map__is_struct_ops(map) || map->fd == -1)
>>>> +        return libbpf_err_ptr(-EINVAL);
>>>> +
>>>> +    link = calloc(1, sizeof(*link));
>>>> +    if (!link)
>>>> +        return libbpf_err_ptr(-EINVAL);
>>>> +
>>>> +    err = bpf_map__update_vdata(map);
>>>>        if (err) {
>>>>            err = -errno;
>>>>            free(link);
>>>>            return libbpf_err_ptr(err);
>>>>        }
>>>
>>>> -    link->detach = bpf_link__detach_struct_ops;
>>>> -    link->fd = map->fd;
>>>> +    link->link.detach = bpf_link__detach_struct_ops;
>>>
>>>> -    return link;
>>>> +    if (!(map->def.map_flags & BPF_F_LINK)) {
>>>> +        /* Fake bpf_link */
>>>> +        link->link.fd = map->fd;
>>>> +        link->map_fd = -1;
>>>> +        return &link->link;
>>>> +    }
>>>> +
>>>> +    fd = bpf_link_create(map->fd, -1, BPF_STRUCT_OPS_MAP, NULL);
>>>> +    if (fd < 0) {
>>>> +        err = -errno;
>>>> +        free(link);
>>>> +        return libbpf_err_ptr(err);
>>>> +    }
>>>> +
>>>> +    link->link.fd = fd;
>>>> +    link->map_fd = map->fd;
>>>> +
>>>> +    return &link->link;
>>>>    }
>>>
>>>>    typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct
>>>> perf_event_header *hdr,
>>>> --
>>>> 2.30.2
>>>
