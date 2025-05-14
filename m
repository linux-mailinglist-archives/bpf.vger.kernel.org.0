Return-Path: <bpf+bounces-58220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB039AB7445
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 20:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA858C2196
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 18:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C39F2820C9;
	Wed, 14 May 2025 18:23:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7C91E9B16;
	Wed, 14 May 2025 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747246996; cv=none; b=Sk5BqHMrVxSKIPhjrXdTb7XHQi5Ostq9JMBz5TnQcg12vFXo9VtlaHMTT4rNf4u6DYu+MJAjIVr16z2oJOFuUgzL1uVrSPGuSLcGBdf9VFhoJb/oQ+Uf6q/rsq6hnoktpLRu5hw0n0kCUqTDZ9OTaVG2VNv1HdBoARZ39etPVcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747246996; c=relaxed/simple;
	bh=4e1qOJWkWaFSa6R6yvbt8eruwMLzqqkT2IlDLCrqYys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L22IxhQcnqq3czH0E2UweUpc5fleRchqCSRMoP+GKSgoG3Rwrz8WH0br8/mTy3HgX2gELkt7YbHFeNIVr77i4eMKB5KuRBAPugf+DNPh9J9U0mKEQTDDIdNU8w8MYRnh3wpopm9Siwt3iYRvv6sHWV/V9YTJvvAVACAcB8JTTS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong
 Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Roman Gushchin <guro@fb.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, syzbot <syzkaller@googlegroups.com>, Eric
 Dumazet <edumazet@google.com>
Subject: [PATCH 5.10] bpf: Avoid overflows involving hash elem_size
Date: Wed, 14 May 2025 21:07:33 +0300
Message-ID: <20250514180733.1271988-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-01.aladdin.ru (192.168.1.101) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

From: Eric Dumazet <edumazet@google.com>

commit e1868b9e36d0ca52e4e7c6c06953f191446e44df upstream.

Use of bpf_map_charge_init() was making sure hash tables would not use more
than 4GB of memory.

Since the implicit check disappeared, we have to be more careful
about overflows, to support big hash tables.

syzbot triggers a panic using :

bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_LRU_HASH, key_size=16384, value_size=8,
                     max_entries=262200, map_flags=0, inner_map_fd=-1, map_name="",
                     map_ifindex=0, btf_fd=-1, btf_key_type_id=0, btf_value_type_id=0,
                     btf_vmlinux_value_type_id=0}, 64) = ...

BUG: KASAN: vmalloc-out-of-bounds in bpf_percpu_lru_populate kernel/bpf/bpf_lru_list.c:594 [inline]
BUG: KASAN: vmalloc-out-of-bounds in bpf_lru_populate+0x4ef/0x5e0 kernel/bpf/bpf_lru_list.c:611
Write of size 2 at addr ffffc90017e4a020 by task syz-executor.5/19786

CPU: 0 PID: 19786 Comm: syz-executor.5 Not tainted 5.10.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x4c8 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 bpf_percpu_lru_populate kernel/bpf/bpf_lru_list.c:594 [inline]
 bpf_lru_populate+0x4ef/0x5e0 kernel/bpf/bpf_lru_list.c:611
 prealloc_init kernel/bpf/hashtab.c:319 [inline]
 htab_map_alloc+0xf6e/0x1230 kernel/bpf/hashtab.c:507
 find_and_alloc_map kernel/bpf/syscall.c:123 [inline]
 map_create kernel/bpf/syscall.c:829 [inline]
 __do_sys_bpf+0xa81/0x5170 kernel/bpf/syscall.c:4336
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45deb9
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd93fbc0c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000001a40 RCX: 000000000045deb9
RDX: 0000000000000040 RSI: 0000000020000280 RDI: 0000000000000000
RBP: 000000000119bf60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bf2c
R13: 00007ffc08a7be8f R14: 00007fd93fbc19c0 R15: 000000000119bf2c

Fixes: 755e5d55367a ("bpf: Eliminate rlimit-based memory accounting for hashtab maps")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Roman Gushchin <guro@fb.com>
Link: https://lore.kernel.org/bpf/20201207182821.3940306-1-eric.dumazet@gmail.com
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 kernel/bpf/hashtab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4c7cab79d90e..829d6d3a8495 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -199,7 +199,7 @@ static void *fd_htab_map_get_ptr(const struct bpf_map *map, struct htab_elem *l)
 
 static struct htab_elem *get_htab_elem(struct bpf_htab *htab, int i)
 {
-	return (struct htab_elem *) (htab->elems + i * htab->elem_size);
+	return (struct htab_elem *) (htab->elems + i * (u64)htab->elem_size);
 }
 
 static void htab_free_elems(struct bpf_htab *htab)
@@ -255,7 +255,7 @@ static int prealloc_init(struct bpf_htab *htab)
 	if (!htab_is_percpu(htab) && !htab_is_lru(htab))
 		num_entries += num_possible_cpus();
 
-	htab->elems = bpf_map_area_alloc(htab->elem_size * num_entries,
+	htab->elems = bpf_map_area_alloc((u64)htab->elem_size * num_entries,
 					 htab->map.numa_node);
 	if (!htab->elems)
 		return -ENOMEM;
-- 
2.34.1


