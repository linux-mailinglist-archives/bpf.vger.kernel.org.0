Return-Path: <bpf+bounces-8619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DB2788BF8
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300DD2817CF
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DFFDDD9;
	Fri, 25 Aug 2023 14:52:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E29CA60
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 14:52:31 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EA32119
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 07:52:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc63ef9959so8574745ad.2
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692975149; x=1693579949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/dMEL/eEENa8yeDvWupyh/RWMLTdFGan0OZP6hnhmM=;
        b=dYahkzF5IZO9B1hYaq3FuCUJ22CyA1ctQ/EjumPrEfYScBlqOrMZ04nvu+Mb+04x45
         vgC7SHeSdSZz3HktR/3fTZSnvuNRHwVtxwn+PRbiGZ20COfztomaKpH9lYSWTNT3+FgX
         Oz5pfJeaMMGbeFstDyktKOH5Fa0cW9gCFq2kPOBBeo74j7FoIzvDlAkgAvnwVsPDtGwQ
         /HiGbfZqVa2aVAV3lldExTkH8JM84C4DRKWSJ3SAQ8EFIOWLoXdNFZoeWgiyZL3IMcss
         gVBgFS6aDg35SL1qEYe5WPAnDs+nhtdrF3CuFj+fDPT30OEKP5ho9Bhpb/E/hua5WPCZ
         T5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692975149; x=1693579949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/dMEL/eEENa8yeDvWupyh/RWMLTdFGan0OZP6hnhmM=;
        b=GRQXRrxlu80M2XJd3RXsJyAfOh+un1ytSKCa9t4yABovXcw39SQa9cosa6r2FsPyuB
         kllqVB5fFocLgE+nbH/0vaLCU208rR2ANTYJr7rw7Wy0Niej0krt4Zes924M985O0sCH
         WoHu3jSmVqpUHBq2QfbJsoQbBhyGZdFZ6gnEihFTSMH2Q1YiuMXpKefmMpuYPKQjEpwR
         JwE8zI17PvuI/aiyKr1z1EFwBloPqkSuDrrX68gNDKQkORPjOHCfBs9FwtneObGHkXi9
         7mwD1ivjVVSEBoi5cdxn4vdoyje1z3fNt/Gq+z6KvwbAE5/5hzkEsMytMgiWHXN5voMT
         AGyA==
X-Gm-Message-State: AOJu0Yx+iIXgmXFImUOmjzMaran3B1WuilWZZYPo/TdNheHzI1e9aPfo
	P0hjrZD8FDyHKzw0ewguelR+oG8wTps=
X-Google-Smtp-Source: AGHT+IHXxuC3YuDCz1lGSdGize9KgFcqHr5zzExnGcXXXT5AC7Is5lP80tK6LCSTTA4vwzJTfCMxjg==
X-Received: by 2002:a17:903:44d:b0:1c0:6e92:8cbd with SMTP id iw13-20020a170903044d00b001c06e928cbdmr12811738plb.28.1692975149449;
        Fri, 25 Aug 2023 07:52:29 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id iy4-20020a170903130400b001b016313b1dsm1806638plb.86.2023.08.25.07.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:52:29 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com
Cc: song@kernel.org,
	hffilwlqm@gmail.com,
	bpf@vger.kernel.org
Subject: [RFC PATCH bpf-next v3 0/2] bpf, x64: Fix tailcall infinite loop
Date: Fri, 25 Aug 2023 22:52:14 +0800
Message-ID: <20230825145216.56660-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series fixes a tailcall infinite loop.

From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
handling in JIT"), the tailcall on x64 works better than before.

From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
for x64 JIT"), tailcall is able to run in BPF subprograms on x64.

From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF program
to other BPF programs"), BPF program is able to trace other BPF programs.

How about combining them all together?

1. FENTRY/FEXIT on a BPF subprogram.
2. A tailcall runs in the BPF subprogram.
3. The tailcall calls itself.

As a result, a tailcall infinite loop comes up. And the loop would halt
the machine.

As we know, in tail call context, the tail_call_cnt propagates by stack
and rax register between BPF subprograms. So do it in trampolines.

How did I discover the bug?

From commit 7f6e4312e15a5c37 ("bpf: Limit caller's stack depth 256 for
subprogs with tailcalls"), the total stack size limits to around 8KiB.
Then, I write some bpf progs to validate the stack consuming, that are
tailcalls running in bpf2bpf and FENTRY/FEXIT tracing on bpf2bpf[1].

At that time, accidently, I made a tailcall loop. And then the loop halted
my VM. Without the loop, the bpf progs would consume over 8KiB stack size.
But the _stack-overflow_ did not halt my VM.

With bpf_printk(), I confirmed that the tailcall count limit did not work
expectedly. Next, read the code and fix it.

Finally, unfortunately, I only fix it on x64 but other arches. As a
result, CI tests failed because this bug hasn't been fixed on s390x.

Some helps are requested.

v2 -> v3:
  * Suggestions from Alexei:
    * Fix comment style.
    * Remove FIXME comment.
    * Remove arch_prepare_bpf_trampoline() function comment update.
    * Remove the unnecessary 'tgt_prog->aux->func[subprog]->is_func' check.

[1]: https://github.com/Asphaltt/learn-by-example/tree/main/ebpf/tailcall-stackoverflow

Leon Hwang (2):
  bpf, x64: Fix tailcall infinite loop
  selftests/bpf: Add testcases for tailcall infinite loop fixing

 arch/x86/net/bpf_jit_comp.c                   |  32 ++-
 include/linux/bpf.h                           |   5 +
 kernel/bpf/trampoline.c                       |   4 +-
 kernel/bpf/verifier.c                         |  30 ++-
 .../selftests/bpf/prog_tests/tailcalls.c      | 194 +++++++++++++++++-
 .../bpf/progs/tailcall_bpf2bpf_fentry.c       |  18 ++
 .../bpf/progs/tailcall_bpf2bpf_fexit.c        |  18 ++
 7 files changed, 285 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c


base-commit: 9930e4af4b509bcf6f060b09b16884f26102d110
-- 
2.41.0


