Return-Path: <bpf+bounces-17005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2B8808972
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 14:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A10282707
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADD540BFF;
	Thu,  7 Dec 2023 13:47:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADD610E4
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 05:46:57 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SmFtd4Yzrz4f3l1n
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 21:46:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 68BD01A053D
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 21:46:54 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgCHKknIzHFlNYVZDA--.40645S2;
	Thu, 07 Dec 2023 21:46:52 +0800 (CST)
Subject: Re: [PATCH bpf-next v4] bpf: Fix a race condition between btf_put()
 and map_free()
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231206210959.1035724-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <f2cb6555-c8ec-1a8c-b178-1b36f1c361df@huaweicloud.com>
Date: Thu, 7 Dec 2023 21:46:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231206210959.1035724-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgCHKknIzHFlNYVZDA--.40645S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyrGw1Duw15Wry3GF1kGrg_yoW5ZF1UpF
	15JF1Syr4DJ34UXFWUKw4Uta4IkF43u3ZrGas7Kry8X3W0g398A3409FyUJrs8urW5uF1U
	Ca4DGw1rXr4UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 12/7/2023 5:09 AM, Yonghong Song wrote:
> When running `./test_progs -j` in my local vm with latest kernel,
> I once hit a kasan error like below:
>
>   [ 1887.184724] BUG: KASAN: slab-use-after-free in bpf_rb_root_free+0x1f8/0x2b0
>   [ 1887.185599] Read of size 4 at addr ffff888106806910 by task kworker/u12:2/2830
>   [ 1887.186498]
>   [ 1887.186712] CPU: 3 PID: 2830 Comm: kworker/u12:2 Tainted: G           OEL     6.7.0-rc3-00699-g90679706d486-dirty #494
>   [ 1887.188034] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>   [ 1887.189618] Workqueue: events_unbound bpf_map_free_deferred
>   [ 1887.190341] Call Trace:
>   [ 1887.190666]  <TASK>
>   [ 1887.190949]  dump_stack_lvl+0xac/0xe0
>   [ 1887.191423]  ? nf_tcp_handle_invalid+0x1b0/0x1b0
>   [ 1887.192019]  ? panic+0x3c0/0x3c0
>   [ 1887.192449]  print_report+0x14f/0x720
>   [ 1887.192930]  ? preempt_count_sub+0x1c/0xd0
>   [ 1887.193459]  ? __virt_addr_valid+0xac/0x120
>   [ 1887.194004]  ? bpf_rb_root_free+0x1f8/0x2b0
>   [ 1887.194572]  kasan_report+0xc3/0x100
>   [ 1887.195085]  ? bpf_rb_root_free+0x1f8/0x2b0
>   [ 1887.195668]  bpf_rb_root_free+0x1f8/0x2b0
>   [ 1887.196183]  ? __bpf_obj_drop_impl+0xb0/0xb0
>   [ 1887.196736]  ? preempt_count_sub+0x1c/0xd0
>   [ 1887.197270]  ? preempt_count_sub+0x1c/0xd0
>   [ 1887.197802]  ? _raw_spin_unlock+0x1f/0x40
>   [ 1887.198319]  bpf_obj_free_fields+0x1d4/0x260
>   [ 1887.198883]  array_map_free+0x1a3/0x260
>   [ 1887.199380]  bpf_map_free_deferred+0x7b/0xe0
>   [ 1887.199943]  process_scheduled_works+0x3a2/0x6c0
>   [ 1887.200549]  worker_thread+0x633/0x890
>   [ 1887.201047]  ? __kthread_parkme+0xd7/0xf0
>   [ 1887.201574]  ? kthread+0x102/0x1d0
>   [ 1887.202020]  kthread+0x1ab/0x1d0
>   [ 1887.202447]  ? pr_cont_work+0x270/0x270
>   [ 1887.202954]  ? kthread_blkcg+0x50/0x50
>   [ 1887.203444]  ret_from_fork+0x34/0x50
>   [ 1887.203914]  ? kthread_blkcg+0x50/0x50
>   [ 1887.204397]  ret_from_fork_asm+0x11/0x20
>   [ 1887.204913]  </TASK>
>   [ 1887.204913]  </TASK>
>   [ 1887.205209]
>   [ 1887.205416] Allocated by task 2197:
>   [ 1887.205881]  kasan_set_track+0x3f/0x60
>   [ 1887.206366]  __kasan_kmalloc+0x6e/0x80
>   [ 1887.206856]  __kmalloc+0xac/0x1a0
>   [ 1887.207293]  btf_parse_fields+0xa15/0x1480
>   [ 1887.207836]  btf_parse_struct_metas+0x566/0x670
>   [ 1887.208387]  btf_new_fd+0x294/0x4d0
>   [ 1887.208851]  __sys_bpf+0x4ba/0x600
>   [ 1887.209292]  __x64_sys_bpf+0x41/0x50
>   [ 1887.209762]  do_syscall_64+0x4c/0xf0
>   [ 1887.210222]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>   [ 1887.210868]
>   [ 1887.211074] Freed by task 36:
>   [ 1887.211460]  kasan_set_track+0x3f/0x60
>   [ 1887.211951]  kasan_save_free_info+0x28/0x40
>   [ 1887.212485]  ____kasan_slab_free+0x101/0x180
>   [ 1887.213027]  __kmem_cache_free+0xe4/0x210
>   [ 1887.213514]  btf_free+0x5b/0x130
>   [ 1887.213918]  rcu_core+0x638/0xcc0
>   [ 1887.214347]  __do_softirq+0x114/0x37e
>

SNIP
> Fixes: 958cf2e273f0 ("bpf: Introduce bpf_obj_new")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Hou Tao <houtao1@huawei.com>


