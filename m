Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F49A68BD57
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 13:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBFMzO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 07:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBFMzN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 07:55:13 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C83B14EA4;
        Mon,  6 Feb 2023 04:55:10 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cx_eqt+OBj7ioPAA--.29604S3;
        Mon, 06 Feb 2023 20:55:09 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxIL+r+OBjYOEqAA--.46519S3;
        Mon, 06 Feb 2023 20:55:07 +0800 (CST)
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix build errors if
 CONFIG_NF_CONNTRACK=m
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <1674028604-7113-1-git-send-email-yangtiezhu@loongson.cn>
 <CAEf4BzZfBb75smH0uTn4E36T6vk1xhZZ+5_ONtdh9aFQCMH2pw@mail.gmail.com>
 <496935ea-298e-db57-bcd1-b3fb6ae6608d@loongson.cn>
 <CAEf4BzY5VNgPeR4cTkcpVAy4FSek2MaTMPYHKcGdmCVUbBbpfg@mail.gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <cc62c390-7f64-1f55-6f44-4c1c1c9b910f@loongson.cn>
Date:   Mon, 6 Feb 2023 20:55:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzY5VNgPeR4cTkcpVAy4FSek2MaTMPYHKcGdmCVUbBbpfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxIL+r+OBjYOEqAA--.46519S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxtw43Kry5tFWfur4rZF43Wrg_yoWfXw43pF
        W8AFWqyF1vqw4Y9F12va97CFyrtFs29ryUGw1kJrWYkrs0vFn8Jr1xtr47Cr98Xr40k3Wr
        Z34jqr9ruF1rAw7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCa
        FVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8qXdUUUUUU==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 02/04/2023 06:16 AM, Andrii Nakryiko wrote:
> On Sat, Jan 28, 2023 at 10:25 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>>
>>
>> On 01/24/2023 07:17 AM, Andrii Nakryiko wrote:
>>> On Tue, Jan 17, 2023 at 11:57 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>>
>>>> If CONFIG_NF_CONNTRACK=m, there are no definitions of NF_NAT_MANIP_SRC
>>>> and NF_NAT_MANIP_DST in vmlinux.h, build test_bpf_nf.c failed.
>>>>
>>>> $ make -C tools/testing/selftests/bpf/
>>>>
>>>>   CLNG-BPF [test_maps] test_bpf_nf.bpf.o
>>>> progs/test_bpf_nf.c:160:42: error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
>>>>                 bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
>>>>                                                        ^
>>>> progs/test_bpf_nf.c:163:42: error: use of undeclared identifier 'NF_NAT_MANIP_DST'
>>>>                 bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
>>>>                                                        ^
>>>> 2 errors generated.
>>>>
>>>> Copy the definitions in include/net/netfilter/nf_nat.h to test_bpf_nf.c,
>>>> in order to avoid redefinitions if CONFIG_NF_CONNTRACK=y, rename them with
>>>> ___local suffix. This is similar with commit 1058b6a78db2 ("selftests/bpf:
>>>> Do not fail build if CONFIG_NF_CONNTRACK=m/n").
>>>>
>>>> Fixes: b06b45e82b59 ("selftests/bpf: add tests for bpf_ct_set_nat_info kfunc")
>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>> ---
>>>>  tools/testing/selftests/bpf/progs/test_bpf_nf.c | 11 ++++++++---
>>>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>>>> index 227e85e..9fc603c 100644
>>>> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>>>> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>>>> @@ -34,6 +34,11 @@ __be16 dport = 0;
>>>>  int test_exist_lookup = -ENOENT;
>>>>  u32 test_exist_lookup_mark = 0;
>>>>
>>>> +enum nf_nat_manip_type___local {
>>>> +       NF_NAT_MANIP_SRC___local,
>>>> +       NF_NAT_MANIP_DST___local
>>>> +};
>>>> +
>>>>  struct nf_conn;
>>>>
>>>>  struct bpf_ct_opts___local {
>>>> @@ -58,7 +63,7 @@ int bpf_ct_change_timeout(struct nf_conn *, u32) __ksym;
>>>>  int bpf_ct_set_status(struct nf_conn *, u32) __ksym;
>>>>  int bpf_ct_change_status(struct nf_conn *, u32) __ksym;
>>>>  int bpf_ct_set_nat_info(struct nf_conn *, union nf_inet_addr *,
>>>> -                       int port, enum nf_nat_manip_type) __ksym;
>>>> +                       int port, enum nf_nat_manip_type___local) __ksym;
>>>>
>>>>  static __always_inline void
>>>>  nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
>>>> @@ -157,10 +162,10 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
>>>>
>>>>                 /* snat */
>>>>                 saddr.ip = bpf_get_prandom_u32();
>>>> -               bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
>>>> +               bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC___local);
>>>>                 /* dnat */
>>>>                 daddr.ip = bpf_get_prandom_u32();
>>>> -               bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
>>>> +               bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST___local);
>>>>
>>>
>>> it would be a bit more reliable if you used `bpf_core_enum_value(enum
>>> nf_nat_manip_type___local, NF_NAT_MANIP_DST___local)`. That would make
>>> libbpf substitute correct absolute value, if actual enum
>>> nf_nat_manip_type in kernel ever changed. Please consider a follow up
>>> patch for this.
>>
>> Sorry for the late reply, I tested the code as your suggestion, but it
>> failed.
>>
>> failed to resolve CO-RE relocation <enumval_value> [101] enum
>> nf_nat_manip_type___local::NF_NAT_MANIP_SRC___local = 0
>
>
> Was nf_conntrack kernel module loaded at the time when you ran the
> test? If yes, what's the output of

