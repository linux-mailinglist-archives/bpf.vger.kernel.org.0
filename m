Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A53622FA06
	for <lists+bpf@lfdr.de>; Mon, 27 Jul 2020 22:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgG0U2X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jul 2020 16:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgG0U2X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jul 2020 16:28:23 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C4DC0619D2
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 13:28:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 184so16011553wmb.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fRlx83gIL4bWYNB6kR5rrjfnxf0E6xTaNozKcd8Z7ZA=;
        b=FpcVj+m2e/aBHNueAo02mBo8+S8nwrjfh6Fi7Gr4rMV6kkOUspBv5JmBEZJU4IFyJr
         KmingvsPMA2uaiOzD3LNKaP8SMFaoiIoP97vkjXv44Uu0LxDSLlOIZ7XY663d6Dtzv/q
         vsanvdym2nvmfXeNc8BQXsNlfU9Qn++dAbHaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fRlx83gIL4bWYNB6kR5rrjfnxf0E6xTaNozKcd8Z7ZA=;
        b=X6O3Ay0OLQLriX4dMdym+W8jrqQFkB/wKoufwzuFWu6b0hCzXZzdns0ZmpuCmZo2da
         4tm+VYC0ZB2ZEV1BvcSz5UyZhw9V0g3eOruTJ08UxJvSowvLPwUlnqGH8mlHKgRDH5Ww
         fWQn/rkq9LaE4A8uIoCTMOIEB9KijaS94/Fgjxx5XQpf13XdwIqG0qcylASQObOvAAhS
         Wh1YVXQhf4k/0xEfO95rL5lnuLzDzzdgKfHk2WOMhcViRa8VLGWIL0ThFe+iqSwc4Ogq
         wtabK6cXKturEF/QaWXtHwdp2kgOO+9e2qo+lrrJ7gB9LPhfFDP2vFrdf1PjdmmbfOrq
         40vQ==
X-Gm-Message-State: AOAM531DZ8XN+G83u6mUozRPU8Ntuoppp7pieHB3aMmYuC8iU92ADyee
        nxNLJhOv5ka38ZGcq41zWt+h3g==
X-Google-Smtp-Source: ABdhPJwnxw9+qS+jvyymvqBVIeENV90Qd/NvV4LrayhF0s91ojVbDucVdejgCYqE5jDVbAaJYvtoqA==
X-Received: by 2002:a1c:678b:: with SMTP id b133mr886310wmc.117.1595881701814;
        Mon, 27 Jul 2020 13:28:21 -0700 (PDT)
Received: from kpsingh-macbookpro2.roam.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id u66sm900737wmu.37.2020.07.27.13.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 13:28:21 -0700 (PDT)
Subject: Re: [PATCH bpf-next v6 3/7] bpf: Generalize bpf_sk_storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200723115032.460770-1-kpsingh@chromium.org>
 <20200723115032.460770-4-kpsingh@chromium.org>
 <20200725011329.ymvhmbb2y5yqzy3k@kafai-mbp>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <a75f9231-b347-cec1-e7af-7bbed4ad2f00@chromium.org>
