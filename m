Return-Path: <bpf+bounces-40477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 893EE98933E
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 08:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253A81F23B91
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 06:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E41A1386B4;
	Sun, 29 Sep 2024 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5UUxHGt"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78F018EB0;
	Sun, 29 Sep 2024 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727590421; cv=none; b=LsJYAgSdDF7mG/gOsO0wrvtaIILarlY5+KcYcozsMPzMhFNZ8WdNo/4HdiqT6FGXinHHkZoof0rbO8ckwRdDcJ5osQEkXpbYM/6B1zKXnY45Nk0k4e82CSl2FLMLGW/GsAKxJ1ihmWOAdQg4K3W6II43cZU6nUPhhDPQxpv9g0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727590421; c=relaxed/simple;
	bh=K1yicp/bGL8F91qvGqt+1UnHa6FWbR1s/iEvXrsN5Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqZEoEq72X+uylT48ne8BwsH+3E2OzN6q108OsP3z7TAan3rrheGzrRpNBsCwx0pTl8Wnn7oeXaJde3T+u4wrF+S6HlWDnYfUoPsp51rhkqjRB9LSTp/LjLrd7BsnOMghQNbzVSKAtveaA5mi2TWGu+i91nB01h0CyzDah3LLbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5UUxHGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735A2C4CEC5;
	Sun, 29 Sep 2024 06:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727590421;
	bh=K1yicp/bGL8F91qvGqt+1UnHa6FWbR1s/iEvXrsN5Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5UUxHGtQUu638bUVVX5IG9DsMPkLZUmJZiPMaqKExcUqR5Fz4Y78JcuP18aepHLt
	 7LLcI8R/WB4W2YFQpBlTJzUNyrpPXsRkvobrNE3N58HlwdRe17mwuc64Kqx/z6AVcE
	 LevWQHqsImQz4eBPle2PF4HIarw6LD8IcqARcMT7LiCNVlRAB603QlGTprA3fawx7E
	 ab5ppjgaEz1tMahm4x/F3OcuWaLUrtQodj7qpzUSreLt2YZlbVFm2PtXDMT98EeKB0
	 Ta3XM3Hx1uQfv3PWmCH0HD5piAxRZpEaMWfCM1+upWppKW8qEqY6SXl2WKQTv6kf3+
	 ap0ylKZkjX4IA==
Date: Sat, 28 Sep 2024 23:13:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
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
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC/PATCH bpf-next 3/3] selftests/bpf: Add a test for
 kmem_cache_iter
Message-ID: <ZvjwEH3QXkjUCu8Z@google.com>
References: <20240927184133.968283-1-namhyung@kernel.org>
 <20240927184133.968283-4-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927184133.968283-4-namhyung@kernel.org>

On Fri, Sep 27, 2024 at 11:41:33AM -0700, Namhyung Kim wrote:
> The test traverses all slab caches using the kmem_cache_iter and check
> if current task's pointer is from "task_struct" slab cache.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  .../bpf/prog_tests/kmem_cache_iter.c          | 64 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/bpf_iter.h  |  7 ++
>  .../selftests/bpf/progs/kmem_cache_iter.c     | 66 +++++++++++++++++++
>  3 files changed, 137 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
>  create mode 100644 tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> new file mode 100644
> index 0000000000000000..814bcc453e9f3ccd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Google */
> +
> +#include <test_progs.h>
> +#include <bpf/libbpf.h>
> +#include <bpf/btf.h>
> +#include "kmem_cache_iter.skel.h"
> +
> +static void test_kmem_cache_iter_check_task(struct kmem_cache_iter *skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		.flags = BPF_F_TEST_RUN_ON_CPU,
> +	);
> +	int prog_fd = bpf_program__fd(skel->progs.check_task_struct);
> +
> +	/* get task_struct and check it if's from a slab cache */
> +	bpf_prog_test_run_opts(prog_fd, &opts);
> +
> +	/* the BPF program should set 'found' variable */
> +	ASSERT_EQ(skel->bss->found, 1, "found task_struct");

Hmm.. I'm seeing a failure with found being -1, which means ...