Yes, nf_conntrack was loaded when ran the test.

[root@fedora bpf]# lsmod | grep -w nf_conntrack
nf_conntrack          188416  4 
nf_nat,nft_ct,nf_conntrack_netbios_ns,nf_conntrack_broadcast
nf_defrag_ipv6         24576  1 nf_conntrack
nf_defrag_ipv4         16384  1 nf_conntrack

[root@fedora bpf]# ./test_progs -a bpf_nf
...
218: <invalid CO-RE relocation>
failed to resolve CO-RE relocation <enumval_value> [101] enum 
nf_nat_manip_type___local::NF_NAT_MANIP_SRC___local = 0
processed 170 insns (limit 1000000) max_states_per_insn 0 total_states 
12 peak_states 12 mark_read 2
-- END PROG LOAD LOG --
libbpf: prog 'nf_xdp_ct_test': failed to load: -22
libbpf: failed to load object 'test_bpf_nf'
libbpf: failed to load BPF skeleton 'test_bpf_nf': -22
test_bpf_nf_ct:FAIL:test_bpf_nf__open_and_load unexpected error: -22
#16/2    bpf_nf/tc-bpf-ct:FAIL
#16      bpf_nf:FAIL
Summary: 0/8 PASSED, 0 SKIPPED, 1 FAILED

>
> bpftool btf dump file /sys/kernel/btf/nf_conntrack | grep nf_nat_manip_type
>
> ?
>

[root@fedora bpf]# ./bpftool btf dump file /sys/kernel/btf/nf_conntrack 
| grep nf_nat_manip_type
[130070] ENUM 'nf_nat_manip_type' encoding=UNSIGNED size=4 vlen=2
[root@fedora bpf]# ./bpftool btf dump file /sys/kernel/btf/nf_conntrack 
| grep NF_NAT_MANIP_SRC
	'NF_NAT_MANIP_SRC' val=0
[root@fedora bpf]# ./bpftool btf dump file /sys/kernel/btf/nf_conntrack 
| grep NF_NAT_MANIP_DST
	'NF_NAT_MANIP_DST' val=1


Thanks,
Tiezhu

