Return-Path: <bpf+bounces-44286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9119C0E56
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 20:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC231C22A31
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 19:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AED2178E3;
	Thu,  7 Nov 2024 19:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OygUWNF7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E5621731F;
	Thu,  7 Nov 2024 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006290; cv=none; b=G0WMNvfCzXRi8ZkqMZE1JzOUo5r5bCwdJ2RPtozwsCk2W6QKQ7jN1zY1j4dlBwm3iofJz+A3bEfmKRfmK1G3gmqUyyBBF586fn9AhtQ5LimdrRrlLEgJPJ2BY/pKJUOatasmRC1xoEc8Gv0cTMse2lZ87rwb9Q9zH9trQjkkwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006290; c=relaxed/simple;
	bh=6qAvTWg1SHVPdbmrSCAWCMFZirajS79twV9QAJVcQUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/v+TK7zVU2mqnGkFy7Ef3mJRoFPvfaqMuBroSs+BpLb1oSiZxG7Vm0sceD/stFCafQWhnErcKYkXzIO0FSDhqtkM7fBNEAeV63U/fO/1NrqjxN9K9YgX8m41Rw3D4cp1f07zLox61GtmUoginjPjY/5Ul4E2QRhHrUSLEyB3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OygUWNF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B80C4CED0;
	Thu,  7 Nov 2024 19:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731006289;
	bh=6qAvTWg1SHVPdbmrSCAWCMFZirajS79twV9QAJVcQUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OygUWNF7NCWmtfyAqiNG+lZw2jet0eJiki9HzOjRBWCKV0pplNc2aAtkIYXf/slhw
	 x6XiWAyoFMqtA6TUxBLc8Fvo6Jr8kdx/s2OKOkeBlGR/pXickpceTF1x7rozdqOEN7
	 /KI6SpzErfatyS2L8GT6HdWUIxJR6RNWxaly32AFei/G7+VBN8QRInCXE4zRMZ5YzX
	 8sBoFpKnwkm4Nz2EY4YhT0KcK6PAJ/Lqy08YKsVH0aPS0t/BfLDFFHiNcb1yOoUEVI
	 I1Tw96HyeJUcF5SVsQA/rJL7g2oJynvvvqwPhaTl1M1pb0F46E/rCGMuJtjvzEdJEx
	 i9PrCQUTrutqQ==
Date: Thu, 7 Nov 2024 11:04:47 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Kees Cook <kees@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH 2/4] perf lock contention: Run BPF slab cache iterator
Message-ID: <Zy0PT0apgXWnBglI@google.com>
References: <20241105172635.2463800-1-namhyung@kernel.org>
 <20241105172635.2463800-3-namhyung@kernel.org>
 <CAEf4BzaL71O-odNtE88OwwZcVkRPw2uRaBgRAZYcoVo+G+38Mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaL71O-odNtE88OwwZcVkRPw2uRaBgRAZYcoVo+G+38Mg@mail.gmail.com>

Hello,

