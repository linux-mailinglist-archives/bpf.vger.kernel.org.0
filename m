Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A65E6B0EC0
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 17:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCHQ2v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 11:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjCHQ2d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 11:28:33 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F311CCE80
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 08:27:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so2257646pjg.4
        for <bpf@vger.kernel.org>; Wed, 08 Mar 2023 08:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678292869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=noBRcmXPxLjRAX6O2YWkwxmsC7dESGXBHA15rLMOevU=;
        b=NEfoAcZVpqf0vrdjGXgcX05XL42TnqYRr+fbzhmjcxs2J0Oq66zRITJ807K7kSttjQ
         2GjXr5CAV9PFh4ykK0k1/P3Mtif1VHRgF4SDjHkN9NUjB9Kh83ZgZPk3ZYM/FSRZI5Yx
         HCIyUGaj2FOKBD+Kq0t+7ouQh6fDoeZmVhMq7SBBlI1cHEbXPzYOvNilOD8ob9SL+4Hg
         SOxSjdvghKvgKEQ/iEq1nFmvPUw8iL0GAhP+yDvRxZbcE+MKCu+XN/gcQvKZDpLYHgYQ
         INhlRvIOh5QeLa6sTxWTmESb6hVdH7zxKyVdd1slZ7pQ6qu4T1LbZwVlVYEu/NWFH4fV
         xlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678292869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noBRcmXPxLjRAX6O2YWkwxmsC7dESGXBHA15rLMOevU=;
        b=hFjB65gUEr5g1CT0uUblqgA6Y/tNJpFzSVGKRf4JYMPhu3d6OU3u/1fD0JwjdMiHqq
         bit55L1DVPf9SKsoux8oGw8YwFPACscbgG2qCu8FxffWyqFuKDwtH531hFc/AeZtVYVF
         GaPq/GP9lmwN35QWHzEAVyY5bOU0iZUOCI8jHeFD86kZwJwQDIhqgSa4Bapee0odC5pv
         GW2Ifv3eRqlneJQxK2h8R/IEb7ctOsilRoL3LXMBvMDpAqUqfaAIquWLHalMZnEMO4kj
         /9H2/0Id9QJbfZCHgLgsIaekXc1YKCh3Wn3WspMA0e1JVYXh6Fi2AiGxMrpk6M1qrVbl
         Y/Cg==
X-Gm-Message-State: AO0yUKVkZZUvmrNHf0rFdNlVittxgM6qvKlVgu+bliXWXjAJIJyx0vS0
        FU9x6n9b1fVOHi8DNt6dyCg=
X-Google-Smtp-Source: AK7set9VNDDLdVNFxwmO/e8EVICaneTX1qaGv5n5HGuini7RyS91RYrs6xV9Rmw8Ka6XtFdf//qGOA==
X-Received: by 2002:a17:90a:341:b0:237:ae7c:1591 with SMTP id 1-20020a17090a034100b00237ae7c1591mr19234195pjf.26.1678292868735;
        Wed, 08 Mar 2023 08:27:48 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21d6::126c? ([2620:10d:c090:400::5:d539])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090ad59300b0023493354f37sm10874533pju.26.2023.03.08.08.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 08:27:48 -0800 (PST)
Message-ID: <23503351-16ee-e84c-33c4-43241614f7fb@gmail.com>
Date:   Wed, 8 Mar 2023 08:27:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v4 6/9] bpf: Update the struct_ops of a bpf_link.
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
References: <20230307233307.3626875-1-kuifeng@meta.com>
 <20230307233307.3626875-7-kuifeng@meta.com>
 <CAEf4BzbK8s+VFG5HefydD7CRLzkRFKg-Er0PKV_-C2-yttfXzA@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzbK8s+VFG5HefydD7CRLzkRFKg-Er0PKV_-C2-yttfXzA@mail.gmail.com>
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



