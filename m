Return-Path: <bpf+bounces-4913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE114751728
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 06:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693D5281A3A
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B2B5254;
	Thu, 13 Jul 2023 04:08:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD3A468C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 04:08:46 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166241FFD;
	Wed, 12 Jul 2023 21:08:45 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-666e3b15370so192113b3a.0;
        Wed, 12 Jul 2023 21:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689221324; x=1691813324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TEwq2+q6JfV3n+3skv2W0fszZRn1aic7BmEleaUX5Kc=;
        b=nNdyIXRuVkdtNEzIvkMJtTHSa6vpvQ/sTY/wCj2NMRWBwH2Fgp/OuUYYWCH684LDPb
         ySrMpM4gk6l6YTrkm+caTpOniU+xQLqgkguxAW50cNJjITRg9VE+yuijAoT3Yu9pA79N
         WU107GHPlyZ/DatTrght5v1IQ+jnhMUAGR4TJjZ12nkPYYALBinp41CtJjdL9iPjdapg
         qBA4kXnnW/hsH+4b4yUgcw1n/yQmOFDX/3HntIQ+1OlcXBgeueNG8aiEzSXCcuVTTYXw
         EGk8GFG9twio4lO2xYMFg1j80O0fXgd6C6fe84OyNwJppPunRoASzReGFCmYZginXJ5y
         qRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689221324; x=1691813324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEwq2+q6JfV3n+3skv2W0fszZRn1aic7BmEleaUX5Kc=;
        b=dhOWm2l2RWMuJUSWJi8Wj+AnGfbyy5LMdfGeUdsyHOgsaOzOmUkIiZLn0N4xQBDquT
         T+ZYAj4duCeP2Ept3sfwTi/BvMhloYtmt9ogEgw1GO7kRrG7zfMlQzrNC6c+sDTqWQAc
         XjU8DKUfv0z836MbO1+dVj7oTHYlFFQ3PW8k3MkMRPE2ZWNXaTfezeFRlXFvmN+gv9ho
         nqrPhRxIdM4OyKhAXLh0Sgf+TP3v4WVfjLTooQxWjkdrsX0UDr0yuzYhzoi32SRwLFXL
         FSqUD4s0CF/MijF5RH3sTee1Y8/pOV33yK04mfMZD7i7lIvummOrlV0zqbmRtQQ1yQN+
         ajxw==
X-Gm-Message-State: ABy/qLZ3G/+9OzLBOnoF/k+V4PaKSoGObug11ySNyxWd3uFULBwMmlk8
	0w80X1hnY9gMlmEmb6i3R1iTZDq6iFuMFFWP
X-Google-Smtp-Source: APBJJlEY120b734X5cPoDPB8G/pM26FDSWMSFId7fSoN6Yds/YcWb238LnW8kFYGhoM1BpAkdhHdpQ==
X-Received: by 2002:a05:6a20:144d:b0:125:f3d8:e65b with SMTP id a13-20020a056a20144d00b00125f3d8e65bmr145540pzi.18.1689221324400;
        Wed, 12 Jul 2023 21:08:44 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.100])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001bb04755212sm483217plg.228.2023.07.12.21.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 21:08:43 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: yhs@meta.com,
	daniel@iogearbox.net,
	alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	dsahern@kernel.org,
	jolsa@kernel.org,
	x86@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v10 0/3] bpf, x86: allow function arguments up to 12 for TRACING
Date: Thu, 13 Jul 2023 12:07:35 +0800
Message-Id: <20230713040738.1789742-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Menglong Dong <imagedong@tencent.com>

For now, the BPF program of type BPF_PROG_TYPE_TRACING can only be used
on the kernel functions whose arguments count less than or equal to 6, if
not considering '> 8 bytes' struct argument. This is not friendly at all,
as too many functions have arguments count more than 6. According to the
current kernel version, below is a statistics of the function arguments
count:

argument count | function count
7              | 704
8              | 270
9              | 84
10             | 47
11             | 47
12             | 27
13             | 22
14             | 5
15             | 0
16             | 1

Therefore, let's enhance it by increasing the function arguments count
allowed in arch_prepare_bpf_trampoline(), for now, only x86_64.

In the 1st patch, we save/restore regs with BPF_DW size to make the code
in save_regs()/restore_regs() simpler.

In the 2nd patch, we make arch_prepare_bpf_trampoline() support to copy
function arguments in stack for x86 arch. Therefore, the maximum
arguments can be up to MAX_BPF_FUNC_ARGS for FENTRY, FEXIT and
MODIFY_RETURN. Meanwhile, we clean the potential garbage value when we
copy the arguments on-stack.

And the 3rd patch is for the testcases of the this series.

Changes since v9:
- fix the failed test cases of trampoline_count and get_func_args_test
  in the 3rd patch

Changes since v8:
- change the way to test fmod_ret in the 3rd patch

Changes since v7:
- split the testcases, and add fentry_many_args/fexit_many_args to
  DENYLIST.aarch64 in 3rd patch

Changes since v6:
- somit nits from commit message and comment in the 1st patch
- remove the inline in get_nr_regs() in the 1st patch
- rename some function and various in the 1st patch

Changes since v5:
- adjust the commit log of the 1st patch, avoiding confusing people that
  bugs exist in current code
- introduce get_nr_regs() to get the space that used to pass args on
  stack correct in the 2nd patch
- add testcases to tracing_struct.c instead of fentry_test.c and
  fexit_test.c

Changes since v4:
- consider the case of the struct in arguments can't be hold by regs
- add comment for some code
- add testcases for MODIFY_RETURN
- rebase to the latest

Changes since v3:
- try make the stack pointer 16-byte aligned. Not sure if I'm right :)
- introduce clean_garbage() to clean the grabage when argument count is 7
- use different data type in bpf_testmod_fentry_test{7,12}
- add testcase for grabage values in ctx

Changes since v2:
- keep MAX_BPF_FUNC_ARGS still
- clean garbage value in upper bytes in the 2nd patch
- move bpf_fentry_test{7,12} to bpf_testmod.c and rename them to
  bpf_testmod_fentry_test{7,12} meanwhile in the 3rd patch

Changes since v1:
- change the maximun function arguments to 14 from 12
- add testcases (Jiri Olsa)
- instead EMIT4 with EMIT3_off32 for "lea" to prevent overflow

Menglong Dong (3):
  bpf, x86: save/restore regs with BPF_DW size
  bpf, x86: allow function arguments up to 12 for TRACING
  selftests/bpf: add testcase for TRACING with 6+ arguments

 arch/x86/net/bpf_jit_comp.c                   | 246 +++++++++++++++---
 net/bpf/test_run.c                            |  14 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   2 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  49 +++-
 .../selftests/bpf/prog_tests/fentry_test.c    |  43 ++-
 .../selftests/bpf/prog_tests/fexit_test.c     |  43 ++-
 .../bpf/prog_tests/get_func_args_test.c       |   4 +-
 .../selftests/bpf/prog_tests/modify_return.c  |  10 +-
 .../selftests/bpf/prog_tests/tracing_struct.c |  19 ++
 .../bpf/prog_tests/trampoline_count.c         |   4 +-
 .../selftests/bpf/progs/fentry_many_args.c    |  39 +++
 .../selftests/bpf/progs/fexit_many_args.c     |  40 +++
 .../selftests/bpf/progs/modify_return.c       |  40 +++
 .../selftests/bpf/progs/tracing_struct.c      |  54 ++++
 14 files changed, 548 insertions(+), 59 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_many_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_many_args.c

-- 
2.40.1


