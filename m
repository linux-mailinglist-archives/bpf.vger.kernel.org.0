Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7E86AFBCC
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 02:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCHBLX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 20:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCHBLW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 20:11:22 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE8BA6167
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 17:11:21 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso652849pjr.5
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 17:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678237881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6QJDrTocP4I9YKZY4mDmZOrPdR8HyI+d6gaRdmdXMQo=;
        b=QvaIqFAXmXesTaescZ7NiFxoWTsffvlGjj91BGdAm9qZVOcm3ltJtdMWFnD5Dm1qu8
         LOF0KZ/1LN5u77JWVofvkQ/M4z7suDhqa5dacHhSZqUm21xoUaSQcGJGxIc6yyObgGgg
         HZ5M11boAsBhcDs3y10S8vgcyer15eoYlW2zTv20TtLVhfTG9XZqD5agE2GL1ayFF614
         R0p96R+PtPF395IoVw4BgD8aTLZb9vvf0H6iIJBJ40fiRbwlTELXFYR5dTxi12mUG/BW
         dotQ/Pi8VSb5/arvBSsqL4HflTtKzYJAmsz3m1v/NjJYdJv5nvPqutRqTjeI0hwtOiG8
         zDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678237881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QJDrTocP4I9YKZY4mDmZOrPdR8HyI+d6gaRdmdXMQo=;
        b=qtx5gqNsHhNSDgBGe9eHqPvKOugmFqUSHjORYIxIIwZITo9iShsi+WZGH8xKKvsw00
         5MEWfVBCpms8DaJJYdkqk8KOtAgc448A4i/uUAXgeDPrIOMS8Mrgqa7cuyr9ladREqGY
         LFY9raWTz6H/5Jd+sJhnSaQd74FkYd4Y8nshj6tEW26lniwbENP0ck5eULCf5H/OHSFY
         6IbtlAEo6PIAsu2jR//Slbyp3x+LMOFB0SF6b4R8MFmfanMoeXVSIg1XXoErnuzO0QHz
         SuIxs4NzSUkiTITk4SP3B5TLxxSVbFWeBOe+bEEnFHp4InLneRfbNv0KA/OqI7YS6M/P
         tC6w==
X-Gm-Message-State: AO0yUKWlHyvSR0HTikD3zlkeqiq67cT+FBTMTseoji5FR6YzosTr76DR
        vittofZCwUK6YiXnQKhsEJs=
X-Google-Smtp-Source: AK7set+my4oxSDrZDzfLhOTVHj6QtCdki5ixqRa2moRgJ5oHNqerg72cGfeBHuHyxxQtPV1OXpZY8A==
X-Received: by 2002:a17:903:230e:b0:19c:b4e3:c660 with SMTP id d14-20020a170903230e00b0019cb4e3c660mr18877583plh.47.1678237881072;
        Tue, 07 Mar 2023 17:11:21 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21cf::1402? ([2620:10d:c090:400::5:173])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709029a4700b0019339f3368asm9022993plv.3.2023.03.07.17.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 17:11:20 -0800 (PST)
Message-ID: <5fc2580a-f8f2-d9e8-ebc5-e567ed67b24f@gmail.com>
Date:   Tue, 7 Mar 2023 17:11:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v4 2/9] bpf: Create links for BPF struct_ops
 maps.
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
References: <20230307233307.3626875-1-kuifeng@meta.com>
 <20230307233307.3626875-3-kuifeng@meta.com>
 <CAEf4BzYKrO3VZ=s5JA+TyC1iMEQnWm=RJutsEVV08bM9br-new@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzYKrO3VZ=s5JA+TyC1iMEQnWm=RJutsEVV08bM9br-new@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/7/23 16:37, Andrii Nakryiko wrote:
> On Tue, Mar 7, 2023 at 3:33 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>>
>> BPF struct_ops maps are employed directly to register TCP Congestion
>> Control algorithms. Unlike other BPF programs that terminate when
>> their links gone. The link of a BPF struct_ops map provides a uniform
>> experience akin to other types of BPF programs.
>>
>> bpf_links are responsible for registering their associated
>> struct_ops. You can only use a struct_ops that has the BPF_F_LINK flag
>> set to create a bpf_link, while a structs without this flag behaves in
>> the same manner as before and is registered upon updating its value.
>>
>> The BPF_LINK_TYPE_STRUCT_OPS serves a dual purpose. Not only is it
>> used to craft the links for BPF struct_ops programs, but also to
>> create links for BPF struct_ops them-self.  Since the links of BPF
>> struct_ops programs are only used to create trampolines internally,
>> they are never seen in other contexts. Thus, they can be reused for
>> struct_ops themself.
>>
>> To maintain a reference to the map supporting this link, we add
>> bpf_struct_ops_link as an additional type. The pointer of the map is
>> RCU and won't be necessary until later in the patchset.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   include/linux/bpf.h            |  11 +++
>>   include/uapi/linux/bpf.h       |  12 +++-
>>   kernel/bpf/bpf_struct_ops.c    | 119 +++++++++++++++++++++++++++++++--
>>   kernel/bpf/syscall.c           |  23 ++++---
>>   tools/include/uapi/linux/bpf.h |  12 +++-
>>   5 files changed, 163 insertions(+), 14 deletions(-)
>>
> 
> [...]
> 
>> +int bpf_struct_ops_link_create(union bpf_attr *attr)
>> +{
>> +       struct bpf_struct_ops_link *link = NULL;
>> +       struct bpf_link_primer link_primer;
>> +       struct bpf_struct_ops_map *st_map;
>> +       struct bpf_map *map;
>> +       int err;
>> +
>> +       map = bpf_map_get(attr->link_create.map_fd);
>> +       if (!map)
>> +               return -EINVAL;
>> +
>> +       st_map = (struct bpf_struct_ops_map *)map;
>> +
>> +       if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS || !(map->map_flags & BPF_F_LINK) ||
>> +           /* Pair with smp_store_release() during map_update */
>> +           smp_load_acquire(&st_map->kvalue.state) != BPF_STRUCT_OPS_STATE_READY) {
>> +               err = -EINVAL;
>> +               goto err_out;
>> +       }
>> +
>> +       link = kzalloc(sizeof(*link), GFP_USER);
>> +       if (!link) {
>> +               err = -ENOMEM;
>> +               goto err_out;
>> +       }
>> +       bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL);
>> +       RCU_INIT_POINTER(link->map, map);
>> +
>> +       err = bpf_link_prime(&link->link, &link_primer);
>> +       if (err)
>> +               goto err_out;
>> +
>> +       err = st_map->st_ops->reg(st_map->kvalue.data);
>> +       if (err) {
>> +               bpf_link_cleanup(&link_primer);
> 
> link = NULL to avoid kfree()-ing it, see bpf_tracing_prog_attach() for
> similar approach
> 

Got it! Thank you!

>> +               goto err_out;
>> +       }
>> +
>> +       return bpf_link_settle(&link_primer);
>> +
>> +err_out:
>> +       bpf_map_put(map);
>> +       kfree(link);
>> +       return err;
>> +}
>> +
> 
> [...]
