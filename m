Return-Path: <bpf+bounces-9156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2095C790CB8
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 17:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD30280F93
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4668A3D79;
	Sun,  3 Sep 2023 15:15:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D1C28ED
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 15:15:33 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A31CED
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 08:14:59 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-565403bda57so139571a12.3
        for <bpf@vger.kernel.org>; Sun, 03 Sep 2023 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693754099; x=1694358899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yy70HFiaWfnz4Brc5xJnZkcb75qpfI3ZQ9kjvXhQ4lM=;
        b=MNpYdOR2fC9S09Osb640vV4nK+xfcSuRPvn/fiIHR8eySowzYLA8h6+mIV+cyTL6dd
         2MFNjc6oEjTN+aNeBrbrM/UsgQBg1YqWnnqZWWfJfBrhoCHXU+dbeb9Iuw7Pi2E+fvCA
         8cXDiujw9yGnKI0wYq/Ik2PNcrZo3W1/rypNjde9wbWvv1Fh74XyXsPXTLNj/5jb3+a/
         fL0Anw6xB31bY//O9YJFIKMZre2zkkRa2c+aLy+AgETbuqb0LpQZX8ROkwHVVjkkz9rz
         evGn8J9FJs1BPxEJcduPRKtkCPF6ezF8ppdcc/bjDtWgKXORDKgJ4gWVIoBWHeC6BZHI
         2/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693754099; x=1694358899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yy70HFiaWfnz4Brc5xJnZkcb75qpfI3ZQ9kjvXhQ4lM=;
        b=Gk441mP+ikhiuLPBOoiDX3E8zLGf7oVV5hP8rRwsXL1tosDsPcaEl4M6cVK5ST3q5Q
         REmP0r9KfRv5unshB7fnkJ02Rkj1DB0mb5t6KzmJraaB9hca/rl/gZlc3X6OUpy+h4KY
         eRSRgcKIOlhqxakeg+UV5/VKpUrkdMyqhLnPplsManHu7CKOMkhxC9w/Ytanyyp4ywcV
         rQdbtXY1RJ6OPjm+LcMWu0jF+EqzAyKgtJkHIqJFC1nqOZ2KOXXY50ijO1Ca2B9848f2
         QVFfOC2PC5ned6emgkeCP4+76DdbEwE3KP1xWgKu//eMS9X0vV13CZt2Neip8l9DOzBu
         z+6Q==
X-Gm-Message-State: AOJu0YxN73FbzNpf43ZXSmP7tZR7v9CvVc1NlLSoX1zyJMVlQ/Eg5J8F
	qiPY5q7gw12wGtr7UGRWq/2fAj7ZVAQ=
X-Google-Smtp-Source: AGHT+IHeNI+sPq7mEVQL/vcsFmnzVXxCmkxPJc0v907n13hqiJwPbES6FW/JSZSXAgy8rT3WgrXnSw==
X-Received: by 2002:a05:6a20:12cb:b0:13d:af0e:4ee5 with SMTP id v11-20020a056a2012cb00b0013daf0e4ee5mr7663063pzg.18.1693754098654;
        Sun, 03 Sep 2023 08:14:58 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-95-136.singnet.com.sg. [116.14.95.136])
        by smtp.gmail.com with ESMTPSA id x17-20020aa784d1000000b00686940bfb77sm5882268pfn.71.2023.09.03.08.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:14:58 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com
Cc: song@kernel.org,
	iii@linux.ibm.com,
	jakub@cloudflare.com,
	hffilwlqm@gmail.com,
	bpf@vger.kernel.org
Subject: [RFC PATCH bpf-next v4 0/4] bpf, x64: Fix tailcall infinite loop
Date: Sun,  3 Sep 2023 23:14:44 +0800
Message-ID: <20230903151448.61696-1-hffilwlqm@gmail.com>
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
	HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
tailcalls running in bpf2bpf and FENTRY/FEXIT tracing on bpf2bpf[1].

At that time, accidently, I made a tailcall loop. And then the loop halted
my VM. Without the loop, the bpf progs would consume over 8KiB stack size.
But the _stack-overflow_ did not halt my VM.

With bpf_printk(), I confirmed that the tailcall count limit did not work
expectedly. Next, read the code and fix it.

Finally, unfortunately, I only fix it on x64 but other arches. As a
result, CI tests failed because this bug hasn't been fixed on s390x.

Some helps on s390x are requested.

v3 -> v4:
  * Suggestions from Maciej:
    * Separate tail_call_cnt initialisation to a single patch.
    * Unnecessary to check subprog.

v2 -> v3:
  * Suggestions from Alexei:
    * Fix comment style.
    * Remove FIXME comment.
    * Remove arch_prepare_bpf_trampoline() function comment update.
    * Remove the unnecessary 'tgt_prog->aux->func[subprog]->is_func' check.

[1]: https://github.com/Asphaltt/learn-by-example/tree/main/ebpf/tailcall-stackoverflow

Leon Hwang (4):
  bpf, x64: Comment tail_call_cnt initialisation
  bpf, x64: Fix tailcall infinite loop
  selftests/bpf: Correct map_fd to data_fd in tailcalls
  selftests/bpf: Add testcases for tailcall infinite loop fixing

 arch/x86/net/bpf_jit_comp.c                   |  32 +-
 include/linux/bpf.h                           |   5 +
 kernel/bpf/trampoline.c                       |   4 +-
 kernel/bpf/verifier.c                         |   3 +
 .../selftests/bpf/prog_tests/tailcalls.c      | 311 +++++++++++++++++-
 .../bpf/progs/tailcall_bpf2bpf_fentry.c       |  18 +
 .../bpf/progs/tailcall_bpf2bpf_fexit.c        |  18 +
 7 files changed, 377 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c


base-commit: 9930e4af4b509bcf6f060b09b16884f26102d110
-- 
2.41.0


