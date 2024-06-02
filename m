Return-Path: <bpf+bounces-31144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFCE8D7550
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 14:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB961C210A4
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DE13A29C;
	Sun,  2 Jun 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE18SI1m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD3E38DF2
	for <bpf@vger.kernel.org>; Sun,  2 Jun 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717331121; cv=none; b=iYI9neFp3qaVV6cj5mAgQDu2rN30Wq7UkxH1gAfQZDg/SfIvx16DPuCYE3rG+07roGGjico8QuXLWm455bFoRHszRoal4GRn+OXGPCOQiY309K6vTmer3bIrsfrP6W47gfwBQ9VfL+kvc4LrAle5ZnH1pDuSKjfUfQFRcnoevSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717331121; c=relaxed/simple;
	bh=/NWLJpAp6WyHoqyJM8ptSDqXquXUD/eNAIQPCqGsth0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFJrW49zHrtu7pr8gaGWKeKgT6krJuT33JIhCGQ/uBZNvBKCrS+Z16JFXQ0BU8U4543kPyqBIbxFYk8xhf+ZWUGLN9S2lq3YmqNRiim170VlB8FVrFLPOGI1Cd6ngcZHBaU8r++w+fgfxbZhuzugmmHaKrTahTyGVi/2c8zDa3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE18SI1m; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7e9113f0cc8so149008039f.2
        for <bpf@vger.kernel.org>; Sun, 02 Jun 2024 05:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717331117; x=1717935917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16cwHBYsC4fBGL5DHiEXEg+jLqoS3mXtK6Q+iZcxcN0=;
        b=iE18SI1mpCAXnXEJEE7SIOWbSvt0CHul0ckKj4K4wKoPzgyM0ICV1apJRJgv2e0/y/
         pUCj3zYYS24ZTF+sW9j4p5QYXw0fet5vBlulo26aHGC7EfYsCVUkmGil9ri247ooNc28
         vBQcePXfsYr7GPHdPVS96Lceeum9/yTdFL4x0OTDPaXSpIH5d9qtiiYHGlUzx/wUK400
         103yQdatmd5k51p/AZd4EM7tivsGjdFbatH43wklffAmiD2RTqopwmx5kt7lNCLa/Ttb
         MViLrc8Dj9V2IDa31S9/N3uL4t1w/kciYVC0oNqC4KvhvbMDmGr/rRoJpycwsfnB7cm9
         g+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717331117; x=1717935917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16cwHBYsC4fBGL5DHiEXEg+jLqoS3mXtK6Q+iZcxcN0=;
        b=aQnkINQxzzT3ZdO/CX0TNTeHcZfwLk9ParFOnpm8qgmF9D3Whvg5tLB6wSW7/gPYgO
         L6azlzNyKxIZBFhVGRF3K78KvaQdha6Df+FgRkeC6z0m1aTqjTpGcwhCo+Qk/nwiTK4S
         U7Z6bOmbolV8AQxn7FleYZ//3R3lK9I025Wxt2oF5rcmtWPE1H95Zlf7UD4yTBCyirpx
         9Ly08yZ31wGRt7rCxX6vi/wyOqhUvgfSSrqx66fHfN4E5ny0w7vTj2YFG3l6oqtjsMjN
         /iO/KkHB/SG+wKDCkScO6ZOjEXNruZbDZmL88etlbY/DIrVFN3pBTWjcp/6Us0hnGCHN
         J9cA==
X-Gm-Message-State: AOJu0YwhDur09yUW9dwqYnOT4cKC4HMEPItwd0On748OpWxhp+PQlgWp
	uYNvP7rtrMM03kapfNt/tdCTxCbneIN9kU9AxV47n0xZzwVdDp+JBsC+vQ==
X-Google-Smtp-Source: AGHT+IEESUhvZ/jOQljINn0M1GQenQocrWhd1zrdKITVyFm+M1qyeBQfDSIiVU5+mRREFV24mlKEMA==
X-Received: by 2002:a05:6602:15c8:b0:7e1:8839:a32 with SMTP id ca18e2360f4ac-7eafff2d9dbmr827983239f.16.1717331117270;
        Sun, 02 Jun 2024 05:25:17 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423dc0ebsm3965332b3a.68.2024.06.02.05.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 05:25:16 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	hffilwlqm@gmail.com
