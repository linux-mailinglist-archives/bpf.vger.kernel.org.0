Return-Path: <bpf+bounces-19245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C341827C71
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 02:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905CD1F242A1
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 01:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DEB139D;
	Tue,  9 Jan 2024 01:16:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DBEECE
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 01:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T8Cgn46xzz4f3jrx
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 09:16:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1054D1A017A
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 09:16:41 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgCHqQxznpxlna8bAQ--.833S2;
	Tue, 09 Jan 2024 09:16:39 +0800 (CST)
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add benchmark for bpf memory
 allocator
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20231221141501.3588586-1-houtao@huaweicloud.com>
 <20231221141501.3588586-3-houtao@huaweicloud.com>
 <CAPhsuW5_9Tt6HLD_LFddS6egKK92WK6TWpz+X1mfi10FHzPskg@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <620908a5-aee1-9f22-9d5c-552223250b35@huaweicloud.com>
Date: Tue, 9 Jan 2024 09:16:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5_9Tt6HLD_LFddS6egKK92WK6TWpz+X1mfi10FHzPskg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgCHqQxznpxlna8bAQ--.833S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WryUJFy7Zr48Gw1UXr1rCrg_yoW3AF4DpF
	W8tr4akrZ8trZFgr1fXr4kXFy2qws7Xw15CFyYq3s7Zwn3urnakr1Ikr47Wa43ZrWvvFsx
	uF1qqwnxuw4rJ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 1/9/2024 5:45 AM, Song Liu wrote:
> On Thu, Dec 21, 2023 at 6:14 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
> [...]
>> The following is the test results conducted on a 8-CPU VM with 16GB memory:
>>
>> $ for i in 1 4 8; do ./bench -w3 -d10 bpf_ma -p${i} -a; done |grep Summary
>> Summary: per-prod alloc 11.29 ± 0.14M/s free 33.76 ± 0.33M/s, total memory usage    0.01 ± 0.00MiB
>> Summary: per-prod alloc  7.49 ± 0.12M/s free 34.42 ± 0.56M/s, total memory usage    0.03 ± 0.00MiB
>> Summary: per-prod alloc  6.66 ± 0.08M/s free 34.27 ± 0.41M/s, total memory usage    0.06 ± 0.00MiB
>>
>> $ for i in 1 4 8; do ./bench -w3 -d10 bpf_ma -p${i} -a --percpu; done |grep Summary
>> Summary: per-prod alloc 14.64 ± 0.60M/s free 36.94 ± 0.35M/s, total memory usage  188.02 ± 7.43MiB
>> Summary: per-prod alloc 12.39 ± 1.32M/s free 36.40 ± 0.38M/s, total memory usage  808.90 ± 25.56MiB
>> Summary: per-prod alloc 10.80 ± 0.17M/s free 35.45 ± 0.25M/s, total memory usage 2330.24 ± 480.56MiB
> This is not likely related to this patch, but do we expect this much
> memory usage?
> I guess the 2.3GiB number is from bigger ALLOC_OBJ_SIZE and
> ALLOC_BATCH_CNT? I am getting 0 MiB with this test on my VM.

I think the reduction of memory usage is due to the merge of patch set
"bpf: Reduce memory usage for bpf_global_percpu_ma", because I got the
similar result as you did after apply the patch set [1].

1:
https://lore.kernel.org/bpf/cb8edf4b-f585-4e3e-9bed-10f5b36e427c@huaweicloud.com/

>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  tools/testing/selftests/bpf/Makefile          |   2 +
>>  tools/testing/selftests/bpf/bench.c           |   4 +
>>  tools/testing/selftests/bpf/bench.h           |   7 +
>>  .../selftests/bpf/benchs/bench_bpf_ma.c       | 273 ++++++++++++++++++
>>  .../selftests/bpf/progs/bench_bpf_ma.c        | 222 ++++++++++++++
> Maybe add a run_bench_bpf_ma.sh script in selftests/bpf/benchs?

