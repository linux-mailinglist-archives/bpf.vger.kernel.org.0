Return-Path: <bpf+bounces-2474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1BC72D779
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 04:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649EB1C20C1A
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 02:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F1E17F9;
	Tue, 13 Jun 2023 02:53:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14297F
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 02:53:07 +0000 (UTC)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE89EE;
	Mon, 12 Jun 2023 19:53:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-665a16cdd97so1321360b3a.3;
        Mon, 12 Jun 2023 19:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686624786; x=1689216786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zU1aUlsiWsl4IlJv9hQedeNTa8fO5CzZWJlrdg0Vjj0=;
        b=Q8Cf9Vbi1aDL8NbhnHwzvWRizdpXWyaQGltBeXKxjvlFU9J4x9suwGZeyBHczYUZ3t
         YSesIXdN6fX9wOrZRc2NbCG/ERlhqF5y3P7Ooo53LCWGZPbS/Bpk3ny2fEDfZyG29VpY
         pEc/iZgPx6iHz+ka61bnMegPR1eq3ASMlokt5umlUK/GhYGmpPJ6ILguId3JGn0IDbMR
         5GMYtbHde+qEgzWN2GH+D3XPKTiqp5jKMIMGc59J2SVIxIMYO/2q6nMpslJpl151XrV4
         fsn2s6PiL+GvW68ZzylQunrEvX7bEx/JorLhxf+1+wXL+v68JvpZ1uDACtk4X5x1OztW
         cDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686624786; x=1689216786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zU1aUlsiWsl4IlJv9hQedeNTa8fO5CzZWJlrdg0Vjj0=;
        b=QqiVeeaoinGop3/nUTQwKwn3kbelFF+KBvdTshIlGD3jMAM4XwBvvvbndhHtNB5bUf
         fXKFUX8XXtercDYG5qGKy8upYP/KcJvrFOjJicCQ3nzW/zfF+RK9LcY6RLc7MyCIQIEv
         gly2Js97LZfcUALBu2BLWITGEnG2CqBCeTgiXeuM80SJnhWli2q7XOsCrDqMvT+X74e9
         dttnlu6aYJI6UkFarGhbgQdI/oQ4MVT8+a4ST3L3lly9fF1fZBb6kqidI322bNbexxWR
         WHZz1WviFZgtYS0U9zmPclwH8xPYRxvW0D1dVJq9Zy0o2seMb0g42fFVpAEh5iJm4yeP
         n05A==
X-Gm-Message-State: AC+VfDz5K7xtzDcPQjILwhuu6qbxbu+wo3mB1G01t+RmffeMUGZ6yTx7
	D6x1Ig+zEf0OKOUK0oV3FS0=
X-Google-Smtp-Source: ACHHUZ4zidIJjxVF/YXPHR+9qFCmk26mh453EjtCOTsKM3qzTFmSIFN38UTMQpxO9V4Lq1gjkkEciA==
X-Received: by 2002:a05:6a00:218c:b0:65b:38b2:8d4b with SMTP id h12-20020a056a00218c00b0065b38b28d4bmr13788265pfi.29.1686624785671;
        Mon, 12 Jun 2023 19:53:05 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.85])
        by smtp.gmail.com with ESMTPSA id v65-20020a632f44000000b00543e9e17207sm8240207pgv.30.2023.06.12.19.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 19:53:04 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 0/3] bpf, x86: allow function arguments up to 12 for TRACING
Date: Tue, 13 Jun 2023 10:52:23 +0800
Message-Id: <20230613025226.3167956-1-imagedong@tencent.com>
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

In the 1st patch, we clean garbage value in upper bytes of the trampoline
when we store the arguments from regs into stack.

In the 2nd patch, we make arch_prepare_bpf_trampoline() support to copy
function arguments in stack for x86 arch. Therefore, the maximum
arguments can be up to MAX_BPF_FUNC_ARGS for FENTRY and FEXIT. Meanwhile,
we clean the potentian garbage value when we copy the arguments on-stack.

And the 3rd patches are for the testcases of the this series.

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
  bpf, x86: clean garbage values when store args from regs into stack
  bpf, x86: allow function arguments up to 12 for TRACING
  selftests/bpf: add testcase for TRACING with 6+ arguments

 arch/x86/net/bpf_jit_comp.c                   | 232 ++++++++++++++----
 net/bpf/test_run.c                            |  23 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  45 +++-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |   4 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |   2 +
 .../selftests/bpf/prog_tests/fexit_test.c     |   2 +
 .../selftests/bpf/prog_tests/modify_return.c  |  20 +-
 .../testing/selftests/bpf/progs/fentry_test.c |  52 ++++
 .../testing/selftests/bpf/progs/fexit_test.c  |  54 ++++
 .../selftests/bpf/progs/modify_return.c       |  40 +++
 10 files changed, 424 insertions(+), 50 deletions(-)

-- 
2.40.1


