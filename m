Return-Path: <bpf+bounces-27015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0392B8A79D3
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 02:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78126B20DA0
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 00:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F884C90;
	Wed, 17 Apr 2024 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAhkU5MV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360774A3D
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 00:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313519; cv=none; b=Mb/QOsWmv0cpQx/daFrWwDVQWuq0tf+4yTaB5Y+q8uXZtL7qeZDHLWd076t+qxfYUG+b+ANnuMtCVJks8RWfP8yik3LnB4eCu6WCb+EIZHUGhNoZJjc3vBfQBbgNkhhE8sjpT4XSSHMlhcziZ4jeoiUcxbXZWlz1nE/4Q75FcEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313519; c=relaxed/simple;
	bh=FU4AUvaaxiVA0GNXTjY4memr0RAqR7jLgX/XBO0n7Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oZ9KaOkgTg1Rrvwvu+Hw6VL4CpCwFEEdc7d2pdL5xLcHCG2PeumzdSvUhq8m8R1rF5oqU4nmZSD5EXnjTvNpd5bAzs4aPF7u/AXsiGf79HRUhuqXSXoyeBT98jTe0ZGPjR+yzGd0FIC5Cqks5eVDC8cBo+/ZbS3wGzymfxul7/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAhkU5MV; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61ae6c615aaso20993357b3.0
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 17:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713313517; x=1713918317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ztzdYkUHRavrVMzZ4/pqUskvu/ExzVG+/jNLdgCPzTs=;
        b=bAhkU5MV35Py4a2M20qxM4VTkqpNAVCe2lfIDdGsHkMYSqyfpBWRZETChN3aDLasm5
         ErCQ1VT3+DMvyHdcckhFb4DUEqWm5cwjflry/t9FxEJYyLSXlSSEMB65SyRsQGnil049
         JCCzRX4hDpMOrOeC2wR+hCgVvKGoI3HwgZmvkfhC8axLtGUM1bwsNn5Oui82NBxL6lI7
         tr1W1SRrDBx3s7c5BK2qyTkVqHusw8xOkw4ZPffkq3ciNp+V5xaRDOV4c1hm5wOpJVyx
         JWUiXsS/TkiJDxwRuEiK6Qk1w83PNoN6AUMSQ0nd8PGzr+E+hRP3Ao0F4VWa5v8DYxwO
         LQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713313517; x=1713918317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztzdYkUHRavrVMzZ4/pqUskvu/ExzVG+/jNLdgCPzTs=;
        b=OIhR9FWAycrHVljC4lnIMKVXl05wVNVBOy4E+syT2gbvFC9NakF2AwHdwmalma/CrI
         2S+bp5YNuTp5ave3sUIsuogA8D2kb4AGRvF+s6kg1BgrUeq/awDi1Wg8ao4gIyHwmv0y
         Rp/7y41P2FlQP7a2q2KFGvYbXRMwFk8SUFmFXGL4QNr+W3GbpByEjJ05A/dWOK8CflDu
         1qfFBWXh5XFGqZx/5vMvn3RbKsdFUzpoqzKwtfJSeVvH0E2z4vhwFf1Yl28Cqg8v96Ld
         lCdSLYfW43JbSx8/9deWyTEp2S1mUpIxXBaLFn6NqoLl/CGNiKplf8M8o1dM5i53CeUb
         aSpg==
X-Gm-Message-State: AOJu0YxXI/eYSc5lPkcXu4bz6vmy3QiJJ569hvfUTIcmS5N7YdE0kyFx
	KZrDRs5dtYrksh164dPSbXxEjm22p/QPSW2rIbnIuAsmuQ94emGFSY6yUQ==
X-Google-Smtp-Source: AGHT+IGNZKpdIwK9kl8U9OZUJc28WvzXzxX9jWpDc3lWhOJlGB3sritPGv9kv+BmA0MMNUH3OUmVqg==
X-Received: by 2002:a0d:ca49:0:b0:61a:d372:8767 with SMTP id m70-20020a0dca49000000b0061ad3728767mr6740991ywd.51.1713313516720;
        Tue, 16 Apr 2024 17:25:16 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:2bf6:8300:76f:3cae])
        by smtp.gmail.com with ESMTPSA id z79-20020a814c52000000b00617e3ac0deesm2792555ywa.86.2024.04.16.17.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 17:25:16 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/2] Update a struct_ops link through a pinned path
Date: Tue, 16 Apr 2024 17:25:11 -0700
Message-Id: <20240417002513.1534535-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Applications already have the ability to update a struct_ops link with
another struct_ops map. However, they were unable to open pinned paths
of the links. This implies that updating a link through its pinned
paths was not feasible. By allowing the "open" operator on pinned
paths, applications can pin a struct_ops link and update the link
through the pinned path later.

Kui-Feng Lee (2):
  bpf: enable the "open" operator on a pinned path of a struct_osp link.
  selftests/bpf: open a pinned path of a struct_ops link.

 include/linux/bpf.h                           |  4 ++
 kernel/bpf/bpf_struct_ops.c                   | 10 ++++
 kernel/bpf/inode.c                            | 11 +++-
 kernel/bpf/syscall.c                          | 14 ++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  6 ++
 .../bpf/prog_tests/test_struct_ops_module.c   | 56 +++++++++++++++++++
 6 files changed, 97 insertions(+), 4 deletions(-)

-- 
2.34.1


