Return-Path: <bpf+bounces-17476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3677780E0C4
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 02:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD0E1F21C6A
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 01:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0407F7;
	Tue, 12 Dec 2023 01:20:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC581AF
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 17:20:30 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Sq151431Lz4f3jMK
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 09:20:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7AF881A0B38
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 09:20:26 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgA3hw1WtXdlo0mdDQ--.23613S2;
	Tue, 12 Dec 2023 09:20:26 +0800 (CST)
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add test for abnormal cnt
 during multi-uprobe attachment
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 xingwei lee <xrivendell7@gmail.com>, houtao1@huawei.com
References: <20231211112843.4147157-1-houtao@huaweicloud.com>
 <20231211112843.4147157-5-houtao@huaweicloud.com> <ZXcG7FQLi08Eojjy@krava>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <94e744a3-7ffd-7703-9668-3240a273195f@huaweicloud.com>
Date: Tue, 12 Dec 2023 09:20:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZXcG7FQLi08Eojjy@krava>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgA3hw1WtXdlo0mdDQ--.23613S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw47JrW3XFy7JrW7tFW5Wrg_yoWrGF4Upa
	9aqFya9F4fXa4UXrW2vr90gFyFvF4kur17AryfWa45JrnFyFn7JF1kKr43CFn3ArZYqa1f
	Aw15tr9rG3yUXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 12/11/2023 8:56 PM, Jiri Olsa wrote:
> On Mon, Dec 11, 2023 at 07:28:43PM +0800, Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> If an abnormally huge cnt is used for multi-uprobes attachment, the
>> following warning will be reported:
>>
>>   ------------[ cut here ]------------
>>   WARNING: CPU: 7 PID: 406 at mm/util.c:632 kvmalloc_node+0xd9/0xe0
>>   Modules linked in: bpf_testmod(O)
>>   CPU: 7 PID: 406 Comm: test_progs Tainted: G ...... 6.7.0-rc3+ #32
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
>>   RIP: 0010:kvmalloc_node+0xd9/0xe0
>>   ......
>>   Call Trace:
>>    <TASK>
>>    ? __warn+0x89/0x150
>>    ? kvmalloc_node+0xd9/0xe0
>>    bpf_uprobe_multi_link_attach+0x14a/0x480
>>    __sys_bpf+0x14a9/0x2bc0
>>    do_syscall_64+0x36/0xb0
>>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
>>    ......
>>    </TASK>
>>   ---[ end trace 0000000000000000 ]---
>>
>> So add a test to ensure the warning is fixed.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  .../bpf/prog_tests/uprobe_multi_test.c        | 43 ++++++++++++++++++-
>>  1 file changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
>> index ece260cf2c0b..379ee9cc6221 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
>> @@ -234,6 +234,45 @@ static void test_attach_api_syms(void)
>>  	test_attach_api("/proc/self/exe", NULL, &opts);
>>  }
>>  
>> +static void test_failed_link_api(void)
>> +{
>> +	LIBBPF_OPTS(bpf_link_create_opts, opts);
>> +	const char *path = "/proc/self/exe";
>> +	struct uprobe_multi *skel = NULL;
>> +	unsigned long *offsets = NULL;
>> +	const char *syms[3] = {
>> +		"uprobe_multi_func_1",
>> +		"uprobe_multi_func_2",
>> +		"uprobe_multi_func_3",
>> +	};
>> +	int link_fd = -1, err;
>> +
>> +	err = elf_resolve_syms_offsets(path, 3, syms, (unsigned long **) &offsets, STT_FUNC);
>> +	if (!ASSERT_OK(err, "elf_resolve_syms_offsets"))
>> +		return;
> we should not need any symbols/offset for this tests right?
>
> the allocation takes place before the offsets are checked,
> so I think using just some pointer != NULL should be enough?

Yes. Will update.
>
> thanks,
> jirka
>
>> +
>> +	skel = uprobe_multi__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
>> +		goto cleanup;
>> +
>> +	/* abnormal cnt */
>> +	opts.uprobe_multi.path = path;
>> +	opts.uprobe_multi.offsets = offsets;
>> +	opts.uprobe_multi.cnt = INT_MAX;
>> +	opts.kprobe_multi.flags = 0;
>> +	link_fd = bpf_link_create(bpf_program__fd(skel->progs.uprobe), 0,
>> +				  BPF_TRACE_UPROBE_MULTI, &opts);
>> +	if (!ASSERT_ERR(link_fd, "link_fd"))
>> +		goto cleanup;
>> +	if (!ASSERT_EQ(link_fd, -ENOMEM, "no mem fail"))
>> +		goto cleanup;
>> +cleanup:
>> +	if (link_fd >= 0)
>> +		close(link_fd);
>> +	uprobe_multi__destroy(skel);
>> +	free(offsets);
>> +}
>> +
>>  static void __test_link_api(struct child *child)
>>  {
>>  	int prog_fd, link1_fd = -1, link2_fd = -1, link3_fd = -1, link4_fd = -1;
>> @@ -311,7 +350,7 @@ static void __test_link_api(struct child *child)
>>  	free(offsets);
>>  }
>>  
>> -void test_link_api(void)
>> +static void test_link_api(void)
>>  {
>>  	struct child *child;
>>  
>> @@ -408,6 +447,8 @@ void test_uprobe_multi_test(void)
>>  		test_attach_api_syms();
>>  	if (test__start_subtest("link_api"))
>>  		test_link_api();
>> +	if (test__start_subtest("failed_link_api"))
>> +		test_failed_link_api();
>>  	if (test__start_subtest("bench_uprobe"))
>>  		test_bench_attach_uprobe();
>>  	if (test__start_subtest("bench_usdt"))
>> -- 
>> 2.29.2
>>


