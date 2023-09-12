Return-Path: <bpf+bounces-9760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D7179D445
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 17:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FD8281E16
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACDA18B15;
	Tue, 12 Sep 2023 15:04:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DCA952
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 15:04:54 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C11A1BB
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 08:04:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bf1935f6c2so39879605ad.1
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 08:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694531093; x=1695135893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yq4GfhVF0M63+GEVlLPeqClx+SoD4fGbNhlSG64lDE=;
        b=WaZGBR646wfUFQnejWFYktjwwnl04BZTLLK2WPGnpVwJOkTVdSHZLL80U3iVjLGLRT
         0tuPIDKqkZ2/99zpUPsI87BZSY5uKzCCt6E+1JqO/JBJvwF9Y/sgHUGy1eiRbrJNLu6r
         xq5/WgHqkSrxBB61ZQHL8Pcj0vrTi8huNphN7pDcETA7qx+4hJb7uWhzxEEt7j5I1iHi
         SQ9BPSIDdBYZ+cFRe6hT1xWFRw0s4ycBZn+gFSslj1KsPRwzFpQXA1OrIi8sbi4dXUrv
         zpRdeHV91MsAbcCRXWYwzSav55pOHIUDLXpBZgXuO4EjJwDtVQerhBn+n5GhqPJ0+eps
         +Iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694531093; x=1695135893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yq4GfhVF0M63+GEVlLPeqClx+SoD4fGbNhlSG64lDE=;
        b=X8hKSzB1wfK5vjjM0gJHFW60POylQOECV3NuCWwdZgGf8i+J9/UZ2X1FiqVEz7qR8g
         qpTxaYpiqpCTXevOlY/EEhJzqbpvt1RIe4+nDSLPLFmsVqMea8P4H2ZSJvWDU6Ne+08F
         lfdf2la878j4VvvZI/BbXtQ1TTwZ3FY88CdDYCs2aiIldOYkWV86m/GbfqgJSDLra2b9
         KQmiXSV57NiyOuVSCzfnzlMBwVG8PSp7CgiyehPUPX/NXQOwfw0vwdfHwrBpBfUbmnm9
         yWrbtYJEv0cmrQvO7SyGA8hO3nC3XDjap7rgZ68hUzYMGyi7vnBfiTu+EBN2bkS8xpSG
         eJ7w==
X-Gm-Message-State: AOJu0YwlDRQlPhYOaEKDimtnRAXlh1prvA7/l92SG6/mMlXOE1K+wGtx
	HHcig4wgA99qUZMBwjDCXEJ5wmisBWE=
X-Google-Smtp-Source: AGHT+IF0SX/glO+It+tuekONeaBWLzx70ExncFa390mZ4Sfx6nDGzbf7aF8iGJh0ifaoiQuV4dp93w==
X-Received: by 2002:a17:902:e748:b0:1bb:8cb6:3f99 with SMTP id p8-20020a170902e74800b001bb8cb63f99mr3731544plf.14.1694531093163;
        Tue, 12 Sep 2023 08:04:53 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b001b8b26fa6c1sm8526941pli.115.2023.09.12.08.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 08:04:52 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	song@kernel.org,
	iii@linux.ibm.com,
	xukuohai@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 0/3] bpf, x64: Fix tailcall infinite loop
Date: Tue, 12 Sep 2023 23:04:39 +0800
Message-ID: <20230912150442.2009-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes a tailcall infinite loop on x64.

From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
handling in JIT"), the tailcall on x64 works better than before.

From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
for x64 JIT"), tailcall is able to run in BPF subprograms on x64.

From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF program
to other BPF programs"), BPF program is able to trace other BPF programs.

How about combining them all together?

1. FENTRY/FEXIT on a BPF subprogram.
2. A tailcall runs in the BPF subprogram.
3. The tailcall calls the subprogram's caller.

As a result, a tailcall infinite loop comes up. And the loop would halt
the machine.

As we know, in tail call context, the tail_call_cnt propagates by stack
and rax register between BPF subprograms. So do in trampolines.

How did I discover the bug?

From commit 7f6e4312e15a5c37 ("bpf: Limit caller's stack depth 256 for
subprogs with tailcalls"), the total stack size limits to around 8KiB.
Then, I write some bpf progs to validate the stack consuming, that are
tailcalls running in bpf2bpf and FENTRY/FEXIT tracing on bpf2bpf.

At that time, accidently, I made a tailcall loop. And then the loop halted
my VM. Without the loop, the bpf progs would consume over 8KiB stack size.
But the _stack-overflow_ did not halt my VM.

With bpf_printk(), I confirmed that the tailcall count limit did not work
expectedly. Next, read the code and fix it.

Thank Ilya Leoshkevich, this bug on s390x has been fixed.

Hopefully, this bug on arm64 will be fixed in near future.

Leon Hwang (3):
  bpf, x64: Comment tail_call_cnt initialisation
  bpf, x64: Fix tailcall infinite loop
  selftests/bpf: Add testcases for tailcall infinite loop fixing

 arch/x86/net/bpf_jit_comp.c                   |  32 ++-
 include/linux/bpf.h                           |   5 +
 kernel/bpf/trampoline.c                       |   4 +-
 kernel/bpf/verifier.c                         |   3 +
 .../selftests/bpf/prog_tests/tailcalls.c      | 237 +++++++++++++++++-
 .../bpf/progs/tailcall_bpf2bpf_fentry.c       |  18 ++
 .../bpf/progs/tailcall_bpf2bpf_fexit.c        |  18 ++
 7 files changed, 305 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c


base-commit: 58ad9404c00a9fc4d68896fcadd40f423ccad25d
-- 
2.41.0