>>
>> Is it necessary to send a follow patch now? Thank you.
>>
>> Here are the test results.
>>
>> (1) bpf_nf passed with the current code if CONFIG_NF_CONNTRACK=m:
>>
>> [root@fedora bpf]# ./test_progs -a bpf_nf
>> #16/1    bpf_nf/xdp-ct:OK
>> #16/2    bpf_nf/tc-bpf-ct:OK
>> #16/3    bpf_nf/alloc_release:OK
>> #16/4    bpf_nf/insert_insert:OK
>> #16/5    bpf_nf/lookup_insert:OK
>> #16/6    bpf_nf/set_timeout_after_insert:OK
>> #16/7    bpf_nf/set_status_after_insert:OK
>> #16/8    bpf_nf/change_timeout_after_alloc:OK
>> #16/9    bpf_nf/change_status_after_alloc:OK
>> #16/10   bpf_nf/write_not_allowlisted_field:OK
>> #16      bpf_nf:OK
>> Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED
>>
>> (2) bpf_nf failed with the following changes if CONFIG_NF_CONNTRACK=m:
>>
>> [yangtiezhu@fedora bpf.git]$ git diff
>> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> index 9fc603c9d673..f56ba60ab809 100644
>> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> @@ -2,6 +2,7 @@
>>   #include <vmlinux.h>
>>   #include <bpf/bpf_helpers.h>
>>   #include <bpf/bpf_endian.h>
>> +#include <bpf/bpf_core_read.h>
>>
>>   #define EAFNOSUPPORT 97
>>   #define EPROTO 71
>> @@ -162,10 +163,14 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *,
>> struct bpf_sock_tuple *, u32,
>>
>>                  /* snat */
>>                  saddr.ip = bpf_get_prandom_u32();
>> -               bpf_ct_set_nat_info(ct, &saddr, sport,
>> NF_NAT_MANIP_SRC___local);
>> +               bpf_ct_set_nat_info(ct, &saddr, sport,
>> +                                   bpf_core_enum_value(enum
>> nf_nat_manip_type___local,
>> +
>> NF_NAT_MANIP_SRC___local));
>>                  /* dnat */
>>                  daddr.ip = bpf_get_prandom_u32();
>> -               bpf_ct_set_nat_info(ct, &daddr, dport,
>> NF_NAT_MANIP_DST___local);
>> +               bpf_ct_set_nat_info(ct, &daddr, dport,
>> +                                   bpf_core_enum_value(enum
>> nf_nat_manip_type___local,
>> +
>> NF_NAT_MANIP_DST___local));
>>
>>                  ct_ins = bpf_ct_insert_entry(ct);
>>                  if (ct_ins) {
>>
>> [root@fedora bpf]# ./test_progs -a bpf_nf
>> ...
>> All error logs:
>> libbpf: prog 'nf_xdp_ct_test': BPF program load failed: Invalid argument
>> libbpf: prog 'nf_xdp_ct_test': -- BEGIN PROG LOAD LOG --
>> ...
>> libbpf: failed to load object 'test_bpf_nf'
>> libbpf: failed to load BPF skeleton 'test_bpf_nf': -22
>> test_bpf_nf_ct:FAIL:test_bpf_nf__open_and_load unexpected error: -22
>> #16/1    bpf_nf/xdp-ct:FAIL
>> libbpf: prog 'nf_xdp_ct_test': BPF program load failed: Invalid argument
>> libbpf: prog 'nf_xdp_ct_test': -- BEGIN PROG LOAD LOG --
>> ...
>> 217: (bf) r1 = r7                     ;
>> R1_w=ptr_nf_conn___init(ref_obj_id=18,off=0,imm=0)
>> R7=ptr_nf_conn___init(ref_obj_id=18,off=0,imm=0) refs=18
>> 218: <invalid CO-RE relocation>
>> failed to resolve CO-RE relocation <enumval_value> [101] enum
>> nf_nat_manip_type___local::NF_NAT_MANIP_SRC___local = 0
>> processed 170 insns (limit 1000000) max_states_per_insn 0 total_states
>> 12 peak_states 12 mark_read 2
>> -- END PROG LOAD LOG --
>> libbpf: prog 'nf_xdp_ct_test': failed to load: -22
>> libbpf: failed to load object 'test_bpf_nf'
>> libbpf: failed to load BPF skeleton 'test_bpf_nf': -22
>> test_bpf_nf_ct:FAIL:test_bpf_nf__open_and_load unexpected error: -22
>> #16/2    bpf_nf/tc-bpf-ct:FAIL
>> #16      bpf_nf:FAIL
>> Summary: 0/8 PASSED, 0 SKIPPED, 1 FAILED
>>
>> Thanks,
>> Tiezhu
>>

