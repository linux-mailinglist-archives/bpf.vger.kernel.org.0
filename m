Return-Path: <bpf+bounces-16184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A87A7FE08E
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 20:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE87B2114A
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 19:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3E55EE78;
	Wed, 29 Nov 2023 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHQfQyzn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BEA194
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 11:56:35 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a02c48a0420so17880066b.2
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 11:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701287793; x=1701892593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C4GPhQ+sLgiEcHXE4/l/jgu+gnQoD3xuZZnFnmNzMMI=;
        b=dHQfQyznOC08qf4meYRhv0VCK4aapUD1b3HtYiLuuRdpWFKS4FBQATZcSROIkcoYbV
         PryU78puL54twJsG+Ci9C6S/yxEhHS3nXyn7dqycT8JSE9LHRNRaTt+sUs6cCr6g/DVL
         5PI776nOZBiT78A4xqqiWCXbCtKU4uxoHIU1KgVg4htkFXdc6ufy+/FoMn+0MZ3BGPCg
         NX+h1+nhpe7nQ1BKpulIL9lVRFGB0T0UhZe1LEHbtxYFExrFQxpHPnRDH7F9AhjJb7sc
         HqoGR/fYupgdaS/NyYvKdJKNojH6Y+o6aV+Sp0msx+RComvazv6vbGD7bSC4+VUbVRUh
         62yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701287793; x=1701892593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4GPhQ+sLgiEcHXE4/l/jgu+gnQoD3xuZZnFnmNzMMI=;
        b=Zvs33lbFjmhiRGZfvSJEBfE982cDgfk4gLd5b1A/jrBIIh/ebSWELn0btlJrlmlPOH
         jmyPoCurI7TJ0Z7QNIM2qhrM8LBnPqfGNdxTtRAtykpuEyximU16FgqqAb+Fs8L2OIWP
         D3UHx3bWKbalQ5N8Sc/99saby4SlXRlYfVI6ZXckp9ms3TIgXsyJISfoQz08cmD3kiqC
         +hAsnQaIoNTDE1d7qxUxzZJmXXYE3nWPLULVqLAh5GQKPl7B2z67t+y4+3/Urk5ED/hL
         9g4O4pAhntbXgOydSc71FYsCukVDq0Y6LHbw2ibkwprLhZ/OjvnhP2KbX7WNwChOwNYU
         eEiA==
X-Gm-Message-State: AOJu0YxoOn1JCsPxOaVw0F6ttm2DvBiJrAW9WbBfo7UbJR7VrItiFHwr
	hIH3U2bYu0c5UXFORuKBx8Uw5k0qXXEWPQ==
X-Google-Smtp-Source: AGHT+IH0Ru4InKVqafM/3Zwyot5oKFcot+3g4bXRK8Vcw5lTMe+Y01Kora5/JDwQJS+oGGfQ2g+i8A==
X-Received: by 2002:a17:906:e0d3:b0:9fd:3ba:ddcb with SMTP id gl19-20020a170906e0d300b009fd03baddcbmr14152018ejb.29.1701287793477;
        Wed, 29 Nov 2023 11:56:33 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id p4-20020a170906b20400b009ddaf5ebb6fsm8287742ejz.177.2023.11.29.11.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 11:56:33 -0800 (PST)
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
Subject: [PATCH bpf-next v4 0/3] Relax tracing prog recursive attach rules
Date: Wed, 29 Nov 2023 20:52:35 +0100
Message-ID: <20231129195240.19091-1-9erthalion6@gmail.com>
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


base-commit: 40d0eb0259ae77ace3e81d7454d1068c38bc95c2
-- 
2.41.0


