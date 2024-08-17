Return-Path: <bpf+bounces-37402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D28A9554B0
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 03:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2544B1F21EB9
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 01:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A14C96;
	Sat, 17 Aug 2024 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQw2zSSg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC10645
	for <bpf@vger.kernel.org>; Sat, 17 Aug 2024 01:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723859516; cv=none; b=GVWFkVFUhcNFQ/7Sxtcv34I2oF3qDrzt+w1fRjrmoNUFNyhRCC6yVWG27xBaAkovIs9Njt9dQWEBPLg8v3HkoCU8gUSLCtuLCykTyD+KJiqKJ27OwCW9NChFO4g4FIg32S+GtMf4CZ01FqjGr+pERxvidspHx+4eBP6Y+mN+nRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723859516; c=relaxed/simple;
	bh=QuYZhjgpOb1upTCc3qmEctC3ARKfPj0oqwPAYxDqw2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A8V8xrDbTykGOt++shFE42l6NgG1FYMFWBfA6r54guF3pcQSbWCbdyyanL4kMMKa0FAAB2PkCkOo4rjlQ+17VcM2oYwZG8oZWVwycMfvicfAbSR3mRxZPlgUYrUQ1DQXw6r2pvdNISWXkArplcDdnbiHbs69o/WsZ1y1MmNBmVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQw2zSSg; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-27020fca39aso884775fac.0
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 18:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723859514; x=1724464314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H43Fos0XVo8/xBlHlyQDbYtAJCydQbaLI1nGWH7EpvY=;
        b=NQw2zSSgKwTlxh31znPsvH0UG3Cb1gwOo2wXjoTkrnIe97xcb6G9qwUqupKDI7GcDA
         IvGuvfg2t3f72EHsdrpmF9TKFymcDXA7vlYabA+j7Z+jHIZAjRBxVtdwcfnhqGQDPfzN
         H/KiIAJu1i1sTXqWh4nu8qcXQ1PRHOOjLFcZjR0jqy71UcFWslqTv+rcJgr9k2hMRVZz
         1XGRBuB6KAOngKWSHxjchdELMkqUCQcuGpEdy9NlTb2DqrxMxgfhgMUVWmEGxgpk5mj1
         BKB+2tMzGbDE9cAgoLYd0nr7fDlu44byg7LlA+ehzCrnvpN9z39U07Ky3W7vmkU0WCQT
         H0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723859514; x=1724464314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H43Fos0XVo8/xBlHlyQDbYtAJCydQbaLI1nGWH7EpvY=;
        b=wdsKpaalcp88bN3b4P2KWBAs/N5V16wThzb/2Kwi3oLBHIbCqy5XnO6i9jybvBGsLe
         cJVEndZJK5Zv+Ong4hnC5UQh39Qk1r1mLSPFoCs6jpmfC2FuFEMATTcRJAHsEM4/Jyr3
         Kn5FupCQ+mWqpxVoikr+yzgC3n7LkHb/GglBUu2a3ZGgTPns+oQROTi2X2QK3jqnAih7
         e8HNIt9LBT1sBNIf2klF+XWZuQ2bS9owMmSQPqwt34eo2P4Y9IegIv4CjoHPh//tlbSm
         S40AGxDXzKpgI0FnuAzg9ZFb1IrzNfTgH606wxG0u+jBI/7fhM5X3x/Tjzso4aT17OHw
         qISg==
X-Gm-Message-State: AOJu0YyCY+zyAYfmLmJXvnUgejhgH6LtkIqk9NJiyHUF0o45bcQ0iZF0
	iITAl4qYMVuTD5fNb+ClsJY7fMRj1Q31NJsxj/Fz3KbfGt6xctyxV0U/qSJ8qsU=
X-Google-Smtp-Source: AGHT+IHX95Gz7Erg/2ZVtArCceTU7V6rPGy2KuWH3gmCg+IJxM8/JOZpjhZj/hZrhDkIRAwp7UAz9Q==
X-Received: by 2002:a05:6870:3320:b0:25e:d62:f297 with SMTP id 586e51a60fabf-2701c58a268mr5091236fac.45.1723859513998;
        Fri, 16 Aug 2024 18:51:53 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356ad2sm3598887a12.69.2024.08.16.18.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 18:51:53 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/5] support bpf_fastcall patterns for calls to kfuncs
Date: Fri, 16 Aug 2024 18:51:35 -0700
Message-ID: <20240817015140.1039351-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As an extension of [1], allow bpf_fastcall patterns for kfuncs:
- pattern rules are the same as for helpers;
- spill/fill removal is allowed only for kfuncs listed in the
  is_fastcall_kfunc_call (under assumption that such kfuncs would
  always be members of special_kfunc_list).

Allow bpf_fastcall rewrite for bpf_cast_to_kern_ctx() and
bpf_rdonly_cast() in order to conjure selftests for this feature.

After this patch-set verifier would rewrite the program below:

  r2 = 1
  *(u64 *)(r10 - 32) = r2
  call %[bpf_cast_to_kern_ctx]
  r2 = *(u64 *)(r10 - 32)
  r0 = r2;"

As follows:

  r2 = 1   /* spill/fill at r10[-32] is removed */
  r0 = r1  /* replacement for bpf_cast_to_kern_ctx() */
  r0 = r2
  exit

Also, attribute used by LLVM implementation of the feature had been
changed from no_caller_saved_registers to bpf_fastcall (see [2]).
This patch-set replaces references to nocsr by references to
bpf_fastcall to keep LLVM and Kernel parts in sync.

[1] no_caller_saved_registers attribute for helper calls
    https://lore.kernel.org/bpf/20240722233844.1406874-1-eddyz87@gmail.com/
[2] [BPF] introduce __attribute__((bpf_fastcall))
    https://github.com/llvm/llvm-project/pull/101228

Changes v1->v2:
- added two patches replacing all mentions of nocsr by bpf_fastcall
  (suggested by Andrii);
- removed KF_NOCSR flag (suggested by Yonghong).

v1: https://lore.kernel.org/bpf/20240812234356.2089263-1-eddyz87@gmail.com/

Eduard Zingerman (5):
  bpf: rename nocsr -> bpf_fastcall in verifier
  selftests/bpf: rename nocsr -> bpf_fastcall in selftests
  bpf: support bpf_fastcall patterns for kfuncs
  bpf: allow bpf_fastcall for bpf_cast_to_kern_ctx and bpf_rdonly_cast
  selftests/bpf: check if bpf_fastcall is recognized for kfuncs

 include/linux/bpf.h                           |   6 +-
 include/linux/bpf_verifier.h                  |  18 +-
 kernel/bpf/helpers.c                          |   2 +-
 kernel/bpf/verifier.c                         | 183 +++++++++++-------
 .../selftests/bpf/prog_tests/verifier.c       |   4 +-
 ...rifier_nocsr.c => verifier_bpf_fastcall.c} |  76 ++++++--
 6 files changed, 188 insertions(+), 101 deletions(-)
 rename tools/testing/selftests/bpf/progs/{verifier_nocsr.c => verifier_bpf_fastcall.c} (90%)

-- 
2.45.2


