Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26C2558C7F
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 02:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiFXAyN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 20:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiFXAyM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 20:54:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BD8506E1;
        Thu, 23 Jun 2022 17:54:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 106CB61FCB;
        Fri, 24 Jun 2022 00:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34462C3411D;
        Fri, 24 Jun 2022 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656032049;
        bh=iJwqda8D81N2o+hntjwonESDlai5qrBeRt0wDQyhytA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VRg16VLbHbCAHtpbS+Hfa2v5CTHaAlfmZjvOx5+3Paoh7RB7kD1hEgpVOt3MFYMbl
         j2Qotj5cnfAtdfuMaNsx/QJuz94u1mB9KcB2c8hHLOTELJXLR0G2hcLybLEw2G1trd
         gyeqXZuRmugJVd8+V2sMy6k8ZfppIg3bOM+39Wf8sYKuUG+kvxrvOO7FgZPoFYGXwV
         7S/LDmr0u3Wl2V1qzkMKLH5t7G0GeiSDloXdlufITe2qLFONs3tr+LbsVCh17UWhhT
         lVPnd//R9xkvpUWiCLi2MJQw8T8YKGoF2E5V2a/raz88jBL99ZRLjl5mskI7RCv6J9
         2yBy/gEHa4PBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C73E15C097C; Thu, 23 Jun 2022 17:54:08 -0700 (PDT)
Date:   Thu, 23 Jun 2022 17:54:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, rcu@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Eric Dumazet <edumazet@google.com>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add benchmark for local_storage
 RCU Tasks Trace usage
