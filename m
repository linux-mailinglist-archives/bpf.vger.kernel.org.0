Return-Path: <bpf+bounces-56959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48447AA107A
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 17:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D002466080
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 15:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4E122171A;
	Tue, 29 Apr 2025 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A89YHWQB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9CD21ABA6;
	Tue, 29 Apr 2025 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940503; cv=none; b=hFDUBsFNYAeXdRhCyDvSaNEsbfIx2CK0F90OyHKYAptQH0s+4h/wlOSirX1LOsgDZnijSAZ1lXDX8V1ISSxMn+JkvQ8uiDqoIGmLNibmxzlO0R+Xby5bwRQjaXe2iQnSXns/opTlpgzHq6DJD4GPxlTfZmtTVHs+D9eh4zxnt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940503; c=relaxed/simple;
	bh=GKDoPE5wVo0tvFoMnp2QEMrBMBHNnvcfAV6ozVMfKjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OytckxnYL4QzRBZnkBxhaHB8HH5KAD9YHwx7xJFYEMBFUd3WldC7a81w4TEkHfJYA0wPALr6tr3qOGqgzyYSKKszoYSq77iAilsE9spRyFO9ll2PI+v/llBvpbPUu6xl1gqJcxbISB5XkLcLEZy2tQ0F6K+p1Vfadj9uXVaEWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A89YHWQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B602BC4CEEE;
	Tue, 29 Apr 2025 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745940503;
	bh=GKDoPE5wVo0tvFoMnp2QEMrBMBHNnvcfAV6ozVMfKjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A89YHWQBWZie2Qrt7QyyXd3blZM9jL8nJtei4Utc/6ZdOmhfjvAc6Id6lbaNjE9fH
	 BTpgE4u9ZpBiL9K5WL9non63r58U2gyaP1/eDPcWFq6brsH7c/rUl2CnBz31hu2RNA
	 jGZ+UqCs2z019Thy0mLHIzEw38N/c1O2TxCGlO9OqCasH+dd/rGLadtDWc47Jvhjwc
	 XQkIs7kFFrmbP+XKR3CgZqT0Ln9EZMqQ/W+fDDxw2pZNjggjleJ3eGgq0TEa/aRnaO
	 gAj8aR7L8FTOBo14cZ8NauaGGzIF1MjDMF+BAdPQXvWqWhC+aByEfPbI0IBLfdwNXz
	 n2nD1bnkKVpOg==
Date: Tue, 29 Apr 2025 12:28:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH] perf lock contention: Symbolize zone->lock using BTF
Message-ID: <aBDwB7b5dPL7REy8@x1>
References: <20250401063055.7431-1-namhyung@kernel.org>
 <aA8HImKeUutpFoeD@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA8HImKeUutpFoeD@google.com>

On Sun, Apr 27, 2025 at 09:42:10PM -0700, Namhyung Kim wrote:
> Ping!

Thanks!

Applied. :-)

- Arnaldo
 
