Return-Path: <bpf+bounces-27633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 238A38AFF44
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 05:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE711F235B7
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 03:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0285126F04;
	Wed, 24 Apr 2024 03:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Twhdhbod"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5A83CD6
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713928401; cv=none; b=RJYvIcUQPrp/8QMbd354puVMoTP97Wp8NyIrKZAFa5L2QcJU0KjvyLpkqBmmBYeSeDBiBgaAVqBvCGgbI44qsmPGnEWnHTUECC8xR18yrEa/fCm+NPLNWOMsCvAbint2vQK4NrrkkuxUswo7CJPukqAPolH0IGg6fnQd6L7omao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713928401; c=relaxed/simple;
	bh=y53M2DOtzi+3XQlUTRm04riS/pBg8Jp8c90WRsn+Vs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+BP+cAmbvK30be4H49iNJZNrPvkPFD0yRCj4cuRpqZpyvFGomBoUYGEogDKy6Aq7YrrnXOh/JQDOFOsaybzsYcDcf2HJoHYe1poXuGavDsoZGhgV5dmNMPProQvaVLsUECodCwmrp52XucfYaew/QvO9sPcZTih9FVylKrjl/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Twhdhbod; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-51ae2e37a87so5435036e87.2
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 20:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713928397; x=1714533197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9TqmM3y8W4CEDNAiZdApW+5uxTvMByjIAGPlIDhCvs=;
        b=Twhdhbodvlbo5WiP4VeDJWFSh4iSImyRYU5Rk+yYBOX7dTbadhKsafVwh+srg+BTG0
         pnnwFygVPZbHr9o+oVyiaVFVDDk6N9kRPtrWtFkj38tPabxXbXNJI7b3jTyCdcfp++ko
         W9arATpJbBi1ZGj4KyVhKgdIcSyXHzGVsUFAK2CRF4YYb32ywfEUCmKsOy1wz7g44ajC
         xIh8r2MO1wtdYk14u5Q29lYkKS/kBCz19/xpLSkDsZ0WxbzfOxX1atPOo/DPTJCZuHIj
         UKZWFit7lLocisi1oAGEJhFc8mAUHGwwvMGQfZbDANGi8NNGVACgN2emzzxygX0v0WSV
         /i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713928397; x=1714533197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9TqmM3y8W4CEDNAiZdApW+5uxTvMByjIAGPlIDhCvs=;
        b=Fq4Y8c/RD1bLZb0Uc96rClFbknX1ejt233ccyCDYTYpgf+nR+qe+l1lh4VaRtaPFR4
         aXVSKuucV4g2tSXK1RpCiCi2zN0T8nFItbLIQamiutiwEt6hQ1YwE2Hq0F+lygRnjp5f
         52ucmn8SJBVxXxlrnU02sSoOe8B8bVSxIPpy+2GHs008CGKqm+YJNh7hxDaMvicYtjGw
         63N5lLHuUHo3KnRg069HU3JqupBe7fIp2aLy4+BZ9WcZxqjc6/UovVoKDiMK30Yr7R7T
         ZEKLFoF48ZpJD6t2UHbEEiV5d+kFcJdrFYJPqAsYSeltutS7FjBEz8dnx/G6Z75crVIn
         VjqQ==
X-Gm-Message-State: AOJu0YwlYIPTv6Y/Qf06qXXBmnRxw00MWJ0vFsoT3RLtHlZHOnzQhv5X
	rlX5WsVr6utgTOZr+D1aC/jVmIJpIOkdbUgY/digUYWFSX27qhoEBHNIewAp
X-Google-Smtp-Source: AGHT+IHZr7151IYo9xD5u5EkxeuBQ6r/O/uMlZix2L5kYRveUcAqsnYflpmzu3jCTybFML/TFxhFqA==
X-Received: by 2002:ac2:4557:0:b0:51b:a801:3067 with SMTP id j23-20020ac24557000000b0051ba8013067mr767317lfm.25.1713928396821;
        Tue, 23 Apr 2024 20:13:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id qt3-20020a170906ece300b00a5887fed95dsm754008ejb.2.2024.04.23.20.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 20:13:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Barret Rhoden <brho@google.com>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v2 0/2] Introduce bpf_preempt_{disable,enable}
