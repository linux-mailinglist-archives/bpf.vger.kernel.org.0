Return-Path: <bpf+bounces-30618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E25E8CF69C
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 01:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8B71C20E26
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 23:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BC613A3E1;
	Sun, 26 May 2024 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Revskb8s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643808BE7;
	Sun, 26 May 2024 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716764816; cv=none; b=abP3gNfnMI1UyvB3Y3xVGIIefuLPPPuGDwQ/KU4aNE/ors78dgATiAiYV58bPUSpTBPmF23pXZOExud50JZBRaaYyPtuc4v1VQ9GmgcRYe3sDlNn4aU5z8yquQV+mixIglMuaxXIfRcmVKbba2C+KEnWWI4v0djQvEERVOxty98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716764816; c=relaxed/simple;
	bh=tV9a6uconUwR7erk4Id3zTcW3RE9e+fvV73JW2n3cZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LwSu2zy27PNZI0oiNdns8qCIFhfUXTT8MrSyITRPeyoXrpvo2ETyiWMOuQuRD5IvoPgbxlHmhQwCpEOPU1601ax7JS1/WK9hDOJcTcpRCs0/zxUgGmz9EP32KfWdAlShGMjUmaqJ+7xfMVJzjQ61W8vSKf3Xq5Htz+v5PXN0oUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Revskb8s; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-371c97913cdso23242925ab.3;
        Sun, 26 May 2024 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716764813; x=1717369613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zJqtAAqlFhCcDbb4ROnfcMhXZWMT8rTzCRv8aWFfHq8=;
        b=Revskb8snfzPYIUc/CVXgSpm1cW12KIki3TvZQ3+1GDMlgPqdD8pzM7KL3aMgrxEUp
         pshChCrD0Inol+opqr/21kgYmQyH2CSPFpMHZsRdWzWwrDf4BrD+1YUBbpS15pajBG8H
         xml7OkFnqOpM58PrNnvDbv4q9Y/+qK029gSJ5RvGD3DD7dFwQlOUqPi7DB9uxB1+Pxqo
         pHMghCZfakew1B7oHyL65k1HCfOUDc9JHaVkk82sJ8/NTtsFj6G90Ayvu+IwYQAaMPVy
         NSceWW/IQgpzikm0SfOsWj807MYJ1t7ltSafcKb11IzDKBI7g476BZK3nwBKtbEREQvm
         9juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716764813; x=1717369613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJqtAAqlFhCcDbb4ROnfcMhXZWMT8rTzCRv8aWFfHq8=;
        b=PGa7+DwAtdM2vSH+L8k9vYDkgtQg6QNz0eG5OtoHV50PEAX3TKZYpCn3JWqlrYYgWY
         TY/HACU0CiL0RDEbaCyPsXZ15LoV3JCc7nttx0XT2zzPJXMIjScnkVxqdpqmLxzA8toV
         O/+R+rCxXfADW6JOqzb9J+p7CC5zZVDnDQtCyVp1VCepQ1lnG3Rr16iMoUiSBBsArtBb
         5Tp3JDV8uUL6KA9JmanGKaCMelBqxr/W2zA5iXgXx97vmOGH/qiS+W+72hjOquRPQ3nB
         SEkMMFx3XykFSmCjmDMZkGOH353dzr2jgfkCnBgV8r3HHHkFSSP5Lc/qtADpmvAJai2R
         15hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP2JvDmySuABtfwwD9Az+JvxcSo3eXa/ptkUqVOO1z5iOtYonVwNzWszRd0SNLOdLKjPb9xEtlXfBzVsEqmaghs6+Z
X-Gm-Message-State: AOJu0YyciyXCBqoe4MzFMGJ7Qn3RUs+VyW4ygMKsqcLbXkzxY+y4bfBD
	I7tE+jhwUuhyeU7pJSAHMOPUStM6A3G6bd4LJY/ykdxsvYP3VZpKjYxrUQ==
X-Google-Smtp-Source: AGHT+IE201ttVYgZcyG2D3k1Vy2ZngvDdVtaBQx71rVja7N8HAXvNtKmfkWyaYbH3Fovx5pjX5yBiQ==
X-Received: by 2002:a05:6e02:178d:b0:371:44f7:b9c0 with SMTP id e9e14a558f8ab-3737b2f8c57mr108095665ab.9.1716764813126;
        Sun, 26 May 2024 16:06:53 -0700 (PDT)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:ea8b:d923:f46f:eef5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6822073f067sm4855338a12.5.2024.05.26.16.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 16:06:52 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mike Rapoport <rppt@kernel.org>
Subject: [Patch bpf] vmalloc: relax is_vmalloc_or_module_addr() check
Date: Sun, 26 May 2024 16:06:48 -0700
Message-Id: <20240526230648.188550-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

After commit 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
CONFIG_BPF_JIT does not depend on CONFIG_MODULES any more and bpf jit
also uses the MODULES_VADDR ~ MODULES_END memory region. But
is_vmalloc_or_module_addr() still checks CONFIG_MODULES, which then
returns false for a bpf jit memory region when CONFIG_MODULES is not
defined. It leads to the following kernel BUG:

[    1.567023] ------------[ cut here ]------------
[    1.567883] kernel BUG at mm/vmalloc.c:745!
[    1.568477] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[    1.569367] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0+ #448
[    1.570247] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[    1.570786] RIP: 0010:vmalloc_to_page+0x48/0x1ec
[    1.570786] Code: 0f 00 00 e8 eb 1a 05 00 b8 37 00 00 00 48 ba fe ff ff ff ff 1f 00 00 4c 03 25 76 49 c6 02 48 c1 e0 28 48 01 e8 48 39 d0 76 02 <0f> 0b 4c 89 e7 e8 bf 1a 05 00 49 8b 04 24 48 a9 9f ff ff ff 0f 84
[    1.570786] RSP: 0018:ffff888007787960 EFLAGS: 00010212
[    1.570786] RAX: 000036ffa0000000 RBX: 0000000000000640 RCX: ffffffff8147e93c
[    1.570786] RDX: 00001ffffffffffe RSI: dffffc0000000000 RDI: ffffffff840e32c8
[    1.570786] RBP: ffffffffa0000000 R08: 0000000000000000 R09: 0000000000000000
[    1.570786] R10: ffff888007787a88 R11: ffffffff8475d8e7 R12: ffffffff83e80ff8
[    1.570786] R13: 0000000000000640 R14: 0000000000000640 R15: 0000000000000640
[    1.570786] FS:  0000000000000000(0000) GS:ffff88806cc00000(0000) knlGS:0000000000000000
[    1.570786] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.570786] CR2: ffff888006a01000 CR3: 0000000003e80000 CR4: 0000000000350ef0
[    1.570786] Call Trace:
[    1.570786]  <TASK>
[    1.570786]  ? __die_body+0x1b/0x58
[    1.570786]  ? die+0x31/0x4b
[    1.570786]  ? do_trap+0x9d/0x138
[    1.570786]  ? vmalloc_to_page+0x48/0x1ec
[    1.570786]  ? do_error_trap+0xcd/0x102
[    1.570786]  ? vmalloc_to_page+0x48/0x1ec
[    1.570786]  ? vmalloc_to_page+0x48/0x1ec
[    1.570786]  ? handle_invalid_op+0x2f/0x38
[    1.570786]  ? vmalloc_to_page+0x48/0x1ec
[    1.570786]  ? exc_invalid_op+0x2b/0x41
[    1.570786]  ? asm_exc_invalid_op+0x16/0x20
[    1.570786]  ? vmalloc_to_page+0x26/0x1ec
[    1.570786]  ? vmalloc_to_page+0x48/0x1ec
[    1.570786]  __text_poke+0xb6/0x458
[    1.570786]  ? __pfx_text_poke_memcpy+0x10/0x10
[    1.570786]  ? __pfx___mutex_lock+0x10/0x10
[    1.570786]  ? __pfx___text_poke+0x10/0x10
[    1.570786]  ? __pfx_get_random_u32+0x10/0x10
[    1.570786]  ? srso_return_thunk+0x5/0x5f
[    1.570786]  text_poke_copy_locked+0x70/0x84
[    1.570786]  text_poke_copy+0x32/0x4f
[    1.570786]  bpf_arch_text_copy+0xf/0x27
[    1.570786]  bpf_jit_binary_pack_finalize+0x26/0x5a
[    1.570786]  bpf_int_jit_compile+0x576/0x8ad
[    1.570786]  ? __pfx_bpf_int_jit_compile+0x10/0x10
[    1.570786]  ? srso_return_thunk+0x5/0x5f
[    1.570786]  ? __kmalloc_node_track_caller+0x2b5/0x2e0
[    1.570786]  bpf_prog_select_runtime+0x7c/0x199
[    1.570786]  bpf_prepare_filter+0x1e9/0x25b
[    1.570786]  ? __pfx_bpf_prepare_filter+0x10/0x10
[    1.570786]  ? srso_return_thunk+0x5/0x5f
[    1.570786]  ? _find_next_bit+0x29/0x7e
[    1.570786]  bpf_prog_create+0xb8/0xe0
[    1.570786]  ptp_classifier_init+0x75/0xa1
[    1.570786]  ? __pfx_ptp_classifier_init+0x10/0x10
[    1.570786]  ? srso_return_thunk+0x5/0x5f
[    1.570786]  ? register_pernet_subsys+0x36/0x42
[    1.570786]  ? srso_return_thunk+0x5/0x5f
[    1.570786]  sock_init+0x99/0xa3
[    1.570786]  ? __pfx_sock_init+0x10/0x10
[    1.570786]  do_one_initcall+0x104/0x2c4
[    1.570786]  ? __pfx_do_one_initcall+0x10/0x10
[    1.570786]  ? parameq+0x25/0x2d
[    1.570786]  ? rcu_is_watching+0x1c/0x3c
[    1.570786]  ? trace_kmalloc+0x81/0xb2
[    1.570786]  ? srso_return_thunk+0x5/0x5f
[    1.570786]  ? __kmalloc+0x29c/0x2c7
[    1.570786]  ? srso_return_thunk+0x5/0x5f
[    1.570786]  do_initcalls+0xf9/0x123
[    1.570786]  kernel_init_freeable+0x24f/0x289
[    1.570786]  ? __pfx_kernel_init+0x10/0x10
[    1.570786]  kernel_init+0x19/0x13a
[    1.570786]  ret_from_fork+0x24/0x41
[    1.570786]  ? __pfx_kernel_init+0x10/0x10
[    1.570786]  ret_from_fork_asm+0x1a/0x30
[    1.570786]  </TASK>
[    1.570819] ---[ end trace 0000000000000000 ]---
[    1.571463] RIP: 0010:vmalloc_to_page+0x48/0x1ec
[    1.572111] Code: 0f 00 00 e8 eb 1a 05 00 b8 37 00 00 00 48 ba fe ff ff ff ff 1f 00 00 4c 03 25 76 49 c6 02 48 c1 e0 28 48 01 e8 48 39 d0 76 02 <0f> 0b 4c 89 e7 e8 bf 1a 05 00 49 8b 04 24 48 a9 9f ff ff ff 0f 84
[    1.574632] RSP: 0018:ffff888007787960 EFLAGS: 00010212
[    1.575129] RAX: 000036ffa0000000 RBX: 0000000000000640 RCX: ffffffff8147e93c
[    1.576097] RDX: 00001ffffffffffe RSI: dffffc0000000000 RDI: ffffffff840e32c8
[    1.577084] RBP: ffffffffa0000000 R08: 0000000000000000 R09: 0000000000000000
[    1.578077] R10: ffff888007787a88 R11: ffffffff8475d8e7 R12: ffffffff83e80ff8
[    1.578810] R13: 0000000000000640 R14: 0000000000000640 R15: 0000000000000640
[    1.579823] FS:  0000000000000000(0000) GS:ffff88806cc00000(0000) knlGS:0000000000000000
[    1.580992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.581869] CR2: ffff888006a01000 CR3: 0000000003e80000 CR4: 0000000000350ef0
[    1.582800] Kernel panic - not syncing: Fatal exception
[    1.583765] ---[ end Kernel panic - not syncing: Fatal exception ]---

Fixes: 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 125427cbdb87..168a5c7c2fdf 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -714,7 +714,7 @@ int is_vmalloc_or_module_addr(const void *x)
 	 * and fall back on vmalloc() if that fails. Others
 	 * just put it in the vmalloc space.
 	 */
-#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
+#if defined(MODULES_VADDR)
 	unsigned long addr = (unsigned long)kasan_reset_tag(x);
 	if (addr >= MODULES_VADDR && addr < MODULES_END)
 		return 1;
-- 
2.34.1


