Return-Path: <bpf+bounces-2194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD191728E7C
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 05:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2118B1C2108D
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 03:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54D91C39;
	Fri,  9 Jun 2023 03:19:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7F1C03
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 03:19:15 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2CD30F1;
	Thu,  8 Jun 2023 20:19:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b04706c974so3768145ad.2;
        Thu, 08 Jun 2023 20:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686280751; x=1688872751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3tNzE++EcYGnK4QRocvYBhYYoUc6HW5mKkfGV3A0RNo=;
        b=sgeQBC5Mb7MndGGyzLOYbHfGpnJqu8+OVbiAt0taGIE3yb837Wm9xx3JLjEV3+K9lc
         QTAJrkHUDgkQJgdzK28acqlz4XKI4MkN5LA3TQ8OT/ReN1zjGNXTtXGIoMvu2lyO6Es0
         L0KT/G94R9b6Hq5LBkbF/L52Wm/u/NWuRXY/GHBIznPcxi4GsP8XT5B+LqqjzM+0izVj
         LS8po2u7ndfFB8CtYcrnY85E7v2dHd4a+5jXHMmmoL357FNeTvyI0/961jWQKABPO0aD
         SnBZw4FWKaQWoRlQSEXaSI6o2/329a6EF/WgJPYV2r0rclWmvvCFAflcLdOgz5Po9Id5
         ME8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686280751; x=1688872751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tNzE++EcYGnK4QRocvYBhYYoUc6HW5mKkfGV3A0RNo=;
        b=ZoXA5ljqyWvbuCj1UQEPi+MaMFNZcgA0m3ExUpwtfLssQtUeUcWwJ7By39AmCnXV4F
         L3yqE8+mpLN/559khTXV7EwWXzKJ2lB3wBAgJz5PVhEhV6cmVqbLmdZKrDhvamJUAxWn
         SRIWVgBHRgUwNMYMypRXygW3L5RCC3S72paTEI2rwUnrc/sU31SSXMq9hoOAN32LOmT+
         gyzUvj+Mb+hK7O1sm0VaOeQhXte6GAUqXi6+ZZwGo2ZL3ssP/2R+13dO8vlXtN/SHpcG
         AdIW2YrVvekaBZzsyfWLFkeQ3J1LWpwo/pzVrQsuNjpIemwl6mmFlO8j6vpdsRH3YQ36
         iqjg==
X-Gm-Message-State: AC+VfDw5tGn6ajULn+X5egUD1K0U34zA0H8jpa2wN5Fv+Zh5b9RnXZW8
	3Bt7P7sCyhVJAUzDHt/truQ=
X-Google-Smtp-Source: ACHHUZ4RwRTdwNYGWAEr2F/Zzms7xXw87YMvP7/OcuxJDBtghZQy7DGYlc63rWHsf8qi/6DUOqMZLA==
X-Received: by 2002:a17:903:32cb:b0:1b0:3742:e732 with SMTP id i11-20020a17090332cb00b001b03742e732mr280450plr.23.1686280751454;
        Thu, 08 Jun 2023 20:19:11 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:cb35])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c20200b001aae909cfbbsm2108326pll.119.2023.06.08.20.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 20:19:11 -0700 (PDT)
Date: Thu, 8 Jun 2023 20:19:07 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	houtao1@huawei.com
Subject: Re: [PATCH bpf-next v5] selftests/bpf: Add benchmark for bpf memory
 allocator
Message-ID: <20230609031907.5yt7pnnynrawjzht@MacBook-Pro-8.local>
References: <20230609024030.2585058-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609024030.2585058-1-houtao@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 09, 2023 at 10:40:30AM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The benchmark could be used to compare the performance of hash map
> operations and the memory usage between different flavors of bpf memory
> allocator (e.g., no bpf ma vs bpf ma vs reuse-after-gp bpf ma). It also
> could be used to check the performance improvement or the memory saving
> provided by optimization.
> 
> The benchmark creates a non-preallocated hash map which uses bpf memory
> allocator and shows the operation performance and the memory usage of
> the hash map under different use cases:
> (1) no_op
> Only create the hash map and there is no operations on hash map. It is
> used as the baseline. When each CPU completes the iteration of 64
> elements in hash map, it increases the loop count.

