Return-Path: <bpf+bounces-18865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 695A9822F63
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 15:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31C61F2436C
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 14:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F761A59A;
	Wed,  3 Jan 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udOqa7YP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEBE1A587;
	Wed,  3 Jan 2024 14:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA331C433C7;
	Wed,  3 Jan 2024 14:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704291971;
	bh=Us1U4ekKUZYhDZM+/JiE/lHdH9RPsrOOu25MquneZRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udOqa7YP6ola/DrR4YwY5Luv39v8BkcG3aSJ3dzErw27tHAFgCb4mt3HB2c1F0/B9
	 wEE4LYYJURI8nUIkBX9efDqXSOnZYiqBdFnOtKBrDhQ4HE2BeRJAqVeEw1hENvsySs
	 HUInTYFxAYzrUHIanQAr1DH1JsplQrJB9bijTUiZ04FIUU2T4vue8tXuBe0S0NxwLW
	 F0B0s5a4hihoOxHlLmJFAWiHZvYHe2eZoJ7BNjFDOIRsxb2/ilgL3O6dhtw++Omwf1
	 21GWy+zw21a8rTe/HxTcfcBh9lJs90kieBNMg3Akx7Ld8/gz57zJFfPNT+rzd+lNnA
	 aNX5hNF2dsYTg==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com,
	Yonghong Song <yonghong.song@linux.dev>,
	Lee Jones <lee@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH stable 5.15 1/1] bpf: Fix prog_array_map_poke_run map poke update
Date: Wed,  3 Jan 2024 15:25:57 +0100
Message-ID: <20240103142557.4009040-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103142557.4009040-1-jolsa@kernel.org>
References: <20240103142557.4009040-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 4b7de801606e504e69689df71475d27e35336fb3 upstream.

[ The patch differs from upstream by calling __bpf_arch_text_poke with
  text_live=true, because 5.15 does not have commit 1022a5498f6f ]

Lee pointed out issue found by syscaller [0] hitting BUG in prog array
map poke update in prog_array_map_poke_run function due to error value
returned from bpf_arch_text_poke function.

There's race window where bpf_arch_text_poke can fail due to missing
bpf program kallsym symbols, which is accounted for with check for
-EINVAL in that BUG_ON call.

The problem is that in such case we won't update the tail call jump
and cause imbalance for the next tail call update check which will
fail with -EBUSY in bpf_arch_text_poke.

I'm hitting following race during the program load:

  CPU 0                             CPU 1

  bpf_prog_load
    bpf_check
      do_misc_fixups
        prog_array_map_poke_track

                                    map_update_elem
                                      bpf_fd_array_map_update_elem
                                        prog_array_map_poke_run

                                          bpf_arch_text_poke returns -EINVAL

    bpf_prog_kallsyms_add

After bpf_arch_text_poke (CPU 1) fails to update the tail call jump, the next
poke update fails on expected jump instruction check in bpf_arch_text_poke
with -EBUSY and triggers the BUG_ON in prog_array_map_poke_run.

Similar race exists on the program unload.

Fixing this by moving the update to bpf_arch_poke_desc_update function which
makes sure we call __bpf_arch_text_poke that skips the bpf address check.

Each architecture has slightly different approach wrt looking up bpf address
in bpf_arch_text_poke, so instead of splitting the function or adding new
'checkip' argument in previous version, it seems best to move the whole
map_poke_run update as arch specific code.

  [0] https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810

Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
Reported-by: syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Cc: Lee Jones <lee@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Link: https://lore.kernel.org/bpf/20231206083041.1306660-2-jolsa@kernel.org
---
 arch/x86/net/bpf_jit_comp.c | 46 +++++++++++++++++++++++++++++
 include/linux/bpf.h         |  3 ++
 kernel/bpf/arraymap.c       | 58 +++++++------------------------------
 3 files changed, 59 insertions(+), 48 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index dccaab2113f9..ee6e3cda1738 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2403,3 +2403,49 @@ bool bpf_jit_supports_kfunc_call(void)
 {
 	return true;
 }
