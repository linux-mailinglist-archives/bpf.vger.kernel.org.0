Return-Path: <bpf+bounces-22159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDDF85800E
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 16:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A13F282AD4
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1372C12F390;
	Fri, 16 Feb 2024 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsQvmT+r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0402F1292F4
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095830; cv=none; b=UkGxKHbDudf6GDFPhK6VQqlLnOVOaBoIhnqD7h7DJZWwZH59wY67cjQz0GoL+Mnr9lcB4HxJoHoAUBrpb5ynCrJ6BsoI16Esbb7Ey1wrzhEX4He3kLGsKNncithFPGuDKzB7/iwAYCS7gixPndz6jZeUJf5dVU0dawbK4z+2A7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095830; c=relaxed/simple;
	bh=J0yj4BDXL3YMBHBIvOhsqkI5u8ECYsgw+L0cou065iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KT43qUTN8hq53T91fiCX5OTvdaff1UcwC+Pzwd5jaLbo7qsODdAF09pzW/3CFmAGAda2TjdJqZfLiwGrDQ7y6zUiZh7nvvN4x3muh5n0IJp1iYIZeeejbi+RVbeK/a7Ha3NBy4qcdX1e3ThA2tdbeKQt8cUJfGAbAGb6f/uZhS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsQvmT+r; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3d6ea28d46so416218266b.1
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 07:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708095827; x=1708700627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Po1Yb7JsMIxli0ABK8HL9EyBgr+s5WDg4rhCl+zwXT8=;
        b=CsQvmT+rIOBPoiLMKNCh0EC0pFDah2ZybWI/f5Etl0i2RXt80kpK342kQO7A8IcKpI
         pxpH3/pHj3FXs57/KRmnjho7QIuaRC+hjlaV5McYUSb+T4YJmd8uf6ZoChJjU1NKqrvB
         AaPU3kyGechRreK4IvNzuLOJieOE+lVOjLUMJYnkrqqdu2yWBxbNogb7ZKpgH8UucOjN
         1iDuQqGo5zllbuMkmAj9fgaphgt8pm0qmossGJyt4SXq6ii72fo/k5YGUdbnaweoNNOJ
         hNEGecr5G55q8mGmlSqlBfd3HovLduc8eK7lPofDzFSi8lVbE3B5QlrrJMlhHTp/8/gn
         yk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708095827; x=1708700627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Po1Yb7JsMIxli0ABK8HL9EyBgr+s5WDg4rhCl+zwXT8=;
        b=bvfvF45coeAGdfeKYAMO4/ThVq0SJc9Uvg1H+uRnxYwEc1x8IB2HJ1hl3x2bss09DB
         oNdTEcJWfvqdNN4dSfVWU0p0HjCWl5qPGI9LzfAM+ve7NP8ATQYd9HR83+yzJK5ZPpPc
         ew+6i57u3JTlHij4cFgoLK49kDtvFsl86SoRqgY52zc3RgK/XbJ/WrRtA5PIS2Oj3ITB
         UCaznXgXeBZPezB0SNypB+FgK/04lObR15bifoMEZouFKsNoRbdeZ4hxOflV7sfMs2F0
         ERQC7cGc0q/mahyMb66D4+rWxP7Ho5pOZvhUjKiMxq5WH82ODwtZkTX8EKR5qfH7DplB
         u1fw==
X-Gm-Message-State: AOJu0YxmVfMflkS0oM6zyjGwfqpyySrECCACHpu2BLQb9SRzGuth/JX7
	ANsqqvSjezX0OOSHYeLqQ9QvtYPjL0Wk+MJc/vOdFF9g+tqEJUneG0vpIjz8
X-Google-Smtp-Source: AGHT+IGWO6tGvRd6qWcotlTlracNesREq89pq4YJFn+Lh03E7vqyDr4ce5NAlyVFqfGgCQgclK1Ptw==
X-Received: by 2002:a17:906:81cc:b0:a3d:2970:32f1 with SMTP id e12-20020a17090681cc00b00a3d297032f1mr3995029ejx.8.1708095826763;
        Fri, 16 Feb 2024 07:03:46 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id fj16-20020a1709069c9000b00a3d07f3ac61sm14209ejc.101.2024.02.16.07.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 07:03:46 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	kuniyu@amazon.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/3] check bpf_func_state->callback_depth when pruning states
Date: Fri, 16 Feb 2024 17:03:31 +0200
Message-ID: <20240216150334.31937-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch-set fixes bug in states pruning logic hit in mailing list
discussion [0]. The details of the fix are in patch #2.
A change to the test case test_tcp_custom_syncookie.c is necessary,
otherwise updated verifier won't be able to process it due to
instruction complexity limit. This change is done in patch #1.

The main idea for the fix belongs to Yonghong Song,
mine contribution is merely in review and test cases.

There are some changes in verification performance:

File                       Program   Insns   (DIFF)  States (A)  States (B)  States (DIFF)
-------------------------  --------  --------------  ----------  ----------  -------------
pyperf600_bpf_loop.bpf.o   on_event    +53 (+1.09%)         323         330    +7 (+2.17%)
strobemeta_bpf_loop.bpf.o  on_event  +594 (+27.85%)         163         213  +50 (+30.67%)

(when tested using BPF selftests and Cilium object files)

Changelog:
v1 [1] -> v2:
- patch #2 commit message updated to better reflect verifier behavior
  with regards to checkpoints tree (suggested by Yonghong);
- veristat results added (suggested by Andrii).

[0] https://lore.kernel.org/bpf/9b251840-7cb8-4d17-bd23-1fc8071d8eef@linux.dev/
[1] https://lore.kernel.org/bpf/20240212143832.28838-1-eddyz87@gmail.com/

Eduard Zingerman (3):
  selftests/bpf: update tcp_custom_syncookie to use scalar packet offset
  bpf: check bpf_func_state->callback_depth when pruning states
  selftests/bpf: test case for callback_depth states pruning logic

 kernel/bpf/verifier.c                         |  3 +
 .../bpf/progs/test_tcp_custom_syncookie.c     | 83 ++++++++++++-------
 .../bpf/progs/verifier_iterating_callbacks.c  | 70 ++++++++++++++++
 3 files changed, 126 insertions(+), 30 deletions(-)

-- 
2.43.0


