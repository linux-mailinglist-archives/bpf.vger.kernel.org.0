Return-Path: <bpf+bounces-20924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0DF84524F
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 09:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C77F1F2377B
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABE7158D7C;
	Thu,  1 Feb 2024 08:03:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6611F14C5A2;
	Thu,  1 Feb 2024 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774634; cv=none; b=oSwDCV3WiJyR1qwBrHPKqXVAdDY5dySdoFFOYhpEIOGvEiIAj1IqItKY/oxC88WSBv9a0mabebT8EJeYN1uVorF3n46hfJQMqqXjyjP428Q9XWr8BEGUGDJO6qBAdrQGzAKQjZt0+H4hGsxfxQD6n2BfwMgnVHiM4Z/ve4spUhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774634; c=relaxed/simple;
	bh=tKcwMRDgvBFJP+WtgVhk6nVNrLK6Rc4EnYPBvWe7TCA=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XFrY4CBqJjd+GyOZzYfKlLUQWuy9TZgi/RRN6dBhXsIsLWG95Mu9TV2f3SqPGQrBIGMz2+nAzCBxVWuqT6DRDSYr6JXZhEGfHMcbc2Gg5FEwjIKTfKX+xvIAJOhI1VdmFrnuN8GEO5G8HnPM5RW/tcmYu1R6b2RVhFj9IRqt8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TQWZk4bnLz1Q83V;
	Thu,  1 Feb 2024 16:01:50 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D0C714040D;
	Thu,  1 Feb 2024 16:03:42 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 16:03:39 +0800
Subject: Re: [PATCH v2 8/8] perf cpumap: Use perf_cpu_map__for_each_cpu when
 possible
To: Ian Rogers <irogers@google.com>
References: <20240201042236.1538928-1-irogers@google.com>
 <20240201042236.1538928-9-irogers@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Suzuki K
 Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, James
 Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, John Garry
	<john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
	<dave@stgolabs.net>, =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
	Kan Liang <kan.liang@linux.intel.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, Athira
 Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
	"Steinar H. Gunderson" <sesse@google.com>, Yang Li
	<yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, Sandipan
 Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Paran Lee
	<p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, Huacai Chen
	<chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<bpf@vger.kernel.org>
From: Yang Jihong <yangjihong1@huawei.com>
Message-ID: <aa719d3b-5b96-a341-b776-a67cc6fad64a@huawei.com>
Date: Thu, 1 Feb 2024 16:03:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240201042236.1538928-9-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)

Hello,

