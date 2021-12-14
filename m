Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D8F474CF7
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 22:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhLNVJX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 16:09:23 -0500
Received: from www62.your-server.de ([213.133.104.62]:57024 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhLNVJX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 16:09:23 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mxF31-000Dxo-6W; Tue, 14 Dec 2021 22:09:19 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mxF30-0003rN-Vk; Tue, 14 Dec 2021 22:09:19 +0100
Subject: Re: [PATCH v3 bpf-next 1/2] libbpf: auto-bump RLIMIT_MEMLOCK if
 kernel needs it for BPF
To:     Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20211214004856.3785613-1-andrii@kernel.org>
 <20211214004856.3785613-2-andrii@kernel.org>
 <177504f5-c89a-a05e-8542-9c326d9a10c1@iogearbox.net>
 <CAEf4BzYRQcpd5meQ21oOBWdKdUnSM2VLF9oTV9kQrX8cmnk==Q@mail.gmail.com>
 <9656836e-f9ea-f1ff-80c2-f4aba51f0d8d@fb.com>
 <CAEf4BzbmBNRB0sWAxHpSaW6fYMbgrCDm9K=8XScYGa2PEpdsPA@mail.gmail.com>
 <35b54575-ede0-e9b3-ad3c-4b18ffe0089e@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <59860cf4-2113-9e8a-3edb-1b7a19dff2c6@iogearbox.net>
Date:   Tue, 14 Dec 2021 22:09:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <35b54575-ede0-e9b3-ad3c-4b18ffe0089e@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26387/Tue Dec 14 10:33:30 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/14/21 9:51 PM, Alexei Starovoitov wrote:
> On 12/14/21 10:31 AM, Andrii Nakryiko wrote:
>> On Tue, Dec 14, 2021 at 9:58 AM Alexei Starovoitov <ast@fb.com> wrote:
>>> On 12/14/21 9:51 AM, Andrii Nakryiko wrote:
>>>> On Tue, Dec 14, 2021 at 7:09 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>> On 12/14/21 1:48 AM, Andrii Nakryiko wrote:
>>>>>> The need to increase RLIMIT_MEMLOCK to do anything useful with BPF is
>>>>>> one of the first extremely frustrating gotchas that all new BPF users go
>>>>>> through and in some cases have to learn it a very hard way.
>>>>>>
>>>>>> Luckily, starting with upstream Linux kernel version 5.11, BPF subsystem
>>>>>> dropped the dependency on memlock and uses memcg-based memory accounting
>>>>>> instead. Unfortunately, detecting memcg-based BPF memory accounting is
>>>>>> far from trivial (as can be evidenced by this patch), so in practice
>>>>>> most BPF applications still do unconditional RLIMIT_MEMLOCK increase.
>>>>>>
>>>>>> As we move towards libbpf 1.0, it would be good to allow users to forget
>>>>>> about RLIMIT_MEMLOCK vs memcg and let libbpf do the sensible adjustment
>>>>>> automatically. This patch paves the way forward in this matter. Libbpf
>>>>>> will do feature detection of memcg-based accounting, and if detected,
>>>>>> will do nothing. But if the kernel is too old, just like BCC, libbpf
>>>>>> will automatically increase RLIMIT_MEMLOCK on behalf of user
>>>>>> application ([0]).
>>>>>>
>>>>>> As this is technically a breaking change, during the transition period
>>>>>> applications have to opt into libbpf 1.0 mode by setting
>>>>>> LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK bit when calling
>>>>>> libbpf_set_strict_mode().
>>>>>>
>>>>>> Libbpf allows to control the exact amount of set RLIMIT_MEMLOCK limit
>>>>>> with libbpf_set_memlock_rlim_max() API. Passing 0 will make libbpf do
>>>>>> nothing with RLIMIT_MEMLOCK. libbpf_set_memlock_rlim_max() has to be
>>>>>> called before the first bpf_prog_load(), bpf_btf_load(), or
>>>>>> bpf_object__load() call, otherwise it has no effect and will return
>>>>>> -EBUSY.
>>>>>>
>>>>>>      [0] Closes: https://github.com/libbpf/libbpf/issues/369
>>>>>>
>>>>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>>>> [...]
>>>>>>
>>>>>> +/* Probe whether kernel switched from memlock-based (RLIMIT_MEMLOCK) to
>>>>>> + * memcg-based memory accounting for BPF maps and progs. This was done in [0].
>>>>>> + * We use the difference in reporting memlock value in BPF map's fdinfo before
>>>>>> + * and after [0] to detect whether memcg accounting is done for BPF subsystem
>>>>>> + * or not.
>>>>>> + *
>>>>>> + * Before the change, memlock value for ARRAY map would be calculated as:
>>>>>> + *
>>>>>> + *   memlock = sizeof(struct bpf_array) + round_up(value_size, 8) * max_entries;
>>>>>> + *   memlock = round_up(memlock, PAGE_SIZE);
>>>>>> + *
>>>>>> + *
>>>>>> + * After, memlock is approximated as:
>>>>>> + *
>>>>>> + *   memlock = round_up(key_size + value_size, 8) * max_entries;
>>>>>> + *   memlock = round_up(memlock, PAGE_SIZE);
>>>>>> + *
>>>>>> + * In this check we use the fact that sizeof(struct bpf_array) is about 300
>>>>>> + * bytes, so if we use value_size = (PAGE_SIZE - 100), before memcg
>>>>>> + * approximation memlock would be rounded up to 2 * PAGE_SIZE, while with
>>>>>> + * memcg approximation it will stay at single PAGE_SIZE (key_size is 4 for
>>>>>> + * array and doesn't make much difference given 100 byte decrement we use for
>>>>>> + * value_size).
>>>>>> + *
>>>>>> + *   [0] https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com/
>>>>>> + */
>>>>>> +int probe_memcg_account(void)
>>>>>> +{
>>>>>> +     const size_t map_create_attr_sz = offsetofend(union bpf_attr, map_extra);
>>>>>> +     long page_sz = sysconf(_SC_PAGESIZE), memlock_sz;
>>>>>> +     char buf[128];
>>>>>> +     union bpf_attr attr;
>>>>>> +     int map_fd;
>>>>>> +     FILE *f;
>>>>>> +
>>>>>> +     memset(&attr, 0, map_create_attr_sz);
>>>>>> +     attr.map_type = BPF_MAP_TYPE_ARRAY;
>>>>>> +     attr.key_size = 4;
>>>>>> +     attr.value_size = page_sz - 100;
>>>>>> +     attr.max_entries = 1;
>>>>>> +     map_fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, map_create_attr_sz);
>>>>>> +     if (map_fd < 0)
>>>>>> +             return -errno;
>>>>>> +
>>>>>> +     sprintf(buf, "/proc/self/fdinfo/%d", map_fd);
>>>>>> +     f = fopen(buf, "r");
>>>>>> +     while (f && !feof(f) && fgets(buf, sizeof(buf), f)) {
>>>>>> +             if (fscanf(f, "memlock: %ld\n", &memlock_sz) == 1) {
>>>>>> +                     fclose(f);
>>>>>> +                     close(map_fd);
>>>>>> +                     return memlock_sz == page_sz ? 1 : 0;
>>>>>> +             }
>>>>>> +     }
>>>>>> +
>>>>>> +     /* proc FS is disabled or we failed to parse fdinfo properly, assume
>>>>>> +      * we need setrlimit
>>>>>> +      */
>>>>>> +     if (f)
>>>>>> +             fclose(f);
>>>>>> +     close(map_fd);
>>>>>> +     return 0;
>>>>>> +}
>>>>>
>>>>> One other option which might be slightly more robust perhaps could be to probe
>>>>> for a BPF helper that has been added along with 5.11 kernel. As Toke noted earlier
>>>>> it might not work with ooo backports, but if its good with RHEL in this specific
>>>>> case, we should be covered for 99% of cases. Potentially, we could then still try
>>>>> to fallback to the above probing logic?
>>>>
>>>> Ok, I was originally thinking of probe bpf_sock_from_file() (which was
>>>> added after memcg change), but it's PITA. But I see that slightly
>>>> before that (but in the same 5.11 release) bpf_ktime_get_coarse_ns()
>>>
>>> Note that it had fixes after that, so in the kernel version where
>>
>> You mean 5e0bc3082e2e ("bpf: Forbid bpf_ktime_get_coarse_ns and
>> bpf_timer_* in tracing progs"), right? This shouldn't matter if I use
>> BPF_PROG_TYPE_SOCKET_FILTER for probing.
> 
> hmm. I guess we allow it in unpriv too.
> 
>> fdinfo parsing approach has unnecessary dependency on PROCFS and is
>> more code (and very detailed knowledge of approximation and memlock
>> calculation formula). I like ktime_get_coarse_ns approach due to
>> minimal amount of code and no reliance on any other kernel config
>> besides CONFIG_BPF_SYSCALL.
>>
>> But in the end I care about the overall feature, not a particular
>> implementation of the detection. Should I send
>> ktime_get_coarse_ns-based approach or we go with this one? I've
>> implemented and tested all three variants already, so no time savings
>> are expected either way.
> 
> Either v3 or v4 are fine by me. Let Daniel pick.

Same here, I can take in v4 given less dependencies.

Thanks,
Daniel