Forgot that. Will do in v2.
>
>>  5 files changed, 508 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_ma.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/bench_bpf_ma.c
>>
> [...]
>> diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
>> index a6fcf111221f..206cf3de5df2 100644
>> --- a/tools/testing/selftests/bpf/bench.h
>> +++ b/tools/testing/selftests/bpf/bench.h
>> @@ -53,6 +53,13 @@ struct bench_res {
>>                         unsigned long gp_ct;
>>                         unsigned int stime;
>>                 } rcu;
>> +               struct {
>> +                       unsigned long alloc;
>> +                       unsigned long free;
> nit: maybe add _ct or _cnt postfix to match "rcu" above or the skel?

Will do in v2.
>
>> +                       unsigned long alloc_ns;
>> +                       unsigned long free_ns;
>> +                       unsigned long mem_bytes;
>> +               } ma;
>>         };
>>  };
>>
> [...]
>> +
>> +static void bpf_ma_validate(void)
>> +{
>> +}
> Empty validate() function seems not necessary.

Yes. Will remove it.
>
> [...]
>
>> +
>> +static void bpf_ma_report_final(struct bench_res res[], int res_cnt)
>> +{
>> +       double mem_mean = 0.0, mem_stddev = 0.0;
>> +       double alloc_mean = 0.0, alloc_stddev = 0.0;
>> +       double free_mean = 0.0, free_stddev = 0.0;
>> +       double alloc_ns = 0.0, free_ns = 0.0;
>> +       int i;
>> +
>> +       for (i = 0; i < res_cnt; i++) {
>> +               alloc_ns += res[i].ma.alloc_ns;
>> +               free_ns += res[i].ma.free_ns;
>> +       }
>> +       for (i = 0; i < res_cnt; i++) {
>> +               if (alloc_ns)
>> +                       alloc_mean += res[i].ma.alloc * 1000.0 / alloc_ns;
>> +               if (free_ns)
>> +                       free_mean += res[i].ma.free * 1000.0 / free_ns;
>> +               mem_mean += res[i].ma.mem_bytes / 1048576.0 / (0.0 + res_cnt);
>> +       }
>> +       if (res_cnt > 1) {
>> +               for (i = 0; i < res_cnt; i++) {
>> +                       double sample;
>> +
>> +                       sample = res[i].ma.alloc_ns ? res[i].ma.alloc * 1000.0 /
>> +                                                     res[i].ma.alloc_ns : 0.0;
>> +                       alloc_stddev += (alloc_mean - sample) * (alloc_mean - sample) /
>> +                                       (res_cnt - 1.0);
>> +
>> +                       sample = res[i].ma.free_ns ? res[i].ma.free * 1000.0 /
>> +                                                    res[i].ma.free_ns : 0.0;
>> +                       free_stddev += (free_mean - sample) * (free_mean - sample) /
>> +                                      (res_cnt - 1.0);
>> +
>> +                       sample = res[i].ma.mem_bytes / 1048576.0;
>> +                       mem_stddev += (mem_mean - sample) * (mem_mean - sample) /
>> +                                     (res_cnt - 1.0);
>> +               }
> nit: We can probably refactor common code for stddev calculation into
> some helpers.

Will try. The calculation of free/alloc ratio is the same, but the names
of related fields are different. Maybe need to define alloc_cnt/free_cnt
as an array first.
>
>> +               alloc_stddev = sqrt(alloc_stddev);
>> +               free_stddev = sqrt(free_stddev);
>> +               mem_stddev = sqrt(mem_stddev);
>> +       }
>> +
>> +       printf("Summary: per-prod alloc %7.2lf \u00B1 %3.2lfM/s free %7.2lf \u00B1 %3.2lfM/s, "
>> +              "total memory usage %7.2lf \u00B1 %3.2lfMiB\n",
>> +              alloc_mean, alloc_stddev, free_mean, free_stddev,
>> +              mem_mean, mem_stddev);
>> +}
>> +
>> +const struct bench bench_bpf_mem_alloc = {
>> +       .name = "bpf_ma",
>> +       .argp = &bench_bpf_mem_alloc_argp,
>> +       .validate = bpf_ma_validate,
>> +       .setup = bpf_ma_setup,
>> +       .producer_thread = bpf_ma_producer,
>> +       .measure = bpf_ma_measure,
>> +       .report_progress = bpf_ma_report_progress,
>> +       .report_final = bpf_ma_report_final,
>> +};
>> diff --git a/tools/testing/selftests/bpf/progs/bench_bpf_ma.c b/tools/testing/selftests/bpf/progs/bench_bpf_ma.c
> [...]
>
>> +

