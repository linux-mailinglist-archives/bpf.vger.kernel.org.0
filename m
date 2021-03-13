Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CF2339D1E
	for <lists+bpf@lfdr.de>; Sat, 13 Mar 2021 09:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhCMIy3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 13 Mar 2021 03:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhCMIyB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 13 Mar 2021 03:54:01 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FAEC061574
        for <bpf@vger.kernel.org>; Sat, 13 Mar 2021 00:53:59 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j3so11291595edp.11
        for <bpf@vger.kernel.org>; Sat, 13 Mar 2021 00:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ibdRAv6EtjDTFwtMN7emcgatOGX4SdwjveYs0AyR+Hk=;
        b=e43ipuJrQgcTFI10or2ar5Ot2IFQuBml80gE3l8IwrQRGyHVq6mUExlMqENlRIe3wE
         ZxqMNgZYogGk16oMO7g8DVDzALsemgCLHYfTMWjQ2/k0fpnUN/QKIoYUsMuJUJX8kLpq
         YnoNP2W5OD143lpSRRhR6hbUOrkiC9ooStv83e4HTcPDqOIe2MaZeA/cfIBWdPKUbmJD
         Icbifz0oHpHrzaeHCyzQKaUZNX54PhweIWOm46Jd0OJ+YyQporghPXqAkFH2CXTHtKVE
         YaYONSdNDmUmhEBuQCjfBkdqkw8JqIHcPqTpZTcm2Ray6CGC2py32wbXmiybkrNo53wI
         f6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ibdRAv6EtjDTFwtMN7emcgatOGX4SdwjveYs0AyR+Hk=;
        b=j43jpgruL3Lw+eisScR4jAwutacFF0NnnkYK+KcUJ/LyOfeAY9za21Ak+vCnaGyoN4
         se7QkZhRoDyEzjpBvEUbVe37xZxgMySVLS6q01IeP/p/tpm43bYKe5ewKK2hPjtfBnAp
         ELkT5lxexOnyheF+dnqhNXkp4yuOCkxahkpLk7KJIc87pCJIVgiDrERhEQe6h7Urvfss
         bdft0T0Wth8bALQHASCOwkUKXves2DoRdrpZxL4EyzEUi2jYwvbJ+lnsin1ZsQ+FfKiw
         a6J2VGz8hxbpPYhG88ky1TO3xCiW0TLKzhE9jaaOr+XFGu17hYCRXSDslopKawUG0MoB
         g8Ew==
X-Gm-Message-State: AOAM532XKPm04K+m5wwl/XhiH8l6xVdIvzt8NcwuLUxcEarBWNbyZDbN
        yG1N/p3pmly58/sbbDnxXX8oPQ==
X-Google-Smtp-Source: ABdhPJwKm2q4gO98vgQ0fuAqtOqfzVbJFD/tH3uzHeeX/oFw3FAxAmmvN/LmbouAq7cYj8znEszOuw==
X-Received: by 2002:a05:6402:1a3c:: with SMTP id be28mr18993646edb.125.1615625637956;
        Sat, 13 Mar 2021 00:53:57 -0800 (PST)
Received: from gmail.com (93-136-4-143.adsl.net.t-com.hr. [93.136.4.143])
        by smtp.gmail.com with ESMTPSA id br13sm3833573ejb.87.2021.03.13.00.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 00:53:57 -0800 (PST)
Date:   Sat, 13 Mar 2021 09:54:01 +0100
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, juraj.vijtiuk@sartura.hr,
        luka.oreskovic@sartura.hr, luka.perkov@sartura.hr
Subject: Re: [PATCH v2 bpf-next] bpf: add lookup_and_delete_elem support to
 hashtab
Message-ID: <YEx9qYVBWWdH0LPM@gmail.com>
References: <YDtk/vr/lk62L4KP@gmail.com>
 <d8104f41-4302-7b68-5bc1-fb014a261e42@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8104f41-4302-7b68-5bc1-fb014a261e42@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

Thank you for your feedback and comments.

