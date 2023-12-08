Return-Path: <bpf+bounces-17223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEBC80AC8F
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 20:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A455281A1D
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 19:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D6A481A1;
	Fri,  8 Dec 2023 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7hO20nf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7A510DA
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 10:59:57 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1f0616a15bso241879766b.2
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 10:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702061995; x=1702666795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fRwEX9nnHrjqtpXbTvdXXmY5o6VMC/wtGkG1FenJnbk=;
        b=a7hO20nfeE65kzcdNEYDa6UWsM2LwVvh9WEe4MWP8+7yx4LyKgOfJcaZ18vCJAVdsA
         T8faUMWm2Owsy7Jq4OB0LXDyQyUHr2ORzxdeWqXNL0ZQdJ2mpeWabvJWstDfO4X5HvEZ
         SMHe2gflcKqKf+i3CFo0kgvxOZGaz861jH1WGwxLCyGLOtJXP8iOxcMo7ZcKQr76OFRf
         uKG1hRwShr9KS0W5OCrjdGbDtzZ5MDqFq284QM1qYZtKLydPxTaDwMB54QWYP5cbfv64
         +fnCmBehRceyTMgjS2+yUy4AbBT5iCKPNM7sSRlpH928voJWidzar5cy+Ngy815Xthtu
         +6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702061995; x=1702666795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRwEX9nnHrjqtpXbTvdXXmY5o6VMC/wtGkG1FenJnbk=;
        b=CW17OuanhXdgEa9MAf0kUp9RGV3rhLaCb1K84HiXHUKzcqd6rQmWg+q3Ygod+ly99U
         GcU32LWA72Di7gOjwRDdBYEs4dL10VMcqw/bZLLK4EGFIIzXQS+26LLWsMxGc5lEqdMJ
         t6GN3RSHaavwtxnCkdyblI71CB5EnQiojkvQwY2NL5Ar0eEY7qn9U5nIPsKvTYA/MkNp
         uDwLY+zV206Q/bvXqU44clEFhJBLfonYpItnAiCwsf6kg56iV1JXxMtS75TKDqU2Kq/D
         ms1KciyobBB51DzlNvwU9g2oqJbqmVwPVrU2tqIRpZhYqDqqoMrH3KRxduq7nwFv1fnX
         lHUg==
X-Gm-Message-State: AOJu0YyiMiMnAlw+F6ofoN9bHv3w61Ba+QXio/naT1VIAB7VGfNQF6PR
	Hl0DYBd7yxlxSE9eBDKVKGYCnoun2RCKBQ==
X-Google-Smtp-Source: AGHT+IGUBk6s1jhWcqXFWGAVbPEJ08OjymzQz6UYzlKhFdM8SMK7zSqfYHyHj0Oig8b6I21wZ9ylOw==
X-Received: by 2002:a17:906:4559:b0:a18:8b15:4d3d with SMTP id s25-20020a170906455900b00a188b154d3dmr249469ejq.77.1702061995186;
        Fri, 08 Dec 2023 10:59:55 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id le9-20020a170907170900b00a1e2aa3d090sm1295702ejc.206.2023.12.08.10.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:59:54 -0800 (PST)
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
Subject: [PATCH bpf-next v7 0/4] Relax tracing prog recursive attach rules
Date: Fri,  8 Dec 2023 19:55:52 +0100
Message-ID: <20231208185557.8477-1-9erthalion6@gmail.com>
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
 kernel/bpf/syscall.c                          |  16 +++
 kernel/bpf/verifier.c                         |  39 +++---
 .../bpf/prog_tests/recursive_attach.c         | 117 ++++++++++++++++++
 .../selftests/bpf/progs/fentry_recursive.c    |  19 +++
 .../bpf/progs/fentry_recursive_target.c       |  31 +++++
 6 files changed, 209 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c


base-commit: 40d0eb0259ae77ace3e81d7454d1068c38bc95c2
-- 
2.41.0


