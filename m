Return-Path: <bpf+bounces-9970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0877F79F6A2
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 03:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A4FB20ACF
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 01:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65135814;
	Thu, 14 Sep 2023 01:55:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2239A
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 01:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA75C43140;
	Thu, 14 Sep 2023 01:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694656508;
	bh=t1Pr/RNuBBUYiftS/aXKvA2dyLKFjLPI0RdyqKx26mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPGreEU6tMMDK9Svk9eRu0j0d8cmMTcjcsBzD9NHwaetOnMkcT6q/ODzUWS6S00Uc
	 LEVpLhcGUMDLLJZ0uPZsetwNVFZ1JpRKfIaUsV9fGKkstgZVNqZz9UiAW6gpju2Br4
	 EoE9x0gbdiSkY+4Ah51S1PcVSARk3bC36ap1PhyAZptlKOEfLo6cmdJkox+NodTnt0
	 +IJbKIBM5Jrsi2YnUNSHRv6z+1znI/LkKUcMWPpGGE+wLnu1alXNB713ja3pOX2hHy
	 HCsWMpjTp56fnLm1xlZfAFYHR3gljZjdPc8VcwrPqfxlIBe4RWba2LIIR310R2QhUP
	 kXqn9pycDrfDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	syzbot+97522333291430dd277f@syzkaller.appspotmail.com,
	Marco Elver <elver@google.com>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 4/7] bpf: Annotate bpf_long_memcpy with data_race
Date: Wed, 13 Sep 2023 21:54:48 -0400
Message-Id: <20230914015459.51740-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914015459.51740-1-sashal@kernel.org>
References: <20230914015459.51740-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.3
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 6a86b5b5cd76d2734304a0173f5f01aa8aa2025e ]

syzbot reported a data race splat between two processes trying to
update the same BPF map value via syscall on different CPUs:

  BUG: KCSAN: data-race in bpf_percpu_array_update / bpf_percpu_array_update

  write to 0xffffe8fffe7425d8 of 8 bytes by task 8257 on cpu 1:
   bpf_long_memcpy include/linux/bpf.h:428 [inline]
   bpf_obj_memcpy include/linux/bpf.h:441 [inline]
   copy_map_value_long include/linux/bpf.h:464 [inline]
   bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
   bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
   generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
   bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
   __sys_bpf+0x28a/0x780
   __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
   __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
   __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

  write to 0xffffe8fffe7425d8 of 8 bytes by task 8268 on cpu 0:
   bpf_long_memcpy include/linux/bpf.h:428 [inline]
   bpf_obj_memcpy include/linux/bpf.h:441 [inline]
   copy_map_value_long include/linux/bpf.h:464 [inline]
   bpf_percpu_array_update+0x3bb/0x500 kernel/bpf/arraymap.c:380
   bpf_map_update_value+0x190/0x370 kernel/bpf/syscall.c:175
   generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1749
   bpf_map_do_batch+0x2df/0x3d0 kernel/bpf/syscall.c:4648
   __sys_bpf+0x28a/0x780
   __do_sys_bpf kernel/bpf/syscall.c:5241 [inline]
   __se_sys_bpf kernel/bpf/syscall.c:5239 [inline]
   __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5239
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

  value changed: 0x0000000000000000 -> 0xfffffff000002788

The bpf_long_memcpy is used with 8-byte aligned pointers, power-of-8 size
and forced to use long read/writes to try to atomically copy long counters.
It is best-effort only and no barriers are here since it _will_ race with
concurrent updates from BPF programs. The bpf_long_memcpy() is called from
bpf(2) syscall. Marco suggested that the best way to make this known to
KCSAN would be to use data_race() annotation.

Reported-by: syzbot+97522333291430dd277f@syzkaller.appspotmail.com
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/bpf/000000000000d87a7f06040c970c@google.com
Link: https://lore.kernel.org/bpf/57628f7a15e20d502247c3b55fceb1cb2b31f266.1693342186.git.daniel@iogearbox.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830adae..eb1bb76e87f8b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -425,7 +425,7 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
 
 	size /= sizeof(long);
 	while (size--)
-		*ldst++ = *lsrc++;
+		data_race(*ldst++ = *lsrc++);
 }
 
 /* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could be one of each. */
-- 
2.40.1


