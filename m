Return-Path: <bpf+bounces-3558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F7673FB75
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 13:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3211C20AC7
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 11:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE0317AAB;
	Tue, 27 Jun 2023 11:54:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5879D6
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 11:53:59 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F30DA;
	Tue, 27 Jun 2023 04:53:58 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-66f5faba829so1815450b3a.3;
        Tue, 27 Jun 2023 04:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687866838; x=1690458838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DC8eCS1n/CqPPownotds85d4i2CHzR+X63I8C5DwGqs=;
        b=J+FA3HqAGy0keXFdKQ+mmKFY6L4ay6ZdVGTdiXlHApv5lt6lO/+cWlqXXp1psvyhpr
         xJMMw0poN4MSd+jKyQg11EErgupFl4NZwRO5anv5tmA8HXsAhN2wnC38DJYTMQgx2hCU
         2k0/e/vNzaJzPU6gt+Xqn+uGZY+KpCbzWzsKPDRuiwmf30VHcaXoSxNEa7g1QZSWrY2E
         fyts9EJPGTanPq7z65rqRnTW3KwoUtvPAm/G3HHz/NuybJQLWa0KEa/SQ6niHxqcsPmR
         Pk1bKNhZO0bMTZY3qDmpo35bFhawth9ZT9mx38ohN6lLspewZOGM3XwcvUPCu/juLjDB
         sx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687866838; x=1690458838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DC8eCS1n/CqPPownotds85d4i2CHzR+X63I8C5DwGqs=;
        b=jn19+qOvbXIasg0Btn6Uwk85obY8NJZWfWgwu2F9urVN9yOSIXYlrmrOgCGl1Nn0QU
         ZzumOj+mhUgTfG1m8/vFRHVzV8RuDt+puya9j+fvNqOF+fuU7NZdisY7Hrs7pCMua2bm
         JM/R1dZb3oAGfidV6sDMPfnMbH2ELpGsgs4IBMYaen8/PPcBfYes8UXqUVX+iUFtq7Aq
         IYQpNogCdYRLYEsxZfM2Daaes3ffsPIexbdV13xMjBZRxR2PQM3nNDN+cjWH0prGlf3/
         HmE/zRdRih5v0IkzMt8x+bMYzECDr5PNa+Shf9KhEylCnlVNlGfNIcDEB/eMviDqKFMi
         qfZA==
X-Gm-Message-State: AC+VfDxK7Bto9e2cKGwK+wK2OuisIEmOKKb+fEOYU5cPJKqgd+WWJAZS
	TnNxv6flJdLrQ9cJ3JapnACFh9Bn1nAcnc0J
X-Google-Smtp-Source: ACHHUZ5Yvs47lFIcE4oAAjTBmSUBTDYvklyepVJLOo2hknr4eWGMXKQ71GQZoMUAm5sTX2fm1aF6CQ==
X-Received: by 2002:a05:6a20:54a7:b0:125:517c:4f18 with SMTP id i39-20020a056a2054a700b00125517c4f18mr14154689pzk.8.1687866837767;
        Tue, 27 Jun 2023 04:53:57 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.112])
        by smtp.gmail.com with ESMTPSA id jg3-20020a17090326c300b001a2104d706fsm4961236plb.225.2023.06.27.04.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:53:57 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: daniel@iogearbox.net,
	yhs@meta.com,
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
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v8 0/3] bpf, x86: allow function arguments up to 12 for TRACING
Date: Tue, 27 Jun 2023 19:53:16 +0800
Message-Id: <20230627115319.13128-1-imagedong@tencent.com>
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
 net/bpf/test_run.c                            |  23 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64  |   2 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  49 +++-
 .../selftests/bpf/prog_tests/fentry_test.c    |  43 ++-
 .../selftests/bpf/prog_tests/fexit_test.c     |  43 ++-
 .../selftests/bpf/prog_tests/modify_return.c  |  20 +-
 .../selftests/bpf/prog_tests/tracing_struct.c |  19 ++
 .../selftests/bpf/progs/fentry_many_args.c    |  39 +++
 .../selftests/bpf/progs/fexit_many_args.c     |  40 +++
 .../selftests/bpf/progs/modify_return.c       |  40 +++
 .../selftests/bpf/progs/tracing_struct.c      |  54 ++++
 12 files changed, 561 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_many_args.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_many_args.c

-- 
2.40.1


