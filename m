Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2FD249E4A
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgHSMmB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 08:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgHSMly (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 08:41:54 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D66C061383
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 05:41:53 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o23so26145559ejr.1
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 05:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/y3jRYjISN6SJ5xQ83KSW3ddpwc4GdyAtPJH5CRfRJ0=;
        b=MMwcAkNPoxSXmPkz0pR7sTwo66Xg5xE8uIJAgcgY7tIE1K+xayzXU/yLxzn1EmRPBz
         cqK+MOxm4aZbhj43T3YSsPW3XM1y4yq7glyAHROQ4b1KQRxmH1gLlBRq+rhvyuZrYS+x
         bdxpA7wELpjNG4SRngDWN43obystfj96snvms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/y3jRYjISN6SJ5xQ83KSW3ddpwc4GdyAtPJH5CRfRJ0=;
        b=QEaVlVei+ThSDrKgI9VSL77KKhjgR3F4y+BZJ6PTW8XewUhI11FQEvQc72APv6AjDc
         3uBGwVbMvQzEYTWUNT60XzsKSMZ+z3KVj2g4CZd/O/3nmOO98IsbYH0rOvSTyIx96aSP
         b31F5B5SA1KTfQllAud89CQ5AqIhIbSVuZUnYaIPDDDa6RCFBw1NVwP4Nx4JKhyTiZ9G
         oxsfhNA0n/4reBhLsaAFsTckq8hkCxu6E+sQd94foX+/zfqIJ5ZK3v04cTH01pjYf7iD
         hsPNoGd7FF6K3qJHyAy93jLLZFRmg84TONxkxPTqpVAou1V+tEjSHNlxo6S15AZSFjZs
         zb3A==
X-Gm-Message-State: AOAM532qZRWZpNfDuyYRTVXtjotp4j5TUbDKspYth3b3Co14+tAuP8df
        aVCCXh3FVjwb17iEqV7ZOtwGww==
X-Google-Smtp-Source: ABdhPJzARsZBOTQokn+pLPQqdAoHgnbmZAYTqgVRhFkyXjlQCLD8bRL5hnqaqrbxwy82mMtNYBxSig==
X-Received: by 2002:a17:906:86c9:: with SMTP id j9mr24478953ejy.5.1597840912462;
        Wed, 19 Aug 2020 05:41:52 -0700 (PDT)
Received: from [192.168.2.66] ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id t3sm17820566edq.26.2020.08.19.05.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 05:41:51 -0700 (PDT)
Subject: Re: [PATCH bpf-next v8 3/7] bpf: Generalize bpf_sk_storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
 <20200803164655.1924498-4-kpsingh@chromium.org>
 <20200818010545.iix72le4tkhuyqe5@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <6cb51fa0-61a5-2cf6-b44d-84d58d08c775@chromium.org>
Date:   Wed, 19 Aug 2020 14:41:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818010545.iix72le4tkhuyqe5@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/18/20 3:05 AM, Martin KaFai Lau wrote:
> On Mon, Aug 03, 2020 at 06:46:51PM +0200, KP Singh wrote:
>> From: KP Singh <kpsingh@google.com>
>>
>> Refactor the functionality in bpf_sk_storage.c so that concept of
>> storage linked to kernel objects can be extended to other objects like
>> inode, task_struct etc.
>>
>> Each new local storage will still be a separate map and provide its own
>> set of helpers. This allows for future object specific extensions and
>> still share a lot of the underlying implementation.
>>
>> This includes the changes suggested by Martin in:
>>
>>   https://lore.kernel.org/bpf/20200725013047.4006241-1-kafai@fb.com/
>>
>> which adds map_local_storage_charge, map_local_storage_uncharge,
>> and map_owner_storage_ptr.
> A description will still be useful in the commit message to talk
> about the new map_ops, e.g.
> they allow kernel object to optionally have different mem-charge strategy.
> 
>>
>> Co-developed-by: Martin KaFai Lau <kafai@fb.com>
>> Signed-off-by: KP Singh <kpsingh@google.com>
>> ---
>>  include/linux/bpf.h            |   9 ++
>>  include/net/bpf_sk_storage.h   |  51 +++++++
>>  include/uapi/linux/bpf.h       |   8 +-
>>  net/core/bpf_sk_storage.c      | 246 +++++++++++++++++++++------------
>>  tools/include/uapi/linux/bpf.h |   8 +-
>>  5 files changed, 233 insertions(+), 89 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index cef4ef0d2b4e..8e1e23c60dc7 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -34,6 +34,9 @@ struct btf_type;
>>  struct exception_table_entry;
>>  struct seq_operations;
>>  struct bpf_iter_aux_info;
>> +struct bpf_local_storage;
>> +struct bpf_local_storage_map;
>> +struct bpf_local_storage_elem;
> "struct bpf_local_storage_elem" is not needed.

True, I moved it to bpf_sk_storage.h because it's needed there.

> 
>>  
>>  extern struct idr btf_idr;
>>  extern spinlock_t btf_idr_lock;
>> @@ -104,6 +107,12 @@ struct bpf_map_ops {
>>  	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
>>  			     struct poll_table_struct *pts);
>>  
>> +	/* Functions called by bpf_local_storage maps */
>> +	int (*map_local_storage_charge)(struct bpf_local_storage_map *smap,
>> +					void *owner, u32 size);
>> +	void (*map_local_storage_uncharge)(struct bpf_local_storage_map *smap,
>> +					   void *owner, u32 size);
>> +	struct bpf_local_storage __rcu ** (*map_owner_storage_ptr)(void *owner);


[...]

>> +			struct bpf_local_storage_map *smap,
>> +			struct bpf_local_storage_elem *first_selem);
>> +
>> +struct bpf_local_storage_data *
>> +bpf_local_storage_update(void *owner, struct bpf_map *map, void *value,
> Nit.  It may be more consistent to take "struct bpf_local_storage_map *smap"
> instead of "struct bpf_map *map" here.
> 
> bpf_local_storage_map_check_btf() will be the only one taking
> "struct bpf_map *map".

That's because it is used in map operations as map_check_btf which expects
a bpf_map *map pointer. We can wrap it in another function but is that
worth doing? 

> 
>> +			 u64 map_flags);
>> +
>>  #ifdef CONFIG_BPF_SYSCALL
>>  int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk);
>>  struct bpf_sk_storage_diag *
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index b134e679e9db..35629752cec8 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -3647,9 +3647,13 @@ enum {
>>  	BPF_F_SYSCTL_BASE_NAME		= (1ULL << 0),
>>  };
>>  
>> -/* BPF_FUNC_sk_storage_get flags */
>> +/* BPF_FUNC_<local>_storage_get flags */
> BPF_FUNC_<kernel_obj>_storage_get flags?
> 

