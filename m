Return-Path: <bpf+bounces-16977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D1D807E2F
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 03:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0061F1F21A27
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 02:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2172615CE;
	Thu,  7 Dec 2023 02:06:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567DFC3
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 18:06:15 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SlyL94bbmz4f3l6w
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 10:06:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E1DA01A0377
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 10:06:11 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgDnSLeOKHFlsaeeCw--.37345S2;
	Thu, 07 Dec 2023 10:06:09 +0800 (CST)
Subject: Re: [PATCH bpf-next] selftests/bpf: Test the release of map btf
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Daniel Borkmann <daniel@iogearbox.net>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 houtao1@huawei.com
References: <20231206110625.3188975-1-houtao@huaweicloud.com>
 <274e98da-9f9e-4828-8a8f-7891c6775770@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <81c277e9-856c-7763-8e76-7b76aa39d1dc@huaweicloud.com>
Date: Thu, 7 Dec 2023 10:06:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <274e98da-9f9e-4828-8a8f-7891c6775770@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgDnSLeOKHFlsaeeCw--.37345S2
X-Coremail-Antispam: 1UD129KBjvJXoW3uw15uF1DAF45WrWrGFWDtwb_yoWkury7pF
	Z5JFWYkFy8Jrn3Jr1Utay5CFySyw48J3WDtr1Fqa4jyrZFvr1Igr10gFyqgF15Ar48Jr4j
	yr1jqrs7u39rJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi,

On 12/7/2023 7:16 AM, Yonghong Song wrote:
>
> On 12/6/23 6:06 AM, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> When there is bpf_list_head or bpf_rb_root field in map value, the free
>> of map btf and the free of map value may run concurrently and there may
>> be use-after-free problem, so add two test cases to demonstrate it.
>>
>> The first test case tests the racing between the free of map btf and the
>> free of array map. It constructs the racing by releasing the array
>> map in
>> the end after other ref-counter of map btf has been released. But it is
>> still hard to reproduce the UAF problem, and I managed to reproduce it
>> by queuing multiple kworkers to stress system_unbound_wq concurrently.
>
> Thanks a lot for your test cases! I tried your patch on top of bpf-next
> and run over 20 times and still cannot reproduce the issue.
> Based on your description, you need to do
> "
> queuing multiple kworkers to stress system_unbound_wq concurrently
> "
> What specific steps you are doing here to stree system_unbound_wq?
> I guess we have to have some kind of logic in the patch to stree
> system_unbound_wq to trigger a failure?
>

