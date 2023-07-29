Return-Path: <bpf+bounces-6322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE45767E25
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 12:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194D92825B2
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 10:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07051427F;
	Sat, 29 Jul 2023 10:21:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554597C;
	Sat, 29 Jul 2023 10:21:46 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E9B19A7;
	Sat, 29 Jul 2023 03:21:44 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RCgTL3FNdzLngj;
	Sat, 29 Jul 2023 18:19:02 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 18:21:39 +0800
Message-ID: <595910b8-c923-ecef-bd05-5e6928c7de3a@huawei.com>
Date: Sat, 29 Jul 2023 18:21:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH bpf 1/2] bpf, cpumap: Make sure kthread is running before
 map update returns
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>, <bpf@vger.kernel.org>
CC: <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn.topel@gmail.com>, =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?=
	<toke@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko
	<andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann
	<daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, <houtao1@huawei.com>
References: <20230729095107.1722450-1-houtao@huaweicloud.com>
 <20230729095107.1722450-2-houtao@huaweicloud.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20230729095107.1722450-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.184]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500020.china.huawei.com (7.221.188.8)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/29 17:51, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The following warning was reported when running stress-mode enabled
> xdp_redirect_cpu with some RT threads:
> 
>    ------------[ cut here ]------------
>    WARNING: CPU: 4 PID: 65 at kernel/bpf/cpumap.c:135
>    CPU: 4 PID: 65 Comm: kworker/4:1 Not tainted 6.5.0-rc2+ #1
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>    Workqueue: events cpu_map_kthread_stop
>    RIP: 0010:put_cpu_map_entry+0xda/0x220
>    ......
>    Call Trace:
>     <TASK>
>     ? show_regs+0x65/0x70
>     ? __warn+0xa5/0x240
>     ......
>     ? put_cpu_map_entry+0xda/0x220
>     cpu_map_kthread_stop+0x41/0x60
>     process_one_work+0x6b0/0xb80
>     worker_thread+0x96/0x720
>     kthread+0x1a5/0x1f0
>     ret_from_fork+0x3a/0x70
>     ret_from_fork_asm+0x1b/0x30
>     </TASK>
> 
> The root cause is the same as commit 436901649731 ("bpf: cpumap: Fix memory
> leak in cpu_map_update_elem"). The kthread is stopped prematurely by
> kthread_stop() in cpu_map_kthread_stop(), and kthread() doesn't call
> cpu_map_kthread_run() at all but XDP program has already queued some
> frames or skbs into ptr_ring. So when __cpu_map_ring_cleanup() checks
> the ptr_ring, it will find it was not emptied and report a warning.
> 
> An alternative fix is to use __cpu_map_ring_cleanup() to drop these
> pending frames or skbs when kthread_stop() returns -EINTR, but it may
> confuse the user, because these frames or skbs have been handled
> correctly by XDP program. So instead of dropping these frames or skbs,
> just make sure the per-cpu kthread is running before
> __cpu_map_entry_alloc() returns.
> 
> After apply the fix, the error handle for kthread_stop() will be
> unnecessary because it will always return 0, so just remove it.
> 
> Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   kernel/bpf/cpumap.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 0a16e30b16ef..08351e0863e5 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -28,6 +28,7 @@
>   #include <linux/sched.h>
>   #include <linux/workqueue.h>
>   #include <linux/kthread.h>
> +#include <linux/completion.h>
>   #include <trace/events/xdp.h>
>   #include <linux/btf_ids.h>
>   
> @@ -71,6 +72,7 @@ struct bpf_cpu_map_entry {
>   	struct rcu_head rcu;
>   
>   	struct work_struct kthread_stop_wq;
> +	struct completion kthread_running;
>   };
>   
>   struct bpf_cpu_map {
> @@ -151,7 +153,6 @@ static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
>   static void cpu_map_kthread_stop(struct work_struct *work)
>   {
>   	struct bpf_cpu_map_entry *rcpu;
> -	int err;
>   
>   	rcpu = container_of(work, struct bpf_cpu_map_entry, kthread_stop_wq);
>   
> @@ -161,14 +162,7 @@ static void cpu_map_kthread_stop(struct work_struct *work)
>   	rcu_barrier();
>   
>   	/* kthread_stop will wake_up_process and wait for it to complete */
> -	err = kthread_stop(rcpu->kthread);
> -	if (err) {
> -		/* kthread_stop may be called before cpu_map_kthread_run
> -		 * is executed, so we need to release the memory related
> -		 * to rcpu.
> -		 */
> -		put_cpu_map_entry(rcpu);
> -	}
> +	kthread_stop(rcpu->kthread);
>   }

Looks good to me.

Feel free to add:
Reviewed-by: Pu Lehui <pulehui@huawei.com>

>   
>   static void cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
> @@ -296,11 +290,11 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
>   	return nframes;
>   }
>   
> -
>   static int cpu_map_kthread_run(void *data)
>   {
>   	struct bpf_cpu_map_entry *rcpu = data;
>   
> +	complete(&rcpu->kthread_running);
>   	set_current_state(TASK_INTERRUPTIBLE);
>   
>   	/* When kthread gives stop order, then rcpu have been disconnected
> @@ -465,6 +459,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
>   		goto free_ptr_ring;
>   
>   	/* Setup kthread */
> +	init_completion(&rcpu->kthread_running);
>   	rcpu->kthread = kthread_create_on_node(cpu_map_kthread_run, rcpu, numa,
>   					       "cpumap/%d/map:%d", cpu,
>   					       map->id);
> @@ -478,6 +473,12 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
>   	kthread_bind(rcpu->kthread, cpu);
>   	wake_up_process(rcpu->kthread);
>   
> +	/* Make sure kthread has been running, so kthread_stop() will not
> +	 * stop the kthread prematurely and all pending frames or skbs
> +	 * will be handled by the kthread before kthread_stop() returns.
> +	 */
> +	wait_for_completion(&rcpu->kthread_running);
> +
>   	return rcpu;
>   
>   free_prog:

