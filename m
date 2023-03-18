Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAB66BF702
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 01:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCRAlV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 20:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCRAlU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 20:41:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2FF3CE03
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 17:41:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h8so7041461plf.10
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 17:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679100077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FAoE3rDktey+KO7NdL/mCkve4m+zQG1OG+Zbpkj7BiI=;
        b=g8EMn9REXxlV32WXnrMsm2QljR1+H7/KjByaKgIU76aRBGc2Rm1RHWBS5nqbHidPyO
         QFQW0VW4ZqstOPuRHtqgy7zVuBpiPFKMg/4NCD3Ne7kzlIxNRw0M/wFRj1GBs3Wx21BE
         9pZa0t+HM5oKNOyfztv4yjCuE7RC4ZWcL0s6S6AvW8C66uf3Lsd2vqoI6BLFnvBop+qc
         OaY/InwbIaaXrHh+ceQPpFnaQ2wdATKDcvURq4nTihyaSjOoP9DBNypL36wchbL1G15G
         91e3+PQdiVatkriks+bLPWi0588Sq2w+aRHS39B0Tw4JLk1aeF8Tg2ba91r+PAJn33GG
         kkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679100077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAoE3rDktey+KO7NdL/mCkve4m+zQG1OG+Zbpkj7BiI=;
        b=xzGorrXhSMGTzdX14PIPigKfke3sdXMbEL4r0+1g+ERtEJOJyjzgp8Mda01G9v2qO6
         MMLPehjOmZTe2PYILjHzkkghGy8wd2hhxupHGJZHEV4YXXvJh5BQMSw8GJA/QdgMoVpn
         WKgIwPZm9m30iX4UNvdYL8COMJQU5i2YRiLWL50NIZQP4ziYEWTf0334wws+lehW7s4S
         Jwi2aPGVvELU13nulDy0j7LEEEOKtfHx3Wz2s5nJxlEhSGQajgdXQiJfQedNUsi7OSPZ
         yc5d/6Jyrrp9G+CU//3xXsVq9hGxD465wYgOvzfPAaXi3Y6jCUryAs3twVxsRyA6drLH
         sbuA==
X-Gm-Message-State: AO0yUKV5dwEfMyH/1ajSObOol3jKzTazIwDzdBZih6NS1Xn4o1yrrHjg
        jTEd/bUZVtLRZNIrNdRn5wGL8eGCGsY=
X-Google-Smtp-Source: AK7set/3O79OnYb4q/u/UMYFyeSKY54yaJwGqEGgf/qVjqQ10zK6IQ8Fl6negQWcjS9s3M5Ya6MlbA==
X-Received: by 2002:a05:6a20:8493:b0:d4:9cb2:9030 with SMTP id u19-20020a056a20849300b000d49cb29030mr8409397pzd.24.1679100076819;
        Fri, 17 Mar 2023 17:41:16 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1380? ([2620:10d:c090:400::5:87c3])
        by smtp.gmail.com with ESMTPSA id n21-20020a62e515000000b0058bc60dd98dsm2115513pff.23.2023.03.17.17.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 17:41:16 -0700 (PDT)
Message-ID: <e40829fe-bb00-9296-3b24-2412d72f7eaf@gmail.com>
Date:   Fri, 17 Mar 2023 17:41:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v7 5/8] bpf: Update the struct_ops of a bpf_link.
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
References: <20230316023641.2092778-1-kuifeng@meta.com>
 <20230316023641.2092778-6-kuifeng@meta.com>
 <CAEf4BzY77ntrzDK+YdFY56hhLaR2Nh3UuvR9rMU68BCPXsc1bg@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzY77ntrzDK+YdFY56hhLaR2Nh3UuvR9rMU68BCPXsc1bg@mail.gmail.com>
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