I used a kernel module in which it queued multiple kworkers to
system_unbound_wq repeatedly, so the running of bpf_map_free_deferred
will be delayed. The reason I kept the test here is for completeness,
but I think I could try to stress system_unbound_wq in test case by
creating and destroying multiple array map concurrently.
>>
>> The second case tests the racing between the free of map btf and the
>> free of inner map. Beside using the similar method as the first one
>> does, it uses bpf_map_delete_elem() to delete the inner map and to defer
>> the release of inner map after one RCU grace period. The UAF problem can
>> been easily reproduced by using bpf_next tree and a KASAN-enabled
>> kernel.
>
> This test is solid and I can reproduce it easily and with my patch
>  
> https://lore.kernel.org/bpf/20231206210959.1035724-1-yonghong.song@linux.dev/
> the test can run successfully.
>
>>
>> The reason for using two skeletons is to prevent the release of outer
>> map and inner map in map_in_map_btf.c interfering the release of bpf
>> map in normal_map_btf.c.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>> Hi,
>>
>> I was also working on the UAF problem caused by the racing between the
>> free map btf and the free map value. However considering Yonghong posted
>> the patch first [1], I decided to post the selftest for the problem. The
>> reliable reproduce of the problem depends on the "Fix the release of
>> inner map" patch-set in bpf-next.
>>
>> [1]:
>> https://lore.kernel.org/bpf/20231205224812.813224-1-yonghong.song@linux.dev/
>>
>>   .../selftests/bpf/prog_tests/map_btf.c        | 88 +++++++++++++++++++
>>   .../selftests/bpf/progs/map_in_map_btf.c      | 73 +++++++++++++++
>>   .../selftests/bpf/progs/normal_map_btf.c      | 56 ++++++++++++
>>   3 files changed, 217 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/map_btf.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/map_in_map_btf.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/normal_map_btf.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/map_btf.c
>> b/tools/testing/selftests/bpf/prog_tests/map_btf.c
>> new file mode 100644
>> index 000000000000..5304eee0e8f8
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/map_btf.c
>> @@ -0,0 +1,88 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
>> +#define _GNU_SOURCE
>> +#include <sched.h>
>> +#include <pthread.h>
>> +#include <stdbool.h>
>> +#include <bpf/btf.h>
>> +#include <test_progs.h>
>> +
>> +#include "normal_map_btf.skel.h"
>> +#include "map_in_map_btf.skel.h"
>> +
>> +static void do_test_normal_map_btf(void)
>> +{
>> +    struct normal_map_btf *skel;
>> +    int err, new_fd = -1;
>> +
>> +    skel = normal_map_btf__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "open_load"))
>> +        return;
>> +
>> +    err = normal_map_btf__attach(skel);
>> +    if (!ASSERT_OK(err, "attach"))
>> +        goto out;
>> +
>> +    skel->bss->pid = getpid();
>> +    usleep(1);
>> +    ASSERT_TRUE(skel->bss->done, "done");
>> +
>> +    /* Close array fd later */
>> +    new_fd = dup(bpf_map__fd(skel->maps.array));
>> +out:
>> +    normal_map_btf__destroy(skel);
>> +    if (new_fd < 0)
>> +        return;
>> +    /* Use kern_sync_rcu() to wait for the start of the free of the bpf
>> +     * program and use an assumed delay to wait for the release of
>> the map
>> +     * btf which is held by other maps (e.g, bss). After that, array
>> map
>> +     * holds the last reference of map btf.
>> +     */
>> +    kern_sync_rcu();
>> +    usleep(2000);
>
> I tried 2000/20000/200000 and all of them cannot reproduce the issue.
> I guess this usleep will not only delay freeing the map, but also
> delaying some other system activity, e.g., freeing the btf?

