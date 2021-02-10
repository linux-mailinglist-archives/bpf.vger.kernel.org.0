Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970D8316D74
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 18:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhBJR5h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 12:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhBJR52 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 12:57:28 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1EDC061786
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 09:56:47 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id b9so5687084ejy.12
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 09:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dbvM+WSOz7Eqb2meD6TNJbWzsjLznvpSgUE4lN789No=;
        b=oZ8A33FZQ0TTMr26/hRET3DhG1y3oA/eu7EETStn6s1IY+dMl1RTAVUAbKJnbw5eJw
         KHO6FYkSnV2K0P2Gb8RdQ9XePloUjK2l4XdSCMcEyLf1b8+pL2Wy0h7EPGQBnB5JDP0p
         Y81xfHlqlxzRT5K/L+LWSI1mLZPc+LB+R78cxWHjueov2rSs+/CTyt72F1f3iS6rR2l9
         wQrntAGd3xT5KbedkAIYRp9jvgHJhY6Hm1QR7hygrTxAWsM8yOhnaMKDhnBCX7JEvpEe
         Gb1hxUNGhaQ/+o0hJHEEkyLqsAuzfPQcTSdNL3wOC3J5tOCTKLaspaB+aGLuBlEbPo1N
         m0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dbvM+WSOz7Eqb2meD6TNJbWzsjLznvpSgUE4lN789No=;
        b=F8cm3AqukJJkHVSrdWei9qB1TiQoJMOo4rvGW9kWtu5FGP/ozDbJBqQ/QUxRc6K+Ld
         ejV8uCpVAWGpz8xK0Qh9OLcYxwLQ3C06V7gzEo72Px+B8fZ/EJTHlM6Y8+ahPwDcJdcs
         E/weeh+xBcmrySqhqKu2GAW3D7FXmeIQEesTDiKC18dac7w/01U9qCOjDbK8AhwzUNhT
         94W12BpPaHz2hn/KZhhy8uTG9q/hy+8rdjiPqk12lTiaCQYkMaXZtxZTVptcBSVrWphn
         IIR4mfA0ObNchy5oFeHjEsaKN4D6CVRf3KQHqUfLZ6cgfcTc1NFVt+VmHoz4uEjBV9vH
         XLvg==
X-Gm-Message-State: AOAM532dIYyAmf0ct4glFhxc1GGc78Q81X/uhrJl9cDbJv4zTYSxvX0D
        KVuPOU4IyWkMmqipG3tlukEwgA==
X-Google-Smtp-Source: ABdhPJx+qpWNtGpmaUfvhIvJMSd0VbGK+5Cr17l7UE9Fv6APrg1jg/yLI4K0uE+2WJg5wkg2VngT/w==
X-Received: by 2002:a17:906:8507:: with SMTP id i7mr4104543ejx.175.1612979806211;
        Wed, 10 Feb 2021 09:56:46 -0800 (PST)
Received: from gmail.com (93-136-111-120.adsl.net.t-com.hr. [93.136.111.120])
        by smtp.gmail.com with ESMTPSA id w8sm1540502edd.39.2021.02.10.09.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:56:45 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:56:50 +0100
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, luka.perkov@sartura.hr,
        luka.oreskovic@sartura.hr, juraj.vijtiuk@sartura.hr,
        andrii.nakryiko@gmail.com
Subject: Re: [PATCH bpf-next] bpf: add lookup_and_delete_elem support to
 hashtab
Message-ID: <YCQeYte5OB0PNUE9@gmail.com>
References: <YBGe5WFzSc3Z8Oh5@gmail.com>
 <74e61161-3330-88b8-aa18-84d7357cd945@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74e61161-3330-88b8-aa18-84d7357cd945@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 29, 2021 at 04:58:12PM +0100, Daniel Borkmann wrote:
> On 1/27/21 6:12 PM, Denis Salopek wrote:
> > Extend the existing bpf_map_lookup_and_delete_elem() functionality to
> > hashtab maps, in addition to stacks and queues.
> > Create a new hashtab bpf_map_ops function that does lookup and deletion
> > of the element under the same bucket lock and add the created map_ops to
> > bpf.h.
> > Add the appropriate test case to 'maps' selftests.
> > 
> > Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
> > Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> > Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> > Cc: Luka Perkov <luka.perkov@sartura.hr>
> 
> This is already possible in a more generic form, that is, via bpf(2) cmd
> BPF_MAP_LOOKUP_AND_DELETE_BATCH which is implemented by the different htab
> map flavors which also take the bucket lock. Did you have a try at that?
> 
> > ---
> >   include/linux/bpf.h                     |  1 +
> >   kernel/bpf/hashtab.c                    | 38 +++++++++++++++++++++++++
> >   kernel/bpf/syscall.c                    |  9 ++++++
> >   tools/testing/selftests/bpf/test_maps.c |  7 +++++
> >   4 files changed, 55 insertions(+)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 1aac2af12fed..003c1505f0e3 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -77,6 +77,7 @@ struct bpf_map_ops {
> >   	/* funcs callable from userspace and from eBPF programs */
> >   	void *(*map_lookup_elem)(struct bpf_map *map, void *key);
> > +	int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key, void *value);
> >   	int (*map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags);
> >   	int (*map_delete_elem)(struct bpf_map *map, void *key);
> >   	int (*map_push_elem)(struct bpf_map *map, void *value, u64 flags);
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index c1ac7f964bc9..8d8463e0ea34 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -973,6 +973,43 @@ static int check_flags(struct bpf_htab *htab, struct htab_elem *l_old,
> >   	return 0;
> >   }
> > +/* Called from syscall or from eBPF program */
> > +static int htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void *value)
> > +{
> > +	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> > +	struct hlist_nulls_head *head;
> > +	struct bucket *b;
> > +	struct htab_elem *l;
> > +	unsigned long flags;
> > +	u32 hash, key_size;
> > +	int ret;
> > +
> > +	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
> > +
> > +	key_size = map->key_size;
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
> > +
> > +	if (l) {
> > +		copy_map_value(map, value, l->key + round_up(key_size, 8));
> > +		hlist_nulls_del_rcu(&l->hash_node);
> > +		free_htab_elem(htab, l);
> > +	} else {
> > +		ret = -ENOENT;
> > +	}
> > +
> > +	htab_unlock_bucket(htab, b, hash, flags);
> > +	return ret;
> > +}
> > +
> >   /* Called from syscall or from eBPF program */
> >   static int htab_map_update_elem(struct bpf_map *map, void *key, void *value,
> >   				u64 map_flags)
> > @@ -1877,6 +1914,7 @@ const struct bpf_map_ops htab_map_ops = {
> >   	.map_free = htab_map_free,
> >   	.map_get_next_key = htab_map_get_next_key,
> >   	.map_lookup_elem = htab_map_lookup_elem,
> > +	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
> >   	.map_update_elem = htab_map_update_elem,
> >   	.map_delete_elem = htab_map_delete_elem,
> >   	.map_gen_lookup = htab_map_gen_lookup,
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index e5999d86c76e..4ff45c8d1077 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -1505,6 +1505,15 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
> >   	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
> >   	    map->map_type == BPF_MAP_TYPE_STACK) {
> >   		err = map->ops->map_pop_elem(map, value);
> > +	} else if (map->map_type == BPF_MAP_TYPE_HASH) {
> > +		if (!bpf_map_is_dev_bound(map)) {
> > +			bpf_disable_instrumentation();
> > +			rcu_read_lock();
> > +			err = map->ops->map_lookup_and_delete_elem(map, key, value);
> > +			rcu_read_unlock();
> > +			bpf_enable_instrumentation();
> > +			maybe_wait_bpf_programs(map);
> > +		}
> >   	} else {
> >   		err = -ENOTSUPP;
> >   	}

Hi,

Is there something wrong with adding hashmap functionality to the
map_lookup_and_delete_elem() function? As per commit
bd513cd08f10cbe28856f99ae951e86e86803861, adding this functionality for
other map types was the plan at the time this function was implemented,
so wouldn't this addition be useful? Otherwise, this function would only
be used for stack/queue popping. So why does it even exist in the first
place, if the _batch function can be used instead?

I understand the _batch function can do the same job, but is there a
reason why using it would be a better option? There is also a
performance impact in the _batch function when compared to my function -
not too big, but still worth the mention. In my benchmarks, the _batch
function takes 15% longer for lookup and deletion of one element.

Denis
