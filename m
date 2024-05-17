Return-Path: <bpf+bounces-29901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F008C7FE6
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 04:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504C71F22549
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 02:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6758828;
	Fri, 17 May 2024 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXoxOEe5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1165A28E6
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913051; cv=none; b=UVp1j+SfsVkBzY3GT58Q3OSJnuRANKVZRZ59jyyWvu1YjrNhf4HBfWaRHtAlpwMhkxZOTVxzrmyxs9uwEEHahXz8w2KS9sEt/FGJsk4VfxN6wNlsq3xnX06z0CkAuOmrMI0Mmp5msHD3jtjkBgPL2iiNV1c8xx7ymutp3zGeApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913051; c=relaxed/simple;
	bh=4Fa3UOFeHArW3+b9yQkG3GDdWGPCX8gGg7VDrQ5CPqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tz/iVOLVyXXMPnfNS5Rm3EyhHQMiP16w10HIXLxSfCmLU2IURGd9Mmrka8lJ1OCidfAb64g0FCsa0RGZoCPNg+4smVSzMpGjFQyABVuH6P1wW796bmuhVdGXasSwKjnmqR018wewFo/enN7DTxdTpoXSvpIiLPh9er50/4qoCRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXoxOEe5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1edf506b216so1306485ad.2
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 19:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715913049; x=1716517849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wpS2pJw+pNgJD/drQuuJhwmftf3UMuD0b1g/AOCUEYU=;
        b=IXoxOEe5e7zsEK56voQqX60llcEksS+QThsFJ5Wc1DIOQcFLmAp71QKSvfwGofYnyt
         dMNs6qRjJ909bdhv0lWGEP1ZC6Nn8xiI41CKFRX/E7m42ZLcNta/Xp+E7fp5wgmhABA4
         PArR/eJvb+3gF+QbtmtDGV6AU0/uhoHtKRQak/Ql5QAxNY1ORNNAPK3P8mBby0hi3bWg
         RzEd6EJKcEgyNysfYtNzDpyFxggQX94c4Bq/9vkh+A2wHHRIsLKU9skgrx2tEUXGUwMF
         tPbICddq0gtyg8spgQFpTGyJqAEmXkHgHBb5bGrzkoWhhSu+J9oU6OF7KRqWL9E/rofL
         HsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715913049; x=1716517849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpS2pJw+pNgJD/drQuuJhwmftf3UMuD0b1g/AOCUEYU=;
        b=TqyETeV19vNsA9fkRH3wgpj7dwhDA5c+sqE1sgs04oNR9a9kg8prmBF8oDJZzJKU5M
         ks7p6Nf3NxW7xdG61jIMSYLuzld/UrWhvLHOO4rKIt6HWj+q8ymgLzGUVwIKwWBkiyhH
         745n2R9Jt/1hgvtxu0G3yxl9JFPq43nJLv0w7ZSIunZO/pKQQiaMdWRvNDwy4uOtgYBg
         8BS3fingACsB70VAp8c8K9vFFu8nXFYbJp0WRNQFixmSi1PAZABNZ32+/0pYf1FmXSgS
         635Dp3d07WT7ktw0m02fbcvBUY12Fq1W6PoMo44TsOY0GaDBTnRvjNeo4fnEO6fx+R8K
         nzbg==
X-Gm-Message-State: AOJu0Yxpvb/CHtcpcoItJQiub82GUnKUdWWfhde94zPKT2jp+hNwdVXo
	t5Nrqpz3tN/c6UEuSYvF7hO7meTWd6PEM0i7wzm0QOgaPzE7mUjj
X-Google-Smtp-Source: AGHT+IGlUEPhBCsT8Fe/mRxEGL2z99XekA6SrtHklZJ+xx/k2Gi0oWDUwIWy0taulRNWAApcGnsatQ==
X-Received: by 2002:a17:902:da8c:b0:1eb:4a72:f468 with SMTP id d9443c01a7336-1ef4416113fmr247636705ad.52.1715913049303;
        Thu, 16 May 2024 19:30:49 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f093824c4dsm41361395ad.282.2024.05.16.19.30.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2024 19:30:48 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v8 bpf-next 0/2] bpf: Add a generic bits iterator
Date: Fri, 17 May 2024 10:30:32 +0800
Message-Id: <20240517023034.48138-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
added for the new bpf_iter_bits functionality. These kfuncs enable the
iteration of the bits from a given address and a given number of bits.

- bpf_iter_bits_new
  Initialize a new bits iterator for a given memory area. Due to the
  limitation of bpf memalloc, the max number of bits to be iterated
  over is (4096 * 8).
- bpf_iter_bits_next
  Get the next bit in a bpf_iter_bits
- bpf_iter_bits_destroy
  Destroy a bpf_iter_bits

The bits iterator can be used in any context and on any address.

Changes:
- v7->v8:
  Refine the interface to avoid dealing with endianness (Andrii)
- v6->v7:
  Fix endianness error for non-long-aligned data (Andrii)
- v5->v6:
  Add positive tests (Andrii)
- v4->v5:
  Simplify test cases (Andrii)
- v3->v4:
  - Fix endianness error on s390x (Andrii)
  - zero-initialize kit->bits_copy and zero out nr_bits (Andrii)
- v2->v3:
  Optimization for u64/u32 mask (Andrii)
- v1->v2:
  Simplify the CPU number verification code to avoid the failure on s390x
  (Eduard)
- bpf: Add bpf_iter_cpumask
  https://lwn.net/Articles/961104/
- bpf: Add new bpf helper bpf_for_each_cpu
  https://lwn.net/Articles/939939/

Yafang Shao (2):
  bpf: Add bits iterator
  selftests/bpf: Add selftest for bits iter

 kernel/bpf/helpers.c                          | 119 ++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_bits_iter.c  | 153 ++++++++++++++++++
 3 files changed, 274 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_iter.c

-- 
2.39.1


