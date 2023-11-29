Return-Path: <bpf+bounces-16179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082817FE036
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 20:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627C6B21094
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 19:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCA45DF2C;
	Wed, 29 Nov 2023 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNKKYZjz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1425A2
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 11:20:34 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a03a900956dso21850366b.1
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 11:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701285633; x=1701890433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHBAkofkcMhXqcW5EEB09C4TtQr+TbVjMWBO9hd7KUk=;
        b=WNKKYZjz11nQGIB2pivxzGU4n4eVPW2L5kMfpVwfcrpzh42ClNlQPQwnRdvRj8T8lk
         PQ2QzRnpLxE6ZmLhrSj8+5zH+zqSv3av+HSuScF544wWFmwer6PcDG861zUe3qeRaPTn
         2lUArML2Ixyok9R5fKdPUlSmuqGyajGrpv1zJqwDq3OjIKFdHaZEDllglls7a3SUAnOf
         UiYTzUm+O06DQYYSbo6v+yC8zXt/XUzgrBOi7vWdp3h31mRt/AEwDUCr4IkeVV78V1sX
         67pmQEC90kAXeIDiOE2rXcQFWF+S7Yz5J+R6PVBiXJAAXrPqJt+BHFYNIevZfSqk375G
         fYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701285633; x=1701890433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHBAkofkcMhXqcW5EEB09C4TtQr+TbVjMWBO9hd7KUk=;
        b=oDFfhphO+aW1GiZdcn4mfr8krgJEQjEIqtXW2ImheVXcTh1237tk7BnXduKOjyPnor
         w0z+FrvF2od70hoLc2E3JyU/nwn+aaS52znGYH+oUFUINTcT/1jc65P8XA05jWN8r8tl
         zq7Yp8vRD+sZsfNL9W2+uBg4CM+vCvG2eBoYbLD6R/hSNucImYx3BOwCHFTkzHR3Pdyr
         +SGVhfKQVcLSmG4jXxRn3P/kj3X5dkjhhbv4MWvajozWuBIoAjV7f69yt3Kde2XAgH22
         DIAzg1RgE5h+NZmzy2kVQTU9P/OdocdncVckUHY0e3JtGn4yiqONcukjmYQqw1URgPGl
         13SA==
X-Gm-Message-State: AOJu0Yxncd6h2FmpOAwyCYpNEwjsLHciZPXwiWEOgksDRi5bfZ8QBIns
	xpFaoWMqjOIBDheLNfFq47eEiP2FKYFFcw==
X-Google-Smtp-Source: AGHT+IE3yqrWnUPsYChHcDoCe2sStIWTdIPp6pRXYZ8/poRU9cVSlEOs6uVOkK/QSLuwYmEWkqvEQw==
X-Received: by 2002:a17:906:394e:b0:9fb:ddb4:1285 with SMTP id g14-20020a170906394e00b009fbddb41285mr21551331eje.31.1701285633153;
        Wed, 29 Nov 2023 11:20:33 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id s16-20020a170906455000b009fd7bcd9054sm3596123ejq.147.2023.11.29.11.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 11:20:32 -0800 (PST)
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
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v3 0/3] Relax tracing prog recursive attach rules
Date: Wed, 29 Nov 2023 20:16:37 +0100
Message-ID: <20231129191643.6842-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, it's not allowed to attach an fentry/fexit prog to another
one of the same type. At the same time it's not uncommon to see a
tracing program with lots of logic in use, and the attachment limitation
prevents usage of fentry/fexit for performance analysis (e.g. with
"bpftool prog profile" command) in this case. An example could be
falcosecurity libs project that uses tp_btf tracing programs for
offloading certain part of logic into tail-called programs, but the
use-case is still generic enough -- a tracing program could be
complicated and heavy enough to warrant its profiling, yet frustratingly
it's not possible to do so use best tooling for that.

Following the corresponding discussion [1], the reason for that is to
avoid tracing progs call cycles without introducing more complex
solutions. Relax "no same type" requirement to "no progs that are
already an attach target themselves" for the tracing type. In this way
only a standalone tracing program (without any other progs attached to
it) could be attached to another one, and no cycle could be formed.

Note that currently, due to various limitations, it's actually not
possible to form such an attachment cycle the original implementation
was prohibiting. It seems that the idea was to make this part robust
even in the view of potential future changes.

The series contains a test for recursive attachment, as well as a fix +
test for what looks like an issue in re-attachment branch of
bpf_tracing_prog_attach. When preparing the test for the main change
set, I've stumbled upon the possibility to construct a sequence of
events when attach_btf would be NULL while computing a trampoline key.
It doesn't look like this issue is triggered by the main change,
because the reproduces doesn't actually need to have an fentry
attachment chain.

[1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org/

Dmitrii Dolgov (3):
  bpf: Relax tracing prog recursive attach rules
  selftests/bpf: Add test for recursive attachment of tracing progs
  bpf, selftest/bpf: Fix re-attachment branch in bpf_tracing_prog_attach

 include/linux/bpf.h                           |   2 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/syscall.c                          |  16 ++-
 kernel/bpf/verifier.c                         |  19 ++-
 tools/bpf/bpftool/prog.c                      |   3 +
 tools/include/uapi/linux/bpf.h                |   1 +
 .../bpf/prog_tests/recursive_attach.c         | 133 ++++++++++++++++++
 .../selftests/bpf/progs/fentry_recursive.c    |  19 +++
 .../bpf/progs/fentry_recursive_target.c       |  31 ++++
 9 files changed, 220 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c


base-commit: 100888fb6d8a185866b1520031ee7e3182b173de
-- 
2.41.0


