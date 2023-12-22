Return-Path: <bpf+bounces-18616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C025381CC00
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 16:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753E2281601
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432C924B5C;
	Fri, 22 Dec 2023 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuNV/E/y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEF128DB0
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2699ee30d1so169223466b.2
        for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 07:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703257923; x=1703862723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ApQ/EutCgfD3vC4gFe/lZ2ItP5bkC0V6aOQ0rIxM94E=;
        b=BuNV/E/yEn8pXmNvZHpQTpeDYFhtthhuRdAGvnUIPd90kgcJRlbhTkoHeLENKbonQh
         zRZATOvqeYbo1OarVdMhmFQRNWunzrPF+1qi7cvYT8Ht5/PdyFRmJQv2ju972AOfFNek
         AzTNZ/buyMze2ALQl2Fi/VtNcrcqR4tnlXv1Gdu776WJKtBk9lFTB6GQC6ttDt1j1cMS
         ZCo+l5qTOv455G91yvx/mkUfmQjIs26lk0374yhE0NzYkHI9GI9tG80zu1h/1RvFkLcP
         gd21qWfG/2IFfDXEUzM7ixxD/JeG9c+KbZdsaI6HX8uGJNfbm6HNew7CIAWoyLXjSbsm
         fkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703257923; x=1703862723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ApQ/EutCgfD3vC4gFe/lZ2ItP5bkC0V6aOQ0rIxM94E=;
        b=VvLHHMogi+YTI2B0XY4nxmWIBrBVffUzvxqX1SWcWxNI6t3CT82bYh40xuTdGuEaxP
         4CFGw76I0UPafU4Ntk8F9+MLXKUs17hgMreljJI1kWdajFhz1Bp6Wd8gWwNKFvzYxI4O
         /j0taGQ6rv3v18zjOffW0wjVwdd0YgveFyTtmjVr+RSDu7U1ii97x8amG5RlFp8cUaH3
         CozX10s3G1ogTvAXWKh5PKd2nB4ZrQJzRPuuMnzpOkNhUZwHjez7hJBsgC09W33uIafq
         4x632lgGktALnXPAPwf2375ZG9HNFfO8rrUgoBj06ePSmSl3qwnBz85yW8Cn8vbQhnCI
         oNRw==
X-Gm-Message-State: AOJu0YwQxTpViWCCiu1RRI+iTJTXJImjbslYM+ND5qbefyJwPc7zw6CL
	3Zto1LgSrBhjYCBAx3xlWa0fMRE3/lmBrw==
X-Google-Smtp-Source: AGHT+IENpYcMH/c46XCKOo6G0HUvcSU5dZWCiOCU55t099zTf7zp/WskDSvjHCLxZLOqVX2jBTg0MQ==
X-Received: by 2002:a17:906:280f:b0:a26:8994:6491 with SMTP id r15-20020a170906280f00b00a2689946491mr914743ejc.17.1703257923108;
        Fri, 22 Dec 2023 07:12:03 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id br18-20020a170906d15200b00a236f815a1fsm2111162ejb.200.2023.12.22.07.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 07:12:02 -0800 (PST)
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
Subject: [PATCH bpf-next v11 0/4] Relax tracing prog recursive attach rules
Date: Fri, 22 Dec 2023 16:11:46 +0100
Message-ID: <20231222151153.31291-1-9erthalion6@gmail.com>
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
 .../bpf/prog_tests/recursive_attach.c         | 156 ++++++++++++++++++
 .../selftests/bpf/progs/fentry_recursive.c    |  16 ++
 .../bpf/progs/fentry_recursive_target.c       |  27 +++
 6 files changed, 256 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c


base-commit: 40d0eb0259ae77ace3e81d7454d1068c38bc95c2
-- 
2.41.0


