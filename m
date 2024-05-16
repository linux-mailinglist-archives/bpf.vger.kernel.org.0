Return-Path: <bpf+bounces-29830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EA58C7090
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 05:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7ED5B2285A
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 03:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6659441D;
	Thu, 16 May 2024 03:14:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021F4688;
	Thu, 16 May 2024 03:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715829291; cv=none; b=O/zY/nL+zJZdNHhHlRXMQuyYiIq1ZpBXCkPQ2j+Jj+ir/ssvfnlyAtBptHlRUVbNP/861+iov34Ud++udcDWj5+a6Y89GzB80LGKPqrrZcb+0rb6RM6CS41sqxHr6poEcgcIdUSVGX0jmnLI+1QEwgy2UPb4JImOKCdH+Y8Jh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715829291; c=relaxed/simple;
	bh=rowuu9ugrGKZ/V2f9RKstIG9lCJHliRej0gakn/Cc0Y=;
	h=Subject:To:References:From:Cc:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LqfAiWHYIj5JRBZVNkGO+URP+Md07qP5JD0yosOTD4EWrW6plXrefJu5FHXmOM+iiYelnvP/70ryEp28356RsV4HOePlJsHj7j751gtRal8cQzi8rJb/MKW9wKbfduXKWpH1+zhAfKfcY/cq0pXVm2aZraAt58anH+C1zqzH5BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VfwDm2M7Vz4f3jdX;
	Thu, 16 May 2024 11:14:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0866C1A0B41;
	Thu, 16 May 2024 11:14:41 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXbQYaekVmhbsnMw--.9025S2;
	Thu, 16 May 2024 11:14:37 +0800 (CST)
Subject: Re: [syzbot] [bpf?] KASAN: slab-use-after-free Read in htab_map_alloc
 (2)
To: syzbot <syzbot+061f58eec3bde7ee8ffa@syzkaller.appspotmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000ac237d06179e3237@google.com>
From: Hou Tao <houtao@huaweicloud.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@google.com, song@kernel.org,
 yonghong.song@linux.dev
Message-ID: <d28e4f02-965d-96de-ee56-f7a001b67fe7@huaweicloud.com>
Date: Thu, 16 May 2024 11:14:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <000000000000ac237d06179e3237@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXbQYaekVmhbsnMw--.9025S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw15JF4DAr47tr1xCr48Zwb_yoWrtF1Dpw
	s8KFyxCr4FqryUZryUJr1UCF1UtwsxCF17GF4fWr1rZ3ZIgw1xKr1ktFWUXF9rCry8uFya
	qwn8Z3yrKw1rZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU13rcDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 5/4/2024 6:21 PM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2506f6229bd0 Merge branch 'net-dsa-adjust_link-removal'
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11ac64ef180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=15dda165e1d20cf1
> dashboard link: https://syzkaller.appspot.com/bug?extid=061f58eec3bde7ee8ffa
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fc61e6a6e169/disk-2506f622.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3ed6cc1ccbe5/vmlinux-2506f622.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c6ea42464245/bzImage-2506f622.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+061f58eec3bde7ee8ffa@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in lockdep_register_key+0x253/0x3f0 kernel/locking/lockdep.c:1225
> Read of size 8 at addr ffff88805fe2c298 by task syz-executor.1/5906
>
> CPU: 1 PID: 5906 Comm: syz-executor.1 Not tainted 6.9.0-rc5-syzkaller-01473-g2506f6229bd0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  lockdep_register_key+0x253/0x3f0 kernel/locking/lockdep.c:1225
>  htab_map_alloc+0x9b/0xe60 kernel/bpf/hashtab.c:506
>  map_create+0x90c/0x1200 kernel/bpf/syscall.c:1333
>  __sys_bpf+0x6d1/0x810 kernel/bpf/syscall.c:5659
>  __do_sys_bpf kernel/bpf/syscall.c:5784 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5782 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5782
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7781e7dea9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f7782c720c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007f7781fabf80 RCX: 00007f7781e7dea9
> RDX: 0000000000000048 RSI: 0000000020000140 RDI: 0100000000000000
> RBP: 00007f7781eca4a4 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f7781fabf80 R15: 00007ffe14057dd8
>  </TASK>
>
> Allocated by task 5593:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  __do_kmalloc_node mm/slub.c:3966 [inline]
>  __kmalloc_node_track_caller+0x24e/0x4e0 mm/slub.c:3986
>  kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:597
>  __alloc_skb+0x1f3/0x440 net/core/skbuff.c:666
>  alloc_skb include/linux/skbuff.h:1308 [inline]

SNIP
>
> The buggy address belongs to the object at ffff88805fe2c000
>  which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 664 bytes inside of
>  freed 2048-byte region [ffff88805fe2c000, ffff88805fe2c800)

After checking all possible callers of lockdep_register_key(), it seems
that the culprit is Qdisc instead of bpf hash-table, because only the
offset of lock_class_key in Qdisc is 664. And I think the use-after-free
problem happens as follow:

(1) call qdisc_alloc()
After calling lockdep_register_key(), qdisc_alloc() goes to errout1 due
to netdev_alloc_pcpu_stats() fails. However it doesn't call
lockdep_register_key() to unregister root_lock_key, but it frees the
allocated memory

(2) call htab_map_alloc
During the calling of lockdep_register_key(), it finds the lockdep_key
registered by free-ed Qdisc and triggers the use-after-free.

Will post a simple patch to fix it.


