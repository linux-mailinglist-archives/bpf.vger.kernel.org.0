Return-Path: <bpf+bounces-40535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91743989931
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 04:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3ACB1C211A7
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 02:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E6A17BA6;
	Mon, 30 Sep 2024 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu7jwEoZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD853AC;
	Mon, 30 Sep 2024 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727662691; cv=none; b=tgmox4vnL4pr+ycPcW5LFImdYwzGfJRlSeL7lGpaFJ71Yb5lETPr9PpFBEeQQGrFT/n4Y0zscVx2HeFqoTwQy8H75I2aBQ6bVkdXxVXatfep6pSRZhnteNOfhukDoLXjqk3lpf2q5y7piMfPBxZQLLkPxGbdURlniZ/iexT15r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727662691; c=relaxed/simple;
	bh=2053N4a8VkEzXJbWeWSR+BxbA+LoWzS7AnfahyYtpeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx0KJNg4kN14LIES+81yPrS45v3zcWweuSGg8wXaKH5ROwc9zZLxCT0yrRDzbQrcrr6WCANNox4jjzFJVj/AfXeMh1bSMEOvXJ5g5aV2D5yhutsVUnozoO5pPefSG8NBkz/T1TXbI0OS/b9RV0m0tGv0DwAJSXlm2jPQZ8g2LUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mu7jwEoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF08EC4CECE;
	Mon, 30 Sep 2024 02:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727662690;
	bh=2053N4a8VkEzXJbWeWSR+BxbA+LoWzS7AnfahyYtpeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mu7jwEoZ38Y5+VbAL83S0PJ4vSJFTlIpCpdtkU/w5EHrgh2gtDCd15rTiewA2R8vV
	 7eZT3lVHhDElc57/n/LcStn1UuHfpfwpIgXdC3lpa0fCkDqgjhKUghDuWhZaQJPoB2
	 OcY7hP01Xp2+XCHLEgPk9RzM9hWud0rOITVjXIH12k1aG2WgEHOaCWkoUKoIPWdS+S
	 E2G+r5Jqm6RhSP5c204p8+oapHfr2hzd+34ubut1dDzQLXMjGQdIrglyMR0O46MK/s
	 mzvAx1UNFwmZaeobkb5Ny6LK6qErIVtlvMVh8CjN+c3ibaOOkLy00/uSQ81Ytshtj+
	 fU2rMhdIcp+RA==
Date: Sun, 29 Sep 2024 19:18:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC/PATCH bpf-next 3/3] selftests/bpf: Add a test for
 kmem_cache_iter
Message-ID: <ZvoKYFEx9_h_6zyf@google.com>
References: <20240927184133.968283-1-namhyung@kernel.org>
 <20240927184133.968283-4-namhyung@kernel.org>
 <ZvjwEH3QXkjUCu8Z@google.com>
 <CAB=+i9Sm4UEhGy-jzsZEs1Q6KQCVdbnu_eAiRzXz=sRC-3H6Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB=+i9Sm4UEhGy-jzsZEs1Q6KQCVdbnu_eAiRzXz=sRC-3H6Uw@mail.gmail.com>

Hello Hyeonggon,

