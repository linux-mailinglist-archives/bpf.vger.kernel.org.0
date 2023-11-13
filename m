Return-Path: <bpf+bounces-15002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349267E9E4B
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 15:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550561C2097B
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2077A210F5;
	Mon, 13 Nov 2023 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452D6210E7;
	Mon, 13 Nov 2023 14:13:06 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8671727;
	Mon, 13 Nov 2023 06:13:04 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4STWbv6vJMz4f3jrs;
	Mon, 13 Nov 2023 22:12:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 485321A016F;
	Mon, 13 Nov 2023 22:13:01 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgBXpw3nLlJlMR9IAw--.44909S2;
	Mon, 13 Nov 2023 22:12:59 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: [bug report] BUG: KASAN: slab-use-after-free in
 sock_def_readable+0x101/0x450
To: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Message-ID: <edda3930-bbb7-c927-578d-c3bd51da7384@huaweicloud.com>
Date: Mon, 13 Nov 2023 22:12:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgBXpw3nLlJlMR9IAw--.44909S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1kAF4DGr13XF15Zw4rGrg_yoWxGw47pF
	nayFWxC3yfJryIqw4rtr4UJryUXFZFka1UtrZ2yF17J3W7Crn0qF1UXr1j9r1jgrW8Aryf
	K3WDtr4YvF1aqaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY
	1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

I got the following kasan report when running test_progs on bpf-tree
(commit 100888fb6d8a):

[  212.183985]
==================================================================
[  212.184699] BUG: KASAN: slab-use-after-free in
sock_def_readable+0x101/0x450
[  212.185375] Read of size 8 at addr ffff88812d9f1860 by task
kworker/4:1/67

[  212.186195] CPU: 4 PID: 67 Comm: kworker/4:1 Tainted: G          
O       6.6.0+ #9
[  212.186942] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[  212.188044] Workqueue: events sk_psock_backlog
[  212.188496] Call Trace:
[  212.188746]  <TASK>
[  212.188967]  dump_stack_lvl+0x4a/0x90
[  212.189342]  print_report+0xd2/0x620
[  212.189706]  ? kasan_complete_mode_report_info+0x7c/0x210
[  212.190241]  kasan_report+0xd1/0x110
[  212.190599]  ? sock_def_readable+0x101/0x450
[  212.191022]  ? sock_def_readable+0x101/0x450
[  212.191452]  kasan_check_range+0x101/0x1c0
[  212.191852]  __kasan_check_read+0x11/0x20
[  212.192253]  sock_def_readable+0x101/0x450
[  212.192656]  unix_stream_sendmsg+0x3cc/0xaa0
[  212.193093]  ? __pfx_unix_stream_sendmsg+0x10/0x10
[  212.193565]  ? __pfx___lock_acquire+0x10/0x10
[  212.194034]  sock_sendmsg+0x219/0x230
[  212.194400]  ? __pfx_sock_sendmsg+0x10/0x10
[  212.194813]  ? lock_acquire+0x180/0x420
[  212.195193]  ? sk_psock_backlog+0x3c/0x600
[  212.195598]  ? __pfx_lock_acquire+0x10/0x10
[  212.196014]  ? lock_is_held_type+0x97/0x100
[  212.196436]  ? __asan_storeN+0x12/0x20
[  212.196808]  __skb_send_sock+0x53b/0x660
[  212.197204]  ? __pfx_sendmsg_unlocked+0x10/0x10
[  212.197653]  ? sk_psock_backlog+0x3c/0x600
[  212.198057]  ? __pfx___skb_send_sock+0x10/0x10
[  212.198499]  ? __mutex_unlock_slowpath+0x122/0x410
[  212.198990]  skb_send_sock+0x15/0x20
[  212.199355]  sk_psock_backlog+0x149/0x600
[  212.199762]  process_one_work+0x462/0x990
[  212.200174]  ? __pfx_process_one_work+0x10/0x10
[  212.200617]  ? do_raw_spin_lock+0x115/0x1b0
[  212.201041]  ? assign_work+0xe6/0x120
[  212.201407]  worker_thread+0x370/0x670
[  212.201779]  ? __pfx_worker_thread+0x10/0x10
[  212.202202]  kthread+0x1b0/0x200
[  212.202525]  ? kthread+0x103/0x200
[  212.202862]  ? __pfx_kthread+0x10/0x10
[  212.203238]  ret_from_fork+0x3a/0x70
[  212.203600]  ? __pfx_kthread+0x10/0x10
[  212.203978]  ret_from_fork_asm+0x1b/0x30
[  212.204378]  </TASK>

