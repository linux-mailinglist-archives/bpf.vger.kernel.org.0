Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6637E63BB1E
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 08:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiK2H4j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 02:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiK2H4i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 02:56:38 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359074FFBF;
        Mon, 28 Nov 2022 23:56:36 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NLvlw02XVz15Myl;
        Tue, 29 Nov 2022 15:55:56 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 15:56:33 +0800
Subject: Re: [net-next] bpf: avoid hashtab deadlock with try_lock
To:     Tonghao Zhang <xiangxia.m.yue@gmail.com>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Hao Luo <haoluo@google.com>
References: <20221121100521.56601-1-xiangxia.m.yue@gmail.com>
 <20221121100521.56601-2-xiangxia.m.yue@gmail.com>
 <7ed2f531-79a3-61fe-f1c2-b004b752c3f7@huawei.com>
 <CAMDZJNUiPOcnpNg8tM4xCoJABJz_3=AaXLTm5ofQg64mGDkB_A@mail.gmail.com>
 <9278cf3f-dfb6-78eb-8862-553545dac7ed@huawei.com>
 <41eda0ea-0ed4-1ffb-5520-06fda08e5d38@huawei.com>
 <CAMDZJNVSv3Msxw=5PRiXyO8bxNsA-4KyxU8BMCVyHxH-3iuq2Q@mail.gmail.com>
 <fdb3b69c-a29c-2d5b-a122-9d98ea387fda@huawei.com>
 <CAMDZJNWTry2eF_n41a13tKFFSSLFyp3BVKakOOWhSDApdp0f=w@mail.gmail.com>
 <CA+khW7jgsyFgBqU7hCzZiSSANE7f=A+M-0XbcKApz6Nr-ZnZDg@mail.gmail.com>
 <07a7491e-f391-a9b2-047e-cab5f23decc5@huawei.com>
 <CAMDZJNUTaiXMe460P7a7NfK1_bbaahpvi3Q9X85o=G7v9x-w=g@mail.gmail.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <386296f5-198d-169b-3399-18b29b867d32@huawei.com>
