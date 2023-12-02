Return-Path: <bpf+bounces-16514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24AA801E32
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 20:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A2C1C208E4
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 19:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B63A1C69C;
	Sat,  2 Dec 2023 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzdkDlQb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07816124
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 11:19:45 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9fa2714e828so452158566b.1
        for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 11:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701544783; x=1702149583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xc8OyAIvpMrj7i+6PDtXxCT3yAf1ur8NpR9z/Cd0U4o=;
        b=HzdkDlQbjHkpuPlPKEHQAmRCts0wBv3+idEwgJS7eStgK/O717zGGejWaRVIY2LYY3
         SGImExyKrxP7GdfQ4kYKUzi1LQh6xmF31GDjbfZZpcGFjTNVN3+VJvdM8110NFLUH2CW
         91u3fHZqGvqA01j36s1ogLFXpmS5E7V9+AFXwMT8vGl0a/myFDjZKFoV6WxlOaik3J1G
         67xjx5hxoMPkx9pQZzOSs+GINoS+6ZGN7YcGFm9HAqOPm4KZeBKCHKVQP1QTPUi8vOOX
         35uOHwaW50ybI6gLMKNQ9uKJkNXwtD7MIFesnAT6j3MOq9qntPE53sx3xMVN9VaYNFuR
         biRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701544783; x=1702149583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xc8OyAIvpMrj7i+6PDtXxCT3yAf1ur8NpR9z/Cd0U4o=;
        b=CYeqsR6CG0/nnEa62tsVwyqZUyEuL25eAvckjgF0QyR8SMMIusayVeLrtOSvVBaV2f
         dYhFUmYX/U71CVCUtJCK5q/B/VEGvCwcF8BPYWDUxc93r5oUNH+0fIrIYXKCe48q4ARJ
         u+ip/srVm+JRBJX1BARjzSUwx7HjtoHYitU6c9urY6bx9qh8BwP9Xb6j8LHxzo+VCNQS
         frhHecoOTKmHohFGmV16PmRdwQHsz21dDIM09sCSRKoiZBKpOBfyfzpv9dxxArgo/hm9
         U3Ij1D9F29ajwHlT5iCl5D8DkVRV7+YrHvsJcXnhw+8yFwXvXw24JwkM/xNzWCQPcQOK
         Z3RQ==
X-Gm-Message-State: AOJu0YymejekTcIh0XGvzH2iylNfBqp9zaZB4w1d9O68e7SUbdFvDb37
	PCaZIRZcForYiXJOBf/6MLiXGtTpzjT54Q==
X-Google-Smtp-Source: AGHT+IGU82kClpeF36iSwC9WXO1CzO2xBx/xwBfACkvKS+zkvjXYScs44gwy7UFmSRgfAZPRUPjo7Q==
X-Received: by 2002:a17:906:14e:b0:a19:a19b:5605 with SMTP id 14-20020a170906014e00b00a19a19b5605mr2338205ejh.149.1701544783069;
        Sat, 02 Dec 2023 11:19:43 -0800 (PST)
Received: from localhost.localdomain ([2a00:20:6008:6fb9:fa16:54ff:fe6e:2940])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906115700b00a18ed83ce42sm3127814eja.15.2023.12.02.11.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 11:19:42 -0800 (PST)
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
Subject: [PATCH bpf-next v6 0/4] Relax tracing prog recursive attach rules
Date: Sat,  2 Dec 2023 20:15:46 +0100
Message-ID: <20231202191556.30997-1-9erthalion6@gmail.com>
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
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/syscall.c                          |  21 ++++
 kernel/bpf/verifier.c                         |  33 ++---
 tools/include/uapi/linux/bpf.h                |   1 +
 .../bpf/prog_tests/recursive_attach.c         | 117 ++++++++++++++++++
 .../selftests/bpf/progs/fentry_recursive.c    |  19 +++
 .../bpf/progs/fentry_recursive_target.c       |  31 +++++
 8 files changed, 210 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c


base-commit: 40d0eb0259ae77ace3e81d7454d1068c38bc95c2
-- 
2.41.0