On Sun, Sep 29, 2024 at 11:27:25PM +0900, Hyeonggon Yoo wrote:
> On Sun, Sep 29, 2024 at 3:13 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Sep 27, 2024 at 11:41:33AM -0700, Namhyung Kim wrote:
> > > The test traverses all slab caches using the kmem_cache_iter and check
> > > if current task's pointer is from "task_struct" slab cache.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  .../bpf/prog_tests/kmem_cache_iter.c          | 64 ++++++++++++++++++
> > >  tools/testing/selftests/bpf/progs/bpf_iter.h  |  7 ++
> > >  .../selftests/bpf/progs/kmem_cache_iter.c     | 66 +++++++++++++++++++
> > >  3 files changed, 137 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> > > new file mode 100644
> > > index 0000000000000000..814bcc453e9f3ccd
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> > > @@ -0,0 +1,64 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2024 Google */
> > > +
> > > +#include <test_progs.h>
> > > +#include <bpf/libbpf.h>
> > > +#include <bpf/btf.h>
> > > +#include "kmem_cache_iter.skel.h"
> > > +
> > > +static void test_kmem_cache_iter_check_task(struct kmem_cache_iter *skel)
> > > +{
> > > +     LIBBPF_OPTS(bpf_test_run_opts, opts,
> > > +             .flags = BPF_F_TEST_RUN_ON_CPU,
> > > +     );
> > > +     int prog_fd = bpf_program__fd(skel->progs.check_task_struct);
> > > +
> > > +     /* get task_struct and check it if's from a slab cache */
> > > +     bpf_prog_test_run_opts(prog_fd, &opts);
> > > +
> > > +     /* the BPF program should set 'found' variable */
> > > +     ASSERT_EQ(skel->bss->found, 1, "found task_struct");
> >
> > Hmm.. I'm seeing a failure with found being -1, which means ...
> >
> > > +}
> > > +
> > > +void test_kmem_cache_iter(void)
> > > +{
> > > +     DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> > > +     struct kmem_cache_iter *skel = NULL;
> > > +     union bpf_iter_link_info linfo = {};
> > > +     struct bpf_link *link;
> > > +     char buf[1024];
> > > +     int iter_fd;
> > > +
> > > +     skel = kmem_cache_iter__open_and_load();
> > > +     if (!ASSERT_OK_PTR(skel, "kmem_cache_iter__open_and_load"))
> > > +             return;
> > > +
> > > +     opts.link_info = &linfo;
> > > +     opts.link_info_len = sizeof(linfo);
> > > +
> > > +     link = bpf_program__attach_iter(skel->progs.slab_info_collector, &opts);
> > > +     if (!ASSERT_OK_PTR(link, "attach_iter"))
> > > +             goto destroy;
> > > +
> > > +     iter_fd = bpf_iter_create(bpf_link__fd(link));
> > > +     if (!ASSERT_GE(iter_fd, 0, "iter_create"))
> > > +             goto free_link;
> > > +
> > > +     memset(buf, 0, sizeof(buf));
> > > +     while (read(iter_fd, buf, sizeof(buf) > 0)) {
> > > +             /* read out all contents */
> > > +             printf("%s", buf);
> > > +     }
> > > +
> > > +     /* next reads should return 0 */
> > > +     ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");
> > > +
> > > +     test_kmem_cache_iter_check_task(skel);
> > > +
> > > +     close(iter_fd);
> > > +
> > > +free_link:
> > > +     bpf_link__destroy(link);
> > > +destroy:
> > > +     kmem_cache_iter__destroy(skel);
> > > +}
> > > diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
> > > index c41ee80533ca219a..3305dc3a74b32481 100644
> > > --- a/tools/testing/selftests/bpf/progs/bpf_iter.h
> > > +++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
> > > @@ -24,6 +24,7 @@
> > >  #define BTF_F_PTR_RAW BTF_F_PTR_RAW___not_used
> > >  #define BTF_F_ZERO BTF_F_ZERO___not_used
> > >  #define bpf_iter__ksym bpf_iter__ksym___not_used
> > > +#define bpf_iter__kmem_cache bpf_iter__kmem_cache___not_used
> > >  #include "vmlinux.h"
> > >  #undef bpf_iter_meta
> > >  #undef bpf_iter__bpf_map
> > > @@ -48,6 +49,7 @@
> > >  #undef BTF_F_PTR_RAW
> > >  #undef BTF_F_ZERO
> > >  #undef bpf_iter__ksym
> > > +#undef bpf_iter__kmem_cache
> > >
> > >  struct bpf_iter_meta {
> > >       struct seq_file *seq;
> > > @@ -165,3 +167,8 @@ struct bpf_iter__ksym {
> > >       struct bpf_iter_meta *meta;
> > >       struct kallsym_iter *ksym;
> > >  };
> > > +
> > > +struct bpf_iter__kmem_cache {
> > > +     struct bpf_iter_meta *meta;
> > > +     struct kmem_cache *s;
> > > +} __attribute__((preserve_access_index));
> > > diff --git a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> > > new file mode 100644
> > > index 0000000000000000..3f6ec15a1bf6344c
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> > > @@ -0,0 +1,66 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/* Copyright (c) 2024 Google */
> > > +
> > > +#include "bpf_iter.h"
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +
> > > +char _license[] SEC("license") = "GPL";
> > > +
> > > +#define SLAB_NAME_MAX  256
> > > +
> > > +struct {
> > > +     __uint(type, BPF_MAP_TYPE_HASH);
> > > +     __uint(key_size, sizeof(void *));
> > > +     __uint(value_size, SLAB_NAME_MAX);
> > > +     __uint(max_entries, 1024);
> > > +} slab_hash SEC(".maps");
> > > +
> > > +extern struct kmem_cache *bpf_get_kmem_cache(__u64 addr) __ksym;
> > > +
> > > +/* result, will be checked by userspace */
> > > +int found;
> > > +
> > > +SEC("iter/kmem_cache")
> > > +int slab_info_collector(struct bpf_iter__kmem_cache *ctx)
> > > +{
> > > +     struct seq_file *seq = ctx->meta->seq;
> > > +     struct kmem_cache *s = ctx->s;
> > > +
> > > +     if (s) {
> > > +             char name[SLAB_NAME_MAX];
> > > +
> > > +             /*
> > > +              * To make sure if the slab_iter implements the seq interface
> > > +              * properly and it's also useful for debugging.
> > > +              */
> > > +             BPF_SEQ_PRINTF(seq, "%s: %u\n", s->name, s->object_size);
> > > +
> > > +             bpf_probe_read_kernel_str(name, sizeof(name), s->name);
> > > +             bpf_map_update_elem(&slab_hash, &s, name, BPF_NOEXIST);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +SEC("raw_tp/bpf_test_finish")
> > > +int BPF_PROG(check_task_struct)
> > > +{
> > > +     __u64 curr = bpf_get_current_task();
> > > +     struct kmem_cache *s;
> > > +     char *name;
> > > +
> > > +     s = bpf_get_kmem_cache(curr);
> > > +     if (s == NULL) {
> > > +             found = -1;
> > > +             return 0;
> >
> > ... it cannot find a kmem_cache for the current task.  This program is
> > run by bpf_prog_test_run_opts() with BPF_F_TEST_RUN_ON_CPU.  So I think
> > the curr should point a task_struct in a slab cache.
> >
> > Am I missing something?
> 
> Hi Namhyung,
> 
> Out of curiosity I've been investigating this issue on my machine and
> running some experiments.

Thanks a lot for looking at this!

> 
> When the test fails, calling dump_page() for the page the task_struct
> belongs to,
> shows that the page does not have the PGTY_slab flag set which is why
> virt_to_slab(current) returns NULL.
> 
> Does the test always fails on your environment? On my machine, the
> test passed sometimes but failed some times.

I'm using vmtest.sh but it succeeded mostly.  I thought I couldn't
reproduce it locally, but I also see the failure sometimes.  I'll take a
deeper look.

> 
> Maybe sometimes the value returned by 'current' macro belongs to a
> slab, but sometimes it does not.
> But that doesn't really make sense to me as IIUC task_struct
> descriptors are allocated from slab.

AFAIK the notable exception is the init_task which lives in the kernel
data.  I'm not sure the if the test is running by PID 1.

> 
> ....Or maybe some code can overwrote the page_type field of a slab?
> Hmm, it seems we need more information to identify what's gone wrong.

I doubt it's the case, but who knows? :)

> 
> Just FYI, adding the output of the following code snippet in
> bpf_get_kmem_cache():
> 
> pr_info("current = %llx\n", (unsigned long long)current);
> dump_page(virt_to_head_page(current), "virt_to_head_page()");

Thanks, I'll try this in my test too.
Namhyung

> 
> # When the test passes
> [  232.755028] current = ffff8ff5b9ebd200
> [  232.755031] page: refcount:1 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x139eb8
> [  232.755033] head: order:3 mapcount:0 entire_mapcount:0
> nr_pages_mapped:0 pincount:0
> [  232.755035] memcg:ffff8ff5b3ee0c01
> [  232.755037] ksm flags:
> 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
> [  232.755040] page_type: f5(slab)
> [  232.755042] raw: 0017ffffc0000040 ffff8ff58028ab00 ffffdaba05b8fc00
> dead000000000003
> [  232.755045] raw: 0000000000000000 0000000000030003 00000001f5000000
> ffff8ff5b3ee0c01
> [  232.755047] head: 0017ffffc0000040 ffff8ff58028ab00
> ffffdaba05b8fc00 dead000000000003
> [  232.755048] head: 0000000000000000 0000000000030003
> 00000001f5000000 ffff8ff5b3ee0c01
> [  232.755050] head: 0017ffffc0000003 ffffdaba04e7ae01
> ffffffffffffffff 0000000000000000
> [  232.755052] head: 0000000000000008 0000000000000000
> 00000000ffffffff 0000000000000000
> [  232.755053] page dumped because: virt_to_head_page()
> 
> # When the test fails
> [  130.811626] current = ffffffff884110c0
> [  130.811628] page: refcount:1 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x8a9411
> [  130.811632] flags:
> 0x17ffffc0002000(reserved|node=0|zone=2|lastcpupid=0x1fffff)
> [  130.811636] raw: 0017ffffc0002000 ffffdaba22a50448 ffffdaba22a50448
> 0000000000000000
> [  130.811639] raw: 0000000000000000 0000000000000000 00000001ffffffff
> 0000000000000000
> [  130.811641] page dumped because: virt_to_head_page()
> 
> Best,
> Hyeonggon
> 
> >
> > Thanks,
> > Namhyung
> >
> > > +     }
> > > +
> > > +     name = bpf_map_lookup_elem(&slab_hash, &s);
> > > +     if (name && !bpf_strncmp(name, 11, "task_struct"))
> > > +             found = 1;
> > > +     else
> > > +             found = -2;
> > > +
> > > +     return 0;
> > > +}
> > > --
> > > 2.46.1.824.gd892dcdcdd-goog
> > >

