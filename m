Return-Path: <bpf+bounces-70124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD131BB15EB
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 19:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AAA3174C97
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 17:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CE9254B1F;
	Wed,  1 Oct 2025 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY05wDdH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E3A17AE1D
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759340007; cv=none; b=ES3nAZ8mQJyIpkqHRSS+QJdrAxJDVdmKyPqqFesLmt/DpDU7n/Re3W9X5ckjI6Z4biITJDP9JiQlUMY96HPUeJH76sP4CiNs1qg9En0aeqiLStqd1lCnhJmby5yWwSH++HtHy1Dk/6T4+ctcD+54/Awm+K4a8SJq0ZgNBlsJij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759340007; c=relaxed/simple;
	bh=OEeoNV7sK6UvF+t+I1t+X1hP7gx9hrHHSM0GTBk9WGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZqnkcwJzsgvaqrkIXQTJWZV9pRN6unvtOnEi7/6xp3ac+fzMnN/Dl1hg9SelsIazS2JI6uQcv+KbEusGdFRLNVyC4ZJ+kmcdwoTwBuAbOKvOYwysQj61bLXuDmzqyGHgRjAm8TxuRtxjIlDKRttZqctQfTp3zMuCxwxWx2ytQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY05wDdH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso530915e9.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759340003; x=1759944803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jba0KIeNe/dm42FwS3kLZy28vX9Z3CFBQQdK2qAnZg8=;
        b=AY05wDdHi4asCxgoKUj1A9U2tF7drwRVKOKE2lE/ZUPqOOyzDwOUUhXPijscND4usS
         lXeZqmTAENYCbk7RzKI7Y6qdiKbszaLiZ40q4OOukS/Ptx5aq+/BdS3E8A3yzgYOOoXd
         FB7kEgXuJZE78oY0Kq00H2QYbERyZ+OUyz/LUoMPt1pQE1K/Fg9bbewyYl2241lMJhpU
         7SjzhwssXTgKWNIsBUJGHbpXesRhSqkVnsMwtt/X7pKoSRt0XDDZLPu7tazS9xYLoR4n
         bRHurLgOtQpdd4ssb6Few+Xp9vcWSjV6LcOJsRhMSNmSUIOE/yhhZ4TOqvsgBkAqEcNE
         kU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759340003; x=1759944803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jba0KIeNe/dm42FwS3kLZy28vX9Z3CFBQQdK2qAnZg8=;
        b=iSRrN2+qnYglWUYvGU6cIR56YvRwXnd6EIIA2rX1Z4zxTIGwexOo1V30XPIZMN34UO
         tMhBVm9cH8QuqyzyFWmtxwSiWcWCc41lvNK8HY2iA+/q2K4XPIyha/Jz/E1akpyvd5AB
         ZitnY9MoOxaKQLLE8862JjGwVzhIfRn2i18s29d4RyGK5VEhFin+B+QZ2L3/kwNoB6Ri
         47jYhMJQAScKWv0Q+ue/anE/o2F+j/CTKaDII5Q+b2uN5tw0Y+jhikfhrm2CNsb4ABqo
         n/+z62ADgQHOW2qCLijDkZEHq2ruSoZBHjYqjz/Ct2zBnPYmnhmqt/VfRt6q1J6vehdm
         km9g==
X-Gm-Message-State: AOJu0YyI+z/bXVCtspM9jsbC8evyfltSyKvOtW4/BJ+beyq+TeL6Ooij
	gBVTTcvj7MD+mQpTVt3x6QXgxVxZV9LzsLEU3WvrUFH3APQva3funXNk
X-Gm-Gg: ASbGnctnBvw4AZTZb5IYQz/6usTV418qO/jY1GwBmFHIcUZ0w51AK+8rC7/zmWU+G4o
	aKRbZTMqkxTPtFzntdANkr3nMKox6r1bpdPXXyebj3e6mwLmuCNkX7a9j0wGASSJyt2xnY17oOB
	SdEC20gR5fs+6x50ImOWU3w2/KiFz/1OfptPE6Qbd5BLZfRcozqjkdaanguQ3wuP/5CPV2WZ3WQ
	7nQY40pK2A20bhnAYNPjsb1fDule5hyARudQxXjDlv0hK++tOCjZwMWCc2uBtkFIr78N8qYNxaX
	D70R/m7UBfYa08vptEa5FX9EjG9oUdD3Cce/d87eA+94Kbvs+kLyB8Id9CrZNhr3/fgb3e+yCZ6
	X6xNyCjdbAciTeBoLCztuoqx7ZbkjuwJa0pnh1CgW3rNIBawiQ5vDOOBz+gRMb3+EXzw2gEaAYi
	q1P8AEuHsmhls=
