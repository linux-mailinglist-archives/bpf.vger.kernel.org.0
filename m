Return-Path: <bpf+bounces-53398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A801A50D1F
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A023A966F
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 21:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F892566DB;
	Wed,  5 Mar 2025 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="W6k4M6yD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ED91A5BB2
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209168; cv=none; b=cRBQkdqJ3ZLAR+RUYtRSMuiw/9H2MpjoGXB0+jHqUy2NR0293nGAk95Jt5XGgD9cZBjimFAcFsXvRJOEQB2l3CeIMsHSzIkM2Ei16Y2FVXOp690tpafr/4MvkvBxLQpxuci8pX7a3V2MZudKNzAxRt6ckr/gJiZZsqQ2Rnj/nhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209168; c=relaxed/simple;
	bh=8cgxl6h/4OJkrPKmNXfngR/2mZnj9ySkIPRN2VAgCf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7g4EfmW5xTDoNsaq5v0w84t4Vkcq6UzbyAAHyMYGwahtP0YBY60bi3Rib3AgJRSmUhFIcfNFdJgjMlYrc/CXJ8YvzUrIPR3IiyM+reQEavDhQ7m2ErhrNxm8UN7oUfprYU9y4JvC86Lz/qJNSSQ7pcqT3N4cEpKGn9P0MmGMG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=W6k4M6yD; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e89c11fd8fso112456d6.0
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 13:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741209165; x=1741813965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v9ZqzupBJqgWh4c4fBt8kR8hBipkk9pB46wcDOSAliw=;
        b=W6k4M6yDnZJTitXi5k7UNaPhAr4PjITroFh3SoAa1PVwQvRDhdShW9I5V/lXCY2rAL
         nzvMWPsOKubBmJmcGAYqcPeFGEVm0b2IDyYIgwfX+uUMFT16SF8imSR/FkDJVgEydqwN
         RwZGNbd5tTG0Eoj8S3APzQ8UHgWIJ/f35/xn2fF9yAOQVIkzG3s/x5J/qBSc53yH4eT2
         PPiXym2k+wKotPAViZPAFFVXURfAMYfMqtIN+6cfzqMb6k7eu729lHhQ0pBbUdQWpcgc
         2Vu1sAJtrxE30xvZMwVSd2q23ZuSXMb+/CsLvOAihUjqyTKtDWO60Tvq/4qNYbAHxNWr
         vALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741209165; x=1741813965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9ZqzupBJqgWh4c4fBt8kR8hBipkk9pB46wcDOSAliw=;
        b=C428Tb4A3LtpHTyx8Dtjfh7SYUKFuXRmuVsqsCP/Mn53Fn46HiaTdFMNaHy+/MK9zY
         9B4DvbuG8Pw7w7xqcPq3F4t6A9UJMSDBjQM2Br1LU3jNIlodeAgAKnzQ8q+Fp8pNg2gL
         KksYsAohwM8Gw/myvzdXms4ehm5jxHTsbYEFBCXF6i7KdniWlIFtLKjANvDcgH35zPJu
         OtR5XE3E4HjfaEN5CyCPf/SzV/uBi4HWny0mO9ldJ+Il6F+s8fl1k305IdkiPiU3NAEB
         AO7H4D2WdtCqB2gJgVcDLPX2uXOzr2s+mePO2s0vQ9B/DdFWvH0ZYIrnjp++8flxEkpF
         cQpQ==
X-Gm-Message-State: AOJu0YyDld4HIeSTncD+TNjhqHhKoilusmnabir4LXBAWZlf90Abc6Qq
	iKGn5LfJTiQb1OGPkh2MznSkWZhZ+b54weS0goL7JW1by97emiWi6Od6zxmkH2u7QEIHb/o9rTx
	8y1jEPw==
X-Gm-Gg: ASbGnctLQB7hRk9xnbIW5m/yr2GgCzGQFFgAc8/Fp8TwpnWrCHYfCx1YBTAWSqMzDOV
	BEVMDlSnK7xVFf7IJA1sY1VJCjlhznFZJ0zdzD72gcaAUIlqew1fjPa5/vaUrpSYx5NVTpZ0fc1
	yxolkKg7MJTtUumPnOcAa84Pt6261DjkUWfzdkFOZXg3OnKE/ayBp6rvWA76MMYr4RdbeEiiYXg
	hBxvC3J9ZLU/47itqkHYyv9ikTq4ysNQhQYONO12JPzuAT3VA91Po7J5b5Ug2hs8p5gm7hvRunn
	4gM10qra4OaLUL1QkZ1kAlr1tIiM/KKew5mMubj0Sg==
X-Google-Smtp-Source: AGHT+IHwOJsx9Yjw2GSeGC1q0B86IbZN+l7pVh2QBSsYNQ6ElmnuC6PxqNToJtIdSjXX2CpWZEgSQA==
X-Received: by 2002:a05:6214:11aa:b0:6e8:f2d2:f123 with SMTP id 6a1803df08f44-6e8f2d2f16bmr20615726d6.13.1741209163848;
        Wed, 05 Mar 2025 13:12:43 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474eced9880sm43726851cf.17.2025.03.05.13.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:12:43 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	houtao@huaweicloud.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v4 0/3] bpf: introduce helper for populating bpf_cpumask
Date: Wed,  5 Mar 2025 16:12:32 -0500
Message-ID: <20250305211235.368399-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some BPF programs like scx schedulers have their own internal CPU mask types, 
mask types, which they must transform into struct bpf_cpumask instances
before passing them to scheduling-related kfuncs. There is currently no
way to efficiently populate the bitfield of a bpf_cpumask from BPF memory, 
and programs must use multiple bpf_cpumask_[set, clear] calls to do so. 
Introduce a kfunc helper to populate the bitfield of a bpf_cpumask from valid 
BPF memory with a single call.

Changelog :
-----------
v3->v4
v3: https://lore.kernel.org/bpf/20250305161327.203396-1-emil@etsalapatis.com/

	* Removed new tests from tools/selftests/bpf/prog_tests/cpumask.c because
they were being run twice.

Addressed feedback by Alexei Starovoitov:
	* Added missing return value in function kdoc
	* Added an additional patch fixing some missing kdoc fields in
	kernel/bpf/cpumask.c

Addressed feedback by Tejun Heo:
	* Renamed the kfunc to bpf_cpumask_populate to avoid confusion
	w/ bitmap_fill()

v2->v3
v2: https://lore.kernel.org/bpf/20250305021020.1004858-1-emil@etsalapatis.com/

Addressed feedback by Alexei Starovoitov:
	* Added back patch descriptions dropped from v1->v2
	* Elide the alignment check for archs with efficient
	  unaligned accesses

v1->v2
v1: https://lore.kernel.org/bpf/20250228003321.1409285-1-emil@etsalapatis.com/

Addressed feedback by Hou Tao:
	* Add check that the input buffer is aligned to sizeof(long)
	* Adjust input buffer size check to use bitmap_size()
	* Add selftest for checking the bit pattern of the bpf_cpumask
	* Moved all selftests into existing files

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

Emil Tsalapatis (3):
  bpf: add kfunc for populating cpumask bits
  selftests: bpf: add bpf_cpumask_fill selftests
  bpf: fix missing kdoc string fields in cpumask.c

 kernel/bpf/cpumask.c                          |  53 ++++++++
 .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
 .../selftests/bpf/progs/cpumask_success.c     | 114 ++++++++++++++++++
 3 files changed, 205 insertions(+)

-- 
2.47.1


