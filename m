Return-Path: <bpf+bounces-46260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F299E6CA2
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 11:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15F6164BE0
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 10:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6CE1FBC8A;
	Fri,  6 Dec 2024 10:54:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEDA1DE2C7
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482466; cv=none; b=t71SKGMLUl89e7NgaTnF48x+ugFb24sKr1VY1satcYxs/f0T+spMjypnO9BKSp3CKSWLhq8KE3c/cK4U+/h2ZXyH4/P3dkXKcWn5J6WWTjRMTIdPSI8v2uDS5NndIY8YlmCErHa8gquJ6CbNp7Hli0bakPQbUx8F/jEg16whpwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482466; c=relaxed/simple;
	bh=qX3jkYQgn/ZUs8arhYYoStB2eat+QnaA5USOc0Ufe/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Syp199EwtmnYBnavf92yE7RoSclfBWsD8ifQSaiGc6ZlozvzbQZi7gPDoNdAlYgpvgZB6TmJBVefFURn6tktYJGOp65bsG6evpbDFYT1KuX+Fz2ZElWZcfoKAXxRZPSOXDOlBRrISj0lk6e7KTnkaUDUhFx58deghTleoqyoiGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Y4Smg1tnkz4f3jdR
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:53:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 57E7C1A0359
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 18:54:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHI4fS11JnmMhIDw--.40874S4;
	Fri, 06 Dec 2024 18:54:12 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf v3 0/9] Fixes for LPM trie
Date: Fri,  6 Dec 2024 19:06:13 +0800
Message-Id: <20241206110622.1161752-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHI4fS11JnmMhIDw--.40874S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWDuFWDCr48Gw13tFy7ZFb_yoW5ArWkpa
	yfKrn8Ar1FgF9xXw4Ika1jq3Wruw4fGw12ga15G34YvFy3ZFy3Jr4IgF1YvFy5ZFs3J3Wa
	yF4SqF1kX3Wvva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

This patch set fixes several issues for LPM trie. These issues were
found during adding new test cases or were reported by syzbot.

The patch set is structured as follows:

Patch #1~#2 are clean-ups for lpm_trie_update_elem().
Patch #3 handles BPF_EXIST and BPF_NOEXIST correctly for LPM trie.
Patch #4 fixes the accounting of n_entries when doing in-place update.
Patch #5 fixes the exact match condition in trie_get_next_key() and it
may skip keys when the passed key is not found in the map.
Patch #6~#7 switch from kmalloc() to bpf memory allocator for LPM trie
to fix several lock order warnings reported by syzbot. It also enables
raw_spinlock_t for LPM trie again. After these changes, the LPM trie will
be closer to being usable in any context (though the reentrance check of
trie->lock is still missing, but it is on my todo list).
Patch #8: move test_lpm_map to map_tests to make it run regularly.
Patch #9: add test cases for the issues fixed by patch #3~#5.

Please see individual patches for more details. Comments are always
welcome.

Change Log:
v3:
  * patch #2: remove the unnecessary NULL-init for im_node
  * patch #6: alloc the leaf node before disabling IRQ to low
    the possibility of -ENOMEM when leaf_size is large; Free
    these nodes outside the trie lock (Suggested by Alexei)
  * collect review and ack tags (Thanks for Toke & Daniel)

v2: https://lore.kernel.org/bpf/20241127004641.1118269-1-houtao@huaweicloud.com/
  * collect review tags (Thanks for Toke)
  * drop "Add bpf_mem_cache_is_mergeable() helper" patch
  * patch #3~#4: add fix tag
  * patch #4: rename the helper to trie_check_add_elem() and increase
    n_entries in it.
  * patch #6: use one bpf mem allocator and update commit message to
    clarify that using bpf mem allocator is more appropriate.
  * patch #7: update commit message to add the possible max running time
    for update operation.
  * patch #9: update commit message to specify the purpose of these test
    cases.

v1: https://lore.kernel.org/bpf/20241118010808.2243555-1-houtao@huaweicloud.com/

Hou Tao (9):
  bpf: Remove unnecessary check when updating LPM trie
  bpf: Remove unnecessary kfree(im_node) in lpm_trie_update_elem
  bpf: Handle BPF_EXIST and BPF_NOEXIST for LPM trie
  bpf: Handle in-place update for full LPM trie correctly
  bpf: Fix exact match conditions in trie_get_next_key()
  bpf: Switch to bpf mem allocator for LPM trie
  bpf: Use raw_spinlock_t for LPM trie
  selftests/bpf: Move test_lpm_map.c to map_tests
  selftests/bpf: Add more test cases for LPM trie

 kernel/bpf/lpm_trie.c                         | 133 +++---
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../lpm_trie_map_basic_ops.c}                 | 405 +++++++++++++++++-
 4 files changed, 484 insertions(+), 57 deletions(-)
 rename tools/testing/selftests/bpf/{test_lpm_map.c => map_tests/lpm_trie_map_basic_ops.c} (65%)

-- 
2.29.2


