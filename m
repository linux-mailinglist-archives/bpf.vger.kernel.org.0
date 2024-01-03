Return-Path: <bpf+bounces-18891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C245E823551
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 20:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712DA281B48
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD6C1CA90;
	Wed,  3 Jan 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMxiPfIU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B61CA91
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d5f40ce04so61349295e9.2
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 11:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704308778; x=1704913578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XHpl88613pe3RBlMD4Zl/Z6y6/lD4+7681GvLDtpdAs=;
        b=NMxiPfIUt/o0V+f2h4krcjScE/G0FBpzSQZb+XAzyPZplSRq7VVhZCbkHrRmQBajfi
         1bSBhYzm69zmdhg7W/0Mv1Y+iDP9OdDx01QcI82TsQ/bwUbGaLyeBo1FteiMcfZvoquE
         A+/inToOUyGEkqciXm7AVYHF2NqS2F1q1bwrgpKVhWU3rmW0ueHXjJQLJhC6oSZgTKzF
         cf6trDEPg0orDB9FUqr1AuxMGvS6EScCKSIKpTKTPSMjh3EtBtEF7DzXmog9Z7N7gUgB
         Gap38xezj/kqeN0nPiEci7XVpEHnAgPbCYvf2bEJGtcMrzyqmdUtfkymVeaTq5XXogbH
         fNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704308778; x=1704913578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHpl88613pe3RBlMD4Zl/Z6y6/lD4+7681GvLDtpdAs=;
        b=dCJMexez2CvczRoGuBxy/PMUqp+Sx3rxjIDDOyCF/q+JJRdduucOifLAHBDT2UH1vn
         JP4fNsTB4PxN94wcIPrm4bbPWbC51dAdzXgO1vpTElpp5v3bb3yHifRVr97vQ3jkzomc
         ag/HYggvB1lFf+4B4PxRWt6vAMlmxsOQa/xBD13l/azFmwjn5XjBAQWf2YzIsUbIHPVF
         c/GZM5o6q2KWuGRSNJZ5qA23GndL50AI66REHDAZen6A12sMH7WTjQDPu5RWwsirCUsZ
         g52lu2muzkUktGcwdTFI21npcxv2XgBhMkPk8vXWoT2ya5uk41K/YR53H6fybmNLsTNz
         KsAQ==
X-Gm-Message-State: AOJu0Yyb+T++/O63AYvMJDkuJ6wkUduSel1N7S/Yp+mGQUH8D0+gjlnh
	6136+hbjQN/DKFQXoZlz+sJ5OKn2eRiOsg==
X-Google-Smtp-Source: AGHT+IG1RPq2fjYzJ1J2Z3z6q2ZkWcUC62G169Sije+2kl1TPMwJvGOiEdDmLGwkz6gGqoVCFgK3Kg==
X-Received: by 2002:a05:600c:b4d:b0:40d:3c6e:6645 with SMTP id k13-20020a05600c0b4d00b0040d3c6e6645mr9936828wmr.188.1704308778228;
        Wed, 03 Jan 2024 11:06:18 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id wj20-20020a170907051400b00a28a8a7de10sm605772ejb.159.2024.01.03.11.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 11:06:17 -0800 (PST)
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
Subject: [PATCH bpf-next v12 0/4] Relax tracing prog recursive attach rules
Date: Wed,  3 Jan 2024 20:05:43 +0100
Message-ID: <20240103190559.14750-1-9erthalion6@gmail.com>
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
 kernel/bpf/syscall.c                          |  32 +++-
 kernel/bpf/verifier.c                         |  39 +++--
 .../bpf/prog_tests/recursive_attach.c         | 151 ++++++++++++++++++
 .../selftests/bpf/progs/fentry_recursive.c    |  16 ++
 .../bpf/progs/fentry_recursive_target.c       |  27 ++++
 6 files changed, 251 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c


base-commit: 40d0eb0259ae77ace3e81d7454d1068c38bc95c2
-- 
2.41.0


