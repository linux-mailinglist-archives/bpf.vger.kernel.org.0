Return-Path: <bpf+bounces-70437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EEFBBF120
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 21:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40F63C08F6
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 19:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2EA2D5436;
	Mon,  6 Oct 2025 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGqpP/II"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF951D61A3
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759777991; cv=none; b=sf20wKLaEO5qRzqFSisjkCY1CA+6Cyq0El6Jn8VtrQ3TPbzlnp8o48ggTo8OYnlDQ6iVpbpcr1KUtLu8JSJIoFgOG1Zm9Y0L6nIhAqkn3zacJUA7gF772+b+zSBW2X/6cXNf7MnQWge67T9jv3QqDLrZXcwdJ2/wkbbTHxFcGU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759777991; c=relaxed/simple;
	bh=mlsXUypLaxWMjl9HrmTJn3375hs6p1q8KHDEdfSsYU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOHKhU7557/EUghtSx0ySsBjnRcLhA2WFbToYzzMn+B4zYIkDKeL2cezPQok3CsjWvJcpjnoGkz4x5slBQvfO/uPpAXdGZDkBXf2L089BNzEBB6v0Trb4Nzhea1QDbp+TfegLzwhsJMuUwd7/Iy/5GqMAmrtZdv/+dioWZBlLWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGqpP/II; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f0308469a4so3058015f8f.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 12:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759777987; x=1760382787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yr9xSLwS0kJUXE5yAcZSFHPJ3X0ScGS70CfsP1BbUU0=;
        b=SGqpP/IIoCKFFu8Qqlzm8EDHtAquX7HpPMcazDmZBXJ1XI0eGWkMEHea/tGBUWIWi1
         SqHevMZpzXmhVOWGN47tNvPCS/QCKJfjUCb1YJmRV50jPvv9vZO+IzCOanTyqpoTnrGq
         f6LvPtaGnTHEVB1sGu8reSFeCdS1GcK/D0Iv3QxKGI0pBJir7e1u1cD+DCL14x5siZmb
         J+SqGuqHucGZieorwiOYUuqs/kTQEHgZCTxy1LTRM0iGSCTTprHXyLFIvv37MDSJ9rzV
         rVCfRgsaxzj0eeqqpBIsO4VkBGAt43sxNUO9Oi+Whgu3Wf7VE/ZKKHclEV5PqJNdGnJC
         wA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759777987; x=1760382787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yr9xSLwS0kJUXE5yAcZSFHPJ3X0ScGS70CfsP1BbUU0=;
        b=w3vh08TyE37s9zvjreHENZiFY/4UkjN/12iYzWNIfNNYXSQOiNiM6Rr3Y9jtFI7Q8c
         fAx7PyllZRQuN9eocxddmlI7WBpFblNnwfJ8EmNkRvYxXjE7a4mCqBWsP5IADZ2GiEvP
         67EnaB4hHpUlUrif6yu3dEKrJu/7/DDXW1Yan2oXTr7tELbUa0LHH0I3mrhwCj9dw31k
         iPmw2mAIul1wMiGalYz0PgMPzDuypC/JavecFClOGBwFo8LHlz6LBgD013PF24Qj4hJR
         bYvOoPrYxQ+Jfkj2QHaeX9TKM+LleoGyrZ/dkCcRpY13sxwsiMX0uq1vV2s4Ce6BK+du
         XUJQ==
X-Gm-Message-State: AOJu0YzlgNCiTfjRoJkHyb3Fso9n2rcEz4qHcLvZjNcYiGdSJVW71eup
	DAZ93vpEUaRP/6om66hTwRDirF+1lJbZH1lVfXfMKG6nRHbiUSDtUed/
X-Gm-Gg: ASbGncuYJnvDyNreHCOOJ/HWtVDG59I5BpAuC472ASLjzyIpx/GJos5k/pkZ9r883zl
	54S8V3mXfdbGIYn6gTEH8dHB7MQSUu2LaBTNCzeegBNCfjcxRNz3qA9U0cZNn3iKbjFEo3DMREw
	YIgHqWOkOOy5SP9zdTEwgjfluZk7LpcFKAyXa7DMkum2jov6FcQtnfprVZSY/FRincawAVn06Re
	AHZAgIKmdklm33dUedEzRkz/xM/HriQzxGqzn/Cn08f7hzzMfCpkRbWeryJsEyetsT/dIVRlHM1
	qZbcU3V7gJR7R2j5QDPVMiuJuNuLlx6WJBYPUP7muJ1luYmzwXSSulNEUdyK/HKH9GCavcD5CWc
	r/4hJffDnXe4S/fN96+/hFtYN2pVT55HQzLVxmssTiZd3wIlBt55ywiIbtxZKHOH2BhTkr31dRH
	+JcLpw9Ub7B8mNae9aGVBW/tV7+tL2Wr4=
X-Google-Smtp-Source: AGHT+IGAmFGXCEoQsl5msAEQzTrRezP6wqfiOyJc8HHvuTEmvXdcfYOfJs7VZiP5en589IrELfuoYw==
X-Received: by 2002:a05:6000:40dc:b0:3c7:df1d:3d9 with SMTP id ffacd0b85a97d-425671c0c7dmr9025508f8f.39.1759777986951;
        Mon, 06 Oct 2025 12:13:06 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6e1bsm22210769f8f.8.2025.10.06.12.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 12:13:06 -0700 (PDT)
Message-ID: <7ad5567c-ecd8-44c3-8be9-238f41e0ad78@gmail.com>
Date: Mon, 6 Oct 2025 20:13:05 +0100
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
We have a test that uses few of these fields:
https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/wq.c#L12 

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


