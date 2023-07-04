Return-Path: <bpf+bounces-3930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6934B7466D4
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 03:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5A1280F0A
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 01:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC450629;
	Tue,  4 Jul 2023 01:14:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C44139C
	for <bpf@vger.kernel.org>; Tue,  4 Jul 2023 01:14:01 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E26D184;
	Mon,  3 Jul 2023 18:13:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qw4Yt2JLvz4f3q30;
	Tue,  4 Jul 2023 09:13:54 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDXPypQcqNkjCnEMQ--.2370S2;
	Tue, 04 Jul 2023 09:13:56 +0800 (CST)
Subject: Re: [PATCH bpf-next v8] selftests/bpf: Add benchmark for bpf memory
 allocator
To: John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 houtao1@huawei.com, Martin KaFai Lau <martin.lau@linux.dev>
References: <20230703141332.3319271-1-houtao@huaweicloud.com>
 <64a34309e42aa_652052084f@john.notmuch>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <47eb0f85-5950-bb15-079f-383a865e27c0@huaweicloud.com>
Date: Tue, 4 Jul 2023 09:13:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <64a34309e42aa_652052084f@john.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDXPypQcqNkjCnEMQ--.2370S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW7Aw4fJry3ZF45Ww1xXwb_yoW8ZFWUp3
	ykJa1fXr13Jrs7Gw18Aa4kJrW7Xr1fJw129r1rAa4Durs5Xws29r4xK3yUKry5uFyIkw42
	kayqvr12ka9rKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/4/2023 5:52 AM, John Fastabend wrote:
> Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> The benchmark could be used to compare the performance of hash map
>> operations and the memory usage between different flavors of bpf memory
>> allocator (e.g., no bpf ma vs bpf ma vs reuse-after-gp bpf ma). It also
>> could be used to check the performance improvement or the memory saving
>> provided by optimization.
>>

SNIP
>> overwrite            per-prod-op: 191.92 ± 0.07k/s, avg mem: 1.23 ± 0.00MiB, peak mem: 1.49MiB
>> batch_add_batch_del  per-prod-op: 218.10 ± 0.25k/s, avg mem: 1.23 ± 0.00MiB, peak mem: 1.49MiB
>> add_del_on_diff_cpu  per-prod-op: 39.59 ± 0.41k/s, avg mem: 1.48 ± 0.11MiB, peak mem: 1.74MiB
>>
>> (3) normal bpf memory allocator
>>
>> overwrite            per-prod-op: 134.81 ± 0.22k/s, avg mem: 1.67 ± 0.12MiB, peak mem: 2.74MiB
>> batch_add_batch_del  per-prod-op: 90.44 ± 0.34k/s, avg mem: 2.27 ± 0.00MiB, peak mem: 2.74MiB
>> add_del_on_diff_cpu  per-prod-op: 28.20 ± 0.15k/s, avg mem: 1.73 ± 0.17MiB, peak mem: 2.06MiB
> Acked-by: John Fastabend <john.fastabend@gmail.com>
Thanks for the Ack.
>
>> +
>> +static error_t htab_mem_parse_arg(int key, char *arg, struct argp_state *state)
>> +{
>> +	switch (key) {
>> +	case ARG_VALUE_SIZE:
>> +		args.value_size = strtoul(arg, NULL, 10);
>> +		if (args.value_size > 4096) {
>> +			fprintf(stderr, "too big value size %u\n", args.value_size);
>> +			argp_usage(state);
>> +		}
>> +		break;
>> +	case ARG_USE_CASE:
>> +		args.use_case = strdup(arg);
> might be worth checking for null and returning an error? Only matters if we
> run from CI or something and then this looks like a flake.
Will fix. I also found an error reported from BPF CI llvm-16 build
procedure: "benchs/bench_htab_mem.c:45:27: error: initializer element is
not a compile-time constant". Will fix in v9.
>
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