On Mon, Mar 01, 2021 at 06:02:37PM -0800, Yonghong Song wrote:
> 
> 
> On 2/28/21 1:40 AM, Denis Salopek wrote:
> > Extend the existing bpf_map_lookup_and_delete_elem() functionality to
> > hashtab maps, in addition to stacks and queues.
> > Create a new hashtab bpf_map_ops function that does lookup and deletion
> > of the element under the same bucket lock and add the created map_ops to
> > bpf.h.
> > Add the appropriate test cases to 'maps' and 'lru_map' selftests
> > accompanied with new test_progs.
> > 
> > Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> > Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
> > ---
> > v2: Add functionality for LRU/per-CPU, add test_progs tests.
> > ---
> >   include/linux/bpf.h                           |   2 +
> >   kernel/bpf/hashtab.c                          |  80 +++++
> >   kernel/bpf/syscall.c                          |  14 +-
> >   .../bpf/prog_tests/lookup_and_delete.c        | 283 ++++++++++++++++++
> >   .../bpf/progs/test_lookup_and_delete.c        |  26 ++
> >   tools/testing/selftests/bpf/test_lru_map.c    |   8 +
> >   tools/testing/selftests/bpf/test_maps.c       |  19 +-
> >   7 files changed, 430 insertions(+), 2 deletions(-)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 4c730863fa77..0bcc4f89af40 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -67,6 +67,8 @@ struct bpf_map_ops {
> >   	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
> >   	int (*map_lookup_batch)(struct bpf_map *map, const union bpf_attr *attr,
> >   				union bpf_attr __user *uattr);
> > +	int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key,
> > +					  void *value);
> >   	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
> >   					   const union bpf_attr *attr,
> >   					   union bpf_attr __user *uattr);
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 330d721dd2af..8c3334d1b6b3 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -1401,6 +1401,82 @@ static void htab_map_seq_show_elem(struct bpf_map *map, void *key,
> >   	rcu_read_unlock();
> >   }
> >   
> > +static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
> > +					     void *value, bool is_lru_map,
> > +					     bool is_percpu)
> > +{
> > +	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> > +	u32 hash, key_size, value_size;
> > +	struct hlist_nulls_head *head;
> > +	int cpu, off = 0, ret;
> > +	struct htab_elem *l;
> > +	unsigned long flags;
> > +	void __percpu *pptr;
> > +	struct bucket *b;
> > +
> > +	key_size = map->key_size;
> > +	value_size = round_up(map->value_size, 8);
> > +
> > +	hash = htab_map_hash(key, key_size, htab->hashrnd);
> > +	b = __select_bucket(htab, hash);
> > +	head = &b->head;
> > +
> > +	ret = htab_lock_bucket(htab, b, hash, &flags);
> > +	if (ret)
> > +		return ret;
> > +
> > +	l = lookup_elem_raw(head, hash, key, key_size);
> > +	if (l) {
> > +		if (is_percpu) {
> > +			pptr = htab_elem_get_ptr(l, key_size);
> > +			for_each_possible_cpu(cpu) {
> > +				bpf_long_memcpy(value + off,
> > +						per_cpu_ptr(pptr, cpu),
> > +						value_size);
> > +				off += value_size;
> > +			}
> > +		} else {
> > +			copy_map_value(map, value, l->key + round_up(key_size, 8));
> 
> For hashtab lookup elem, BPF_F_LOCK flag may be set by user, I think 
> hashtab lookup_and_delete_elem should also support this flag, so user
> can ensure they always get a lock protected sane value.
> 
> We have the following libbpf APIs.
> 
> LIBBPF_API int bpf_map_lookup_elem(int fd, const void *key, void *value);
> LIBBPF_API int bpf_map_lookup_elem_flags(int fd, const void *key, void 
> *value,
>                                           __u64 flags);
> LIBBPF_API int bpf_map_lookup_and_delete_elem(int fd, const void *key,
>                                                void *value);
> 
> Previously, bpf_map_lookup_and_delete_elem only supports queue/stack,
> which does not need flags as it does not support BPF_F_LOCK so we
> are fine.
> 
> Maybe similar to bpf_map_lookup_elem_flags() we add a
> bpf_map_lookup_and_delete_elem_flags()? Maybe libbpf v1.0
> can consolidate into a better uniform api.
> 

If I understood correctly, there shouldn't be much changes for this
addition:
- add LIBBPF_API prototype and function in bpf.[hc] - those are
  practically the same as bpf_map_lookup_elem_flags() but we call
  BPF_LOOKUP_AND_DELETE_ELEM syscall,
- add global declaration for bpf_map_lookup_elem_flags() in libbpf.map,
- make the necessary checks for flags and the lock in the functions,
- call copy_map_value_locked() if BPF_F_LOCK is set,
- mask lock with check_and_init_map_lock().

Is this right or is there anything else I've missed?

> > +		}
> > +
> > +		hlist_nulls_del_rcu(&l->hash_node);
> > +		if (!is_lru_map)
> > +			free_htab_elem(htab, l);
> > +	} else
> > +		ret = -ENOENT;
> > +
> > +	htab_unlock_bucket(htab, b, hash, flags);
> > +
> > +	if (is_lru_map && l)
> > +		bpf_lru_push_free(&htab->lru, &l->lru_node);
> > +
> > +	return ret;
> > +}
> > +
> > +static int htab_map_lookup_and_delete_elem(struct bpf_map *map,
> > +					   void *key, void *value)
> > +{
> > +	return __htab_map_lookup_and_delete_elem(map, key, value, false, false);
> > +}
> > +
> > +static int htab_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
> > +						  void *key, void *value)
> > +{
> > +	return __htab_map_lookup_and_delete_elem(map, key, value, false, true);
> > +}
> > +
> > +static int htab_lru_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
> > +					       void *value)
> > +{
> > +	return __htab_map_lookup_and_delete_elem(map, key, value, true, false);
> > +}
> > +
> > +static int htab_lru_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
> > +						      void *key, void *value)
> > +{
> > +	return __htab_map_lookup_and_delete_elem(map, key, value, true, true);
> > +}
> > +
> >   static int
> >   __htab_map_lookup_and_delete_batch(struct bpf_map *map,
> >   				   const union bpf_attr *attr,
> > @@ -1934,6 +2010,7 @@ const struct bpf_map_ops htab_map_ops = {
> >   	.map_free = htab_map_free,
> >   	.map_get_next_key = htab_map_get_next_key,
> >   	.map_lookup_elem = htab_map_lookup_elem,
> > +	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
> >   	.map_update_elem = htab_map_update_elem,
> >   	.map_delete_elem = htab_map_delete_elem,
> >   	.map_gen_lookup = htab_map_gen_lookup,
> > @@ -1954,6 +2031,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
> >   	.map_free = htab_map_free,
> >   	.map_get_next_key = htab_map_get_next_key,
> >   	.map_lookup_elem = htab_lru_map_lookup_elem,
> > +	.map_lookup_and_delete_elem = htab_lru_map_lookup_and_delete_elem,
> >   	.map_lookup_elem_sys_only = htab_lru_map_lookup_elem_sys,
> >   	.map_update_elem = htab_lru_map_update_elem,
> >   	.map_delete_elem = htab_lru_map_delete_elem,
> > @@ -2077,6 +2155,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
> >   	.map_free = htab_map_free,
> >   	.map_get_next_key = htab_map_get_next_key,
> >   	.map_lookup_elem = htab_percpu_map_lookup_elem,
> > +	.map_lookup_and_delete_elem = htab_percpu_map_lookup_and_delete_elem,
> >   	.map_update_elem = htab_percpu_map_update_elem,
> >   	.map_delete_elem = htab_map_delete_elem,
> >   	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
> > @@ -2096,6 +2175,7 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
> >   	.map_free = htab_map_free,
> >   	.map_get_next_key = htab_map_get_next_key,
> >   	.map_lookup_elem = htab_lru_percpu_map_lookup_elem,
> > +	.map_lookup_and_delete_elem = htab_lru_percpu_map_lookup_and_delete_elem,
> >   	.map_update_elem = htab_lru_percpu_map_update_elem,
> >   	.map_delete_elem = htab_lru_map_delete_elem,
> >   	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index c859bc46d06c..2634aa4a2f37 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -1495,7 +1495,7 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
> >   		goto err_put;
> >   	}
> >   
> > -	value_size = map->value_size;
> > +	value_size = bpf_map_value_size(map);
> >   
> >   	err = -ENOMEM;
> >   	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
> > @@ -1505,6 +1505,18 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
> >   	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
> >   	    map->map_type == BPF_MAP_TYPE_STACK) {
> >   		err = map->ops->map_pop_elem(map, value);
> > +	} else if (map->map_type == BPF_MAP_TYPE_HASH ||
> > +		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
> > +		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
> > +		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
> > +		if (!bpf_map_is_dev_bound(map)) {
> > +			bpf_disable_instrumentation();
> > +			rcu_read_lock();
> > +			err = map->ops->map_lookup_and_delete_elem(map, key, value);
> > +			rcu_read_unlock();
> > +			bpf_enable_instrumentation();
> > +			maybe_wait_bpf_programs(map);
> 
> maybe_wait_bpf_programs(map) is mostly for map-in-map.
> but I think it is okay to put it here in case in the future
> we will support map-in-map here. If maybe_wait_bpf_programs()
> get inlined which mostly likely is the case, the compiler
> should be able to optimize it away.
> 

I didn't realise at first it's only for map-in-map and forgot to remove
it later, so I can remove this if you think it's better?

> > +		}
> >   	} else {
> >   		err = -ENOTSUPP;
> >   	}
> > diff --git a/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> > new file mode 100644
> > index 000000000000..05123bbcdc1c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c
> > @@ -0,0 +1,283 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <test_progs.h>
> > +#include "test_lookup_and_delete.skel.h"
> > +
> > +#define START_VALUE 1234
> > +#define NEW_VALUE 4321
> > +#define MAX_ENTRIES 2
> > +
> > +static int duration;
> > +static int nr_cpus;
> > +
> > +static int fill_values(int map_fd)
> > +{
> > +	__u64 key, value = START_VALUE;
> > +	int err;
> > +
> > +	for (key = 1; key < MAX_ENTRIES + 1; key++) {
> > +		err = bpf_map_update_elem(map_fd, &key, &value, BPF_NOEXIST);
> > +		if (CHECK(err, "bpf_map_update_elem", "failed\n"))
> 
> You can use
> 	if (!ASSERT_OK(err, "bpf_map_update_elem"))
> to save you from explicit "failed" string.
> The same for some later other CHECK usages.
> 

Ok.

> > +			return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int fill_values_percpu(int map_fd)
> > +{
> > +	BPF_DECLARE_PERCPU(__u64, value);
> > +	int i, err;
> > +	u64 key;
> > +
> > +	for (i = 0; i < nr_cpus; i++)
> > +		bpf_percpu(value, i) = START_VALUE;
> > +
> > +	for (key = 1; key < MAX_ENTRIES + 1; key++) {
> > +		err = bpf_map_update_elem(map_fd, &key, value, BPF_NOEXIST);
> > +		if (CHECK(err, "bpf_map_update_elem", "failed\n"))
> > +			return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> [...]
> > diff --git a/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c b/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
> > new file mode 100644
> > index 000000000000..eb19de8bb415
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/test_lookup_and_delete.c
> > @@ -0,0 +1,26 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +
> > +__u32 set_pid;
> > +__u64 set_key;
> > +__u64 set_value;
> 
> Please add "= 0" to the above declaration to make
> it llvm10 friendly.
> 

Ok, I'll add this. Sorry, checkpatch.pl gave me an error with it, that's
why I removed it.

> > +
> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_HASH);
> > +	__uint(max_entries, 2);
> > +	__type(key, __u64);
> > +	__type(value, __u64);
> > +} hash_map SEC(".maps");
> > +
> > +SEC("tp/syscalls/sys_enter_getpgid")
> > +int bpf_lookup_and_delete_test(const void *ctx)
> > +{
> > +	if (set_pid == bpf_get_current_pid_tgid() >> 32)
> > +		bpf_map_update_elem(&hash_map, &set_key, &set_value, BPF_NOEXIST);
> > +
> > +	return 0;
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> [...]
