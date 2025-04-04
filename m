Return-Path: <bpf+bounces-55275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1A8A7B2F4
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 02:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05EDC7A7FE7
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B25617B50A;
	Fri,  4 Apr 2025 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdQARpbJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD629178CF8;
	Fri,  4 Apr 2025 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725063; cv=none; b=ZKGPnJa22pJwL5WA78sjGjoXkWQN5Lc17TGjALWANRgsAoO7L7Mab69lUXu2mkRqDCwv79pWDWVVDf+moHN+UTNZALTcMeZT3yLmMHiFNtoBYIfgAMCc+z9295qKsYokn6jbEJhUMsFsuMu/A5qWBuOETobEFYN8DaiPG6uYPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725063; c=relaxed/simple;
	bh=Vs7ETizBunCJX9rKsc3qwP8DPfDySkX/BY3oWLYBDu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dC+GOv2+5X84tTno62uAlRP/qeA2Adza7MhwAEztXNAVrfEeqBqvhFdqTXd/0IlOY/OdLudyl5+Tqu/v6DSedZQE1mw43rooBcYTZPWcZCfuR50W84PFTmqoVJ5e6/S3DO145rmHCA5zGYa/7yiPQoCWfKGoF0/DE3MExlYvuEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdQARpbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09145C4CEE9;
	Fri,  4 Apr 2025 00:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725063;
	bh=Vs7ETizBunCJX9rKsc3qwP8DPfDySkX/BY3oWLYBDu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdQARpbJpH8KE8p7ZBTqMRGn4vzmhsTpAGOEOaQdHHnwQG6DB9bui9UPF8rxCUmAO
	 D8aav3hpLP+ExBMqwC2i+DCckIkBMEW3ic/sCwPRSSLfCMPZ141U95/HvMiFIMQ4Rc
	 MDL2W/vKsEN4EoQ1vbK6SxOTA/Lqgj7lFIoHRZZWfSO5ZyJPc7OwkqPMqjbk8iUclY
	 tRrpV3+fW2kwPwwAVKj7amPI+VpLrU9UowVjJd7PpwrUh7eRxk2aZrHRY67nGedjT6
	 G2A1nbk6e8HBA/853okaSuheVUm83kceaW1ZM83RDNr8bTAlJY+LOFZqTulG9rIr8E
	 1gVs4GaxHhEgQ==
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
Subject: [PATCH AUTOSEL 6.14 09/23] bpf: Fix kmemleak warning for percpu hashmap
Date: Thu,  3 Apr 2025 20:03:46 -0400
Message-Id: <20250404000402.2688049-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000402.2688049-1-sashal@kernel.org>
References: <20250404000402.2688049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index 4a9eeb7aef855..c308300fc72f6 100644
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
@@ -2354,7 +2354,7 @@ static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn
 	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3);
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0,
-				offsetof(struct htab_elem, key) + map->key_size);
+				offsetof(struct htab_elem, key) + roundup(map->key_size, 8));
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
 	*insn++ = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 
-- 
2.39.5


