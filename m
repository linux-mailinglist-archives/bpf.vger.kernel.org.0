Return-Path: <bpf+bounces-15892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B1A7F9CE3
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 10:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D7FB20DA9
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 09:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CD517738;
	Mon, 27 Nov 2023 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIbz6kmo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E911C8A
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 09:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1753C433C7;
	Mon, 27 Nov 2023 09:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701078331;
	bh=hGCGagX9lvo2c0HMQyVR9FPN43ewMP0sAtlebuaooDI=;
	h=From:To:Cc:Subject:Date:From;
	b=VIbz6kmoD8uQ1YnhIKIwnt75Aktc/I1+PVqNe2QNR3CT2OH0xNDlEtc0k5vv9fhAz
	 6dHuS7kR0pTgolNRV+sL7DcuROGsLkTelb63l5fRZ2azJklz1prAiXHKOp7dwfAKBu
	 tIwYfjvynAUMw0lQ3j5TmqwLDebSmpEUS1gXHcSuBNamdG3wbGl8oJvz+OPkvb9h1N
	 2DZ77uzStFPhjVxuxA7o3mxG8fUkxr4gG4mEKrzcC2IAVurlQwVjuC2XdyxKFW6hDx
	 4xGgmZHSk1BHOfZeDNnwlmRQTkfcJ8mhzuT8Rb3mSNcR1kXGdR0vmcDP6vUz1Nc/XW
	 2uCcN4f4rM1yQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Lee Jones <lee@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf, x64: Fix prog_array_map_poke_run map poke update
Date: Mon, 27 Nov 2023 10:45:25 +0100
Message-ID: <20231127094525.1366740-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lee pointed out issue found by syscaller [0] hitting BUG in prog
array map poke update in prog_array_map_poke_run function due to
bpf_arch_text_poke error return value.

There's race window where bpf_arch_text_poke can fail due to missing
bpf program kallsym symbols, which is accounted for with check for
-EINVAL in BUG_ON.

The problem is that in such case we won't update the tail call jump
and cause imballance for the next tail call update check which will
fail with -EBUSY in __bpf_arch_text_poke.

I'm hitting following race during the program load:

  CPU 0                                   CPU 1

  bpf_prog_load
    bpf_check
      do_misc_fixups
        prog_array_map_poke_track {}

                                          map_update_elem
                                            bpf_fd_array_map_update_elem
                                              prog_array_map_poke_run

                                                bpf_arch_text_poke returns -EINVAL

    bpf_prog_kallsyms_add

After bpf_arch_text_poke (CPU 1) fails to update the tail call jump,
the next poke update fails on expected jump instruction check in
__bpf_arch_text_poke with -EBUSY and triggers the BUG_ON in
prog_array_map_poke_run.

Similar race exists on the program unload.

Fixing this by calling directly __bpf_arch_text_poke and skipping the bpf
symbol check like we do in bpf_tail_call_direct_fixup. This way the
prog_array_map_poke_run does not depend on bpf program having the kallsym
symbol in place.

[0] https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810

Cc: Lee Jones <lee@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
Reported-by: syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com
Tested-by: Lee Jones <lee@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c |  4 ++--
 include/linux/bpf.h         |  2 ++
 kernel/bpf/arraymap.c       | 31 +++++++++++--------------------
 3 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8c10d9abc239..35c2988caf29 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -391,8 +391,8 @@ static int emit_jump(u8 **pprog, void *func, void *ip)
 	return emit_patch(pprog, func, ip, 0xE9);
 }
 
-static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
-				void *old_addr, void *new_addr)
+int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
+			 void *old_addr, void *new_addr)
 {
 	const u8 *nop_insn = x86_nops[5];
 	u8 old_insn[X86_PATCH_SIZE];
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6762dac3ef76..c28a8563e845 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3174,6 +3174,8 @@ enum bpf_text_poke_type {
 
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *addr1, void *addr2);
+int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
+			 void *old_addr, void *new_addr);
 
 void *bpf_arch_text_copy(void *dst, void *src, size_t len);
 int bpf_arch_text_invalidate(void *dst, size_t len);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 2058e89b5ddd..0b5afa2ec17a 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -1044,20 +1044,11 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
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
+			 *    buffer is freed.
+			 * 4) Any error happening below from __bpf_arch_text_poke()
 			 *    is a unexpected bug.
 			 */
 			if (!READ_ONCE(poke->tailcall_target_stable))
@@ -1073,33 +1064,33 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 			new_addr = new ? (u8 *)new->bpf_func + poke->adj_off : NULL;
 
 			if (new) {
-				ret = bpf_arch_text_poke(poke->tailcall_target,
+				ret = __bpf_arch_text_poke(poke->tailcall_target,
 							 BPF_MOD_JUMP,
 							 old_addr, new_addr);
-				BUG_ON(ret < 0 && ret != -EINVAL);
+				BUG_ON(ret < 0);
 				if (!old) {
-					ret = bpf_arch_text_poke(poke->tailcall_bypass,
+					ret = __bpf_arch_text_poke(poke->tailcall_bypass,
 								 BPF_MOD_JUMP,
 								 poke->bypass_addr,
 								 NULL);
-					BUG_ON(ret < 0 && ret != -EINVAL);
+					BUG_ON(ret < 0);
 				}
 			} else {
-				ret = bpf_arch_text_poke(poke->tailcall_bypass,
+				ret = __bpf_arch_text_poke(poke->tailcall_bypass,
 							 BPF_MOD_JUMP,
 							 old_bypass_addr,
 							 poke->bypass_addr);
-				BUG_ON(ret < 0 && ret != -EINVAL);
+				BUG_ON(ret < 0);
 				/* let other CPUs finish the execution of program
 				 * so that it will not possible to expose them
 				 * to invalid nop, stack unwind, nop state
 				 */
 				if (!ret)
 					synchronize_rcu();
-				ret = bpf_arch_text_poke(poke->tailcall_target,
+				ret = __bpf_arch_text_poke(poke->tailcall_target,
 							 BPF_MOD_JUMP,
 							 old_addr, NULL);
-				BUG_ON(ret < 0 && ret != -EINVAL);
+				BUG_ON(ret < 0);
 			}
 		}
 	}
-- 
2.43.0


