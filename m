Return-Path: <bpf+bounces-45669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B600D9DA006
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 01:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F19A168E09
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 00:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5D68831;
	Wed, 27 Nov 2024 00:34:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF112F30
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 00:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732667685; cv=none; b=QALITuAS/okvjVymgxhBJu7ZhxbqWadxcbvIUBhFcK99xoQ5O2s6wXhC/0n//JRBsBmIYVNCYul+tqKN0FAewO6awM8jPiZs50qsGydminXSzKGtTrOJeq9bEljsElhtsFHOuQIBqhQF3xamBJcFa224a8yjDWiAndA8nlfZaDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732667685; c=relaxed/simple;
	bh=tBYXgHpQwU8XEzgKLkrKXqTqtMacj9tIYDybuzEmb0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ef1M4/FGoFZaBghzVbnqNrdtY2McF217etF8trPK91DtwvAyRKgYhcmr1tL0XmYKznfQWjE68Yudcv2AQMVcV5WPeOK0EkcVbN/ZkhOXN0PaPluxmfSCwn62FUffNrzk7DtYnAOHhfa4MQTkyOgx1Zv9G5woQMxIRQU0NI8FawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XygRq0pvCz4f3jdg
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:34:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D60971A0568
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:34:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBHI4cVaUZn5pO9Cw--.38194S4;
	Wed, 27 Nov 2024 08:34:31 +0800 (CST)
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
Subject: [PATCH bpf v2 0/9] Fixes for LPM trie
Date: Wed, 27 Nov 2024 08:46:32 +0800
Message-Id: <20241127004641.1118269-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHI4cVaUZn5pO9Cw--.38194S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWDuw13JFWfXrW7JFW3GFg_yoW5Gry5pa
	yftrn8Ar15KF9xXw42ka10q3Wrua1fG3W2ga15G34qvFy7ZFy3Jr4I9F1UZa45AF4fJ3Wa
	yF4SyF1kW3WvvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUIa0PDUUUU
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
v2:
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

 kernel/bpf/lpm_trie.c                         | 106 +++--
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../lpm_trie_map_basic_ops.c}                 | 405 +++++++++++++++++-
 4 files changed, 464 insertions(+), 50 deletions(-)
 rename tools/testing/selftests/bpf/{test_lpm_map.c => map_tests/lpm_trie_map_basic_ops.c} (65%)

-- 
2.29.2


