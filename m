Return-Path: <bpf+bounces-71249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE51BEB541
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 21:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB4234F24B5
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965C33F8B1;
	Fri, 17 Oct 2025 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOf1+UcS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6431B33F8A2
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727826; cv=none; b=dE/0GwpqOc7IRKzZ0CB/oY13//HH/RtufkgPW5r7l3FjwEEheTUiobqQiUk4WR/QyDPY8OUEVhmOhryfahTf3PzNQ1eGR0aYke89ByDACg4abe4LDf8vNCiiP12nlcBBXK1tlVzrPmScPO7eMZ4TJT/VopggZnA/NT0S7LD9UZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727826; c=relaxed/simple;
	bh=ndBeSn+NHm2RNQsZOlDvyzbqjuibwXN3qsksVo5bKwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNrGP6BmdKD2fUHQ75A7HbqtmxipVxBamYX6hShJmYq3RVHdV4mugo0USC81fVHUXCdm48+I4NHDN1lSUgJj17se8+tuEEgVSXod3IZPhciY6U/mLYqDfB4EQt6HdRcRao5xImimrkWfklzFy6gZQYk/D3CCaZklPZ8ceHjePDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOf1+UcS; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b679450ecb6so1702335a12.2
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760727825; x=1761332625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pzBQ7GTghrJcf2Zkkw+BbCZd1M/qoU2VTdHo+YmIg1g=;
        b=jOf1+UcS+k7JP8OVEIXN1VialXIrP1BJbfan9X55vt+v0UEh8XjGVVoEIOQ6tW5mOT
         oIXXLU3IadS812hg027XTxXG8Tg9jfBnSqidmzQ+ClNogqx6ZJGnt2rRBR2mH3msG9AN
         takP0FKqbUw9Am10gZiKXFwlvwA9gUm+xyTjQzwIcXpdfaIPAHSUVOEEA5F/qZhJLngs
         koujhgxEtSBwEv6U8LrbTSYEppJz3dSuvqdG9U59weXwHgjwLjPR+IbDtDFIyFnt/XBj
         hJNvqIUKGyhlaQ5cPOo6io7wsZswf7ZZRGcOJ+DN9XC7afMPyISq1c8Vd7KyQXgJSOMy
         qPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760727825; x=1761332625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzBQ7GTghrJcf2Zkkw+BbCZd1M/qoU2VTdHo+YmIg1g=;
        b=sFm95WkTCTLix26XqEg+fi1Ko9u09xyrjd9KOrKcWJTh729LMcf9RFEi8fV+3/SkAU
         elyU71Pm4fPn0cGG2hcWExsNmdADrlQPpOBwq/Gahw639Bmcdl0TAGDcqq9Jlkbqm4GK
         I6T9y6IUIvczGaVUFzGyChOm9gZwpVYLN3O4qRcMshiRN1PqPV303lJ8xuw4NbzzEzQv
         Ka+YnD2DRDmaIu7EQHq/iUTtIv4v+2qG9fWkASO+bQTNkG/83anQBUoRzSOAc+cCEAM1
         BVK+OISvD4MpQm7y72cVBT1dXPmzSIjOUgecW4yQUVkg8x/PO2xEFhFkniKubx62cegm
         G6wg==
X-Gm-Message-State: AOJu0YypJZsLessl3yhYUgl2tnj2idEqY9EERfNxgQ0xtsXub+Tnyf7l
	qb/rt5KQU744qMEl8NOdStcNRHedX8K6+FhRoCEaIONCnSdikH8c9ybI
X-Gm-Gg: ASbGnctY5YsISH3orQ8503oly4GB1Bv4w7y9sjGOERTtAvsvJBjrNcNxN4sgsqkNHTS
	tHDXq4Sq4QzuTfK1WncDI5MonsIzqIb7t+WeeoDgZb4Z64lUnxF289WDMkOLys5eLsoI8D4UlAI
	ylG7H6/tJgSACAe/aJXfxo5Y2NRaKhakvK3dGtKIkLb1IJzgL6Asl1Qa5KRzjHLRupNMjQilBVQ
	YuXBOzTUvLmymcF95B0faP5rMJEZGT6o9OViPnO9MOiQQN1UhUYxgWMJokz5I407zB3Nd1CiFSG
	LBn/tWI230/J/dQGHGBFpZExxWorlBXQ130sN2eu6h1LqWJab2ZpPLSv4WzRcJO3IANiVNYJcpr
	zvh+rhTWDViW0FVX3xy/fOrrrIMEeBnSMA4fkk6IuguKX6LOzgCh4HMUkxZi5mKz37axIHAacTS
	QWXQJOMYx5FNBAJ2eLMP4e8symal+YrsLQyRR/SMH3qSrR81gsnNv6ceVP9zQ63h9s1Q==
X-Google-Smtp-Source: AGHT+IEmSNmVOYhB9iA0IInPdGoucPK2+chDWeNvaO85c3Xk14X+AYVU7s9x79ybQ12XyjcaItYIYw==
X-Received: by 2002:a17:902:db11:b0:28e:a70f:e879 with SMTP id d9443c01a7336-290c9c8cc5bmr62775865ad.1.1760727824508;
        Fri, 17 Oct 2025 12:03:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837e:3c50:1021:a424:7dd1:a498])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebd068sm2676215ad.12.2025.10.17.12.03.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Oct 2025 12:03:44 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 6.18-rc2
Date: Fri, 17 Oct 2025 12:03:41 -0700
Message-ID: <20251017190342.52125-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to a1e83d4c0361f4b0e3b7ef8b603bf5e5ef60af86:

  selftests/bpf: Fix redefinition of 'off' as different kind of symbol (2025-10-17 11:33:23 -0700)

----------------------------------------------------------------
- Replace bpf_map_kmalloc_node() with kmalloc_nolock() to fix
  kmemleak imbalance in tracking of bpf_async_cb structures
  (Alexei Starovoitov)

- Make selftests/bpf arg_parsing.c more robust to errors
  (Andrii Nakryiko)

- Fix redefinition of 'off' as different kind of symbol
  when I40E driver is builtin (Brahmajit Das)

- Do not disable preemption in bpf_test_run (Sahil Chandna)

- Fix memory leak in __lookup_instance error path (Shardul Bankar)

- Ensure test data is flushed to disk before reading it (Xing Guo)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (1):
      bpf: Replace bpf_map_kmalloc_node() with kmalloc_nolock() to allocate bpf_async_cb structures.

Andrii Nakryiko (1):
      selftests/bpf: make arg_parsing.c more robust to crashes

Brahmajit Das (1):
      selftests/bpf: Fix redefinition of 'off' as different kind of symbol

Sahil Chandna (1):
      bpf: Do not disable preemption in bpf_test_run().

Shardul Bankar (2):
      bpf: test_run: Fix ctx leak in bpf_prog_test_run_xdp error path
      bpf: Fix memory leak in __lookup_instance error path

Xing Guo (1):
      selftests: arg_parsing: Ensure data is flushed to disk before reading.

 include/linux/bpf.h                                |  4 ++++
 kernel/bpf/helpers.c                               | 25 ++++++++++++----------
 kernel/bpf/liveness.c                              |  4 +++-
 kernel/bpf/syscall.c                               | 15 +++++++++++++
 net/bpf/test_run.c                                 | 25 ++++++----------------
 .../testing/selftests/bpf/prog_tests/arg_parsing.c | 12 ++++++++---
 .../selftests/bpf/progs/verifier_global_ptr_args.c | 14 ++++++------
 7 files changed, 59 insertions(+), 40 deletions(-)

