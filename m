Return-Path: <bpf+bounces-53704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DEFA58A63
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 03:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD93C3A94BA
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 02:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6AF1922F5;
	Mon, 10 Mar 2025 02:19:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BD319DF99;
	Mon, 10 Mar 2025 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741573186; cv=none; b=BBoHPiBOxeppVxjaFCENKbgCNtS6bVkrgiJzjl/8NiZAYR7yvzggQgBE48y4h+t1HeuqzlkSg64N21FXnoJt/D86q1jhTvMViiTZX04KUu6un1jVkeaG6sUY0SkYAY4RY0zy1YQdAAueZ46MZejiMcUKMhEQWluG2/G63sRu7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741573186; c=relaxed/simple;
	bh=+UkM0OEN4rOw6DU7+Tx/C6WWCe6zyQipbpvPzubAuLE=;
	h=Subject:References:From:To:Cc:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ItrNkdlCJSmZ4VRF4f8GIt0+kx2ZrH4HtS9N/OJc7iSWST7kc/WlAUXKDGsdcHXiBX6hJhAxCYuy3e0ZmCiCvHq0sdYMwsA6qchRgMIpxgUPRuz+P9/db4Dtyz9aeQ4McVdgOqTXet06BhDWT9UEry2mAOmgE+5nskfH1cDBGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZB0vS0TxFz4f3lwf;
	Mon, 10 Mar 2025 10:19:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 59FA21A06DC;
	Mon, 10 Mar 2025 10:19:38 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgBnyl43TM5nOgYyGA--.16576S2;
	Mon, 10 Mar 2025 10:19:38 +0800 (CST)
Subject: =?UTF-8?Q?=5bRESEND=5d_Fwd=3a_=5bBUG=5d_list_corruption_in_=5f=5fbp?=
 =?UTF-8?Q?f=5flru=5fnode=5fmove_=28=29_=e3=80=90_bug_found_and_suggestions_?=
 =?UTF-8?Q?for_fixing_it=e3=80=91?=
References: <263a77e4-9ba8-f9e2-4aaf-5e2854d487e5@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
To: Strforexc yn <strforexc@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 "Alexei Starovoitov," <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
X-Forwarded-Message-Id: <263a77e4-9ba8-f9e2-4aaf-5e2854d487e5@huaweicloud.com>
Message-ID: <2e946e29-ccd3-3a12-d6b4-d44d778c9223@huaweicloud.com>
Date: Mon, 10 Mar 2025 10:19:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <263a77e4-9ba8-f9e2-4aaf-5e2854d487e5@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnyl43TM5nOgYyGA--.16576S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrW7XrWftFW3uF1fGFy3urg_yoW3JFy8pF
	45GFWUGr48Xr17AFW7Jr10kr4fGF1UAF4UJr17Gr10yF15ua1Utr1Utr47AF98Jr45Xr1f
	twn0qw48trW7GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Resend due to the HTML part in the reply. Sorry for the inconvenience.

Hi,

On 3/5/2025 9:28 PM, Strforexc yn wrote:
> Hi Maintainers,
>
> When using our customized Syzkaller to fuzz the latest Linux kernel,
> the following crash was triggered.
> Kernel Config : https://github.com/Strforexc/LinuxKernelbug/blob/main/.config
>
> A kernel BUG was reported due to list corruption during BPF LRU node movement.
> The issue occurs when the node being moved is the sole element in its list and
> also the next_inactive_rotation candidate. After moving, the list became empty,
> but next_inactive_rotation incorrectly pointed to the moved node, causing later
> operations to corrupt the list.

