Return-Path: <bpf+bounces-22487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3A185F37D
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 09:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120761F23C7C
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEAA364C2;
	Thu, 22 Feb 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXO7NNUz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FA718030
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591974; cv=none; b=HDxuVVdYZ3Y37uGtcOict/AE1eELSMTVfiI6ru0zup0PN/TJVCAGYbwsTY5oSdUH1p4YZ72ezQ0cvu2px52VCccOKepAVf1fzzlV+1aSGvyb86gCoi+vrS1hXgz10f2kGfX2ai5Y8lSxUx/cKBZ62zJknntzPnDUsX6V1p95Va4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591974; c=relaxed/simple;
	bh=kor8q6UkJtxOdurV8lLMyDivN89CXjpv9TlhRI5HyWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h96fuatdedjUdHsVLZKJP2K2vzmHNJy49y4HY2IeB9R7WOV1GkFgfss8H9e+eSsEFdXJqFlf7cav901v5GssbCiJxEY5Zbv7fh6CBa5REwuK6jxhFHuWozKSBbbvZW60ZW6cCLIvoQ1UL8J22U+VrpbvXHPTeJtQVsxOV/Ed8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXO7NNUz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e46b5e7c43so2323827b3a.2
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 00:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708591972; x=1709196772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDOkAdY9qrPMkWdTu/bHgC+jiBWbVfhG81xsHdXNH34=;
        b=HXO7NNUzjKQqxdorQqPRGaUBTvXumYiRiY+ytxzPBaUpB3ufpJwKNCZUAMo2UoU0g+
         GMJDCwX8er+Z/p0ZYbhdpL4U8tY7W83i2tfrpXjWQRPunsFmrj+jALh9EIJzIMLX2GF3
         tv7q4zgxfufPRBouN6AX3qk0xDhE+p/JMZiOshTkVwvlcaPzyYxEm/3gOWkkQFy6cAZD
         niMkTlBibVCsYHB4Dq0Hk6zYcGORk2B6sJtJM8GY05JayAI2FBW7POyDSF8UFdghGwfx
         DUj1kB3cAkgsoqwEnS21wH0zQHmv9TLM5pj0eZFa3j8zrFMxYLikSWqnAOy2pqUfWTG6
         UKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708591972; x=1709196772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDOkAdY9qrPMkWdTu/bHgC+jiBWbVfhG81xsHdXNH34=;
        b=vD4jTd6tdHYOdwDKCyCbc7njmACB7pgfkVoiI1rkTdvY1RvzmD6UpAtgZ2JryQO4kF
         4k5ZGJmMB5qdke5V2INZYX/cX+Rere16BhwGzk7I2A2nDnXkz7mOxS5fRv9oehATsE3F
         vN6VReIOnOA9+Ydd+i/EFyZ0GduTChEeRHUct3YLoenK7QBB03hlm/BUKacqe53gybqu
         4b/xSu+qhEinQ2EGHmJEp4qdEomTvRqvKzFoVDYNfLH2ASt9/CrjhMexKR4R/4u50R0y
         JqsNgScOqI/UpFBKjQQ/nviJazKWF0w1+0BfuAqKHN5C1wCke0zbFShxH9Dzb6P+Z+V5
         VAbA==
X-Gm-Message-State: AOJu0YwbqUi26BZHMWL1w4MX/Ok6myd0qhaF2I5UBpQlADB9x0eKqmg4
	wrpmgxXicQqjlPts9gOPUKYWuMhpZ2Yuq48pTFoF+2bd5se8fXQaFy8WeTNXaTo=
X-Google-Smtp-Source: AGHT+IE5EcPbcgdJsjmx3zvyt/bQ+0ZdnrR/ErQod8bnIHTfE20XVnJLbRdhWqymGYoddYJzQR38Xg==
X-Received: by 2002:aa7:9802:0:b0:6e4:148e:2933 with SMTP id e2-20020aa79802000000b006e4148e2933mr11178308pfl.13.1708591971883;
        Thu, 22 Feb 2024 00:52:51 -0800 (PST)
Received: from localhost.localdomain (220-136-196-149.dynamic-ip.hinet.net. [220.136.196.149])
        by smtp.gmail.com with ESMTPSA id s12-20020aa7828c000000b006dde0724247sm10656712pfm.149.2024.02.22.00.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:52:51 -0800 (PST)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	iii@linux.ibm.com,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 0/2] bpf, x64: Fix tailcall hierarchy
Date: Thu, 22 Feb 2024 16:52:30 +0800
Message-ID: <20240222085232.62483-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset fixes a tailcall hierarchy issue.

The issue is confirmed in the discussions of "bpf, x64: Fix tailcall infinite
loop"[0].

But, the issue is only resolved on x86.

Hopefully, the issue on aarch64 and s390x will be resolved soon.

This CI history[1] confirms the issue on aarch64 and s390x.

I provide a long commit message in the first patch to describe how the issue
happens and how this patchset resolves the issue in details.

In short, it uses PERCPU tail_call_cnt to store the temporary tail_call_cnt.

First, at the prologue of bpf prog, it initialise the PERCPU
tail_call_cnt by setting current CPU's tail_call_cnt to 0.

Then, when a tailcall happens, it fetches and increments current CPU's
tail_call_cnt, and compares to MAX_TAIL_CALL_CNT.

v1 -> v2:
  * Solution changes from extra run-time call insn to percpu tail_call_cnt.
  * Address comments from Alexei:
    * Use percpu tail_call_cnt.
    * Use asm to make sure no callee saved registers are touched.

RFC v2 -> v1:
  * Solution changes from propagating tail_call_cnt with its pointer to extra
    run-time call insn.
  * Address comments from Maciej:
    * Replace all memcpy(prog, x86_nops[5], X86_PATCH_SIZE) with
        emit_nops(&prog, X86_PATCH_SIZE)

RFC v1 -> RFC v2:
  * Address comments from Stanislav:
    * Separate moving emit_nops() as first patch.

Links:
[0] https://lore.kernel.org/bpf/6203dd01-789d-f02c-5293-def4c1b18aef@gmail.com/
[1] https://github.com/kernel-patches/bpf/pull/6476/checks

Leon Hwang (2):
  bpf, x64: Fix tailcall hierarchy
  selftests/bpf: Add testcases for tailcall hierarchy fixing

 arch/x86/net/bpf_jit_comp.c                   | 128 +++---
 .../selftests/bpf/prog_tests/tailcalls.c      | 418 ++++++++++++++++++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   |  34 ++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   |  55 +++
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   |  46 ++
 5 files changed, 624 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy1.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy2.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_hierarchy3.c


base-commit: 499e99ea0e8020bfc84b2327d4c37e45dc40bbd1
-- 
2.42.1