Done.

>>  enum {
>> -	BPF_SK_STORAGE_GET_F_CREATE	= (1ULL << 0),
>> +	BPF_LOCAL_STORAGE_GET_F_CREATE	= (1ULL << 0),
>> +	/* BPF_SK_STORAGE_GET_F_CREATE is only kept for backward compatibility
>> +	 * and BPF_LOCAL_STORAGE_GET_F_CREATE must be used instead.
>> +	 */
>> +	BPF_SK_STORAGE_GET_F_CREATE  = BPF_LOCAL_STORAGE_GET_F_CREATE,
>>  };
>>  
>>  /* BPF_FUNC_read_branch_records flags. */
>> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
>> index 99dde7b74767..bb2375769ca1 100644
>> --- a/net/core/bpf_sk_storage.c
>> +++ b/net/core/bpf_sk_storage.c
>> @@ -84,7 +84,7 @@ struct bpf_local_storage_elem {
>>  struct bpf_local_storage {
>>  	struct bpf_local_storage_data __rcu *cache[BPF_LOCAL_STORAGE_CACHE_SIZE];
>>  	struct hlist_head list; /* List of bpf_local_storage_elem */
>> -	struct sock *owner;	/* The object that owns the the above "list" of

[...]

>>  }
>>  
>> -/* sk_storage->lock must be held and selem->sk_storage == sk_storage.
>> +/* local_storage->lock must be held and selem->sk_storage == sk_storage.
> This name change belongs to patch 1.
> 
> Also,
> selem->"local_"storage == "local_"storage

Done.

> 
>>   * The caller must ensure selem->smap is still valid to be
>>   * dereferenced for its smap->elem_size and smap->cache_idx.
>>   */
> 
> [ ... ]
> 
>> @@ -367,7 +401,7 @@ static int sk_storage_alloc(struct sock *sk,
>>  		/* Note that even first_selem was linked to smap's
>>  		 * bucket->list, first_selem can be freed immediately
>>  		 * (instead of kfree_rcu) because
>> -		 * bpf_sk_storage_map_free() does a
>> +		 * bpf_local_storage_map_free() does a


[...]

>>  			kfree(selem);
>> -			atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
>> +			mem_uncharge(smap, owner, smap->elem_size);
>>  			return ERR_PTR(err);
>>  		}
>>  
>> @@ -430,8 +464,8 @@ bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
>>  		 * such that it can avoid taking the local_storage->lock
>>  		 * and changing the lists.
>>  		 */
>> -		old_sdata =
>> -			bpf_local_storage_lookup(local_storage, smap, false);
>> +		old_sdata = bpf_local_storage_lookup(local_storage, smap,
>> +						     false);
> Pure indentation change.  The same line has been changed in patch 1.  Please change
> the identation in patch 1 if the above way is preferred.

I removed this change. 

> 
>>  		err = check_flags(old_sdata, map_flags);
>>  		if (err)
>>  			return ERR_PTR(err);
>> @@ -475,7 +509,7 @@ bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
>>  	 * old_sdata will not be uncharged later during
>>  	 * bpf_selem_unlink_storage().
>>  	 */
>> -	selem = bpf_selem_alloc(smap, sk, value, !old_sdata);
>> +	selem = bpf_selem_alloc(smap, owner, value, !old_sdata);
>>  	if (!selem) {
>>  		err = -ENOMEM;
>>  		goto unlock_err;
>> @@ -567,7 +601,7 @@ void bpf_sk_storage_free(struct sock *sk)
>>  	 * Thus, no elem can be added-to or deleted-from the
>>  	 * sk_storage->list by the bpf_prog or by the bpf-map's syscall.
>>  	 *
>> -	 * It is racing with bpf_sk_storage_map_free() alone
>> +	 * It is racing with bpf_local_storage_map_free() alone
> This name change belongs to patch 1 also.

Done.

> 
>>  	 * when unlinking elem from the sk_storage->list and
>>  	 * the map's bucket->list.
>>  	 */
>> @@ -587,17 +621,12 @@ void bpf_sk_storage_free(struct sock *sk)
>>  		kfree_rcu(sk_storage, rcu);
>>  }
>>  
>> -static void bpf_local_storage_map_free(struct bpf_map *map)

[..]

>>  
>>  	/* bpf prog and the userspace can no longer access this map
>>  	 * now.  No new selem (of this map) can be added
>> -	 * to the sk->sk_bpf_storage or to the map bucket's list.
>> +	 * to the bpf_local_storage or to the map bucket's list.
> s/bpf_local_storage/owner->storage/

Done.

> 
>>  	 *
>>  	 * The elem of this map can be cleaned up here
>>  	 * or
>> -	 * by bpf_sk_storage_free() during __sk_destruct().
>> +	 * by bpf_local_storage_free() during the destruction of the
>> +	 * owner object. eg. __sk_destruct.
> This belongs to patch 1 also.


In patch, 1, changed it to:

	 * The elem of this map can be cleaned up here
	 * or when the storage is freed e.g.
	 * by bpf_sk_storage_free() during __sk_destruct().

> 
>>  	 */
>>  	for (i = 0; i < (1U << smap->bucket_log); i++) {
>>  		b = &smap->buckets[i];
>> @@ -627,22 +657,31 @@ static void bpf_local_storage_map_free(struct bpf_map *map)
>>  		rcu_read_unlock();
>>  	}
>>  
>> -	/* bpf_sk_storage_free() may still need to access the map.
>> -	 * e.g. bpf_sk_storage_free() has unlinked selem from the map
>> +	/* bpf_local_storage_free() may still need to access the map.
> It is confusing.  There is no bpf_local_storage_free().

	/* While freeing the storage we may still need to access the map.
	 *
	 * e.g. when bpf_sk_storage_free() has unlinked selem from the map
	 * which then made the above while((selem = ...)) loop
	 * exited immediately.

> 
>> +	 * e.g. bpf_local_storage_free() has unlinked selem from the map
>>  	 * which then made the above while((selem = ...)) loop
>>  	 * exited immediately.
>>  	 *
>> -	 * However, the bpf_sk_storage_free() still needs to access
>> +	 * However, the bpf_local_storage_free() still needs to access
> Same here.

With the change above, this can stay bpf_sk_storage_free

> 
>>  	 * the smap->elem_size to do the uncharging in
>>  	 * bpf_selem_unlink_storage().
>>  	 *
>>  	 * Hence, wait another rcu grace period for the
>> -	 * bpf_sk_storage_free() to finish.
>> +	 * bpf_local_storage_free() to finish.
> and here.

and this too can stay bpf_sk_storage_free

> 
>>  	 */
>>  	synchronize_rcu();
>>  
>>  	kvfree(smap->buckets);
>> -	kfree(map);
>> +	kfree(smap);
>> +}
>> +
>> +static void sk_storage_map_free(struct bpf_map *map)
>> +{

[...]

_attr *attr)
>>  		raw_spin_lock_init(&smap->buckets[i].lock);
>>  	}
>>  
>> -	smap->elem_size = sizeof(struct bpf_local_storage_elem) + attr->value_size;
>> -	smap->cache_idx = bpf_local_storage_cache_idx_get(&sk_cache);
>> +	smap->elem_size =
>> +		sizeof(struct bpf_local_storage_elem) + attr->value_size;
> Same line has changed in patch 1.   Change the indentation in patch 1 also
> if the above way is desired.

Done.

> Others LGTM.
> 
