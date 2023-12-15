Return-Path: <bpf+bounces-18034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B538150E4
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 21:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740191F242FC
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 20:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9BE4187B;
	Fri, 15 Dec 2023 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+QxbRVz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB335883
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a1d2f89ddabso128380966b.1
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 12:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702671065; x=1703275865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BbNiGM8C3suom9OKuBRRWLn2iRvs+hpuDcupLd75HbE=;
        b=T+QxbRVzNWo8+KNjSzOaGfzrCGJ1axDbQBxIZe5xi4OStJK6DHhy67Cl1SCwM5iEC5
         h7vgif7f7a+BpZm1A0bYmY0uhjnaOnbH8l773NjnB+nNl9k2ma30qLgXfopss2NYGl2M
         CKFc2w89Oy/Bkb/rkWTs6zV0aotYISDlewQfgg36l4epOBfV1IszpV/VEb9rD4biaJgG
         NPqpZ9SUokwHLwRo/0ZnBpAL41MncsCRaz/Uf2BTuL7qYFBwJpIPIflAyNkw/9sTh86y
         cla3dgd0xIgWL3a2pgE2rPfhyoPOODeHi2CZafkJknXnhIWqkMlROzf2+IgSdLdYk7or
         WdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702671065; x=1703275865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbNiGM8C3suom9OKuBRRWLn2iRvs+hpuDcupLd75HbE=;
        b=QpgsomTXpZel6wnOEnDV+ucAJa6esyN1IUBOajTudN622bq0bIj9lRdf4oLeGI4gx5
         H7VVjKrOIvsh4d/1A/I76kC0vjqzy0JEkCtlrdkNCVOWFYGHaFYGPADpNsLX/eGXxB4k
         HJxAr8TPtVuRK4BOslF88jtXuDSH58YkSE9qcwqXGxVh+cqZrRwDyf5PIA91W+cUFRbr
         I8GcWpMxU0MOrQ4dfmAZutFz1PDdlj4fWtvMTnONncNX4bXH4XY/VGKm6y0B5ya3sHOa
         FNCVTAU81tdGkEWCojXeFGjPbPeN/6XuXzzUiZSeeO+cscFxhNNN2TLb4mIGg/JubF+n
         3Fcg==
X-Gm-Message-State: AOJu0YxUEB5hYJtMLhreZC9zqFVZZ30jjqT3PAKBUlZgofeOVDx/3u3K
	LK3eKoarvsn/fB9e7ij3jdPPztkxjREdBA==
X-Google-Smtp-Source: AGHT+IH2GX0slEh5lxyNN2BmuqoNfk9t3IiGmcjbz050b4H8P/w8JDkRwhftF2bTH3sDig1+V/ZHcA==
X-Received: by 2002:a17:907:948f:b0:a04:4b57:8f27 with SMTP id dm15-20020a170907948f00b00a044b578f27mr7083040ejc.60.1702671064675;
        Fri, 15 Dec 2023 12:11:04 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id cx11-20020a170907168b00b00a1d5ebe8871sm11031490ejd.28.2023.12.15.12.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 12:11:04 -0800 (PST)
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
Subject: [PATCH bpf-next v9 0/4] Relax tracing prog recursive attach rules
Date: Fri, 15 Dec 2023 21:07:06 +0100
Message-ID: <20231215200712.17222-1-9erthalion6@gmail.com>
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


