Return-Path: <bpf+bounces-18593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F97981C75B
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 10:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020921C215AC
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECD8DF67;
	Fri, 22 Dec 2023 09:36:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19315DDB5
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SxMcF4tRtz4f57jR
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 17:35:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1D4AA1A01C3
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 17:35:59 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAHVQt5WIVlbZ1MEQ--.57057S2;
	Fri, 22 Dec 2023 17:35:57 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH bpf-next v6 0/8] bpf: Reduce memory usage for
 bpf_global_percpu_ma
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231222031729.1287957-1-yonghong.song@linux.dev>
Message-ID: <cb8edf4b-f585-4e3e-9bed-10f5b36e427c@huaweicloud.com>
Date: Fri, 22 Dec 2023 17:35:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231222031729.1287957-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAHVQt5WIVlbZ1MEQ--.57057S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4DWFyxGw4rGrWDtryrZwb_yoWrtrW3pF
	s7Jr4ayryDAF97Gw1fK3Z7uF1fXwn5WF1rJ3yYkryDCrnIgr109rZ2kw1UWF9xGFs3JF1f
	tFyqqwn3Wa1UZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/22/2023 11:17 AM, Yonghong Song wrote:
> Currently when a bpf program intends to allocate memory for percpu kptr,
> the verifier will call bpf_mem_alloc_init() to prefill all supported
> unit sizes and this caused memory consumption very big for large number
> of cpus. For example, for 128-cpu system, the total memory consumption
> with initial prefill is ~175MB. Things will become worse for systems
> with even more cpus.
>
> Patch 1 avoids unnecessary extra percpu memory allocation.
> Patch 2 adds objcg to bpf_mem_alloc at init stage so objcg can be
> associated with root cgroup and objcg can be passed to later
> bpf_mem_alloc_percpu_unit_init().
> Patch 3 addresses memory consumption issue by avoiding to prefill
> with all unit sizes, i.e. only prefilling with user specified size.
> Patch 4 further reduces memory consumption by limiting the
> number of prefill entries for percpu memory allocation.
> Patch 5 has much smaller low/high watermarks for percpu allocation
> to reduce memory consumption.
> Patch 6 rejects percpu memory allocation with bpf_global_percpu_ma
> when allocation size is greater than 512 bytes.
> Patch 7 fixed test_bpf_ma test due to Patch 5.
> Patch 8 added one test to show the verification failure log message.

FYI. After applying the patch set, the memory consumption in bpf memory
benchmark [1] on 8-CPU VM decreases a lot:

Before the patch set:

$ for i in 1 4 8; do ./bench -w3 -d10 bpf_ma -p${i} -a --percpu; done |
grep Summary
Summary: per-prod alloc   14.16 ± 0.59M/s free   36.18 ± 0.39M/s, total
memory usage  183.71 ± 10.38MiB
Summary: per-prod alloc   12.35 ± 1.10M/s free   35.79 ± 0.51M/s, total
memory usage  744.52 ± 11.64MiB
Summary: per-prod alloc   11.15 ± 0.20M/s free   35.72 ± 0.27M/s, total
memory usage 2545.98 ± 537.57MiB

After the patch set:

$ for i in 1 4 8; do ./bench -w3 -d10 bpf_ma -p${i} -a --percpu; done |
grep Summary
Summary: per-prod alloc    0.86 ± 0.00M/s free   37.29 ± 0.11M/s, total
memory usage    0.00 ± 0.00MiB
Summary: per-prod alloc    0.85 ± 0.00M/s free   36.70 ± 0.24M/s, total
memory usage    0.00 ± 0.00MiB
Summary: per-prod alloc    0.84 ± 0.00M/s free   37.21 ± 0.17M/s, total
memory usage    0.00 ± 0.00MiB

However the allocation performance also degrades a lot. It seems it is
due to patch 5 (bpf: Use smaller low/high marks for percpu allocation),
because c->batch is 1 now, so each allocation needs one run of irq_work.

[1]:
https://lore.kernel.org/bpf/20231221141501.3588586-1-houtao@huaweicloud.com/
> Changelogs:
>   v5 -> v6:
>     . Change bpf_mem_alloc_percpu_init() to add objcg as one of parameters.
>       For bpf_global_percpu_ma, the objcg is NULL, corresponding root memcg.
>   v4 -> v5:
>     . Do not do bpf_global_percpu_ma initialization at init stage, instead
>       doing initialization when the verifier knows it is going to be used
>       by bpf prog.
>     . Using much smaller low/high watermarks for percpu allocation.
>   v3 -> v4:
>     . Add objcg to bpf_mem_alloc during init stage.
>     . Initialize objcg at init stage but use it in bpf_mem_alloc_percpu_unit_init().
>     . Remove check_obj_size() in bpf_mem_alloc_percpu_unit_init().
>   v2 -> v3:
>     . Clear the bpf_mem_cache if prefill fails.
>     . Change test_bpf_ma percpu allocation tests to use bucket_size
>       as allocation size instead of bucket_size - 8.
>     . Remove __GFP_ZERO flag from __alloc_percpu_gfp() call.
>   v1 -> v2:
>     . Avoid unnecessary extra percpu memory allocation.
>     . Add a separate function to do bpf_global_percpu_ma initialization
>     . promote.
>     . Promote function static 'sizes' array to file static.
>     . Add comments to explain to refill only one item for percpu alloc.
>
> Yonghong Song (8):
>   bpf: Avoid unnecessary extra percpu memory allocation
>   bpf: Add objcg to bpf_mem_alloc
>   bpf: Allow per unit prefill for non-fix-size percpu memory allocator
>   bpf: Refill only one percpu element in memalloc
>   bpf: Use smaller low/high marks for percpu allocation
>   bpf: Limit up to 512 bytes for bpf_global_percpu_ma allocation
>   selftests/bpf: Cope with 512 bytes limit with bpf_global_percpu_ma
>   selftests/bpf: Add a selftest with > 512-byte percpu allocation size
>
>  include/linux/bpf_mem_alloc.h                 |  8 ++
>  kernel/bpf/memalloc.c                         | 93 ++++++++++++++++---
>  kernel/bpf/verifier.c                         | 45 ++++++---
>  .../selftests/bpf/prog_tests/test_bpf_ma.c    | 20 ++--
>  .../selftests/bpf/progs/percpu_alloc_fail.c   | 18 ++++
>  .../testing/selftests/bpf/progs/test_bpf_ma.c | 66 ++++++-------
>  6 files changed, 184 insertions(+), 66 deletions(-)
>


