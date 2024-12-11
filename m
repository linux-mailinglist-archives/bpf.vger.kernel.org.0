Return-Path: <bpf+bounces-46583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6368B9EC1DF
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 03:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D666280DF3
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 02:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F87F19D897;
	Wed, 11 Dec 2024 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9Q2pJ3b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6461F4FA
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882522; cv=none; b=Kdmm6k3Bc7HxAEhiHcxp1mLBtgvE5feppWSLzFw4EevZ1MexkwfEsFkoNZ0Tl+FceV4QHhrbVA17AI5lrgq6jQjRULmn5WTmCKcWBHA8WsPhQSUbFprEv2amH8KETV4Mx0Ikd2GxvSq+CrV0c/W9fojp3Jlxg2P8lin8rcDIAT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882522; c=relaxed/simple;
	bh=OHXl9kFesSiJUnnFWrmVzYTXpWXPnY1unyJZTT7FMzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KyVTLx+Jkn8vXmfOye5AiBQe9d0quFDqNaSbjDN+z+y+RDbZUKQeuc+d/moGGW3A1D/6+buOyz5TJiqVI0WzLVfASqKzLlQv+gDDOOq3pK6TwWZ6s+sqDcxuPbwUUrZsB88G7PNHXA1Av5EsIYMMTNZ5qfMwVapA/DHBxCGj5xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9Q2pJ3b; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43618283d48so7192735e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 18:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733882519; x=1734487319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3sVoBL83SVBqxbXyRf/vd7YsleFJbyHIYiaFUWk7Muk=;
        b=R9Q2pJ3bbu0DXKsnHtRHvCZufB0f4uhYL0ZOamAsuwwXCeB0AqNTmwsgVkx5JjZDE0
         mS4ytFRSmpqHvJoI3QM4mhBU1UEN25AIsXjHFweknK0K/aKSu/kOwAx07gi2g8x0h2LX
         b+fZvO0b7DeWrfbfWTEgi4b18sYTOutIyhhXsIy8d4ChGZt8WMr7KQFFgCJ70w3xP4yF
         JbK5gueDUAZraQ1VLM8L0HovPhce4bIYmJkKw1oJ9+tb+Yr3scxzCBrMvfRhsHUdnkvS
         xGiis532vNGnDUcxAyLcSrGA0XxNgrP3Vq2WoGRy67229VXxShcysQDtlvMvuoSLYn/Z
         NP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733882519; x=1734487319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sVoBL83SVBqxbXyRf/vd7YsleFJbyHIYiaFUWk7Muk=;
        b=pFqyz8mk0GCxxyhi9nPwHt3jozhdKTLou4MsUZ/Be8x/JAs+ywKKYK110GmGNaPonM
         ihgEP/mx/4ultpHmZjBdCT5JrtXF3OQlbCl1eP/VJ+D6Ez3xStxYWrhCDH/aiuh8hrqs
         nL6cE4EKC2JUw2ZAih39ODm/XuP/rF8mmyiRDsi1p8W4I1RyRXrS2uNeC/2+5m/lxABT
         zjaGo7mXNxzxwkYytE/yvXma6lq3o77Cx5XxgxsC+BW/VmiORLhnZDoGZw36wi6louCe
         4ermPXScWdi4Icvvm2UNeXVzb8yTbKiysA12VdlPK7L7C8HOgTHrEE8kckGBbFGvz35q
         m1Sw==
X-Gm-Message-State: AOJu0Yzs/3xoT6za1Z3xB5jWmaK0vquxTinKhrveJRiryCtcte7Km8yX
	yETrB1Gfa6vpitMugwJBP2sok5bmAXy3dKDmFXTwNAOG63p8wukBA4wnvk0C8uU=
X-Gm-Gg: ASbGncvOvs2W2PiXnmYrovtM2mmdfBP1PUIcuw7OOp7fM8E8kgERulEObqM2uaeowfX
	6o833ttz3waKdBLf58RJsGQKK1rNPO8BcKj80m1IwtCh9oFkrgq9Nb25tGf8oLLw1D1e1X9KKZh
	rYRbjH66su19x8irZqj+9tSYyfNnLLiUtn9SSYi6+9y9S97skXjfrYo8tGOgDneLUtQ/cFTUtdP
	ZEZBGtFygrKPG3198xcwGK19ljCmEUf0u26zrNZ5En0/LJBhIEdEJAbJDSDwm08ieEl4avHLV/f
	WxDj
X-Google-Smtp-Source: AGHT+IHkY13d6sm7LQrvqMbapnV/4PPWSEDj09MzE5peFS/kdLj9v6ouAyiKQnG+N6K85FVbnfDy6A==
X-Received: by 2002:a05:600c:468c:b0:434:ff30:a165 with SMTP id 5b1f17b1804b1-4361c366d8dmr5579695e9.8.1733882517949;
        Tue, 10 Dec 2024 18:01:57 -0800 (PST)
