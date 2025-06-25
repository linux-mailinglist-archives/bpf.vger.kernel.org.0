Return-Path: <bpf+bounces-61468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 706A9AE739A
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 02:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633DB1885DA1
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275A8322A;
	Wed, 25 Jun 2025 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAIUnahD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8177F9
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750809924; cv=none; b=eyKPMQp1FapE9/7HEPoTMm5OuGTbgvuUMJOTkB4omLfYaBW+hsJnLE2kmh4yjF410UrTj0sSkfDwV6kDMK8Q1ED92xHXHMePUSNrrE4oj5LS4+db6cPDkUGk6CRCbA9eQro7Q9PqBjA8UFLRYL1MU6nvwTuHXLkBTpEk3Z7MBLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750809924; c=relaxed/simple;
	bh=+ODLrY6fIJ4CZhBZEzNMjeOoIyGbxhlHWwFDrsgFTlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdQwFIaqp+3sHwk/D3kFOZuccFuqTK4kVCmyUm1if6RM3VTIal9omoPdWD2QLxWWUZwjqRbDwi+kSMyvrtkxtgtVUgq2JLHBYbfd8d6aBn5nlCDyjxKvosfiCQUbY4SE5yGhj0ttxdFpyc49Qbi3rVptTI9XaNeDguw4kdAVznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAIUnahD; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-711d4689084so11279647b3.0
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750809922; x=1751414722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ytLsWD3WW5dCiTMn0NI4+qMgZ5gVwXXI1f12xB8R8Cg=;
        b=NAIUnahDiEiCz22OinPQW5A8xFw4viA3XxNPrG2csH5kSg4K9eSGU03+VyLIVRiaAa
         sTtYrKvSneStiwDiE/aPS5RpFvzZ2DpcXGUtn07YHbr8zw7T4VDS0fE1/BWJguf1NmI1
         0HCMhwqgbyacB5zpEMH7xa6Z50GtyHa5y+rFcR0zOSLqZdu0WbSSIxs7XfSi3ua/tBk9
         QUm4MMDympNdjoLYn5i6QNY+qjA4wxL4enI5yVSD/B7hkcZV/hVZ6LGd9FBDsEqZhxRx
         zkPI2qNowd6To7EjEU8tG8VAh4AmPNAJwpseDfa41bi9gXS/Q2wDlAIRK/YNhieiosAt
         VqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750809922; x=1751414722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytLsWD3WW5dCiTMn0NI4+qMgZ5gVwXXI1f12xB8R8Cg=;
        b=kCaoDA/Tnb3hx/keOZUIKZ/MhXLzjpO2/gAQnfnIEI0qt42OMvxwUX+uOBXNvUFOqM
         cP19CmJ36oaFbBeTmI5234OpZWmFaBSVFTUL79V9gf5d0K7zDEOhdSPO5/dcIG/Jzm7a
         e2dpVasjfHupMn5mYHan9CwKP3KuD8noIJUbsPhbOVZInnyKHR5/xfAjTXVKM75PcATD
         IetG6RjwoYBjIxOzOSNgfL/5aLHA/1B4QSqHJ+QWttNrFdgEULQOy8wi4Vi7RwQJdXqC
         /JWvTRKaJ9obc9G1CfoHu+4KItV3odbG2jyQ/yjk6TIWt5zZk5ywxDFpvTgTBXofH1kF
         zKcA==
X-Gm-Message-State: AOJu0YyJacjNBNhXbNDUgL2kNYsWhCYqaxQEEx/s7Mpg3d9ZJXaLQ67F
	ppiFx2KFHsP6G/sCdA2KojgGFxjHUypJFJvliGrHRsg3LII57d0aQkrB7WSLClCH
X-Gm-Gg: ASbGncsnSPWC50jlMoeoekHFzDgUXMNbGVKNLCqF03scENtznFoGxdcEmdn3qQaSPaK
	+y833jX9bfjP21uP4kIfY3KAglqUiNhpP3XXtaQ0W3eevuQXGdsdh89LtKH6JatjduWgTwCkcz+
	hKZXe1QK1cHsvYAq+JAYXKJL6ch1SMOvC++WUqvWARL+I/yi+OrZphjqbmiUDedFcbpGyfCfV6B
	G2QVHIervtAtV9xSW0nCcBlrSe99rivu0iS2ZRlvMISmd0pGrBwMFd1XN/pTxkIZ8lAMochf1+H
	AqM/UjJ9cikg+4t/Bsk1aVyfKyheIIzi9xFq+K2thVtAEshzCPdK
X-Google-Smtp-Source: AGHT+IEQFet5cmx/A3XjrSIuUoK9YYfY5udg74bVLV34X2MdX5cw+RYSxGmASnBoDdvCgpuaV8+Nvg==
X-Received: by 2002:a05:690c:9692:b0:710:e81b:f7cf with SMTP id 00721157ae682-71406cafb2dmr13979007b3.13.1750809921978;
        Tue, 24 Jun 2025 17:05:21 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c4c25e27sm22270847b3.125.2025.06.24.17.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 17:05:21 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 0/3] bpf: allow void* cast using bpf_rdonly_cast()
Date: Tue, 24 Jun 2025 17:05:17 -0700
Message-ID: <20250625000520.2700423-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
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


