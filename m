Return-Path: <bpf+bounces-45063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD209D076B
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 02:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F340B21933
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 01:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A006D28379;
	Mon, 18 Nov 2024 01:13:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A6A95E
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892438; cv=none; b=uoSgBdzSvHdZp/gpej9Llg+mtjrnUdFKOu5xgT2d5KFaNPYdUIj8XbaPhEbFlMPrkCk9PjyZtPxHvqojnWmtR4PueyPACrxuVYdzzZDaeiTrHqQ1LmDcDSX0/tIxV92lUcadARRpnRVvZLpm4iPFnv7YzCfFBmkrupQEMM89ycM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892438; c=relaxed/simple;
	bh=lSCATPHFRF+JjeroSz2IXO4HAfM/d8Qk7gfAnsIUges=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OyaAzb9fitxIcMWyX+mdwJ2aqWanBpMZu8BfeInrrGcENJSmqiJN+nkO/OpmGqVTxescGtPVhAF1OXV2mmFUigACFtTO0Itg76fwELGlR5AssGAVqhyAsCR+2Vv1HMoRZTeVqzibk2gCUX5QuBfa3zwDUO47FJBtuzbvkIBSIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xs8Lg4FV2z4f3lfR
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 08:55:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E41151A07B6
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 08:55:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4eckDpn2G5fCA--.44635S4;
	Mon, 18 Nov 2024 08:55:58 +0800 (CST)
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 00/10] Fixes for LPM trie
Date: Mon, 18 Nov 2024 09:07:58 +0800
Message-Id: <20241118010808.2243555-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4eckDpn2G5fCA--.44635S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDXFWDXF43tFWrWryUKFg_yoW8Cw4kpa
	yfK398Ar10yF9xXw4xCa1Iqa4Fk3WfW3W2gay3WryYvFy2vry3Jr4xKF18Za45AF4fA3Wa
	yrWftF1vg3WvvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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
Patch #6~7 switch from kmalloc() to bpf memory allocator for LPM trie to
fix several lock order warnings reported by syzbot.
Patch #8 enables raw_spinlock_t for LPM trie again after switching to
bpf memory allocator.
Patch #9: move test_lpm_map to map_tests to make it run regularly.
Patch #10: add more basic test cases for LPM trie.

Please see individual patches for more details. Comments are always
welcome.

Hou Tao (10):
  bpf: Remove unnecessary check when updating LPM trie
  bpf: Remove unnecessary kfree(im_node) in lpm_trie_update_elem
  bpf: Handle BPF_EXIST and BPF_NOEXIST for LPM trie
  bpf: Handle in-place update for full LPM trie correctly
  bpf: Fix exact match conditions in trie_get_next_key()
  bpf: Add bpf_mem_cache_is_mergeable() helper
  bpf: Switch to bpf mem allocator for LPM trie
  bpf: Use raw_spinlock_t for LPM trie
  selftests/bpf: Move test_lpm_map.c to map_tests
  selftests/bpf: Add more test cases for LPM trie

 include/linux/bpf_mem_alloc.h                 |   1 +
 kernel/bpf/lpm_trie.c                         | 158 +++++--
 kernel/bpf/memalloc.c                         |  12 +
 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../lpm_trie_map_basic_ops.c}                 | 401 +++++++++++++++++-
 6 files changed, 523 insertions(+), 52 deletions(-)
 rename tools/testing/selftests/bpf/{test_lpm_map.c => map_tests/lpm_trie_map_basic_ops.c} (64%)

-- 
2.29.2