The list being pointed by next_inactive_rotation is a doubly linked list
(aka, struct list_head), therefore, there are at least two nodes in the
non-empty list: the head of the list and the sole element. When the node
is the last element in the list, next_inactive_rotation will be pointed
to the head of the list after the move. So I don't think the analysis
and the fix below is correct.
>
> Here is my fix suggestion:
> The fix checks if the node was the only element before adjusting
> next_inactive_rotation. If so, it sets the pointer to NULL, preventing invalid
> access.
>
> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
> index XXXXXXX..XXXXXXX 100644
> --- a/kernel/bpf/bpf_lru_list.c
> +++ b/kernel/bpf/bpf_lru_list.c
> @@ -119,8 +119,13 @@ static void __bpf_lru_node_move(struct bpf_lru_list *l,
>   * move the next_inactive_rotation pointer also.
>   */
>   if (&node->list == l->next_inactive_rotation)
> - l->next_inactive_rotation = l->next_inactive_rotation->prev;
> -
> + {
> + if (l->next_inactive_rotation->prev == &node->list) {
> + l->next_inactive_rotation = NULL;
> + } else {
> + l->next_inactive_rotation = l->next_inactive_rotation->prev;
> + }
> + }
>   list_move(&node->list, &l->lists[tgt_type]);
>  }
>
> -- 2.34.1 Our knowledge of the kernel is somewhat limited, and we'd
> appreciate it if you could determine if there is such an issue. If
> this issue doesn't have an impact, please ignore it ☺. If you fix this
> issue, please add the following tag to the commit: Reported-by:
> Zhizhuo Tang strforexctzzchange@foxmail.com, Jianzhou Zhao
> xnxc22xnxc22@qq.com, Haoran Liu <cherest_san@163.com> Last is my
> report： vmalloc memory list_add corruption. next->prev should be prev
> (ffffe8ffac433e40), but was 50ffffe8ffac433e. (next=ffffe8ffac433e41).
> ------------[ cut here ]------------ kernel BUG at
> lib/list_debug.c:29! Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> PTI CPU: 0 UID: 0 PID: 14524 Comm: syz.0.285 Not tainted
> 6.14.0-rc5-00013-g99fa936e8e4f #1 Hardware name: QEMU Standard PC
> (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014 RIP:
> 0010:__list_add_valid_or_report+0xfc/0x1a0 lib/list_debug.c:29

I suspect that the content of lists[BPF_LRU_LIST_T_ACTIVE].next has been
corrupted, because the pointer itself should be at least 8-bytes
aligned, but its value is 0xffffe8ffac433e41. Also only the last bit of
the next pointer is different with the address of
list[BPF_LRU_LIST_T_ACTIVE] itelse (aka 0xffffe8ffac433e40).

> Code: 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 a6 00 00 00
> 49 8b 54 24 08 4c 89 e1 48 c7 c7 c0 1f f2 8b e8 55 54 d3 fc 90 <0f> 0b
> 48 89 f7 48 89 34 24 e8 16 54 33 fd 48 8b 34 24 48 b8 00 00 RSP:
> 0018:ffffc900033779b0 EFLAGS: 00010046 RAX: 0000000000000075 RBX:
> ffffc900035777c8 RCX: 0000000000000000 RDX: 0000000000000000 RSI:
> 0000000000000000 RDI: 0000000000000000 RBP: ffffe8ffac433e40 R08:
> 0000000000000000 R09: 0000000000000000 R10: 0000000000000000 R11:
> 0000000000000000 R12: ffffe8ffac433e41 R13: ffffc900035777c8 R14:
> ffffe8ffac433e49 R15: ffffe8ffac433e50 FS: 00007fef15ddd640(0000)
> GS:ffff88802b600000(0000) knlGS:0000000000000000 CS: 0010 DS: 0000 ES:
> 0000 CR0: 0000000080050033 CR2: 00007ffd53abb238 CR3: 00000000296f4000
> CR4: 00000000000006f0 DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400 Call Trace: <TASK> __list_add_valid
> include/linux/list.h:88 [inline] __list_add include/linux/list.h:150
> [inline] list_add include/linux/list.h:169 [inline] list_move
> include/linux/list.h:299 [inline] __bpf_lru_node_move+0x21a/0x480
> kernel/bpf/bpf_lru_list.c:126
> __bpf_lru_list_rotate_inactive+0x20f/0x310
> kernel/bpf/bpf_lru_list.c:196 __bpf_lru_list_rotate
> kernel/bpf/bpf_lru_list.c:247 [inline] bpf_percpu_lru_pop_free
> kernel/bpf/bpf_lru_list.c:417 [inline] bpf_lru_pop_free+0x157/0x370
> kernel/bpf/bpf_lru_list.c:502 prealloc_lru_pop+0x23/0xf0
> kernel/bpf/hashtab.c:308 htab_lru_map_update_elem+0x14c/0xbe0
> kernel/bpf/hashtab.c:1251 bpf_map_update_value+0x675/0xf50
> kernel/bpf/syscall.c:289 generic_map_update_batch+0x44a/0x5f0
> kernel/bpf/syscall.c:1963 bpf_map_do_batch+0x4be/0x610
> kernel/bpf/syscall.c:5303 __sys_bpf+0x1002/0x1630
> kernel/bpf/syscall.c:5859 __do_sys_bpf kernel/bpf/syscall.c:5902
> [inline] __se_sys_bpf kernel/bpf/syscall.c:5900 [inline]
> __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5900 do_syscall_x64
> arch/x86/entry/common.c:52 [inline] do_syscall_64+0xcb/0x260
> arch/x86/entry/common.c:83 entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fef14fb85ad Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00
> f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c
> 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7
> d8 64 89 01 48 RSP: 002b:00007fef15ddcf98 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000141 RAX: ffffffffffffffda RBX: 00007fef15245fa0 RCX:
> 00007fef14fb85ad RDX: 0000000000000038 RSI: 0000400000000000 RDI:
> 000000000000001a RBP: 00007fef1506a8d6 R08: 0000000000000000 R09:
> 0000000000000000 R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000000 R13: 0000000000000000 R14: 00007fef15245fa0 R15:
> 00007fef15dbd000 </TASK> Modules linked in: ---[ end trace
> 0000000000000000 ]--- RIP: 0010:__list_add_valid_or_report+0xfc/0x1a0
> lib/list_debug.c:29 Code: 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00
> 0f 85 a6 00 00 00 49 8b 54 24 08 4c 89 e1 48 c7 c7 c0 1f f2 8b e8 55
> 54 d3 fc 90 <0f> 0b 48 89 f7 48 89 34 24 e8 16 54 33 fd 48 8b 34 24 48
> b8 00 00 RSP: 0018:ffffc900033779b0 EFLAGS: 00010046 RAX:
> 0000000000000075 RBX: ffffc900035777c8 RCX: 0000000000000000 RDX:
> 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000 RBP:
> ffffe8ffac433e40 R08: 0000000000000000 R09: 0000000000000000 R10:
> 0000000000000000 R11: 0000000000000000 R12: ffffe8ffac433e41 R13:
> ffffc900035777c8 R14: ffffe8ffac433e49 R15: ffffe8ffac433e50 FS:
> 00007fef15ddd640(0000) GS:ffff88802b600000(0000)
> knlGS:0000000000000000 CS: 0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033 CR2: 00007ffd53abb238 CR3: 00000000296f4000 CR4:
> 00000000000006f0 DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400 Regards, Strforexc .


