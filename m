Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401886BF72E
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 02:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCRBR4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 21:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCRBRy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 21:17:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A03E2501
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 18:17:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p20so7094231plw.13
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 18:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679102273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bxEGCl74NBjmYda5W+5RT/IrofV83VCCSuSPlISIGs=;
        b=o1KJK8mrzJl+wH72W7LzuJqUcSmhVrV466lmGbxr2kflBzgmmS73Dq5Y8AyH2EmVKe
         qsS8unHtT66mfWYk/gu8hV0Tkeh0BlFb+d4JkXjyOKsk7nxNzwckj0dGcXAuGQa6Eme2
         1ptVpXlEt5U/VyviioKLKZ7uNLMEwmWWJrhgETozvjnysCeOSkSraasZIEHPROLTfT0T
         HG7d18HyWBLgqLNtmsTcxhdWXd5KZHS7EN2ip0fuGr/fBvAR0srAvta0awTXpl2z7OIL
         vkMomHY7ZUhusRxGOzCXMQ6YRCBU1oQI5rtcdi+zMGbo9uQnWuGbbw+sLw+4u2Dk5JX/
         9GtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679102273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bxEGCl74NBjmYda5W+5RT/IrofV83VCCSuSPlISIGs=;
        b=hAibkh00LCcITVsuDumm88XEkxPsh46bEkvM8rqcEHaX9Rg4KdyZrQleaiSAwCF/XA
         wThNPG4DbPObuOjygWXrXuISytFzi/sDsyY0+rC4OyGoZHCvhovnbJObVE09YcJHRvju
         nIJFyQJDFqAcI04qk7nJw8RKYb8bfz27VzTgXHIux3oJMvLBPnWp0y+Eydez7zCffV57
         0anfAZ80mXyDdtMwJRmLpDp2u1GAkqX5OjlzGHZ7GfsRBzSQwk2bsD5Zx3EhkNUsgIrU
         +43B59+/ylZtG/nYMNjfjXfafz1gGDN2kZW6gYg0BUsMUOStO+ZLRAbJyKG55rpjOy6T
         alww==
X-Gm-Message-State: AO0yUKUYp7AjXySqJfWcOZV1pFIKcQlu91TCnDYQ5SrdsNaHJmPSGAoa
        zpHxf0npMSuKorfkmC3txyM=
X-Google-Smtp-Source: AK7set8H0Gl/RQq0UdEmgFA1GKuHGdh6ArIGuyw7ZyrA4693sxH4xys5eyF94ryRiK+BWdK9e8WWsA==
X-Received: by 2002:a05:6a20:b704:b0:d0:15c9:4e67 with SMTP id fg4-20020a056a20b70400b000d015c94e67mr8951839pzb.19.1679102273312;
        Fri, 17 Mar 2023 18:17:53 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1380? ([2620:10d:c090:400::5:87c3])
        by smtp.gmail.com with ESMTPSA id d16-20020aa78150000000b005825b8e0540sm2090555pfn.204.2023.03.17.18.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 18:17:52 -0700 (PDT)
Message-ID: <b9010a3f-1a37-17f9-6185-c9563b81429a@gmail.com>
Date:   Fri, 17 Mar 2023 18:17:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v7 6/8] libbpf: Update a bpf_link with another
 struct_ops.
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
References: <20230316023641.2092778-1-kuifeng@meta.com>
 <20230316023641.2092778-7-kuifeng@meta.com>
 <CAEf4BzaYUdyfA4nL-SRiUUVCKKeO-oL6xXuXqa2WSvJqOQb_7g@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzaYUdyfA4nL-SRiUUVCKKeO-oL6xXuXqa2WSvJqOQb_7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/17/23 15:33, Andrii Nakryiko wrote:
> On Wed, Mar 15, 2023 at 7:37 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>>
>> Introduce bpf_link__update_map(), which allows to atomically update
>> underlying struct_ops implementation for given struct_ops BPF link
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   tools/lib/bpf/libbpf.c   | 30 ++++++++++++++++++++++++++++++
>>   tools/lib/bpf/libbpf.h   |  1 +
>>   tools/lib/bpf/libbpf.map |  1 +
>>   3 files changed, 32 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 6dbae7ffab48..63ec1f8fe8a0 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -11659,6 +11659,36 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>          return &link->link;
>>   }
>>
>> +/*
>> + * Swap the back struct_ops of a link with a new struct_ops map.
>> + */
>> +int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map)
>> +{
>> +       struct bpf_link_struct_ops *st_ops_link;
>> +       __u32 zero = 0;
>> +       int err, fd;
>> +
>> +       if (!bpf_map__is_struct_ops(map) || map->fd < 0)
>> +               return -EINVAL;
>> +
>> +       st_ops_link = container_of(link, struct bpf_link_struct_ops, link);
>> +       /* Ensure the type of a link is correct */
>> +       if (st_ops_link->map_fd < 0)
>> +               return -EINVAL;
>> +
>> +       err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);
>> +       if (err && err != -EBUSY)
> 
> Why is it ok to ignore -EBUSY? Let's leave a comment as well, as this
> is not clear.

got it!

> 
>> +               return err;
>> +
>> +       fd = bpf_link_update(link->fd, map->fd, NULL);
>> +       if (fd < 0)
>> +               return fd;
>> +
>> +       st_ops_link->map_fd = map->fd;
>> +
>> +       return 0;
>> +}
>> +
>>   typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_event_header *hdr,
>>                                                            void *private_data);
>>
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index db4992a036f8..1615e55e2e79 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -719,6 +719,7 @@ bpf_program__attach_freplace(const struct bpf_program *prog,
>>   struct bpf_map;
>>
>>   LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
>> +LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map);
>>
>>   struct bpf_iter_attach_opts {
>>          size_t sz; /* size of this struct for forward/backward compatibility */
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 50dde1f6521e..cc05be376257 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -387,6 +387,7 @@ LIBBPF_1.2.0 {
>>          global:
>>                  bpf_btf_get_info_by_fd;
>>                  bpf_link_get_info_by_fd;
>> +               bpf_link__update_map;
> 
> nit: this should go before bpf_link_get_info_by_fd ('_' orders before 'g')

ok!

> 
>>                  bpf_map_get_info_by_fd;
>>                  bpf_prog_get_info_by_fd;
>>   } LIBBPF_1.1.0;
>> --
>> 2.34.1
>>
