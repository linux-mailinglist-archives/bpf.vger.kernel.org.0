Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4466EBC58
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 03:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDWBzh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Apr 2023 21:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDWBzg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Apr 2023 21:55:36 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AD51728;
        Sat, 22 Apr 2023 18:55:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q3rv252g8z4f43Fj;
        Sun, 23 Apr 2023 09:55:26 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgD3Yi0MkERkgefoHQ--.46625S2;
        Sun, 23 Apr 2023 09:55:27 +0800 (CST)
Subject: Re: [RFC bpf-next v2 1/4] selftests/bpf: Add benchmark for bpf memory
 allocator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
References: <20230408141846.1878768-1-houtao@huaweicloud.com>
 <20230408141846.1878768-2-houtao@huaweicloud.com>
 <20230422025930.fwoodzn6jlqe2jt5@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <6887e058-45e5-bbec-088a-ebc43bb066c9@huaweicloud.com>
Date:   Sun, 23 Apr 2023 09:55:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230422025930.fwoodzn6jlqe2jt5@dhcp-172-26-102-232.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgD3Yi0MkERkgefoHQ--.46625S2
X-Coremail-Antispam: 1UD129KBjvAXoWfurW3Wr4rtF1DJr1kCrWrAFb_yoW8Zw4kXo
        WfGr4xJr1xXryjqryUKa4ktw1fuF1kKr1UZ3W8J3ZxJF10yayY9F1UCw4fAF4fWFW3Kw47
        XFZ7t34rAFWkW3Z5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
        rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
        IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI
        62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
        ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 4/22/2023 10:59 AM, Alexei Starovoitov wrote:
> On Sat, Apr 08, 2023 at 10:18:43PM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> The benchmark could be used to compare the performance of hash map
>> operations and the memory usage between different flavors of bpf memory
>> allocator (e.g., no bpf ma vs bpf ma vs reuse-after-gp bpf ma). It also
>> could be used to check the performance improvement or the memory saving
>> of bpf memory allocator optimization and check whether or not a specific
>> use case is suitable for bpf memory allocator.
>>
>> The benchmark creates a non-preallocated hash map which uses bpf memory
>> allocator and shows the operation performance and the memory usage of
>> the hash map under different use cases:
>> (1) no_op
>> Only create the hash map and there is no operations on hash map. It is
>> used as the baseline. When each CPUs complete the iteartion of
>> nonoverlapping part of hash map, the loop count is increased.
>> (2) overwrite
>> Each CPU overwrites nonoverlapping part of hash map. When each CPU
>> completes one round of iteration, the loop count is increased.
>> (3) batch_add_batch_del
>> Each CPU adds then deletes nonoverlapping part of hash map in batch.
>> When each CPU completes one round of iteration, the loop count is
>> increased.
>> (4) add_del_on_diff_cpu
>> Each two CPUs add and delete nonoverlapping part of map concurrently.
>> When each CPU completes one round of iteration, the loop count is
>> increased.
>>
>> The following benchmark results show that bpf memory allocator doesn't
>> handle add_del_on_diff_cpu scenario very well. Because map deletion
>> always happen on a different CPU than the map addition and the freed
>> memory can never be reused.
> what do you mean "can never be reused" ?
> bpf_ma frees back to slab when num of elems in per-cpu freelist
> is above watermark.
Yes,  the above saying is inaccurate. I should say: the freed element can never
be immediately-reused and these elements are only available for reuse after
freeing to slab subsystem.
>
>> ./bench htab-mem --use-case $name --max-entries 16384 \
>> 	--full 50 -d 7 -w 3 --producers=8 --prod-affinity=0-7
>>
>> | name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
>> | --                  | --         | --                   | --                |
>> | no_op               | 1129       | 1.15                 | 1.15              |
>> | overwrite           | 24.37      | 2.07                 | 2.97              |
>> | batch_add_batch_del | 10.58      | 2.91                 | 3.36              |
>> | add_del_on_diff_cpu | 13.14      | 380.66               | 633.99            |
> large mem for diff_cpu case needs to be investigated.
The main reason is that tasks-trace RCU GP is slow and there is only one
inflight free callback, so the CPUs which only do element addition will allocate
new memory from slab continuously and the CPUs which only do element deletion
will free these elements continuously through call_tasks_trace_rcu(), but due to
the slowness of tasks-trace RCU GP, these freed elements could not be freed back
to slab subsystem timely.

