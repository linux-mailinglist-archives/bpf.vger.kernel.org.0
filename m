Return-Path: <bpf+bounces-8071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B92780EBD
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6400128243A
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 15:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2492C18C24;
	Fri, 18 Aug 2023 15:12:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AE518B09
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 15:12:47 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04324210
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:12:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-688787570ccso838165b3a.2
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692371554; x=1692976354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79MlyolaTqKPOhlC+AbGvVgO9CHazBYDlvmZK+Wo254=;
        b=nJpcFQEqVbQP9f2/mKWt/8PXgdO/iTRzCeECYfwQAWYN76KDa1FB0fH3JT7JUGIBa+
         XqkqQL5Z3PZDsMMS6rMs81agqtss0sJbxcaF0Ne2UBIzRmyYnRH9sXh7n5AVS2uNiP89
         J3qkIGAN0GWqMTRUXroWUrXtLrE9vewN1OekCOoNB1YNoHIfKHfKYOHi/nbvGsZsj6wT
         DkMVx9AG+0ofnyUwcqQXRM1NwIsbborqwwpXjhWUamxVsPYwU2INKq3sIkQWr8UUhmn8
         A3TWiLpaBnC29tR4S8b9a54asb1xzDulKPWzmK69iBvAzyYAC1YYR6aiBW8Hh9Q5CxMO
         xcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371554; x=1692976354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79MlyolaTqKPOhlC+AbGvVgO9CHazBYDlvmZK+Wo254=;
        b=DSQT9Uc0ZMbuzAREmyup7fOoa7p2QbJ+QFE1Y+2i2DprAXiCEzvx64KxkRukKgPXl4
         eki5Y440Fo7eC75TALjMcXzJaU22dIK7zWIXuJkqTh5rhehc64bGl5qFzlgThC9VBZ7q
         xaVxEe/Um+4UfKfUbFG6qnmwwtpFf8/Ag/6xZcytwiHxsYH54rhT4Me/J2MIlSzpI4xv
         MkSwCKgfnG6yg6y1hmyvezLOBuVtXTcAw7q9TGvzHvkr/QSgQhRHYIawdm4ngfi31075
         4ZVvAHWUwk0V6Bok+Q/IrZQs1XcdzNC18SOKM8C9/0h8fvd687D8NHSK4cYythiPLiPp
         w56w==
X-Gm-Message-State: AOJu0YzLWiKkjM9+XUHQ1JqHfaBE03wIahiNYW1gROA3cXWTZqtJqdDJ
	Bbt+IKqLYds6zQ4+QRvGkH4Nlkdg9OOheQ==
X-Google-Smtp-Source: AGHT+IGldAnOyhArvn+HTtLcieBZgkRXOhk35D7CFTlljYtebBc+HYd3oobPOwePAkZNo+gq6n+FGQ==
X-Received: by 2002:a05:6a20:96c6:b0:137:a9d7:de12 with SMTP id hq6-20020a056a2096c600b00137a9d7de12mr2734358pzc.59.1692371553837;
        Fri, 18 Aug 2023 08:12:33 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id j19-20020a62b613000000b00686dd062207sm1650967pff.150.2023.08.18.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:12:33 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com
Cc: song@kernel.org,
	hffilwlqm@gmail.com,
	bpf@vger.kernel.org
Subject: [RFC PATCH bpf-next v2 0/2] bpf, x64: Fix tailcall infinite loop
Date: Fri, 18 Aug 2023 23:12:14 +0800
Message-ID: <20230818151216.7686-1-hffilwlqm@gmail.com>
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
and RAX register between BPF subprograms. So do it in trampolines.

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

[1]: https://github.com/Asphaltt/learn-by-example/tree/main/ebpf/tailcall-stackoverflow

Leon Hwang (2):
  bpf, x64: Fix tailcall infinite loop
  selftests/bpf: Add testcases for tailcall infinite loop fixing

 arch/x86/net/bpf_jit_comp.c                   |  40 +++-
 include/linux/bpf.h                           |   5 +
 kernel/bpf/trampoline.c                       |   4 +-
 kernel/bpf/verifier.c                         |  31 ++-
 .../selftests/bpf/prog_tests/tailcalls.c      | 194 +++++++++++++++++-
 .../bpf/progs/tailcall_bpf2bpf_fentry.c       |  18 ++
 .../bpf/progs/tailcall_bpf2bpf_fexit.c        |  18 ++
 7 files changed, 292 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c


base-commit: 9930e4af4b509bcf6f060b09b16884f26102d110
-- 
2.41.0


