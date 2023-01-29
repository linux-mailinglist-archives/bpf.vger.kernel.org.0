Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5F67FD1D
	for <lists+bpf@lfdr.de>; Sun, 29 Jan 2023 07:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjA2GZ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Jan 2023 01:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA2GZ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Jan 2023 01:25:26 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57A861ADFE;
        Sat, 28 Jan 2023 22:25:23 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxSupREdZjEUQJAA--.19213S3;
        Sun, 29 Jan 2023 14:25:21 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxtOVQEdZj6QEkAA--.38041S3;
        Sun, 29 Jan 2023 14:25:20 +0800 (CST)
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix build errors if
 CONFIG_NF_CONNTRACK=m
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <1674028604-7113-1-git-send-email-yangtiezhu@loongson.cn>
 <CAEf4BzZfBb75smH0uTn4E36T6vk1xhZZ+5_ONtdh9aFQCMH2pw@mail.gmail.com>
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
Message-ID: <496935ea-298e-db57-bcd1-b3fb6ae6608d@loongson.cn>
Date:   Sun, 29 Jan 2023 14:25:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZfBb75smH0uTn4E36T6vk1xhZZ+5_ONtdh9aFQCMH2pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxtOVQEdZj6QEkAA--.38041S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxuFW8Zw4kAw48Wr13Ar43ZFb_yoWxCrWUpF
        Z7ZFZ0yryDtan8uF1xZa97ur1rKFs29rWUJw1kJrWYkrZ8Zr15Xr1xKr43Ar98urWv9a1r
        Za4jgr9rAF1rAw7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5fHUUUUUU=
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 01/24/2023 07:17 AM, Andrii Nakryiko wrote:
> On Tue, Jan 17, 2023 at 11:57 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> If CONFIG_NF_CONNTRACK=m, there are no definitions of NF_NAT_MANIP_SRC
>> and NF_NAT_MANIP_DST in vmlinux.h, build test_bpf_nf.c failed.
>>
>> $ make -C tools/testing/selftests/bpf/
>>
>>   CLNG-BPF [test_maps] test_bpf_nf.bpf.o
>> progs/test_bpf_nf.c:160:42: error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
>>                 bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
>>                                                        ^
>> progs/test_bpf_nf.c:163:42: error: use of undeclared identifier 'NF_NAT_MANIP_DST'
>>                 bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
>>                                                        ^
>> 2 errors generated.
>>
>> Copy the definitions in include/net/netfilter/nf_nat.h to test_bpf_nf.c,
>> in order to avoid redefinitions if CONFIG_NF_CONNTRACK=y, rename them with
>> ___local suffix. This is similar with commit 1058b6a78db2 ("selftests/bpf:
>> Do not fail build if CONFIG_NF_CONNTRACK=m/n").
>>
>> Fixes: b06b45e82b59 ("selftests/bpf: add tests for bpf_ct_set_nat_info kfunc")
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  tools/testing/selftests/bpf/progs/test_bpf_nf.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> index 227e85e..9fc603c 100644
>> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> @@ -34,6 +34,11 @@ __be16 dport = 0;
>>  int test_exist_lookup = -ENOENT;
>>  u32 test_exist_lookup_mark = 0;
>>
>> +enum nf_nat_manip_type___local {
>> +       NF_NAT_MANIP_SRC___local,
>> +       NF_NAT_MANIP_DST___local
>> +};
>> +
>>  struct nf_conn;
>>
>>  struct bpf_ct_opts___local {
>> @@ -58,7 +63,7 @@ int bpf_ct_change_timeout(struct nf_conn *, u32) __ksym;
>>  int bpf_ct_set_status(struct nf_conn *, u32) __ksym;
>>  int bpf_ct_change_status(struct nf_conn *, u32) __ksym;
>>  int bpf_ct_set_nat_info(struct nf_conn *, union nf_inet_addr *,
>> -                       int port, enum nf_nat_manip_type) __ksym;
>> +                       int port, enum nf_nat_manip_type___local) __ksym;
>>
>>  static __always_inline void
>>  nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
>> @@ -157,10 +162,10 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
>>
>>                 /* snat */
>>                 saddr.ip = bpf_get_prandom_u32();
>> -               bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
>> +               bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC___local);
>>                 /* dnat */
>>                 daddr.ip = bpf_get_prandom_u32();
>> -               bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
>> +               bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST___local);
>>
>
> it would be a bit more reliable if you used `bpf_core_enum_value(enum
> nf_nat_manip_type___local, NF_NAT_MANIP_DST___local)`. That would make
> libbpf substitute correct absolute value, if actual enum
> nf_nat_manip_type in kernel ever changed. Please consider a follow up
> patch for this.

