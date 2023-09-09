Return-Path: <bpf+bounces-9592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ECC7995FA
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 04:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5303D1C2092F
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 02:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFC915C4;
	Sat,  9 Sep 2023 02:49:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA180629;
	Sat,  9 Sep 2023 02:49:17 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA171BFF;
	Fri,  8 Sep 2023 19:49:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RjHVw2Jd0z4f3jqZ;
	Sat,  9 Sep 2023 10:49:12 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgD3itol3ftkjzEDAA--.3845S2;
	Sat, 09 Sep 2023 10:49:12 +0800 (CST)
Subject: Re: [PATCH net 4/4] bpf, cpumap: Flush xdp after
 cpu_map_bpf_prog_run_skb().
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20230908135748.794163-1-bigeasy@linutronix.de>
 <20230908135748.794163-5-bigeasy@linutronix.de>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <1cf255a3-e48b-0a90-28ce-1a9c47095fc2@huaweicloud.com>
Date: Sat, 9 Sep 2023 10:49:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230908135748.794163-5-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgD3itol3ftkjzEDAA--.3845S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWUWr4UWF45tFy8XrWfuFg_yoW8ZFyDpF
	WkGFW7GrWUXrs7uay7G3yUCFy3twsIv343KayYy34rArn0qr18WrW8WFs0qF1YgrW5Cr4F
	9r4DXayvg3yDZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUo0eHDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 9/8/2023 9:57 PM, Sebastian Andrzej Siewior wrote:
> xdp_do_flush() should be invoked before leaving the NAPI poll function
> if XDP-redirect has been performed.
>
> There are two possible XDP invocations in cpu_map_bpf_prog_run():
> - cpu_map_bpf_prog_run_xdp()
> - cpu_map_bpf_prog_run_skb()
>
> Both functions update stats->redirect if a redirect is performed but
> xdp_do_flush() is only invoked after the former.
>
> Invoke xdp_do_flush() after both functions run and a redirect was
> performed.
>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Fixes: 11941f8a85362 ("bpf: cpumap: Implement generic cpumap")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/bpf/cpumap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index e42a1bdb7f536..f3ba11b4a732b 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -248,12 +248,12 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
>  
>  	nframes = cpu_map_bpf_prog_run_xdp(rcpu, frames, xdp_n, stats);
>  
> -	if (stats->redirect)
> -		xdp_do_flush();
> -
>  	if (unlikely(!list_empty(list)))
>  		cpu_map_bpf_prog_run_skb(rcpu, list, stats);
>  
> +	if (stats->redirect)
> +		xdp_do_flush();
> +

The purpose of xdp_do_flush() is to flush xdp frames stashed in per-cpu
cpu_map_flush list into xdp_bulk_queue. But for redirected skbs, these
skbs will be directly added into xdp_bulk_queue() in
cpu_map_generic_redirect(), so I think xdp_do_flush() is not needed for
redirected skbs.
>  	rcu_read_unlock_bh(); /* resched point, may call do_softirq() */
>  
>  	return nframes;


