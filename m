Return-Path: <bpf+bounces-67385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F398B42FC8
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 04:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB6A563A94
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 02:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D561C5F10;
	Thu,  4 Sep 2025 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xhpcoy9a"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219521DE2D7
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 02:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953244; cv=none; b=lVF3PL9Sm4kbTXulaNdB9DJ153JICE1Jz3gIrIzM21fbNT6nzgqvmbZkPG5jznHHFtQU3y2cNW3RMFft5ItDeYw6ddxaTbrX16l16e5kue+HtBg+OqOQotWiBFCcxsV8+6abtfG26xmcEyKHki6Bu61yko/sQeMQ74IVJDg6I1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953244; c=relaxed/simple;
	bh=1zBt2rQAN+Niiez5Zz3RTB+dhCCpTfP+TZnUMT/cYSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYX2U/GbQqvuYhi6Ew8UeggxHbXFKLLiN609+vgKLLjn50N5H7KwPtr6dxz5TVpuRd30scDStIq14ZAIFje9YWkwK9fwAJ9Q2GLjKicTSucORcts6ponUlDSZmU/y7uY+aXMGBofNw3nx9/l1MYQYvhmCek3H6Yp+PP3A6hbkQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xhpcoy9a; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dfe41b0d-c73a-433b-99fe-db05dbe1c0f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756953239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GrrzK7URfYVDvwGMvTjuKo66Qu1KuFZeiLQPI0RNuE=;
	b=xhpcoy9aRcvMZs4USYLfGByUGT8l/vEEdNF2cWf/Zs8z3IUMYFTqzAV+oixxOOYA5rMXNb
	uGSlarQDg28H6c25gX0m+E3hgDXvAnkyk9XceNoWl7e3Gj30YOFWzUK3lFiGNsXCF/YhkN
	W9fMZzoiwbF86PgU7ZR6TmYKdHLyh0c=
Date: Thu, 4 Sep 2025 10:33:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Generalize data copying for percpu maps
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 kernel-patches-bot@fb.com
References: <20250903170411.69188-1-leon.hwang@linux.dev>
 <CAADnVQL-Zj95bfOxkxc2tf9CKvUSCt4PKdoQMZtqaiirzPLxvw@mail.gmail.com>
 <CAEf4BzYmX9RfOwArEAa+XW+uVzqUUy-5gjenog+ZvDjxGa80SQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYmX9RfOwArEAa+XW+uVzqUUy-5gjenog+ZvDjxGa80SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/9/25 07:39, Andrii Nakryiko wrote:
> On Wed, Sep 3, 2025 at 10:36 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Wed, Sep 3, 2025 at 10:04 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>
>>> While adding support for the BPF_F_CPU and BPF_F_ALL_CPUS flags, the data
>>> copying logic of the following percpu map types needs to be updated:
>>>
>>> * percpu_array
>>> * percpu_hash
>>> * lru_percpu_hash
>>> * percpu_cgroup_storage
>>>
>>> Following Andrii’s suggestion[0], this patch refactors the data copying
> 
> as flattering as that is, "Andrii's suggestion" is no justification
> why the patch is correct :)
> 

:)

