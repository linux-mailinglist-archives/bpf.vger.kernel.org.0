Return-Path: <bpf+bounces-4590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5E774D3DE
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 12:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C5C280FA7
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 10:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6D1C8C7;
	Mon, 10 Jul 2023 10:51:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FC7566F
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 10:51:40 +0000 (UTC)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D98C3;
	Mon, 10 Jul 2023 03:51:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 41be03b00d2f7-557790487feso3171939a12.0;
        Mon, 10 Jul 2023 03:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688986298; x=1691578298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DC8eCS1n/CqPPownotds85d4i2CHzR+X63I8C5DwGqs=;
        b=GnFD53InakGR6Pn3SQgvzDpJqJWKzJL2+IP75us6N4xoHFDkQd93ZGa4jD6xbF1aSB
         SpEMxK6EJT05dMmCixn4QnxlG6maIZe9uQh5cNngktSY2BJGmZgtJhsfCoewhKuObfRh
         pXMiLLWfIa8EygBZXpXHmdTLwbhqtNN0rQ6oGlzKP3dljyn1m1H/CBboSwFbIUzo/JOI
         3ZktFEihr0IjUcDXqdZqhCtFRFIUGd7Ti8MJBaIKAyogyKyMfHPsRs1r6MnUUh8ohM2c
         NeBLkgvZFmV8TNBG/gvTeTY/Gpe99oSYhB5GWZarvW3LO/IkDJjQ47lnRMnqnQ878nz4
         Xsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688986298; x=1691578298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DC8eCS1n/CqPPownotds85d4i2CHzR+X63I8C5DwGqs=;
        b=jcZJ//RylwB4e1l1/zCT5JbVZwdU12TLGM/7vsjl4KEKT9DSZVBc2qcakpCiH0txT8
         0LvHR1F1xH69VW/CIOnsqw0QcgOmOJhBnScy5BawD1u7c0kSRnipm4y4RR0p2gfAIByJ
         4c5g5WXZROpjuD6swnAx+3YZlnwt+UWGuogZtabH8JxxsGdRc/cIGW8ET8taoEscD9wn
         dOymqd/3iaB+dK//fhUwW7cdocWlxufOlv/m4EtbBSd9DCs1cbm0PNIXq4MBzkPMAa+j
         K4CBBhcKLLeVaELr9YDObF2n9UBqVS4XJXk7v/Q+ZXgoFz6OI716HAfwNF4VRhhF79TR
         joqA==
X-Gm-Message-State: ABy/qLY2UloNk1FG/6YPkPcOqcu+lmDRL4/9TFN1vMIH6AhlP48TsRKd
	ZFGpHSbBBZBHvrsAqOHVvWI=
X-Google-Smtp-Source: APBJJlEpdeavj75MSx73fyvdyMKN+CamSicuPBDXSgERGBQEZUGtEMLQy/e9a8Lnl/i4idmIuocSWA==
X-Received: by 2002:a17:90a:46ce:b0:262:e6d2:2d6 with SMTP id x14-20020a17090a46ce00b00262e6d202d6mr13367239pjg.47.1688986297868;
        Mon, 10 Jul 2023 03:51:37 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.106])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a191100b00263eb5054ebsm6475036pjg.27.2023.07.10.03.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 03:51:37 -0700 (PDT)
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
Subject: [PATCH RESEND bpf-next v8 0/3] bpf, x86: allow function arguments up to 12 for TRACING
Date: Mon, 10 Jul 2023 18:48:31 +0800
Message-Id: <20230710104834.947884-1-imagedong@tencent.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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