+
+void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
+			       struct bpf_prog *new, struct bpf_prog *old)
+{
+	u8 *old_addr, *new_addr, *old_bypass_addr;
+	int ret;
+
+	old_bypass_addr = old ? NULL : poke->bypass_addr;
+	old_addr = old ? (u8 *)old->bpf_func + poke->adj_off : NULL;
+	new_addr = new ? (u8 *)new->bpf_func + poke->adj_off : NULL;
+
+	/*
+	 * On program loading or teardown, the program's kallsym entry
+	 * might not be in place, so we use __bpf_arch_text_poke to skip
+	 * the kallsyms check.
+	 */
+	if (new) {
+		ret = __bpf_arch_text_poke(poke->tailcall_target,
+					   BPF_MOD_JUMP,
+					   old_addr, new_addr, true);
+		BUG_ON(ret < 0);
+		if (!old) {
+			ret = __bpf_arch_text_poke(poke->tailcall_bypass,
+						   BPF_MOD_JUMP,
+						   poke->bypass_addr,
+						   NULL, true);
+			BUG_ON(ret < 0);
+		}
+	} else {
+		ret = __bpf_arch_text_poke(poke->tailcall_bypass,
+					   BPF_MOD_JUMP,
+					   old_bypass_addr,
+					   poke->bypass_addr, true);
+		BUG_ON(ret < 0);
+		/* let other CPUs finish the execution of program
+		 * so that it will not possible to expose them
+		 * to invalid nop, stack unwind, nop state
+		 */
+		if (!ret)
+			synchronize_rcu();
+		ret = __bpf_arch_text_poke(poke->tailcall_target,
+					   BPF_MOD_JUMP,
+					   old_addr, NULL, true);
+		BUG_ON(ret < 0);
+	}
+}
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9ab087d73ab3..00c615fc8ec3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2280,6 +2280,9 @@ enum bpf_text_poke_type {
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *addr1, void *addr2);
 
+void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
+			       struct bpf_prog *new, struct bpf_prog *old);
+
 struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 88014cd31b28..23ffb8f0b5d7 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -957,11 +957,16 @@ static void prog_array_map_poke_untrack(struct bpf_map *map,
 	mutex_unlock(&aux->poke_mutex);
 }
 
+void __weak bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
+				      struct bpf_prog *new, struct bpf_prog *old)
+{
+	WARN_ON_ONCE(1);
+}
+
 static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 				    struct bpf_prog *old,
 				    struct bpf_prog *new)
 {
-	u8 *old_addr, *new_addr, *old_bypass_addr;
 	struct prog_poke_elem *elem;
 	struct bpf_array_aux *aux;
 
@@ -970,7 +975,7 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 
 	list_for_each_entry(elem, &aux->poke_progs, list) {
 		struct bpf_jit_poke_descriptor *poke;
-		int i, ret;
+		int i;
 
 		for (i = 0; i < elem->aux->size_poke_tab; i++) {
 			poke = &elem->aux->poke_tab[i];
@@ -989,21 +994,10 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 			 *    activated, so tail call updates can arrive from here
 			 *    while JIT is still finishing its final fixup for
 			 *    non-activated poke entries.
-			 * 3) On program teardown, the program's kallsym entry gets
-			 *    removed out of RCU callback, but we can only untrack
-			 *    from sleepable context, therefore bpf_arch_text_poke()
-			 *    might not see that this is in BPF text section and
-			 *    bails out with -EINVAL. As these are unreachable since
-			 *    RCU grace period already passed, we simply skip them.
-			 * 4) Also programs reaching refcount of zero while patching
+			 * 3) Also programs reaching refcount of zero while patching
 			 *    is in progress is okay since we're protected under
 			 *    poke_mutex and untrack the programs before the JIT
-			 *    buffer is freed. When we're still in the middle of
-			 *    patching and suddenly kallsyms entry of the program
-			 *    gets evicted, we just skip the rest which is fine due
-			 *    to point 3).
-			 * 5) Any other error happening below from bpf_arch_text_poke()
-			 *    is a unexpected bug.
+			 *    buffer is freed.
 			 */
 			if (!READ_ONCE(poke->tailcall_target_stable))
 				continue;
@@ -1013,39 +1007,7 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 			    poke->tail_call.key != key)
 				continue;
 
-			old_bypass_addr = old ? NULL : poke->bypass_addr;
-			old_addr = old ? (u8 *)old->bpf_func + poke->adj_off : NULL;
-			new_addr = new ? (u8 *)new->bpf_func + poke->adj_off : NULL;
-
-			if (new) {
-				ret = bpf_arch_text_poke(poke->tailcall_target,
-							 BPF_MOD_JUMP,
-							 old_addr, new_addr);
-				BUG_ON(ret < 0 && ret != -EINVAL);
-				if (!old) {
-					ret = bpf_arch_text_poke(poke->tailcall_bypass,
-								 BPF_MOD_JUMP,
-								 poke->bypass_addr,
-								 NULL);
-					BUG_ON(ret < 0 && ret != -EINVAL);
-				}
-			} else {
-				ret = bpf_arch_text_poke(poke->tailcall_bypass,
-							 BPF_MOD_JUMP,
-							 old_bypass_addr,
-							 poke->bypass_addr);
-				BUG_ON(ret < 0 && ret != -EINVAL);
-				/* let other CPUs finish the execution of program
-				 * so that it will not possible to expose them
-				 * to invalid nop, stack unwind, nop state
-				 */
-				if (!ret)
-					synchronize_rcu();
-				ret = bpf_arch_text_poke(poke->tailcall_target,
-							 BPF_MOD_JUMP,
-							 old_addr, NULL);
-				BUG_ON(ret < 0 && ret != -EINVAL);
-			}
+			bpf_arch_poke_desc_update(poke, new, old);
 		}
 	}
 }
-- 
2.43.0


