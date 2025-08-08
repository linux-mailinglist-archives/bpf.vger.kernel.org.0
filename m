Return-Path: <bpf+bounces-65276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB863B1ED80
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 18:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2283A797B
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E54C2882D8;
	Fri,  8 Aug 2025 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhRzkcmC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CDB285CB6
	for <bpf@vger.kernel.org>; Fri,  8 Aug 2025 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754672117; cv=none; b=EmCbY1nYc5P0d8qW09p4TM0BdxVKE2MJ0ijwYrLrTxYnlWQF69y22ReqZKJN6E5LzLUlW6NIzwFkrMZT/iPYNGw0+XlX546YZNmf91Dx9+HdZbUOGJfhUdz649QpGZ1Qkjsr3bhvpNeNMo45T+JQ+nsMHFnk1f6erG3iy7IEw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754672117; c=relaxed/simple;
	bh=GYgwVal4v4omFU76dLFzfEp2glPvEN8Z5ww8svHnDl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=upwRE8MurwiGyP7VDgeB/1erVul6EGKUaFDuaoCltE7TdCnP9NaPLOuVaAY6+3my/gBDCakLzT1qjkMjw0TqOurl4RiYEXsX3TMrgPAdzBeXRC8C8NCeE5sOmpxhSLbkQTy1SDDdb4U4MK/hUy3TTsYrJw8AbdGFpt+cZxLApIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhRzkcmC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31ecd1f0e71so2822471a91.3
        for <bpf@vger.kernel.org>; Fri, 08 Aug 2025 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754672116; x=1755276916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BGaC3Er/c4JcdQQjHqnMm+KVMrQKO2I12gxNY/MuN+k=;
        b=fhRzkcmCLjhUj48kIb9EFiDwGNrHU1uV59ngnP9etYyMxDalnkQFBXMKymE4D/R0UO
         lzotyNr2YYlm59zQKI3hrM10RBybdBQUnCvM/mPd/W3aKUPTT9cakDsnIrHQ6C04KuTW
         XCErdeCM+IoPw2X5ajB2k/GqH6tUEGVBeyG9oxnH7ltkh7dO9+kEbIY90IUWPlgY63B7
         SSX3FoW9wDcH5eECW9xZKIaziNAFnWo1/uaKXtfOI5O5jL2cf8c9UE0pvJWVqq6au/N2
         u2O5yc199047v5AUUF+TfWvyaVeS2++r/aK/w+UoUfxmgoCiS7hkdrFEXEwf0CZlAvVO
         8vSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754672116; x=1755276916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGaC3Er/c4JcdQQjHqnMm+KVMrQKO2I12gxNY/MuN+k=;
        b=Ai1rKnqvID4KjfJkWil6Yd0qeWy8VuQ7ZwICk5ubcL9wM4XzBxOuXsP++5noDAdqSX
         sUKAv+OcWu2rYSpn4BeYeprJB7VbJmIUMAQ4HgCDIxFTh2qHABIrZ9gSgbCeFCSiCkRL
         qsgKD9VXCr5TgJs9TZJ2xzGOoS8VPIdkCdTxaxYqxfEHs7583B4QqP9jNN5Vx2we9pvS
         l9fvcs49pcNiWh0WlxOzlt2roghg9OGjqmljrXPmri67SLFhlNbsVryPrtRkp3ywta7r
         iR1xAkQZbHZ4eevXm3/uNGIb27mPyMSSCGfL6cJoIPfFe+GrEoaMTgk2Xoz02QYu6U0B
         lSog==
X-Gm-Message-State: AOJu0Yw1p0pIL1b021vZTalHu9VyH+wCZ7xWkmxizVEJ16D+Q4moV40L
	GhIClHAfeObssKcrWiicbqKajUP22fmpTpe9duVnULBKGsYy0EvTWrzJ
X-Gm-Gg: ASbGncsGq70thbm1XX0/2LVrV68+Fg5KFydmYp2v3jJnsRnp81nl78PeP929kURH695
	5olUlvRb52NjwrigozyCpUQjsV8K1yi5sZk7ryDCXaCjfYXMz7QVzBnDN50J7PN4ThSIrZmtLG/
	doTpIQ6BfpGi+6lsvx0w6koPV93CHAxF8VgAUMYXOLXA4LRVSsjrcRMdg9qBczA5BddJpMrAfmZ
	U+8OY9kEfzUODMRAacre0bD359NUcDonVY6/6SPPaItOJlhxanhanirmViLAlCy8p7Y9Fzgyabt
	dgPJmgpuXCqP9nUBa2FvDFrM5KEc6v9EDeNZz8U3AsML0d3oCLTcne1IKMF27sFf4vhuUOAMRLj
	F37WD9JJ3G93ccGiiw5PjB/4i3xhiczGsNk+NJsByEd66HwE+B1PUMp8pXqh4pHszlee5adNnSg
	==
X-Google-Smtp-Source: AGHT+IHaTn2btV2X9VPBpGnA/m5fgSHqW9yr3HpRFpeL1zn76dPGsK1J/9ouoHtkuEXPgnfRHIkjcA==
X-Received: by 2002:a17:90b:224e:b0:321:2b8a:4304 with SMTP id 98e67ed59e1d1-321839ec183mr5766082a91.10.1754672115515;
        Fri, 08 Aug 2025 09:55:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7bc91dsm18245391a12.19.2025.08.08.09.55.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 08 Aug 2025 09:55:14 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 6.17-rc1
Date: Fri,  8 Aug 2025 09:55:13 -0700
Message-Id: <20250808165513.23952-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit a6923c06a3b2e2c534ae28c53a7531e76cc95cfa:

  Merge tag 'bpf-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2025-08-01 17:13:26 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 0e260fc798bfef6b0dd24627afa01879f901e23e:

  Merge branch 'perf-s390-regression-move-uid-filtering-to-bpf-filters' (2025-08-07 09:04:34 -0700)

----------------------------------------------------------------
- Fix memory leak of bpf_scc_info objects (Eduard Zingerman)

- Fix a regression in the 'perf' tool caused by moving UID
  filtering to BPF (Ilya Leoshkevich)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'perf-s390-regression-move-uid-filtering-to-bpf-filters'

Eduard Zingerman (1):
      bpf: Fix memory leak of bpf_scc_info objects

Ilya Leoshkevich (2):
      libbpf: Add the ability to suppress perf event enablement
      perf bpf-filter: Enable events manually

 kernel/bpf/verifier.c        |  3 +++
 tools/lib/bpf/libbpf.c       | 13 ++++++++-----
 tools/lib/bpf/libbpf.h       |  4 +++-
 tools/perf/util/bpf-filter.c |  5 ++++-
 4 files changed, 18 insertions(+), 7 deletions(-)

