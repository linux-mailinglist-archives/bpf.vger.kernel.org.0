Return-Path: <bpf+bounces-16030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C670F7FB5C9
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 10:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B9CB216EB
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13E048CC3;
	Tue, 28 Nov 2023 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUwp5qAk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD72E3F2
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 09:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F73FC433C8;
	Tue, 28 Nov 2023 09:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701163761;
	bh=AqnHQYm5KJcppl/sr8C22RY8YgWq7vXqnLF5mYExpcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RUwp5qAkaz/Rv7TVtFZLw4FEkVtDPQ8KGYp93N/SScwu7wxmRv0vndLvHgKZ2T2FD
	 YXJn0Vo+E0GLSMp0gl62/CFsP6fGFigCr+c77SjSi7RpY8ZwbUChybye2xUCen50Vw
	 ddJ5iMaIQB5giuj+iM4mpbjgfqY7o9xFhvDdDJeEuwmEeGeoRtgLQok7of7Htk4DF6
	 sleR/pGtG34hD3XN3WpafT2oTotsmW/SjPRf8doGgzRi530F/fUSdnf6KRxw9pnonY
	 Dt5i1dcNId7aqzgEAaOA5L+iRhwcqLjXMyuEjuklHqcgyhACxOYPurX7+klkaOP0rE
	 0Fcfkri1gUoDw==
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
	Hao Luo <haoluo@google.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCHv2 bpf 2/2] bpf: Fix prog_array_map_poke_run map poke update
Date: Tue, 28 Nov 2023 10:28:50 +0100
Message-ID: <20231128092850.1545199-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128092850.1545199-1-jolsa@kernel.org>
References: <20231128092850.1545199-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lee pointed out issue found by syscaller [0] hitting BUG in prog array
map poke update in prog_array_map_poke_run function due to error value
returned from bpf_arch_text_poke function.

There's race window where bpf_arch_text_poke can fail due to missing
bpf program kallsym symbols, which is accounted for with check for
-EINVAL in that BUG_ON call.

The problem is that in such case we won't update the tail call jump
and cause imballance for the next tail call update check which will
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

Fixing this by calling bpf_arch_text_poke with 'checkip=false' to skip the
bpf symbol check like we do in bpf_tail_call_direct_fixup. This way the
prog_array_map_poke_run does not depend on bpf program having the kallsym
symbol in place.

[0] https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810

Cc: Lee Jones <lee@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
Reported-by: syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/arraymap.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 7ba389f7212f..b194282eacbb 100644
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
+			 * 4) Any error happening below from bpf_arch_text_poke()
 			 *    is a unexpected bug.
 			 */
 			if (!READ_ONCE(poke->tailcall_target_stable))
@@ -1075,21 +1066,21 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 			if (new) {
 				ret = bpf_arch_text_poke(poke->tailcall_target,
 							 BPF_MOD_JUMP,
-							 old_addr, new_addr, true);
-				BUG_ON(ret < 0 && ret != -EINVAL);
+							 old_addr, new_addr, false);
+				BUG_ON(ret < 0);
 				if (!old) {
 					ret = bpf_arch_text_poke(poke->tailcall_bypass,
 								 BPF_MOD_JUMP,
 								 poke->bypass_addr,
-								 NULL, true);
-					BUG_ON(ret < 0 && ret != -EINVAL);
+								 NULL, false);
+					BUG_ON(ret < 0);
 				}
 			} else {
 				ret = bpf_arch_text_poke(poke->tailcall_bypass,
 							 BPF_MOD_JUMP,
 							 old_bypass_addr,
-							 poke->bypass_addr, true);
-				BUG_ON(ret < 0 && ret != -EINVAL);
+							 poke->bypass_addr, false);
+				BUG_ON(ret < 0);
 				/* let other CPUs finish the execution of program
 				 * so that it will not possible to expose them
 				 * to invalid nop, stack unwind, nop state
@@ -1098,8 +1089,8 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
 					synchronize_rcu();
 				ret = bpf_arch_text_poke(poke->tailcall_target,
 							 BPF_MOD_JUMP,
-							 old_addr, NULL, true);
-				BUG_ON(ret < 0 && ret != -EINVAL);
+							 old_addr, NULL, false);
+				BUG_ON(ret < 0);
 			}
 		}
 	}
-- 
2.43.0