I am trying to mitigate the problem by using multiple inflight free RCU
callback, but the result doesn't lookup very good and I'm still digging into it.
If it doesn't work out, maybe stealing from free_list of other CPUs is an
alternative option.
>
>> ./bench htab-mem --preallocated --use-case $name --max-entries 16384 \
>> 	--full 50 -d 7 -w 3 --producers=8 --prod-affinity=0-7
>>
>> | name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
>> | --                  | --         | --                   | --                |
>> | no_op               | 1195       | 2.11                 | 2.16              |
>> | overwrite           | 34.02      | 1.96                 | 2.00              |
>> | batch_add_batch_del | 19.25      | 1.96                 | 2.00              |
>> | add_del_on_diff_cpu | 8.70       | 1.96                 | 2.00              |
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  tools/testing/selftests/bpf/Makefile          |   3 +
>>  tools/testing/selftests/bpf/bench.c           |   4 +
>>  .../selftests/bpf/benchs/bench_htab_mem.c     | 273 ++++++++++++++++++
>>  .../selftests/bpf/progs/htab_mem_bench.c      | 145 ++++++++++
>>  4 files changed, 425 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_htab_mem.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/htab_mem_bench.c
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index c02184eaae69..74a45c790d4a 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -647,11 +647,13 @@ $(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
>>  $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o: $(OUTPUT)/local_storage_rcu_tasks_trace_bench.skel.h
>>  $(OUTPUT)/bench_local_storage_create.o: $(OUTPUT)/bench_local_storage_create.skel.h
>>  $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.h
>> +$(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
>>  $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
>>  $(OUTPUT)/bench: LDLIBS += -lm
>>  $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>>  		 $(TESTING_HELPERS) \
>>  		 $(TRACE_HELPERS) \
>> +		 $(CGROUP_HELPERS) \
>>  		 $(OUTPUT)/bench_count.o \
>>  		 $(OUTPUT)/bench_rename.o \
>>  		 $(OUTPUT)/bench_trigger.o \
>> @@ -664,6 +666,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>>  		 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o \
>>  		 $(OUTPUT)/bench_bpf_hashmap_lookup.o \
>>  		 $(OUTPUT)/bench_local_storage_create.o \
>> +		 $(OUTPUT)/bench_htab_mem.o \
>>  		 #
>>  	$(call msg,BINARY,,$@)
>>  	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
>> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
>> index d9c080ac1796..d3d9ae321b74 100644
>> --- a/tools/testing/selftests/bpf/bench.c
>> +++ b/tools/testing/selftests/bpf/bench.c
>> @@ -279,6 +279,7 @@ extern struct argp bench_local_storage_rcu_tasks_trace_argp;
>>  extern struct argp bench_strncmp_argp;
>>  extern struct argp bench_hashmap_lookup_argp;
>>  extern struct argp bench_local_storage_create_argp;
>> +extern struct argp bench_htab_mem_argp;
>>  
>>  static const struct argp_child bench_parsers[] = {
>>  	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
>> @@ -290,6 +291,7 @@ static const struct argp_child bench_parsers[] = {
>>  		"local_storage RCU Tasks Trace slowdown benchmark", 0 },
>>  	{ &bench_hashmap_lookup_argp, 0, "Hashmap lookup benchmark", 0 },
>>  	{ &bench_local_storage_create_argp, 0, "local-storage-create benchmark", 0 },
>> +	{ &bench_htab_mem_argp, 0, "hash map memory benchmark", 0 },
>>  	{},
>>  };
>>  
>> @@ -518,6 +520,7 @@ extern const struct bench bench_local_storage_cache_hashmap_control;
>>  extern const struct bench bench_local_storage_tasks_trace;
>>  extern const struct bench bench_bpf_hashmap_lookup;
>>  extern const struct bench bench_local_storage_create;
>> +extern const struct bench bench_htab_mem;
>>  
>>  static const struct bench *benchs[] = {
>>  	&bench_count_global,
>> @@ -559,6 +562,7 @@ static const struct bench *benchs[] = {
>>  	&bench_local_storage_tasks_trace,
>>  	&bench_bpf_hashmap_lookup,
>>  	&bench_local_storage_create,
>> +	&bench_htab_mem,
>>  };
>>  
>>  static void find_benchmark(void)
>> diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
>> new file mode 100644
>> index 000000000000..116821a2a7dd
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
>> @@ -0,0 +1,273 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
>> +#include <argp.h>
>> +#include <stdbool.h>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <fcntl.h>
>> +
>> +#include "bench.h"
>> +#include "cgroup_helpers.h"
>> +#include "htab_mem_bench.skel.h"
>> +
>> +static struct htab_mem_ctx {
>> +	struct htab_mem_bench *skel;
>> +	int fd;
>> +} ctx;
>> +
>> +static struct htab_mem_args {
>> +	u32 max_entries;
>> +	u32 value_size;
>> +	u32 full;
>> +	const char *use_case;
>> +	bool preallocated;
>> +} args = {
>> +	.max_entries = 16384,
>> +	.full = 50,
>> +	.value_size = 8,
>> +	.use_case = "overwrite",
>> +	.preallocated = false,
>> +};
>> +
>> +enum {
>> +	ARG_MAX_ENTRIES = 10000,
>> +	ARG_FULL_PERCENT = 10001,
>> +	ARG_VALUE_SIZE = 10002,
>> +	ARG_USE_CASE = 10003,
>> +	ARG_PREALLOCATED = 10004,
>> +};
>> +
>> +static const struct argp_option opts[] = {
>> +	{ "max-entries", ARG_MAX_ENTRIES, "MAX_ENTRIES", 0,
>> +	  "Set the max entries of hash map (default 16384)" },
>> +	{ "full", ARG_FULL_PERCENT, "FULL", 0,
>> +	  "Set the full percent of hash map (default 50)" },
>> +	{ "value-size", ARG_VALUE_SIZE, "VALUE_SIZE", 0,
>> +	  "Set the value size of hash map (default 8)" },
>> +	{ "use-case", ARG_USE_CASE, "USE_CASE", 0,
>> +	  "Set the use case of hash map: no_op|overwrite|batch_add_batch_del|add_del_on_diff_cpu" },
>> +	{ "preallocated", ARG_PREALLOCATED, NULL, 0, "use preallocated hash map" },
>> +	{},
>> +};
>> +
>> +static error_t htab_mem_parse_arg(int key, char *arg, struct argp_state *state)
>> +{
>> +	switch (key) {
>> +	case ARG_MAX_ENTRIES:
>> +		args.max_entries = strtoul(arg, NULL, 10);
>> +		break;
>> +	case ARG_FULL_PERCENT:
>> +		args.full = strtoul(arg, NULL, 10);
>> +		if (!args.full || args.full > 100) {
>> +			fprintf(stderr, "invalid full percent %u\n", args.full);
>> +			argp_usage(state);
>> +		}
>> +		break;
>> +	case ARG_VALUE_SIZE:
>> +		args.value_size = strtoul(arg, NULL, 10);
>> +		break;
>> +	case ARG_USE_CASE:
>> +		args.use_case = strdup(arg);
>> +		break;
>> +	case ARG_PREALLOCATED:
>> +		args.preallocated = true;
>> +		break;
>> +	default:
>> +		return ARGP_ERR_UNKNOWN;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +const struct argp bench_htab_mem_argp = {
>> +	.options = opts,
>> +	.parser = htab_mem_parse_arg,
>> +};
>> +
>> +static void htab_mem_validate(void)
>> +{
>> +	if (env.consumer_cnt != 1) {
>> +		fprintf(stderr, "htab mem benchmark doesn't support multi-consumer!\n");
>> +		exit(1);
>> +	}
>> +}
>> +
>> +static int setup_and_join_cgroup(const char *path)
>> +{
>> +	int err, fd;
>> +
>> +	err = setup_cgroup_environment();
>> +	if (err) {
>> +		fprintf(stderr, "setup cgroup env failed\n");
>> +		return -1;
>> +	}
>> +
>> +	err = create_and_get_cgroup(path);
>> +	if (err < 0) {
>> +		fprintf(stderr, "create cgroup %s failed\n", path);
>> +		goto out;
>> +	}
>> +	fd = err;
>> +
>> +	err = join_cgroup(path);
>> +	if (err) {
>> +		fprintf(stderr, "join cgroup %s failed\n", path);
>> +		close(fd);
>> +		goto out;
>> +	}
>> +
>> +	return fd;
>> +out:
>> +	cleanup_cgroup_environment();
>> +	return -1;
>> +}
>> +
>> +static void htab_mem_setup(void)
>> +{
>> +	struct bpf_program *prog;
>> +	struct bpf_map *map;
>> +	int err;
>> +
>> +	setup_libbpf();
>> +
>> +	err = setup_and_join_cgroup("/htab_mem");
>> +	if (err < 0)
>> +		exit(1);
>> +	ctx.fd = err;
>> +
>> +	ctx.skel = htab_mem_bench__open();
>> +	if (!ctx.skel) {
>> +		fprintf(stderr, "failed to open skeleton\n");
>> +		goto cleanup;
>> +	}
>> +
>> +	map = ctx.skel->maps.htab;
>> +	bpf_map__set_max_entries(map, args.max_entries);
>> +	bpf_map__set_value_size(map, args.value_size);
>> +	if (args.preallocated)
>> +		bpf_map__set_map_flags(map, bpf_map__map_flags(map) & ~BPF_F_NO_PREALLOC);
>> +
>> +	map = ctx.skel->maps.array;
>> +	bpf_map__set_max_entries(map, args.max_entries);
>> +	bpf_map__set_value_size(map, args.value_size);
>> +
>> +	prog = bpf_object__find_program_by_name(ctx.skel->obj, args.use_case);
>> +	if (!prog) {
>> +		fprintf(stderr, "no such use-case: %s\n", args.use_case);
>> +		fprintf(stderr, "available use case:");
>> +		bpf_object__for_each_program(prog, ctx.skel->obj)
>> +			fprintf(stderr, " %s", bpf_program__name(prog));
>> +		fprintf(stderr, "\n");
>> +		goto cleanup;
>> +	}
>> +	bpf_program__set_autoload(prog, true);
>> +
>> +	ctx.skel->bss->nr_thread = env.producer_cnt;
>> +	ctx.skel->bss->nr_entries = (uint64_t)args.max_entries * args.full / 100;
>> +
>> +	err = htab_mem_bench__load(ctx.skel);
>> +	if (err) {
>> +		fprintf(stderr, "failed to load skeleton\n");
>> +		goto cleanup;
>> +	}
>> +	err = htab_mem_bench__attach(ctx.skel);
>> +	if (err) {
>> +		fprintf(stderr, "failed to attach skeleton\n");
>> +		goto cleanup;
>> +	}
>> +	return;
>> +cleanup:
>> +	close(ctx.fd);
>> +	cleanup_cgroup_environment();
>> +	htab_mem_bench__destroy(ctx.skel);
>> +	exit(1);
>> +}
>> +
>> +static void *htab_mem_producer(void *ctx)
>> +{
>> +	while (true)
>> +		(void)syscall(__NR_getpgid);
>> +	return NULL;
>> +}
>> +
>> +static void *htab_mem_consumer(void *ctx)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
>> +{
>> +	char buf[32];
>> +	int fd;
>> +
>> +	fd = openat(ctx.fd, name, O_RDONLY);
>> +	if (fd < 0) {
>> +		fprintf(stderr, "no %s\n", name);
>> +		*value = 0;
>> +		return;
>> +	}
>> +
>> +	buf[sizeof(buf) - 1] = 0;
>> +	read(fd, buf, sizeof(buf) - 1);
>> +	*value = strtoull(buf, NULL, 0);
>> +
>> +	close(fd);
>> +}
>> +
>> +static void htab_mem_measure(struct bench_res *res)
>> +{
>> +	res->hits = atomic_swap(&ctx.skel->bss->loop_cnt, 0);
>> +	htab_mem_read_mem_cgrp_file("memory.current", &res->gp_ct);
>> +}
>> +
>> +static void htab_mem_report_progress(int iter, struct bench_res *res, long delta_ns)
>> +{
>> +	double loop, mem;
>> +
>> +	loop = res->hits / 1000.0 / (delta_ns / 1000000000.0);
>> +	mem = res->gp_ct / 1048576.0;
>> +	printf("Iter %3d (%7.3lfus): ", iter, (delta_ns - 1000000000) / 1000.0);
>> +	printf("loop %7.2lfk/s, memory usage %7.2lfMiB\n", loop, mem);
>> +}
>> +
>> +static void htab_mem_report_final(struct bench_res res[], int res_cnt)
>> +{
>> +	double mem_mean = 0.0, mem_stddev = 0.0;
>> +	double loop_mean = 0.0, loop_stddev = 0.0;
>> +	unsigned long peak_mem;
>> +	int i;
>> +
>> +	for (i = 0; i < res_cnt; i++) {
>> +		loop_mean += res[i].hits / 1000.0 / (0.0 + res_cnt);
>> +		mem_mean += res[i].gp_ct / 1048576.0 / (0.0 + res_cnt);
>> +	}
>> +	if (res_cnt > 1)  {
>> +		for (i = 0; i < res_cnt; i++) {
>> +			loop_stddev += (loop_mean - res[i].hits / 1000.0) *
>> +				       (loop_mean - res[i].hits / 1000.0) /
>> +				       (res_cnt - 1.0);
>> +			mem_stddev += (mem_mean - res[i].gp_ct / 1048576.0) *
>> +				      (mem_mean - res[i].gp_ct / 1048576.0) /
>> +				      (res_cnt - 1.0);
>> +		}
>> +		loop_stddev = sqrt(loop_stddev);
>> +		mem_stddev = sqrt(mem_stddev);
>> +	}
>> +
>> +	htab_mem_read_mem_cgrp_file("memory.peak", &peak_mem);
>> +	printf("Summary: loop %7.2lf \u00B1 %7.2lfk/s, memory usage %7.2lf \u00B1 %7.2lfMiB, "
>> +	       "peak memory usage %7.2lfMiB\n",
>> +	       loop_mean, loop_stddev, mem_mean, mem_stddev, peak_mem / 1048576.0);
>> +}
>> +
>> +const struct bench bench_htab_mem = {
>> +	.name = "htab-mem",
>> +	.argp = &bench_htab_mem_argp,
>> +	.validate = htab_mem_validate,
>> +	.setup = htab_mem_setup,
>> +	.producer_thread = htab_mem_producer,
>> +	.consumer_thread = htab_mem_consumer,
>> +	.measure = htab_mem_measure,
>> +	.report_progress = htab_mem_report_progress,
>> +	.report_final = htab_mem_report_final,
>> +};
>> diff --git a/tools/testing/selftests/bpf/progs/htab_mem_bench.c b/tools/testing/selftests/bpf/progs/htab_mem_bench.c
>> new file mode 100644
>> index 000000000000..f320cb3a11e8
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/htab_mem_bench.c
>> @@ -0,0 +1,145 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
>> +#include <stdbool.h>
>> +#include <errno.h>
>> +#include <linux/types.h>
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +struct update_ctx {
>> +	unsigned int from;
>> +	unsigned int step;
>> +	unsigned int max;
>> +};
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_HASH);
>> +	__uint(key_size, 4);
>> +	__uint(map_flags, BPF_F_NO_PREALLOC);
>> +} htab SEC(".maps");
>> +
>> +struct {
>> +	__uint(type, BPF_MAP_TYPE_ARRAY);
>> +	__uint(key_size, 4);
>> +} array SEC(".maps");
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +unsigned int nr_entries = 0;
>> +unsigned int nr_thread = 0;
>> +long loop_cnt = 0;
>> +
>> +static int noop_htab(unsigned int i, struct update_ctx *ctx)
>> +{
>> +	if (ctx->from >= ctx->max)
>> +		return 1;
>> +
>> +	ctx->from += ctx->step;
>> +	return 0;
>> +}
>> +
>> +static int write_htab(unsigned int i, struct update_ctx *ctx, unsigned int flags)
>> +{
>> +	__u64 *value;
>> +
>> +	if (ctx->from >= ctx->max)
>> +		return 1;
>> +
>> +	value = bpf_map_lookup_elem(&array, &ctx->from);
>> +	if (value)
>> +		bpf_map_update_elem(&htab, &ctx->from, value, flags);
> What is a point of doing lookup from giant array of en element with zero value
> to copy it into htab?
> Why not to use single zero inited elem for all htab ops?
I want to check how does the different size of value effect the benchmark
result, so I choose a variable-size value.
>
>> +	ctx->from += ctx->step;
>> +
>> +	return 0;
>> +}
>> +
>> +static int overwrite_htab(unsigned int i, struct update_ctx *ctx)
>> +{
>> +	return write_htab(i, ctx, 0);
>> +}
>> +
>> +static int newwrite_htab(unsigned int i, struct update_ctx *ctx)
>> +{
>> +	return write_htab(i, ctx, BPF_NOEXIST);
>> +}
>> +
>> +static int del_htab(unsigned int i, struct update_ctx *ctx)
>> +{
>> +	__u64 *value;
>> +
>> +	if (ctx->from >= ctx->max)
>> +		return 1;
>> +
>> +	value = bpf_map_lookup_elem(&array, &ctx->from);
>> +	if (value)
>> +		bpf_map_delete_elem(&htab, &ctx->from);
> even worse here.
> Why lookup from array to delete the elem by key from htab?
>
> The if (ctx->from >= ctx->max) check is done before the lookup,
> so lookup will succeed and disarded immediately.
> array lookup is fast, but the waste of cpu cycles is meaningless.
My bad. Indeed there is no need to lookup from the array. Will remove it.
>
>> +	ctx->from += ctx->step;
>> +
>> +	return 0;
>> +}
>> +
>> +SEC("?tp/syscalls/sys_enter_getpgid")
>> +int no_op(void *ctx)
>> +{
>> +	struct update_ctx update;
>> +
>> +	update.from = bpf_get_smp_processor_id();
>> +	update.step = nr_thread;
>> +	update.max = nr_entries;
>> +	bpf_loop(update.max, noop_htab, &update, 0);
>> +	__sync_fetch_and_add(&loop_cnt, 1);
>> +
>> +	return 0;
>> +}
>> +
>> +SEC("?tp/syscalls/sys_enter_getpgid")
>> +int overwrite(void *ctx)
>> +{
>> +	struct update_ctx update;
>> +
>> +	update.from = bpf_get_smp_processor_id();
>> +	update.step = nr_thread;
>> +	update.max = nr_entries;
>> +	bpf_loop(update.max, overwrite_htab, &update, 0);
>> +
>> +	__sync_fetch_and_add(&loop_cnt, 1);
>> +	return 0;
>> +}
>> +
>> +SEC("?tp/syscalls/sys_enter_getpgid")
>> +int batch_add_batch_del(void *ctx)
>> +{
>> +	struct update_ctx update;
>> +
>> +	update.from = bpf_get_smp_processor_id();
>> +	update.step = nr_thread;
>> +	update.max = nr_entries;
>> +	bpf_loop(update.max, overwrite_htab, &update, 0);
>> +
>> +	update.from = bpf_get_smp_processor_id();
>> +	bpf_loop(update.max, del_htab, &update, 0);
>> +
>> +	__sync_fetch_and_add(&loop_cnt, 1);
>> +	return 0;
>> +}
>> +
>> +SEC("?tp/syscalls/sys_enter_getpgid")
>> +int add_del_on_diff_cpu(void *ctx)
>> +{
>> +	struct update_ctx update;
>> +	unsigned int from;
>> +
>> +	from = bpf_get_smp_processor_id();
>> +	update.from = from / 2;
>> +	update.step = nr_thread / 2;
>> +	update.max = nr_entries;
>> +
>> +	if (from & 1)
>> +		bpf_loop(update.max, newwrite_htab, &update, 0);
>> +	else
>> +		bpf_loop(update.max, del_htab, &update, 0);
> This is oddly shaped test.
> deleter cpu may run ahead of newwrite_htab.
> deleter will try to delete elems that don't exist.
> Loop of few thousand iterations is not a lot for one cpu to run ahead.
Yes. There will be empty loop if deletion CPU is running ahead of addition CPU,
but as shown by the nop column in the benchmark result, the speed of empty loop
is relative fast.
>
> Each loop will run 16k times and every time you step += 4.
> So 3/4 of these 16k runs it will be hitting if (ctx->from >= ctx->max) condition.
> What are you measuring?
As explained in the commit message, I am trying to let different deletion and
deletion CPU pairs operate on the different subsets of hash-table elements.
Assuming there are 16 elements in the htab and there are 8 CPUs and 8 threads,
the following is the operation subset for each CPU:

CPU 0:  0 4 8 12 (do deletion)
CPU 1:  0 4 8 12 (do addition)

CPU 2:  1 5 9 13
CPU 3:  1 5 9 13

CPU 4:  2 6 10 14
CPU 5:  2 6 10 14

CPU 6:  3 7 11 15
CPU 7:  3 7 11 15

>
>> +
>> +	__sync_fetch_and_add(&loop_cnt, 1);
>> +	return 0;
>> +}
>> -- 
>> 2.29.2
>>

