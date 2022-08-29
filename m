Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020415A408D
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 03:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiH2BMf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 21:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2BMe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 21:12:34 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC45B220FA
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 18:12:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MGC6z3sc8zKGpk
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 09:10:51 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgCXGy96EgxjuWZFAA--.25416S2;
        Mon, 29 Aug 2022 09:12:30 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: add test cases for htab
 update
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>, Hao Sun <sunhao.th@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <oss@lmb.io>, houtao1@huawei.com
References: <20220827100134.1621137-1-houtao@huaweicloud.com>
 <20220827100134.1621137-3-houtao@huaweicloud.com>
 <CACYkzJ6aAFvWuR4ozqAQjO2bDPQMsDX+q6fMxq64Xk7ZaKA51g@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <74f61b6d-f3d4-e601-8863-20dee1ca42e6@huaweicloud.com>
Date:   Mon, 29 Aug 2022 09:12:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CACYkzJ6aAFvWuR4ozqAQjO2bDPQMsDX+q6fMxq64Xk7ZaKA51g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgCXGy96EgxjuWZFAA--.25416S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFy5tF1kur1fGw4rtF4Utwb_yoW7Zw4Dpa
        y8Ca17KF4Iqw1UXr1Yqw42gF4Fvr4rWF1YyrWvg3W5ArWq9rn2qr1xKryrGF4xArs5Zr1r
        Z34UtFsrWw4xZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 8/29/2022 6:39 AM, KP Singh wrote:
> On Sat, Aug 27, 2022 at 11:43 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> One test demonstrates the reentrancy of hash map update fails, and
>> another one shows concureently updates of the same hash map bucket
> "concurrent updates of the same hashmap"
>
> This is just a description of what the test does but not why?
Will elaborate the description.
>
> What's the expected behaviour? Was it broken?
>
> I think your whole series will benefit from a cover letter to explain
> the stuff you are fixing.
Yes. There is a patch 0 for v2, but I forge to send it out.
>
>> succeed.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  .../selftests/bpf/prog_tests/htab_update.c    | 126 ++++++++++++++++++
>>  .../testing/selftests/bpf/progs/htab_update.c |  29 ++++
>>  2 files changed, 155 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_update.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/htab_update.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
>> new file mode 100644
>> index 000000000000..e2a4034daa79
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
>> @@ -0,0 +1,126 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
>> +#define _GNU_SOURCE
>> +#include <sched.h>
>> +#include <stdbool.h>
>> +#include <test_progs.h>
>> +#include "htab_update.skel.h"
>> +
>> +struct htab_update_ctx {
>> +       int fd;
>> +       int loop;
>> +       bool stop;
>> +};
>> +
>> +static void test_reenter_update(void)
>> +{
>> +       struct htab_update *skel;
>> +       unsigned int key, value;
>> +       int err;
>> +
>> +       skel = htab_update__open();
>> +       if (!ASSERT_OK_PTR(skel, "htab_update__open"))
>> +               return;
>> +
>> +       /* lookup_elem_raw() may be inlined and find_kernel_btf_id() will return -ESRCH */
>> +       bpf_program__set_autoload(skel->progs.lookup_elem_raw, true);
>> +       err = htab_update__load(skel);
>> +       if (!ASSERT_TRUE(!err || err == -ESRCH, "htab_update__load") || err)
>> +               goto out;
>> +
>> +       skel->bss->pid = getpid();
>> +       err = htab_update__attach(skel);
>> +       if (!ASSERT_OK(err, "htab_update__attach"))
>> +               goto out;
>> +
>> +       /* Will trigger the reentrancy of bpf_map_update_elem() */
>> +       key = 0;
>> +       value = 0;
> nit: just move these initializations to the top.
>
>> +       err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, &value, 0);
>> +       if (!ASSERT_OK(err, "add element"))
>> +               goto out;
>> +
>> +       ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
>> +out:
>> +       htab_update__destroy(skel);
>> +}
>> +
>> +static void *htab_update_thread(void *arg)
>> +{
>> +       struct htab_update_ctx *ctx = arg;
>> +       cpu_set_t cpus;
>> +       int i;
>> +
>> +       /* Pin on CPU 0 */
>> +       CPU_ZERO(&cpus);
>> +       CPU_SET(0, &cpus);
>> +       pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);
>> +
>> +       i = 0;
>> +       while (i++ < ctx->loop && !ctx->stop) {
> nit: for loop?
>
>
>> +               unsigned int key = 0, value = 0;
>> +               int err;
>> +
>> +               err = bpf_map_update_elem(ctx->fd, &key, &value, 0);
>> +               if (err) {
>> +                       ctx->stop = true;
>> +                       return (void *)(long)err;
>> +               }
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static void test_concurrent_update(void)
>> +{
>> +       struct htab_update_ctx ctx;
>> +       struct htab_update *skel;
>> +       unsigned int i, nr;
>> +       pthread_t *tids;
>> +       int err;
>> +
>> +       skel = htab_update__open_and_load();
>> +       if (!ASSERT_OK_PTR(skel, "htab_update__open_and_load"))
>> +               return;
>> +
>> +       ctx.fd = bpf_map__fd(skel->maps.htab);
>> +       ctx.loop = 1000;
>> +       ctx.stop = false;
>> +
>> +       nr = 4;
>> +       tids = calloc(nr, sizeof(*tids));
>> +       if (!ASSERT_NEQ(tids, NULL, "no mem"))
>> +               goto out;
>> +
>> +       for (i = 0; i < nr; i++) {
>> +               err = pthread_create(&tids[i], NULL, htab_update_thread, &ctx);
>> +               if (!ASSERT_OK(err, "pthread_create")) {
>> +                       unsigned int j;
>> +
>> +                       ctx.stop = true;
>> +                       for (j = 0; j < i; j++)
>> +                               pthread_join(tids[j], NULL);
>> +                       goto out;
>> +               }
>> +       }
>> +
>> +       for (i = 0; i < nr; i++) {
>> +               void *thread_err = NULL;
>> +
>> +               pthread_join(tids[i], &thread_err);
>> +               ASSERT_EQ(thread_err, NULL, "update error");
>> +       }
>> +
>> +out:
>> +       if (tids)
>> +               free(tids);
>> +       htab_update__destroy(skel);
>> +}
>> +
>> +void test_htab_update(void)
>> +{
>> +       if (test__start_subtest("reenter_update"))
>> +               test_reenter_update();
>> +       if (test__start_subtest("concurrent_update"))
>> +               test_concurrent_update();
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/htab_update.c b/tools/testing/selftests/bpf/progs/htab_update.c
>> new file mode 100644
>> index 000000000000..7481bb30b29b
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/htab_update.c
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2022. Huawei Technologies Co., Ltd */
>> +#include <linux/bpf.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +struct {
>> +       __uint(type, BPF_MAP_TYPE_HASH);
>> +       __uint(max_entries, 1);
>> +       __uint(key_size, sizeof(__u32));
>> +       __uint(value_size, sizeof(__u32));
>> +} htab SEC(".maps");
>> +
>> +int pid = 0;
>> +int update_err = 0;
>> +
>> +SEC("?fentry/lookup_elem_raw")
>> +int lookup_elem_raw(void *ctx)
>> +{
>> +       __u32 key = 0, value = 1;
>> +
>> +       if ((bpf_get_current_pid_tgid() >> 32) != pid)
>> +               return 0;
>> +
>> +       update_err = bpf_map_update_elem(&htab, &key, &value, 0);
>> +       return 0;
>> +}
>> --
>> 2.29.2
>>
> .

