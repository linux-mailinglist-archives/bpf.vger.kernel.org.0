Return-Path: <bpf+bounces-46427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ED99EA1B3
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 23:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62711886919
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2432519E985;
	Mon,  9 Dec 2024 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUrEENYQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9711319E96A;
	Mon,  9 Dec 2024 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733782600; cv=none; b=S2q0jKypRtfPnGtI/GLswdtPrko9ErzNrhYa1BtyZ58WjFFhK3S3O2hzJhCjH1Fvye4Uk6HVGhfQ+Z4JFH5C2lzHuyn0cJzfV7R3FbCTDS57UMwOGKx4n7V7xlqiBHaVGdU+5Y1DPQmFgw+9amvYiKiZuFYjwd40FLiZ2BTA1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733782600; c=relaxed/simple;
	bh=onWEC+E/OvyjxuQLUEr/DBSpPODfK5X7/PXcwijg9yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEb6tbMY3NyWUK+KcHGrVdi7mGzJEQ8Bdggu53CogMEVShvluvNty3jAiFkQMvHEcqduy+PKvCHkVDh+O96RUtcr7Zc1cKWkG3W69+awPbOgrRJWRb+td53PO2m1WwCWjA6szs496+VNbmwr0CeNpChAmXg1bPsHMaY/ppLZY8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUrEENYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA219C4CED1;
	Mon,  9 Dec 2024 22:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733782600;
	bh=onWEC+E/OvyjxuQLUEr/DBSpPODfK5X7/PXcwijg9yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUrEENYQ1Hz101bQFyPkz+wAsURBdWAjYtxi/n7p9F2CET3Jft4DjFTEroIYWDDZO
	 kujJYsjKfMNghxudSjZZPKLROhjf6vExL1eaLFCEkLog5eHZiYm2A3i76KJLsaNzZT
	 p4ceABKsjTxYRzNOkwoEEDav76ImGumd6am+hGJIH9fO5+iM4ZN5CwFqdUagTs6PjA
	 vC15KHNwzR/VbRpx3F7m/l9I9YG4Eju/5VUoegCDs7WERYy83VAHeEg8KJE4HwREht
	 EjsvGP0HU4zqj3OQwJ9m5tdV5bc6ur0SEGwbn8z/wFuJvXN5jSbI6UOxnFg1QpJ28V
	 rb1LzcW5yVs9w==
Date: Mon, 9 Dec 2024 14:16:38 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 2/4] perf lock contention: Run BPF slab cache iterator
Message-ID: <Z1dsRk-3RrZra39w@google.com>
References: <20241108061500.2698340-1-namhyung@kernel.org>
 <20241108061500.2698340-3-namhyung@kernel.org>
 <Z1ccoNOl4Z8c5DCz@x1>
 <Z1cdDzXe4QNJe8jL@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1cdDzXe4QNJe8jL@x1>

On Mon, Dec 09, 2024 at 01:38:39PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Dec 09, 2024 at 01:36:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Nov 07, 2024 at 10:14:57PM -0800, Namhyung Kim wrote:
> > > Recently the kernel got the kmem_cache iterator to traverse metadata of
> > > slab objects.  This can be used to symbolize dynamic locks in a slab.
> > > 
> > > The new slab_caches hash map will have the pointer of the kmem_cache as
> > > a key and save the name and a id.  The id will be saved in the flags
> > > part of the lock.
> > 
> > Trying to fix this 
> 
> So you have that struct in tools/perf/util/bpf_skel/vmlinux/vmlinux.h,
> but then, this kernel is old and doesn't have the kmem_cache iterator,
> so using the generated vmlinux.h will fail the build.

Thanks for checking this.  I think we handle compatibility issues by
checking BTF at runtime but this is a build-time issue. :(

I wonder if it's really needed to generate vmlinux.h for perf.  Can we
simply use the minimal vmlinux.h always?

Thanks,
Namhyung

>  
> > cd . && make GEN_VMLINUX_H=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.DWo9tIFvWU DESTDIR=/tmp/tmp.ex3iljqLBT
> >   BUILD:   Doing 'make -j28' parallel build
[...]
> >   GEN     /tmp/tmp.DWo9tIFvWU/util/bpf_skel/vmlinux.h
> >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
> >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bperf_leader.bpf.o
> >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bperf_follower.bpf.o
> >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
> >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/func_latency.bpf.o
> >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/off_cpu.bpf.o
> >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/lock_contention.bpf.o
> >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/kwork_trace.bpf.o
> >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/sample_filter.bpf.o
> >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/kwork_top.bpf.o
> >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/bench_uprobe.bpf.o
> >   CLANG   /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
> >   GENSKEL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/bench_uprobe.skel.h
> >   GENSKEL /tmp/tmp.DWo9tIFvWU/util/bpf_skel/func_latency.skel.h
> > util/bpf_skel/lock_contention.bpf.c:612:28: error: declaration of 'struct bpf_iter__kmem_cache' will not be visible outside of this function [-Werror,-Wvisibility]
> >   612 | int slab_cache_iter(struct bpf_iter__kmem_cache *ctx)
> >       |                            ^
> > util/bpf_skel/lock_contention.bpf.c:614:28: error: incomplete definition of type 'struct bpf_iter__kmem_cache'
> >   614 |         struct kmem_cache *s = ctx->s;
> >       |                                ~~~^
> > util/bpf_skel/lock_contention.bpf.c:612:28: note: forward declaration of 'struct bpf_iter__kmem_cache'
> >   612 | int slab_cache_iter(struct bpf_iter__kmem_cache *ctx)
> >       |                            ^
> > 2 errors generated.
> > make[4]: *** [Makefile.perf:1248: /tmp/tmp.DWo9tIFvWU/util/bpf_skel/.tmp/lock_contention.bpf.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> > make[3]: *** [Makefile.perf:292: sub-make] Error 2
> > make[2]: *** [Makefile:76: all] Error 2
> > make[1]: *** [tests/make:344: make_gen_vmlinux_h_O] Error 1
> > make: *** [Makefile:109: build-test] Error 2
> > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> > 
> > real	3m43.896s
> > user	29m30.716s
> > sys	6m36.609s
> > ⬢ [acme@toolbox perf-tools-next]$ 
> > 
> > 
> >  
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/bpf_lock_contention.c         | 50 +++++++++++++++++++
> > >  .../perf/util/bpf_skel/lock_contention.bpf.c  | 28 +++++++++++
> > >  tools/perf/util/bpf_skel/lock_data.h          | 12 +++++
> > >  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |  8 +++
> > >  4 files changed, 98 insertions(+)
> > > 
> > > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> > > index 41a1ad08789511c3..558590c3111390fc 100644
> > > --- a/tools/perf/util/bpf_lock_contention.c
> > > +++ b/tools/perf/util/bpf_lock_contention.c
> > > @@ -12,12 +12,59 @@
> > >  #include <linux/zalloc.h>
> > >  #include <linux/string.h>
> > >  #include <bpf/bpf.h>
> > > +#include <bpf/btf.h>
> > >  #include <inttypes.h>
> > >  
> > >  #include "bpf_skel/lock_contention.skel.h"
> > >  #include "bpf_skel/lock_data.h"
> > >  
> > >  static struct lock_contention_bpf *skel;
> > > +static bool has_slab_iter;
> > > +
> > > +static void check_slab_cache_iter(struct lock_contention *con)
> > > +{
> > > +	struct btf *btf = btf__load_vmlinux_btf();
> > > +	s32 ret;
> > > +
> > > +	if (btf == NULL) {
> > > +		pr_debug("BTF loading failed: %s\n", strerror(errno));
> > > +		return;
> > > +	}
> > > +
> > > +	ret = btf__find_by_name_kind(btf, "bpf_iter__kmem_cache", BTF_KIND_STRUCT);
> > > +	if (ret < 0) {
> > > +		bpf_program__set_autoload(skel->progs.slab_cache_iter, false);
> > > +		pr_debug("slab cache iterator is not available: %d\n", ret);
> > > +		goto out;
> > > +	}
> > > +
> > > +	has_slab_iter = true;
> > > +
> > > +	bpf_map__set_max_entries(skel->maps.slab_caches, con->map_nr_entries);
> > > +out:
> > > +	btf__free(btf);
> > > +}
> > > +
> > > +static void run_slab_cache_iter(void)
> > > +{
> > > +	int fd;
> > > +	char buf[256];
> > > +
> > > +	if (!has_slab_iter)
> > > +		return;
> > > +
> > > +	fd = bpf_iter_create(bpf_link__fd(skel->links.slab_cache_iter));
> > > +	if (fd < 0) {
> > > +		pr_debug("cannot create slab cache iter: %d\n", fd);
> > > +		return;
> > > +	}
> > > +
> > > +	/* This will run the bpf program */
> > > +	while (read(fd, buf, sizeof(buf)) > 0)
> > > +		continue;
> > > +
> > > +	close(fd);
> > > +}
> > >  
> > >  int lock_contention_prepare(struct lock_contention *con)
> > >  {
> > > @@ -109,6 +156,8 @@ int lock_contention_prepare(struct lock_contention *con)
> > >  			skel->rodata->use_cgroup_v2 = 1;
> > >  	}
> > >  
> > > +	check_slab_cache_iter(con);
> > > +
> > >  	if (lock_contention_bpf__load(skel) < 0) {
> > >  		pr_err("Failed to load lock-contention BPF skeleton\n");
> > >  		return -1;
> > > @@ -304,6 +353,7 @@ static void account_end_timestamp(struct lock_contention *con)
> > >  
> > >  int lock_contention_start(void)
> > >  {
> > > +	run_slab_cache_iter();
> > >  	skel->bss->enabled = 1;
> > >  	return 0;
> > >  }
> > > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > index 1069bda5d733887f..fd24ccb00faec0ba 100644
> > > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > @@ -100,6 +100,13 @@ struct {
> > >  	__uint(max_entries, 1);
> > >  } cgroup_filter SEC(".maps");
> > >  
> > > +struct {
> > > +	__uint(type, BPF_MAP_TYPE_HASH);
> > > +	__uint(key_size, sizeof(long));
> > > +	__uint(value_size, sizeof(struct slab_cache_data));
> > > +	__uint(max_entries, 1);
> > > +} slab_caches SEC(".maps");
> > > +
> > >  struct rw_semaphore___old {
> > >  	struct task_struct *owner;
> > >  } __attribute__((preserve_access_index));
> > > @@ -136,6 +143,8 @@ int perf_subsys_id = -1;
> > >  
> > >  __u64 end_ts;
> > >  
> > > +__u32 slab_cache_id;
> > > +
> > >  /* error stat */
> > >  int task_fail;
> > >  int stack_fail;
> > > @@ -563,4 +572,23 @@ int BPF_PROG(end_timestamp)
> > >  	return 0;
> > >  }
> > >  
> > > +SEC("iter/kmem_cache")
> > > +int slab_cache_iter(struct bpf_iter__kmem_cache *ctx)
> > > +{
> > > +	struct kmem_cache *s = ctx->s;
> > > +	struct slab_cache_data d;
> > > +
> > > +	if (s == NULL)
> > > +		return 0;
> > > +
> > > +	d.id = ++slab_cache_id << LCB_F_SLAB_ID_SHIFT;
> > > +	bpf_probe_read_kernel_str(d.name, sizeof(d.name), s->name);
> > > +
> > > +	if (d.id >= LCB_F_SLAB_ID_END)
> > > +		return 0;
> > > +
> > > +	bpf_map_update_elem(&slab_caches, &s, &d, BPF_NOEXIST);
> > > +	return 0;
> > > +}
> > > +
> > >  char LICENSE[] SEC("license") = "Dual BSD/GPL";
> > > diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
> > > index 4f0aae5483745dfa..c15f734d7fc4aecb 100644
> > > --- a/tools/perf/util/bpf_skel/lock_data.h
> > > +++ b/tools/perf/util/bpf_skel/lock_data.h
> > > @@ -32,9 +32,16 @@ struct contention_task_data {
> > >  #define LCD_F_MMAP_LOCK		(1U << 31)
> > >  #define LCD_F_SIGHAND_LOCK	(1U << 30)
> > >  
> > > +#define LCB_F_SLAB_ID_SHIFT	16
> > > +#define LCB_F_SLAB_ID_START	(1U << 16)
> > > +#define LCB_F_SLAB_ID_END	(1U << 26)
> > > +#define LCB_F_SLAB_ID_MASK	0x03FF0000U
> > > +
> > >  #define LCB_F_TYPE_MAX		(1U << 7)
> > >  #define LCB_F_TYPE_MASK		0x0000007FU
> > >  
> > > +#define SLAB_NAME_MAX  28
> > > +
> > >  struct contention_data {
> > >  	u64 total_time;
> > >  	u64 min_time;
> > > @@ -55,4 +62,9 @@ enum lock_class_sym {
> > >  	LOCK_CLASS_RQLOCK,
> > >  };
> > >  
> > > +struct slab_cache_data {
> > > +	u32 id;
> > > +	char name[SLAB_NAME_MAX];
> > > +};
> > > +
> > >  #endif /* UTIL_BPF_SKEL_LOCK_DATA_H */
> > > diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > > index 4dcad7b682bdee9c..7b81d3173917fdb5 100644
> > > --- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > > +++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > > @@ -195,4 +195,12 @@ struct bpf_perf_event_data_kern {
> > >   */
> > >  struct rq {};
> > >  
> > > +struct kmem_cache {
> > > +	const char *name;
> > > +} __attribute__((preserve_access_index));
> > > +
> > > +struct bpf_iter__kmem_cache {
> > > +	struct kmem_cache *s;
> > > +} __attribute__((preserve_access_index));
> > > +
> > >  #endif // __VMLINUX_H
> > > -- 
> > > 2.47.0.277.g8800431eea-goog

