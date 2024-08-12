Return-Path: <bpf+bounces-36900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E256894F243
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1170C1C21198
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 16:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440BA183CBF;
	Mon, 12 Aug 2024 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvsNeBwM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24261494B8
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478439; cv=none; b=miR7cN6rMU2TM3lZ8O5XJQFgebhkJ2FI2fjkZPHdWqnYpOIlgpx8B8e9GOrYuu5iXtBLWdfK5+fllTcc77NMg8mmjf/+HL7d0tpthLeAyBzlJgg97OLD8mvzzMb1sQ8lbCY1h6w8U+nLuCXNV/u2k0UDfFKYFj8Znoe+W6l8pqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478439; c=relaxed/simple;
	bh=FOwm0heXCI1ZBQIACQIW28lQMbD9CKBo9edOq9gcA0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XunV34vD36Egb+5jaB+TyyEAUBC1EyFCmnYjmINlx8y8p8GtbvigMU8E2k0lD/m7MuqlmbSUzWWsxZFBoVSIdVDeTZ+60zQydop+6oG9G0PtBp4YmElTmFfpff3kN+ln7R8a9WKXgNkEEPE6FQEjtuLvSRriCRxuvlxgj5F1dQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvsNeBwM; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-66acac24443so44550377b3.1
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723478437; x=1724083237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lD/wflMowJD3Iq7tVy4u4pSGQ7jLaKhQPcD4PILD9IU=;
        b=KvsNeBwM4UI8hFE1FYiO9/LWukFEbbqUtIgqX+xoORnahcRWEbO9rsPU0QBVnpQWMC
         QVMYsF4vv/P+bPo2U9LzpnqFoMOVeEDz0ytgCdDdGl4zF5eZqm88KAS9/gF1RApm9WME
         NrEV03Th91aofmeWG0rs4crVkCKbkciW/iE4kjm3mEziU4YJcrM+uDmoXyAG8OTZipUc
         URBtPPE5/CmzCm2ULssZR/R3ApU7FWH3OKjN4M/iuC/NGC+0A2hcuDT+CncUCNwPUjIQ
         FX+yzwc9f3xe+lfUPDItxGDEync3twX24nWxb9ud1b4hpEw7Qqs9bLIzpL3FFa5EzuxL
         u32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723478437; x=1724083237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lD/wflMowJD3Iq7tVy4u4pSGQ7jLaKhQPcD4PILD9IU=;
        b=Rq0iCs4xIOmcMM9vL17v16b8bbr1JB5eIVDp/Qp/9xVSTWcc6P7X1UKzfOjomYRIsa
         p7pdSYr6+kbdwPuuS0/qjySO5+BsrTR9Ow2BvnYDFbDMUPYOoRFCPDKfuGJrobKr6Czd
         Fw4P2NQVaWD8piVmW4r9fWuOSzftnyOeeRcNl6hGvKU0fWZH162wxHEm0hDK5IedpVel
         gJc4HTZDxKckTI4p2EkJpTbFJxpYpWWSZZfHL0fUJGUzLj28ieLjfNZBDYt743+yf6vI
         goisNy6xmLyQTESKNWhqwzKBpXEJyE4RdwxZPKjfyywD7R3PEuzk3s+csI1St8D7/40G
         tiLw==
X-Forwarded-Encrypted: i=1; AJvYcCWEI+IzpI4/PgqkAxgnVQ3mc8ZvppgnmsEydY4ebK/EjxAttspR19Ao6U3dn0n3CvMBG6o68wcjRwFxnewq7wVGqOWP
X-Gm-Message-State: AOJu0YwcZbm06oHwDQNf1nP98DhLKhG++zVEtdsPB+wo2OEYhYfeF/19
	4rp/etJbS9vaWMwUi+10RfwJ3rEH7oQItlGXudCT+qGBnyZd3o/C