Subject: [RFC PATCH bpf-next 1/2] bpf: Fix updating attached freplace to PROG_ARRAY map
Date: Sun,  2 Jun 2024 20:24:20 +0800
Message-ID: <20240602122421.50892-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240602122421.50892-1-hffilwlqm@gmail.com>
References: <20240602122421.50892-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 1c123c567fb138eb ("bpf: Resolve fext program type when
checking map compatibility"), freplace prog can be used as tail-callee.

However, when freplace prog has been attached and then updates to
PROG_ARRAY map, it will panic, because the updating checks prog type of
freplace prog by 'prog->aux->dst_prog->type' and 'prog->aux->dst_prog' of
freplace prog is NULL.

[309049.036402] BUG: kernel NULL pointer dereference, address: 0000000000000004
[309049.036419] #PF: supervisor read access in kernel mode
[309049.036426] #PF: error_code(0x0000) - not-present page
[309049.036432] PGD 0 P4D 0
[309049.036437] Oops: 0000 [#1] PREEMPT SMP NOPTI
[309049.036444] CPU: 2 PID: 788148 Comm: test_progs Not tainted 6.8.0-31-generic #31-Ubuntu
[309049.036465] Hardware name: VMware, Inc. VMware20,1/440BX Desktop Reference Platform, BIOS VMW201.00V.21805430.B64.2305221830 05/22/2023
[309049.036477] RIP: 0010:bpf_prog_map_compatible+0x2a/0x140
[309049.036488] Code: 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 49 89 fe 41 55 41 54 53 44 8b 6e 04 48 89 f3 41 83 fd 1c 75 0c 48 8b 46 38 48 8b 40 70 <44> 8b 68 04 f6 43 03 01 75 1c 48 8b 43 38 44 0f b6 a0 89 00 00 00
[309049.036505] RSP: 0018:ffffb2e080fd7ce0 EFLAGS: 00010246
[309049.036513] RAX: 0000000000000000 RBX: ffffb2e0807c1000 RCX: 0000000000000000
[309049.036521] RDX: 0000000000000000 RSI: ffffb2e0807c1000 RDI: ffff990290259e00
[309049.036528] RBP: ffffb2e080fd7d08 R08: 0000000000000000 R09: 0000000000000000
[309049.036536] R10: 0000000000000000 R11: 0000000000000000 R12: ffff990290259e00
[309049.036543] R13: 000000000000001c R14: ffff990290259e00 R15: ffff99028e29c400
[309049.036551] FS:  00007b82cbc28140(0000) GS:ffff9903b3f00000(0000) knlGS:0000000000000000
[309049.036559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[309049.036566] CR2: 0000000000000004 CR3: 0000000101286002 CR4: 00000000003706f0
[309049.036573] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[309049.036581] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[309049.036588] Call Trace:
[309049.036592]  <TASK>
[309049.036597]  ? show_regs+0x6d/0x80
[309049.036604]  ? __die+0x24/0x80
[309049.036619]  ? page_fault_oops+0x99/0x1b0
[309049.036628]  ? do_user_addr_fault+0x2ee/0x6b0
[309049.036634]  ? exc_page_fault+0x83/0x1b0
[309049.036641]  ? asm_exc_page_fault+0x27/0x30
[309049.036649]  ? bpf_prog_map_compatible+0x2a/0x140
[309049.036656]  prog_fd_array_get_ptr+0x2c/0x70
[309049.036664]  bpf_fd_array_map_update_elem+0x37/0x130
[309049.036671]  bpf_map_update_value+0x1d3/0x260
[309049.036677]  map_update_elem+0x1fa/0x360
[309049.036683]  __sys_bpf+0x54c/0xa10
[309049.036689]  __x64_sys_bpf+0x1a/0x30
[309049.036694]  x64_sys_call+0x1936/0x25c0
[309049.036700]  do_syscall_64+0x7f/0x180
[309049.036706]  ? do_syscall_64+0x8c/0x180
[309049.036712]  ? do_syscall_64+0x8c/0x180
[309049.036717]  ? irqentry_exit+0x43/0x50
[309049.036723]  ? common_interrupt+0x54/0xb0
[309049.036729]  entry_SYSCALL_64_after_hwframe+0x73/0x7b

Why 'prog->aux->dst_prog' of freplace prog is NULL? It causes by commit 3aac1ead5eb6
("bpf: Move prog->aux->linked_prog and trampoline into bpf_link on attach").

As 'prog->aux->dst_prog' of freplace prog is set as NULL when attach,
freplace prog does not have stable prog type. But when to update
freplace prog to PROG_ARRAY map, it requires checking prog type. They are
conflict in theory.

This patch is unable to resolve this issue thoroughly. It resolves prog
type of freplace prog by 'prog->aux->saved_dst_prog_type' to avoid panic.

Fixes: 1c123c567fb1 ("bpf: Resolve fext program type when checking map compatibility")
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 include/linux/bpf_verifier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 50aa87f8d77ff..b648a96ca310b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -845,7 +845,7 @@ static inline u32 type_flag(u32 type)
 static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
 {
 	return prog->type == BPF_PROG_TYPE_EXT ?
-		prog->aux->dst_prog->type : prog->type;
+		prog->aux->saved_dst_prog_type : prog->type;
 }
 
 static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
-- 
2.44.0