> On Mon, Mar 31, 2025 at 11:30:55PM -0700, Namhyung Kim wrote:
> > The struct zone is embedded in struct pglist_data which can be allocated
> > for each NUMA node early in the boot process.  As it's not a slab object
> > nor a global lock, this was not symbolized.
> > 
> > Since the zone->lock is often contended, it'd be nice if we can
> > symbolize it.  On NUMA systems, node_data array will have pointers for
> > struct pglist_data.  By following the pointer, it can calculate the
> > address of each zone and its lock using BTF.  On UMA, it can just use
> > contig_page_data and its zones.
> > 
> > The following example shows the zone lock contention at the end.
> > 
> >   $ sudo ./perf lock con -abl -E 5 -- ./perf bench sched messaging
> >   # Running 'sched/messaging' benchmark:
> >   # 20 sender and receiver processes per group
> >   # 10 groups == 400 processes run
> > 
> >        Total time: 0.038 [sec]
> >    contended   total wait     max wait     avg wait            address   symbol
> > 
> >         5167     18.17 ms     10.27 us      3.52 us   ffff953340052d00   &kmem_cache_node (spinlock)
> >           38     11.75 ms    465.49 us    309.13 us   ffff95334060c480   &sock_inode_cache (spinlock)
> >         3916     10.13 ms     10.43 us      2.59 us   ffff953342aecb40   &kmem_cache_node (spinlock)
> >         2963     10.02 ms     13.75 us      3.38 us   ffff9533d2344098   &kmalloc-rnd-08-2k (spinlock)
> >          216      5.05 ms     99.49 us     23.39 us   ffff9542bf7d65d0   zone_lock (spinlock)
> > 
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/bpf_lock_contention.c         | 88 +++++++++++++++++--
> >  .../perf/util/bpf_skel/lock_contention.bpf.c  | 64 ++++++++++++++
> >  tools/perf/util/bpf_skel/lock_data.h          |  1 +
> >  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |  9 ++
> >  tools/perf/util/lock-contention.h             |  1 +
> >  5 files changed, 157 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> > index 5af8f6d1bc952613..98395667220e58ee 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> > @@ -12,6 +12,7 @@
> >  #include "util/lock-contention.h"
> >  #include <linux/zalloc.h>
> >  #include <linux/string.h>
> > +#include <api/fs/fs.h>
> >  #include <bpf/bpf.h>
> >  #include <bpf/btf.h>
> >  #include <inttypes.h>
> > @@ -35,28 +36,26 @@ static bool slab_cache_equal(long key1, long key2, void *ctx __maybe_unused)
> >  
> >  static void check_slab_cache_iter(struct lock_contention *con)
> >  {
> > -	struct btf *btf = btf__load_vmlinux_btf();
> >  	s32 ret;
> >  
> >  	hashmap__init(&slab_hash, slab_cache_hash, slab_cache_equal, /*ctx=*/NULL);
> >  
> > -	if (btf == NULL) {
> > +	con->btf = btf__load_vmlinux_btf();
> > +	if (con->btf == NULL) {
> >  		pr_debug("BTF loading failed: %s\n", strerror(errno));
> >  		return;
> >  	}
> >  
> > -	ret = btf__find_by_name_kind(btf, "bpf_iter__kmem_cache", BTF_KIND_STRUCT);
> > +	ret = btf__find_by_name_kind(con->btf, "bpf_iter__kmem_cache", BTF_KIND_STRUCT);
> >  	if (ret < 0) {
> >  		bpf_program__set_autoload(skel->progs.slab_cache_iter, false);
> >  		pr_debug("slab cache iterator is not available: %d\n", ret);
> > -		goto out;
> > +		return;
> >  	}
> >  
> >  	has_slab_iter = true;
> >  
> >  	bpf_map__set_max_entries(skel->maps.slab_caches, con->map_nr_entries);
> > -out:
> > -	btf__free(btf);
> >  }
> >  
> >  static void run_slab_cache_iter(void)
> > @@ -109,6 +108,75 @@ static void exit_slab_cache_iter(void)
> >  	hashmap__clear(&slab_hash);
> >  }
> >  
> > +static void init_numa_data(struct lock_contention *con)
> > +{
> > +	struct symbol *sym;
> > +	struct map *kmap;
> > +	char *buf = NULL, *p;
> > +	size_t len;
> > +	long last = -1;
> > +	int ret;
> > +
> > +	/*
> > +	 * 'struct zone' is embedded in 'struct pglist_data' as an array.
> > +	 * As we may not have full information of the struct zone in the
> > +	 * (fake) vmlinux.h, let's get the actual size from BTF.
> > +	 */
> > +	ret = btf__find_by_name_kind(con->btf, "zone", BTF_KIND_STRUCT);
> > +	if (ret < 0) {
> > +		pr_debug("cannot get type of struct zone: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	ret = btf__resolve_size(con->btf, ret);
> > +	if (ret < 0) {
> > +		pr_debug("cannot get size of struct zone: %d\n", ret);
> > +		return;
> > +	}
> > +	skel->rodata->sizeof_zone = ret;
> > +
> > +	/* UMA system doesn't have 'node_data[]' - just use contig_page_data. */
> > +	sym = machine__find_kernel_symbol_by_name(con->machine,
> > +						  "contig_page_data",
> > +						  &kmap);
> > +	if (sym) {
> > +		skel->rodata->contig_page_data_addr = map__unmap_ip(kmap, sym->start);
> > +		map__put(kmap);
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * The 'node_data' is an array of pointers to struct pglist_data.
> > +	 * It needs to follow the pointer for each node in BPF to get the
> > +	 * address of struct pglist_data and its zones.
> > +	 */
> > +	sym = machine__find_kernel_symbol_by_name(con->machine,
> > +						  "node_data",
> > +						  &kmap);
> > +	if (sym == NULL)
> > +		return;
> > +
> > +	skel->rodata->node_data_addr = map__unmap_ip(kmap, sym->start);
> > +	map__put(kmap);
> > +
> > +	/* get the number of online nodes using the last node number + 1 */
> > +	ret = sysfs__read_str("devices/system/node/online", &buf, &len);
> > +	if (ret < 0) {
> > +		pr_debug("failed to read online node: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	p = buf;
> > +	while (p && *p) {
> > +		last = strtol(p, &p, 0);
> > +
> > +		if (p && (*p == ',' || *p == '-' || *p == '\n'))
> > +			p++;
> > +	}
> > +	skel->rodata->nr_nodes = last + 1;
> > +	free(buf);
> > +}
> > +
> >  int lock_contention_prepare(struct lock_contention *con)
> >  {
> >  	int i, fd;
> > @@ -218,6 +286,8 @@ int lock_contention_prepare(struct lock_contention *con)
> >  
> >  	bpf_map__set_max_entries(skel->maps.slab_filter, nslabs);
> >  
> > +	init_numa_data(con);
> > +
> >  	if (lock_contention_bpf__load(skel) < 0) {
> >  		pr_err("Failed to load lock-contention BPF skeleton\n");
> >  		return -1;
> > @@ -505,6 +575,11 @@ static const char *lock_contention_get_name(struct lock_contention *con,
> >  				return "rq_lock";
> >  		}
> >  
> > +		if (!bpf_map_lookup_elem(lock_fd, &key->lock_addr_or_cgroup, &flags)) {
> > +			if (flags == LOCK_CLASS_ZONE_LOCK)
> > +				return "zone_lock";
> > +		}
> > +
> >  		/* look slab_hash for dynamic locks in a slab object */
> >  		if (hashmap__find(&slab_hash, flags & LCB_F_SLAB_ID_MASK, &slab_data)) {
> >  			snprintf(name_buf, sizeof(name_buf), "&%s", slab_data->name);
> > @@ -743,6 +818,7 @@ int lock_contention_finish(struct lock_contention *con)
> >  	}
> >  
> >  	exit_slab_cache_iter();
> > +	btf__free(con->btf);
> >  
> >  	return 0;
> >  }
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > index 69be7a4234e076e8..6f12c7d978a2e015 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -11,6 +11,9 @@
> >  /* for collect_lock_syms().  4096 was rejected by the verifier */
> >  #define MAX_CPUS  1024
> >  
> > +/* for collect_zone_lock().  It should be more than the actual zones. */
> > +#define MAX_ZONES  10
> > +
> >  /* lock contention flags from include/trace/events/lock.h */
> >  #define LCB_F_SPIN	(1U << 0)
> >  #define LCB_F_READ	(1U << 1)
> > @@ -801,6 +804,11 @@ int contention_end(u64 *ctx)
> >  
> >  extern struct rq runqueues __ksym;
> >  
> > +const volatile __u64 contig_page_data_addr;
> > +const volatile __u64 node_data_addr;
> > +const volatile int nr_nodes;
> > +const volatile int sizeof_zone;
> > +
> >  struct rq___old {
> >  	raw_spinlock_t lock;
> >  } __attribute__((preserve_access_index));
> > @@ -809,6 +817,59 @@ struct rq___new {
> >  	raw_spinlock_t __lock;
> >  } __attribute__((preserve_access_index));
> >  
> > +static void collect_zone_lock(void)
> > +{
> > +	__u64 nr_zones, zone_off;
> > +	__u64 lock_addr, lock_off;
> > +	__u32 lock_flag = LOCK_CLASS_ZONE_LOCK;
> > +
> > +	zone_off = offsetof(struct pglist_data, node_zones);
> > +	lock_off = offsetof(struct zone, lock);
> > +
> > +	if (contig_page_data_addr) {
> > +		struct pglist_data *contig_page_data;
> > +
> > +		contig_page_data = (void *)(long)contig_page_data_addr;
> > +		nr_zones = BPF_CORE_READ(contig_page_data, nr_zones);
> > +
> > +		for (int i = 0; i < MAX_ZONES; i++) {
> > +			__u64 zone_addr;
> > +
> > +			if (i >= nr_zones)
> > +				break;
> > +
> > +			zone_addr = contig_page_data_addr + (sizeof_zone * i) + zone_off;
> > +			lock_addr = zone_addr + lock_off;
> > +
> > +			bpf_map_update_elem(&lock_syms, &lock_addr, &lock_flag, BPF_ANY);
> > +		}
> > +	} else if (nr_nodes > 0) {
> > +		struct pglist_data **node_data = (void *)(long)node_data_addr;
> > +
> > +		for (int i = 0; i < nr_nodes; i++) {
> > +			struct pglist_data *pgdat = NULL;
> > +			int err;
> > +
> > +			err = bpf_core_read(&pgdat, sizeof(pgdat), &node_data[i]);
> > +			if (err < 0 || pgdat == NULL)
> > +				break;
> > +
> > +			nr_zones = BPF_CORE_READ(pgdat, nr_zones);
> > +			for (int k = 0; k < MAX_ZONES; k++) {
> > +				__u64 zone_addr;
> > +
> > +				if (k >= nr_zones)
> > +					break;
> > +
> > +				zone_addr = (__u64)(void *)pgdat + (sizeof_zone * k) + zone_off;
> > +				lock_addr = zone_addr + lock_off;
> > +
> > +				bpf_map_update_elem(&lock_syms, &lock_addr, &lock_flag, BPF_ANY);
> > +			}
> > +		}
> > +	}
> > +}
> > +
> >  SEC("raw_tp/bpf_test_finish")
> >  int BPF_PROG(collect_lock_syms)
> >  {
> > @@ -830,6 +891,9 @@ int BPF_PROG(collect_lock_syms)
> >  		lock_flag = LOCK_CLASS_RQLOCK;
> >  		bpf_map_update_elem(&lock_syms, &lock_addr, &lock_flag, BPF_ANY);
> >  	}
> > +
> > +	collect_zone_lock();
> > +
> >  	return 0;
> >  }
> >  
> > diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
> > index 15f5743bd409f2f9..28c5e5aced7fcc91 100644
> > --- a/tools/perf/util/bpf_skel/lock_data.h
> > +++ b/tools/perf/util/bpf_skel/lock_data.h
> > @@ -67,6 +67,7 @@ enum lock_aggr_mode {
> >  enum lock_class_sym {
> >  	LOCK_CLASS_NONE,
> >  	LOCK_CLASS_RQLOCK,
> > +	LOCK_CLASS_ZONE_LOCK,
> >  };
> >  
> >  struct slab_cache_data {
> > diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > index 7b81d3173917fdb5..a59ce912be18cd0f 100644
> > --- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > +++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > @@ -203,4 +203,13 @@ struct bpf_iter__kmem_cache {
> >  	struct kmem_cache *s;
> >  } __attribute__((preserve_access_index));
> >  
> > +struct zone {
> > +	spinlock_t lock;
> > +} __attribute__((preserve_access_index));
> > +
> > +struct pglist_data {
> > +	struct zone node_zones[6]; /* value for all possible config */
> > +	int nr_zones;
> > +} __attribute__((preserve_access_index));
> > +
> >  #endif // __VMLINUX_H
> > diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
> > index b5d916aa49df6424..d331ce8e3caad4cb 100644
> > --- a/tools/perf/util/lock-contention.h
> > +++ b/tools/perf/util/lock-contention.h
> > @@ -142,6 +142,7 @@ struct lock_contention {
> >  	struct lock_filter *filters;
> >  	struct lock_contention_fails fails;
> >  	struct rb_root cgroups;
> > +	void *btf;
> >  	unsigned long map_nr_entries;
> >  	int max_stack;
> >  	int stack_skip;
> > -- 
> > 2.49.0
> > 