X-Google-Smtp-Source: AGHT+IE9JDvQ4Sslb80/B0lefpA60xSEiehQtDcibzdlBnrDOJBy3OQR4NrScIyCHy60PsNPZuCsFw==
X-Received: by 2002:a05:690c:7243:b0:668:7e84:b53e with SMTP id 00721157ae682-6a9756d8aefmr10837247b3.30.1723478436146;
        Mon, 12 Aug 2024 09:00:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:9b6c:23b8:ec8:40fd? ([2600:1700:6cf8:1240:9b6c:23b8:ec8:40fd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a068cc16sm9164257b3.41.2024.08.12.09.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 09:00:35 -0700 (PDT)
Message-ID: <b82c74dd-9475-4080-a7aa-ad33c4be5dcf@gmail.com>
Date: Mon, 12 Aug 2024 09:00:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 3/5] bpf: pin, translate, and unpin __kptr_user
 from syscalls.
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com, linux-mm@kvack.org
References: <20240807235755.1435806-1-thinker.li@gmail.com>
 <20240807235755.1435806-4-thinker.li@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240807235755.1435806-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/7/24 16:57, Kui-Feng Lee wrote:
> User kptrs are pinned, by pin_user_pages_fast(), and translated to an
> address in the kernel when the value is updated by user programs. (Call
> bpf_map_update_elem() from user programs.) And, the pinned pages are
> unpinned if the value of user kptrs are overritten or if the values of maps
> are deleted/destroyed.
> 
> The pages are mapped through vmap() in order to get a continuous space in
> the kernel if the memory pointed by a user kptr resides in two or more
> pages. For the case of single page, page_address() is called to get the
> address of a page in the kernel.
> 
> User kptr is only supported by task storage maps.
> 
> One user kptr can pin at most KPTR_USER_MAX_PAGES(16) physical pages. This
> is a random picked number for safety. We actually can remove this
> restriction totally.
> 
> User kptrs could only be set by user programs through syscalls.  Any
> attempts of updating the value of a map with __kptr_user in it should
> ignore the values of user kptrs from BPF programs. The values of user kptrs
> will keep as they were if the new values are from BPF programs, not from
> user programs.
> 
> Cc: linux-mm@kvack.org
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>   include/linux/bpf.h               |  35 +++++-
>   include/linux/bpf_local_storage.h |   2 +-
>   kernel/bpf/bpf_local_storage.c    |  18 +--
>   kernel/bpf/helpers.c              |  12 +-
>   kernel/bpf/local_storage.c        |   2 +-
>   kernel/bpf/syscall.c              | 177 +++++++++++++++++++++++++++++-
>   net/core/bpf_sk_storage.c         |   2 +-
>   7 files changed, 227 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 87d5f98249e2..f4ad0bc183cb 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -30,6 +30,7 @@
>   #include <linux/static_call.h>
>   #include <linux/memcontrol.h>
>   #include <linux/cfi.h>
> +#include <linux/mm.h>
>   
>   struct bpf_verifier_env;
>   struct bpf_verifier_log;
> @@ -477,10 +478,12 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
>   		data_race(*ldst++ = *lsrc++);
>   }
>   
> +void bpf_obj_unpin_uaddr(const struct btf_field *field, void *addr);
> +
>   /* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could be one of each. */
>   static inline void bpf_obj_memcpy(struct btf_record *rec,
>   				  void *dst, void *src, u32 size,
> -				  bool long_memcpy)
> +				  bool long_memcpy, bool from_user)
>   {
>   	u32 curr_off = 0;
>   	int i;
> @@ -496,21 +499,40 @@ static inline void bpf_obj_memcpy(struct btf_record *rec,
>   	for (i = 0; i < rec->cnt; i++) {
>   		u32 next_off = rec->fields[i].offset;
>   		u32 sz = next_off - curr_off;
> +		void *addr;
>   
>   		memcpy(dst + curr_off, src + curr_off, sz);
> +		if (from_user && rec->fields[i].type == BPF_KPTR_USER) {
> +			/* Unpin old address.
> +			 *
> +			 * Alignments are guaranteed by btf_find_field_one().
> +			 */
> +			addr = *(void **)(dst + next_off);
> +			if (virt_addr_valid(addr))
> +				bpf_obj_unpin_uaddr(&rec->fields[i], addr);
> +			else if (addr)
> +				WARN_ON_ONCE(1);
> +
> +			*(void **)(dst + next_off) = *(void **)(src + next_off);
> +		}
>   		curr_off += rec->fields[i].size + sz;
>   	}
>   	memcpy(dst + curr_off, src + curr_off, size - curr_off);
>   }
>   
> +static inline void copy_map_value_user(struct bpf_map *map, void *dst, void *src, bool from_user)
> +{
> +	bpf_obj_memcpy(map->record, dst, src, map->value_size, false, from_user);
> +}
> +
>   static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
>   {
> -	bpf_obj_memcpy(map->record, dst, src, map->value_size, false);
> +	bpf_obj_memcpy(map->record, dst, src, map->value_size, false, false);
>   }
>   
>   static inline void copy_map_value_long(struct bpf_map *map, void *dst, void *src)
>   {
> -	bpf_obj_memcpy(map->record, dst, src, map->value_size, true);
> +	bpf_obj_memcpy(map->record, dst, src, map->value_size, true, false);
>   }
>   
>   static inline void bpf_obj_memzero(struct btf_record *rec, void *dst, u32 size)
> @@ -538,6 +560,8 @@ static inline void zero_map_value(struct bpf_map *map, void *dst)
>   	bpf_obj_memzero(map->record, dst, map->value_size);
>   }
>   
> +void copy_map_value_locked_user(struct bpf_map *map, void *dst, void *src,
> +				bool lock_src, bool from_user);
>   void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
>   			   bool lock_src);
>   void bpf_timer_cancel_and_free(void *timer);
> @@ -775,6 +799,11 @@ enum bpf_arg_type {
>   };
>   static_assert(__BPF_ARG_TYPE_MAX <= BPF_BASE_TYPE_LIMIT);
>   
> +#define BPF_MAP_UPDATE_FLAG_BITS 3
> +enum bpf_map_update_flag {
> +	BPF_FROM_USER = BIT(0 + BPF_MAP_UPDATE_FLAG_BITS)
> +};
> +
>   /* type of values returned from helper functions */
>   enum bpf_return_type {
>   	RET_INTEGER,			/* function returns integer */
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index dcddb0aef7d8..d337df68fa23 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -181,7 +181,7 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
>   
>   struct bpf_local_storage_elem *
>   bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
> -		bool charge_mem, gfp_t gfp_flags);
> +		bool charge_mem, gfp_t gfp_flags, bool from_user);
>   
>   void bpf_selem_free(struct bpf_local_storage_elem *selem,
>   		    struct bpf_local_storage_map *smap,
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index c938dea5ddbf..c4cf09e27a19 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -73,7 +73,7 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
>   
>   struct bpf_local_storage_elem *
>   bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
> -		void *value, bool charge_mem, gfp_t gfp_flags)
> +		void *value, bool charge_mem, gfp_t gfp_flags, bool from_user)
>   {
>   	struct bpf_local_storage_elem *selem;
>   
> @@ -100,7 +100,7 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
>   
>   	if (selem) {
>   		if (value)
> -			copy_map_value(&smap->map, SDATA(selem)->data, value);
> +			copy_map_value_user(&smap->map, SDATA(selem)->data, value, from_user);
>   		/* No need to call check_and_init_map_value as memory is zero init */
>   		return selem;
>   	}
> @@ -530,9 +530,11 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>   	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
>   	struct bpf_local_storage *local_storage;
>   	unsigned long flags;
> +	bool from_user = map_flags & BPF_FROM_USER;
>   	int err;
>   
>   	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
> +	map_flags &= ~BPF_FROM_USER;
>   	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
>   	    /* BPF_F_LOCK can only be used in a value with spin_lock */
>   	    unlikely((map_flags & BPF_F_LOCK) &&
> @@ -550,7 +552,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>   		if (err)
>   			return ERR_PTR(err);
>   
> -		selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags);
> +		selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags, from_user);
>   		if (!selem)
>   			return ERR_PTR(-ENOMEM);
>   
> @@ -575,8 +577,8 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>   		if (err)
>   			return ERR_PTR(err);
>   		if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
> -			copy_map_value_locked(&smap->map, old_sdata->data,
> -					      value, false);
> +			copy_map_value_locked_user(&smap->map, old_sdata->data,
> +						   value, false, from_user);
>   			return old_sdata;
>   		}
>   	}
> @@ -584,7 +586,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>   	/* A lookup has just been done before and concluded a new selem is
>   	 * needed. The chance of an unnecessary alloc is unlikely.
>   	 */
> -	alloc_selem = selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags);
> +	alloc_selem = selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags, from_user);
>   	if (!alloc_selem)
>   		return ERR_PTR(-ENOMEM);
>   
> @@ -607,8 +609,8 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
>   		goto unlock;
>   
>   	if (old_sdata && (map_flags & BPF_F_LOCK)) {
> -		copy_map_value_locked(&smap->map, old_sdata->data, value,
> -				      false);
> +		copy_map_value_locked_user(&smap->map, old_sdata->data, value,
> +					   false, from_user);
>   		selem = SELEM(old_sdata);
>   		goto unlock;
>   	}
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index d02ae323996b..4aef86209fdd 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -372,8 +372,8 @@ const struct bpf_func_proto bpf_spin_unlock_proto = {
>   	.arg1_btf_id    = BPF_PTR_POISON,
>   };
>   
> -void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
> -			   bool lock_src)
> +void copy_map_value_locked_user(struct bpf_map *map, void *dst, void *src,
> +				bool lock_src, bool from_user)
>   {
>   	struct bpf_spin_lock *lock;
>   
> @@ -383,11 +383,17 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
>   		lock = dst + map->record->spin_lock_off;
>   	preempt_disable();
>   	__bpf_spin_lock_irqsave(lock);
> -	copy_map_value(map, dst, src);
> +	copy_map_value_user(map, dst, src, from_user);
>   	__bpf_spin_unlock_irqrestore(lock);
>   	preempt_enable();
>   }
>   
> +void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
> +			   bool lock_src)
> +{
> +	copy_map_value_locked_user(map, dst, src, lock_src, false);
> +}
> +
>   BPF_CALL_0(bpf_jiffies64)
>   {
>   	return get_jiffies_64();
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 3969eb0382af..62a12fa8ce9e 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -147,7 +147,7 @@ static long cgroup_storage_update_elem(struct bpf_map *map, void *key,
>   	struct bpf_cgroup_storage *storage;
>   	struct bpf_storage_buffer *new;
>   
> -	if (unlikely(flags & ~(BPF_F_LOCK | BPF_EXIST)))
> +	if (unlikely(flags & ~BPF_F_LOCK))
>   		return -EINVAL;
>   
>   	if (unlikely((flags & BPF_F_LOCK) &&
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 90a25307480e..eaa2a9d13265 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -155,8 +155,134 @@ static void maybe_wait_bpf_programs(struct bpf_map *map)
>   		synchronize_rcu();
>   }
>   
> -static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
> -				void *key, void *value, __u64 flags)
> +static void *trans_addr_pages(struct page **pages, int npages)
> +{
> +	if (npages == 1)
> +		return page_address(pages[0]);
> +	/* For multiple pages, we need to use vmap() to get a contiguous
> +	 * virtual address range.
> +	 */
> +	return vmap(pages, npages, VM_MAP, PAGE_KERNEL);
> +}
> +
> +#define KPTR_USER_MAX_PAGES 16
> +
> +static int bpf_obj_trans_pin_uaddr(struct btf_field *field, void **addr)
> +{
> +	const struct btf_type *t;
> +	struct page *pages[KPTR_USER_MAX_PAGES];
> +	void *ptr, *kern_addr;
> +	u32 type_id, tsz;
> +	int r, npages;
> +
> +	ptr = *addr;
> +	type_id = field->kptr.btf_id;
> +	t = btf_type_id_size(field->kptr.btf, &type_id, &tsz);
> +	if (!t)
> +		return -EINVAL;
> +	if (tsz == 0) {
> +		*addr = NULL;
> +		return 0;
> +	}
> +
> +	npages = (((intptr_t)ptr + tsz + ~PAGE_MASK) -
> +		  ((intptr_t)ptr & PAGE_MASK)) >> PAGE_SHIFT;
> +	if (npages > KPTR_USER_MAX_PAGES)
> +		return -E2BIG;
> +	r = pin_user_pages_fast((intptr_t)ptr & PAGE_MASK, npages, 0, pages);
> +	if (r != npages)
> +		return -EINVAL;
> +	kern_addr = trans_addr_pages(pages, npages);
> +	if (!kern_addr)
> +		return -ENOMEM;
> +	*addr = kern_addr + ((intptr_t)ptr & ~PAGE_MASK);
> +	return 0;
> +}
> +
> +void bpf_obj_unpin_uaddr(const struct btf_field *field, void *addr)
> +{
> +	struct page *pages[KPTR_USER_MAX_PAGES];
> +	int npages, i;
> +	u32 size, type_id;
> +	void *ptr;
> +
> +	type_id = field->kptr.btf_id;
> +	btf_type_id_size(field->kptr.btf, &type_id, &size);
> +	if (size == 0)
> +		return;
> +
> +	ptr = (void *)((intptr_t)addr & PAGE_MASK);
> +	npages = (((intptr_t)addr + size + ~PAGE_MASK) - (intptr_t)ptr) >> PAGE_SHIFT;
> +	for (i = 0; i < npages; i++) {
> +		pages[i] = virt_to_page(ptr);
> +		ptr += PAGE_SIZE;
> +	}
> +	if (npages > 1)
> +		/* Paired with vmap() in trans_addr_pages() */
> +		vunmap((void *)((intptr_t)addr & PAGE_MASK));

Just realize that vunmap() should not be called in a non-sleepable
context. I would add an async variant of vunmap() to defer unmapping to
a workqueue.

> +	unpin_user_pages(pages, npages);
> +}
> +
> +static int bpf_obj_trans_pin_uaddrs(struct btf_record *rec, void *src, u32 size)
> +{
> +	u32 next_off;
> +	int i, err;
> +
> +	if (IS_ERR_OR_NULL(rec))
> +		return 0;
> +
> +	if (!btf_record_has_field(rec, BPF_KPTR_USER))
> +		return 0;
> +
> +	for (i = 0; i < rec->cnt; i++) {
> +		if (rec->fields[i].type != BPF_KPTR_USER)
> +			continue;
> +
> +		next_off = rec->fields[i].offset;
> +		if (next_off + sizeof(void *) > size)
> +			return -EINVAL;
> +		err = bpf_obj_trans_pin_uaddr(&rec->fields[i], src + next_off);
> +		if (!err)
> +			continue;
> +
> +		/* Rollback */
> +		for (i--; i >= 0; i--) {
> +			if (rec->fields[i].type != BPF_KPTR_USER)
> +				continue;
> +			next_off = rec->fields[i].offset;
> +			bpf_obj_unpin_uaddr(&rec->fields[i], *(void **)(src + next_off));
> +			*(void **)(src + next_off) = NULL;
> +		}
> +
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void bpf_obj_unpin_uaddrs(struct btf_record *rec, void *src)
> +{
> +	u32 next_off;
> +	int i;
> +
> +	if (IS_ERR_OR_NULL(rec))
> +		return;
> +
> +	if (!btf_record_has_field(rec, BPF_KPTR_USER))
> +		return;
> +
> +	for (i = 0; i < rec->cnt; i++) {
> +		if (rec->fields[i].type != BPF_KPTR_USER)
> +			continue;
> +
> +		next_off = rec->fields[i].offset;
> +		bpf_obj_unpin_uaddr(&rec->fields[i], *(void **)(src + next_off));
> +		*(void **)(src + next_off) = NULL;
> +	}
> +}
> +
> +static int bpf_map_update_value_inner(struct bpf_map *map, struct file *map_file,
> +				      void *key, void *value, __u64 flags)
>   {
>   	int err;
>   
> @@ -208,6 +334,29 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
>   	return err;
>   }
>   
> +static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
> +				void *key, void *value, __u64 flags)
> +{
> +	int err;
> +
> +	if (flags & BPF_FROM_USER) {
> +		/* Pin user memory can lead to context switch, so we need
> +		 * to do it before potential RCU lock.
> +		 */
> +		err = bpf_obj_trans_pin_uaddrs(map->record, value,
> +					       bpf_map_value_size(map));
> +		if (err)
> +			return err;
> +	}
> +
> +	err = bpf_map_update_value_inner(map, map_file, key, value, flags);
> +
> +	if (err && (flags & BPF_FROM_USER))
> +		bpf_obj_unpin_uaddrs(map->record, value);
> +
> +	return err;
> +}
> +
>   static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
>   			      __u64 flags)
>   {
> @@ -714,6 +863,11 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>   				field->kptr.dtor(xchgd_field);
>   			}
>   			break;
> +		case BPF_KPTR_USER:
> +			if (virt_addr_valid(*(void **)field_ptr))
> +				bpf_obj_unpin_uaddr(field, *(void **)field_ptr);
> +			*(void **)field_ptr = NULL;
> +			break;
>   		case BPF_LIST_HEAD:
>   			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
>   				continue;
> @@ -1155,6 +1309,12 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
>   					goto free_map_tab;
>   				}
>   				break;
> +			case BPF_KPTR_USER:
> +				if (map->map_type != BPF_MAP_TYPE_TASK_STORAGE) {
> +					ret = -EOPNOTSUPP;
> +					goto free_map_tab;
> +				}
> +				break;
>   			case BPF_LIST_HEAD:
>   			case BPF_RB_ROOT:
>   				if (map->map_type != BPF_MAP_TYPE_HASH &&
> @@ -1618,11 +1778,15 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
>   	struct bpf_map *map;
>   	void *key, *value;
>   	u32 value_size;
> +	u64 extra_flags = 0;
>   	struct fd f;
>   	int err;
>   
>   	if (CHECK_ATTR(BPF_MAP_UPDATE_ELEM))
>   		return -EINVAL;
> +	/* Prevent userspace from setting any internal flags */
> +	if (attr->flags & ~(BIT(BPF_MAP_UPDATE_FLAG_BITS) - 1))
> +		return -EINVAL;
>   
>   	f = fdget(ufd);
>   	map = __bpf_map_get(f);
> @@ -1653,7 +1817,9 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
>   		goto free_key;
>   	}
>   
> -	err = bpf_map_update_value(map, f.file, key, value, attr->flags);
> +	if (map->map_type == BPF_MAP_TYPE_TASK_STORAGE)
> +		extra_flags |= BPF_FROM_USER;
> +	err = bpf_map_update_value(map, f.file, key, value, attr->flags | extra_flags);
>   	if (!err)
>   		maybe_wait_bpf_programs(map);
>   
> @@ -1852,6 +2018,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>   	void __user *keys = u64_to_user_ptr(attr->batch.keys);
>   	u32 value_size, cp, max_count;
>   	void *key, *value;
> +	u64 extra_flags = 0;
>   	int err = 0;
>   
>   	if (attr->batch.elem_flags & ~BPF_F_LOCK)
> @@ -1881,6 +2048,8 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>   		return -ENOMEM;
>   	}
>   
> +	if (map->map_type == BPF_MAP_TYPE_TASK_STORAGE)
> +		extra_flags |= BPF_FROM_USER;
>   	for (cp = 0; cp < max_count; cp++) {
>   		err = -EFAULT;
>   		if (copy_from_user(key, keys + cp * map->key_size,
> @@ -1889,7 +2058,7 @@ int generic_map_update_batch(struct bpf_map *map, struct file *map_file,
>   			break;
>   
>   		err = bpf_map_update_value(map, map_file, key, value,
> -					   attr->batch.elem_flags);
> +					   attr->batch.elem_flags | extra_flags);
>   
>   		if (err)
>   			break;
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index bc01b3aa6b0f..db5281384e6a 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -137,7 +137,7 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
>   {
>   	struct bpf_local_storage_elem *copy_selem;
>   
> -	copy_selem = bpf_selem_alloc(smap, newsk, NULL, true, GFP_ATOMIC);
> +	copy_selem = bpf_selem_alloc(smap, newsk, NULL, true, GFP_ATOMIC, false);
>   	if (!copy_selem)
>   		return NULL;
>   