Received: from localhost (fwdproxy-cln-006.fbsv.net. [2a03:2880:31ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b14csm249135745e9.2.2024.12.10.18.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 18:01:57 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Manu Bretelle <chantra@meta.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	kernel-team@fb.com
Subject: [PATCH bpf v1 0/4] Explicit raw_tp NULL arguments
Date: Tue, 10 Dec 2024 18:01:52 -0800
Message-ID: <20241211020156.18966-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161; h=from:subject; bh=OHXl9kFesSiJUnnFWrmVzYTXpWXPnY1unyJZTT7FMzA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnWPJVemeZPQ7CMUEvcsUm1MjvtQCOx5wf7756aZoc 0RhLqB2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1jyVQAKCRBM4MiGSL8RytNLD/ 9dqVGais8CSEuuuwwPRgQ4qaRwl44dFqRTmzx/V68CLvB/smwgGCmSGSQUzh8bon08uZEQ4sRROBYB DK3GUZ7E8VQFgawTlFhn+fc+TufFOTWjUpBbrlxuA5eJTyF9D6p2YjIqqttF5WHbUIoaMrdwbaAaAU btnuJc0E8FXaGwPDFLIt9WmTgcHOR7VVkoZ/vYCUECX4usk3YKqPYroNv+Dq7kuYD/+kVeW46oFSVT B+HdA7ZVaiEjkKqRh3hiYY3KCs16HAGi6651fYVoCqJsq1cNC7ocAGO0ZbqLibqqN/vWhnJ00WY0Xe 1nhXZx1bUKGh0NQXEB+m75x8bLUQVeIVrrbrk5TDFTAISJ6y6BNxOWBdRuI0u307K052PxuDRpLHLJ eeylufImx1DeNiLX2sGY+eXFJia6l/DrFVboZFWRGUFeIoFDiR1gVZdgfJKPYoH2pp1mJm7oNdQ6BN nlwNtrktkL9h39wqn3AFa4aeGkv4yM58SqbOIqdbtGOP46RUg6FUqocZHxqHR0yyMdg1qz6JIShmRd Fv3t7EIVAvN5L6uBvIVIxBrTNOa4zgL3Vad7ouyNwGeKiwlQzfAGSleWpjtelN+agd9V8iZ2zguXZt 8n8xaDuvJVrsngs6WU++rPE8y5AzwbcmAMeyXO47HRL+7mRMRDhTXGo02M2w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set reverts the raw_tp masking hack introduced in commit
cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
and replaces it wwith an explicit list of tracepoints and their
arguments which need to be annotated as PTR_MAYBE_NULL. More context
on the fallout caused by the masking fix and subsequent discussions can
be found in [0].

The set begins by reverting the fix and its associated selftest,
then introduces a new method of defining tracepoints with NULL
argument(s), and adds a script to autogenerate tests for all such
tracepoints. For tracepoints that are not available due to missing
CONFIG_ options, the testing is skipped by commenting them out.
However, to expand coverage for different cases, some additional config
options are introduced which do not introduce too many dependencies.

Kumar Kartikeya Dwivedi (4):
  bpf: Revert "bpf: Mark raw_tp arguments with PTR_MAYBE_NULL"
  selftests/bpf: Revert "selftests/bpf: Add tests for raw_tp null
    handling"
  bpf: Augment raw_tp arguments with PTR_MAYBE_NULL
  selftests/bpf: Add autogenerated tests for raw_tp NULL args

 include/linux/bpf.h                           |   6 -
 kernel/bpf/btf.c                              | 134 +++++-
 kernel/bpf/verifier.c                         |  79 +---
 .../bpf/bpf_testmod/bpf_testmod-events.h      |   8 -
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   2 -
 tools/testing/selftests/bpf/config            |   5 +
 .../testing/selftests/bpf/gen_raw_tp_null.py  |  58 +++
 .../testing/selftests/bpf/gen_raw_tp_null.sh  |   3 +
 .../selftests/bpf/prog_tests/raw_tp_null.c    |  19 +-
 .../testing/selftests/bpf/progs/raw_tp_null.c | 431 +++++++++++++++++-
 .../selftests/bpf/progs/raw_tp_scalar.c       |  24 +
 .../bpf/progs/test_tp_btf_nullable.c          |   6 +-
 12 files changed, 639 insertions(+), 136 deletions(-)
 create mode 100755 tools/testing/selftests/bpf/gen_raw_tp_null.py
 create mode 100755 tools/testing/selftests/bpf/gen_raw_tp_null.sh
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_scalar.c


base-commit: 7d0d673627e20cfa3b21a829a896ce03b58a4f1c
-- 
2.43.5