Date:   Mon, 27 Jul 2020 22:28:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200725011329.ymvhmbb2y5yqzy3k@kafai-mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 25.07.20 03:13, Martin KaFai Lau wrote:
> On Thu, Jul 23, 2020 at 01:50:28PM +0200, KP Singh wrote:
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
> 
> [ ... ]
> 
>> @@ -386,54 +407,28 @@ static int sk_storage_alloc(struct sock *sk,
>>   * Otherwise, it will become a leak (and other memory issues
>>   * during map destruction).
>>   */
>> -static struct bpf_local_storage_data *
>> -bpf_local_storage_update(struct sock *sk, struct bpf_map *map, void *value,
>> +struct bpf_local_storage_data *
>> +bpf_local_storage_update(void *owner, struct bpf_map *map,
>> +			 struct bpf_local_storage *local_storage, void *value,
>>  			 u64 map_flags)
>>  {
>>  	struct bpf_local_storage_data *old_sdata = NULL;
>>  	struct bpf_local_storage_elem *selem;
>> -	struct bpf_local_storage *local_storage;
>>  	struct bpf_local_storage_map *smap;
>>  	int err;
>>  
>> -	/* BPF_EXIST and BPF_NOEXIST cannot be both set */
>> -	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST) ||
>> -	    /* BPF_F_LOCK can only be used in a value with spin_lock */
>> -	    unlikely((map_flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
>> -		return ERR_PTR(-EINVAL);
>> -
>>  	smap = (struct bpf_local_storage_map *)map;
>> -	local_storage = rcu_dereference(sk->sk_bpf_storage);
>> -	if (!local_storage || hlist_empty(&local_storage->list)) {
>> -		/* Very first elem for this object */
>> -		err = check_flags(NULL, map_flags);
> This check_flags here is missing in the later sk_storage_update().
> 
>> -		if (err)
>> -			return ERR_PTR(err);
>> -
>> -		selem = bpf_selem_alloc(smap, sk, value, true);
>> -		if (!selem)
>> -			return ERR_PTR(-ENOMEM);
>> -
>> -		err = sk_storage_alloc(sk, smap, selem);
>> -		if (err) {
>> -			kfree(selem);
>> -			atomic_sub(smap->elem_size, &sk->sk_omem_alloc);
>> -			return ERR_PTR(err);
>> -		}
>> -
>> -		return SDATA(selem);
>> -	}
>>  
>>  	if ((map_flags & BPF_F_LOCK) && !(map_flags & BPF_NOEXIST)) {
>>  		/* Hoping to find an old_sdata to do inline update
>>  		 * such that it can avoid taking the local_storage->lock
>>  		 * and changing the lists.
>>  		 */
>> -		old_sdata =
>> -			bpf_local_storage_lookup(local_storage, smap, false);
>> +		old_sdata = bpf_local_storage_lookup(local_storage, smap, false);
>>  		err = check_flags(old_sdata, map_flags);
>>  		if (err)
>>  			return ERR_PTR(err);
>> +
>>  		if (old_sdata && selem_linked_to_storage(SELEM(old_sdata))) {
>>  			copy_map_value_locked(map, old_sdata->data,
>>  					      value, false);
> 
> [ ... ]
> 
>> +static struct bpf_local_storage_data *
>> +sk_storage_update(void *owner, struct bpf_map *map, void *value, u64 map_flags)
>> +{
>> +	struct bpf_local_storage_data *old_sdata = NULL;
>> +	struct bpf_local_storage_elem *selem;
>> +	struct bpf_local_storage *local_storage;
>> +	struct bpf_local_storage_map *smap;
>> +	struct sock *sk;
>> +	int err;
>> +
>> +	err = bpf_local_storage_check_update_flags(map, map_flags);
>> +	if (err)
>> +		return ERR_PTR(err);
>> +
>> +	sk = owner;
>> +	local_storage = rcu_dereference(sk->sk_bpf_storage);
>> +	smap = (struct bpf_local_storage_map *)map;
>> +
>> +	if (!local_storage || hlist_empty(&local_storage->list)) {
> 
> "check_flags(NULL, map_flags);" is gone in this refactoring.
> 
> This part of code is copied into the inode_storage_update()
> in the latter patch which then has the same issue.
> 
>> +		/* Very first elem */
>> +		selem = map->ops->map_selem_alloc(smap, owner, value, !old_sdata);
>> +		if (!selem)
>> +			return ERR_PTR(-ENOMEM);
> 
>>  static int sk_storage_map_btf_id;
>>  const struct bpf_map_ops sk_storage_map_ops = {
>> -	.map_alloc_check = bpf_sk_storage_map_alloc_check,
>> -	.map_alloc = bpf_local_storage_map_alloc,
>> -	.map_free = bpf_local_storage_map_free,
>> +	.map_alloc_check = bpf_local_storage_map_alloc_check,
>> +	.map_alloc = sk_storage_map_alloc,
>> +	.map_free = sk_storage_map_free,
>>  	.map_get_next_key = notsupp_get_next_key,
>>  	.map_lookup_elem = bpf_fd_sk_storage_lookup_elem,
>>  	.map_update_elem = bpf_fd_sk_storage_update_elem,
>>  	.map_delete_elem = bpf_fd_sk_storage_delete_elem,
>> -	.map_check_btf = bpf_sk_storage_map_check_btf,
>> +	.map_check_btf = bpf_local_storage_map_check_btf,
>>  	.map_btf_name = "bpf_local_storage_map",
>>  	.map_btf_id = &sk_storage_map_btf_id,
>> +	.map_selem_alloc = sk_selem_alloc,
>> +	.map_local_storage_update = sk_storage_update,
>> +	.map_local_storage_unlink = unlink_sk_storage,
> I think refactoring codes as map_selem_alloc, map_local_storage_update,
> and map_local_storage_unlink is not the best option.  The sk and inode
> version of the above map_ops are mostly the same.  Fixing the
> issue like the one mentioned above need to fix both sk, inode, and
> the future kernel-object code.
> 
> The only difference is sk charge omem and inode does not.
> I have played around a little.  I think adding the following three ops (pasted at
> the end) is better and should be enough for both sk and inode.  The inode
> does not even have to implement the (un)charge ops at all.
> 
> That should remove the duplication for the followings:
> - (sk|inode)_selem_alloc
> - (sk|inode)_storage_update
> - unlink_(sk|inode)_storage
> - (sk|inode)_storage_alloc
> 
> Another bonus is the new bpf_local_storage_check_update_flags() and
> bpf_local_storage_publish() will be no longer needed too.

I really like this approach. Thank you so much!

> 
> I have hacked up this patch 3 change to compiler-test out this idea.
> I will post in another email.  Let me know wdy> 
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -33,6 +33,9 @@ struct btf;
>  struct btf_type;
>  struct exception_table_entry;
>  struct seq_operations;
> +struct bpf_local_storage;
> +struct bpf_local_storage_map;
> +struct bpf_local_storage_elem;
>  
>  extern struct idr btf_idr;
>  extern spinlock_t btf_idr_lock;
> @@ -93,6 +96,13 @@ struct bpf_map_ops {
>  	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
>  			     struct poll_table_struct *pts);
>  
> +	/* Functions called by bpf_local_storage maps */
> +	int (*map_local_storage_charge)(struct bpf_local_storage_map *smap,
> +					void *owner, u32 size);
> +	void (*map_local_storage_uncharge)(struct bpf_local_storage_map *smap,
> +					   void *owner, u32 size);
> +	struct bpf_local_storage __rcu ** (*map_owner_storage_ptr)(struct bpf_local_storage_map *smap,
> +								   void *owner);
>  	/* BTF name and id of struct allocated by map_alloc */
>  	const char * const map_btf_name;
>  	int *map_btf_id;
> 
