Return-Path: <bpf+bounces-37793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0CB95A8AE
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 02:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 479FAB2163D
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 00:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E804C8D;
	Thu, 22 Aug 2024 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs2REhsz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5EA4C81
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 00:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724285933; cv=none; b=CxPaGZo4aAdIh8d2oO+V+QhXvc+JD1ddLbCegAGc/Kxcj8aO7HhOIdSukS1P72gM8v6TjOilmiV8/528eJK07kimjd/uwISVHo591z0veq01f1wBv3tRYW0C7LEhBm0ofkKx3VFVC71E+tOHf1eal+jhGIxgQKKCsM9CTntKLYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724285933; c=relaxed/simple;
	bh=I1fWSG5aHLVNj1AQPX+sjPMBRE2n42cayepbOPcBVwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohToBGwui+k2tqEavmVaIAoJ1Kl9oiJNkdXoYTbCf/CZcgfZaPdamca0HTEXh5i/dWvXxsQ8mllqoN4vziRu6QRVj+9jzmKGecBoQC5GxUTGEXO2viY8eqa56FQEMiP7pIXFd3KIPNj+9FRe5xV2P5KcvJnVpJ+glDkckSIegIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hs2REhsz; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7093abb12edso207158a34.3
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 17:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724285930; x=1724890730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vPU2iygLAyxkQKIJPIdLC6ilDp7QxkN2U/rh4SydBGM=;
        b=hs2REhszvC0K7Yb1RcH2pw98oh61YoCLiQ9Q3tPlgLBNLOzsxjeQ3FLLOOWIEbE8Ap
         SulS3QDov6WIre96PqfcFQa5389Uo3YhIYWseu7a1b7gofzAFVzaPonUhcQ20oyhxb7x
         Za0UVQQhr2vSJ55ER9gLwPxasIndH8DY1XWrh6FkFFlVvbJ+s3Lj9qevNfkXHyhVCAcU
         yxKJzOOFa8VF3cINKtoW2VZLCxb1LWjS6pUH8VDyI2ZWP0HRj8wve9mcgGIJOq0GxyNM
         q33U20NYaMohTChSrdilsCskzJDV7TJmrh7mzjK9Lf6c2nHFBX2j+E+Ga9WHNFbLK533
         QT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724285930; x=1724890730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPU2iygLAyxkQKIJPIdLC6ilDp7QxkN2U/rh4SydBGM=;
        b=hFG9KyBFTpdXqgL+tgRBXSylGF2fWjvv/DT9rjvUSAqupah9F559OPP3Qb/KaHfdeI
         1fWutVxumBiN6/eQrTTgbfjrCt0bqBVX8RlrhLGCCSZumrp5cCTCSBxdEl3d9xAFZ0pj
         bsLy2BJbMFLmXwOw0f6zX2Er2mNdRCs6rRwll0EOC7AFkWG6vijxlTAaqnKBGNB/VxvO
         xdh20xqCaxW7Qi5+XZpJ+jy+Ng1rxs1iUSgadP0XhfqGmm7F0VOk6J3JTaanQ5ZTdV0N
         A4cSrVrfAFbfqK0KzbZ62KNq+4KCm94s50FIIF3+fQaAXp6ZJcSYES/kpUlqlxvmUzkO
         Vsfg==
X-Gm-Message-State: AOJu0YzJkFHgaN8hxK2ht0mjZZN1Jq7zveQp+htmEnv65a9aRplNzpdh
	XkojMGfIeRFmZkVd0cf/MOqpgtshK2p25E3KDd9n0wsUroPJoNp+er8r5hPD
X-Google-Smtp-Source: AGHT+IGrEFCBVfoeon82aR5y7/IlG0ad/yWMrnHxxWnm9xzEqoEpVfJ5gZWHAx5r/Jx6tpr/7lan1Q==
X-Received: by 2002:a05:6830:2783:b0:703:7842:6c00 with SMTP id 46e09a7af769-70df86ff0e1mr4582609a34.15.1724285930146;
        Wed, 21 Aug 2024 17:18:50 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143424e145sm231448b3a.55.2024.08.21.17.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:18:49 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	cnitlrt@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/2] bpf: fix null pointer access for malformed BPF_CORE_TYPE_ID_LOCAL relos
Date: Wed, 21 Aug 2024 17:18:35 -0700
Message-ID: <20240822001837.2715909-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Liu RuiTong reported an in-kernel null pointer derefence when
processing BPF_CORE_TYPE_ID_LOCAL relocations referencing non-existing
BTF types. Fix this by adding proper id checks.

Changes v1->v2:
- moved check from bpf_core_calc_relo_insn() to bpf_core_apply()
  now both in kernel and in libbpf relocation type id is guaranteed
  to exist when bpf_core_calc_relo_insn() is called;
- added a test case.

v1: https://lore.kernel.org/bpf/20240821164620.1056362-1-eddyz87@gmail.com/

Eduard Zingerman (2):
  bpf: correctly handle malformed BPF_CORE_TYPE_ID_LOCAL relos
  selftests/bpf: test for malformed BPF_CORE_TYPE_ID_LOCAL relocation

 kernel/bpf/btf.c                              |   8 ++
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 124 ++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c

-- 
2.45.2


