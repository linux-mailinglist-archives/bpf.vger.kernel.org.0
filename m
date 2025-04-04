Return-Path: <bpf+bounces-55289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFB3A7B36D
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0961732B1
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CF51F875F;
	Fri,  4 Apr 2025 00:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXAh+R9S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4D1F8739;
	Fri,  4 Apr 2025 00:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725160; cv=none; b=Joc99+eQq3fUHMZaHx9Qj2yEilDxdnBCvRuzz7cuZsOKH435kdcc4Sproj+okgHa8GFGf0iQzCHS5IxnB+advMjqyJTa4NaNaFtQ/JiyR+4V8dev1TAj+i45cDTsb5+WULU/Yc2tm0A1P95psWkLqVXritw3iYEz/jMZghwzwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725160; c=relaxed/simple;
	bh=lbJeD+K4S5kfWbH0kRQUiptWwBbMhU0X5XWz0+4Wh/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n/1ktFY1bVbiL3KT4zZSVuhWHE7/GSe0vZzjP6NdWLu2cdTyu02tuSsTfRhuHovBp2ZwjaQAe6uyusH7QDSmJYhxpF0LkA9eHr/2k/jO0K3lIRi60PFqB+oBb6+apJ0VUtbqE1tSlVoJTF12zVQagObBT6yzM85n04z3ZZmzqc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXAh+R9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90A0C4CEE5;
	Fri,  4 Apr 2025 00:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725160;
	bh=lbJeD+K4S5kfWbH0kRQUiptWwBbMhU0X5XWz0+4Wh/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QXAh+R9S4XvbDr67bLZHl4wdPCVNAvk16s4fftN89AQvPB5rJ9WddqxT3Joic3QTe
	 ssglyHO8aKPPnZupDQmQ3rPKJCY5axKKtiyqlEq4lYITybfIssY9orlNauuVYJWkHW
	 JUP4zugGbEoGDJKbmh8bcu1+ZpbGjfFPmJRSr/WZuz3Ly2m3CE52S2EFP5F0suIVP5
	 q2f7K0aBhaOvGwEB4BRiCfnMPiNsYFc0O2kJoIli68ZbbjZa+ebtqop2nTURiIECqC
	 7yz5WGgk7WauG/7E8fZa1y/gMJAmN42Rdsl/CvvFl6VZBe+fsAUSF5WkaX8sgwjgSJ
	 V7ckInlg8iwoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Vlad Poenaru <thevlad@meta.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 08/20] bpf: Fix kmemleak warning for percpu hashmap
Date: Thu,  3 Apr 2025 20:05:28 -0400
Message-Id: <20250404000541.2688670-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000541.2688670-1-sashal@kernel.org>
References: <20250404000541.2688670-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 11ba7ce076e5903e7bdc1fd1498979c331b3c286 ]

Vlad Poenaru reported the following kmemleak issue:

  unreferenced object 0x606fd7c44ac8 (size 32):
    backtrace (crc 0):
      pcpu_alloc_noprof+0x730/0xeb0
      bpf_map_alloc_percpu+0x69/0xc0
      prealloc_init+0x9d/0x1b0
      htab_map_alloc+0x363/0x510
      map_create+0x215/0x3a0
      __sys_bpf+0x16b/0x3e0
      __x64_sys_bpf+0x18/0x20
      do_syscall_64+0x7b/0x150
      entry_SYSCALL_64_after_hwframe+0x4b/0x53

Further investigation shows the reason is due to not 8-byte aligned
store of percpu pointer in htab_elem_set_ptr():
  *(void __percpu **)(l->key + key_size) = pptr;

Note that the whole htab_elem alignment is 8 (for x86_64). If the key_size
is 4, that means pptr is stored in a location which is 4 byte aligned but
not 8 byte aligned. In mm/kmemleak.c, scan_block() scans the memory based
on 8 byte stride, so it won't detect above pptr, hence reporting the memory
leak.

In htab_map_alloc(), we already have

        htab->elem_size = sizeof(struct htab_elem) +
                          round_up(htab->map.key_size, 8);
        if (percpu)
                htab->elem_size += sizeof(void *);
        else
                htab->elem_size += round_up(htab->map.value_size, 8);

So storing pptr with 8-byte alignment won't cause any problem and can fix
kmemleak too.

The issue can be reproduced with bpf selftest as well:
  1. Enable CONFIG_DEBUG_KMEMLEAK config
  2. Add a getchar() before skel destroy in test_hash_map() in prog_tests/for_each.c.
     The purpose is to keep map available so kmemleak can be detected.
  3. run './test_progs -t for_each/hash_map &' and a kmemleak should be reported.

Reported-by: Vlad Poenaru <thevlad@meta.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://lore.kernel.org/r/20250224175514.2207227-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/hashtab.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3ec941a0ea41c..bb3ba8ebaf3d2 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -198,12 +198,12 @@ static bool htab_is_percpu(const struct bpf_htab *htab)
 static inline void htab_elem_set_ptr(struct htab_elem *l, u32 key_size,
 				     void __percpu *pptr)
 {
-	*(void __percpu **)(l->key + key_size) = pptr;
+	*(void __percpu **)(l->key + roundup(key_size, 8)) = pptr;
 }
 
 static inline void __percpu *htab_elem_get_ptr(struct htab_elem *l, u32 key_size)
 {
-	return *(void __percpu **)(l->key + key_size);
+	return *(void __percpu **)(l->key + roundup(key_size, 8));
 }
 
 static void *fd_htab_map_get_ptr(const struct bpf_map *map, struct htab_elem *l)
@@ -2355,7 +2355,7 @@ static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0,
-				offsetof(struct htab_elem, key) + map->key_size);
+				offsetof(struct htab_elem, key) + roundup(map->key_size, 8));
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
 	*insn++ = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 
-- 
2.39.5


