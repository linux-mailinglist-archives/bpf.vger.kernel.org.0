Return-Path: <bpf+bounces-17764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ECC8124AC
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF81AB2113C
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76A180D;
	Thu, 14 Dec 2023 01:44:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40992E0
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 17:44:35 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SrFWw53v1z4f3kF5
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 09:44:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 418751A01F0
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 09:44:31 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgA3hQv7XXplAHpYDg--.25378S2;
	Thu, 14 Dec 2023 09:44:31 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 4/4] selftests/bpf: Add test for abnormal cnt
 during multi-kprobe attachment
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 xingwei lee <xrivendell7@gmail.com>, houtao1@huawei.com
References: <20231213112531.3775079-1-houtao@huaweicloud.com>
 <20231213112531.3775079-5-houtao@huaweicloud.com>
 <CAEf4BzbHu3t+Bg3wA2ZMWzw3PTgMtaq0w-McjU3Hje=GUTYK8g@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <b34e560c-0b1f-4c7c-c96c-57a17aaeee7f@huaweicloud.com>
Date: Thu, 14 Dec 2023 09:44:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbHu3t+Bg3wA2ZMWzw3PTgMtaq0w-McjU3Hje=GUTYK8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgA3hQv7XXplAHpYDg--.25378S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr17CF45WFWDWw4UGryDZFb_yoW5GF1UpF
	WSqa4YkF4fXr1jq3W2vw42qFyIvFsa9r15Zr1SqFyfZr1DCF97WF1xKr4xGF93CrykXw1r
	Aw1Utrn0k3yUZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/14/2023 7:33 AM, Andrii Nakryiko wrote:
> On Wed, Dec 13, 2023 at 3:24 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> If an abnormally huge cnt is used for multi-kprobes attachment, the
>> following warning will be reported:
>>
>>   ------------[ cut here ]------------
>>   WARNING: CPU: 1 PID: 392 at mm/util.c:632 kvmalloc_node+0xd9/0xe0
>>   Modules linked in: bpf_testmod(O)
>>   CPU: 1 PID: 392 Comm: test_progs Tainted: G ...... 6.7.0-rc3+ #32
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>>   ......
>>   RIP: 0010:kvmalloc_node+0xd9/0xe0
>>    ? __warn+0x89/0x150
>>    ? kvmalloc_node+0xd9/0xe0
>>    bpf_kprobe_multi_link_attach+0x87/0x670
>>    __sys_bpf+0x2a28/0x2bc0
>>    __x64_sys_bpf+0x1a/0x30
>>    do_syscall_64+0x36/0xb0
>>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
>>   RIP: 0033:0x7fbe067f0e0d
>>   ......
>>    </TASK>
>>   ---[ end trace 0000000000000000 ]---
>>
>> So add a test to ensure the warning is fixed.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  .../selftests/bpf/prog_tests/kprobe_multi_test.c   | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
>> index 4041cfa670eb..802554d4ee24 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
>> @@ -300,6 +300,20 @@ static void test_attach_api_fails(void)
>>         if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_5_error"))
>>                 goto cleanup;
>>
>> +       /* fail_6 - abnormal cnt */
>> +       opts.addrs = (const unsigned long *) addrs;
>> +       opts.syms = NULL;
>> +       opts.cnt = INT_MAX;
>> +       opts.cookies = NULL;
>> +
>> +       link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
>> +                                                    NULL, &opts);
>> +       if (!ASSERT_ERR_PTR(link, "fail_6"))
>> +               goto cleanup;
>> +
>> +       if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_6_error"))
> this is unreliable, store errno right after the operation before
> ASSERT_xxx() macros

I didn't fully follow the reason why it is unreliable. Do you mean
ASSERT_ERR_PTR() macro may overwrite errno, right ? But _CHECK() already
saves and restores errno before invoking fprintf(), so I think it is OK
to use libbpf_get_error() to get the errno here ?
>
>> +               goto cleanup;
>> +
>>  cleanup:
>>         bpf_link__destroy(link);
>>         kprobe_multi__destroy(skel);
>> --
>> 2.29.2
>>