On 3/7/23 16:49, Andrii Nakryiko wrote:
> On Tue, Mar 7, 2023 at 3:33 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
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
>>   include/linux/bpf.h            |  1 +
>>   include/uapi/linux/bpf.h       |  8 ++++--
>>   kernel/bpf/bpf_struct_ops.c    | 46 ++++++++++++++++++++++++++++++++++
>>   kernel/bpf/syscall.c           | 43 ++++++++++++++++++++++++++++---
>>   tools/include/uapi/linux/bpf.h |  7 +++++-
>>   5 files changed, 98 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 047d2c6aba88..2b5f150e370e 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1405,6 +1405,7 @@ struct bpf_link_ops {
>>          void (*show_fdinfo)(const struct bpf_link *link, struct seq_file *seq);
>>          int (*fill_link_info)(const struct bpf_link *link,
>>                                struct bpf_link_info *info);
>> +       int (*update_map)(struct bpf_link *link, struct bpf_map *new_map);
>>   };
>>
>>   struct bpf_tramp_link {
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index eb3e435c5303..999e199ebe06 100644
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
>> index c71c8d73c7ad..2b850ce11617 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -759,10 +759,56 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
>>          return 0;
>>   }
>>
>> +static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map *new_map)
>> +{
>> +       struct bpf_struct_ops_value *kvalue;
>> +       struct bpf_struct_ops_map *st_map, *old_st_map;
>> +       struct bpf_struct_ops_link *st_link;
>> +       struct bpf_map *old_map;
>> +       int err = 0;
>> +
>> +       if (new_map->map_type != BPF_MAP_TYPE_STRUCT_OPS ||
>> +           !(new_map->map_flags & BPF_F_LINK))
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&update_mutex);
>> +
>> +       st_link = container_of(link, struct bpf_struct_ops_link, link);
>> +
>> +       /* The new and old struct_ops must be the same type. */
>> +       st_map = container_of(new_map, struct bpf_struct_ops_map, map);
>> +
>> +       old_map = st_link->map;
>> +       old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
>> +       if (st_map->st_ops != old_st_map->st_ops ||
>> +           /* Pair with smp_store_release() during map_update */
>> +           smp_load_acquire(&st_map->kvalue.state) != BPF_STRUCT_OPS_STATE_READY) {
>> +               err = -EINVAL;
>> +               goto err_out;
>> +       }
>> +
>> +       kvalue = &st_map->kvalue;
>> +
>> +       err = st_map->st_ops->update(kvalue->data, old_st_map->kvalue.data);
>> +       if (err)
>> +               goto err_out;
>> +
>> +       bpf_map_inc(new_map);
>> +       rcu_assign_pointer(st_link->map, new_map);
>> +
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
>> index 25b044fdd82b..94ab1336ff41 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -4646,6 +4646,30 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
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
>> +
>> +       if (new_map->map_type != BPF_MAP_TYPE_STRUCT_OPS) {
>> +               ret = -EINVAL;
>> +               goto out_put_map;
>> +       }
>> +
>> +       if (link->ops->update_map)
>> +               ret = link->ops->update_map(link, new_map);
>> +       else
>> +               ret = -EINVAL;
>> +
>> +out_put_map:
>> +       bpf_map_put(new_map);
>> +       return ret;
>> +}
>> +
>>   #define BPF_LINK_UPDATE_LAST_FIELD link_update.old_prog_fd
>>
>>   static int link_update(union bpf_attr *attr)
>> @@ -4658,14 +4682,25 @@ static int link_update(union bpf_attr *attr)
>>          if (CHECK_ATTR(BPF_LINK_UPDATE))
>>                  return -EINVAL;
>>
>> -       flags = attr->link_update.flags;
>> -       if (flags & ~BPF_F_REPLACE)
>> -               return -EINVAL;
>> -
>>          link = bpf_link_get_from_fd(attr->link_update.link_fd);
>>          if (IS_ERR(link))
>>                  return PTR_ERR(link);
>>
>> +       flags = attr->link_update.flags;
>> +
>> +       if (link->ops->update_map) {
>> +               if (flags)      /* always replace the existing one */
>> +                       ret = -EINVAL;
>> +               else
>> +                       ret = link_update_map(link, attr);
>> +               goto out_put_link;
> 
> umm... BPF_F_REPLACE for link_update is specifying "update only if
> current prog fd matches what I specify", let's not ignore it for
> struct_ops. This will create a deviation in behavior unnecessarily.
> Please keep it consistent.

Ok!

> 
> 
>> +       }
>> +
>> +       if (flags & ~BPF_F_REPLACE) {
>> +               ret = -EINVAL;
>> +               goto out_put_link;
>> +       }
>> +
>>          new_prog = bpf_prog_get(attr->link_update.new_prog_fd);
>>          if (IS_ERR(new_prog)) {
>>                  ret = PTR_ERR(new_prog);
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index cd0ff39981e8..259b8ab4f54e 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1556,7 +1556,12 @@ union bpf_attr {
>>          struct { /* struct used by BPF_LINK_UPDATE command */
>>                  __u32           link_fd;        /* link fd */
>>                  /* new program fd to update link with */
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
>> --
>> 2.34.1
>>