Message-ID: <20220624005408.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220623234609.543263-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623234609.543263-1-davemarchevsky@fb.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 23, 2022 at 04:46:09PM -0700, Dave Marchevsky wrote:
> This benchmark measures grace period latency and kthread cpu usage of
> RCU Tasks Trace when many processes are creating/deleting BPF
> local_storage. Intent here is to quantify improvement on these metrics
> after Paul's recent RCU Tasks patches [0].
> 
> Specifically, fork 15k tasks which call a bpf prog that creates/destroys
> task local_storage and sleep in a loop, resulting in many
> call_rcu_tasks_trace calls.
> 
> To determine grace period latency, trace time elapsed between
> rcu_tasks_trace_pregp_step and rcu_tasks_trace_postgp; for cpu usage
> look at rcu_task_trace_kthread's stime in /proc/PID/stat.
> 
> On my virtualized test environment (Skylake, 8 cpus) benchmark results
> demonstrate significant improvement:
> 
> BEFORE Paul's patches:
> 
>   SUMMARY tasks_trace grace period latency        avg 22298.551 us stddev 1302.165 us
>   SUMMARY ticks per tasks_trace grace period      avg 2.291 stddev 0.324
> 
> AFTER Paul's patches:
> 
>   SUMMARY tasks_trace grace period latency        avg 16969.197 us  stddev 2525.053 us
>   SUMMARY ticks per tasks_trace grace period      avg 1.146 stddev 0.178
> 
> Note that since these patches are not in bpf-next benchmarking was done
> by cherry-picking this patch onto rcu tree.
> 
>   [0]: https://lore.kernel.org/rcu/20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1/
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Nice!  Thank you!!!

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  tools/testing/selftests/bpf/Makefile          |   4 +-
>  tools/testing/selftests/bpf/bench.c           |  42 +++
>  tools/testing/selftests/bpf/bench.h           |  12 +
>  .../bench_local_storage_rcu_tasks_trace.c     | 272 ++++++++++++++++++
>  ...run_bench_local_storage_rcu_tasks_trace.sh |  11 +
>  .../local_storage_rcu_tasks_trace_bench.c     |  65 +++++
>  6 files changed, 405 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_local_storage_rcu_tasks_trace.sh
>  create mode 100644 tools/testing/selftests/bpf/progs/local_storage_rcu_tasks_trace_bench.c
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 4fbd88a8ed9e..9350f0e33727 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -572,6 +572,7 @@ $(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
>  $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
>  $(OUTPUT)/bench_bpf_hashmap_full_update.o: $(OUTPUT)/bpf_hashmap_full_update_bench.skel.h
>  $(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
> +$(OUTPUT)/bench_local_storage_rcu_tasks_trace.o: $(OUTPUT)/local_storage_rcu_tasks_trace_bench.skel.h
>  $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
>  $(OUTPUT)/bench: LDLIBS += -lm
>  $(OUTPUT)/bench: $(OUTPUT)/bench.o \
> @@ -585,7 +586,8 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>  		 $(OUTPUT)/bench_bpf_loop.o \
>  		 $(OUTPUT)/bench_strncmp.o \
>  		 $(OUTPUT)/bench_bpf_hashmap_full_update.o \
> -		 $(OUTPUT)/bench_local_storage.o
> +		 $(OUTPUT)/bench_local_storage.o \
> +		 $(OUTPUT)/bench_local_storage_rcu_tasks_trace.o
>  	$(call msg,BINARY,,$@)
>  	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
>  
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> index 1e7b5d4b1f11..c1f20a147462 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -79,6 +79,43 @@ void hits_drops_report_progress(int iter, struct bench_res *res, long delta_ns)
>  	       hits_per_sec, hits_per_prod, drops_per_sec, hits_per_sec + drops_per_sec);
>  }
>  
> +void
> +grace_period_latency_basic_stats(struct bench_res res[], int res_cnt, struct basic_stats *gp_stat)
> +{
> +	int i;
> +
> +	memset(gp_stat, 0, sizeof(struct basic_stats));
> +
> +	for (i = 0; i < res_cnt; i++)
> +		gp_stat->mean += res[i].gp_ns / 1000.0 / (double)res[i].gp_ct / (0.0 + res_cnt);
> +
> +#define IT_MEAN_DIFF (res[i].gp_ns / 1000.0 / (double)res[i].gp_ct - gp_stat->mean)
> +	if (res_cnt > 1) {
> +		for (i = 0; i < res_cnt; i++)
> +			gp_stat->stddev += (IT_MEAN_DIFF * IT_MEAN_DIFF) / (res_cnt - 1.0);
> +	}
> +	gp_stat->stddev = sqrt(gp_stat->stddev);
> +#undef IT_MEAN_DIFF
> +}
> +
> +void
> +grace_period_ticks_basic_stats(struct bench_res res[], int res_cnt, struct basic_stats *gp_stat)
> +{
> +	int i;
> +
> +	memset(gp_stat, 0, sizeof(struct basic_stats));
> +	for (i = 0; i < res_cnt; i++)
> +		gp_stat->mean += res[i].stime / (double)res[i].gp_ct / (0.0 + res_cnt);
> +
> +#define IT_MEAN_DIFF (res[i].stime / (double)res[i].gp_ct - gp_stat->mean)
> +	if (res_cnt > 1) {
> +		for (i = 0; i < res_cnt; i++)
> +			gp_stat->stddev += (IT_MEAN_DIFF * IT_MEAN_DIFF) / (res_cnt - 1.0);
> +	}
> +	gp_stat->stddev = sqrt(gp_stat->stddev);
> +#undef IT_MEAN_DIFF
> +}
> +
>  void hits_drops_report_final(struct bench_res res[], int res_cnt)
>  {
>  	int i;
> @@ -236,6 +273,7 @@ extern struct argp bench_ringbufs_argp;
>  extern struct argp bench_bloom_map_argp;
>  extern struct argp bench_bpf_loop_argp;
>  extern struct argp bench_local_storage_argp;
> +extern struct argp bench_local_storage_rcu_tasks_trace_argp;
>  extern struct argp bench_strncmp_argp;
>  
>  static const struct argp_child bench_parsers[] = {
> @@ -244,6 +282,8 @@ static const struct argp_child bench_parsers[] = {
>  	{ &bench_bpf_loop_argp, 0, "bpf_loop helper benchmark", 0 },
>  	{ &bench_local_storage_argp, 0, "local_storage benchmark", 0 },
>  	{ &bench_strncmp_argp, 0, "bpf_strncmp helper benchmark", 0 },
> +	{ &bench_local_storage_rcu_tasks_trace_argp, 0,
> +		"local_storage RCU Tasks Trace slowdown benchmark", 0 },
>  	{},
>  };
>  
> @@ -449,6 +489,7 @@ extern const struct bench bench_bpf_hashmap_full_update;
>  extern const struct bench bench_local_storage_cache_seq_get;
>  extern const struct bench bench_local_storage_cache_interleaved_get;
>  extern const struct bench bench_local_storage_cache_hashmap_control;
> +extern const struct bench bench_local_storage_tasks_trace;
>  
>  static const struct bench *benchs[] = {
>  	&bench_count_global,
> @@ -487,6 +528,7 @@ static const struct bench *benchs[] = {
>  	&bench_local_storage_cache_seq_get,
>  	&bench_local_storage_cache_interleaved_get,
>  	&bench_local_storage_cache_hashmap_control,
> +	&bench_local_storage_tasks_trace,
>  };
>  
>  static void setup_benchmark()
> diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
> index 4b15286753ba..d748255877e2 100644
> --- a/tools/testing/selftests/bpf/bench.h
> +++ b/tools/testing/selftests/bpf/bench.h
> @@ -30,11 +30,19 @@ struct env {
>  	struct cpu_set cons_cpus;
>  };
>  
> +struct basic_stats {
> +	double mean;
> +	double stddev;
> +};
> +
>  struct bench_res {
>  	long hits;
>  	long drops;
>  	long false_hits;
>  	long important_hits;
> +	unsigned long gp_ns;
> +	unsigned long gp_ct;
> +	unsigned int stime;
>  };
>  
>  struct bench {
> @@ -65,6 +73,10 @@ void ops_report_final(struct bench_res res[], int res_cnt);
>  void local_storage_report_progress(int iter, struct bench_res *res,
>  				   long delta_ns);
>  void local_storage_report_final(struct bench_res res[], int res_cnt);
> +void grace_period_latency_basic_stats(struct bench_res res[], int res_cnt,
> +				      struct basic_stats *gp_stat);
> +void grace_period_ticks_basic_stats(struct bench_res res[], int res_cnt,
> +				    struct basic_stats *gp_stat);
>  
>  static inline __u64 get_time_ns(void)
>  {
> diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
> new file mode 100644
> index 000000000000..43026430b25a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_rcu_tasks_trace.c
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include <argp.h>
> +
> +#include <sys/prctl.h>
> +#include "local_storage_rcu_tasks_trace_bench.skel.h"
> +#include "bench.h"
> +
> +#include <signal.h>
> +
> +static struct {
> +	__u32 nr_procs;
> +	__u32 kthread_pid;
> +	bool quiet;
> +} args = {
> +	.nr_procs = 1000,
> +	.kthread_pid = 0,
> +	.quiet = false,
> +};
> +
> +enum {
> +	ARG_NR_PROCS = 7000,
> +	ARG_KTHREAD_PID = 7001,
> +	ARG_QUIET = 7002,
> +};
> +
> +static const struct argp_option opts[] = {
> +	{ "nr_procs", ARG_NR_PROCS, "NR_PROCS", 0,
> +		"Set number of user processes to spin up"},
> +	{ "kthread_pid", ARG_KTHREAD_PID, "PID", 0,
> +		"Pid of rcu_tasks_trace kthread for ticks tracking"},
> +	{ "quiet", ARG_QUIET, "{0,1}", 0,
> +		"If true, don't report progress"},
> +	{},
> +};
> +
> +static error_t parse_arg(int key, char *arg, struct argp_state *state)
> +{
> +	long ret;
> +
> +	switch (key) {
> +	case ARG_NR_PROCS:
> +		ret = strtol(arg, NULL, 10);
> +		if (ret < 1 || ret > UINT_MAX) {
> +			fprintf(stderr, "invalid nr_procs\n");
> +			argp_usage(state);
> +		}
> +		args.nr_procs = ret;
> +		break;
> +	case ARG_KTHREAD_PID:
> +		ret = strtol(arg, NULL, 10);
> +		if (ret < 1) {
> +			fprintf(stderr, "invalid kthread_pid\n");
> +			argp_usage(state);
> +		}
> +		args.kthread_pid = ret;
> +		break;
> +	case ARG_QUIET:
> +		ret = strtol(arg, NULL, 10);
> +		if (ret < 0 || ret > 1) {
> +			fprintf(stderr, "invalid quiet %ld\n", ret);
> +			argp_usage(state);
> +		}
> +		args.quiet = ret;
> +		break;
> +break;
> +	default:
> +		return ARGP_ERR_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +const struct argp bench_local_storage_rcu_tasks_trace_argp = {
> +	.options = opts,
> +	.parser = parse_arg,
> +};
> +
> +#define MAX_SLEEP_PROCS 150000
> +
> +static void validate(void)
> +{
> +	if (env.producer_cnt != 1) {
> +		fprintf(stderr, "benchmark doesn't support multi-producer!\n");
> +		exit(1);
> +	}
> +	if (env.consumer_cnt != 1) {
> +		fprintf(stderr, "benchmark doesn't support multi-consumer!\n");
> +		exit(1);
> +	}
> +
> +	if (args.nr_procs > MAX_SLEEP_PROCS) {
> +		fprintf(stderr, "benchmark supports up to %u sleeper procs!\n",
> +			MAX_SLEEP_PROCS);
> +		exit(1);
> +	}
> +}
> +
> +static long kthread_pid_ticks(void)
> +{
> +	char procfs_path[100];
> +	long stime;
> +	FILE *f;
> +
> +	if (!args.kthread_pid)
> +		return -1;
> +
> +	sprintf(procfs_path, "/proc/%u/stat", args.kthread_pid);
> +	f = fopen(procfs_path, "r");
> +	if (f < 0) {
> +		fprintf(stderr, "couldn't open %s, exiting\n", procfs_path);
> +		exit(1);
> +	}
> +	fscanf(f, "%*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s %ld", &stime);
> +	fclose(f);
> +	return stime;
> +}
> +
> +static struct {
> +	struct local_storage_rcu_tasks_trace_bench *skel;
> +	long prev_kthread_stime;
> +} ctx;
> +
> +static void sleep_and_loop(void)
> +{
> +	while (true) {
> +		sleep(rand() % 4);
> +		syscall(__NR_getpgid);
> +	}
> +}
> +
> +static void local_storage_tasks_trace_setup(void)
> +{
> +	int i, err, forkret, runner_pid;
> +
> +	runner_pid = getpid();
> +
> +	for (i = 0; i < args.nr_procs; i++) {
> +		forkret = fork();
> +		if (forkret < 0) {
> +			fprintf(stderr, "Error forking sleeper proc %u of %u, exiting\n", i,
> +				args.nr_procs);
> +			goto err_out;
> +		}
> +
> +		if (!forkret) {
> +			err = prctl(PR_SET_PDEATHSIG, SIGKILL);
> +			if (err < 0) {
> +				fprintf(stderr, "prctl failed with err %d, exiting\n", err);
> +				goto err_out;
> +			}
> +
> +			if (getppid() != runner_pid) {
> +				fprintf(stderr, "Runner died while spinning up procs, exiting\n");
> +				goto err_out;
> +			}
> +			sleep_and_loop();
> +		}
> +	}
> +	fprintf(stderr, "Spun up %u procs (our pid %d)\n", args.nr_procs, runner_pid);
> +
> +	setup_libbpf();
> +
> +	ctx.skel = local_storage_rcu_tasks_trace_bench__open_and_load();
> +	if (!ctx.skel) {
> +		fprintf(stderr, "Error doing open_and_load, exiting\n");
> +		goto err_out;
> +	}
> +
> +	ctx.prev_kthread_stime = kthread_pid_ticks();
> +
> +	if (!bpf_program__attach(ctx.skel->progs.get_local)) {
> +		fprintf(stderr, "Error attaching bpf program\n");
> +		goto err_out;
> +	}
> +
> +	if (!bpf_program__attach(ctx.skel->progs.pregp_step)) {
> +		fprintf(stderr, "Error attaching bpf program\n");
> +		goto err_out;
> +	}
> +
> +	if (!bpf_program__attach(ctx.skel->progs.postgp)) {
> +		fprintf(stderr, "Error attaching bpf program\n");
> +		goto err_out;
> +	}
> +
> +	return;
> +err_out:
> +	exit(1);
> +}
> +
> +static void measure(struct bench_res *res)
> +{
> +	long ticks;
> +
> +	res->gp_ct = atomic_swap(&ctx.skel->bss->gp_hits, 0);
> +	res->gp_ns = atomic_swap(&ctx.skel->bss->gp_times, 0);
> +	ticks = kthread_pid_ticks();
> +	res->stime = ticks - ctx.prev_kthread_stime;
> +	ctx.prev_kthread_stime = ticks;
> +}
> +
> +static void *consumer(void *input)
> +{
> +	return NULL;
> +}
> +
> +static void *producer(void *input)
> +{
> +	while (true)
> +		syscall(__NR_getpgid);
> +	return NULL;
> +}
> +
> +static void report_progress(int iter, struct bench_res *res, long delta_ns)
> +{
> +	if (ctx.skel->bss->unexpected) {
> +		fprintf(stderr, "Error: Unexpected order of bpf prog calls (postgp after pregp).");
> +		fprintf(stderr, "Data can't be trusted, exiting\n");
> +		exit(1);
> +	}
> +
> +	if (args.quiet)
> +		return;
> +
> +	printf("Iter %d\t avg tasks_trace grace period latency\t%lf ns\n",
> +	       iter, res->gp_ns / (double)res->gp_ct);
> +	printf("Iter %d\t avg ticks per tasks_trace grace period\t%lf\n",
> +	       iter, res->stime / (double)res->gp_ct);
> +}
> +
> +static void report_final(struct bench_res res[], int res_cnt)
> +{
> +	struct basic_stats gp_stat;
> +
> +	grace_period_latency_basic_stats(res, res_cnt, &gp_stat);
> +	printf("SUMMARY tasks_trace grace period latency");
> +	printf("\tavg %.3lf us\tstddev %.3lf us\n", gp_stat.mean, gp_stat.stddev);
> +	grace_period_ticks_basic_stats(res, res_cnt, &gp_stat);
> +	printf("SUMMARY ticks per tasks_trace grace period");
> +	printf("\tavg %.3lf\tstddev %.3lf\n", gp_stat.mean, gp_stat.stddev);
> +}
> +
> +/* local-storage-tasks-trace: Benchmark performance of BPF local_storage's use
> + * of RCU Tasks-Trace.
> + *
> + * Stress RCU Tasks Trace by forking many tasks, all of which do no work aside
> + * from sleep() loop, and creating/destroying BPF task-local storage on wakeup.
> + * The number of forked tasks is configurable.
> + *
> + * exercising code paths which call call_rcu_tasks_trace while there are many
> + * thousands of tasks on the system should result in RCU Tasks-Trace having to
> + * do a noticeable amount of work.
> + *
> + * This should be observable by measuring rcu_tasks_trace_kthread CPU usage
> + * after the grace period has ended, or by measuring grace period latency.
> + *
> + * This benchmark uses both approaches, attaching to rcu_tasks_trace_pregp_step
> + * and rcu_tasks_trace_postgp functions to measure grace period latency and
> + * using /proc/PID/stat to measure rcu_tasks_trace_kthread kernel ticks
> + */
> +const struct bench bench_local_storage_tasks_trace = {
> +	.name = "local-storage-tasks-trace",
> +	.validate = validate,
> +	.setup = local_storage_tasks_trace_setup,
> +	.producer_thread = producer,
> +	.consumer_thread = consumer,
> +	.measure = measure,
> +	.report_progress = report_progress,
> +	.report_final = report_final,
> +};
> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_local_storage_rcu_tasks_trace.sh b/tools/testing/selftests/bpf/benchs/run_bench_local_storage_rcu_tasks_trace.sh
> new file mode 100755
> index 000000000000..5dac1f02892c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_local_storage_rcu_tasks_trace.sh
> @@ -0,0 +1,11 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +kthread_pid=`pgrep rcu_tasks_trace_kthread`
> +
> +if [ -z $kthread_pid ]; then
> +	echo "error: Couldn't find rcu_tasks_trace_kthread"
> +	exit 1
> +fi
> +
> +./bench --nr_procs 15000 --kthread_pid $kthread_pid -d 600 --quiet 1 local-storage-tasks-trace
> diff --git a/tools/testing/selftests/bpf/progs/local_storage_rcu_tasks_trace_bench.c b/tools/testing/selftests/bpf/progs/local_storage_rcu_tasks_trace_bench.c
> new file mode 100644
> index 000000000000..9b11342b19a0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/local_storage_rcu_tasks_trace_bench.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, int);
> +} task_storage SEC(".maps");
> +
> +long hits;
> +long gp_hits;
> +long gp_times;
> +long current_gp_start;
> +long unexpected;
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int get_local(void *ctx)
> +{
> +	struct task_struct *task;
> +	int idx;
> +	int *s;
> +
> +	idx = 0;
> +	task = bpf_get_current_task_btf();
> +	s = bpf_task_storage_get(&task_storage, task, &idx,
> +				 BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (!s)
> +		return 0;
> +
> +	*s = 3;
> +	bpf_task_storage_delete(&task_storage, task);
> +	__sync_add_and_fetch(&hits, 1);
> +	return 0;
> +}
> +
> +SEC("kprobe/rcu_tasks_trace_pregp_step")
> +int pregp_step(struct pt_regs *ctx)
> +{
> +	current_gp_start = bpf_ktime_get_ns();
> +	return 0;
> +}
> +
> +SEC("kprobe/rcu_tasks_trace_postgp")
> +int postgp(struct pt_regs *ctx)
> +{
> +	if (!current_gp_start) {
> +		/* Will only happen if prog tracing rcu_tasks_trace_pregp_step doesn't
> +		 * execute before this prog
> +		 */
> +		__sync_add_and_fetch(&unexpected, 1);
> +		return 0;
> +	}
> +
> +	__sync_add_and_fetch(&gp_times, bpf_ktime_get_ns() - current_gp_start);
> +	__sync_add_and_fetch(&gp_hits, 1);
> +	current_gp_start = 0;
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.30.2
> 
