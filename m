Return-Path: <bpf+bounces-61562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF7DAE8C4F
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 20:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1B34A1E0B
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39432DA76D;
	Wed, 25 Jun 2025 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAw44UI4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9382D9EEB
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875868; cv=none; b=oDRyMm178mPuIcX/fQKv4jyWM+DKPkHR1XrGOeS7kax0wMSnhDU9gxcnTgmKlMad3F2Rud767JJ/Fz0ZLTAt2GeX4yrZvGIgNra5cglCbKryim2ZWLXf7ndobxkYogSzv1Def1E+yAOTDFBbcCqmLDtLPuNw0hSAu9ifI+/JFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875868; c=relaxed/simple;
	bh=IwxCZtd5SAodSu7/ZDZJ1FWKPJ4C5A5TKpGwkS6BnEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdSvJ0SD+FMk+MfiE2o8RoTD9gFCCyWNjBx2tsecyMqROswnmWkwEEdhBAJhkpwfuhjPRoBRJ4lJMl8mXEEN/RzsDQhdAwTdisqpmn14u/ALS/6VF3wI2Ox3yXcWBoLsyv6dHryBCOrz167Jfor7Hyo4uVbgKQ1eyl9VBLhFTrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAw44UI4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso371849b3a.0
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 11:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750875866; x=1751480666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p3MgTJCuo7AY/jsRMAqfKyXfMeRrASKvBm3D3vjYrcw=;
        b=XAw44UI4VYZOdiIrw4V65C3ZE7PCCoU/MU3ipT/PacJ0DvvkrJJFXWRO0XtEX9YWC6
         R4LFdpo8kW1elOIbKBNkqZMf3fqFtXPu11/177R1z5qPFynQL4lFppqFiEAPqEGr2MvP
         +Y/ExBM4cHZfdyIG5NZDVga4cTY+KCuwDRzjgJeV8H0R+Di8HJnhmSxfuHh57S4o8i/P
         VdHNZM9fyPNp+m8GPHTrd0lpV8MhUCJg0ci8l3qhLUpjjVvQrD9/FOh/sHR3+hKGRmdz
         gNAtigqJQtLCF+cngT5y9AIywwrj0helalEMqgETfu6nsP4GwNl2CnPa76u0aJXShAxJ
         zx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750875866; x=1751480666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3MgTJCuo7AY/jsRMAqfKyXfMeRrASKvBm3D3vjYrcw=;
        b=MXyPw5D4ohoxDxj7h9ywHIv6W1uE/Jx9DhuWXu8aJxG7fBjCFp4QAwaEH/VECM93vL
         I3RE1IYIhbnikxP1m5d8Za90lKsT6A5libZeBNW7vciwWMB2lyFwgGwyE0tbBM4WEFlF
         37Dqo00RZsV3e+8gx0KMyUSc8b8neewUQ7w2xSxexOKtXRKkObXV93ZTCGZL4AoX5UAz
         B3QniYZZsVTu/Yu3qgQeVKrIqPZjsCb7UmSrgN1GXiDlQOkLLx6KB6EA5uLymBHJI9rM
         OtKzusCNhgu3sfq8OYTgPiiQBccf19fWybZ5Uf5BxiOC6t/n5VN8EFlhxGn5i+X7SSoh
         UsSQ==
X-Gm-Message-State: AOJu0Yyl5xTh085OMo4I3rs0E7BcvnSnWMnD2Dc8TK+AshiWQvY2Tim4
	S7LtT5S6yFoufMutXG/XihCaho0obghKQ1PNJZatTjEw/fUEccuJoK8lBxPWy4BWClA=
X-Gm-Gg: ASbGncsdZF+pw9aRHNq/kfR9St1/wnjOmR0BAvmdOmn0eZehkIeE+IwOkXoH93tklpW
	p85w7IvTgTIPJYUhnef6YARduDCBv9VYS/YQ6ovZZDEyReQRKRo+BUhFzGJKU0LDgSvhnbelOhq
	G2fVYlNkSVORJss6QQyqhcHxyIemW9vllNqn7+2omJ5jbuJDsJpGF35JbtzMwtY7FTQTibc1rnb
	WfULwoUariZ8vBa8QLUo5eQFB2FiT5UjftI5y115jnHK6pTeEryyxVSOBCV/NQgVpPj5AqmGvD9
	JnGZ5BeTaozr8FSDsEKVW+jTSQ6NXp+6c3pyqZXK+611mGT0/NHhjAvsSctnBhCjv148e7Nosls
	VT1r2fTCnWA==
X-Google-Smtp-Source: AGHT+IG66cAc95MDOL5iYhDattAPCifmMi71P3++KcuvR6MQIfI6PI5qqCgVL2At+1EMPWuzXahJxQ==
X-Received: by 2002:a05:6a21:9006:b0:21f:5aa1:3124 with SMTP id adf61e73a8af0-2207f20ac1fmr6166153637.13.1750875865770;
        Wed, 25 Jun 2025 11:24:25 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:1734])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1258b4asm13322939a12.60.2025.06.25.11.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 11:24:25 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v3 0/3] bpf: allow void* cast using bpf_rdonly_cast()
Date: Wed, 25 Jun 2025 11:24:11 -0700
Message-ID: <20250625182414.30659-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, pointers returned by `bpf_rdonly_cast()` have a type of
"pointer to btf id", and only casts to structure types are allowed.
Access to memory pointed to by these pointers is done through
`BPF_PROBE_{MEM,MEMSX}` instructions and does not produce errors on
invalid memory access.

This patch set extends `bpf_rdonly_cast()` to allow casts to an
equivalent of 'void *', effectively replacing
`bpf_probe_read_kernel()` calls in situations where access to
individual bytes or integers is necessary.

The mechanism was suggested and explored by Andrii Nakryiko in [1].

To help with detecting support for this feature, an
`enum bpf_features` is added with intended usage as follows:

  if (bpf_core_enum_value_exists(enum bpf_features,
                                 BPF_FEAT_RDONLY_CAST_TO_VOID))
    ...

[1] https://github.com/anakryiko/linux/tree/bpf-mem-cast

Changelog:

v2: https://lore.kernel.org/bpf/20250625000520.2700423-1-eddyz87@gmail.com/
v2 -> v3:
- dropped direct numbering for __MAX_BPF_FEAT.

v1: https://lore.kernel.org/bpf/20250624191009.902874-1-eddyz87@gmail.com/
v1 -> v2:
- renamed BPF_FEAT_TOTAL to __MAX_BPF_FEAT and moved patch introducing
  bpf_features enum to the start of the series (Alexei);
- dropped patch #3 allowing optout from CAP_SYS_ADMIN drop in
  prog_tests/verifier.c, use a separate runner in prog_tests/*
  instead.

Eduard Zingerman (3):
  bpf: add bpf_features enum
  bpf: allow void* cast using bpf_rdonly_cast()
  selftests/bpf: check operations on untrusted ro pointers to mem

 kernel/bpf/verifier.c                         |  79 ++++++++--
 .../bpf/prog_tests/mem_rdonly_untrusted.c     |   9 ++
 .../bpf/progs/mem_rdonly_untrusted.c          | 136 ++++++++++++++++++
 3 files changed, 212 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mem_rdonly_untrusted.c
 create mode 100644 tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c

-- 
2.47.1


