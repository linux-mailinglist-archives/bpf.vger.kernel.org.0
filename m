Return-Path: <bpf+bounces-64307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9383CB113F3
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 00:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11A6AE08EC
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 22:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8169023BF91;
	Thu, 24 Jul 2025 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2NXr7S8R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC16D23AB8D
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396353; cv=none; b=epp24kvc3T7vMu8I1gV5QOmIx2A1ZcYyXjzNNf0igKMOxkBUXAwQOLc4kqKjc0GDbT957dAPvclb4YHp6uS/afUsNVPB1BKx8pSZ0leI0/jCyCekZSuGhceIv3EYIHXXkQGTZjMZRLzIpYGuOghemsdeIjmh+V40ciQoqZoVKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396353; c=relaxed/simple;
	bh=qNJea7lpsjCJP/Ap37YwQvHbphKYA19XBsxMlvH+Aq0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kbl3JEQ+MxggMdkw4DYzBczkep+sylBDHbH++C8fYnh5EHis9m2kuUldTGHh4cNj/8e/RavjF0IEwr9DOAdt9/Q/z3+c5dQaLFw5pIB/KbmlVSKe+BjmglQH1STlVOz+ZHN8M6kw9R/n+GRVYbNWBCgo5cEnE+OoKZXlpmAzo/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2NXr7S8R; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313d6d671ffso1524605a91.2
        for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 15:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753396351; x=1754001151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/DkLxOprfBbIReqRwK5t6BSLgRNtfOK+ocx7xMH4ZB8=;
        b=2NXr7S8RYOtkuzY0+FQc1u43U/XVbf4FRT/tEGMNTjO3nz4EBYN/YjzNVhbL+9Lvg8
         6V1CUlqWvOY/gKofYL1FsBfkCjEYx4ZEAZ63d5v43FJL8ZkEtxW+Xigod9sac9e/thxa
         p6M/u76XY0xXdtXUFVJjHMCpMrqPIDNM+bT569hckrUY4xTTnT9PICemNV9RwvgxShP+
         /f3ldH1C79awwjbd4y0DSX3piXZE66Hh8ecN6T2l3npk49IL0qSak/bwYu9BtcBxit9V
         ukIIHYeBrr03MVhwWwGr21KtlOahhq6q+VW5UZ9dikhYw/jx2sTU5zf59KTZ30o3HRvm
         Q/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753396351; x=1754001151;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/DkLxOprfBbIReqRwK5t6BSLgRNtfOK+ocx7xMH4ZB8=;
        b=LUKHEcJxYRoNqBVZDVj+zxY5gj3TOjT8Stu0JmYqEziIy9stY2gCWFW8EwUTz3MHwi
         aPxSC49V14GNeu0LR9uapWHhM3Xz6RgIO8wYVFBkf72eJf/Fde21M4qTpkCQGs1VP3C1
         /xQuixjcp5/3YWfMP5SZizjTySt7CREwy5okm7DHRkrhP00jqFuZDLTujiHas5ZcjUTW
         VyAO0+ni8tMaDDn7wpbf5+O6so+aiT49NFIxTYZmVWuEjJrj7aIxJXPsgzMhq9rTXzuM
         0EKLLBC4ObQI2hn8H31lVZ+vG4c4aMWqk290CGPKlnBUU9kHiugvazgiqZU6XG1Obiwp
         dbaQ==
X-Gm-Message-State: AOJu0YzL/CwbHKneDTGw3wC3cT49pJXxHt0JsfBGNEcK0BdsPBoXls5a
	Wt5kR1HyOMZpuOj2AGlFE6rdbQnUKw5g0d7SKyKhCU1/Fb3ycnIn6Q8StFh0wr7anxqWbsMuqDP
	iSSYUXy5et2vLb/rxwwroFcLESnuOEEZlstLM1KRu5IlyjA/FSUUT2pVr+JHjsKFT79v+I3fiqt
	KM8ELyqh6VrdaExl5d0Y5Yca8IY5WxDEemR89MvDgwEwn87PykCQbw+XBuN/9sI9BY
X-Google-Smtp-Source: AGHT+IF6O7rT5GsXaujxV+fnL7FhV3anbExg+l8E4A3O9jUGKRRbD4C1+rBykCMWxadAw03JwNCLVcFY4EMK3EcKPi4=
X-Received: from pjbsi15.prod.google.com ([2002:a17:90b:528f:b0:311:4bc2:3093])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d12:b0:2ff:58c7:a71f with SMTP id 98e67ed59e1d1-31e508169f3mr9948065a91.32.1753396350823;
 Thu, 24 Jul 2025 15:32:30 -0700 (PDT)
Date: Thu, 24 Jul 2025 22:32:26 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=samitolvanen@google.com;
 h=from:subject; bh=qNJea7lpsjCJP/Ap37YwQvHbphKYA19XBsxMlvH+Aq0=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBlNWyod3KutuSWsHXTaEs96/ZmfHHzl+1GdFuWbR6oDS
 wvLPZM6SlkYxLgYZMUUWVq+rt66+7tT6qvPRRIwc1iZQIYwcHEKwERefWNkmLHDra5iz8Opj/kr
 shXL+FJOmN1vSdvym+HEjQ2szwSS+xkZ9rEpPJgfuXHSGpuKPOlotbzH1o/nhbaf/RR6YO5vBw0 HPgA=
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724223225.1481960-6-samitolvanen@google.com>
Subject: [PATCH bpf-next 0/4] Use correct destructor kfunc types
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

Sami Tolvanen (4):
  bpf: crypto: Use the correct destructor kfunc type
  bpf: net_sched: Use the correct destructor kfunc type
  selftests/bpf: Use the correct destructor kfunc type
  bpf, btf: Enforce destructor kfunc type with CFI

 kernel/bpf/btf.c                                     | 7 +++++++
 kernel/bpf/crypto.c                                  | 7 ++++++-
 net/sched/bpf_qdisc.c                                | 7 ++++++-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 7 ++++++-
 4 files changed, 25 insertions(+), 3 deletions(-)


base-commit: 95993dc3039e29dabb9a50d074145d4cb757b08b
-- 
2.50.1.470.g6ba607880d-goog


