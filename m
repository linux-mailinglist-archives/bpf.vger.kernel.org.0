Return-Path: <bpf+bounces-17578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D1F80F74F
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 20:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15206281FD6
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 19:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2A65275C;
	Tue, 12 Dec 2023 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO6irhT9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFDAA0
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 11:58:09 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1c8512349dso801289966b.2
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 11:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702411087; x=1703015887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BbNiGM8C3suom9OKuBRRWLn2iRvs+hpuDcupLd75HbE=;
        b=nO6irhT9g5fC1w4eJQZyRVx+b9+0QEMonqGCTgrwImZ7raZFqp5JddXBVCdBgzVu5x
         TbQYPLLJP8N1drIseP1kBVIXDbIXTdxaWqhhLqzJlMA4BeXkzMnrgNb3vS3xgoaHImhd
         TRdgPCBLClTlCYCCsxzbgr90/C36jNC9u/fHG0YB2CJHAIiVY5INlALpHcNgnKDKd4e3
         yZt7eimRmsGyZcO2xyboknf6rsUqUU/EUrNTPcCc3suephmSp12dtGO1GofJZ0vIUr9s
         U1vg9DQ1qUBBNyyChxtmD+bK6uTs54t86PEHdv9hYNOkUf+rRBMQlmAFnbPib3aUB6Pk
         uKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702411087; x=1703015887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbNiGM8C3suom9OKuBRRWLn2iRvs+hpuDcupLd75HbE=;
        b=XDEO8d9CdLfo6YacZcS/OnhnbG3yB93J7wwJ+BDuCRkiJlxRzgYwCMoRgdxTTuLrzb
         EKto0YhDKGmjYPAVDGVjnnkM+y+KGC2S6l+WeoQ8tt8pKjqaZTQYjy7Lo/YDKHFoFqgz
         tTm915wHDkFJJSVpmydsRY++jv8rqvbgw9vuLD5p7aS72sQVlG+ZXUQ7nxMTbekgLJdn
         40x+Y0eMn0lU/aQmLnVThFaHEyP4/5lB7rfS989k/LKymy8ex2WLpSHBRz5IoS0Tus2s
         iIwwBo1CTSH9xEvX2ffCYTSiHdXa0Y09S+/ZAq21mRWlDBj9mxIOZ7UrgEu7lsCV+bKg
         P9Zw==
X-Gm-Message-State: AOJu0YwGZrQvH/El5NwFUFUD2hJxXTk3pxFdhaqX1yyjNN+mZR6wWmhM
	FvAIdaQiNeqfBalULnB3KdlSVhGTF7eLQg==
X-Google-Smtp-Source: AGHT+IF/rKKgs+emHhOPfw8b9ZnAVAvYEfPPianoW0P7eb18MZosyjq2Tptd0hdSK86cEbxsOCiMGg==
X-Received: by 2002:a17:907:8f85:b0:a1b:ef19:384a with SMTP id wh5-20020a1709078f8500b00a1bef19384amr3274859ejc.47.1702411087236;
        Tue, 12 Dec 2023 11:58:07 -0800 (PST)
Received: from localhost.localdomain ([2a00:20:608d:69b3:fa16:54ff:fe6e:2940])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1db955c809sm6677386ejc.73.2023.12.12.11.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:58:06 -0800 (PST)
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
Subject: [PATCH bpf-next v8 0/4] Relax tracing prog recursive attach rules
Date: Tue, 12 Dec 2023 20:54:05 +0100
Message-ID: <20231212195413.23942-1-9erthalion6@gmail.com>
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
 kernel/bpf/syscall.c                          |  19 ++-
 kernel/bpf/verifier.c                         |  39 +++---
 .../bpf/prog_tests/recursive_attach.c         | 113 ++++++++++++++++++
 .../selftests/bpf/progs/fentry_recursive.c    |  16 +++
 .../bpf/progs/fentry_recursive_target.c       |  27 +++++
 6 files changed, 200 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c


base-commit: 40d0eb0259ae77ace3e81d7454d1068c38bc95c2
-- 
2.41.0


