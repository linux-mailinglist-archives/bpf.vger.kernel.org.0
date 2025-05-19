Return-Path: <bpf+bounces-58497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9176DABC824
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 22:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E987A7677
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 20:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218462116F2;
	Mon, 19 May 2025 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2bqHuqL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DAB4B1E73;
	Mon, 19 May 2025 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747685043; cv=none; b=iI7fgRcxPV+8/+Ov0hM2Ha417DEKN8JCRiO3SUux5dXDe1K8F2Sk/9NIvnWIgCYckBndFvKI37t/Er3jZ2z4oVl6GiWyEZyqHeqmTOyzdpGZsGvUx4GEmrJ5LRziA4XZYeyoe5XcdbhnvWlH9moNpDEuxRQgRRFFvzkyjfXRwpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747685043; c=relaxed/simple;
	bh=VCSVeyv1BHfGUOW4mmEvbxzSMKRqWVY5VWJRcpA4WU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecRV3wvBn4Lr9SE1MZiUAhNA3NstC/X5CdnATrnc5gccuO2sfBRZstiMzo4I2gxK4dx5crYmL8/JqMO3trAXiSUhMOzW/KuSTmbHbLo8HQ/Tpq2pmGuxqblDQzJCv10lzdRr5i6jVMyOoo1AxNvjNn8zOv5WDLLvZQc4kF97h6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2bqHuqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D399EC4CEE4;
	Mon, 19 May 2025 20:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747685043;
	bh=VCSVeyv1BHfGUOW4mmEvbxzSMKRqWVY5VWJRcpA4WU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2bqHuqLNEwCIpGC/fd899BInnypiko6V+U2TPFMb7oCB9J/Bij6dFowxkAT+KyCg
	 +QhK8FtKFee1oACXYvxMybPA3xGtDJLuouWPEGLsoOsFuTOEtt4yWF2IHvKm0dKFQR
	 E+R8kxoOG6mU0jo+sbSpyMwuWpIshmN6ouU3F4Q3iWg2BinkrLNHLDevuyZw4ukxrM
	 E/AsNc38zNLSwRxNomZbiStv5xEv0MnIHUDJEad6seBX4sG7lg5VtOKRXv+ZpFidrL
	 uqm2ZYCcbA1zJYREZPqpB6ljg5neDeCBj4fMg7bR9n2Ja/TbVk2jqjpM04Lr99RZ5f
	 hdqTclxElTcqg==
Date: Mon, 19 May 2025 10:04:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com, andrii@kernel.org,
	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: Introduce task local data
Message-ID: <aCuOsXKCkwa8zkwR@slm.duckdns.org>
References: <20250515211606.2697271-1-ameryhung@gmail.com>
 <20250515211606.2697271-2-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515211606.2697271-2-ameryhung@gmail.com>

Hello,

On Thu, May 15, 2025 at 02:16:00PM -0700, Amery Hung wrote:
...
> +#define PAGE_SIZE 4096

This might conflict with other definitions. Looks like non-4k page sizes are
a lot more popular on arm. Would this be a problem?

