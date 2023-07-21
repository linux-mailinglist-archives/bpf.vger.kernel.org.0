Return-Path: <bpf+bounces-5612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6221375C80E
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 15:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A60F281EA2
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 13:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE21DDFE;
	Fri, 21 Jul 2023 13:43:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED41DDDD
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 13:43:03 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179351722
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 06:43:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6rNJ4wMyz4f3lXH
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 21:42:56 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAXf7Jdi7pkrrDtOQ--.30212S2;
	Fri, 21 Jul 2023 21:42:57 +0800 (CST)
Subject: Re: [PATCHv2 bpf 0/2] bpf: Disable preemption in perf_event_output
 helpers code
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
References: <20230720085704.190592-1-jolsa@kernel.org>
 <cefba62b-eb52-6955-86c5-a1ccff918b72@huaweicloud.com>
 <ZLp9tyAuawEWcCay@krava>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <c5b2b3be-d68a-6966-94be-56d73f16acc1@huaweicloud.com>
Date: Fri, 21 Jul 2023 21:42:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZLp9tyAuawEWcCay@krava>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAXf7Jdi7pkrrDtOQ--.30212S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw13Kr4fGrWrCw4fGF1UAwb_yoW8uw47pF
	WkGayavr4DtF1Iqw12v348C3WFyr47XryFqr1DJryrC3y5WrWF9F1Fga1F9asIgrs7A3yS
	9ayqqa97ZFWDCa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 7/21/2023 8:44 PM, Jiri Olsa wrote:
> On Fri, Jul 21, 2023 at 08:12:41PM +0800, Hou Tao wrote:
>>
>> On 7/20/2023 4:57 PM, Jiri Olsa wrote:
>>> hi,
>>> we got report of kernel crash [1][3] within bpf_event_output helper.
>>>
>>> The reason is the nesting protection code in bpf_event_output that expects
>>> disabled preemption, which is not guaranteed for programs executed by
>>> bpf_prog_run_array_cg.
>>>
>>> I managed to reproduce on tracing side where we have the same problem
>>> in bpf_perf_event_output. The reproducer [2] just creates busy uprobe
>>> and call bpf_perf_event_output helper a lot.
>> It is a little strange that I can not reproduce the same problem on my
>> local VM by using the same reproducer from [2]. I have already enabled
>> both CONFIG_PREEMPT=y and CONFIG_PREEMPT_RCU=y.
> I have 4 cpu VM and I run '# ./test_progs -t krava -v' together with test
> instance for each of cpu, like:
>
>    # ./test & ./test & ./test & ./test &
>
> and it's hit within 15 minutes
>
> attaching my config so you can compare, but can't think of another
> option you need

By using my .config, the reproduce just cost about 2 hours. I will try
your .config to see whether or not there is any difference.
>
>
>>> v2 changes:
>>>   - I changed 'Fixes' commits to where I saw we switched from preempt_disable
>>>     to migrate_disable, but I'm not completely sure about the patch 2, because
>>>     it was tricky to find, would be nice if somebody could check on that
>> After digging into the change log, I think the fix tag is correct. In
>> commit 2a916f2f546c, preempt_disable() is changed to migrate_disable()
>> in the macro BPF_PROG_RUN_ARRAY(), and in commit 772412176fb9,
>> BPF_PROG_RUN_ARRAY_FLAGS() was added for
>> __cgroup_bpf_run_filter_sock_addr() and the implementation of
>> BPF_PROG_RUN_ARRAY_FLAGS() was basically copied from
>> BPF_PROG_RUN_ARRAY(). And afterwards, BPF_PROG_RUN_ARRAY_FLAGS was
>> rename to BPF_PROG_RUN_ARRAY_CG_FLAGS, then
>> bpf_prog_run_array_cg_flags(), and was renamed to
>> bpf_prog_run_array_cg() in the final.
> thanks for checking on that
You are welcome. Hope it is helpful.

Regards,
Hou
>
> jirka
>


