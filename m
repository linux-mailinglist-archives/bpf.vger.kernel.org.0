Return-Path: <bpf+bounces-65782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F2DB285CC
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 20:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7342E1CC7F8C
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 18:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80C2F9C58;
	Fri, 15 Aug 2025 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkrvUt9H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9A6219315
	for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282351; cv=none; b=JTPJw6WuJU3Fyn+94SNo22xmZWyVJGI+x2pb6N+mk2iyCa69Kem1tIx+ngOOG1+bcFalEmfFL1sLmcavcELvM0ZXwMGvYbFTzKq7L/3KRnJvsKDbX0/ChQITKu3KxK60aGP0YPVWzz8hdQx8arf/XezWFV6Q1t0X0gmC0tm1oGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282351; c=relaxed/simple;
	bh=yde9FWfePtInsQqLF/Ez1qaIVGVM0D9JT9QsrNqxHto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6QCa7/5hIzhbvIwIyFgxhloknJTpT9nEte0eSqvDQtqnFBB9lrXJy6hwR7ymAlSvhG2cUGsTgIjyGqyAqSNILTBCXOpoG9/INXJXheQZ3M/D2y7AyxWzf91jOUTUppjxTP6hOckKbvkG6h71qeJPXn0ftlZcywSppmB1LAU5wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkrvUt9H; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9d41d2a5cso1845962f8f.0
        for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 11:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755282348; x=1755887148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fWFs43afGhXA1LxnNyqo77Z2nZEoKBMfJb133dp3tis=;
        b=hkrvUt9HBEjA9sWp56sypg14M2VXaCH2kizJ2/trC90YM7V01PCFiDax+Qf8N3PbO3
         F9iK6mYvsi6QN+ZTEYZ3k8dT+xu/HnefAyiDM3G1e5ti8bue3QPgZKE8FHMBw1cnpXP6
         nP1egk4OyyZYN7WFHPScBHdCBGhEeZ2eQ3fF990W3VCECpjyX4tcxDsiOwyBS4SM397J
         MHEcam8HVXI7gPpt1txMh5283Nt36nywWs7IVnOuFyWt3w2QoFp8pejCWMP+9tSiKa/r
         U4r2IJftpf6wOYCXCptkoKomyze9E/8w0zBiQY7VyKvZWxEwNp3CQelp0+eWWTfw+Xw6
         weRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755282348; x=1755887148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWFs43afGhXA1LxnNyqo77Z2nZEoKBMfJb133dp3tis=;
        b=Aax8DiE/y6H57KMN5EvffxEj3cbdesAvrUc0aqzjntvZ8wPKYWSDhZRRwG2veUwpE6
         A0Ts8hDDQPCNUb7e5ZiaC1YdxbZXUWPjDUVqE1HtKCeKLpbXLsGbE1Ds5gPtfbjJnbRT
         1u2iTOTJJ65EfXD98T5hk53qKrft4S1k5vkGc2HdlmLGc9VSSHjCFSNfzMzkPlnNj+z9
         sV2sKdXXFgLIfX/meBZ+caDLIYx0xLIEMnTYt2rcUs4oFXJX+Wxo016zHZktknh+NLPB
         8bkt2BZfnv/5OrhqdivIlK3uzj47EAOYuqE9aNvox3klqhV7sZj1jHyZCgZhgKJYQtle
         ZqqA==
X-Gm-Message-State: AOJu0YyJbVGsG4L5UWZVEjHN7lOkDs0RITARdBWR+j6LrgjUZxkUqID0
	AjvG807fXmZciBLA61lDQ6j5fGLETrzhC3pmEARXeXbN0JtlJH7hE1UY
X-Gm-Gg: ASbGnctYWA3E1WjiSdBd9QOlRB72MRdghtAfSvUWdX5SmgMwPyRu3xmxEM8eeEVWp6L
	3HCwaN2/lwp5PhhbvYkz7VB1/g237KQDi7BC4lM91GX8eHTbMjwEnz1UvTZ03GzVmmw89FHGZEc
	gHl3+Bn1VYCvJOFobbqrm2rK692l+U7TIv12BHtp9cLEYGeNcl1db85iftLYAUf503caLYtYfo4
	UTRr6bGq0chrTl4CxpXOkeMSYYBHkTe0lv7mfRgMqE7diM1Ru6rmeKHYgKlg0ylVE+lcsr40mQv
	AHhcd3X43Yf8TwjWwqcFdAlMnK6mHKtQogWtTq9aJeF4ViOv1MkZ1FH1ky/CJx/sao3XOHsV3tC
	aF+20fXcA5SM/D2m7nC8YSE9uveDLXy1pmDZGipTYB+0sKW9VZfrYiTfIPR+VabVHo3eT7MdyqP
	dcV/QcmbMxotyJ/JMt
