Return-Path: <bpf+bounces-16838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 012418063B9
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 01:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF3F28225F
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 00:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789BC7E4;
	Wed,  6 Dec 2023 00:56:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBEB1A4
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 16:56:45 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SlJrS3CX0z4f3jqg
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 08:56:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7F4641A093C
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 08:56:41 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDXMULExm9lyWrCCw--.64737S2;
	Wed, 06 Dec 2023 08:56:39 +0800 (CST)
Subject: Re: [PATCH bpf-next v3] bpf: Fix a race condition between btf_put()
 and map_free()
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231205224812.813224-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <47ee3265-23f7-2130-ff28-27bfaf3f7877@huaweicloud.com>
Date: Wed, 6 Dec 2023 08:56:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231205224812.813224-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDXMULExm9lyWrCCw--.64737S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JryrZFy3Xr17XFyUZFy3twb_yoW3Zr47pF
	43JF1Skr4kJryUZrW3Kr4jgFySyr45W3WUWas5K34rZa1Fgr95AF109FyUuF43urZ5ur18
	Ca4qgas0yw4UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/6/2023 6:48 AM, Yonghong Song wrote:
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
> The error happens at bpf_rb_root_free+0x1f8/0x2b0:
>
>   00000000000034c0 <bpf_rb_root_free>:
>   ; {
>     34c0: f3 0f 1e fa                   endbr64
>     34c4: e8 00 00 00 00                callq   0x34c9 <bpf_rb_root_free+0x9>
>     34c9: 55                            pushq   %rbp
>     34ca: 48 89 e5                      movq    %rsp, %rbp
>   ...
>   ;       if (rec && rec->refcount_off >= 0 &&
>     36aa: 4d 85 ed                      testq   %r13, %r13
>     36ad: 74 a9                         je      0x3658 <bpf_rb_root_free+0x198>
>     36af: 49 8d 7d 10                   leaq    0x10(%r13), %rdi
>     36b3: e8 00 00 00 00                callq   0x36b8 <bpf_rb_root_free+0x1f8>
>                                         <==== kasan function
>     36b8: 45 8b 7d 10                   movl    0x10(%r13), %r15d
>                                         <==== use-after-free load
>     36bc: 45 85 ff                      testl   %r15d, %r15d
>     36bf: 78 8c                         js      0x364d <bpf_rb_root_free+0x18d>
>
> So the problem is at rec->refcount_off in the above.
>
> I did some source code analysis and find the reason.
>                                   CPU A                        CPU B
>   bpf_map_put:
>     ...
>     btf_put with rcu callback
>     ...
>     bpf_map_free_deferred
>       with system_unbound_wq
>     ...                          ...                           ...
>     ...                          btf_free_rcu:                 ...
>     ...                          ...                           bpf_map_free_deferred:
>     ...                          ...
>     ...         --------->       btf_struct_metas_free()
>     ...         | race condition ...
>     ...         --------->                                     map->ops->map_free()
>     ...
>     ...                          btf->struct_meta_tab = NULL
>
> In the above, map_free() corresponds to array_map_free() and eventually
> calling bpf_rb_root_free() which calls:
>   ...
>   __bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
>   ...
>
> Here, 'value_rec' is assigned in btf_check_and_fixup_fields() with following code:
>
>   meta = btf_find_struct_meta(btf, btf_id);
>   if (!meta)
>     return -EFAULT;
>   rec->fields[i].graph_root.value_rec = meta->record;
>
> So basically, 'value_rec' is a pointer to the record in struct_metas_tab.
> And it is possible that that particular record has been freed by
> btf_struct_metas_free() and hence we have a kasan error here.
>
> Actually it is very hard to reproduce the failure with current bpf/bpf-next
> code, I only got the above error once. To increase reproducibility, I added
> a delay in bpf_map_free_deferred() to delay map->ops->map_free(), which
> significantly increased reproducibility.
>
>   diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>   index 5e43ddd1b83f..aae5b5213e93 100644
>   --- a/kernel/bpf/syscall.c
>   +++ b/kernel/bpf/syscall.c
>   @@ -695,6 +695,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
>         struct bpf_map *map = container_of(work, struct bpf_map, work);
>         struct btf_record *rec = map->record;
>
>   +     mdelay(100);
>         security_bpf_map_free(map);
>         bpf_map_release_memcg(map);
>         /* implementation dependent freeing */
>
> To fix the problem, let us increase the reference count for btf
> so it won't be prematurely freed by btf_put() in bpf_map_free().
> The same strategy has been used by kptrs, and this patch did
> similar things for graph node (list_head and rb_root).
> Rerun './test_progs -j' with the above mdelay() hack for a couple
> of times and didn't observe the error.
>
> Fixes: 958cf2e273f0 ("bpf: Introduce bpf_obj_new")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  kernel/bpf/btf.c     | 1 +
>  kernel/bpf/syscall.c | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 63cf4128fc05..f999e0c1bb32 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3696,6 +3696,7 @@ static int btf_parse_graph_root(const struct btf *btf,
>  		if (offset % node_type_align)
>  			return -EINVAL;
>  
> +		btf_get((struct btf *)btf);

I think there will be memory leak for btf. Because btf_parse() calls
btf_parse_graph_root() indirectly as well, here btf_get() pins the BTF,
but the free of the passed btf_field is done in btf_free(), so the map
BTF can not be freed. It seems we need to pin the passed BTF optionally
and it depends on whether btf_record is freed by the passed BTF or not.

And for the extra type casting (namely (struct btf *)), I think we
should change the function signature of its callers to fix it, because
btf_get() does modify the passed btf.
>  		field->graph_root.btf = (struct btf *)btf;
>  		field->graph_root.value_btf_id = info->graph_root.value_btf_id;
>  		field->graph_root.node_offset = offset;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index ebaccf77d56e..00efc82a8e36 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -521,8 +521,10 @@ void btf_record_free(struct btf_record *rec)
>  			btf_put(rec->fields[i].kptr.btf);
>  			break;
>  		case BPF_LIST_HEAD:
> -		case BPF_LIST_NODE:
>  		case BPF_RB_ROOT:
> +			btf_put(rec->fields[i].graph_root.btf);
> +			break;
> +		case BPF_LIST_NODE:
>  		case BPF_RB_NODE:
>  		case BPF_SPIN_LOCK:
>  		case BPF_TIMER:
> @@ -570,8 +572,10 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
>  			}
>  			break;
>  		case BPF_LIST_HEAD:
> -		case BPF_LIST_NODE:
>  		case BPF_RB_ROOT:
> +			btf_get(fields[i].graph_root.btf);
> +			break;
> +		case BPF_LIST_NODE:
>  		case BPF_RB_NODE:
>  		case BPF_SPIN_LOCK:
>  		case BPF_TIMER:


