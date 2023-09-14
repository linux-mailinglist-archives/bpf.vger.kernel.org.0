Return-Path: <bpf+bounces-9971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B58579F6E1
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 03:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C78281B7B
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 01:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0736815AB;
	Thu, 14 Sep 2023 01:55:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666EC39E
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 01:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325C6C433CB;
	Thu, 14 Sep 2023 01:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694656532;
	bh=H8J6x+2Y6tppzE18uo4IDaHZGGtg6t6HrzYXaGUNOes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvzLWIBe2AOKn1ZnpUkPKNGGpdSOGvm6UsDAlcV9DQpYcLJuEyMCxUxOLsm4my0Yv
	 HxmGkNP9X2vrD6t0FCWUAyOY41QCk2uKq3TtYECEhRHrEC1OH/EO9NIM2Ng75ahneM
	 kAj89ST4jkTcY7mW4RSv1Zj1uzBcX9jvCs8w9C0IkN8YpII57o2vUPvX2BYhZIWlJy
	 P9TngpjwyS/ewXAmJ049+7Le28OXWMItNg+bAX/LkV/mMUc+ftBJ8hEPfhFXXAvwlk
	 0eeoqvXW+wsoP7ABFNHoXmNSRX8RAaiFUCEp69fpTeCebMCSg0retda+JBHSUwNNI1
	 ynj980ktmx0wA==
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
Subject: [PATCH AUTOSEL 6.1 4/6] bpf: Annotate bpf_long_memcpy with data_race
Date: Wed, 13 Sep 2023 21:55:14 -0400
Message-Id: <20230914015523.51894-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914015523.51894-1-sashal@kernel.org>
References: <20230914015523.51894-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.53
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
index 8cef9ec3a89c2..5b53d4c166506 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -301,7 +301,7 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
 
 	size /= sizeof(long);
 	while (size--)
-		*ldst++ = *lsrc++;
+		data_race(*ldst++ = *lsrc++);
 }
 
 /* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could be one of each. */
-- 
2.40.1