X-Google-Smtp-Source: AGHT+IF1I5M9O694jiElfQRPsGyX8cQl6UPCzH0Ng2UNmCDt0eYCrWNMgSRkJVSzeusbmLn8Le2ksQ==
X-Received: by 2002:a05:600c:a08e:b0:46d:cfc9:1d20 with SMTP id 5b1f17b1804b1-46e612bab6cmr32394205e9.22.1759340003140;
        Wed, 01 Oct 2025 10:33:23 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:c2ca:1894:572a:7e0e? ([2620:10d:c092:500::4:a74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6901c3a6sm1195075e9.0.2025.10.01.10.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 10:33:22 -0700 (PDT)
Message-ID: <a871de6c-f260-4a88-9d9a-645075eb4478@gmail.com>
Date: Wed, 1 Oct 2025 18:33:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 2/2] bpf: extract internal structs helpers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20251001132252.385398-1-mykyta.yatsenko5@gmail.com>
 <20251001132252.385398-2-mykyta.yatsenko5@gmail.com>
 <CAEf4BzbK9cY+Oqn265uyzKSBWjy6rFRwUheMwZBJUeeuGGDrhw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzbK9cY+Oqn265uyzKSBWjy6rFRwUheMwZBJUeeuGGDrhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/1/25 18:00, Andrii Nakryiko wrote:
> On Wed, Oct 1, 2025 at 6:23 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> arraymap and hashtab duplicate the logic that checks for and frees
>> internal structs (timer, workqueue, task_work) based on
>> BTF record flags. Centralize this by introducing two helpers:
>>
>>    * bpf_map_has_internal_structs(map)
>>      Returns true if the map value contains any of internal structs:
>>      BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK.
>>
>>    * bpf_map_free_internal_structs(map, obj)
>>      Frees the internal structs for a single value object.
>>
>> Convert arraymap and both the prealloc/malloc hashtab paths to use the
>> new generic functions. This keeps the functionality for when/how to free
>> these special fields in one place and makes it easier to add support for
>> new internal structs in the future without touching every map
>> implementation.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   include/linux/bpf.h   |  4 ++++
>>   kernel/bpf/arraymap.c | 17 ++++++----------
>>   kernel/bpf/hashtab.c  | 45 ++++++++++++++++++++++++-------------------
>>   3 files changed, 35 insertions(+), 31 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index a98c83346134..3f7525f5c436 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -663,6 +663,10 @@ int map_check_no_btf(const struct bpf_map *map,
>>   bool bpf_map_meta_equal(const struct bpf_map *meta0,
>>                          const struct bpf_map *meta1);
>>
>> +bool bpf_map_has_internal_structs(struct bpf_map *map);
>> +
>> +void bpf_map_free_internal_structs(struct bpf_map *map, void *obj);
>> +
>>   extern const struct bpf_map_ops bpf_map_offload_ops;
>>
>>   /* bpf_type_flag contains a set of flags that are applicable to the values of
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index 80b1765a3159..bfde60402fd5 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -448,19 +448,14 @@ static void array_map_free_internal_structs(struct bpf_map *map)
>>          struct bpf_array *array = container_of(map, struct bpf_array, map);
>>          int i;
>>
>> -       /* We don't reset or free fields other than timer and workqueue
>> +       /* We don't reset or free fields other than timer, workqueue and task_work
>>           * on uref dropping to zero.
>>           */
>> -       if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
>> -               for (i = 0; i < array->map.max_entries; i++) {
>> -                       if (btf_record_has_field(map->record, BPF_TIMER))
>> -                               bpf_obj_free_timer(map->record, array_map_elem_ptr(array, i));
>> -                       if (btf_record_has_field(map->record, BPF_WORKQUEUE))
>> -                               bpf_obj_free_workqueue(map->record, array_map_elem_ptr(array, i));
>> -                       if (btf_record_has_field(map->record, BPF_TASK_WORK))
>> -                               bpf_obj_free_task_work(map->record, array_map_elem_ptr(array, i));
>> -               }
>> -       }
>> +       if (!bpf_map_has_internal_structs(map))
>> +               return;
>> +
>> +       for (i = 0; i < array->map.max_entries; i++)
>> +               bpf_map_free_internal_structs(map, array_map_elem_ptr(array, i));
>>   }
>>
>>   /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index c2fcd0cd51e5..40936dec0402 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -215,17 +215,19 @@ static bool htab_has_extra_elems(struct bpf_htab *htab)
>>          return !htab_is_percpu(htab) && !htab_is_lru(htab) && !is_fd_htab(htab);
>>   }
>>
>> -static void htab_free_internal_structs(struct bpf_htab *htab, struct htab_elem *elem)
>> +bool bpf_map_has_internal_structs(struct bpf_map *map)
>>   {
>> -       if (btf_record_has_field(htab->map.record, BPF_TIMER))
>> -               bpf_obj_free_timer(htab->map.record,
>> -                                  htab_elem_value(elem, htab->map.key_size));
>> -       if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
>> -               bpf_obj_free_workqueue(htab->map.record,
>> -                                      htab_elem_value(elem, htab->map.key_size));
>> -       if (btf_record_has_field(htab->map.record, BPF_TASK_WORK))
>> -               bpf_obj_free_task_work(htab->map.record,
>> -                                      htab_elem_value(elem, htab->map.key_size));
>> +       return btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK);
>> +}
> make this static inline and put into include/linux/btf.h to keep this check fast
>
>> +
>> +void bpf_map_free_internal_structs(struct bpf_map *map, void *obj)
> I'd try to make it clearer that we are working with map value, so obj
> -> val, and maybe name this bpf_map_value_free_internal_structs
>
> (though we probably want to come up with shorter name for this
> concept, "internal_structs" is quite verbose, but I don't have a great
> suggestion)
>
>
> Also, let's move this to kernel/bpf/helpers.c, it doesn't make sense
> to keep this in hashtab.c
>
>> +{
>> +       if (btf_record_has_field(map->record, BPF_TIMER))
>> +               bpf_obj_free_timer(map->record, obj);
>> +       else if (btf_record_has_field(map->record, BPF_WORKQUEUE))
>> +               bpf_obj_free_workqueue(map->record, obj);
>> +       else if (btf_record_has_field(map->record, BPF_TASK_WORK))
>> +               bpf_obj_free_task_work(map->record, obj);
> why elses? all of them can be present (and let's add a test that verifies that)
Good point, somehow I thought they should be mutually-exclusive. I'll 
send fixed v2, thanks.
>
> pw-bot: cr
>
>
>>   }
>>
>>   static void htab_free_prealloced_internal_structs(struct bpf_htab *htab)
>> @@ -240,7 +242,8 @@ static void htab_free_prealloced_internal_structs(struct bpf_htab *htab)
>>                  struct htab_elem *elem;
>>
>>                  elem = get_htab_elem(htab, i);
>> -               htab_free_internal_structs(htab, elem);
>> +               bpf_map_free_internal_structs(&htab->map,
>> +                                             htab_elem_value(elem, htab->map.key_size));
>>                  cond_resched();
>>          }
>>   }
>> @@ -1509,8 +1512,9 @@ static void htab_free_malloced_internal_structs(struct bpf_htab *htab)
>>                  struct htab_elem *l;
>>
>>                  hlist_nulls_for_each_entry(l, n, head, hash_node) {
>> -                       /* We only free timer on uref dropping to zero */
>> -                       htab_free_internal_structs(htab, l);
>> +                       /* We only free timer, wq, task_work on uref dropping to zero */
> not sure it makes sense to keep listing all possible special structs
> we are freeing, maybe just make a generic comment and whoever needs to
> know exactly can always check implementation of
> bpf_map_free_internal_structs? (there was another comment like that
> earlier, I'd generalize it as well)
>
>> +                       bpf_map_free_internal_structs(&htab->map,
>> +                                                     htab_elem_value(l, htab->map.key_size));
>>                  }
>>                  cond_resched_rcu();
>>          }
>> @@ -1521,13 +1525,14 @@ static void htab_map_free_internal_structs(struct bpf_map *map)
>>   {
>>          struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>
>> -       /* We only free timer and workqueue on uref dropping to zero */
>> -       if (btf_record_has_field(htab->map.record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
>> -               if (!htab_is_prealloc(htab))
>> -                       htab_free_malloced_internal_structs(htab);
>> -               else
>> -                       htab_free_prealloced_internal_structs(htab);
>> -       }
>> +       /* We only free timer, workqueue, task_work on uref dropping to zero */
>> +       if (!bpf_map_has_internal_structs(map))
>> +               return;
>> +
>> +       if (htab_is_prealloc(htab))
>> +               htab_free_prealloced_internal_structs(htab);
>> +       else
>> +               htab_free_malloced_internal_structs(htab);
>>   }
>>
>>   /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
>> --
>> 2.51.0
>>


