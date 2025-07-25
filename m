Return-Path: <bpf+bounces-64414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7C7B12631
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 23:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02610AA72C2
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 21:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A422A258CE8;
	Fri, 25 Jul 2025 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvxfWT7m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5736254AEC
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753479861; cv=none; b=YXaBhYFN2U4NvsFxvCDFdy8qEsYwYlZ4JtPlpX7NEgklzq/vuRz0PyPYEyVtfN/EYU+0hV1bAtve0YrVnJg76kVvpzOaxyMwIvZUwSQe1b5Jsjofm2V8fK3ZgnWDGxTfcDuNI36HUL50pggi5MowpLi+BBcitWE88j+T/H4Ix2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753479861; c=relaxed/simple;
	bh=bUkj5xSp80OkF0SzfWqXezoXWmIJiBEemdW6yxCyQ8U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cZDgag6nJhjG6pcS1vMSEX7CIacey0mL50Ep6GYx0RThUf5XEu8tD9grpDf9b4UQHn37J8+UQFgiIKuiDeCCOkOFz6vLmb4PrV1+6iMemygmvP+gZnjdD8oN0T8F0psI4WkaqpzVTs755olkzkIOANyr1pY7lNneR16KzlXk9J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvxfWT7m; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74928291bc3so2422360b3a.0
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753479857; x=1754084657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3+PZlLRGqHNoXRhoksTGR7fQVcc2exxerOsCnlgIDHE=;
        b=rvxfWT7mdZSZuqRPl53uJgdlMOsOq7P5UiaqgWkcdhaVRUPjYx03hRwtZSxMPsIcLk
         oEJDXSgL9wT8WhcdvPEAmXeXCccbXhoTIY62nErGYkRX2oKFzaC2nlzZPsm+xTp9eVVt
         t8igYZjFe+HpMAVkYOYGQ0NWF+tMlbRu733lz44+rv0IgoI2oUpuEpU/Ipojc0hhSi5x
         gWMdT3z82+P37tZRMLKkG8mgj1KTE/TJJwUjDII4ju3rSulZGOvxx356T6yVIvctk6vY
         Ha4eqqu+Dx7Nsf7HD1hn6GfnUo60ok7aI8aQXjNFfpXmk9Gs6IRFomO/wwDckPRCUPvi
         bjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753479857; x=1754084657;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+PZlLRGqHNoXRhoksTGR7fQVcc2exxerOsCnlgIDHE=;
        b=UhetNhJ69/6mNLmJcDsfcbWc/1UN2F4yfboQIhTa4rCh86dkSB7d+KedZDPvRokQ+z
         3wKEmfw6cvKuKnCGO5yfNa0wMGVbmXEZMcW2gcWEM/iS3DDuSGUs3etuyr5toC7W7mNv
         I7U9k6KGwjr4kVp/EMsl8nfgP+kMkeBDjb3ekCnWziYoxjqC3SAV9qrBSOgQ+/wLcZiU
         ZEC2O5wkL5+Mpa2RlkU+MI1UlSWe1H4baOnkPIwy9i6ytXL6+4buGGJDst98PO8L+Ejh
         RQ/I+UAezRRIBJ+btQ5ZDgL3b5WB6Z6XE9I2kBVisSlvMi7T3aFqmskxJWRvzhtydGnL
         4ayA==
X-Gm-Message-State: AOJu0Yw+gnsImynsKu+ujtHdTCh41EFoFZhqpfka1eswIe8eCVyD/N/5
	AFNtAk3YcCV5CMahnkNazKDR9NZNpDk2M5uX/+PFCBZ6qxnVRpU0CbH6eFJxaK2mckUtzi8MpXq
	1TxoqFJuUxtLN1OKh97ofyGBIpeZKa1sRAHCZ0aOoeUhelMWO+zEKmAKuWS4zC8dA61MIpWxyRb
	dUB++VroySwR7NbBBvXDhYjRSmPODWUyw/FvYMlRBDGv+9/DTokcPKxbr3hxOLADse
X-Google-Smtp-Source: AGHT+IHihIHLR4bcIDbb4J6+u+bWCkyh8D4Hmzl4BF/uzSbYsdSRlthrIlvEZfBIKL44Yz2X0fpgKx1CWMfeddpUGn0=
X-Received: from pfjx28.prod.google.com ([2002:aa7:9a5c:0:b0:746:3162:8be1])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2394:b0:75f:8239:5c25 with SMTP id d2e1a72fcca58-7633286328dmr4966711b3a.10.1753479856833;
 Fri, 25 Jul 2025 14:44:16 -0700 (PDT)
Date: Fri, 25 Jul 2025 21:44:02 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773; i=samitolvanen@google.com;
 h=from:subject; bh=bUkj5xSp80OkF0SzfWqXezoXWmIJiBEemdW6yxCyQ8U=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBnNvxb+YQ17aCm5yrPc9GnL5Dsy4YIRamm+PiIZmokfH
 x9Yd8Sno5SFQYyLQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAEzE4wIjwz3X5/6F9vqbJm6Y
 EKUpXL8kUWqZVJ6s5p5Fc/bHNtwz1GT4ze501aLVQP3FhL8L5LuaTd5uY67bd/vIJIdXnGanbWV VuQE=
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725214401.1475224-6-samitolvanen@google.com>
Subject: [PATCH bpf-next v2 0/4] Use correct destructor kfunc types
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
destructors that panic the kernel. Perhaps this is something we
could enforce even without CONFIG_CFI_CLANG?

Sami

---
v2:
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
 kernel/bpf/crypto.c                                  | 9 ++++++++-
 net/sched/bpf_qdisc.c                                | 9 ++++++++-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 9 ++++++++-
 4 files changed, 31 insertions(+), 3 deletions(-)


base-commit: 95993dc3039e29dabb9a50d074145d4cb757b08b
-- 
2.50.1.470.g6ba607880d-goog