>>> logic by introducing two helpers:
>>>
>>> * `bpf_percpu_copy_to_user()`
>>> * `bpf_percpu_copy_from_user()`
>>>
>>> This prepares the codebase for the upcoming CPU flag support.
>>>
>>> [0] https://lore.kernel.org/bpf/20250827164509.7401-1-leon.hwang@linux.dev/
>>>
>>> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>> ---
>>>  include/linux/bpf.h        | 29 ++++++++++++++++++++++++++++-
>>>  kernel/bpf/arraymap.c      | 14 ++------------
>>>  kernel/bpf/hashtab.c       | 20 +++-----------------
>>>  kernel/bpf/local_storage.c | 18 ++++++------------
>>>  4 files changed, 39 insertions(+), 42 deletions(-)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index 8f6e87f0f3a89..2dc0299a2da50 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -547,6 +547,34 @@ static inline void copy_map_value_long(struct bpf_map *map, void *dst, void *src
>>>         bpf_obj_memcpy(map->record, dst, src, map->value_size, true);
>>>  }
>>>
>>> +#ifdef CONFIG_BPF_SYSCALL
>>> +static inline void bpf_percpu_copy_to_user(struct bpf_map *map, void __percpu *pptr, void *value,
>>> +                                          u32 size)
>>> +{
>>> +       int cpu, off = 0;
>>> +
>>> +       for_each_possible_cpu(cpu) {
>>> +               copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
>>> +               check_and_init_map_value(map, value + off);
> 
> I still maintain that this makes zero sense... value+off is memory
> that we'll copy_to_user, why are we setting refcount to 1, or
> rb_node/list_node to "proper empty node" is absolutely not clear... it
> feels like we can drop check_and_init_map_value() altogether and be
> absolutely no worse. If anything, memset(0) would be nicer, but I
> guess we didn't have it to begin with, so no need to add it now.
> 

Agreed.

As 'copy_map_value_long()' won't copy those fields,
'check_and_init_map_value()' is unnecessary here.

>>> +               off += size;
>>> +       }
>>> +}
>>> +
>>> +void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
>>> +
>>> +static inline void bpf_percpu_copy_from_user(struct bpf_map *map, void __percpu *pptr, void *value,
>>> +                                            u32 size)
>>> +{
>>> +       int cpu, off = 0;
>>> +
>>> +       for_each_possible_cpu(cpu) {
>>> +               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
> 
> copy_map_value_long is generalization of bpf_long_memcpy, and so it
> would be good to call this out to explain why your refactoring is
> correct
> 

No.

It shouldn't call bpf_long_memcpy() before bpf_obj_free_fields(), or it
will overwrite those fields data used for bpf_obj_free_fields().

It would be better to call bpf_obj_free_fields() then bpf_long_memcpy().

>>> +               bpf_obj_free_fields(map->record, per_cpu_ptr(pptr, cpu));
>>> +               off += size;
>>> +       }
>>> +}
>>> +#endif
>>> +
>>>  static inline void bpf_obj_swap_uptrs(const struct btf_record *rec, void *dst, void *src)
>>>  {
>>>         unsigned long *src_uptr, *dst_uptr;
>>> @@ -2417,7 +2445,6 @@ struct btf_record *btf_record_dup(const struct btf_record *rec);
>>>  bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *rec_b);
>>>  void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
>>>  void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj);
>>> -void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
>>>  void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
>>>
>>>  struct bpf_map *bpf_map_get(u32 ufd);
>>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>>> index 3d080916faf97..6be9c54604503 100644
>>> --- a/kernel/bpf/arraymap.c
>>> +++ b/kernel/bpf/arraymap.c
>>> @@ -300,7 +300,6 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
>>>         struct bpf_array *array = container_of(map, struct bpf_array, map);
>>>         u32 index = *(u32 *)key;
>>>         void __percpu *pptr;
>>> -       int cpu, off = 0;
>>>         u32 size;
>>>
>>>         if (unlikely(index >= array->map.max_entries))
>>> @@ -313,11 +312,7 @@ int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value)
>>>         size = array->elem_size;
>>>         rcu_read_lock();
>>>         pptr = array->pptrs[index & array->index_mask];
>>> -       for_each_possible_cpu(cpu) {
>>> -               copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
>>> -               check_and_init_map_value(map, value + off);
>>> -               off += size;
>>> -       }
>>> +       bpf_percpu_copy_to_user(map, pptr, value, size);
>>>         rcu_read_unlock();
>>>         return 0;
>>>  }
>>> @@ -387,7 +382,6 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>>>         struct bpf_array *array = container_of(map, struct bpf_array, map);
>>>         u32 index = *(u32 *)key;
>>>         void __percpu *pptr;
>>> -       int cpu, off = 0;
>>>         u32 size;
>>>
>>>         if (unlikely(map_flags > BPF_EXIST))
>>> @@ -411,11 +405,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>>>         size = array->elem_size;
>>>         rcu_read_lock();
>>>         pptr = array->pptrs[index & array->index_mask];
>>> -       for_each_possible_cpu(cpu) {
>>> -               copy_map_value_long(map, per_cpu_ptr(pptr, cpu), value + off);
>>> -               bpf_obj_free_fields(array->map.record, per_cpu_ptr(pptr, cpu));
>>> -               off += size;
>>> -       }
>>> +       bpf_percpu_copy_from_user(map, pptr, value, size);
>>>         rcu_read_unlock();
>>>         return 0;
>>>  }
>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>> index 71f9931ac64cd..5f0f3c00dbb74 100644
>>> --- a/kernel/bpf/hashtab.c
>>> +++ b/kernel/bpf/hashtab.c
>>> @@ -944,12 +944,8 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
>>>                 copy_map_value(&htab->map, this_cpu_ptr(pptr), value);
>>>         } else {
>>>                 u32 size = round_up(htab->map.value_size, 8);
>>> -               int off = 0, cpu;
>>>
>>> -               for_each_possible_cpu(cpu) {
>>> -                       copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value + off);
>>> -                       off += size;
>>> -               }
>>> +               bpf_percpu_copy_from_user(&htab->map, pptr, value, size);
>>
>> This is not a refactor. There is a significant change in the logic.
>> Why is it needed? Bug fix or introducing a bug?
> 
> this is preparation for that BPF_F_CPU/BPF_F_ALLCPUS, but I agree that
> it would be better to include as preparatory patch in the actual patch
> set
> 

Ack.

I'll move this patch into the patch set of BPF_F_CPU/BPF_F_ALLCPUS flags.

>>
>> The names to_user and from_user are wrong.
>> There is no user space memory involved.
> 
> This was my suggestion because we either are copying user-supplied
> data or copying data back to user. Strictly speaking it's all kernel
> memory (copy_from_user/copy_to_user is done afterwards by the caller),
> but that's the intent.
> 
> Maybe "copy_in" and "copy_out" would be better, I don't know. But
> there is certainly a direction here w.r.t. user space provided data
> (note, this is not BPF program-side logic).
> 

'bpf_percpu_copy_data()' and 'bpf_percpu_update_data()' would be better,
as "copy_data" is used in those 'bpf_percpu_*_copy()' functions and
"update_data" is used in those 'bpf_percpu_*_update()' functions.

Thanks,
Leon