I think this no_op is pointless. It cannot be compared to anything.
Please remove.

> (2) overwrite
> Each CPU overwrites nonoverlapping part of hash map. When each CPU
> completes overwriting of 64 elements in hash map, it increases the loop
> count.
> (3) batch_add_batch_del
> Each CPU adds then deletes nonoverlapping part of hash map in batch.
> When each CPU adds and deletes 64 elements in hash map, it increases the
> loop count.
> (4) add_del_on_diff_cpu
> Each two-CPUs pair adds and deletes nonoverlapping part of map
> cooperatively. When each pair adds and deletes 64 elements in hash map,
> the two-CPUs pair will increase the loop count.
> 
> The following is the benchmark results when comparing between different
> flavors of bpf memory allocator. These tests are conducted on a KVM guest
> with 8 CPUs and 16 GB memory. The command line below is used to do all
> the following benchmarks:
> 
>   ./bench htab-mem --use-case $name --max-entries 16384 ${OPTS} \
>           --full 50 -d 10 --producers=8 --prod-affinity=0-7
> 
> These results show:
> * preallocated case has both better performance and better memory
>   efficiency.
> * normal bpf memory doesn't handle add_del_on_diff_cpu very well. The
>   large memory usage is due to the slow tasks trace RCU grace period.
...
> | add_del_on_diff_cpu| 5.38      | 10.40               | 18.05            |

Doesn't handle well with 18Mbyte peak memory ?
I think it's the opposite.
rcu task trace and slab are handling it very well.

> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
> v5:
>  * send the benchmark patch alone (suggested by Alexei)
>  * limit the max number of touched elements per-bpf-program call to 64 (from Alexei)
>  * show per-producer performance (from Alexei)
>  * handle the return value of read() (from BPF CI)
>  * do cleanup_cgroup_environment() in htab_mem_report_final()
> 
> v4: https://lore.kernel.org/bpf/20230606035310.4026145-1-houtao@huaweicloud.com/
> 
>  tools/testing/selftests/bpf/Makefile          |   3 +
>  tools/testing/selftests/bpf/bench.c           |   4 +
>  .../selftests/bpf/benchs/bench_htab_mem.c     | 367 ++++++++++++++++++
>  .../bpf/benchs/run_bench_htab_mem.sh          |  42 ++
>  .../selftests/bpf/progs/htab_mem_bench.c      | 132 +++++++
>  5 files changed, 548 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_htab_mem.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
>  create mode 100644 tools/testing/selftests/bpf/progs/htab_mem_bench.c
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 538df8fb8c42..add018823ebd 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -644,11 +644,13 @@ $(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
>  $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o: $(OUTPUT)/local_storage_rcu_tasks_trace_bench.skel.h
>  $(OUTPUT)/bench_local_storage_create.o: $(OUTPUT)/bench_local_storage_create.skel.h
>  $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.h
> +$(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
>  $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
>  $(OUTPUT)/bench: LDLIBS += -lm
>  $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>  		 $(TESTING_HELPERS) \
>  		 $(TRACE_HELPERS) \
> +		 $(CGROUP_HELPERS) \
>  		 $(OUTPUT)/bench_count.o \
>  		 $(OUTPUT)/bench_rename.o \
>  		 $(OUTPUT)/bench_trigger.o \
> @@ -661,6 +663,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>  		 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o \
>  		 $(OUTPUT)/bench_bpf_hashmap_lookup.o \
>  		 $(OUTPUT)/bench_local_storage_create.o \
> +		 $(OUTPUT)/bench_htab_mem.o \
>  		 #
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> index d9c080ac1796..d3d9ae321b74 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -279,6 +279,7 @@ extern struct argp bench_local_storage_rcu_tasks_trace_argp;
>  extern struct argp bench_strncmp_argp;
>  extern struct argp bench_hashmap_lookup_argp;
>  extern struct argp bench_local_storage_create_argp;
> +extern struct argp bench_htab_mem_argp;
>  
>  static const struct argp_child bench_parsers[] = {
>  	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
> @@ -290,6 +291,7 @@ static const struct argp_child bench_parsers[] = {
>  		"local_storage RCU Tasks Trace slowdown benchmark", 0 },
>  	{ &bench_hashmap_lookup_argp, 0, "Hashmap lookup benchmark", 0 },
>  	{ &bench_local_storage_create_argp, 0, "local-storage-create benchmark", 0 },
> +	{ &bench_htab_mem_argp, 0, "hash map memory benchmark", 0 },
>  	{},
>  };
>  
> @@ -518,6 +520,7 @@ extern const struct bench bench_local_storage_cache_hashmap_control;
>  extern const struct bench bench_local_storage_tasks_trace;
>  extern const struct bench bench_bpf_hashmap_lookup;
>  extern const struct bench bench_local_storage_create;
> +extern const struct bench bench_htab_mem;
>  
>  static const struct bench *benchs[] = {
>  	&bench_count_global,
> @@ -559,6 +562,7 @@ static const struct bench *benchs[] = {
>  	&bench_local_storage_tasks_trace,
>  	&bench_bpf_hashmap_lookup,
>  	&bench_local_storage_create,
> +	&bench_htab_mem,
>  };
>  
>  static void find_benchmark(void)
> diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> new file mode 100644
> index 000000000000..e658a9f1ce3c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> @@ -0,0 +1,367 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
> +#include <argp.h>
> +#include <stdbool.h>
> +#include <pthread.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +
> +#include "bench.h"
> +#include "cgroup_helpers.h"
> +#include "htab_mem_bench.skel.h"
> +
> +static struct htab_mem_ctx {
> +	struct htab_mem_bench *skel;
> +	pthread_barrier_t *notify;
> +	int fd;
> +	int op_factor;
> +	bool do_notify_wait;
> +} ctx;
> +
> +static struct htab_mem_args {
> +	u32 max_entries;
> +	u32 value_size;
> +	u32 full;
> +	const char *use_case;
> +	bool preallocated;
> +} args = {
> +	.max_entries = 16384,
> +	.full = 50,
> +	.value_size = 8,
> +	.use_case = "overwrite",
> +	.preallocated = false,
> +};
> +
> +enum {
> +	ARG_MAX_ENTRIES = 10000,
> +	ARG_FULL_PERCENT = 10001,
> +	ARG_VALUE_SIZE = 10002,
> +	ARG_USE_CASE = 10003,
> +	ARG_PREALLOCATED = 10004,
> +};
> +
> +static const struct argp_option opts[] = {
> +	{ "max-entries", ARG_MAX_ENTRIES, "MAX_ENTRIES", 0,
> +	  "Set the max entries of hash map (default 16384)" },
> +	{ "full", ARG_FULL_PERCENT, "FULL", 0,
> +	  "Set the full percent of hash map (default 50)" },
> +	{ "value-size", ARG_VALUE_SIZE, "VALUE_SIZE", 0,
> +	  "Set the value size of hash map (default 8)" },
> +	{ "use-case", ARG_USE_CASE, "USE_CASE", 0,
> +	  "Set the use case of hash map: no_op|overwrite|batch_add_batch_del|add_del_on_diff_cpu" },
> +	{ "preallocated", ARG_PREALLOCATED, NULL, 0, "use preallocated hash map" },
> +	{},
> +};
> +
> +static error_t htab_mem_parse_arg(int key, char *arg, struct argp_state *state)
> +{
> +	switch (key) {
> +	case ARG_MAX_ENTRIES:
> +		args.max_entries = strtoul(arg, NULL, 10);
> +		break;
> +	case ARG_FULL_PERCENT:
> +		args.full = strtoul(arg, NULL, 10);
> +		if (!args.full || args.full > 100) {
> +			fprintf(stderr, "invalid full percent %u\n", args.full);
> +			argp_usage(state);
> +		}
> +		break;
> +	case ARG_VALUE_SIZE:
> +		args.value_size = strtoul(arg, NULL, 10);
> +		if (args.value_size > 4096) {
> +			fprintf(stderr, "too big value size %u\n", args.value_size);
> +			argp_usage(state);
> +		}
> +		break;
> +	case ARG_USE_CASE:
> +		args.use_case = strdup(arg);
> +		break;
> +	case ARG_PREALLOCATED:
> +		args.preallocated = true;
> +		break;
> +	default:
> +		return ARGP_ERR_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +const struct argp bench_htab_mem_argp = {
> +	.options = opts,
> +	.parser = htab_mem_parse_arg,
> +};
> +
> +static void htab_mem_validate(void)
> +{
> +	if (env.consumer_cnt != 1) {
> +		fprintf(stderr, "htab mem benchmark doesn't support multi-consumer!\n");
> +		exit(1);
> +	}
> +}
> +
> +static int setup_and_join_cgroup(const char *path)
> +{
> +	int err, fd;
> +
> +	err = setup_cgroup_environment();
> +	if (err) {
> +		fprintf(stderr, "setup cgroup env failed\n");
> +		return -1;
> +	}
> +
> +	err = create_and_get_cgroup(path);
> +	if (err < 0) {
> +		fprintf(stderr, "create cgroup %s failed\n", path);
> +		goto out;
> +	}
> +	fd = err;
> +
> +	err = join_cgroup(path);
> +	if (err) {
> +		fprintf(stderr, "join cgroup %s failed\n", path);
> +		close(fd);
> +		goto out;
> +	}
> +
> +	return fd;
> +out:
> +	cleanup_cgroup_environment();
> +	return -1;
> +}
> +
> +static int htab_mem_bench_init_barriers(void)
> +{
> +	unsigned int i, nr = (env.producer_cnt + 1) / 2;
> +	pthread_barrier_t *barriers;
> +
> +	barriers = calloc(nr, sizeof(*barriers));
> +	if (!barriers)
> +		return -1;
> +
> +	/* Used for synchronization between two threads */
> +	for (i = 0; i < nr; i++)
> +		pthread_barrier_init(&barriers[i], NULL, 2);
> +
> +	ctx.notify = barriers;
> +	return 0;
> +}
> +
> +static void htab_mem_bench_exit_barriers(void)
> +{
> +	unsigned int i, nr;
> +
> +	if (!ctx.notify)
> +		return;
> +
> +	nr = (env.producer_cnt + 1) / 2;
> +	for (i = 0; i < nr; i++)
> +		pthread_barrier_destroy(&ctx.notify[i]);
> +	free(ctx.notify);
> +}
> +
> +static void htab_mem_setup(void)
> +{
> +	struct bpf_program *prog;
> +	struct bpf_map *map;
> +	int err;
> +
> +	setup_libbpf();
> +
> +	err = setup_and_join_cgroup("/htab_mem");
> +	if (err < 0)
> +		exit(1);
> +	ctx.fd = err;
> +
> +	ctx.skel = htab_mem_bench__open();
> +	if (!ctx.skel) {
> +		fprintf(stderr, "failed to open skeleton\n");
> +		goto cleanup;
> +	}
> +
> +	err = htab_mem_bench_init_barriers();
> +	if (err) {
> +		fprintf(stderr, "failed to init barrier\n");
> +		goto cleanup;
> +	}
> +
> +	map = ctx.skel->maps.htab;
> +	bpf_map__set_max_entries(map, args.max_entries);
> +	bpf_map__set_value_size(map, args.value_size);
> +	if (args.preallocated)
> +		bpf_map__set_map_flags(map, bpf_map__map_flags(map) & ~BPF_F_NO_PREALLOC);
> +
> +	if (!strcmp("add_del_on_diff_cpu", args.use_case)) {
> +		/* Do synchronization between addition thread and deletion thread */
> +		ctx.do_notify_wait = true;
> +		/* Use two CPUs to do addition and deletion cooperatively */
> +		ctx.op_factor = 2;
> +	} else {
> +		ctx.op_factor = 1;
> +	}

Please remove op_factor and just do loop += 2 where necessary.

> +
> +	prog = bpf_object__find_program_by_name(ctx.skel->obj, args.use_case);
> +	if (!prog) {
> +		fprintf(stderr, "no such use-case: %s\n", args.use_case);
> +		fprintf(stderr, "available use case:");
> +		bpf_object__for_each_program(prog, ctx.skel->obj)
> +			fprintf(stderr, " %s", bpf_program__name(prog));
> +		fprintf(stderr, "\n");
> +		goto cleanup;
> +	}
> +	bpf_program__set_autoload(prog, true);
> +
> +	ctx.skel->bss->nr_thread = env.producer_cnt;
> +	ctx.skel->bss->nr_entries = (uint64_t)args.max_entries * args.full / 100;
> +
> +	err = htab_mem_bench__load(ctx.skel);
> +	if (err) {
> +		fprintf(stderr, "failed to load skeleton\n");
> +		goto cleanup;
> +	}
> +	err = htab_mem_bench__attach(ctx.skel);
> +	if (err) {
> +		fprintf(stderr, "failed to attach skeleton\n");
> +		goto cleanup;
> +	}
> +	return;
> +cleanup:
> +	close(ctx.fd);
> +	cleanup_cgroup_environment();
> +	htab_mem_bench_exit_barriers();
> +	htab_mem_bench__destroy(ctx.skel);
> +	exit(1);
> +}
> +
> +static void htab_mem_notify_wait_producer(pthread_barrier_t *notify)
> +{
> +	while (true) {
> +		(void)syscall(__NR_getpgid);
> +		/* Notify for start */
> +		pthread_barrier_wait(notify);
> +		/* Wait for completion */
> +		pthread_barrier_wait(notify);
> +	}
> +}
> +
> +static void htab_mem_wait_notify_producer(pthread_barrier_t *notify)
> +{
> +	while (true) {
> +		/* Wait for start */
> +		pthread_barrier_wait(notify);
> +		(void)syscall(__NR_getpgid);
> +		/* Notify for completion */
> +		pthread_barrier_wait(notify);
> +	}
> +}
> +
> +static void *htab_mem_producer(void *arg)
> +{
> +	pthread_barrier_t *notify;
> +	int seq;
> +
> +	if (!ctx.do_notify_wait) {
> +		while (true)
> +			(void)syscall(__NR_getpgid);
> +		return NULL;
> +	}
> +
> +	seq = (long)arg;
> +	notify = &ctx.notify[seq / 2];
> +	if (seq & 1)
> +		htab_mem_notify_wait_producer(notify);
> +	else
> +		htab_mem_wait_notify_producer(notify);
> +	return NULL;
> +}
> +
> +static void *htab_mem_consumer(void *arg)
> +{
> +	return NULL;
> +}
> +
> +static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
> +{
> +	char buf[32];
> +	ssize_t got;
> +	int fd;
> +
> +	fd = openat(ctx.fd, name, O_RDONLY);
> +	if (fd < 0) {
> +		/* cgroup v1 ? */
> +		fprintf(stderr, "no %s\n", name);
> +		*value = 0;
> +		return;
> +	}
> +
> +	got = read(fd, buf, sizeof(buf) - 1);
> +	if (got <= 0) {
> +		*value = 0;
> +		return;
> +	}
> +	buf[got] = 0;
> +
> +	*value = strtoull(buf, NULL, 0);
> +
> +	close(fd);
> +}
> +
> +static void htab_mem_measure(struct bench_res *res)
> +{
> +	res->hits = atomic_swap(&ctx.skel->bss->loop_cnt, 0) / env.producer_cnt / ctx.op_factor;
> +	htab_mem_read_mem_cgrp_file("memory.current", &res->gp_ct);
> +}
> +
> +static void htab_mem_report_progress(int iter, struct bench_res *res, long delta_ns)
> +{
> +	double loop, mem;
> +
> +	loop = res->hits / 1000.0 / (delta_ns / 1000000000.0);
> +	mem = res->gp_ct / 1048576.0;
> +	printf("Iter %3d (%7.3lfus): ", iter, (delta_ns - 1000000000) / 1000.0);
> +	printf("per-prod-op %7.2lfk/s, memory usage %7.2lfMiB\n", loop, mem);
> +}
> +
> +static void htab_mem_report_final(struct bench_res res[], int res_cnt)
> +{
> +	double mem_mean = 0.0, mem_stddev = 0.0;
> +	double loop_mean = 0.0, loop_stddev = 0.0;
> +	unsigned long peak_mem;
> +	int i;
> +
> +	cleanup_cgroup_environment();
> +
> +	for (i = 0; i < res_cnt; i++) {
> +		loop_mean += res[i].hits / 1000.0 / (0.0 + res_cnt);
> +		mem_mean += res[i].gp_ct / 1048576.0 / (0.0 + res_cnt);
> +	}
> +	if (res_cnt > 1)  {
> +		for (i = 0; i < res_cnt; i++) {
> +			loop_stddev += (loop_mean - res[i].hits / 1000.0) *
> +				       (loop_mean - res[i].hits / 1000.0) /
> +				       (res_cnt - 1.0);
> +			mem_stddev += (mem_mean - res[i].gp_ct / 1048576.0) *
> +				      (mem_mean - res[i].gp_ct / 1048576.0) /
> +				      (res_cnt - 1.0);
> +		}
> +		loop_stddev = sqrt(loop_stddev);
> +		mem_stddev = sqrt(mem_stddev);
> +	}
> +
> +	htab_mem_read_mem_cgrp_file("memory.peak", &peak_mem);
> +	printf("Summary: per-prod-op %7.2lf \u00B1 %7.2lfk/s, memory usage %7.2lf \u00B1 %7.2lfMiB,"
> +	       " peak memory usage %7.2lfMiB\n",
> +	       loop_mean, loop_stddev, mem_mean, mem_stddev, peak_mem / 1048576.0);
> +}
> +
> +const struct bench bench_htab_mem = {
> +	.name = "htab-mem",
> +	.argp = &bench_htab_mem_argp,
> +	.validate = htab_mem_validate,
> +	.setup = htab_mem_setup,
> +	.producer_thread = htab_mem_producer,
> +	.consumer_thread = htab_mem_consumer,
> +	.measure = htab_mem_measure,
> +	.report_progress = htab_mem_report_progress,
> +	.report_final = htab_mem_report_final,
> +};
> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh b/tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
> new file mode 100755
> index 000000000000..630c02f859cf
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_htab_mem.sh
> @@ -0,0 +1,42 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +source ./benchs/run_common.sh
> +
> +set -eufo pipefail
> +
> +htab_mem()
> +{
> +	echo -n "per-prod-op : "
> +	echo -n "$*" | sed -E "s/.* per-prod-op\s+([0-9]+\.[0-9]+ � [0-9]+\.[0-9]+k\/s).*/\1/"
> +	echo -n -e ", avg mem: "
> +	echo -n "$*" | sed -E "s/.* memory usage\s+([0-9]+\.[0-9]+ � [0-9]+\.[0-9]+MiB).*/\1/"
> +	echo -n ", peak mem: "
> +	echo "$*" | sed -E "s/.* peak memory usage\s+([0-9]+\.[0-9]+MiB).*/\1/"
> +}
> +
> +summarize_htab_mem()
> +{
> +	local bench="$1"
> +	local summary=$(echo $2 | tail -n1)
> +
> +	printf "%-20s %s\n" "$bench" "$(htab_mem $summary)"
> +}
> +
> +htab_mem_bench()
> +{
> +	local name
> +
> +	for name in no_op overwrite batch_add_batch_del add_del_on_diff_cpu
> +	do
> +		summarize_htab_mem "$name" "$(sudo ./bench htab-mem --use-case $name \
> +			--max-entries 16384 --full 50 -d 10 \

-d 10 is a default. why specify it?

> +			--producers=8 --prod-affinity=0-7 "$@")"

-a -p 8 should just work.
No need to pick specific cpus.

> +	done
> +}
> +
> +header "preallocated"
> +htab_mem_bench "--preallocated"
> +
> +header "normal bpf ma"
> +htab_mem_bench
> diff --git a/tools/testing/selftests/bpf/progs/htab_mem_bench.c b/tools/testing/selftests/bpf/progs/htab_mem_bench.c
> new file mode 100644
> index 000000000000..a1a5981df865
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/htab_mem_bench.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
> +#include <stdbool.h>
> +#include <errno.h>
> +#include <linux/types.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +struct update_ctx {
> +	unsigned int from;
> +	unsigned int step;
> +	unsigned int max;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(key_size, 4);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +} htab SEC(".maps");
> +
> +char _license[] SEC("license") = "GPL";
> +
> +unsigned char zeroed_value[4096];
> +unsigned int nr_entries = 0;
> +unsigned int nr_thread = 0;
> +long loop_cnt = 0;
> +
> +static int noop_htab(unsigned int i, struct update_ctx *ctx)
> +{
> +	if (ctx->from >= ctx->max)
> +		return 1;
> +
> +	ctx->from += ctx->step;
> +	return 0;
> +}
> +
> +static int write_htab(unsigned int i, struct update_ctx *ctx, unsigned int flags)
> +{
> +	if (ctx->from >= ctx->max)
> +		return 1;
> +
> +	bpf_map_update_elem(&htab, &ctx->from, zeroed_value, flags);
> +	ctx->from += ctx->step;
> +
> +	return 0;
> +}
> +
> +static int overwrite_htab(unsigned int i, struct update_ctx *ctx)
> +{
> +	return write_htab(i, ctx, 0);
> +}
> +
> +static int newwrite_htab(unsigned int i, struct update_ctx *ctx)
> +{
> +	return write_htab(i, ctx, BPF_NOEXIST);
> +}
> +
> +static int del_htab(unsigned int i, struct update_ctx *ctx)
> +{
> +	if (ctx->from >= ctx->max)
> +		return 1;
> +
> +	bpf_map_delete_elem(&htab, &ctx->from);
> +	ctx->from += ctx->step;
> +
> +	return 0;
> +}
> +
> +SEC("?tp/syscalls/sys_enter_getpgid")
> +int no_op(void *ctx)
> +{
> +	struct update_ctx update;
> +
> +	update.from = bpf_get_smp_processor_id();
> +	update.step = nr_thread;
> +	update.max = nr_entries;
> +	bpf_loop(64, noop_htab, &update, 0);
> +	__sync_fetch_and_add(&loop_cnt, 1);
> +
> +	return 0;
> +}
> +
> +SEC("?tp/syscalls/sys_enter_getpgid")
> +int overwrite(void *ctx)
> +{
> +	struct update_ctx update;
> +
> +	update.from = bpf_get_smp_processor_id();
> +	update.step = nr_thread;
> +	update.max = nr_entries;
> +	bpf_loop(64, overwrite_htab, &update, 0);

This is sloppy, since it makes --max_entries and --full arguments useless.
Either make them meaningful or hard code size of htab and remove these args.

> +	__sync_fetch_and_add(&loop_cnt, 1);
> +	return 0;
> +}
> +
> +SEC("?tp/syscalls/sys_enter_getpgid")
> +int batch_add_batch_del(void *ctx)
> +{
> +	struct update_ctx update;
> +
> +	update.from = bpf_get_smp_processor_id();
> +	update.step = nr_thread;
> +	update.max = nr_entries;
> +	bpf_loop(64, overwrite_htab, &update, 0);
> +
> +	update.from = bpf_get_smp_processor_id();
> +	bpf_loop(64, del_htab, &update, 0);
> +
> +	__sync_fetch_and_add(&loop_cnt, 1);

It probably should be loop_cnt += 2
because two map operations of 64 each are performed comparing to single
op of 64 in "overwrite".

> +	return 0;
> +}
> +
> +SEC("?tp/syscalls/sys_enter_getpgid")
> +int add_del_on_diff_cpu(void *ctx)
> +{
> +	struct update_ctx update;
> +	unsigned int from;
> +
> +	from = bpf_get_smp_processor_id();
> +	update.from = from / 2;
> +	update.step = nr_thread / 2;
> +	update.max = nr_entries;
> +
> +	if (from & 1)
> +		bpf_loop(64, newwrite_htab, &update, 0);
> +	else
> +		bpf_loop(64, del_htab, &update, 0);

op_factor=2 doesn't make sense here.
One cpu is doing map_update while another cpu is doing map_delete.
Both cpus are doing loop_cnt+=1.
It's fine to keep loop_cnt+=1 here and remove op_factor.

Also what happens if number of producers is odd?

The summary of all comments is please design this bench that it's:
1. realistic and tests something that can happen with real progs
2. combination of all knobs and flags is meaningful.