On 2024/2/1 12:22, Ian Rogers wrote:
> Rather than manually iterating the CPU map, use
> perf_cpu_map__for_each_cpu. When possible tidy local variables.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: James Clark <james.clark@arm.com>
> ---
>   tools/perf/arch/arm64/util/header.c           | 10 ++--
>   tools/perf/tests/bitmap.c                     | 13 +++---
>   tools/perf/tests/topology.c                   | 46 +++++++++----------
>   tools/perf/util/bpf_kwork.c                   | 16 ++++---
>   tools/perf/util/bpf_kwork_top.c               | 12 ++---
>   tools/perf/util/cpumap.c                      | 12 ++---
>   .../scripting-engines/trace-event-python.c    | 12 +++--
>   tools/perf/util/session.c                     |  5 +-
>   tools/perf/util/svghelper.c                   | 20 ++++----
>   9 files changed, 72 insertions(+), 74 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
> index a9de0b5187dd..741df3614a09 100644
> --- a/tools/perf/arch/arm64/util/header.c
> +++ b/tools/perf/arch/arm64/util/header.c
> @@ -4,8 +4,6 @@
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <perf/cpumap.h>
> -#include <util/cpumap.h>
> -#include <internal/cpumap.h>
>   #include <api/fs/fs.h>
>   #include <errno.h>
>   #include "debug.h"
> @@ -19,18 +17,18 @@
>   static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
>   {
>   	const char *sysfs = sysfs__mountpoint();
> -	int cpu;
> -	int ret = EINVAL;
> +	struct perf_cpu cpu;
> +	int idx, ret = EINVAL;
>   
>   	if (!sysfs || sz < MIDR_SIZE)
>   		return EINVAL;
>   
> -	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
> +	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
>   		char path[PATH_MAX];
>   		FILE *file;
>   
>   		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d" MIDR,
> -			  sysfs, RC_CHK_ACCESS(cpus)->map[cpu].cpu);
> +			  sysfs, cpu.cpu);
>   
>   		file = fopen(path, "r");
>   		if (!file) {
> diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
> index 0173f5402a35..98956e0e0765 100644
> --- a/tools/perf/tests/bitmap.c
> +++ b/tools/perf/tests/bitmap.c
> @@ -11,18 +11,19 @@
>   static unsigned long *get_bitmap(const char *str, int nbits)
>   {
>   	struct perf_cpu_map *map = perf_cpu_map__new(str);
> -	unsigned long *bm = NULL;
> -	int i;
> +	unsigned long *bm;
>   
>   	bm = bitmap_zalloc(nbits);
>   
>   	if (map && bm) {
> -		for (i = 0; i < perf_cpu_map__nr(map); i++)
> -			__set_bit(perf_cpu_map__cpu(map, i).cpu, bm);
> +		int i;
> +		struct perf_cpu cpu;
> +
> +		perf_cpu_map__for_each_cpu(cpu, i, map)
> +			__set_bit(cpu.cpu, bm);
>   	}
>   
> -	if (map)
> -		perf_cpu_map__put(map);
> +	perf_cpu_map__put(map);
>   	return bm;
>   }
>   
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index 2a842f53fbb5..a8cb5ba898ab 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -68,6 +68,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>   	};
>   	int i;
>   	struct aggr_cpu_id id;
> +	struct perf_cpu cpu;
>   
>   	session = perf_session__new(&data, NULL);
>   	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
> @@ -113,8 +114,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>   	TEST_ASSERT_VAL("Session header CPU map not set", session->header.env.cpu);
>   
>   	for (i = 0; i < session->header.env.nr_cpus_avail; i++) {
> -		struct perf_cpu cpu = { .cpu = i };
> -
> +		cpu.cpu = i;
>   		if (!perf_cpu_map__has(map, cpu))
>   			continue;
>   		pr_debug("CPU %d, core %d, socket %d\n", i,
> @@ -123,48 +123,48 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>   	}
>   
>   	// Test that CPU ID contains socket, die, core and CPU
> -	for (i = 0; i < perf_cpu_map__nr(map); i++) {
> -		id = aggr_cpu_id__cpu(perf_cpu_map__cpu(map, i), NULL);
> +	perf_cpu_map__for_each_cpu(cpu, i, map) {
> +		id = aggr_cpu_id__cpu(cpu, NULL);
>   		TEST_ASSERT_VAL("Cpu map - CPU ID doesn't match",
> -				perf_cpu_map__cpu(map, i).cpu == id.cpu.cpu);
> +				cpu.cpu == id.cpu.cpu);
>   
>   		TEST_ASSERT_VAL("Cpu map - Core ID doesn't match",
> -			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].core_id == id.core);
> +			session->header.env.cpu[cpu.cpu].core_id == id.core);
>   		TEST_ASSERT_VAL("Cpu map - Socket ID doesn't match",
> -			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].socket_id ==
> +			session->header.env.cpu[cpu.cpu].socket_id ==
>   			id.socket);
>   
>   		TEST_ASSERT_VAL("Cpu map - Die ID doesn't match",
> -			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].die_id == id.die);
> +			session->header.env.cpu[cpu.cpu].die_id == id.die);
>   		TEST_ASSERT_VAL("Cpu map - Node ID is set", id.node == -1);
>   		TEST_ASSERT_VAL("Cpu map - Thread IDX is set", id.thread_idx == -1);
>   	}
>   
>   	// Test that core ID contains socket, die and core
> -	for (i = 0; i < perf_cpu_map__nr(map); i++) {
> -		id = aggr_cpu_id__core(perf_cpu_map__cpu(map, i), NULL);
> +	perf_cpu_map__for_each_cpu(cpu, i, map) {
> +		id = aggr_cpu_id__core(cpu, NULL);
>   		TEST_ASSERT_VAL("Core map - Core ID doesn't match",
> -			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].core_id == id.core);
> +			session->header.env.cpu[cpu.cpu].core_id == id.core);
>   
>   		TEST_ASSERT_VAL("Core map - Socket ID doesn't match",
> -			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].socket_id ==
> +			session->header.env.cpu[cpu.cpu].socket_id ==
>   			id.socket);
>   
>   		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
> -			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].die_id == id.die);
> +			session->header.env.cpu[cpu.cpu].die_id == id.die);
>   		TEST_ASSERT_VAL("Core map - Node ID is set", id.node == -1);
>   		TEST_ASSERT_VAL("Core map - Thread IDX is set", id.thread_idx == -1);
>   	}
>   
>   	// Test that die ID contains socket and die
> -	for (i = 0; i < perf_cpu_map__nr(map); i++) {
> -		id = aggr_cpu_id__die(perf_cpu_map__cpu(map, i), NULL);
> +	perf_cpu_map__for_each_cpu(cpu, i, map) {
> +		id = aggr_cpu_id__die(cpu, NULL);
>   		TEST_ASSERT_VAL("Die map - Socket ID doesn't match",
> -			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].socket_id ==
> +			session->header.env.cpu[cpu.cpu].socket_id ==
>   			id.socket);
>   
>   		TEST_ASSERT_VAL("Die map - Die ID doesn't match",
> -			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].die_id == id.die);
> +			session->header.env.cpu[cpu.cpu].die_id == id.die);
>   
>   		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
>   		TEST_ASSERT_VAL("Die map - Core is set", id.core == -1);
> @@ -173,10 +173,10 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>   	}
>   
>   	// Test that socket ID contains only socket
> -	for (i = 0; i < perf_cpu_map__nr(map); i++) {
> -		id = aggr_cpu_id__socket(perf_cpu_map__cpu(map, i), NULL);
> +	perf_cpu_map__for_each_cpu(cpu, i, map) {
> +		id = aggr_cpu_id__socket(cpu, NULL);
>   		TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
> -			session->header.env.cpu[perf_cpu_map__cpu(map, i).cpu].socket_id ==
> +			session->header.env.cpu[cpu.cpu].socket_id ==
>   			id.socket);
>   
>   		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
> @@ -187,10 +187,10 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>   	}
>   
>   	// Test that node ID contains only node
> -	for (i = 0; i < perf_cpu_map__nr(map); i++) {
> -		id = aggr_cpu_id__node(perf_cpu_map__cpu(map, i), NULL);
> +	perf_cpu_map__for_each_cpu(cpu, i, map) {
> +		id = aggr_cpu_id__node(cpu, NULL);
>   		TEST_ASSERT_VAL("Node map - Node ID doesn't match",
> -				cpu__get_node(perf_cpu_map__cpu(map, i)) == id.node);
> +				cpu__get_node(cpu) == id.node);
>   		TEST_ASSERT_VAL("Node map - Socket is set", id.socket == -1);
>   		TEST_ASSERT_VAL("Node map - Die ID is set", id.die == -1);
>   		TEST_ASSERT_VAL("Node map - Core is set", id.core == -1);
> diff --git a/tools/perf/util/bpf_kwork.c b/tools/perf/util/bpf_kwork.c
> index 6eb2c78fd7f4..44f0f708a15d 100644
> --- a/tools/perf/util/bpf_kwork.c
> +++ b/tools/perf/util/bpf_kwork.c
> @@ -147,12 +147,12 @@ static bool valid_kwork_class_type(enum kwork_class_type type)
>   
>   static int setup_filters(struct perf_kwork *kwork)
>   {
> -	u8 val = 1;
> -	int i, nr_cpus, key, fd;
> -	struct perf_cpu_map *map;
> -
>   	if (kwork->cpu_list != NULL) {
> -		fd = bpf_map__fd(skel->maps.perf_kwork_cpu_filter);
> +		int idx, nr_cpus;
> +		struct perf_cpu_map *map;
> +		struct perf_cpu cpu;
> +		int fd = bpf_map__fd(skel->maps.perf_kwork_cpu_filter);
> +
>   		if (fd < 0) {
>   			pr_debug("Invalid cpu filter fd\n");
>   			return -1;
> @@ -165,8 +165,8 @@ static int setup_filters(struct perf_kwork *kwork)
>   		}
>   
>   		nr_cpus = libbpf_num_possible_cpus();
> -		for (i = 0; i < perf_cpu_map__nr(map); i++) {
> -			struct perf_cpu cpu = perf_cpu_map__cpu(map, i);
> +		perf_cpu_map__for_each_cpu(cpu, idx, map) {
> +			u8 val = 1;
>   
>   			if (cpu.cpu >= nr_cpus) {
>   				perf_cpu_map__put(map);
> @@ -181,6 +181,8 @@ static int setup_filters(struct perf_kwork *kwork)
>   	}
>   
>   	if (kwork->profile_name != NULL) {
> +		int key, fd;
> +
>   		if (strlen(kwork->profile_name) >= MAX_KWORKNAME) {
>   			pr_err("Requested name filter %s too large, limit to %d\n",
>   			       kwork->profile_name, MAX_KWORKNAME - 1);
> diff --git a/tools/perf/util/bpf_kwork_top.c b/tools/perf/util/bpf_kwork_top.c
> index 035e02272790..22a3b00a1e23 100644
> --- a/tools/perf/util/bpf_kwork_top.c
> +++ b/tools/perf/util/bpf_kwork_top.c
> @@ -122,11 +122,11 @@ static bool valid_kwork_class_type(enum kwork_class_type type)
>   
>   static int setup_filters(struct perf_kwork *kwork)
>   {
> -	u8 val = 1;
> -	int i, nr_cpus, fd;
> -	struct perf_cpu_map *map;
> -
>   	if (kwork->cpu_list) {
> +		int idx, nr_cpus, fd;
> +		struct perf_cpu_map *map;
> +		struct perf_cpu cpu;
> +
>   		fd = bpf_map__fd(skel->maps.kwork_top_cpu_filter);
>   		if (fd < 0) {
>   			pr_debug("Invalid cpu filter fd\n");
> @@ -140,8 +140,8 @@ static int setup_filters(struct perf_kwork *kwork)
>   		}
>   
>   		nr_cpus = libbpf_num_possible_cpus();
> -		for (i = 0; i < perf_cpu_map__nr(map); i++) {
> -			struct perf_cpu cpu = perf_cpu_map__cpu(map, i);
> +		perf_cpu_map__for_each_cpu(cpu, idx, map) {
> +			u8 val = 1;
>   
>   			if (cpu.cpu >= nr_cpus) {
>   				perf_cpu_map__put(map);

For part of perf-kwork utility:
Reviewed-and-tested-by: Yang Jihong <yangjihong1@huawei.com>


Thanks,
Yang

