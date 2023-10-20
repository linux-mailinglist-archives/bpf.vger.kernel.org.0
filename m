Return-Path: <bpf+bounces-12826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AD17D1114
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 15:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681131C20FB8
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF671D525;
	Fri, 20 Oct 2023 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498261A5BD
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 13:57:24 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5586293
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 06:57:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SBmNp11G7z4f3l21
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 21:57:14 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBn25s5hzJlKJEvDQ--.18575S2;
	Fri, 20 Oct 2023 21:57:17 +0800 (CST)
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test race between map uref
 release and bpf timer init
To: Hsin-Wei Hung <hsinweih@uci.edu>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20231020014214.2471419-1-houtao@huaweicloud.com>
 <20231020014214.2471419-3-houtao@huaweicloud.com>
 <CABcoxUYdAxUuMp=YtfrqvHsF==yHkCBSbrVDu3uzVkizbSH9OA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <239420e7-1854-6e22-1572-2903af9f8d91@huaweicloud.com>
Date: Fri, 20 Oct 2023 21:57:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABcoxUYdAxUuMp=YtfrqvHsF==yHkCBSbrVDu3uzVkizbSH9OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBn25s5hzJlKJEvDQ--.18575S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww1UKw4rWFW8JrW5JFy7Jrb_yoWfZFy8pa
	yIyF43CF48Xr47Jr1jqa1UWFZ3tr48uF4jyr48ta4UAF929rn3tF1xKFW2ka1fCr4vyr4f
	Zr4rtr9Ikw4DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
	ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

Hi,

On 10/20/2023 10:50 AM, Hsin-Wei Hung wrote:
> On Thu, Oct 19, 2023 at 6:41 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> Test race between the release of map ref and bpf_timer_init():
>> 1) create one thread to add array map with bpf_timer into array of
>>    arrays map repeatedly.
>> 2) create another thread to call getpgid() and call bpf_timer_init()
>>    in the attached bpf program repeatedly.
>> 3) synchronize these two threads through pthread barrier.
>>
>> It is a bit hard to trigger the kmemleak by only running the test. I
>> managed to reproduce the kmemleak by injecting a delay between
>> t->timer.function = bpf_timer_cb and timer->timer = t in
>> bpf_timer_init().
> I figured out that to trigger this issue reliably, I can insert
> different delays using large bpf_loop() in allocation and release
> paths. I have some extra code to filter out unwanted events. The
> userspace program is similar. It just needs to try to call close(fd)
> and syscall(SYS_getpgid) at the same time without delay. It is not a
> stable test though due to the reference to the function.
>
> SEC("tp/syscalls/sys_enter_close")
> {
>         ...
>         bpf_loop(1000000, &delay_loop, NULL, 0);
> }
>
> SEC("fexit/bpf_map_kmalloc_node")gmai
> {
>         ...
>         bpf_loop(2000000, &delay_loop, NULL, 0);
> }

Thanks for sharing another way to reproduce the problem.
>
> I can confirm that the v1 patch fixes memleak in v5.15. However, this
> issue doesn't seem to affect net-next. At least since db559117828d
> (bpf: Consolidate spin_lock, timer management into btf_record), the
> leaked memory caused by the race would be freed in array_map_free().