Sorry for the late reply, I tested the code as your suggestion, but it 
failed.

failed to resolve CO-RE relocation <enumval_value> [101] enum 
nf_nat_manip_type___local::NF_NAT_MANIP_SRC___local = 0

Is it necessary to send a follow patch now? Thank you.

Here are the test results.

(1) bpf_nf passed with the current code if CONFIG_NF_CONNTRACK=m:

[root@fedora bpf]# ./test_progs -a bpf_nf
#16/1    bpf_nf/xdp-ct:OK
#16/2    bpf_nf/tc-bpf-ct:OK
#16/3    bpf_nf/alloc_release:OK
#16/4    bpf_nf/insert_insert:OK
#16/5    bpf_nf/lookup_insert:OK
#16/6    bpf_nf/set_timeout_after_insert:OK
#16/7    bpf_nf/set_status_after_insert:OK
#16/8    bpf_nf/change_timeout_after_alloc:OK
#16/9    bpf_nf/change_status_after_alloc:OK
#16/10   bpf_nf/write_not_allowlisted_field:OK
#16      bpf_nf:OK
Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED

(2) bpf_nf failed with the following changes if CONFIG_NF_CONNTRACK=m:

[yangtiezhu@fedora bpf.git]$ git diff
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c 
b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 9fc603c9d673..f56ba60ab809 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -2,6 +2,7 @@
  #include <vmlinux.h>
  #include <bpf/bpf_helpers.h>
  #include <bpf/bpf_endian.h>
+#include <bpf/bpf_core_read.h>

  #define EAFNOSUPPORT 97
  #define EPROTO 71
@@ -162,10 +163,14 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, 
struct bpf_sock_tuple *, u32,

                 /* snat */
                 saddr.ip = bpf_get_prandom_u32();
-               bpf_ct_set_nat_info(ct, &saddr, sport, 
NF_NAT_MANIP_SRC___local);
+               bpf_ct_set_nat_info(ct, &saddr, sport,
+                                   bpf_core_enum_value(enum 
nf_nat_manip_type___local,
+ 
NF_NAT_MANIP_SRC___local));
                 /* dnat */
                 daddr.ip = bpf_get_prandom_u32();
-               bpf_ct_set_nat_info(ct, &daddr, dport, 
NF_NAT_MANIP_DST___local);
+               bpf_ct_set_nat_info(ct, &daddr, dport,
+                                   bpf_core_enum_value(enum 
nf_nat_manip_type___local,
+ 
NF_NAT_MANIP_DST___local));

                 ct_ins = bpf_ct_insert_entry(ct);
                 if (ct_ins) {

[root@fedora bpf]# ./test_progs -a bpf_nf
...
All error logs:
libbpf: prog 'nf_xdp_ct_test': BPF program load failed: Invalid argument
libbpf: prog 'nf_xdp_ct_test': -- BEGIN PROG LOAD LOG --
...
libbpf: failed to load object 'test_bpf_nf'
libbpf: failed to load BPF skeleton 'test_bpf_nf': -22
test_bpf_nf_ct:FAIL:test_bpf_nf__open_and_load unexpected error: -22
#16/1    bpf_nf/xdp-ct:FAIL
libbpf: prog 'nf_xdp_ct_test': BPF program load failed: Invalid argument
libbpf: prog 'nf_xdp_ct_test': -- BEGIN PROG LOAD LOG --
...
217: (bf) r1 = r7                     ; 
R1_w=ptr_nf_conn___init(ref_obj_id=18,off=0,imm=0) 
R7=ptr_nf_conn___init(ref_obj_id=18,off=0,imm=0) refs=18
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

Thanks,
Tiezhu

