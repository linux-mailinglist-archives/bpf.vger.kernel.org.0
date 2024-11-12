Return-Path: <bpf+bounces-44629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F30A9C5ADF
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 15:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1E52829B9
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBDE1FF047;
	Tue, 12 Nov 2024 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctl0ezrd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA01FCF63;
	Tue, 12 Nov 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423015; cv=none; b=edd0Tw21IYCpBeM5iL2hF47S50ypvTcnx0+H+jWM6JfE2vQkCO6plMb3HxnpOD0lso2M+2umL+LMFAENxxWbpQ3kgVYsqWQTkcsnXUkXkA5uEi8bZ1Ir4O/+gy8Mf9rYud31zBnty/tB3tYasdDTp6t83COgNXyJUkSiBB7dGE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423015; c=relaxed/simple;
	bh=hJ/F/Sf0nxolQrVNr59EiaY8Bo9UHnj5Pz/qJIi0AfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyTlXT/4Kh48RARCTx06aSxuqK6RsRFO64RA8FB+BkkYQ3WWgfr9uot4tVa8/WchBRJ9mRfHuNgqh5ood0XwO0wGQuMIlo4thALX9j9eUyiYmeFcAd7fiVjW6lCXCU3Lj6P6R24LChp9VZmT2OoQKQtc0piGK0KqnQhnnFR7TZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctl0ezrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BF6C4CECD;
	Tue, 12 Nov 2024 14:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423014;
	bh=hJ/F/Sf0nxolQrVNr59EiaY8Bo9UHnj5Pz/qJIi0AfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ctl0ezrdUV2trbGdRkjY59oaE5WHvY2rarGsF7m0g+A5/riRPt7K5Sy22wzrEoprV
	 X5M3S29yqKEDoaGkayLlJKf0TVPiDe11SHqlXahsDKDKjolnVT/5kApIzAnJzK8E/l
	 g0ZzwWrWlzvhVQw4CepCZzt020ucc4vmBcr5CgQ7lOJ/JpsuKRoka6ywAF2f/dlQyf
	 duoz0wLB53vFg4OJ/l7U8c8kfe9XaIkpSWlSZDL0b/KdbphEDp4zKsFw5TVialpZE3
	 b0LXHb/332G4NGxW8UDZp6L4qRHuk0UADNE7Oej2isfqX2D1hD65CbjXuzknc9vVa/
	 n0gGs3u7I+0EA==
Date: Tue, 12 Nov 2024 11:50:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 3/4] perf lock contention: Resolve slab object name
 using BPF
Message-ID: <ZzNrIdiHCxTy1QId@x1>
References: <20241108061500.2698340-1-namhyung@kernel.org>
 <20241108061500.2698340-4-namhyung@kernel.org>
 <5f95c0d7-01a4-485d-a9d7-1a39acf9c680@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f95c0d7-01a4-485d-a9d7-1a39acf9c680@suse.cz>

