Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2776B6713D3
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 07:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjARGWE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 01:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjARGTv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 01:19:51 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D71134617D;
        Tue, 17 Jan 2023 22:07:17 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxSurmi8dj40QCAA--.6799S3;
        Wed, 18 Jan 2023 14:04:22 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axvr7ki8djMysbAA--.56965S3;
        Wed, 18 Jan 2023 14:04:21 +0800 (CST)
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix undeclared identifier build
 errors of test_bpf_nf.c
To:     Yonghong Song <yhs@meta.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
References: <1673844908-11533-1-git-send-email-yangtiezhu@loongson.cn>
 <14e0f634f084d0f07e447638c490da60943507d6.camel@gmail.com>
 <556dc633-e7fb-da8a-1fa9-757684edd3a4@oracle.com>
 <dffe5523-4ff7-8b27-46fa-079a9556166f@meta.com>
 <d299be28-42f5-b387-5b54-74694ff5f340@loongson.cn>
 <f8b5ef05-4dd1-eb3e-c6e0-af47169d7b8e@meta.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <2e396e21-1a91-aebe-35b2-09774fe71cf7@loongson.cn>
Date:   Wed, 18 Jan 2023 14:04:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <f8b5ef05-4dd1-eb3e-c6e0-af47169d7b8e@meta.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Axvr7ki8djMysbAA--.56965S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoW3tF1kur45AF48Kr4DZw48tFb_yoW8Jw1fKo
        ZxGF1fKa17Kr1xXa40g3ZYkrZxWw10kryrJryUKw15Jay5t342kr1UCw4UZF4jvF4rG3Z7
        W3ZxCw43Za45WF1kn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2
        z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2
        IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcApnDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 01/18/2023 02:29 AM, Yonghong Song wrote:
>
>
> On 1/17/23 1:52 AM, Tiezhu Yang wrote:
>>
>>
>> On 01/17/2023 02:48 PM, Yonghong Song wrote:
>>>
>>>
>>> On 1/16/23 5:54 AM, Alan Maguire wrote:
>>>> On 16/01/2023 12:30, Eduard Zingerman wrote:
>>>>> On Mon, 2023-01-16 at 12:55 +0800, Tiezhu Yang wrote:
>>>>>> $ make -C tools/testing/selftests/bpf/
>>>>>>
>>>>>>    CLNG-BPF [test_maps] test_bpf_nf.bpf.o
>>>>>> progs/test_bpf_nf.c:160:42: error: use of undeclared identifier
>>>>>> 'NF_NAT_MANIP_SRC'
>>>>>>                  bpf_ct_set_nat_info(ct, &saddr, sport,
>>>>>> NF_NAT_MANIP_SRC);
>>>>>>                                                         ^
>>>>>> progs/test_bpf_nf.c:163:42: error: use of undeclared identifier
>>>>>> 'NF_NAT_MANIP_DST'
>>>>>>                  bpf_ct_set_nat_info(ct, &daddr, dport,
>>>>>> NF_NAT_MANIP_DST);
>>>>>>                                                         ^
>>>>>> 2 errors generated.
>>>>>>
>>>>>> Copy the definitions in include/net/netfilter/nf_nat.h to
>>>>>> test_bpf_nf.c
>>>>>> to fix the above build errors.
>>>>>>
>>>>>> Fixes: b06b45e82b59 ("selftests/bpf: add tests for
>>>>>> bpf_ct_set_nat_info kfunc")
>>>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>>>> ---
>>>>>>   tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
>>>>>>   1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>>>>>> b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>>>>>> index 227e85e..114f961 100644
>>>>>> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>>>>>> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>>>>>> @@ -34,6 +34,11 @@ __be16 dport = 0;
>>>>>>   int test_exist_lookup = -ENOENT;
>>>>>>   u32 test_exist_lookup_mark = 0;
>>>>>>   +enum nf_nat_manip_type {
>>>>>> +    NF_NAT_MANIP_SRC,
>>>>>> +    NF_NAT_MANIP_DST
>>>>>> +};
>>>>>> +
>>>>>
>>>>> This is confusing, when I build the kernel/tests I get the declaration
>>>>> the "enum nf_nat_manip_type" from the vmlinux.h (which is included
>>>>> from test_bpf_nf.c).
>>>>> Which means that this patch results in compilation error with my
>>>>> configuration.
>>>>> Is there a chance that your kernel is configured without some
>>>>> necessary netfilter
>>>>> configuration options? Have you tried this patch with BPF CI?
>>>>>
>>>>
>>>> Yep; I suspect if CONFIG_NF_NAT=m , the required definitions won't
>>>> make it
>>>> into vmlinux.h. The reference tools/testing/seftests/bpf/config has
>>>> CONFIG_NF_NAT=y so it is at least documented in the referenced config.
>>>>
>>>> I'd suggest going the route of
>>>>
>>>> commit aa67961f3243dfff26c47769f87b4d94b07ec71f
>>>> Author: Martin KaFai Lau <martin.lau@kernel.org>
>>>> Date:   Tue Dec 6 11:35:54 2022 -0800
>>>>
>>>>      selftests/bpf: Allow building bpf tests with
>>>> CONFIG_XFRM_INTERFACE=[m|n]
>>>>      ...and adding/using local definitons like:
>>>>
>>>> enum nf_nat_manip_type_local {
>>>>     NF_NAT_MANIP_SRC_LOCAL,
>>>>     NF_NAT_MANIP_DST_LOCAL
>>>> };
>>>
>>> The above won't support core, and since preserve_access_index attribute
>>> does not support enum for now. We need to use bpf_core_enum_value to
>>> retrieve the proper value through CORE.
>>>
>>> could you try the following?
>>>
>>> enum nf_nat_manip_type___local {
>>>     NF_NAT_MANIP_SRC___LOCAL,
>>>     NF_NAT_MANIP_DST___LOCAL,
>>> };
>>
>> This is OK, it is similar with commit 1058b6a78db2 ("selftests/bpf: Do
>> not fail build if CONFIG_NF_CONNTRACK=m/n").
>>
>>>
>>> ...
>>> bpf_ct_set_nat_info(ct, &saddr, sport, bpf_core_enum_value(enum
>>> nf_nat_manip_type___local,  NF_NAT_MANIP_SRC___LOCAL));
>>> ...
>>>
>>> bpf_ct_set_nat_info(ct, &daddr, dport, bpf_core_enum_value(enum
>>> nf_nat_manip_type___local,  NF_NAT_MANIP_DST___LOCAL));
>>>
>>> whether it works or not? Could you also try if the
>>> enumerator sequence in enum nf_nat_manip_type___local changed?
>>>
>>>>
>>>> ...to avoid the name clash.
>>>>
>>>>
>>>> Alan
>>
>> I tested this on x86_64 fedora 36, using config-5.17.5-300.fc36.x86_64
>> to generate .config, CONFIG_NF_CONNTRACK=m, CONFIG_NF_NAT=m, there are
>> no definitions of NF_NAT_MANIP_SRC and NF_NAT_MANIP_DST in vmlinux.h,
>> build test_bpf_nf.c failed.
>
> Thanks for trying. Yes, I tried in my environment and it failed because
> I didn't change the enum nf_nat_manip_type type for kfunc:
> int bpf_ct_set_nat_info(struct nf_conn *, union nf_inet_addr *,
>                         int port, enum nf_nat_manip_type) __ksym;
>
> But when I changed 'enum nf_nat_manip_type' to
> 'enum nf_nat_manip_type___local', kernel complains kfunc argument
> mismatch. The reason most likely is 'enum nf_nat_manip_type___local'
> is not converted to 'enum nf_nat_manip_type' by libbpf.
>
> This might be expected as preserve_access_index attribute only
> supports record (struct/union) type and libbpf might just do that.
> Could you double check whether this is the case or not?
>
> Maybe it is time to implement preserve_access_index support
> for enum type in clang now.
>
> But we need to resolve the issue, even temporarily for now.
> See below.
>
>>
>> $ grep -w CONFIG_NF_CONNTRACK /boot/config-5.17.5-300.fc36.x86_64
>> CONFIG_NF_CONNTRACK=m
>> $ grep -w CONFIG_NF_NAT /boot/config-5.17.5-300.fc36.x86_64
>> CONFIG_NF_NAT=m
>>
>> I tested with various configs, the definitions of NF_NAT_MANIP_SRC and
>> NF_NAT_MANIP_DST in vmlinux.h only depend on CONFIG_NF_CONNTRACK=y.
>>
>> (1) CONFIG_NF_CONNTRACK=m, CONFIG_NF_NAT=m, no definitions
>> $ grep -w CONFIG_NF_CONNTRACK .config
>> CONFIG_NF_CONNTRACK=m
>> $ grep -w CONFIG_NF_NAT .config
>> CONFIG_NF_NAT=m
>> $ grep NF_NAT_MANIP_SRC
>> tools/testing/selftests/bpf/tools/include/vmlinux.h
>> $ grep NF_NAT_MANIP_DST
>> tools/testing/selftests/bpf/tools/include/vmlinux.h
>> $
>>
>> (2) CONFIG_NF_CONNTRACK=m, CONFIG_NF_NAT=y, no definitions
>> This case is unable, because CONFIG_NF_NAT depends on
>> CONFIG_NF_CONNTRACK.
>>
>> (3) CONFIG_NF_CONNTRACK=m, CONFIG_NF_NAT=n, no definitions
>> $ grep -w CONFIG_NF_CONNTRACK .config
>> CONFIG_NF_CONNTRACK=m
>> $ grep -w CONFIG_NF_NAT .config
>> # CONFIG_NF_NAT is not set
>> $ grep NF_NAT_MANIP_SRC
>> tools/testing/selftests/bpf/tools/include/vmlinux.h
>> $ grep NF_NAT_MANIP_DST
>> tools/testing/selftests/bpf/tools/include/vmlinux.h
>> $
>>
>> (4) CONFIG_NF_CONNTRACK=y, CONFIG_NF_NAT=m, have definitions
>> $ grep -w CONFIG_NF_CONNTRACK .config
>> CONFIG_NF_CONNTRACK=y
>> $ grep -w CONFIG_NF_NAT .config
>> CONFIG_NF_NAT=m
>> $ grep NF_NAT_MANIP_SRC
>> tools/testing/selftests/bpf/tools/include/vmlinux.h
>>      NF_NAT_MANIP_SRC = 0,
>> $ grep NF_NAT_MANIP_DST
>> tools/testing/selftests/bpf/tools/include/vmlinux.h
>>      NF_NAT_MANIP_DST = 1,
>>
>> (5) CONFIG_NF_CONNTRACK=y, CONFIG_NF_NAT=y, have definitions
>> $ grep -w CONFIG_NF_CONNTRACK .config
>> CONFIG_NF_CONNTRACK=y
>> $ grep -w CONFIG_NF_NAT .config
>> CONFIG_NF_NAT=y
>> $ grep NF_NAT_MANIP_SRC
>> tools/testing/selftests/bpf/tools/include/vmlinux.h
>>      NF_NAT_MANIP_SRC = 0,
>> $ grep NF_NAT_MANIP_DST
>> tools/testing/selftests/bpf/tools/include/vmlinux.h
>>      NF_NAT_MANIP_DST = 1,
>>
>> (6) CONFIG_NF_CONNTRACK=y, CONFIG_NF_NAT=n, have definitions
>> $ grep -w CONFIG_NF_CONNTRACK .config
>> CONFIG_NF_CONNTRACK=y
>> $ grep -w CONFIG_NF_NAT .config
>> # CONFIG_NF_NAT is not set
>> $ grep NF_NAT_MANIP_SRC
>> tools/testing/selftests/bpf/tools/include/vmlinux.h
>>      NF_NAT_MANIP_SRC = 0,
>> $ grep NF_NAT_MANIP_DST
>> tools/testing/selftests/bpf/tools/include/vmlinux.h
>>      NF_NAT_MANIP_DST = 1,
>>
>> (7) CONFIG_NF_CONNTRACK=n, CONFIG_NF_NAT=n, no definitions
>> $ grep -w CONFIG_NF_CONNTRACK .config
>> # CONFIG_NF_CONNTRACK is not set
>> $ grep -w CONFIG_NF_NAT .config
>> $ grep NF_NAT_MANIP_SRC
>> tools/testing/selftests/bpf/tools/include/vmlinux.h
>> $ grep NF_NAT_MANIP_DST
>> tools/testing/selftests/bpf/tools/include/vmlinux.h
>> $
>>
>> (8) CONFIG_NF_CONNTRACK=n, CONFIG_NF_NAT=y, no definitions
>> This case is unable, because CONFIG_NF_NAT depends on
>> CONFIG_NF_CONNTRACK.
>>
>> Here is an alternative change to check whether CONFIG_NF_CONNTRACK
>> is m, enum nf_nat_manip_type___local is simple, which one is better?
>>
>> $ git diff tools/testing/selftests/bpf/
>> diff --git a/tools/testing/selftests/bpf/Makefile
>> b/tools/testing/selftests/bpf/Makefile
>> index 22533a18705e..f3cf02046c20 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -325,7 +325,7 @@ endif
>>
>>   CLANG_SYS_INCLUDES = $(call
>> get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
>>   BPF_CFLAGS = -g -Werror -D__TARGET_ARCH_$(SRCARCH)
>> $(MENDIAN)          \
>> -            -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)                   \
>> +            -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR) -I$(TOOLSINCDIR)  \
>>               -I$(abspath $(OUTPUT)/../usr/include)
>>
>>   CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
>> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> index 227e85e85dda..f2101807072f 100644
>> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> @@ -2,6 +2,7 @@
>>   #include <vmlinux.h>
>>   #include <bpf/bpf_helpers.h>
>>   #include <bpf/bpf_endian.h>
>> +#include <linux/kconfig.h>
>>
>>   #define EAFNOSUPPORT 97
>>   #define EPROTO 71
>> @@ -34,6 +35,13 @@ __be16 dport = 0;
>>   int test_exist_lookup = -ENOENT;
>>   u32 test_exist_lookup_mark = 0;
>>
>> +#if IS_MODULE(CONFIG_NF_CONNTRACK)
>> +enum nf_nat_manip_type {
>> +       NF_NAT_MANIP_SRC,
>> +       NF_NAT_MANIP_DST
>> +};
>> +#endif
>> +
>
> The above change does not work for me. The complication failed with
>
>   CLNG-BPF [test_maps]
> btf__core_reloc_nesting___err_missing_container.bpf.o
>   CLNG-BPF [test_maps] test_sysctl_loop2.bpf.o
> progs/test_bpf_nf.c:168:42: error: use of undeclared identifier
> 'NF_NAT_MANIP_SRC'
>                 bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
>                                                        ^
> progs/test_bpf_nf.c:171:42: error: use of undeclared identifier
> 'NF_NAT_MANIP_DST'
>                 bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
>                                                        ^
> 2 errors generated.
>
>
> Apparently, IS_MODULE(...) is recognized but it returns 0.
> I do have CONFIG_NF_CONNTRACK=m in my config.
> Note that I build the kernel with KBUILD_OUTPUT=<another dir>
> (make -j LLVM=1) so vmlinux is in a different place.
> While I build selftest
> with 'make -C tools/testing/selftests/bpf -j LLVM=1' which
> is in-tree.
>
>>   struct nf_conn;
>>
>>   struct bpf_ct_opts___local {
>>
>> Note that when unset CONFIG_NF_CONNTRACK, there are much more
>> build errors, I do not know whether it is necessary to fix it
>> and how to fix it properly. Here, I only consider the failed
>> case CONFIG_NF_CONNTRACK=m.
>>
>> Thanks,
>> Tiezhu
>>

I have the following test environment:

system: x86_64 fedora 36
kernel: the latest bpf-next
clang: version 14.0.5 (Fedora 14.0.5-1.fc36)
gcc: 12.2.1 20220819 (Red Hat 12.2.1-2)

With the following changes, there are no any build errors and
warnings if
(1) CONFIG_NF_CONNTRACK=m, CONFIG_NF_NAT=m
(2) CONFIG_NF_CONNTRACK=y, CONFIG_NF_NAT=m
(3) CONFIG_NF_CONNTRACK=y, CONFIG_NF_NAT=y

$ git diff
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c 
b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 227e85e85dda..9fc603c9d673 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -34,6 +34,11 @@ __be16 dport = 0;
  int test_exist_lookup = -ENOENT;
  u32 test_exist_lookup_mark = 0;

+enum nf_nat_manip_type___local {
+       NF_NAT_MANIP_SRC___local,
+       NF_NAT_MANIP_DST___local
+};
+
  struct nf_conn;

  struct bpf_ct_opts___local {
@@ -58,7 +63,7 @@ int bpf_ct_change_timeout(struct nf_conn *, u32) __ksym;
  int bpf_ct_set_status(struct nf_conn *, u32) __ksym;
  int bpf_ct_change_status(struct nf_conn *, u32) __ksym;
  int bpf_ct_set_nat_info(struct nf_conn *, union nf_inet_addr *,
-                       int port, enum nf_nat_manip_type) __ksym;
+                       int port, enum nf_nat_manip_type___local) __ksym;

  static __always_inline void
  nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple 
*, u32,
@@ -157,10 +162,10 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, 
struct bpf_sock_tuple *, u32,

                 /* snat */
                 saddr.ip = bpf_get_prandom_u32();
-               bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
+               bpf_ct_set_nat_info(ct, &saddr, sport, 
NF_NAT_MANIP_SRC___local);
                 /* dnat */
                 daddr.ip = bpf_get_prandom_u32();
-               bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
+               bpf_ct_set_nat_info(ct, &daddr, dport, 
NF_NAT_MANIP_DST___local);

                 ct_ins = bpf_ct_insert_entry(ct);
                 if (ct_ins) {

I will send it as a normal patch for your review, let us see what is
the status of BPF CI.

Thanks,
Tiezhu