Date: Wed, 24 Apr 2024 03:13:13 +0000
Message-ID: <20240424031315.2757363-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2509; i=memxor@gmail.com; h=from:subject; bh=y53M2DOtzi+3XQlUTRm04riS/pBg8Jp8c90WRsn+Vs8=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmKHiPQ5wEz/+M7i8nmw6t/wg508flnRViuoSKC cBnzWsIFm+JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZih4jwAKCRBM4MiGSL8R yne2EACCKheUy+CleTUXT6jjIFVZlu+SP+1K5mxnx6+vStUku1UA9P4sZ/GxA/GRf1cxvJqOArp wCTP6hKyjM6ogX683YrhMbwZnNzVhaRnK6hHrAJ5U/P3QAtsX67ZbhYKjqwcJv800wOQZmMU8c/ icA4lUQtqFfJIl3VC6oft/XbDxFUbs4ng33gDMNQz5EvgBN/GrKLJTpRRVDRoKeLw7Nn06Cp2yT 44HLiXHR9HGg7mDy8IPYirw15Z3pUfBueW02MG6WUtUxFiQNWBglL67iCWn71eE8sRaG/WKtK3E Xh1uXsU/1xayfD+AAvn+ndcYy0ywzsgwfEju4pZBm9iNrKg3LOeHv96d+y0mC3PZPsHYWsa4Fhv LcgB/FG8QUW6VYokbIbwH4vN+XXeMibjSltRNb0qv+BkMp3WIXLAja02mzdN+qb8v1LauPDP3g1 drT9b57q8UMi0KiUv7CQo6A+Gl4tFS1IeJx/fw7KXYy4JEt3l9w6iMP30j5NTPxa8sztUQyfBm6 qLEIlFlamJQOgaWyaV0OcQWHiETLAkYJjdLr6iiAKkZ721V84kGPNJ0am0Tf8JSgX7bHPJC1OG4 V6YDAVb9zKe5oN8oTZsAaBqV5qMU9o5aHI4GGdXby6LFh2nyhMY2PbQHPjH5Q2sCpHA8VvKa0J+ WH26mFKHRClz0Fw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set introduces two kfuncs, bpf_preempt_disable and
bpf_preempt_enable, which are wrappers around preempt_disable and
preempt_enable in the kernel. These functions allow a BPF program to
have code sections where preemption is disabled. There are multiple use
cases that are served by such a feature, a few are listed below:

1. Writing safe per-CPU alogrithms/data structures that work correctly
   across different contexts.
2. Writing safe per-CPU allocators similar to bpf_memalloc on top of
   array/arena memory blobs.
3. Writing locking algorithms in BPF programs natively.

Note that local_irq_disable/enable equivalent is also needed for proper
IRQ context protection, but that is a more involved change and will be
sent later.

While bpf_preempt_{disable,enable} is not sufficient for all of these
usage scenarios on its own, it is still necessary.

The same effect as these kfuncs can in some sense be already achieved
using the bpf_spin_lock or rcu_read_lock APIs, therefore from the
standpoint of kernel functionality exposure in the verifier, this is
well understood territory.

Note that these helpers do allow calling kernel helpers and kfuncs from
within the non-preemptible region (unless sleepable). Otherwise, any
locks built using the preemption helpers will be as limited as
existing bpf_spin_lock.

Nesting is allowed by keeping a counter for tracking remaining enables
required to be performed. Similar approach can be applied to
rcu_read_locks in a follow up.

Changelog
=========
v1: https://lore.kernel.org/bpf/20240423061922.2295517-1-memxor@gmail.com

 * Move kfunc BTF ID declerations above css task kfunc for
   !CONFIG_CGROUPS config (Alexei)
 * Add test case for global function call in non-preemptible region
   (Jiri)

Kumar Kartikeya Dwivedi (2):
  bpf: Introduce bpf_preempt_[disable,enable] kfuncs
  selftests/bpf: Add tests for preempt kfuncs

 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/helpers.c                          |  12 ++
 kernel/bpf/verifier.c                         |  71 ++++++++-
 .../selftests/bpf/prog_tests/preempt_lock.c   |   9 ++
 .../selftests/bpf/progs/preempt_lock.c        | 135 ++++++++++++++++++
 5 files changed, 226 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/preempt_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/preempt_lock.c


base-commit: 6e10b6350a67d398c795ac0b93a7bb7103633fe4
-- 
2.43.0


