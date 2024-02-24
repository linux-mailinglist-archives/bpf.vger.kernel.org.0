Return-Path: <bpf+bounces-22633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B84C86226C
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 04:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83476B225C2
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 03:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073C4125A7;
	Sat, 24 Feb 2024 03:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAm6K9x8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B01118C
	for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708743788; cv=none; b=EGc6ISl1TXtnwrdsVqtHfpVVVwAmnjJQwn65AOUxZ+VIEJ3L+x+YxtToO6HboH9BkxB54J6qdWxhaqgRRdEND8L0RULi7z5IyiU1p8lmW/13Q2wrqw8pu9lgA+Dn7G34KTBGprikDWFI4owluFKeQeK5I4vu0XMyODFlREVLb9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708743788; c=relaxed/simple;
	bh=tOExjkq14EVaqVA6y8a4pYrfnqEeq4RB0Ca6BENOhfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BlRK5a4eg8mP2Ms5L4IwOZYNaTqXaMLYAFRplvZDfgn1n5C27mRYjOgVqy9hJfjvpeW78kDjZ8cBhVby1FHEr7y/2SceSBSzsHQQle8M53AEOSpkC74jeAdHWpF/sOsB3eYbK+i0q36rxPQl08AljQu0/54gzpgZqcGu7hv21sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAm6K9x8; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc742543119so1550283276.0
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 19:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708743785; x=1709348585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3UGOQEGQ1khlLh4x4MrxQtiHo0dJrlfBvJIuHQH7rGU=;
        b=nAm6K9x8skch/dLx/QbNHEB7AMJIimek0PKNU2rE3bDcd9fris04wi+YTGed1Lfx1X
         bSaVMhA00GRbA1doA5DJ3EKTmlyyDXAdmsLGln6UQe40ubjWDuBuUG3/wOGw4pkf2CrI
         SZjAT9XrGmEstLrjcgj8hhRwTB9BNsVLt1TUSNsqm+A/gvDDF67U5BDFSGxQw+ppnSxC
         WXTJOYBbIKGuHSIaJ+XX2XTINJFI9CfwUNxZxAuX6siRdRvjoGnQ7oOvrP02FmB3JxGP
         WZW6W0HekGB95crwAVWdBQgoZEep4Kz64ZabGCqlGFJZ+u5t9nPMBUTJ7qbz4vL1s/ZJ
         jB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708743785; x=1709348585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UGOQEGQ1khlLh4x4MrxQtiHo0dJrlfBvJIuHQH7rGU=;
        b=TF5C6jmzrwyDlillFYotzwEpWfrpYm0bRsr9qRnOGyZTj8pAQnQqHWl9XAs+xW+ixo
         c10t102M3/np2IQmRuIAm4hy/vgc2B5kp4YmDALV1ktiIuv95nAO0lgdhiuTBFZVS1u9
         RRHXhijMVeUS65Q78bR5rQqTFnhFKQ+NP52DsuAK0ELbvaY7J3zEzLyODQdS1AiPxbkZ
         8BlheKXLJ5xoDSxCJIgewaccnaEa4qInGQpHSCgNPn9Hvn/hCdfBRxaLb3FHBPeQM2PH
         fwAc8Hbaj5ARaev/LlgyqkTyTPRWoawFwDU6Rfu4TISw2wgc2b3roCyfjv/N+03yq8z8
         dKgg==
X-Gm-Message-State: AOJu0YzROIXPoJGC6rui47JlIF+KY3cwXEAhecFWtgIf22q6sA9q2s4D
	DO/42t55E1W5FN41N81oR8s+IrqtamnnDw+RSSNohqkakERUfNUqurybPaNX
X-Google-Smtp-Source: AGHT+IF2ePOTJ1h0Tv3Luf9WNZRxYB+dUAM+ff1rm6uwXcIdPf+xvUBmRKdCTwnlKBkWZ/yaq/MQpg==
X-Received: by 2002:a81:431d:0:b0:608:ced0:eb2f with SMTP id q29-20020a81431d000000b00608ced0eb2fmr881021ywa.48.1708743785384;
        Fri, 23 Feb 2024 19:03:05 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:f349:a51b:edf0:db7d])
        by smtp.gmail.com with ESMTPSA id w66-20020a817b45000000b006087a2fc6b9sm84515ywc.101.2024.02.23.19.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 19:03:04 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v3 0/3] Allow struct_ops maps with a large number of programs
Date: Fri, 23 Feb 2024 19:02:59 -0800
Message-Id: <20240224030302.1500343-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF struct_ops previously only allowed for one page to be used for
the trampolines of all links in a map. However, we have recently run
out of space due to the large number of BPF program links. By
allocating additional pages when we exhaust an existing page, we can
accommodate more links in a single map.

The variable st_map->image has been changed to st_map->image_pages,
and its type has been changed to an array of pointers to buffers of
PAGE_SIZE. Additional pages are allocated when all existing pages are
exhausted.

The test case loads a struct_ops maps having 40 programs. Their
trampolines takes about 6.6k+ bytes over 1.5 pages on x86.

---
Major differences from v2:

 - Move image buffer allocation to bpf_struct_ops_prepare_trampoline().

Major differences from v1:

 - Always free pages if failing to update.

 - Allocate 8 pages at most.

v2: https://lore.kernel.org/all/20240221225911.757861-1-thinker.li@gmail.com/
v1: https://lore.kernel.org/all/20240216182828.201727-1-thinker.li@gmail.com/

Kui-Feng Lee (3):
  bpf, net: validate struct_ops when updating value.
  bpf: struct_ops supports more than one page for trampolines.
  selftests/bpf: Test struct_ops maps with a large number of program
    links.

 include/linux/bpf.h                           |   3 +-
 kernel/bpf/bpf_struct_ops.c                   | 126 ++++++++++++------
 net/bpf/bpf_dummy_struct_ops.c                |  12 +-
 net/ipv4/tcp_cong.c                           |   6 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  44 ++++++
 .../prog_tests/test_struct_ops_multi_pages.c  |  30 +++++
 .../bpf/progs/struct_ops_multi_pages.c        | 102 ++++++++++++++
 7 files changed, 266 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_pages.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c

-- 
2.34.1


