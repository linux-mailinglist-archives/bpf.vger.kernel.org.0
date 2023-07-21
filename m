Return-Path: <bpf+bounces-5606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A2575C6AA
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 14:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B611C21680
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 12:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351DF1E513;
	Fri, 21 Jul 2023 12:12:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B563D75
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 12:12:52 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0593D10FE
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 05:12:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6pNG005Dz4f3v5X
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 20:12:45 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDnnLA5drpkfN3oOQ--.26101S2;
	Fri, 21 Jul 2023 20:12:45 +0800 (CST)
Subject: Re: [PATCHv2 bpf 0/2] bpf: Disable preemption in perf_event_output
 helpers code
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
References: <20230720085704.190592-1-jolsa@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <cefba62b-eb52-6955-86c5-a1ccff918b72@huaweicloud.com>
Date: Fri, 21 Jul 2023 20:12:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230720085704.190592-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDnnLA5drpkfN3oOQ--.26101S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1kXryfJw18GrW5AFW5Wrg_yoW5trykpr
	Z3CFWagr40qFyIqwn7t348Wa45Cw4kZryvgr4ktryrAw4rurZYqF1ftr1ruF13ur4xtrWf
	JayDtw4jvFyUCa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 7/20/2023 4:57 PM, Jiri Olsa wrote:
> hi,
> we got report of kernel crash [1][3] within bpf_event_output helper.
>
> The reason is the nesting protection code in bpf_event_output that expects
> disabled preemption, which is not guaranteed for programs executed by
> bpf_prog_run_array_cg.
>
> I managed to reproduce on tracing side where we have the same problem
> in bpf_perf_event_output. The reproducer [2] just creates busy uprobe
> and call bpf_perf_event_output helper a lot.

It is a little strange that I can not reproduce the same problem on my
local VM by using the same reproducer from [2]. I have already enabled
both CONFIG_PREEMPT=y and CONFIG_PREEMPT_RCU=y.
>
> v2 changes:
>   - I changed 'Fixes' commits to where I saw we switched from preempt_disable
>     to migrate_disable, but I'm not completely sure about the patch 2, because
>     it was tricky to find, would be nice if somebody could check on that

After digging into the change log, I think the fix tag is correct. In
commit 2a916f2f546c, preempt_disable() is changed to migrate_disable()
in the macro BPF_PROG_RUN_ARRAY(), and in commit 772412176fb9,
BPF_PROG_RUN_ARRAY_FLAGS() was added for
__cgroup_bpf_run_filter_sock_addr() and the implementation of
BPF_PROG_RUN_ARRAY_FLAGS() was basically copied from
BPF_PROG_RUN_ARRAY(). And afterwards, BPF_PROG_RUN_ARRAY_FLAGS was
rename to BPF_PROG_RUN_ARRAY_CG_FLAGS, then
bpf_prog_run_array_cg_flags(), and was renamed to
bpf_prog_run_array_cg() in the final.

>
> thanks,
> jirka
>
>
> [1] https://github.com/cilium/cilium/issues/26756
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=bpf_output_fix_reproducer&id=8054dcc634121b884c7c331329d61d93351d03b5
> [3] slack:
>     [66194.378161] BUG: kernel NULL pointer dereference, address: 0000000000000001
>     [66194.378324] #PF: supervisor instruction fetch in kernel mode
>     [66194.378447] #PF: error_code(0x0010) - not-present page
>     ...
>     [66194.378692] Oops: 0010 [#1] PREEMPT SMP NOPTI
>     ...
>     [66194.380666]  <TASK>
>     [66194.380775]  ? perf_output_sample+0x12a/0x9a0
>     [66194.380902]  ? finish_task_switch.isra.0+0x81/0x280
>     [66194.381024]  ? perf_event_output+0x66/0xa0
>     [66194.381148]  ? bpf_event_output+0x13a/0x190
>     [66194.381270]  ? bpf_event_output_data+0x22/0x40
>     [66194.381391]  ? bpf_prog_dfc84bbde731b257_cil_sock4_connect+0x40a/0xacb
>     [66194.381519]  ? xa_load+0x87/0xe0
>     [66194.381635]  ? __cgroup_bpf_run_filter_sock_addr+0xc1/0x1a0
>     [66194.381759]  ? release_sock+0x3e/0x90
>     [66194.381876]  ? sk_setsockopt+0x1a1/0x12f0
>     [66194.381996]  ? udp_pre_connect+0x36/0x50
>     [66194.382114]  ? inet_dgram_connect+0x93/0xa0
>     [66194.382233]  ? __sys_connect+0xb4/0xe0
>     [66194.382353]  ? udp_setsockopt+0x27/0x40
>     [66194.382470]  ? __pfx_udp_push_pending_frames+0x10/0x10
>     [66194.382593]  ? __sys_setsockopt+0xdf/0x1a0
>     [66194.382713]  ? __x64_sys_connect+0xf/0x20
>     [66194.382832]  ? do_syscall_64+0x3a/0x90
>     [66194.382949]  ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
>     [66194.383077]  </TASK>
>
>
> ---
> Jiri Olsa (2):
>       bpf: Disable preemption in bpf_perf_event_output
>       bpf: Disable preemption in bpf_event_output
>
>  kernel/trace/bpf_trace.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> .


