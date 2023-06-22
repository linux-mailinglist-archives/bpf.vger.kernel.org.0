Return-Path: <bpf+bounces-3114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECF47398AC
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 09:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFF828183B
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 07:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A33111CBD;
	Thu, 22 Jun 2023 07:57:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C563A4
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 07:57:34 +0000 (UTC)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D75119AB;
	Thu, 22 Jun 2023 00:57:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-54fac3b7725so3214140a12.3;
        Thu, 22 Jun 2023 00:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687420653; x=1690012653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSrox6nZu5QisyWxc0yjYaiViKB1+/tnFUYJAfTfoEM=;
        b=gBESjUDwZc68KmBsSEzmnm1I19QdU3P6QZDbfADNgX+GCuAMFXA0VnAD9fgHZXn5OH
         Vtx1bWsoTrOXvZ5J2qw35/yCtII+l95zIeP7WvwHvZgEcdgiS7OOkNDKb9vZZWb4vWh/
         eGMNHvbuK/3Z6mvB7SQitqMkMB1rvJoMrWi1gH75a9DxeuF0/yig4Hzv+a0Qb3+CpqDA
         XvzauPe2Dj7HWzMYHixSBqlwatfPF/gHY2TltYzn0YcC26Y6z5+tGKFdTYz4Ok+LUdDM
         xhcKyTBzQTCYLEExdcaeE1Jppk4FUncbfrNQsiU5VPDjVPeqOTww0yfP++kHMyoB2pIu
         /pDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687420653; x=1690012653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSrox6nZu5QisyWxc0yjYaiViKB1+/tnFUYJAfTfoEM=;
        b=hQqUFSVm4/E0D2KYwo+r0Q07YPZpX1b0lvb1fA0aysfEhROEAO8eawjmYfX8pEU63d
         Xtbss4zerjjW8QlnWe+hKJBtSFeE8jhiLT1Q1yIZOOavT8inAYZuDkpjmfnsNATRfn5F
         1IpyVtfzhxQHbXqr4omMwt26SKtOx4Ols3rFhgfAPh2h4oA5xqvkbwTShZJG/weE/Idd
         5Gbu0zrjp5ex5ZWRDXzrkDjVrGxuv0qtre8vWrc8oL8o/oqTctedAabW6JePoSeQLJP1
         9rQIYPN2JoJsEaI/hH1A0oYGUn838l3X4Hs6Zvn+vMAzbQiBjEOzJFgrVrkb00MT3Jus
         TuZQ==
X-Gm-Message-State: AC+VfDyjsYJx0UuNXyv76exmEPhL5hlNsu/pVTmK1BiL+gD7ZSsjCmKT
	KEitOVhzYC3cpoUzjOVymrg=
X-Google-Smtp-Source: ACHHUZ4YlN5Zn3b8QblLLYKVAAHkJuqTHvNhxz3lwfTRHrGWrK5D2+ZlIHoNPbm12tJOFHoDUAbpCg==
X-Received: by 2002:a05:6a20:4fa3:b0:11d:2b0c:7f49 with SMTP id gh35-20020a056a204fa300b0011d2b0c7f49mr13471857pzb.36.1687420652704;
        Thu, 22 Jun 2023 00:57:32 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.82])
        by smtp.gmail.com with ESMTPSA id iz3-20020a170902ef8300b001b3e84240b4sm4733338plb.67.2023.06.22.00.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:57:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 0/3] bpf, x86: allow function arguments up to 12 for TRACING
Date: Thu, 22 Jun 2023 15:57:12 +0800
Message-Id: <20230622075715.1818144-1-imagedong@tencent.com>
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
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  49 +++-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |   4 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |   2 +
 .../selftests/bpf/prog_tests/fexit_test.c     |   2 +
 .../selftests/bpf/prog_tests/modify_return.c  |  20 +-
 .../selftests/bpf/prog_tests/tracing_struct.c |  19 ++
 .../testing/selftests/bpf/progs/fentry_test.c |  32 +++
 .../testing/selftests/bpf/progs/fexit_test.c  |  33 +++
 .../selftests/bpf/progs/modify_return.c       |  40 +++
 .../selftests/bpf/progs/tracing_struct.c      |  54 ++++
 12 files changed, 474 insertions(+), 50 deletions(-)

-- 
2.40.1


