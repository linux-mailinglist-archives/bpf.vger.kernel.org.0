Return-Path: <bpf+bounces-17755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D6B812439
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38A72823B1
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE731644;
	Thu, 14 Dec 2023 01:02:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4780ED0
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 17:02:27 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SrDbM0RtTz4f3jq6
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 09:02:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4E28C1A0ADE
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 09:02:24 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBXrUsdVHpl+TvGDg--.23799S2;
	Thu, 14 Dec 2023 09:02:24 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Add test for abnormal cnt
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
References: <20231213112531.3775079-1-houtao@huaweicloud.com>
 <20231213112531.3775079-4-houtao@huaweicloud.com> <ZXnC_utPtXeqAIs3@krava>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <44a3dc5c-da03-183c-789c-b37bc6a994b1@huaweicloud.com>
Date: Thu, 14 Dec 2023 09:02:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZXnC_utPtXeqAIs3@krava>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBXrUsdVHpl+TvGDg--.23799S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw47JrW3XFy7JrW7tFW5Wrg_yoW5uFW7pa
	9YqFyakF4fXFyUXryavrWjgFyIvF4kur1UuryfWa43JrnFvFn7JF1kKr43CFn3ArZYvan3
	Zw1Dtr9rG3yUXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbPEf5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 12/13/2023 10:43 PM, Jiri Olsa wrote:
> On Wed, Dec 13, 2023 at 07:25:30PM +0800, Hou Tao wrote:
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
>>  .../bpf/prog_tests/uprobe_multi_test.c        | 33 ++++++++++++++++++-
>>  1 file changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
>> index ece260cf2c0b..0d2a4510e6cf 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
>> @@ -234,6 +234,35 @@ static void test_attach_api_syms(void)
>>  	test_attach_api("/proc/self/exe", NULL, &opts);
>>  }
>>  
>> +static void test_failed_link_api(void)
>> +{
>> +	LIBBPF_OPTS(bpf_link_create_opts, opts);
>> +	const char *path = "/proc/self/exe";
>> +	struct uprobe_multi *skel = NULL;
>> +	unsigned long offset = 0;
>> +	int link_fd = -1;
>> +
>> +	skel = uprobe_multi__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
>> +		goto cleanup;
>> +
>> +	/* abnormal cnt */
>> +	opts.uprobe_multi.path = path;
>> +	opts.uprobe_multi.offsets = &offset;
>> +	opts.uprobe_multi.cnt = INT_MAX;
>> +	opts.kprobe_multi.flags = 0;
>      s/k/u/  ^^^ .. or best just remove the line

My bad. Will remove it. Thanks for the ack.
>
> jirka
>
>> +	link_fd = bpf_link_create(bpf_program__fd(skel->progs.uprobe), 0,
>> +				  BPF_TRACE_UPROBE_MULTI, &opts);
>> +	if (!ASSERT_ERR(link_fd, "link_fd"))
>> +		goto cleanup;
>> +	if (!ASSERT_EQ(link_fd, -EINVAL, "invalid cnt"))
>> +		goto cleanup;
>> +cleanup:
>> +	if (link_fd >= 0)
>> +		close(link_fd);
>> +	uprobe_multi__destroy(skel);
>> +}
>> +
>>  static void __test_link_api(struct child *child)
>>  {
>>  	int prog_fd, link1_fd = -1, link2_fd = -1, link3_fd = -1, link4_fd = -1;
>> @@ -311,7 +340,7 @@ static void __test_link_api(struct child *child)
>>  	free(offsets);
>>  }
>>  
>> -void test_link_api(void)
>> +static void test_link_api(void)
>>  {
>>  	struct child *child;
>>  
>> @@ -408,6 +437,8 @@ void test_uprobe_multi_test(void)
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