> +static int __tld_init_metadata(int map_fd)
> +{
> +	struct u_tld_metadata *new_metadata;
> +	struct tld_map_value map_val;
> +	int task_fd = 0, err;
> +
> +	task_fd = syscall(SYS_pidfd_open, getpid(), 0);
> +	if (task_fd < 0) {
> +		err = -errno;
> +		goto out;
> +	}
> +
> +	new_metadata = aligned_alloc(PAGE_SIZE, PAGE_SIZE);

Is 4k size limit from UPTR? Is it still 4k on machines with >4k pages? If
this isn't a hard limit from UPTR, would it make sense to encode the size in
the header part of the metadata?

> +static int __tld_init_data(int map_fd)
> +{
> +	struct u_tld_data *new_data = NULL;
> +	struct tld_map_value map_val;
> +	int err, task_fd = 0;
> +
> +	task_fd = syscall(SYS_pidfd_open, gettid(), PIDFD_THREAD);
> +	if (task_fd < 0) {
> +		err = -errno;
> +		goto out;
> +	}
> +
> +	new_data = aligned_alloc(PAGE_SIZE, TLD_DATA_SIZE);

Ditto.

Noob question. Does this means that each thread will map a 4k page no matter
how much data it actually uses?

> +__attribute__((unused))
> +static tld_key_t tld_create_key(int map_fd, const char *name, size_t size)
> +{
> +	int err, i, cnt, sz, off = 0;
> +
> +	if (!READ_ONCE(tld_metadata_p)) {
> +		err = __tld_init_metadata(map_fd);
> +		if (err)
> +			return (tld_key_t) {.off = err};
> +	}
> +
> +	if (!tld_data_p) {
> +		err = __tld_init_data(map_fd);
> +		if (err)
> +			return (tld_key_t) {.off = err};
> +	}
> +
> +	size = round_up(size, 8);
> +
> +	for (i = 0; i < TLD_DATA_CNT; i++) {
> +retry:
> +		cnt = __atomic_load_n(&tld_metadata_p->cnt, __ATOMIC_RELAXED);
> +		if (i < cnt) {
> +			/*
> +			 * Pending tld_create_key() uses size to signal if the metadata has
> +			 * been fully updated.
> +			 */
> +			while (!(sz = __atomic_load_n(&tld_metadata_p->metadata[i].size,
> +						      __ATOMIC_ACQUIRE)))
> +				sched_yield();
> +
> +			if (!strncmp(tld_metadata_p->metadata[i].name, name, TLD_NAME_LEN))
> +				return (tld_key_t) {.off = -EEXIST};
> +
> +			off += sz;
> +			continue;
> +		}
> +
> +		if (off + size > TLD_DATA_SIZE)
> +			return (tld_key_t) {.off = -E2BIG};
> +
> +		/*
> +		 * Only one tld_create_key() can increase the current cnt by one and
> +		 * takes the latest available slot. Other threads will check again if a new
> +		 * TLD can still be added, and then compete for the new slot after the
> +		 * succeeding thread update the size.
> +		 */
> +		if (!__atomic_compare_exchange_n(&tld_metadata_p->cnt, &cnt, cnt + 1, true,
> +						 __ATOMIC_RELAXED, __ATOMIC_RELAXED))
> +			goto retry;
> +
> +		strncpy(tld_metadata_p->metadata[i].name, name, TLD_NAME_LEN);
> +		__atomic_store_n(&tld_metadata_p->metadata[i].size, size, __ATOMIC_RELEASE);
> +		return (tld_key_t) {.off = off};
> +	}
> +
> +	return (tld_key_t) {.off = -ENOSPC};
> +}

This looks fine to me but I wonder whether run-length encoding the key
strings would be more efficient and less restrictive in terms of key length.
e.g.:

struct key {
        u32 data_len;
        u16 key_off;
        u16 key_len;
};

struct metadata {
        struct key      keys[MAX_KEYS];
        char            key_strs[SOME_SIZE];
};

The logic can be mostly the same. The only difference would be that key
string is not inline. Determine winner in the creation path by compxchg'ing
on data_len, but set key_off and key_len only after key string is updated.
Losing on cmpxhcg or seeing an entry where key_len is zero means that that
one lost and should relax and retry. It can still use the same 4k metadata
page but will likely be able to allow more keys while also relaxing
restrictions on key length.

Hmm... maybe making the key string variably sized makes things difficult for
the BPF code. If so (or for any other reasons), please feel free to ignore
the above.

> +#endif /* __TASK_LOCAL_DATA_H */
> diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
> new file mode 100644
> index 000000000000..5f48e408a5e5
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
...
> +/**
> + * tld_get_data() - Retrieves a pointer to the TLD associated with the key.
> + *
> + * @tld_obj: A pointer to a valid tld_object initialized by tld_object_init()
> + * @key: The key of a TLD saved in tld_maps
> + * @size: The size of the TLD. Must be a known constant value
> + *
> + * Returns a pointer to the TLD data associated with the key; NULL if the key
> + * is not valid or the size is too big
> + */
> +#define tld_get_data(tld_obj, key, size) \
> +	__tld_get_data(tld_obj, (tld_obj)->key_map->key.off - 1, size)
> +
> +__attribute__((unused))
> +__always_inline void *__tld_get_data(struct tld_object *tld_obj, u32 off, u32 size)
> +{
> +	return (tld_obj->data_map->data && off >= 0 && off < TLD_DATA_SIZE - size) ?
> +		(void *)tld_obj->data_map->data + off : NULL;
> +}

Neat.

Generally looks great to me. The only thing I wonder is whether the data
area sizing can be determined at init time rather than fixed to 4k.

Thanks.

-- 
tejun