On Tue, Nov 12, 2024 at 12:09:24PM +0100, Vlastimil Babka wrote:
> On 11/8/24 07:14, Namhyung Kim wrote:
> > The bpf_get_kmem_cache() kfunc can return an address of the slab cache
> > (kmem_cache).  As it has the name of the slab cache from the iterator,
> > we can use it to symbolize some dynamic kernel locks in a slab.
> > 
> > Before:
> >   root@virtme-ng:/home/namhyung/project/linux# tools/perf/perf lock con -abl sleep 1
> >    contended   total wait     max wait     avg wait            address   symbol
> > 
> >            2      3.34 us      2.87 us      1.67 us   ffff9d7800ad9600    (mutex)
> >            2      2.16 us      1.93 us      1.08 us   ffff9d7804b992d8    (mutex)
> >            4      1.37 us       517 ns       343 ns   ffff9d78036e6e00    (mutex)
> >            1      1.27 us      1.27 us      1.27 us   ffff9d7804b99378    (mutex)
> >            2       845 ns       599 ns       422 ns   ffffffff9e1c3620   delayed_uprobe_lock (mutex)
> >            1       845 ns       845 ns       845 ns   ffffffff9da0b280   jiffies_lock (spinlock)
> >            2       377 ns       259 ns       188 ns   ffffffff9e1cf840   pcpu_alloc_mutex (mutex)
> >            1       305 ns       305 ns       305 ns   ffffffff9e1b4cf8   tracepoint_srcu_srcu_usage (mutex)
> >            1       295 ns       295 ns       295 ns   ffffffff9e1c0940   pack_mutex (mutex)
> >            1       232 ns       232 ns       232 ns   ffff9d7804b7d8d8    (mutex)
> >            1       180 ns       180 ns       180 ns   ffffffff9e1b4c28   tracepoint_srcu_srcu_usage (mutex)
> >            1       165 ns       165 ns       165 ns   ffffffff9da8b3a0   text_mutex (mutex)
> > 
> > After:
> >   root@virtme-ng:/home/namhyung/project/linux# tools/perf/perf lock con -abl sleep 1
> >    contended   total wait     max wait     avg wait            address   symbol
> > 
> >            2      1.95 us      1.77 us       975 ns   ffff9d5e852d3498   &task_struct (mutex)
> >            1      1.18 us      1.18 us      1.18 us   ffff9d5e852d3538   &task_struct (mutex)
> >            4      1.12 us       354 ns       279 ns   ffff9d5e841ca800   &kmalloc-cg-512 (mutex)
> >            2       859 ns       617 ns       429 ns   ffffffffa41c3620   delayed_uprobe_lock (mutex)
> >            3       691 ns       388 ns       230 ns   ffffffffa41c0940   pack_mutex (mutex)
> >            3       421 ns       164 ns       140 ns   ffffffffa3a8b3a0   text_mutex (mutex)
> >            1       409 ns       409 ns       409 ns   ffffffffa41b4cf8   tracepoint_srcu_srcu_usage (mutex)
> >            2       362 ns       239 ns       181 ns   ffffffffa41cf840   pcpu_alloc_mutex (mutex)
> >            1       220 ns       220 ns       220 ns   ffff9d5e82b534d8   &signal_cache (mutex)
> >            1       215 ns       215 ns       215 ns   ffffffffa41b4c28   tracepoint_srcu_srcu_usage (mutex)
> > 
> > Note that the name starts with '&' sign for slab objects to inform they
> > are dynamic locks.  It won't give the accurate lock or type names but
> > it's still useful.  We may add type info to the slab cache later to get
> > the exact name of the lock in the type later.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> <snip>
> 
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > index fd24ccb00faec0ba..b5bc37955560a58e 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -123,6 +123,8 @@ struct mm_struct___new {
> >  	struct rw_semaphore mmap_lock;
> >  } __attribute__((preserve_access_index));
> >  
> > +extern struct kmem_cache *bpf_get_kmem_cache(u64 addr) __ksym __weak;
> > +
> >  /* control flags */
> >  const volatile int has_cpu;
> >  const volatile int has_task;
> > @@ -496,8 +498,23 @@ int contention_end(u64 *ctx)
> >  		};
> >  		int err;
> >  
> > -		if (aggr_mode == LOCK_AGGR_ADDR)
> > -			first.flags |= check_lock_type(pelem->lock, pelem->flags);
> > +		if (aggr_mode == LOCK_AGGR_ADDR) {
> > +			first.flags |= check_lock_type(pelem->lock,
> > +						       pelem->flags & LCB_F_TYPE_MASK);
> > +
> > +			/* Check if it's from a slab object */
> > +			if (bpf_get_kmem_cache) {
> > +				struct kmem_cache *s;
> > +				struct slab_cache_data *d;
> > +
> > +				s = bpf_get_kmem_cache(pelem->lock);
> > +				if (s != NULL) {
> > +					d = bpf_map_lookup_elem(&slab_caches, &s);
> > +					if (d != NULL)
> > +						first.flags |= d->id;
> > +				}
> 
> Is this being executed as part of obtaining a perf event record, or as part
> of a postprocessing pass? I'm not familiar enough with the code to be certain.
> 
> - if it's part of perf event record, can you just store 's' and defer
> resolving the cache by bpf_map_lookup_elem() to postprocessing?

Namhyung is in vacation this week, so lemme try to help (and learn more
about this patchset since we discussed about it back in LSFMM :-)):

tldr;: He wants to store a 10 bit cookie for the slab cache, to avoid
storing 64 bits per contention record.

My reading of his code:

'first' is a 'struct contention_data' instance, that he will use for
post processing in tools/perf/builtin-lock.c, the relevant part:

	if (use_bpf) {
                lock_contention_start();
                if (argc)
                        evlist__start_workload(con.evlist);

                /* wait for signal */
                pause();

                lock_contention_stop();
                lock_contention_read(&con);
	} else
		process records from a perf.data file with tons
		of lock:lock_contention_{begin,end}, which the use_bpf
		mode above "pre-processes" at begin+end pairs and
                turns into 'struct contention_data' records in a BPF
		map for later post processing in the common part after
		this if/else block.

The post processing is in lock_contention_read(), that is in
tools/perf/util/bpf_lock_contention.c, I stripped out prep steps, etc,
the "meat" is:

        struct contention_data data = {};
	struct lock_stat *st = NULL;
<SNIP>
        while (!bpf_map_get_next_key(fd, prev_key, &key)) {
                s64 ls_key;
                const char *name;

                bpf_map_lookup_elem(fd, &key, &data);

                name = lock_contention_get_name(con, &key, stack_trace, data.flags);
                st = lock_stat_findnew(ls_key, name, data.flags);

That 'lock_stat' struct is then filled up and later, in the common part
to using or not BPF, it gets printed out in the builtin-lock.c main tool
codebase.

The part we're interested here is that lock_contention_get_name(), that
before this patch series returns "(mutex)" and now resolves it to the
slab cache name "&task_struct (mutex)".

key is:

struct contention_key {
        s32 stack_id;
        u32 pid;
        u64 lock_addr_or_cgroup;
};

lock_contention_get_name() tries to resolve the name to the usual
suspects: 
                /* per-process locks set upper bits of the flags */
                if (flags & LCD_F_MMAP_LOCK)
                        return "mmap_lock";
                if (flags & LCD_F_SIGHAND_LOCK)
                        return "siglock";

                /* global locks with symbols */
                sym = machine__find_kernel_symbol(machine, key->lock_addr_or_cgroup, &kmap);
                if (sym)
                        return sym->name;

And then if all of the above (there is another case for rq_lock) it
then gets to look the the ID area of contention_data->flags:

+#define LCB_F_SLAB_ID_SHIFT    16
+#define LCB_F_SLAB_ID_START    (1U << 16)
+#define LCB_F_SLAB_ID_END	(1U << 26)
+#define LCB_F_SLAB_ID_MASK     0x03FF0000U

>>> bin(0x03FF0000)
'0b11111111110000000000000000'
>>>

+               /* look slab_hash for dynamic locks in a slab object */
+               if (hashmap__find(&slab_hash, flags & LCB_F_SLAB_ID_MASK, &slab_data)) {
+                       snprintf(name_buf, sizeof(name_buf), "&%s", slab_data->name);
+                       return name_buf;
+        	}

He wants to avoid storing 64 bytes (the slab cache pointer, 's'), instead
he wants to store a shorter 'id' and encode it in the upper bits of the
'struct contention_data' 'flags' field.

The iterator, at the beggining of the session attributes this id,
starting from zero, to each of the slab caches, so it needs to map it
back from the address at contention_end tracepoint.

At post processing time it converts the id back to the name of the slab
cache.

I hope this helps,

- Arnaldo

> - if it's postprocessing, it would be too late for bpf_get_kmem_cache() as
> the object might be gone already?
> 
> The second alternative would be worse as it could miss the cache or
> misattribute (in case page is reallocated by another cache), the first is
> just less efficient than possible.
> 
> > +			}
> > +		}
> >  
> >  		err = bpf_map_update_elem(&lock_stat, &key, &first, BPF_NOEXIST);
> >  		if (err < 0) {