X-Google-Smtp-Source: AGHT+IFCd3LKpuFExDVDid8Tmi77UoAcRA3LAJ7cl9Od5WPU/wSLD0r5eenaamq7oUQOjM5tI4tI7w==
X-Received: by 2002:a05:6000:2310:b0:3b7:8b64:3107 with SMTP id ffacd0b85a97d-3bc688ab9a7mr82724f8f.26.1755282347653;
        Fri, 15 Aug 2025 11:25:47 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22329b12sm27099005e9.24.2025.08.15.11.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 11:25:47 -0700 (PDT)
Message-ID: <1f7bc700-704a-495a-b353-57794db741e5@gmail.com>
Date: Fri, 15 Aug 2025 19:25:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/4] bpf: bpf task work plumbing
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com>
 <20250806144554.576706-2-mykyta.yatsenko5@gmail.com>
 <CAP01T76tPy6mLQcB8nX=VDmL4fXaGAP92z1rmSh4tBB03nsw0w@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAP01T76tPy6mLQcB8nX=VDmL4fXaGAP92z1rmSh4tBB03nsw0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/25 18:53, Kumar Kartikeya Dwivedi wrote:
> On Wed, 6 Aug 2025 at 16:46, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> This patch adds necessary plumbing in verifier, syscall and maps to
>> support handling new kfunc bpf_task_work_schedule and kernel structure
>> bpf_task_work. The idea is similar to how we already handle bpf_wq and
>> bpf_timer.
>> verifier changes validate calls to bpf_task_work_schedule to make sure
>> it is safe and expected invariants hold.
>> btf part is required to detect bpf_task_work structure inside map value
>> and store its offset, which will be used in the next patch to calculate
>> key and value addresses.
>> arraymap and hashtab changes are needed to handle freeing of the
>> bpf_task_work: run code needed to deinitialize it, for example cancel
>> task_work callback if possible.
>> The use of bpf_task_work and proper implementation for kfuncs are
>> introduced in the next patch.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   include/linux/bpf.h            |  11 +++
>>   include/uapi/linux/bpf.h       |   4 +
>>   kernel/bpf/arraymap.c          |   8 +-
>>   kernel/bpf/btf.c               |  15 ++++
>>   kernel/bpf/hashtab.c           |  22 ++++--
>>   kernel/bpf/helpers.c           |  45 +++++++++++
>>   kernel/bpf/syscall.c           |  23 +++++-
>>   kernel/bpf/verifier.c          | 131 ++++++++++++++++++++++++++++++++-
>>   tools/include/uapi/linux/bpf.h |   4 +
>>   9 files changed, 247 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index f9cd2164ed23..cb83ba0eaed5 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -206,6 +206,7 @@ enum btf_field_type {
>>          BPF_WORKQUEUE  = (1 << 10),
>>          BPF_UPTR       = (1 << 11),
>>          BPF_RES_SPIN_LOCK = (1 << 12),
>> +       BPF_TASK_WORK  = (1 << 13),
>>   };
>>
>>   typedef void (*btf_dtor_kfunc_t)(void *);
>> @@ -245,6 +246,7 @@ struct btf_record {
>>          int timer_off;
>>          int wq_off;
>>          int refcount_off;
>> +       int task_work_off;
>>          struct btf_field fields[];
>>   };
>>
>> @@ -340,6 +342,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
>>                  return "bpf_rb_node";
>>          case BPF_REFCOUNT:
>>                  return "bpf_refcount";
>> +       case BPF_TASK_WORK:
>> +               return "bpf_task_work";
>>          default:
>>                  WARN_ON_ONCE(1);
>>                  return "unknown";
>> @@ -378,6 +382,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
>>                  return sizeof(struct bpf_rb_node);
>>          case BPF_REFCOUNT:
>>                  return sizeof(struct bpf_refcount);
>> +       case BPF_TASK_WORK:
>> +               return sizeof(struct bpf_task_work);
>>          default:
>>                  WARN_ON_ONCE(1);
>>                  return 0;
>> @@ -410,6 +416,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
>>                  return __alignof__(struct bpf_rb_node);
>>          case BPF_REFCOUNT:
>>                  return __alignof__(struct bpf_refcount);
>> +       case BPF_TASK_WORK:
>> +               return __alignof__(struct bpf_task_work);
>>          default:
>>                  WARN_ON_ONCE(1);
>>                  return 0;
>> @@ -441,6 +449,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
>>          case BPF_KPTR_REF:
>>          case BPF_KPTR_PERCPU:
>>          case BPF_UPTR:
>> +       case BPF_TASK_WORK:
>>                  break;
>>          default:
>>                  WARN_ON_ONCE(1);
>> @@ -577,6 +586,7 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
>>                             bool lock_src);
>>   void bpf_timer_cancel_and_free(void *timer);
>>   void bpf_wq_cancel_and_free(void *timer);
>> +void bpf_task_work_cancel_and_free(void *timer);
>>   void bpf_list_head_free(const struct btf_field *field, void *list_head,
>>                          struct bpf_spin_lock *spin_lock);
>>   void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
>> @@ -2391,6 +2401,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec);
>>   bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *rec_b);
>>   void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
>>   void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj);
>> +void bpf_obj_free_task_work(const struct btf_record *rec, void *obj);
>>   void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
>>   void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 233de8677382..e444d9f67829 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7418,6 +7418,10 @@ struct bpf_timer {
>>          __u64 __opaque[2];
>>   } __attribute__((aligned(8)));
>>
>> +struct bpf_task_work {
>> +       __u64 __opaque[16];
>> +} __attribute__((aligned(8)));
>> +
>>   struct bpf_wq {
>>          __u64 __opaque[2];
>>   } __attribute__((aligned(8)));
>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>> index 3d080916faf9..4130d8e76dff 100644
>> --- a/kernel/bpf/arraymap.c
>> +++ b/kernel/bpf/arraymap.c
>> @@ -431,7 +431,7 @@ static void *array_map_vmalloc_addr(struct bpf_array *array)
>>          return (void *)round_down((unsigned long)array, PAGE_SIZE);
>>   }
>>
>> -static void array_map_free_timers_wq(struct bpf_map *map)
>> +static void array_map_free_internal_structs(struct bpf_map *map)
>>   {
>>          struct bpf_array *array = container_of(map, struct bpf_array, map);
>>          int i;
>> @@ -439,12 +439,14 @@ static void array_map_free_timers_wq(struct bpf_map *map)
>>          /* We don't reset or free fields other than timer and workqueue
>>           * on uref dropping to zero.
>>           */
>> -       if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE)) {
>> +       if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
>>                  for (i = 0; i < array->map.max_entries; i++) {
>>                          if (btf_record_has_field(map->record, BPF_TIMER))
>>                                  bpf_obj_free_timer(map->record, array_map_elem_ptr(array, i));
>>                          if (btf_record_has_field(map->record, BPF_WORKQUEUE))
>>                                  bpf_obj_free_workqueue(map->record, array_map_elem_ptr(array, i));
>> +                       if (btf_record_has_field(map->record, BPF_TASK_WORK))
>> +                               bpf_obj_free_task_work(map->record, array_map_elem_ptr(array, i));
>>                  }
>>          }
>>   }
>> @@ -783,7 +785,7 @@ const struct bpf_map_ops array_map_ops = {
>>          .map_alloc = array_map_alloc,
>>          .map_free = array_map_free,
>>          .map_get_next_key = array_map_get_next_key,
>> -       .map_release_uref = array_map_free_timers_wq,
>> +       .map_release_uref = array_map_free_internal_structs,
>>          .map_lookup_elem = array_map_lookup_elem,
>>          .map_update_elem = array_map_update_elem,
>>          .map_delete_elem = array_map_delete_elem,
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 0aff814cb53a..c66f9c6dfc48 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -3527,6 +3527,15 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
>>                          goto end;
>>                  }
>>          }
>> +       if (field_mask & BPF_TASK_WORK) {
>> +               if (!strcmp(name, "bpf_task_work")) {
>> +                       if (*seen_mask & BPF_TASK_WORK)
>> +                               return -E2BIG;
>> +                       *seen_mask |= BPF_TASK_WORK;
>> +                       type = BPF_TASK_WORK;
>> +                       goto end;
>> +               }
>> +       }
>>          field_mask_test_name(BPF_LIST_HEAD, "bpf_list_head");
>>          field_mask_test_name(BPF_LIST_NODE, "bpf_list_node");
>>          field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
>> @@ -3693,6 +3702,7 @@ static int btf_find_field_one(const struct btf *btf,
>>          case BPF_LIST_NODE:
>>          case BPF_RB_NODE:
>>          case BPF_REFCOUNT:
>> +       case BPF_TASK_WORK:
>>                  ret = btf_find_struct(btf, var_type, off, sz, field_type,
>>                                        info_cnt ? &info[0] : &tmp);
>>                  if (ret < 0)
>> @@ -3985,6 +3995,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
>>          rec->timer_off = -EINVAL;
>>          rec->wq_off = -EINVAL;
>>          rec->refcount_off = -EINVAL;
>> +       rec->task_work_off = -EINVAL;
>>          for (i = 0; i < cnt; i++) {
>>                  field_type_size = btf_field_type_size(info_arr[i].type);
>>                  if (info_arr[i].off + field_type_size > value_size) {
>> @@ -4050,6 +4061,10 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
>>                  case BPF_LIST_NODE:
>>                  case BPF_RB_NODE:
>>                          break;
>> +               case BPF_TASK_WORK:
>> +                       WARN_ON_ONCE(rec->task_work_off >= 0);
>> +                       rec->task_work_off = rec->fields[i].offset;
>> +                       break;
>>                  default:
>>                          ret = -EFAULT;
>>                          goto end;
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 71f9931ac64c..207ad4823b5b 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -215,7 +215,7 @@ static bool htab_has_extra_elems(struct bpf_htab *htab)
>>          return !htab_is_percpu(htab) && !htab_is_lru(htab) && !is_fd_htab(htab);
>>   }
>>
>> -static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
>> +static void htab_free_prealloced_internal_structs(struct bpf_htab *htab)
>>   {
>>          u32 num_entries = htab->map.max_entries;
>>          int i;
>> @@ -233,6 +233,9 @@ static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
>>                  if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
>>                          bpf_obj_free_workqueue(htab->map.record,
>>                                                 htab_elem_value(elem, htab->map.key_size));
>> +               if (btf_record_has_field(htab->map.record, BPF_TASK_WORK))
>> +                       bpf_obj_free_task_work(htab->map.record,
>> +                                              htab_elem_value(elem, htab->map.key_size));
>>                  cond_resched();
>>          }
>>   }
>> @@ -1490,7 +1493,7 @@ static void delete_all_elements(struct bpf_htab *htab)
>>          }
>>   }
>>
>> -static void htab_free_malloced_timers_and_wq(struct bpf_htab *htab)
>> +static void htab_free_malloced_internal_structs(struct bpf_htab *htab)
>>   {
>>          int i;
>>
>> @@ -1508,22 +1511,25 @@ static void htab_free_malloced_timers_and_wq(struct bpf_htab *htab)
>>                          if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
>>                                  bpf_obj_free_workqueue(htab->map.record,
>>                                                         htab_elem_value(l, htab->map.key_size));
>> +                       if (btf_record_has_field(htab->map.record, BPF_TASK_WORK))
>> +                               bpf_obj_free_task_work(htab->map.record,
>> +                                                      htab_elem_value(l, htab->map.key_size));
>>                  }
>>                  cond_resched_rcu();
>>          }
>>          rcu_read_unlock();
>>   }
>>
>> -static void htab_map_free_timers_and_wq(struct bpf_map *map)
>> +static void htab_map_free_internal_structs(struct bpf_map *map)
>>   {
>>          struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>
>>          /* We only free timer and workqueue on uref dropping to zero */
>> -       if (btf_record_has_field(htab->map.record, BPF_TIMER | BPF_WORKQUEUE)) {
>> +       if (btf_record_has_field(htab->map.record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
>>                  if (!htab_is_prealloc(htab))
>> -                       htab_free_malloced_timers_and_wq(htab);
>> +                       htab_free_malloced_internal_structs(htab);
>>                  else
>> -                       htab_free_prealloced_timers_and_wq(htab);
>> +                       htab_free_prealloced_internal_structs(htab);
>>          }
>>   }
>>
>> @@ -2255,7 +2261,7 @@ const struct bpf_map_ops htab_map_ops = {
>>          .map_alloc = htab_map_alloc,
>>          .map_free = htab_map_free,
>>          .map_get_next_key = htab_map_get_next_key,
>> -       .map_release_uref = htab_map_free_timers_and_wq,
>> +       .map_release_uref = htab_map_free_internal_structs,
>>          .map_lookup_elem = htab_map_lookup_elem,
>>          .map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
>>          .map_update_elem = htab_map_update_elem,
>> @@ -2276,7 +2282,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
>>          .map_alloc = htab_map_alloc,
>>          .map_free = htab_map_free,
>>          .map_get_next_key = htab_map_get_next_key,
>> -       .map_release_uref = htab_map_free_timers_and_wq,
>> +       .map_release_uref = htab_map_free_internal_structs,
>>          .map_lookup_elem = htab_lru_map_lookup_elem,
>>          .map_lookup_and_delete_elem = htab_lru_map_lookup_and_delete_elem,
>>          .map_lookup_elem_sys_only = htab_lru_map_lookup_elem_sys,
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 6b4877e85a68..322ffcaedc38 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3703,8 +3703,53 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
>>          return bpf_strnstr(s1__ign, s2__ign, XATTR_SIZE_MAX);
>>   }
>>
>> +typedef void (*bpf_task_work_callback_t)(struct bpf_map *, void *, void *);
>> +
>> +/**
>> + * bpf_task_work_schedule_signal - Schedule BPF callback using task_work_add with TWA_SIGNAL mode
>> + * @task: Task struct for which callback should be scheduled
>> + * @tw: Pointer to the bpf_task_work struct, to use by kernel internally for bookkeeping
>> + * @map__map: bpf_map which contains bpf_task_work in one of the values
>> + * @callback: pointer to BPF subprogram to call
>> + * @aux__prog: user should pass NULL
>> + *
>> + * Return: 0 if task work has been scheduled successfully, negative error code otherwise
>> + */
>> +__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task,
>> +                                             struct bpf_task_work *tw,
>> +                                             struct bpf_map *map__map,
>> +                                             bpf_task_work_callback_t callback,
>> +                                             void *aux__prog)
>> +{
>> +       return 0;
>> +}
>> +
>> +/**
>> + * bpf_task_work_schedule_resume - Schedule BPF callback using task_work_add with TWA_RESUME or
>> + * TWA_NMI_CURRENT mode if scheduling for the current task in the NMI
>> + * @task: Task struct for which callback should be scheduled
>> + * @tw: Pointer to the bpf_task_work struct, to use by kernel internally for bookkeeping
>> + * @map__map: bpf_map which contains bpf_task_work in one of the values
>> + * @callback: pointer to BPF subprogram to call
>> + * @aux__prog: user should pass NULL
>> + *
>> + * Return: 0 if task work has been scheduled successfully, negative error code otherwise
>> + */
>> +__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task,
>> +                                             struct bpf_task_work *tw,
>> +                                             struct bpf_map *map__map,
>> +                                             bpf_task_work_callback_t callback,
>> +                                             void *aux__prog)
>> +{
>> +       return 0;
>> +}
> Is there a reason we need separate kfuncs? Why can't we have one with
> flags for different TWA modes?
We are running into 5 arguments limit here.
>> +
>>   __bpf_kfunc_end_defs();
>>
>> +void bpf_task_work_cancel_and_free(void *val)
>> +{
>> +}
>> +
>>   BTF_KFUNCS_START(generic_btf_ids)
>>   #ifdef CONFIG_CRASH_DUMP
>>   BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index e63039817af3..73f801751280 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -670,6 +670,7 @@ void btf_record_free(struct btf_record *rec)
>>                  case BPF_TIMER:
>>                  case BPF_REFCOUNT:
>>                  case BPF_WORKQUEUE:
>> +               case BPF_TASK_WORK:
>>                          /* Nothing to release */
>>                          break;
>>                  default:
>> @@ -723,6 +724,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
>>                  case BPF_TIMER:
>>                  case BPF_REFCOUNT:
>>                  case BPF_WORKQUEUE:
>> +               case BPF_TASK_WORK:
>>                          /* Nothing to acquire */
>>                          break;
>>                  default:
>> @@ -781,6 +783,13 @@ void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj)
>>          bpf_wq_cancel_and_free(obj + rec->wq_off);
>>   }
>>
>> +void bpf_obj_free_task_work(const struct btf_record *rec, void *obj)
>> +{
>> +       if (WARN_ON_ONCE(!btf_record_has_field(rec, BPF_TASK_WORK)))
>> +               return;
>> +       bpf_task_work_cancel_and_free(obj + rec->task_work_off);
>> +}
>> +
>>   void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>>   {
>>          const struct btf_field *fields;
>> @@ -838,6 +847,9 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>>                                  continue;
>>                          bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);
>>                          break;
>> +               case BPF_TASK_WORK:
>> +                       bpf_task_work_cancel_and_free(field_ptr);
>> +                       break;
>>                  case BPF_LIST_NODE:
>>                  case BPF_RB_NODE:
>>                  case BPF_REFCOUNT:
>> @@ -1234,7 +1246,8 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>>
>>          map->record = btf_parse_fields(btf, value_type,
>>                                         BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
>> -                                      BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR,
>> +                                      BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR |
>> +                                      BPF_TASK_WORK,
>>                                         map->value_size);
>>          if (!IS_ERR_OR_NULL(map->record)) {
>>                  int i;
>> @@ -1306,6 +1319,14 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>>                                          goto free_map_tab;
>>                                  }
>>                                  break;
>> +                       case BPF_TASK_WORK:
>> +                               if (map->map_type != BPF_MAP_TYPE_HASH &&
>> +                                   map->map_type != BPF_MAP_TYPE_LRU_HASH &&
>> +                                   map->map_type != BPF_MAP_TYPE_ARRAY) {
>> +                                       ret = -EOPNOTSUPP;
>> +                                       goto free_map_tab;
>> +                               }
>> +                               break;
>>                          default:
>>                                  /* Fail if map_type checks are missing for a field type */
>>                                  ret = -EOPNOTSUPP;
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 399f03e62508..905dc0c5a73d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -524,9 +524,11 @@ static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
>>                 func_id == BPF_FUNC_user_ringbuf_drain;
>>   }
>>
>> -static bool is_async_callback_calling_function(enum bpf_func_id func_id)
>> +static bool is_task_work_add_kfunc(u32 func_id);
>> +
>> +static bool is_async_callback_calling_function(u32 func_id)
>>   {
>> -       return func_id == BPF_FUNC_timer_set_callback;
>> +       return func_id == BPF_FUNC_timer_set_callback || is_task_work_add_kfunc(func_id);
> Hmm, isn't this for helpers? You probably want to change
> is_async_callback_calling_kfunc.
Agreed.
>
>>   }
>>
>>   static bool is_callback_calling_function(enum bpf_func_id func_id)
>> @@ -2236,6 +2238,8 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
>>                                  reg->map_uid = reg->id;
>>                          if (btf_record_has_field(map->inner_map_meta->record, BPF_WORKQUEUE))
>>                                  reg->map_uid = reg->id;
>> +                       if (btf_record_has_field(map->inner_map_meta->record, BPF_TASK_WORK))
>> +                               reg->map_uid = reg->id;
>>                  } else if (map->map_type == BPF_MAP_TYPE_XSKMAP) {
>>                          reg->type = PTR_TO_XDP_SOCK;
>>                  } else if (map->map_type == BPF_MAP_TYPE_SOCKMAP ||
>> @@ -8569,6 +8573,44 @@ static int process_wq_func(struct bpf_verifier_env *env, int regno,
>>          return 0;
>>   }
>>
>> +static int process_task_work_func(struct bpf_verifier_env *env, int regno,
>> +                                 struct bpf_kfunc_call_arg_meta *meta)
>> +{
>> +       struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
>> +       struct bpf_map *map = reg->map_ptr;
>> +       bool is_const = tnum_is_const(reg->var_off);
>> +       u64 val = reg->var_off.value;
>> +
>> +       if (!map->btf) {
>> +               verbose(env, "map '%s' has to have BTF in order to use bpf_task_work\n",
>> +                       map->name);
>> +               return -EINVAL;
>> +       }
>> +       if (!btf_record_has_field(map->record, BPF_TASK_WORK)) {
>> +               verbose(env, "map '%s' has no valid bpf_task_work\n", map->name);
>> +               return -EINVAL;
>> +       }
>> +       if (map->record->task_work_off != val + reg->off) {
>> +               verbose(env,
>> +                       "off %lld doesn't point to 'struct bpf_task_work' that is at %d\n",
>> +                       val + reg->off, map->record->task_work_off);
>> +               return -EINVAL;
>> +       }
>> +       if (!is_const) {
>> +               verbose(env,
>> +                       "bpf_task_work has to be at the constant offset\n");
>> +               return -EINVAL;
>> +       }
> It would make more sense to me to check this before matching val + reg->off.
Makes sense.
Sorry for the delayed response, I was focused on another patch.

