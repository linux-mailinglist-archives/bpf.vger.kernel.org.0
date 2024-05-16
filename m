Return-Path: <bpf+bounces-29877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744F58C7ED9
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 01:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B0F282ED5
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 23:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1810B2AF0F;
	Thu, 16 May 2024 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvM+OtXF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2425605
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715900694; cv=none; b=EMcy4Qb6v9Y6BYTE2MZmOnJAAJCMXLZZaUrYB5ZD18yr1Qxy9i7jKe10fv3Ic9H+4OA+e7dvNbUuNbebdIom1X6ziGin10V7Jb0gJa1fndPgC/NYQE0YucwNvxGnTOQg42MZysTjXxE7kefza5Fkjmr4OF7/rFHVI9JyV5A55sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715900694; c=relaxed/simple;
	bh=HYQYsjTf3FhS/bjezOeZYM8+1bXX3wU8nwjCMlEM2gw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dhcYOXBtKieX6NpqZQh5WzVH02sxG2BhXsM3O9DhGqedp7cYWtjnk1d9+S7z9QffmPIHT3Yjb/3+93QpzTZmhnI6+zjAgg0fjz5caZd2W/FEueffblUiHW7EZbMzEOK7D1am/Wr4A/l5FrqCim0llIBvekAi7rQYea7VK5MDmOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvM+OtXF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f472d550cbso712987b3a.1
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 16:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715900692; x=1716505492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=org19vHzhnMnA9qfKvyyqzEHc8ME/KPvw8LCDGiakaY=;
        b=dvM+OtXFfn70lUwBSMvglFJIfO0uYyZU7RuXr8CBVxQnMVcp9ixkjDd2C+wu4Dnkcc
         45MpMEAKugjIx6g7bc9RqGUaFAxza6E7vpcQwcWzgYRB7FjOWnp9J0On/tyEtsTLoaYT
         1FIDZabrGR/5I/wY5paTyL73Xr484nmNieWtTBE8mz4Gf7m1Q7Uw+hubKJ5EvpSKklNS
         6r6BJB1SrQWzVSKsrjV2gd1TmKcC+VAPwINOcCaR7s481lwis8889CLYtgm0V46anlPg
         AgVFssNiH8RoYfnWrVe3fDlOfGQsXwVYMeo2SuUhsJPR7dLn98kSyJ0Z1T46KHl08OXW
         50pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715900692; x=1716505492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=org19vHzhnMnA9qfKvyyqzEHc8ME/KPvw8LCDGiakaY=;
        b=RVlsxc2+v0BMS3bXGg17tnbxaa0gqT4Othkgkhm7a/OAEY6fGc+fvGDUi8ZrDCZgmZ
         P9zMq3VytuiVLGUsMGpzs2TSCubmzwf/TcAzwqlgi6oIgDTgl1sZ2c8syEbmNF3IijhB
         Agq8Spj4gZgxQ+cFKQZtKVYLR1i1oUYqrkuVmaJjmUT9QylHgy4cg6t26ieeFeA8IKIH
         GqNgLdLJHj0S1pofCiIsHZUnXqtXyX7894/OAsywhYxecPtrzx/KOC7Vxo2ZTSp93Fgs
         l4kQPSMcwH3fOf1sRF5jzlcgsE2N4Ye2Lytv+OARH7WLGMS5hBcum8VNzvcDwHC4NP88
         Vs9A==
X-Gm-Message-State: AOJu0YyHG/H9VC+cR+/GhXJAToJ5qLNy+up4DCsMOftBu2PSZ0PmD7nE
	EbiSFnWKHLNn4piVYSGcVdpE7o09eX6gB8UFSFrhAGZ6HfNuRU2+dPCaMA==
X-Google-Smtp-Source: AGHT+IHLexZ+wvdRH2uILCuvXGYSerak7bHC961fNshATuO4zbYrvOS7zlcbXaSXJYKakJ1yWpnAvQ==
X-Received: by 2002:a05:6a21:c92:b0:1af:f939:8553 with SMTP id adf61e73a8af0-1aff93987d5mr16368478637.46.1715900692249;
        Thu, 16 May 2024 16:04:52 -0700 (PDT)
Received: from badger.hitronhub.home ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f67a5ffc54sm3013405b3a.34.2024.05.16.16.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 16:04:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	alan.maguire@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/3] API to access btf_dump emit queue and print single type
Date: Thu, 16 May 2024 16:04:40 -0700
Message-Id: <20240516230443.3436233-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to the following discussion:
https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/

As suggested by Andrii, this series adds several API functions to
allow more flexibility with btf dump:
- a function to add a type and all its dependencies to the emit queue;
- functions to provide access to the emit queue owned by btf_dump object;
- a function to print a given type (skipping any dependencies).

This should allow filtering printed types and also adding
attributes / pre-processor statements to specific types.

There are several ways to add such API:
1. The simplest in terms of code changes is to refactor
   btf_dump_emit_type() to push types and forward declarations
   to the emit queue, instead of printing those directly;
2. More intrusive: refactor btf_dump_emit_type() and
   btf_dump_order_type() to avoid doing topological sorting twice and
   put forward declarations to the emit queue at once.

This series opts for (2) as it seems to simplify library code a bit.
For the sake of discussion, source code for option (1) as available at:
https://github.com/eddyz87/bpf/tree/libbpf-sort-for-dump-api-simple

Also, this series opts for the following new API function:

  int btf_dump__dump_one_type(struct btf_dump *d, __u32 id, bool fwd);

As adding _opts variant of btf_dump__dump_type seems a bit clumsy:

  struct btf_dump_opts {
	size_t sz;
	bool fwd;
	bool skip_dependencies;
	bool skip_last_semi;
  };

  int btf_dump__dump_type_opts(struct btf_dump *d, __u32 id,
			       struct btf_dump_opts *opts);

but maybe community would prefer the later variant.

Eduard Zingerman (3):
  libbpf: put forward declarations to btf_dump->emit_queue
  libbpf: API to access btf_dump emit queue and print single type
  selftests/bpf: tests for btf_dump emit queue API

 tools/lib/bpf/btf.h                           |  33 ++
 tools/lib/bpf/btf_dump.c                      | 363 ++++++++----------
 tools/lib/bpf/libbpf.map                      |   4 +
 .../selftests/bpf/prog_tests/btf_dump.c       |  86 +++++
 4 files changed, 289 insertions(+), 197 deletions(-)

-- 
2.34.1