SNIP
>> +/* Return the number of freed objects */
>> +static __always_inline unsigned int batch_percpu_free(struct bpf_map *map)
>> +{
>> +       struct percpu_map_value *value;
>> +       unsigned int i, key;
>> +       void *old;
>> +
>> +       for (i = 0; i < ALLOC_BATCH_CNT; i++) {
>> +               key = i;
>> +               value = bpf_map_lookup_elem(map, &key);
>> +               if (!value)
>> +                       return i;
>> +
>> +               old = bpf_kptr_xchg(&value->data, NULL);
>> +               if (!old)
>> +                       return i;
>> +               bpf_percpu_obj_drop(old);
>> +       }
>> +
>> +       return ALLOC_BATCH_CNT;
>> +}
> nit: These four functions have quite duplicated code. We can probably
> refactor them a bit.

Will do. The main difference is that these functions use different
helpers to allocate and free memory. I think we could pass a bool to the
common allocation and free inline functions.

>
>> +
>> +SEC("?fentry/" SYS_PREFIX "sys_getpgid")
>> +int bench_batch_alloc_free(void *ctx)
>> +{
>> +       u64 start, delta;
>> +       unsigned int cnt;
>> +       void *map;
> s/void */struct bpf_map */?

Will fix it in v2.
>
>> +       int key;
>> +
>> +       key = bpf_get_smp_processor_id();
>> +       map = bpf_map_lookup_elem((void *)&outer_array, &key);
>> +       if (!map)
>> +               return 0;
>> +
>> +       start = bpf_ktime_get_boot_ns();
>> +       cnt = batch_alloc(map);
>> +       delta = bpf_ktime_get_boot_ns() - start;
>> +       __sync_fetch_and_add(&alloc_cnt, cnt);
>> +       __sync_fetch_and_add(&alloc_ns, delta);
>> +
>> +       start = bpf_ktime_get_boot_ns();
>> +       cnt = batch_free(map);
>> +       delta = bpf_ktime_get_boot_ns() - start;
>> +       __sync_fetch_and_add(&free_cnt, cnt);
>> +       __sync_fetch_and_add(&free_ns, delta);
>> +
>> +       return 0;
>> +}
>> +
>> +SEC("?fentry/" SYS_PREFIX "sys_getpgid")
>> +int bench_batch_percpu_alloc_free(void *ctx)
>> +{
>> +       u64 start, delta;
>> +       unsigned int cnt;
>> +       void *map;
> ditto

Will update in v2.
>
>> +       int key;
>> +
>> +       key = bpf_get_smp_processor_id();
>> +       map = bpf_map_lookup_elem((void *)&percpu_outer_array, &key);
>> +       if (!map)
>> +               return 0;
>> +
>> +       start = bpf_ktime_get_boot_ns();
>> +       cnt = batch_percpu_alloc(map);
>> +       delta = bpf_ktime_get_boot_ns() - start;
>> +       __sync_fetch_and_add(&alloc_cnt, cnt);
>> +       __sync_fetch_and_add(&alloc_ns, delta);
>> +
>> +       start = bpf_ktime_get_boot_ns();
>> +       cnt = batch_percpu_free(map);
>> +       delta = bpf_ktime_get_boot_ns() - start;
>> +       __sync_fetch_and_add(&free_cnt, cnt);
>> +       __sync_fetch_and_add(&free_ns, delta);
>> +
>> +       return 0;
>> +}
> nit: ditto duplicated code.

Will factor it out as a common function. Thanks for all these suggestions.