On 3/17/23 15:27, Andrii Nakryiko wrote:
> On Wed, Mar 15, 2023 at 7:37 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>>
>> By improving the BPF_LINK_UPDATE command of bpf(), it should allow you
>> to conveniently switch between different struct_ops on a single
>> bpf_link. This would enable smoother transitions from one struct_ops
>> to another.
>>
>> The struct_ops maps passing along with BPF_LINK_UPDATE should have the
>> BPF_F_LINK flag.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   include/linux/bpf.h            |  2 ++
>>   include/uapi/linux/bpf.h       |  8 +++++--
>>   kernel/bpf/bpf_struct_ops.c    | 38 ++++++++++++++++++++++++++++++++++
>>   kernel/bpf/syscall.c           | 20 ++++++++++++++++++
>>   net/bpf/bpf_dummy_struct_ops.c |  6 ++++++
>>   net/ipv4/bpf_tcp_ca.c          |  6 ++++++
>>   tools/include/uapi/linux/bpf.h |  8 +++++--
>>   7 files changed, 84 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 455b14bf8f28..56e6ab7559ef 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1474,6 +1474,7 @@ struct bpf_link_ops {
>>          void (*show_fdinfo)(const struct bpf_link *link, struct seq_file *seq);
>>          int (*fill_link_info)(const struct bpf_link *link,
>>                                struct bpf_link_info *info);
>> +       int (*update_map)(struct bpf_link *link, struct bpf_map *new_map);
>>   };
>>
>>   struct bpf_tramp_link {
>> @@ -1516,6 +1517,7 @@ struct bpf_struct_ops {
>>                             void *kdata, const void *udata);
>>          int (*reg)(void *kdata);
>>          void (*unreg)(void *kdata);
>> +       int (*update)(void *kdata, void *old_kdata);
>>          int (*validate)(void *kdata);
>>          const struct btf_type *type;
>>          const struct btf_type *value_type;
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 42f40ee083bf..24e1dec4ad97 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1555,8 +1555,12 @@ union bpf_attr {
>>
>>          struct { /* struct used by BPF_LINK_UPDATE command */
>>                  __u32           link_fd;        /* link fd */
>> -               /* new program fd to update link with */
>> -               __u32           new_prog_fd;
>> +               union {
>> +                       /* new program fd to update link with */
>> +                       __u32           new_prog_fd;
>> +                       /* new struct_ops map fd to update link with */
>> +                       __u32           new_map_fd;
>> +               };
>>                  __u32           flags;          /* extra flags */
>>                  /* expected link's program fd; is specified only if
>>                   * BPF_F_REPLACE flag is set in flags */
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 8ce6c7581ca3..5a9e10b92423 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -807,10 +807,48 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
>>          return 0;
>>   }
>>
>> +static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map *new_map)
>> +{
>> +       struct bpf_struct_ops_map *st_map, *old_st_map;
>> +       struct bpf_struct_ops_link *st_link;
>> +       struct bpf_map *old_map;
>> +       int err = 0;
>> +
>> +       st_link = container_of(link, struct bpf_struct_ops_link, link);
>> +       st_map = container_of(new_map, struct bpf_struct_ops_map, map);
>> +
>> +       if (!bpf_struct_ops_valid_to_reg(new_map))
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&update_mutex);
>> +
>> +       old_map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
>> +       old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
>> +       /* The new and old struct_ops must be the same type. */
>> +       if (st_map->st_ops != old_st_map->st_ops) {
>> +               err = -EINVAL;
>> +               goto err_out;
>> +       }
>> +
>> +       err = st_map->st_ops->update(st_map->kvalue.data, old_st_map->kvalue.data);
>> +       if (err)
>> +               goto err_out;
>> +
>> +       bpf_map_inc(new_map);
>> +       rcu_assign_pointer(st_link->map, new_map);
>> +       bpf_map_put(old_map);
>> +
>> +err_out:
>> +       mutex_unlock(&update_mutex);
>> +
>> +       return err;
>> +}
>> +
>>   static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>>          .dealloc = bpf_struct_ops_map_link_dealloc,
>>          .show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
>>          .fill_link_info = bpf_struct_ops_map_link_fill_link_info,
>> +       .update_map = bpf_struct_ops_map_link_update,
>>   };
>>
>>   int bpf_struct_ops_link_create(union bpf_attr *attr)
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 5a45e3bf34e2..6fa10d108278 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -4676,6 +4676,21 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>>          return ret;
>>   }
>>
>> +static int link_update_map(struct bpf_link *link, union bpf_attr *attr)
>> +{
>> +       struct bpf_map *new_map;
>> +       int ret = 0;
>> +
>> +       new_map = bpf_map_get(attr->link_update.new_map_fd);
>> +       if (IS_ERR(new_map))
>> +               return -EINVAL;
> 
> I was expecting a check for the BPF_F_LINK flag here. Isn't it
> necessary to verify that here?


link->ops->update_map != NULL implies BPF_F_LINK.  So, it doesn't do
additional check for BPF_F_LINK here.


> 
> 
> 
>> +
>> +       ret = link->ops->update_map(link, new_map);
>> +
>> +       bpf_map_put(new_map);
>> +       return ret;
>> +}
>> +
>>   #define BPF_LINK_UPDATE_LAST_FIELD link_update.old_prog_fd
>>
> 
> [...]
