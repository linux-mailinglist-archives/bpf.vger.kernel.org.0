Return-Path: <bpf+bounces-60461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D4BAD7138
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 15:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E95170CEE
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FC423C511;
	Thu, 12 Jun 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmvGWt9P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C8023BCF5
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733728; cv=none; b=K2+b5cnuBJ/+wfltD+wz6eg3IOLegjUQunB1ad1fVbFZfdoenPwJc7QpEBPgtaJLXzwdS1rQGg8fr7NXTji31qO0jKqFCVu4ry8w2tqt/KeFe08gXgzRnCaE5esVV/HDNZnc4bl/HF6JVwH+Xrz2giGgl9l2nJX4JD/gmtdYTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733728; c=relaxed/simple;
	bh=yLVypVhh/tGP0dVHpbcu5Hg8W4J72hgpgurLOGtTQNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uo3XsocEHO4NRDK319vTRyV8V9Wt22DMhNsAoTus7VaibMXW346ktE2lMptgYGClD9/+BU4hy3f04um/R2VdRTNzEpu8ba7naYHVHzSUIYwRCYEgv2XRtdDxWaGWR3ZQ/D3ZLq5J+qvzmYY7XrPLRrKndncRhqi1alO+Cxq1V7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmvGWt9P; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-747c2cc3419so802857b3a.2
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 06:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749733725; x=1750338525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLaq37yZgf2C6K37TLzwMFUroHsCkaH7B0Ba83oOMyE=;
        b=PmvGWt9P23mKoBqhlFp7y1uVyfy/Sn5Civ499oHvdX2jeE34VQj9MtZ+xXNZuAM2vb
         T1nkmiDbZmEAS2JNWgBjqFyIKOWjdlmqgnAx2O1fWbn9q32+QpbqEanGYotc0pW3LHwa
         1up2Ydb+vSv+xITg0TVjh8ChBSWV0OVl2bHj3mxGZS6QsXvI9PQwaZHlUrbbQJWY0qCU
         s8rcNh1BHWtMwo4iSamWQN2wNYEHZbSbUcKnHEUOpJM/fu/rk1W3iIritdq6UdplsWJD
         Q96qqKG7hKozjeBYxV8BXUh3EXNAecuc8acsBHJWQUlsjoLezOz4NuzYeum/IaST6X4K
         zgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749733725; x=1750338525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLaq37yZgf2C6K37TLzwMFUroHsCkaH7B0Ba83oOMyE=;
        b=LnTuuBclryioDqkDIH8yoRbr/t8FZZjTVWy96D+mSm0/RpqjcA8naIWN8n8L4G1P0d
         JHuzLE3aM29nkovzv/4mpgsv0Zwlnnv3qIsjT2Y/4NEZzAKA6XvlAXhOwENPQ7toDPIk
         tSuW5S+p62S5xbOtFlrrQNqw3FG8Z/gIVEFqC+9+psMASZgFs/Y65DrdeZyp7ghchbMd
         bpVywJ0Y4ochWJWgbVvCUcbmDKFGjEtaS9eaOjo6hx++W4meqpbsbcdXK9Hx9N93nxU+
         7MP5IbProLvQ/KRzn2DU7vY4d0cKzW5GKpubQetm7aRSJ23VF1+5HaTDVb+LUJeT1fJN
         2kUw==
X-Gm-Message-State: AOJu0YzbNu7IRhppKFgVXnT8njsQocLPOgFSNDG2/zhEcTGVcE7Dp0B/
	qTRs5jsxFsFoqXbpfM8lO3TH3BQ9DSQDPJZrn7hg7fUx6fxMxqrUC3Wa97Fs6/R0VoU=
X-Gm-Gg: ASbGncuSave51TxSSaJrrlTmiFKZ1U5nJJwX89t9P9lOHUFMCrrCoy3e5TPFFIRikEv
	eBWXzGjyC1/+ZB5X4l+eM+GHkC00va2iRl7e7RURG84oGkk4webDyl/XpVxWJj6msIm1bL3F8Uh
	vmJhgg7lNxBAP14vJHDVYkBTjtaqOXjv1HVqvxZ1oPbPNQDT/bSc3YJlHfXXuHAXIG07zDejxo9
	db5/a7zwuWa9/U5n7UwzvS34H5cabtSS0+lgXEfKpYs8SMCmb843PXmiZ7o1fVWDw5amQicGnBO
	bAUnlYVOxJ8DGBdIg3eSaLkRliVKDjoxCVtB34QexObRrWpn4MS6jm+/Ww==
X-Google-Smtp-Source: AGHT+IEG8g3lyt/KPIfiKXq5NjcctFaTuzSZnHl5SCjQvr89JCWIkoKjdkXSsiz/9mNqtUQtJvRcdQ==
X-Received: by 2002:a05:6a00:1910:b0:740:4fd8:a2bc with SMTP id d2e1a72fcca58-7487bfe8d90mr4058574b3a.5.1749733725422;
        Thu, 12 Jun 2025 06:08:45 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748809d2b85sm1407445b3a.98.2025.06.12.06.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 06:08:44 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/2] veristat: memory accounting for bpf programs
Date: Thu, 12 Jun 2025 06:08:33 -0700
Message-ID: <20250612130835.2478649-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When working on the verifier, it is sometimes interesting to know how a
particular change affects memory consumption. This patch-set modifies
veristat to provide such information. As a collateral, kernel needs an
update to make allocations reachable from BPF program load accountable
in memcg statistics.

Here is a sample output:

  Program          Peak states  Peak memory (MiB)
  ---------------  -----------  -----------------
  lavd_select_cpu         2153                 43
  lavd_enqueue            1982                 41
  lavd_dispatch           3480                 28

Technically, this is implemented by creating and entering a new cgroup
at the start of veristat execution. The difference between values from
cgroup "memory.peak" file before and after bpf_object__load() is used
as a metric.

To minimize measurements jitter data is collected in megabytes.

Changelog:
v1: https://lore.kernel.org/bpf/20250605230609.1444980-1-eddyz87@gmail.com/
v1 -> v2:
- a single cgroup, created at the beginning of execution, is now used
  for measurements (Andrii, Mykyta);
- cgroup namespace is not created, as it turned out to be useless
  (Andrii);
- veristat no longer mounts cgroup fs or changes subtree_control,
  instead it looks for an existing mount point and reports an error if
  memory.peak file can't be opened (Andrii, Alexei);
- if 'mem_peak' statistics is not enabled, veristat skips cgroup
  setup;
- code sharing with cgroup_helpers.c was considered but was decided
  against to simplify veristat github sync.

Eduard Zingerman (2):
  bpf: include verifier memory allocations in memcg statistics
  veristat: memory accounting for bpf programs

 kernel/bpf/btf.c                       |  15 +-
 kernel/bpf/verifier.c                  |  63 +++---
 tools/testing/selftests/bpf/veristat.c | 266 ++++++++++++++++++++++++-
 3 files changed, 299 insertions(+), 45 deletions(-)

-- 
2.48.1


