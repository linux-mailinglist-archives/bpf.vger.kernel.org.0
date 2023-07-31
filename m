Return-Path: <bpf+bounces-6424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E841C76925E
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 11:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F0128147D
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BA317ADA;
	Mon, 31 Jul 2023 09:53:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0B17AAF
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 09:53:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FB8173F
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 02:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690797123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHyoZhH8+rWHm75lx4Eud7s39jwS+scUBib6BLzaSL8=;
	b=VSChxRh62whxY05aOLxyuW2MLNvINM1p0hjCqJpjbw1n+RS/CvO+/y/uZTigo1Tk94x1Ns
	acf3curSSIOhiCmbPaB1/DHtL8qL84+8FdN3M8VK8UZ964zmJPWbrnqxCTp5jqvdQVhIiv
	fyOxH9yTceencb1+IHd+b/TXpFY7Hv0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-9qCW3ZlTM8-NNrtpYyFRnA-1; Mon, 31 Jul 2023 05:52:02 -0400
X-MC-Unique: 9qCW3ZlTM8-NNrtpYyFRnA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5227fb36095so3258183a12.3
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 02:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690797121; x=1691401921;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHyoZhH8+rWHm75lx4Eud7s39jwS+scUBib6BLzaSL8=;
        b=XXmkbekKmwipwCz0GMsnH00+51/7E9r+/rPyGf6bEQ7Qxk2UtlVCTVGPd+mlL/95h6
         PRmM8EpWhiPjZW0JuHfmU1Vl2DIXtyof2P1Ah+sZZ6ePLDT9HnEhuDraB2TLFgSp95DX
         GoIDA15si7kv+LyavSip1Izd89wqiOMDII0qs8vmh9kNQucmLCUDrLiaI9d2RB/gEJsA
         ZmH38tHasfChtyILL6puH2okv20M3byPHWwhAlhZY9smOj7lfEZojPxr1HLi6FyL5fzM
         DsRA9cfSbwu6oTTDrdZJzA6pjWE8GMLNlNbhW8QyPUridrmxr00aJKHXKIKsblDEMDGW
         bFkQ==
X-Gm-Message-State: ABy/qLZW/vX0cmJI+VuernsfthQjQq4GosXVaVTmFQwprQMMZrZh3wr+
	c60YE/B6wRvOGKpqtB/bQ0eQH77RHfgFxBzok3IWwlToZ8lIgFDfVPFdLbkfVx3aARVZYr18ey7
	2K/vTc8XwgPDW
X-Received: by 2002:a17:907:2712:b0:97e:aace:b6bc with SMTP id w18-20020a170907271200b0097eaaceb6bcmr6270403ejk.53.1690797121264;
        Mon, 31 Jul 2023 02:52:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF+lJ+udhTNe6nab3lH6QYmvgenXCWZfaeQwpPpwvLmoUQFAzutESgLYvoc3XHCIuvGqBOLtQ==
X-Received: by 2002:a17:907:2712:b0:97e:aace:b6bc with SMTP id w18-20020a170907271200b0097eaaceb6bcmr6270377ejk.53.1690797120879;
        Mon, 31 Jul 2023 02:52:00 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709063c0f00b009929ab17be0sm5925438ejg.162.2023.07.31.02.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 02:52:00 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <7c1d0b76-2898-89ea-eb0a-1151e0654de8@redhat.com>
Date: Mon, 31 Jul 2023 11:51:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Pu Lehui <pulehui@huawei.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf 1/2] bpf, cpumap: Make sure kthread is running before
 map update returns
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
References: <20230729095107.1722450-1-houtao@huaweicloud.com>
 <20230729095107.1722450-2-houtao@huaweicloud.com>
In-Reply-To: <20230729095107.1722450-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 29/07/2023 11.51, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> The following warning was reported when running stress-mode enabled
> xdp_redirect_cpu with some RT threads:

Cool stress-mode test that leverage RT to provoke this.

> 
>    ------------[ cut here ]------------
>    WARNING: CPU: 4 PID: 65 at kernel/bpf/cpumap.c:135
>    CPU: 4 PID: 65 Comm: kworker/4:1 Not tainted 6.5.0-rc2+ #1

As you mention RT, I want to mention that it also possible to change the
sched prio on the kthread PID.

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

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

Thanks for catching this!

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

Diff is missing next lines that show this is correct.
I checked this manually and for other reviewers here are the next lines:

	set_current_state(TASK_INTERRUPTIBLE);

	/* When kthread gives stop order, then rcpu have been disconnected
	 * from map, thus no new packets can enter. Remaining in-flight
	 * per CPU stored packets are flushed to this queue.  Wait honoring
	 * kthread_stop signal until queue is empty.
	 */
	while (!kthread_should_stop() || !__ptr_ring_empty(rcpu->queue)) {

The patch is correct in setting complete(&rcpu->kthread_running) before
the while-loop, as the code also checks if ptr_ring is not empty.


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