On Wed, Nov 06, 2024 at 11:36:19AM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 5, 2024 at 9:27 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Recently the kernel got the kmem_cache iterator to traverse metadata of
> > slab objects.  This can be used to symbolize dynamic locks in a slab.
> >
> > The new slab_caches hash map will have the pointer of the kmem_cache as
> > a key and save the name and a id.  The id will be saved in the flags
> > part of the lock.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/bpf_lock_contention.c         | 51 +++++++++++++++++++
> >  .../perf/util/bpf_skel/lock_contention.bpf.c  | 28 ++++++++++
> >  tools/perf/util/bpf_skel/lock_data.h          | 12 +++++
> >  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |  8 +++
> >  4 files changed, 99 insertions(+)
> >
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
> > index 41a1ad08789511c3..a2efd40897bad316 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> > @@ -12,12 +12,60 @@
> >  #include <linux/zalloc.h>
> >  #include <linux/string.h>
> >  #include <bpf/bpf.h>
> > +#include <bpf/btf.h>
> >  #include <inttypes.h>
> >
> >  #include "bpf_skel/lock_contention.skel.h"
> >  #include "bpf_skel/lock_data.h"
> >
> >  static struct lock_contention_bpf *skel;
> > +static bool has_slab_iter;
> > +
> > +static void check_slab_cache_iter(struct lock_contention *con)
> > +{
> > +       struct btf *btf = btf__load_vmlinux_btf();
> > +       s32 ret;
> > +
> > +       ret = libbpf_get_error(btf);
> 
> please don't use libbpf_get_error() in new code. I left that API for
> cases when user might want to support both per-1.0 libbpf and 1.0+,
> but by now I don't think you should be caring about <1.0 versions. And
> in 1.0+, you'll get btf == NULL on error, and errno will be set to
> error. So just check errno directly.

Oh, great.  I'll update the code like below.

	if (btf == NULL) {
		pr_debug("BTF loading failed: %s\n", strerror(errno));
		return;
	}

Thanks for your review,
Namhyung

> 
> > +       if (ret) {
> > +               pr_debug("BTF loading failed: %d\n", ret);
> > +               return;
> > +       }
> > +
> > +       ret = btf__find_by_name_kind(btf, "bpf_iter__kmem_cache", BTF_KIND_STRUCT);
> > +       if (ret < 0) {
> > +               bpf_program__set_autoload(skel->progs.slab_cache_iter, false);
> > +               pr_debug("slab cache iterator is not available: %d\n", ret);
> > +               goto out;
> > +       }
> > +
> > +       has_slab_iter = true;
> > +
> > +       bpf_map__set_max_entries(skel->maps.slab_caches, con->map_nr_entries);
> > +out:
> > +       btf__free(btf);
> > +}
> > +
> > +static void run_slab_cache_iter(void)
> > +{
> > +       int fd;
> > +       char buf[256];
> > +
> > +       if (!has_slab_iter)
> > +               return;
> > +
> > +       fd = bpf_iter_create(bpf_link__fd(skel->links.slab_cache_iter));
> > +       if (fd < 0) {
> > +               pr_debug("cannot create slab cache iter: %d\n", fd);
> > +               return;
> > +       }
> > +
> > +       /* This will run the bpf program */
> > +       while (read(fd, buf, sizeof(buf)) > 0)
> > +               continue;
> > +
> > +       close(fd);
> > +}
> >
> >  int lock_contention_prepare(struct lock_contention *con)
> >  {
> > @@ -109,6 +157,8 @@ int lock_contention_prepare(struct lock_contention *con)
> >                         skel->rodata->use_cgroup_v2 = 1;
> >         }
> >
> > +       check_slab_cache_iter(con);
> > +
> >         if (lock_contention_bpf__load(skel) < 0) {
> >                 pr_err("Failed to load lock-contention BPF skeleton\n");
> >                 return -1;
> > @@ -304,6 +354,7 @@ static void account_end_timestamp(struct lock_contention *con)
> >
> >  int lock_contention_start(void)
> >  {
> > +       run_slab_cache_iter();
> >         skel->bss->enabled = 1;
> >         return 0;
> >  }
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > index 1069bda5d733887f..fd24ccb00faec0ba 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -100,6 +100,13 @@ struct {
> >         __uint(max_entries, 1);
> >  } cgroup_filter SEC(".maps");
> >
> > +struct {
> > +       __uint(type, BPF_MAP_TYPE_HASH);
> > +       __uint(key_size, sizeof(long));
> > +       __uint(value_size, sizeof(struct slab_cache_data));
> > +       __uint(max_entries, 1);
> > +} slab_caches SEC(".maps");
> > +
> >  struct rw_semaphore___old {
> >         struct task_struct *owner;
> >  } __attribute__((preserve_access_index));
> > @@ -136,6 +143,8 @@ int perf_subsys_id = -1;
> >
> >  __u64 end_ts;
> >
> > +__u32 slab_cache_id;
> > +
> >  /* error stat */
> >  int task_fail;
> >  int stack_fail;
> > @@ -563,4 +572,23 @@ int BPF_PROG(end_timestamp)
> >         return 0;
> >  }
> >
> > +SEC("iter/kmem_cache")
> > +int slab_cache_iter(struct bpf_iter__kmem_cache *ctx)
> > +{
> > +       struct kmem_cache *s = ctx->s;
> > +       struct slab_cache_data d;
> > +
> > +       if (s == NULL)
> > +               return 0;
> > +
> > +       d.id = ++slab_cache_id << LCB_F_SLAB_ID_SHIFT;
> > +       bpf_probe_read_kernel_str(d.name, sizeof(d.name), s->name);
> > +
> > +       if (d.id >= LCB_F_SLAB_ID_END)
> > +               return 0;
> > +
> > +       bpf_map_update_elem(&slab_caches, &s, &d, BPF_NOEXIST);
> > +       return 0;
> > +}
> > +
> >  char LICENSE[] SEC("license") = "Dual BSD/GPL";
> > diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
> > index 4f0aae5483745dfa..c15f734d7fc4aecb 100644
> > --- a/tools/perf/util/bpf_skel/lock_data.h
> > +++ b/tools/perf/util/bpf_skel/lock_data.h
> > @@ -32,9 +32,16 @@ struct contention_task_data {
> >  #define LCD_F_MMAP_LOCK                (1U << 31)
> >  #define LCD_F_SIGHAND_LOCK     (1U << 30)
> >
> > +#define LCB_F_SLAB_ID_SHIFT    16
> > +#define LCB_F_SLAB_ID_START    (1U << 16)
> > +#define LCB_F_SLAB_ID_END      (1U << 26)
> > +#define LCB_F_SLAB_ID_MASK     0x03FF0000U
> > +
> >  #define LCB_F_TYPE_MAX         (1U << 7)
> >  #define LCB_F_TYPE_MASK                0x0000007FU
> >
> > +#define SLAB_NAME_MAX  28
> > +
> >  struct contention_data {
> >         u64 total_time;
> >         u64 min_time;
> > @@ -55,4 +62,9 @@ enum lock_class_sym {
> >         LOCK_CLASS_RQLOCK,
> >  };
> >
> > +struct slab_cache_data {
> > +       u32 id;
> > +       char name[SLAB_NAME_MAX];
> > +};
> > +
> >  #endif /* UTIL_BPF_SKEL_LOCK_DATA_H */
> > diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > index 4dcad7b682bdee9c..7b81d3173917fdb5 100644
> > --- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > +++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
> > @@ -195,4 +195,12 @@ struct bpf_perf_event_data_kern {
> >   */
> >  struct rq {};
> >
> > +struct kmem_cache {
> > +       const char *name;
> > +} __attribute__((preserve_access_index));
> > +
> > +struct bpf_iter__kmem_cache {
> > +       struct kmem_cache *s;
> > +} __attribute__((preserve_access_index));
> > +
> >  #endif // __VMLINUX_H
> > --
> > 2.47.0.199.ga7371fff76-goog
> >
> >

