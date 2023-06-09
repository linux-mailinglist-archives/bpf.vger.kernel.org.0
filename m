Return-Path: <bpf+bounces-2218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB89372960C
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 11:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48D028189E
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 09:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D5114295;
	Fri,  9 Jun 2023 09:57:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2959713AE9
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 09:57:21 +0000 (UTC)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354B46A45;
	Fri,  9 Jun 2023 02:57:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 41be03b00d2f7-544c0d768b9so624881a12.0;
        Fri, 09 Jun 2023 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686304622; x=1688896622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oke8FEyU1i0vInWJA3warIdx+aSj1DpDAK4b5OQbzYc=;
        b=gsVCyH+ob/XyG5y9XHqMLjYYC9ihsmBivd32oCTBxUsJsMqSVtacS+R+bPT9GQoQ65
         lLf+Q7QScwo+MhDP+iDrVoVZDg/dIcbS/Xt7CUgkfAf8tIfpjg4Grp/zODcgR7dWKLhA
         Xb6rbPccjDcd7XpTniKuh0trKPSghhlEc6gl1ogB4nf8EhoYFKa/F6vi78eeLGV3X8pv
         z8bp7CHe6Dtj5KGezv9RRt1eWwtvcNrwPD5rxOBCspuOx8CfhFxIhPktiz3Shi58eeYc
         Gaweg+KY1z8Gx4YQmNohFCrdYPixqzMK/Pzz9c9nw3NMohNnJkU8713qU1CP4u/JmtV/
         U75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686304622; x=1688896622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oke8FEyU1i0vInWJA3warIdx+aSj1DpDAK4b5OQbzYc=;
        b=amZlroH9KCV0VrPrkEEtYns7LMXUfgrn6N1ioKdHnwbNx+fO+qFdKP6U5EqqyjUXyA
         V+3qHvBWZ6HXjp4cApH3f2WBq3h3fxmdOXPAS1lp9pHz4jl8G9J8TlDfc1RSs25sJ4H5
         32OeDFBZk+Eiwkm8gM06ZgkWqHysy4P21/waMInP70cZ64w4pBsz9wpbbeisUAdnmBTM
         sq105OnJAWaQle+mFaENtjmv0NoP67mh/DEZG3NDBz/itwNRhSnGvXNkim+Er+YsvKUo
         MQjUitKwiMbxFiQsLsrKeMjz5I8HlVG8H9dmBVAzmR69XnFnKwLKr/v9SzMaqsRqUGxL
         ku8A==
X-Gm-Message-State: AC+VfDxDUquvfJBuKIqcePb+/1d+HudAHpYL1iXWYBm/iOrjwfUz/TBL
	lSzu2yge68+VRN0eeQDcmTQ=
X-Google-Smtp-Source: ACHHUZ7QCm+XPU0jpXw5sGKZfSRT2TqWVUo/oGqCiZgbT/hYu18UPhyCJss3Gct0XveFbDtAYLD9OA==
X-Received: by 2002:a05:6a20:728b:b0:118:ed8a:af45 with SMTP id o11-20020a056a20728b00b00118ed8aaf45mr841972pzk.40.1686304622024;
        Fri, 09 Jun 2023 02:57:02 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.114])
        by smtp.gmail.com with ESMTPSA id 26-20020a63175a000000b0053f3797fc4asm2603369pgx.0.2023.06.09.02.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:57:01 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: andrii.nakryiko@gmail.com,
	alan.maguire@oracle.com
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v4 0/3] bpf, x86: allow function arguments up to 12 for TRACING
Date: Fri,  9 Jun 2023 17:56:50 +0800
Message-Id: <20230609095653.1406173-1-imagedong@tencent.com>
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

In the 1st patch, we make arch_prepare_bpf_trampoline() support to copy
function arguments in stack for x86 arch. Therefore, the maximum
arguments can be up to MAX_BPF_FUNC_ARGS for FENTRY and FEXIT.

In the 2nd patch, we clean garbage value in upper bytes of the trampoline
when we store the arguments from regs or on-stack into stack.

And the 3rd patches are for the testcases of the 1st patch.

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
  bpf, x86: allow function arguments up to 12 for TRACING
  bpf, x86: clean garbage value in the stack of trampoline
  selftests/bpf: add testcase for FENTRY/FEXIT with 6+ arguments

 arch/x86/net/bpf_jit_comp.c                   | 145 ++++++++++++++++--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  19 ++-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |   4 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |   2 +
 .../selftests/bpf/prog_tests/fexit_test.c     |   2 +
 .../testing/selftests/bpf/progs/fentry_test.c |  33 ++++
 .../testing/selftests/bpf/progs/fexit_test.c  |  57 +++++++
 7 files changed, 245 insertions(+), 17 deletions(-)

-- 
2.40.1