I think you are partially right, because array_map indeed doesn't have
such problem but array-in-array map still has the problem and I can
reproduce the problem in bpf tree (see the kmemleak report below). After
reading the related code carefully, I think the proposed fix in the
patch is not right, because the root cause is the release of map-in-map
is not correct (e.g, don't wait for a RCU GP) but the patch only fixes
the phenomenon. Will update the patchset to fix the problem again.

Regards,
Hou
>
>> The following is the output of kmemleak after reproducing:
>>
>> unreferenced object 0xffff8881163d3780 (size 96):
>>   comm "test_progs", pid 539, jiffies 4295358164 (age 23.276s)
>>   hex dump (first 32 bytes):
>>     80 37 3d 16 81 88 ff ff 00 00 00 00 00 00 00 00  .7=.............
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<00000000bbc3f059>] __kmem_cache_alloc_node+0x3b1/0x4a0
>>     [<00000000a24ddf4d>] __kmalloc_node+0x57/0x140
>>     [<000000004d577dbf>] bpf_map_kmalloc_node+0x5f/0x180
>>     [<00000000bd8428d3>] bpf_timer_init+0xf6/0x1b0
>>     [<0000000086d87323>] 0xffffffffc000c94e
>>     [<000000005a09e655>] trace_call_bpf+0xc5/0x1c0
>>     [<0000000051ab837b>] kprobe_perf_func+0x51/0x260
>>     [<000000000069bbd1>] kprobe_dispatcher+0x61/0x70
>>     [<000000007dceb75b>] kprobe_ftrace_handler+0x168/0x240
>>     [<00000000d8721bd7>] 0xffffffffc02010f7
>>     [<00000000e885b809>] __x64_sys_getpgid+0x1/0x20
>>     [<000000007be835d8>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  .../bpf/prog_tests/timer_init_race.c          | 138 ++++++++++++++++++
>>  .../selftests/bpf/progs/timer_init_race.c     |  56 +++++++
>>  2 files changed, 194 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_init_race.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/timer_init_race.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/timer_init_race.c b/tools/testing/selftests/bpf/prog_tests/timer_init_race.c
>> new file mode 100644
>> index 0000000000000..7bd57459e5048
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/timer_init_race.c
>> @@ -0,0 +1,138 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
>> +#define _GNU_SOURCE
>> +#include <unistd.h>
>> +#include <sys/syscall.h>
>> +#include <test_progs.h>
>> +#include <bpf/btf.h>
>> +#include "timer_init_race.skel.h"
>> +
>> +struct thread_ctx {
>> +       struct bpf_map_create_opts opts;
>> +       pthread_barrier_t barrier;
>> +       int outer_map_fd;
>> +       int start, abort;
>> +       int loop, err;
>> +};
>> +
>> +static int wait_for_start_or_abort(struct thread_ctx *ctx)
>> +{
>> +       while (!ctx->start && !ctx->abort)
>> +               usleep(1);
>> +       return ctx->abort ? -1 : 0;
>> +}
>> +
>> +static void *close_map_fn(void *data)
>> +{
>> +       struct thread_ctx *ctx = data;
>> +       int loop = ctx->loop, err = 0;
>> +
>> +       if (wait_for_start_or_abort(ctx) < 0)
>> +               return NULL;
>> +
>> +       while (loop-- > 0) {
>> +               int fd, zero = 0, i;
>> +               volatile int s = 0;
>> +
>> +               fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, sizeof(struct bpf_timer),
>> +                                   1, &ctx->opts);
>> +               if (fd < 0) {
>> +                       err |= 1;
>> +                       pthread_barrier_wait(&ctx->barrier);
>> +                       continue;
>> +               }
>> +
>> +               if (bpf_map_update_elem(ctx->outer_map_fd, &zero, &fd, 0) < 0)
>> +                       err |= 2;
>> +
>> +               pthread_barrier_wait(&ctx->barrier);
>> +               /* let bpf_timer_init run first */
>> +               for (i = 0; i < 5000; i++)
>> +                       s++;
>> +               close(fd);
>> +       }
>> +
>> +       ctx->err = err;
>> +
>> +       return NULL;
>> +}
>> +
>> +static void *init_timer_fn(void *data)
>> +{
>> +       struct thread_ctx *ctx = data;
>> +       int loop = ctx->loop;
>> +
>> +       if (wait_for_start_or_abort(ctx) < 0)
>> +               return NULL;
>> +
>> +       while (loop-- > 0) {
>> +               pthread_barrier_wait(&ctx->barrier);
>> +               syscall(SYS_getpgid);
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +void test_timer_init_race(void)
>> +{
>> +       struct timer_init_race *skel;
>> +       struct thread_ctx ctx;
>> +       pthread_t tid[2];
>> +       struct btf *btf;
>> +       int err;
>> +
>> +       skel = timer_init_race__open();
>> +       if (!ASSERT_OK_PTR(skel, "timer_init_race open"))
>> +               return;
>> +
>> +       err = timer_init_race__load(skel);
>> +       if (!ASSERT_EQ(err, 0, "timer_init_race load"))
>> +               goto out;
>> +
>> +       memset(&ctx, 0, sizeof(ctx));
>> +
>> +       btf = bpf_object__btf(skel->obj);
>> +       if (!ASSERT_OK_PTR(btf, "timer_init_race btf"))
>> +               goto out;
>> +
>> +       LIBBPF_OPTS_RESET(ctx.opts);
>> +       ctx.opts.btf_fd = bpf_object__btf_fd(skel->obj);
>> +       if (!ASSERT_GE((int)ctx.opts.btf_fd, 0, "btf_fd"))
>> +               goto out;
>> +       ctx.opts.btf_key_type_id = btf__find_by_name(btf, "int");
>> +       if (!ASSERT_GT(ctx.opts.btf_key_type_id, 0, "key_type_id"))
>> +               goto out;
>> +       ctx.opts.btf_value_type_id = btf__find_by_name_kind(btf, "inner_value", BTF_KIND_STRUCT);
>> +       if (!ASSERT_GT(ctx.opts.btf_value_type_id, 0, "value_type_id"))
>> +               goto out;
>> +
>> +       err = timer_init_race__attach(skel);
>> +       if (!ASSERT_EQ(err, 0, "timer_init_race attach"))
>> +               goto out;
>> +
>> +       skel->bss->tgid = getpid();
>> +
>> +       pthread_barrier_init(&ctx.barrier, NULL, 2);
>> +       ctx.outer_map_fd = bpf_map__fd(skel->maps.outer_map);
>> +       ctx.loop = 8;
>> +
>> +       err = pthread_create(&tid[0], NULL, close_map_fn, &ctx);
>> +       if (!ASSERT_OK(err, "close_thread"))
>> +               goto out;
>> +
>> +       err = pthread_create(&tid[1], NULL, init_timer_fn, &ctx);
>> +       if (!ASSERT_OK(err, "init_thread")) {
>> +               ctx.abort = 1;
>> +               pthread_join(tid[0], NULL);
>> +               goto out;
>> +       }
>> +
>> +       ctx.start = 1;
>> +       pthread_join(tid[0], NULL);
>> +       pthread_join(tid[1], NULL);
>> +
>> +       ASSERT_EQ(ctx.err, 0, "error");
>> +       ASSERT_EQ(skel->bss->cnt, 8, "cnt");
>> +out:
>> +       timer_init_race__destroy(skel);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/timer_init_race.c b/tools/testing/selftests/bpf/progs/timer_init_race.c
>> new file mode 100644
>> index 0000000000000..ba67cb1786399
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/timer_init_race.c
>> @@ -0,0 +1,56 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
>> +#include <linux/bpf.h>
>> +#include <time.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +#include "bpf_misc.h"
>> +
>> +struct inner_value {
>> +       struct bpf_timer timer;
>> +};
>> +
>> +struct inner_map_type {
>> +       __uint(type, BPF_MAP_TYPE_ARRAY);
>> +       __type(key, int);
>> +       __type(value, struct inner_value);
>> +       __uint(max_entries, 1);
>> +} inner_map SEC(".maps");
>> +
>> +struct {
>> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>> +       __type(key, int);
>> +       __type(value, int);
>> +       __uint(max_entries, 1);
>> +       __array(values, struct inner_map_type);
>> +} outer_map SEC(".maps") = {
>> +       .values = {
>> +               [0] = &inner_map,
>> +       },
>> +};
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +int tgid = 0, cnt = 0;
>> +
>> +SEC("kprobe/" SYS_PREFIX "sys_getpgid")
>> +int do_timer_init(void *ctx)
>> +{
>> +       struct inner_map_type *map;
>> +       struct inner_value *value;
>> +       int zero = 0;
>> +
>> +       if ((bpf_get_current_pid_tgid() >> 32) != tgid)
>> +               return 0;
>> +
>> +       map = bpf_map_lookup_elem(&outer_map, &zero);
>> +       if (!map)
>> +               return 0;
>> +       value = bpf_map_lookup_elem(map, &zero);
>> +       if (!value)
>> +               return 0;
>> +       bpf_timer_init(&value->timer, map, CLOCK_MONOTONIC);
>> +       cnt++;
>> +
>> +       return 0;
>> +}
>> --
>> 2.29.2
>>
> .