As said in the comments, the delay here is only used to wait for the
release of map btf held in bss map. Increasing the delay can not
reproduce the problem because the last ref-counter of map btf will only
be released after closing the array map. The reproduce depends on
btf_free_rcu() runs before bpf_map_free_deferred().
>
>> +    close(new_fd);
>> +}
>> +
>> +static void do_test_map_in_map_btf(void)
>> +{
>> +    int err, zero = 0, new_fd = -1;
>> +    struct map_in_map_btf *skel;
>> +
>> +    skel = map_in_map_btf__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "open_load"))
>> +        return;
>> +
>> +    err = map_in_map_btf__attach(skel);
>> +    if (!ASSERT_OK(err, "attach"))
>> +        goto out;
>> +
>> +    skel->bss->pid = getpid();
>> +    usleep(1);
>> +    ASSERT_TRUE(skel->bss->done, "done");
>> +
>> +    /* Close inner_array fd later */
>> +    new_fd = dup(bpf_map__fd(skel->maps.inner_array));
>> +    /* Defer the free of inner_array */
>> +    err = bpf_map__delete_elem(skel->maps.outer_array, &zero,
>> sizeof(zero), 0);
>> +    ASSERT_OK(err, "delete inner map");
>> +out:
>> +    map_in_map_btf__destroy(skel);
>> +    if (new_fd < 0)
>> +        return;
>> +    /* Use kern_sync_rcu() to wait for the start of the free of the bpf
>> +     * program and use an assumed delay to wait for the free of the
>> outer
>> +     * map and the release of map btf. After that, array map holds
>> the last
>
> array map refers to inner map, right? It would be good to be explicit
> to use 'inner' map?

Yes. Will update.
>
>> +     * reference of map btf.
>> +     */
>> +    kern_sync_rcu();
>> +    usleep(10000);
>> +    close(new_fd);
>> +}
>> +
>> +void test_map_btf(void)
>> +{
>> +    if (test__start_subtest("array_btf"))
>> +        do_test_normal_map_btf();
>> +    if (test__start_subtest("inner_array_btf"))
>> +        do_test_map_in_map_btf();
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/map_in_map_btf.c
>> b/tools/testing/selftests/bpf/progs/map_in_map_btf.c
>> new file mode 100644
>> index 000000000000..6a000dd789d3
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/map_in_map_btf.c
>> @@ -0,0 +1,73 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +#include "bpf_misc.h"
>> +#include "bpf_experimental.h"
>> +
>> +struct node_data {
>> +    __u64 data;
>> +    struct bpf_list_node node;
>> +};
>> +
>> +struct map_value {
>> +    struct bpf_list_head head __contains(node_data, node);
>> +    struct bpf_spin_lock lock;
>> +};
>> +
>> +struct inner_array_type {
>> +    __uint(type, BPF_MAP_TYPE_ARRAY);
>> +    __type(key, int);
>> +    __type(value, struct map_value);
>> +    __uint(max_entries, 1);
>> +} inner_array SEC(".maps");
>> +
>> +struct {
>> +    __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>> +    __uint(key_size, 4);
>> +    __uint(value_size, 4);
>> +    __uint(max_entries, 1);
>> +    __array(values, struct inner_array_type);
>> +} outer_array SEC(".maps") = {
>> +    .values = {
>> +        [0] = &inner_array,
>> +    },
>> +};
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +int pid = 0;
>> +bool done = false;
>> +
>> +SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>> +int add_to_list_in_inner_array(void *ctx)
>> +{
>> +    struct map_value *value;
>> +    struct node_data *new;
>> +    struct bpf_map *map;
>> +    int zero = 0;
>> +
>
> If 'done' is true here we can just return, right?

Yes. It is assumed the bpf program will be called once for the target
pid, but it doesn't incur any harm to ensure that.
>
>> +    if ((u32)bpf_get_current_pid_tgid() != pid)
>> +        return 0;
>> +
>> +    map = bpf_map_lookup_elem(&outer_array, &zero);
>> +    if (!map)
>> +        return 0;
>> +
>> +    value = bpf_map_lookup_elem(map, &zero);
>> +    if (!value)
>> +        return 0;
>> +
>> +    new = bpf_obj_new(typeof(*new));
>> +    if (!new)
>> +        return 0;
>> +
>> +    bpf_spin_lock(&value->lock);
>> +    bpf_list_push_back(&value->head, &new->node);
>> +    bpf_spin_unlock(&value->lock);
>> +    done = true;
>> +
>> +    return 0;
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/normal_map_btf.c
>> b/tools/testing/selftests/bpf/progs/normal_map_btf.c
>> new file mode 100644
>> index 000000000000..c8a19e30f8a9
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/normal_map_btf.c
>> @@ -0,0 +1,56 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +#include "bpf_misc.h"
>> +#include "bpf_experimental.h"
>> +
>> +struct node_data {
>> +    __u64 data;
>> +    struct bpf_list_node node;
>> +};
>> +
>> +struct map_value {
>> +    struct bpf_list_head head __contains(node_data, node);
>> +    struct bpf_spin_lock lock;
>> +};
>> +
>> +struct {
>> +    __uint(type, BPF_MAP_TYPE_ARRAY);
>> +    __type(key, int);
>> +    __type(value, struct map_value);
>> +    __uint(max_entries, 1);
>> +} array SEC(".maps");
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +int pid = 0;
>> +bool done = false;
>> +
>> +SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>> +int add_to_list_in_array(void *ctx)
>> +{
>> +    struct map_value *value;
>> +    struct node_data *new;
>> +    int zero = 0;
>> +
>
> The same here. If 'done' is true, we can return, right?

Will add.
>
>> +    if ((u32)bpf_get_current_pid_tgid() != pid)
>> +        return 0;
>> +
>> +    value = bpf_map_lookup_elem(&array, &zero);
>> +    if (!value)
>> +        return 0;
>> +
>> +    new = bpf_obj_new(typeof(*new));
>> +    if (!new)
>> +        return 0;
>> +
>> +    bpf_spin_lock(&value->lock);
>> +    bpf_list_push_back(&value->head, &new->node);
>> +    bpf_spin_unlock(&value->lock);
>> +    done = true;
>> +
>> +    return 0;
>> +}
> .


