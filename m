Return-Path: <bpf+bounces-18407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2100481A6AC
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 19:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B522D1F22DDE
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E91482CA;
	Wed, 20 Dec 2023 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb7fl2gk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE43481B8
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55359dc0290so1984945a12.1
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 10:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703095699; x=1703700499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MA/htEZ3cB43nIRIKm44A71PRNh/a32PJPa+6dTjCTI=;
        b=Sb7fl2gkLrVvgUGMarFeJLuWebdrJ5sQjxF1NGR1jawwv4I454mFC0/DKUlzlRKKzi
         PF0wXgfSyQPNr7+OFSvaUnnuXnimtGntaPyrr7+h8c7oe+iB8khWonRpa1qm2k5na7hr
         6kHWUkZga0FPUyWY58acdI3G0dkO+lkzimHzanmfOKxwJQiy7Lx/lxvXvWqN5QsLSciI
         XX4d0y9i8a7978ENj/Zz8XbaAeIRxFOtBew+ufqCUNqt9cdtY1Szr4/A86kFUalqGQqL
         q1ESL8eD0KFBQIY7o4GnGqiH/89M0+eAvCeBsjShJzawCHk1nogj+ic9sMz28H7ARN0D
         IgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703095699; x=1703700499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MA/htEZ3cB43nIRIKm44A71PRNh/a32PJPa+6dTjCTI=;
        b=K28x+RXSHyWlezHjmleYiWQrXK1kKKik1uBL1hmoNaPIOFv9WDxKvtscHkqVgQ0EzY
         /GkBn6C7cCsr3G/4BcjpiTYA88/AWEYvP/x82TICQCIbCDQku3gvXb617SjpI9oASEmx
         e/ez6xnasPLjFowfqoFEWRYd5cuCvSwhRsBOmCqwFmBKI28YLwll9kcPTdldi8pvymQU
         67n1cd98GOsGxfX8kqSHd67tdgYVqFIFoBUgUmpxqYozcJDV1VbkfJGNyMiUEcpChMYO
         7+4nfj0fl4v5XcqLYI8gfiAEzp8m8KPA0rEN3TUEEBQCwKCHXRcmBevwXVqIqMcnLNoU
         dP2w==
X-Gm-Message-State: AOJu0YwFgVDoo9yEcuKA82hTEolZOWXnH9HTrQ1W83JTSiOoQ8GrLWpQ
	gcpX8x0GPLj3fD1qBMKemupow8m6sW55Bg==
X-Google-Smtp-Source: AGHT+IH8mw1lhwMmxxv0lHfgiwvNk3NYksI0ATnI/wr7mSaK3Mc97sIOkNQXFWDWmDUszoiEScSbDg==
X-Received: by 2002:a50:8e16:0:b0:553:bdae:be61 with SMTP id 22-20020a508e16000000b00553bdaebe61mr1874590edw.39.1703095698362;
        Wed, 20 Dec 2023 10:08:18 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id b3-20020aa7d483000000b0054c7dfc63b4sm83786edr.43.2023.12.20.10.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 10:08:17 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	dan.carpenter@linaro.org,
	olsajiri@gmail.com,
	asavkov@redhat.com,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v10 0/4] Relax tracing prog recursive attach rules
Date: Wed, 20 Dec 2023 19:04:15 +0100
Message-ID: <20231220180422.8375-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, it's not allowed to attach an fentry/fexit prog to another
fentry/fexit. At the same time it's not uncommon to see a tracing
program with lots of logic in use, and the attachment limitation
prevents usage of fentry/fexit for performance analysis (e.g. with
"bpftool prog profile" command) in this case. An example could be
falcosecurity libs project that uses tp_btf tracing programs for
offloading certain part of logic into tail-called programs, but the
use-case is still generic enough -- a tracing program could be
complicated and heavy enough to warrant its profiling, yet frustratingly
it's not possible to do so use best tooling for that.

Following the corresponding discussion [1], the reason for that is to
avoid tracing progs call cycles without introducing more complex
solutions. But currently it seems impossible to load and attach tracing
programs in a way that will form such a cycle. Replace "no same type"
requirement with verification that no more than one level of attachment
nesting is allowed. In this way only one fentry/fexit program could be
attached to another fentry/fexit to cover profiling use case, and still
no cycle could be formed.

The series contains a test for recursive attachment, as well as a fix +
test for an issue in re-attachment branch of bpf_tracing_prog_attach.
When preparing the test for the main change set, I've stumbled upon the
possibility to construct a sequence of events when attach_btf would be
NULL while computing a trampoline key. It doesn't look like this issue
is triggered by the main change, because the reproduces doesn't actually
need to have an fentry attachment chain.

[1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org/

Dmitrii Dolgov (3):
  bpf: Relax tracing prog recursive attach rules
  selftests/bpf: Add test for recursive attachment of tracing progs
  selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach

Jiri Olsa (1):
  bpf: Fix re-attachment branch in bpf_tracing_prog_attach

 include/linux/bpf.h                           |   1 +
 kernel/bpf/syscall.c                          |  32 ++-
 kernel/bpf/verifier.c                         |  39 +--
 .../bpf/prog_tests/recursive_attach.c         | 237 ++++++++++++++++++
 .../selftests/bpf/progs/fentry_recursive.c    |  16 ++
 .../bpf/progs/fentry_recursive_target.c       |  27 ++
 6 files changed, 337 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c


base-commit: 40d0eb0259ae77ace3e81d7454d1068c38bc95c2
-- 
2.41.0


