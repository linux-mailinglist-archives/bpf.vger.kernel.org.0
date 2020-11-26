Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DB92C51A6
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 10:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733310AbgKZJ4U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 04:56:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733102AbgKZJ4U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Nov 2020 04:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606384578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XL2h/hir+tmct6ROumYIQmrzt7JrIUdXPqptvlCNWjc=;
        b=A3i0p/LMgqGo8lhEOyax9rVMQM0vr+/ibfjpc8Mv7UhWYcy6eRrYffjpwCxuYppVvvsr6r
        FbAPLq4iszgOtIyUU8RPJ6A/IG1zwibeYuZSxcOzAqexWqb57Dzk6aw3zAkG6HmNxH4Sao
        kuXRKdkwZ1awJ7DFm8CxHluf80e79IY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-czdPX-XqNE6jpGZjfhbBMA-1; Thu, 26 Nov 2020 04:56:15 -0500
X-MC-Unique: czdPX-XqNE6jpGZjfhbBMA-1
Received: by mail-ed1-f70.google.com with SMTP id i1so801732edt.19
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 01:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XL2h/hir+tmct6ROumYIQmrzt7JrIUdXPqptvlCNWjc=;
        b=VXdm+oAxs+R+2eyUVxd2gAZvSid68hjs0iYyb/Do5K9mr0bIwa7G1HCKJK7qVos4jk
         GrWFqf0Nn9RAiD6qf3yR+TZs6ajtKVEEkquP7fRfNH2aaSxOMrvPx2akTQmATiPbio2y
         Qg/thOFaP2n1s//HMOrKltCs80alak0lSb//PhjsTg8yjZZ1YLYyguiNhIOQLeabRtZL
         ZqmU0I+0R1wj8v8TNh418Y5GRyuwnwkmjOwMnoU9W/43SReQrUDNy8f/zjtloZZ44gVA
         pWTCQzq2gK0CD3Sp3wveH3v+mdCqyeG8Wrv1J5RR/OEsGp36BWtF0JgELwXrLd9SXy0B
         JoOg==
X-Gm-Message-State: AOAM531D5jVU5ogKi19TegB2/9lzcn/M3V+4X2EHiugQ8QJcZN+fuzDn
        0xuj/znAq9O1UPuWhx5DO5fXoABt9CG9fG2P3Zi2rudvNRJXWHzVbUfhCRm9+2Env+AycEhMHn2
        lLunKbHB1aoeT
X-Received: by 2002:a17:906:4149:: with SMTP id l9mr2025944ejk.48.1606384573589;
        Thu, 26 Nov 2020 01:56:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpwWVFyFaUq292qnGC1BLOcKdLXpzzdLATaHboam1LmcQEjYpWqGxMbDjjskkqrrnuIe1btQ==
X-Received: by 2002:a17:906:4149:: with SMTP id l9mr2025917ejk.48.1606384573185;
        Thu, 26 Nov 2020 01:56:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id jr13sm2742167ejb.50.2020.11.26.01.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 01:56:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 13A1E183064; Thu, 26 Nov 2020 10:56:12 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Roman Gushchin <guro@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, netdev@vger.kernel.org,
        andrii@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        hannes@cmpxchg.org, tj@kernel.org
Subject: Re: [PATCH bpf-next v8 06/34] bpf: prepare for memcg-based memory
 accounting for bpf maps
In-Reply-To: <20201126023000.GB840171@carbon.dhcp.thefacebook.com>
References: <20201125030119.2864302-1-guro@fb.com>
 <20201125030119.2864302-7-guro@fb.com>
 <ef140167-8d80-c581-318c-36c0430e4cfa@iogearbox.net>
 <20201126023000.GB840171@carbon.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 26 Nov 2020 10:56:12 +0100
Message-ID: <87lfeol9vn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Roman Gushchin <guro@fb.com> writes:

> On Thu, Nov 26, 2020 at 01:21:41AM +0100, Daniel Borkmann wrote:
>> On 11/25/20 4:00 AM, Roman Gushchin wrote:
>> > In the absolute majority of cases if a process is making a kernel
>> > allocation, it's memory cgroup is getting charged.
>> > 
>> > Bpf maps can be updated from an interrupt context and in such
>> > case there is no process which can be charged. It makes the memory
>> > accounting of bpf maps non-trivial.
>> > 
>> > Fortunately, after commit 4127c6504f25 ("mm: kmem: enable kernel
>> > memcg accounting from interrupt contexts") and b87d8cefe43c
>> > ("mm, memcg: rework remote charging API to support nesting")
>> > it's finally possible.
>> > 
>> > To do it, a pointer to the memory cgroup of the process, which created
>> > the map, is saved, and this cgroup can be charged for all allocations
>> > made from an interrupt context. This commit introduces 2 helpers:
>> > bpf_map_kmalloc_node() and bpf_map_alloc_percpu(). They can be used in
>> > the bpf code for accounted memory allocations, both in the process and
>> > interrupt contexts. In the interrupt context they're using the saved
>> > memory cgroup, otherwise the current cgroup is getting charged.
>> > 
>> > Signed-off-by: Roman Gushchin <guro@fb.com>
>> 
>> Thanks for updating the cover letter; replying in this series instead
>> on one more item that came to mind:
>> 
>> [...]
>> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> > index f3fe9f53f93c..4154c616788c 100644
>> > --- a/kernel/bpf/syscall.c
>> > +++ b/kernel/bpf/syscall.c
>> > @@ -31,6 +31,8 @@
>> >   #include <linux/poll.h>
>> >   #include <linux/bpf-netns.h>
>> >   #include <linux/rcupdate_trace.h>
>> > +#include <linux/memcontrol.h>
>> > +#include <linux/sched/mm.h>
>> >   #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
>> >   			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
>> > @@ -456,6 +458,77 @@ void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock)
>> >   		__release(&map_idr_lock);
>> >   }
>> > +#ifdef CONFIG_MEMCG_KMEM
>> > +static void bpf_map_save_memcg(struct bpf_map *map)
>> > +{
>> > +	map->memcg = get_mem_cgroup_from_mm(current->mm);
>> > +}
>> > +
>> > +static void bpf_map_release_memcg(struct bpf_map *map)
>> > +{
>> > +	mem_cgroup_put(map->memcg);
>> > +}
>> > +
>> > +void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
>> > +			   int node)
>> > +{
>> > +	struct mem_cgroup *old_memcg;
>> > +	bool in_interrupt;
>> > +	void *ptr;
>> > +
>> > +	/*
>> > +	 * If the memory allocation is performed from an interrupt context,
>> > +	 * the memory cgroup to charge can't be determined from the context
>> > +	 * of the current task. Instead, we charge the memory cgroup, which
>> > +	 * contained the process created the map.
>> > +	 */
>> > +	in_interrupt = in_interrupt();
>> > +	if (in_interrupt)
>> > +		old_memcg = set_active_memcg(map->memcg);
>> > +
>> > +	ptr = kmalloc_node(size, flags, node);
>> > +
>> > +	if (in_interrupt)
>> > +		set_active_memcg(old_memcg);
>> > +
>> > +	return ptr;
>> > +}
>> > +
>> > +void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
>> > +				    size_t align, gfp_t gfp)
>> > +{
>> > +	struct mem_cgroup *old_memcg;
>> > +	bool in_interrupt;
>> > +	void *ptr;
>> > +
>> > +	/*
>> > +	 * If the memory allocation is performed from an interrupt context,
>> > +	 * the memory cgroup to charge can't be determined from the context
>> > +	 * of the current task. Instead, we charge the memory cgroup, which
>> > +	 * contained the process created the map.
>> > +	 */
>> > +	in_interrupt = in_interrupt();
>> > +	if (in_interrupt)
>> > +		old_memcg = set_active_memcg(map->memcg);
>> > +
>> > +	ptr = __alloc_percpu_gfp(size, align, gfp);
>> > +
>> > +	if (in_interrupt)
>> > +		set_active_memcg(old_memcg);
>> 
>> For this and above bpf_map_kmalloc_node() one, wouldn't it make more sense to
>> perform the temporary memcg unconditionally?
>> 
>> 	old_memcg = set_active_memcg(map->memcg);
>> 	ptr = kmalloc_node(size, flags, node);
>> 	set_active_memcg(old_memcg);
>> 
>> I think the semantics are otherwise a bit weird and the charging unpredictable;
>> this way it would /always/ be accounted against the prog in the memcg that
>> originally created the map.
>> 
>> E.g. maps could be shared between progs attached to, say, XDP/tc where in_interrupt()
>> holds true with progs attached to skb-cgroup/egress where we're still in process
>> context. So some part of the memory is charged against the original map's memcg and
>> some other part against the current process' memcg which seems odd, no? Or, for example,
>> if we start to run a tracing BPF prog which updates state in a BPF map ... that tracing
>> prog now interferes with processes in other memcgs which may not be intentional & could
>> lead to potential failures there as opposed when the tracing prog is not run. My concern
>> is that the semantics are not quite clear and behavior unpredictable compared to always
>> charging against map->memcg.
>> 
>> Similarly, what if an orchestration prog creates dedicated memcg(s) for maps with
>> individual limits ... the assumed behavior (imho) would be that whatever memory is
>> accounted on the map it can be accurately retrieved from there & similarly limits
>> enforced, no? It seems that would not be the case currently.
>> 
>> Thoughts?
>
> I did consider this option. There are pros and cons. In general we
> tend to charge the cgroup which actually allocates the memory, and I
> decided to stick with this rule. I agree, it's fairly easy to come
> with arguments why always charging the map creator is better. The
> opposite is also true: it's not clear why bpf is different here. So
> I'm fine with both options, if there is a wide consensus, I'm happy to
> switch to the other option. In general, I believe that the current
> scheme is more flexible: if someone want to pay in advance, they are
> free to preallocate the map. Otherwise it's up to whoever wants to
> populate it.

I think I agree with Daniel here: conceptually the memory used by a map
ought to belong to that map's memcg. I can see how the other scheme can
be more flexible, but as Daniel points out it seems like it can lead to
hard-to-debug errors...

(Side note: I'm really excited about this work in general! The ulimit
thing has been a major pain...)

-Toke