[  212.204762] Allocated by task 415:
[  212.205109]  kasan_save_stack+0x26/0x50
[  212.205495]  kasan_set_track+0x25/0x40
[  212.205873]  kasan_save_alloc_info+0x1e/0x30
[  212.206291]  __kasan_slab_alloc+0x72/0x80
[  212.206689]  kmem_cache_alloc+0x16c/0x3a0
[  212.207086]  sk_prot_alloc+0x48/0x170
[  212.207446]  sk_alloc+0x31/0x5b0
[  212.207773]  unix_create1+0x8b/0x450
[  212.208131]  unix_create+0x82/0xf0
[  212.208470]  __sock_create+0x1d5/0x460
[  212.208838]  __sys_socketpair+0x1b1/0x3a0
[  212.209235]  __x64_sys_socketpair+0x54/0x70
[  212.209642]  do_syscall_64+0x36/0xb0
[  212.210005]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

[  212.210663] Freed by task 415:
[  212.210972]  kasan_save_stack+0x26/0x50
[  212.211348]  kasan_set_track+0x25/0x40
[  212.211717]  kasan_save_free_info+0x2b/0x50
[  212.212130]  __kasan_slab_free+0x113/0x190
[  212.212530]  slab_free_freelist_hook+0xd7/0x1e0
[  212.212983]  kmem_cache_free+0x109/0x280
[  212.213370]  __sk_destruct+0x247/0x370
[  212.213740]  sk_destruct+0x80/0x90
[  212.214080]  __sk_free+0x68/0x180
[  212.214410]  sk_free+0x4a/0x70
[  212.214723]  unix_release_sock+0x648/0x6e0
[  212.215128]  unix_release+0x55/0x80
[  212.215474]  __sock_release+0x64/0x130
[  212.215852]  sock_close+0x18/0x20
[  212.216187]  __fput+0x13d/0x510
[  212.216511]  __fput_sync+0x34/0x40
[  212.216854]  __x64_sys_close+0x56/0xa0
[  212.217232]  do_syscall_64+0x36/0xb0
[  212.217588]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

[  212.218243] The buggy address belongs to the object at ffff88812d9f1800
                which belongs to the cache UNIX-STREAM of size 1920
[  212.219431] The buggy address is located 96 bytes inside of
                freed 1920-byte region [ffff88812d9f1800, ffff88812d9f1f80)
[  212.220753] The buggy address belongs to the physical page:
[  212.221292] page:00000000739895e2 refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x12d9f0
[  212.222189] head:00000000739895e2 order:3 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[  212.222966] memcg:ffff88812d026501
[  212.223302] flags:
0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
[  212.224016] page_type: 0xffffffff()
[  212.224363] raw: 0017ffffc0000840 ffff888102fbb180 ffffea0004b67400
0000000000000002
[  212.225112] raw: 0000000000000000 0000000080100010 00000001ffffffff
ffff88812d026501
[  212.225848] page dumped because: kasan: bad access detected

[  212.226553] Memory state around the buggy address:
[  212.227022]  ffff88812d9f1700: 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00
[  212.227714]  ffff88812d9f1780: fc fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc
[  212.228413] >ffff88812d9f1800: fa fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb
[  212.229107]                                                        ^
[  212.229717]  ffff88812d9f1880: fb fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb
[  212.230418]  ffff88812d9f1900: fb fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb
[  212.231113]
==================================================================





