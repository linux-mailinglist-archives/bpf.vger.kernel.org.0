Return-Path: <bpf+bounces-64558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAB2B142EE
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 22:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4C2542B01
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 20:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D36277CAF;
	Mon, 28 Jul 2025 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8k7Y/ym"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCAC86338
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734424; cv=none; b=MjZ0FHy4ozFB9+jIwbn0VTyXPJDxQbSPap/vdAP6Yw9nbZeAq/4BVbIjjF5XrEzaDZpMPEP22UdhGf3sm004qxhFFaPLbRcJcqlhmveEHR0DqBqsURVIAPpxmh5Ma/ecempURKBCvWmJ0sPXFyEN/lKCq2WQdWPv4r47D1pDK58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734424; c=relaxed/simple;
	bh=FOsqsYou5/P32c2XlFx2QdYjhVrB8Cpb7P8V9ps+wxs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eC92RvvTlPcCcCuOrSeAYW4RdHMmxG4LVBKW4jKIWZEN5bjLlg6mSdLLuyecwW765DBo/IA5k6eyRppKil0A8W0hyTlbcCxQCwDjpavHOfo1B1qqkyFEZvyzsD4uRPCR+bqE+6T3AzBdb7BoMFhsShMI6EjqwXVqWuJJkkGfs7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8k7Y/ym; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso8720669b3a.3
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753734422; x=1754339222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6IWZ7aJwNJ0i58XDePtfXg84Zvmb7Xy3RJeSCsk5t9k=;
        b=b8k7Y/ymdaCoKZI84UrRMD3WJppLRqXG5M4lLEXvj69z6prWLTmDuXduV+WGkH+hMi
         bbnD0RJPrCXiB4ZJGTC3dIamWFThBqxjUeW8+/MmrYiOuOb4knTNPPPvM+XIL5HojLOb
         ivEps0ZH7sdkvfUGN/Oq9hK5Jauo2nvPyP/aDlXrY9Q5ap2431Xuv2rX+KPFPwG5PMWT
         JnuJPk7BUkbb4Cj3Q3/DDma5YLffBTo+2aA8M1e1keVUxvQwvpRXeuPTXtJvDc9xbI5M
         MgT5Ss4vrbboLDk6I6mglojFx4uOqdwE26l1Q3l0HIefumZwaiImnlArvT19cRA7nLU6
         Xw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734422; x=1754339222;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6IWZ7aJwNJ0i58XDePtfXg84Zvmb7Xy3RJeSCsk5t9k=;
        b=P6RbUlBxiircIOBKB4SVttcoamMzXZaRdWlcFhGRuF9litgsixFE6gD7HiZNqmpHWt
         JznGzY4N1CUtpWDsUYP2er8Nb2es//m8H+VuFIxcr24HOoV32l3QY/Tpr4J2H/16LNKW
         O0QEG3KB4C3G9RRes+lGRwHqxYakCvzI7jHrCUWoZp3OGDcTkFf0zY6CI7QrhbxQ/E0T
         GQnnzZwmPr2CbYmJijnzsagyUux2eqeub/2p2QfJAV3P9rfbYoSIo7WE6bqJxcAOAfvl
         /hGJex5kS3175b8wWvA2pMnZRBwW0R11jIQsQ9TnQaNpVQ2Ut4e5xxJTOS032z2HicTP
         55Hw==
X-Gm-Message-State: AOJu0YziDtXXCrUguFagqG36+W0mQp6mizYVw7VBZIrhdp8JM3KUilYO
	gl7N/Zi+O2XvECbZkYa2CWj5qKlUDzr9pdaAbiIu+1nIFdYSiuaEn6TMYmn4h0skGRCjF1atAtX
	CrAqRCEw1sl7bJ2wtncwohQ624V9eHwBB/XWynP5rEnIGsv0/cvgnpQRLg/Lg7iP3ll64bWldAZ
	QWBUvYTbQVAMJnCA3p/vPi6zgOo06uEi2Jqm98nWoYsvcKtETfJ0Qh2jMU1iD4TYDA
X-Google-Smtp-Source: AGHT+IGUReHUkUbmR2M4RfqQQuk6vgsVDC00fdDQUCL9Df/N+1gwrxiM/Xclkwmg52vacgmobdKHIGvJ/zhinzrEKwc=
X-Received: from pfbfh25.prod.google.com ([2002:a05:6a00:3919:b0:748:f98a:d97b])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:22ca:b0:74b:4cab:f01d with SMTP id d2e1a72fcca58-76337014813mr19166325b3a.12.1753734422185;
 Mon, 28 Jul 2025 13:27:02 -0700 (PDT)
Date: Mon, 28 Jul 2025 20:26:57 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=samitolvanen@google.com;
 h=from:subject; bh=FOsqsYou5/P32c2XlFx2QdYjhVrB8Cpb7P8V9ps+wxs=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBntdwXFcpofxCg36R+p2u0grPaokVllgr6VzXaT4xYpX
 4P2mrd0lLIwiHExyIopsrR8Xb1193en1FefiyRg5rAygQxh4OIUgIm48jEyPLp9ZtXxtcG7Xinc
 Ou2hckRMMVFHhOHUxN7fj5c8zI7ZF8bwi+nP2yo36x3n86/eut5yWnTDW1mHew7/lk6LTfvA1Xr SlwEA
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728202656.559071-6-samitolvanen@google.com>
Subject: [PATCH bpf-next v3 0/4] Use correct destructor kfunc types
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi folks,

While running BPF self-tests with CONFIG_CFI_CLANG (Clang Control
Flow Integrity) enabled, I ran into a couple of CFI failures
in bpf_obj_free_fields() caused by type mismatches between
the btf_dtor_kfunc_t function pointer type and the registered
destructor functions.

It looks like we can't change the argument type for these
functions to match btf_dtor_kfunc_t because the verifier doesn't
like void pointer arguments for functions used in BPF programs,
so this series fixes the issue by adding stubs with correct types
to use as destructors for each instance of this I found in the
kernel tree.

The last patch changes btf_check_dtor_kfuncs() to enforce the
function type when CFI is enabled, so we don't end up registering
destructors that panic the kernel.

Sami

---
v3:
- Renamed the functions and went back to __bpf_kfunc based
  on review feedback.

v2: https://lore.kernel.org/bpf/20250725214401.1475224-6-samitolvanen@google.com/
- Annotated the stubs with CFI_NOSEAL to fix issues with IBT
  sealing on x86.
- Changed __bpf_kfunc to explicit __used __retain.

v1: https://lore.kernel.org/bpf/20250724223225.1481960-6-samitolvanen@google.com/

---
Sami Tolvanen (4):
  bpf: crypto: Use the correct destructor kfunc type
  bpf: net_sched: Use the correct destructor kfunc type
  selftests/bpf: Use the correct destructor kfunc type
  bpf, btf: Enforce destructor kfunc type with CFI

 kernel/bpf/btf.c                                     | 7 +++++++
 kernel/bpf/crypto.c                                  | 8 +++++++-
 net/sched/bpf_qdisc.c                                | 8 +++++++-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 8 +++++++-
 4 files changed, 28 insertions(+), 3 deletions(-)


base-commit: 5b4c54ac49af7f486806d79e3233fc8a9363961c
-- 
2.50.1.552.g942d659e1b-goog