> +}
> +
> +void test_kmem_cache_iter(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	struct kmem_cache_iter *skel = NULL;
> +	union bpf_iter_link_info linfo = {};
> +	struct bpf_link *link;
> +	char buf[1024];
> +	int iter_fd;
> +
> +	skel = kmem_cache_iter__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "kmem_cache_iter__open_and_load"))
> +		return;
> +
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	link = bpf_program__attach_iter(skel->progs.slab_info_collector, &opts);
> +	if (!ASSERT_OK_PTR(link, "attach_iter"))
> +		goto destroy;
> +
> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_GE(iter_fd, 0, "iter_create"))
> +		goto free_link;
> +
> +	memset(buf, 0, sizeof(buf));
> +	while (read(iter_fd, buf, sizeof(buf) > 0)) {
> +		/* read out all contents */
> +		printf("%s", buf);
> +	}
> +
> +	/* next reads should return 0 */
> +	ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");
> +
> +	test_kmem_cache_iter_check_task(skel);
> +
> +	close(iter_fd);
> +
> +free_link:
> +	bpf_link__destroy(link);
> +destroy:
> +	kmem_cache_iter__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter.h b/tools/testing/selftests/bpf/progs/bpf_iter.h
> index c41ee80533ca219a..3305dc3a74b32481 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter.h
> @@ -24,6 +24,7 @@
>  #define BTF_F_PTR_RAW BTF_F_PTR_RAW___not_used
>  #define BTF_F_ZERO BTF_F_ZERO___not_used
>  #define bpf_iter__ksym bpf_iter__ksym___not_used
> +#define bpf_iter__kmem_cache bpf_iter__kmem_cache___not_used
>  #include "vmlinux.h"
>  #undef bpf_iter_meta
>  #undef bpf_iter__bpf_map
> @@ -48,6 +49,7 @@
>  #undef BTF_F_PTR_RAW
>  #undef BTF_F_ZERO
>  #undef bpf_iter__ksym
> +#undef bpf_iter__kmem_cache
>  
>  struct bpf_iter_meta {
>  	struct seq_file *seq;
> @@ -165,3 +167,8 @@ struct bpf_iter__ksym {
>  	struct bpf_iter_meta *meta;
>  	struct kallsym_iter *ksym;
>  };
> +
> +struct bpf_iter__kmem_cache {
> +	struct bpf_iter_meta *meta;
> +	struct kmem_cache *s;
> +} __attribute__((preserve_access_index));
> diff --git a/tools/testing/selftests/bpf/progs/kmem_cache_iter.c b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> new file mode 100644
> index 0000000000000000..3f6ec15a1bf6344c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kmem_cache_iter.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Google */
> +
> +#include "bpf_iter.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#define SLAB_NAME_MAX  256
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, sizeof(void *));
> +	__uint(value_size, SLAB_NAME_MAX);
> +	__uint(max_entries, 1024);
> +} slab_hash SEC(".maps");
> +
> +extern struct kmem_cache *bpf_get_kmem_cache(__u64 addr) __ksym;
> +
> +/* result, will be checked by userspace */
> +int found;
> +
> +SEC("iter/kmem_cache")
> +int slab_info_collector(struct bpf_iter__kmem_cache *ctx)
> +{
> +	struct seq_file *seq = ctx->meta->seq;
> +	struct kmem_cache *s = ctx->s;
> +
> +	if (s) {
> +		char name[SLAB_NAME_MAX];
> +
> +		/*
> +		 * To make sure if the slab_iter implements the seq interface
> +		 * properly and it's also useful for debugging.
> +		 */
> +		BPF_SEQ_PRINTF(seq, "%s: %u\n", s->name, s->object_size);
> +
> +		bpf_probe_read_kernel_str(name, sizeof(name), s->name);
> +		bpf_map_update_elem(&slab_hash, &s, name, BPF_NOEXIST);
> +	}
> +
> +	return 0;
> +}
> +
> +SEC("raw_tp/bpf_test_finish")
> +int BPF_PROG(check_task_struct)
> +{
> +	__u64 curr = bpf_get_current_task();
> +	struct kmem_cache *s;
> +	char *name;
> +
> +	s = bpf_get_kmem_cache(curr);
> +	if (s == NULL) {
> +		found = -1;
> +		return 0;

... it cannot find a kmem_cache for the current task.  This program is
run by bpf_prog_test_run_opts() with BPF_F_TEST_RUN_ON_CPU.  So I think
the curr should point a task_struct in a slab cache.

Am I missing something?

Thanks,
Namhyung

> +	}
> +
> +	name = bpf_map_lookup_elem(&slab_hash, &s);
> +	if (name && !bpf_strncmp(name, 11, "task_struct"))
> +		found = 1;
> +	else
> +		found = -2;
> +
> +	return 0;
> +}
> -- 
> 2.46.1.824.gd892dcdcdd-goog
> 

