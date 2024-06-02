Return-Path: <bpf+bounces-31143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4648D754F
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 14:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C401F21A77
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 12:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93F839FF4;
	Sun,  2 Jun 2024 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbGdD4rA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0B438DF2
	for <bpf@vger.kernel.org>; Sun,  2 Jun 2024 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717331118; cv=none; b=lGmDxPZPiQxYTTsizhVkvXIaw5OiKxHDpZM6PVwivoBkj8CmP+vN8Q1DX2tgW2o9o5je1TIdO4gDfeCxWCyP/5SSFM6cCZzz15SYNqOEWzMZt/GIpr85kNJ5MyALrGKGjHn3Bpf/ww9m63SyYFBVqxWLWEuXHHkPplLvRAO9bOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717331118; c=relaxed/simple;
	bh=xx8D96BC45E8uU+cjA+on/cqMp6pXHJfssmSwG8AslE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nldHPn3wHwjrEvi2MKNzbFcC5G86FQpmKt1BGuswCSwr9pH6KgH6yIdYrhMythx/G+SalLc6enu7y1kbjLOaarra07I1XKUoAJJNLy4y67oAIezUIv28NRxhW3zdF+yT+0gvC58nKxmycueE+9kbVqy8aIuXKH6DMdpP4bJqp7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbGdD4rA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-702621d8725so541920b3a.0
        for <bpf@vger.kernel.org>; Sun, 02 Jun 2024 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717331115; x=1717935915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq4OdyrFnzEatH/mALSK8870bjUA3Kob6K2HdNXeR4E=;
        b=MbGdD4rAgIl2nUvU8wx+YvIzbdPn0NwSXdKp8LMJX9nenZmnukFkPkSd0Xfq+k1UyV
         z+lzgybaCJGngBkPOE71wLYJyr6Ky6XKQHbHydZf0zAPTacFM/fp866OFIU98pbuxffX
         fZPBOhB2vO7K28PNxKl9VaxOlRMH8c/vYbycFnK+U5dQ6t4w14Yzmn0gIADLnYnFjIea
         0rz+QXGYvG/Z3ZYxEj6AUkHjWAGWoKY6E+qRpUTmuvB1nkbG5szPfhFFXQp6eNeTGNQv
         0sy+QZDy5MPKw4Xxs7KwTMLRuTKdC76fQ0YyZqENBky1oBWfJR4l08rmk4kYuoS4d7UC
         KOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717331115; x=1717935915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qq4OdyrFnzEatH/mALSK8870bjUA3Kob6K2HdNXeR4E=;
        b=Zsi21Px82sX4DMS6HgVUCl8P/GaFZAfrSMgnX+LnCeclmM1JOUt80owL1l/EVJCtf9
         Hia2y7JHjzfQ2vWxKT5tu2kNNhXcwNdcBkaeJk3L+RJcgS7AwQTB6AYYZ+OawCVlpxhO
         dIEm95Ykd9oWwPpaT5mQO/bDQ1a9zkf6+dwMszzx1LV0DDfvrwCarvlDntuhCxLKyAwt
         rr6d2ooP2HykmlvfI9mAoisYPELIVDWqUhkWOvTnCvDBpndRfc7lnF75vwsNh5a/GbYr
         G1hSjhRHrlXc8eVEDIX8FISefM3TujGZannUCBM7Ay4cXw4ZuE+jgwgQw24JQcP6wXUW
         A0+A==
X-Gm-Message-State: AOJu0Yx3ngI5OYr7d2t/0WJGalWgbaAWWSSUa5SOuvZbEr0XJQnbq5Tm
	whObK658vmdWwHeWet6twSIcg3PhN3KqZVaygqi+JaYB9J21MKcoCfNPLg==
X-Google-Smtp-Source: AGHT+IHjrQ0HiCJ0NRnrEcl3vyrARMr25w3zjstGynt6E22ksMHN8H+xAoO7aUs06J/WSyC4CakccQ==
X-Received: by 2002:a05:6a00:4a85:b0:6f0:be31:8577 with SMTP id d2e1a72fcca58-7024789b03dmr5061356b3a.22.1717331114785;
        Sun, 02 Jun 2024 05:25:14 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423dc0ebsm3965332b3a.68.2024.06.02.05.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 05:25:14 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	hffilwlqm@gmail.com
Subject: [RFC PATCH bpf-next 0/2] bpf: Fix updating attached freplace to PROG_ARRAY map
Date: Sun,  2 Jun 2024 20:24:19 +0800
Message-ID: <20240602122421.50892-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I try to run selftests to confirm that I fix the tailcall hierarchy
issue[0], it hits a kernel NULL pointer dereference BUG.

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

It causes by these two commits:

- commit 1c123c567fb1 ("bpf: Resolve fext program type when checking map compatibility")
- commit 3aac1ead5eb6 ("bpf: Move prog->aux->linked_prog and trampoline into bpf_link on attach")

After freplace attachment, 'prog->aux->dst_prog' is set as NULL. Then,
when to update freplace prog to PROG_ARRAY map, 'resolve_prog_type()'
resolves freplace prog type by 'prog->aux->dst_prog->type'. Finally, the
BUG hits.

This patchset resolves freplace prog type by
'prog->aux->saved_dst_prog_type' to avoid the BUG.

However, it does not resolve this issue thoroughly, because the prog type
of freplace prog is not stable as freplace prog can attach to different
types of prog.

So, I raise an RFC PATCH to discuss how to resolve it thoroughly.

Links:
[0] https://lore.kernel.org/bpf/6203dd01-789d-f02c-5293-def4c1b18aef@gmail.com/

Leon Hwang (2):
  bpf: Fix updating attached freplace to PROG_ARRAY map
  selftests/bpf: Add testcase for updating attached freplace prog to
    PROG_ARRAY map

 include/linux/bpf_verifier.h                  |  2 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 82 +++++++++++++++++++
 .../selftests/bpf/progs/tailcall_freplace.c   | 34 ++++++++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  | 21 +++++
 4 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace.c
 create mode 100644 tools/testing/selftests/bpf/progs/tc_bpf2bpf.c


base-commit: c939103fc8ef1df0984b8665f157ff88e51373fe
-- 
2.44.0


