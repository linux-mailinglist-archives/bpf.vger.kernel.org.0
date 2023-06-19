Return-Path: <bpf+bounces-2845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBA2735622
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 13:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287C31C209B9
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 11:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6568D532;
	Mon, 19 Jun 2023 11:50:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF88C06
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 11:50:18 +0000 (UTC)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EFCC9;
	Mon, 19 Jun 2023 04:50:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 41be03b00d2f7-54fac329a71so1525268a12.1;
        Mon, 19 Jun 2023 04:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687175416; x=1689767416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64u26Yf13gseox4XSvgxkjMEaJCrfYA5il6c3OKayvc=;
        b=DqB0N1f3nW5gWg5lKR2R4SXptZMKR4VsBaU8Mk/DsDeP20DA9jYOeOUWf1K387neqo
         VUlPRncrrK8V5B5KfkSl5q5BzPr6QrmJEKE8Bse72JjtRRS9a5Trl4GmwBrf/4A0lr8n
         B5as/3eoIizGcKofy+elfHvSRQQkflB2vIlL9EgjRSlb4+Ei6Fm+4+ZIUcweSguN9pd0
         zoOWrj9FozMak+VUSz0sz9Xv/MksRVp4MVn6hwoEXI/1Y9NjlxS/Z9Kra+q6twioFRdZ
         T0e+vxgJSbKUXo5R7/gURT/KRwclaEGiMbEKBM0qCls3GTv/DijDKh6LA2sBGiMgfxVl
         AxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687175416; x=1689767416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64u26Yf13gseox4XSvgxkjMEaJCrfYA5il6c3OKayvc=;
        b=aGuKe5kkgzLKeSJVm9FFwxJ7UcI475s5E+TWeT66by5hdksSTTQf4rxZfZRNfrRQG5
         yMrPXn+8vdTnDkTx37RVoIsJO/Gw52A0X4WoJv1RryZvgH50RcEculq8Y/E5KFXluOAj
         OCs6LBhPDYoVXYoZ36C8rHJ31rVTc/i6+RyMMgSJHxmPyjgrALx4AH+eX8qY/Sch1sdO
         yTXi7zxXACQ/RMwfqkcoOA65qKxGijCymDFsy9c2u450DZceb9Mc/Pf5YsAsaLqTcNHh
         jBEDiUDORngGDmCkJqAR3spH0MJWz71ODpHUPb0Uc9ysNA/mAhDPPvk1EeZ6pwlEo5wH
         Sj2w==
X-Gm-Message-State: AC+VfDxNHC7hfpscrjkcInYW1qwtF4nFRLa0b6/L1pDjRNwf9uadUJOd
	T3lzsri7iAFMhjd5piwJsjg=
X-Google-Smtp-Source: ACHHUZ5A8OdIEqGvX58BuD1kdcWZu0WstUIytLxJuSmGmLkicbiqfpR5O613urudGUlNH9HIJ5NbNg==
X-Received: by 2002:a05:6a21:329e:b0:10e:d90f:35d5 with SMTP id yt30-20020a056a21329e00b0010ed90f35d5mr6610862pzb.51.1687175416381;
        Mon, 19 Jun 2023 04:50:16 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.86])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902694100b001aaf370b1c7sm20287882plt.278.2023.06.19.04.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 04:50:15 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: yhs@meta.com,
	alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	benbjiang@tencent.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v6 0/3] bpf, x86: allow function arguments up to 12 for TRACING
Date: Mon, 19 Jun 2023 19:49:44 +0800
Message-Id: <20230619114947.1543848-1-imagedong@tencent.com>
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
on the kernel functions whose arguments count less than 6. This is not
friendly at all, as too many functions have arguments count more than 6.
According to the current kernel version, below is a statistics of the
function arguments count:

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
arguments can be up to MAX_BPF_FUNC_ARGS for FENTRY and FEXIT. Meanwhile,
we clean the potentian garbage value when we copy the arguments on-stack.

And the 3rd patches are for the testcases of the this series.

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

 arch/x86/net/bpf_jit_comp.c                   | 249 +++++++++++++++---
 net/bpf/test_run.c                            |  23 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  49 +++-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |   4 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |   2 +
 .../selftests/bpf/prog_tests/fexit_test.c     |   2 +
 .../selftests/bpf/prog_tests/modify_return.c  |  20 +-
 .../selftests/bpf/prog_tests/tracing_struct.c |  19 ++
 .../testing/selftests/bpf/progs/fentry_test.c |  32 +++
 .../testing/selftests/bpf/progs/fexit_test.c  |  33 +++
 .../selftests/bpf/progs/modify_return.c       |  40 +++
 .../selftests/bpf/progs/tracing_struct.c      |  48 ++++
 12 files changed, 471 insertions(+), 50 deletions(-)

-- 
2.40.1


