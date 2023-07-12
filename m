Return-Path: <bpf+bounces-4816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F5874FCF7
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 04:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCA31C20E34
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 02:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCE2656;
	Wed, 12 Jul 2023 02:12:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D95362;
	Wed, 12 Jul 2023 02:12:11 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BBE11B;
	Tue, 11 Jul 2023 19:12:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R11TH6rp5z4f3mJ4;
	Wed, 12 Jul 2023 10:12:03 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDX9jDyC65k9Z0eNA--.18259S2;
	Wed, 12 Jul 2023 10:12:06 +0800 (CST)
Subject: Re: [PATCH bpf] bpf: cpumap: Fix memory leak in cpu_map_update_elem
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huawei.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20230711115848.2701559-1-pulehui@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e065f385-3baf-eacb-7ca5-6ade14491eee@huaweicloud.com>
Date: Wed, 12 Jul 2023 10:12:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230711115848.2701559-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDX9jDyC65k9Z0eNA--.18259S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWrAFWrZF1xCFWfAFy7Wrg_yoW5Cr4Dpr
	Wrtr1DKr48tr4DZw48t3WrGr18Zw1jya4UJrZ3Jr4fAF18G3W8t348GFZ7JFZrZrn8Xry7
	Jas8t3yvg34DA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/11/2023 7:58 PM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> Syzkaller reported a memory leak as follows:
>
> BUG: memory leak
> unreferenced object 0xff110001198ef748 (size 192):
>   comm "syz-executor.3", pid 17672, jiffies 4298118891 (age 9.906s)
>   hex dump (first 32 bytes):
>     00 00 00 00 4a 19 00 00 80 ad e3 e4 fe ff c0 00  ....J...........
>     00 b2 d3 0c 01 00 11 ff 28 f5 8e 19 01 00 11 ff  ........(.......
>   backtrace:
>     [<ffffffffadd28087>] __cpu_map_entry_alloc+0xf7/0xb00
>     [<ffffffffadd28d8e>] cpu_map_update_elem+0x2fe/0x3d0
>     [<ffffffffadc6d0fd>] bpf_map_update_value.isra.0+0x2bd/0x520
>     [<ffffffffadc7349b>] map_update_elem+0x4cb/0x720
>     [<ffffffffadc7d983>] __se_sys_bpf+0x8c3/0xb90
>     [<ffffffffb029cc80>] do_syscall_64+0x30/0x40
>     [<ffffffffb0400099>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
>
> BUG: memory leak
> unreferenced object 0xff110001198ef528 (size 192):
>   comm "syz-executor.3", pid 17672, jiffies 4298118891 (age 9.906s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffffadd281f0>] __cpu_map_entry_alloc+0x260/0xb00
>     [<ffffffffadd28d8e>] cpu_map_update_elem+0x2fe/0x3d0
>     [<ffffffffadc6d0fd>] bpf_map_update_value.isra.0+0x2bd/0x520
>     [<ffffffffadc7349b>] map_update_elem+0x4cb/0x720
>     [<ffffffffadc7d983>] __se_sys_bpf+0x8c3/0xb90
>     [<ffffffffb029cc80>] do_syscall_64+0x30/0x40
>     [<ffffffffb0400099>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
>
> BUG: memory leak
> unreferenced object 0xff1100010fd93d68 (size 8):
>   comm "syz-executor.3", pid 17672, jiffies 4298118891 (age 9.906s)
>   hex dump (first 8 bytes):
>     00 00 00 00 00 00 00 00                          ........
>   backtrace:
>     [<ffffffffade5db3e>] kvmalloc_node+0x11e/0x170
>     [<ffffffffadd28280>] __cpu_map_entry_alloc+0x2f0/0xb00
>     [<ffffffffadd28d8e>] cpu_map_update_elem+0x2fe/0x3d0
>     [<ffffffffadc6d0fd>] bpf_map_update_value.isra.0+0x2bd/0x520
>     [<ffffffffadc7349b>] map_update_elem+0x4cb/0x720
>     [<ffffffffadc7d983>] __se_sys_bpf+0x8c3/0xb90
>     [<ffffffffb029cc80>] do_syscall_64+0x30/0x40
>     [<ffffffffb0400099>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
>
> In the cpu_map_update_elem flow, when kthread_stop is called before
> calling the threadfn of rcpu->kthread, since the KTHREAD_SHOULD_STOP bit
> of kthread has been set by kthread_stop, the threadfn of rcpu->kthread
> will never be executed, and rcpu->refcnt will never be 0, which will
> lead to the allocated rcpu, rcpu->queue and rcpu->queue->queue cannot be
> released.
>
> Calling kthread_stop before executing kthread's threadfn will return
> -EINTR. We can complete the release of memory resources in this state.
>
> Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Hou Tao <houtao1@huawei.com>