Date:   Tue, 29 Nov 2022 15:56:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAMDZJNUTaiXMe460P7a7NfK1_bbaahpvi3Q9X85o=G7v9x-w=g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 11/29/2022 2:06 PM, Tonghao Zhang wrote:
> On Tue, Nov 29, 2022 at 12:32 PM Hou Tao <houtao1@huawei.com> wrote:
>> Hi,
>>
>> On 11/29/2022 5:55 AM, Hao Luo wrote:
>>> On Sun, Nov 27, 2022 at 7:15 PM Tonghao Zhang <xiangxia.m.yue@gmail.com> wrote:
>>> Hi Tonghao,
>>>
>>> With a quick look at the htab_lock_bucket() and your problem
>>> statement, I agree with Hou Tao that using hash &
>>> min(HASHTAB_MAP_LOCK_MASK, n_bucket - 1) to index in map_locked seems
>>> to fix the potential deadlock. Can you actually send your changes as
>>> v2 so we can take a look and better help you? Also, can you explain
>>> your solution in your commit message? Right now, your commit message
>>> has only a problem statement and is not very clear. Please include
>>> more details on what you do to fix the issue.
>>>
>>> Hao
>> It would be better if the test case below can be rewritten as a bpf selftests.
>> Please see comments below on how to improve it and reproduce the deadlock.
>>>> Hi
>>>> only a warning from lockdep.
>> Thanks for your details instruction.  I can reproduce the warning by using your
>> setup. I am not a lockdep expert, it seems that fixing such warning needs to set
>> different lockdep class to the different bucket. Because we use map_locked to
>> protect the acquisition of bucket lock, so I think we can define  lock_class_key
>> array in bpf_htab (e.g., lockdep_key[HASHTAB_MAP_LOCK_COUNT]) and initialize the
>> bucket lock accordingly.
> Hi
> Thanks for your reply. define the lock_class_key array looks good.
> Last question: how about using  raw_spin_trylock_irqsave, if the
> bucket is locked on the same or other cpu.
> raw_spin_trylock_irqsave will return the false, we should return the
> -EBUSY in htab_lock_bucket.
>
> static inline int htab_lock_bucket(struct bucket *b,
>                                    unsigned long *pflags)
> {
>         unsigned long flags;
>
>         if (!raw_spin_trylock_irqsave(&b->raw_lock, flags))
>                 return -EBUSY;
>
>         *pflags = flags;
>         return 0;
> }
The flaw of trylock solution is that it can not distinguish between dead-lock
and lock with high contention. So I don't think it is a good idea to do that.
>
>>>> 1. the kernel .config
>>>> #
>>>> # Debug Oops, Lockups and Hangs
>>>> #
>>>> CONFIG_PANIC_ON_OOPS=y
>>>> CONFIG_PANIC_ON_OOPS_VALUE=1
>>>> CONFIG_PANIC_TIMEOUT=0
>>>> CONFIG_LOCKUP_DETECTOR=y
>>>> CONFIG_SOFTLOCKUP_DETECTOR=y
>>>> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
>>>> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
>>>> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
>>>> CONFIG_HARDLOCKUP_DETECTOR=y
>>>> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
>>>> CONFIG_DETECT_HUNG_TASK=y
>>>> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
>>>> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
>>>> # CONFIG_WQ_WATCHDOG is not set
>>>> # CONFIG_TEST_LOCKUP is not set
>>>> # end of Debug Oops, Lockups and Hangs
>>>>
>>>> 2. bpf.c, the map size is 2.
>>>> struct {
>>>> __uint(type, BPF_MAP_TYPE_HASH);
>> Adding __uint(map_flags, BPF_F_ZERO_SEED); to ensure there will be no seed for
>> hash calculation, so we can use key=4 and key=20 to construct the case that
>> these two keys have the same bucket index but have different map_locked index.
>>>> __uint(max_entries, 2);
>>>> __uint(key_size, sizeof(unsigned int));
>>>> __uint(value_size, sizeof(unsigned int));
>>>> } map1 SEC(".maps");
>>>>
>>>> static int bpf_update_data()
>>>> {
>>>> unsigned int val = 1, key = 0;
>> key = 20
>>>> return bpf_map_update_elem(&map1, &key, &val, BPF_ANY);
>>>> }
>>>>
>>>> SEC("kprobe/ip_rcv")
>>>> int bpf_prog1(struct pt_regs *regs)
>>>> {
>>>> bpf_update_data();
>>>> return 0;
>>>> }
>> kprobe on ip_rcv is unnecessary, you can just remove it.
>>>> SEC("tracepoint/nmi/nmi_handler")
>>>> int bpf_prog2(struct pt_regs *regs)
>>>> {
>>>> bpf_update_data();
>>>> return 0;
>>>> }
>> Please use SEC("fentry/nmi_handle") instead of SEC("tracepoint") and unfold
>> bpf_update_data(), because the running of bpf program on tracepoint will be
>> blocked by bpf_prog_active which will be increased bpf_map_update_elem through
>> bpf_disable_instrumentation().
>>>> char _license[] SEC("license") = "GPL";
>>>> unsigned int _version SEC("version") = LINUX_VERSION_CODE;
>>>>
>>>> 3. bpf loader.
>>>> #include "kprobe-example.skel.h"
>>>>
>>>> #include <unistd.h>
>>>> #include <errno.h>
>>>>
>>>> #include <bpf/bpf.h>
>>>>
>>>> int main()
>>>> {
>>>> struct kprobe_example *skel;
>>>> int map_fd, prog_fd;
>>>> int i;
>>>> int err = 0;
>>>>
>>>> skel = kprobe_example__open_and_load();
>>>> if (!skel)
>>>> return -1;
>>>>
>>>> err = kprobe_example__attach(skel);
>>>> if (err)
>>>> goto cleanup;
>>>>
>>>> /* all libbpf APIs are usable */
>>>> prog_fd = bpf_program__fd(skel->progs.bpf_prog1);
>>>> map_fd = bpf_map__fd(skel->maps.map1);
>>>>
>>>> printf("map_fd: %d\n", map_fd);
>>>>
>>>> unsigned int val = 0, key = 0;
>>>>
>>>> while (1) {
>>>> bpf_map_delete_elem(map_fd, &key);
>> No needed neither. Only do bpf_map_update_elem() is OK. Also change key=0 from
>> key=4, so it will have the same bucket index as key=20 but have different
>> map_locked index.
>>>> bpf_map_update_elem(map_fd, &key, &val, BPF_ANY);
>>>> }
>> Also need to pin the process on a specific CPU (e.g., CPU 0)
>>>> cleanup:
>>>> kprobe_example__destroy(skel);
>>>> return err;
>>>> }
>>>>
>>>> 4. run the bpf loader and perf record for nmi interrupts.  the warming occurs
>> For perf event, you can reference prog_tests/find_vma.c on how to using
>> perf_event_open to trigger a perf nmi interrupt. The perf event also needs to
>> pin on a specific CPU as the caller of bpf_map_update_elem() does.
>>
>>>> --
>>>> Best regards, Tonghao
>>> .
>

