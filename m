Return-Path: <bpf+bounces-22178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AAC858634
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 20:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A871282F23
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 19:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80F1369A9;
	Fri, 16 Feb 2024 19:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ1Bwt4p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834811350C7
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 19:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112083; cv=none; b=Wg3nv8uu2RpTgRpirbzSgg+BNMmzORveTuCzQrfDHGvjvhHSRXK/2vJH5418mD25gZ3tWlV031JJYA1Wls64xRtmaPhCLHmMpM3LR9qNbTi5BMkyqFmIjaQHdPyuJZMgpqbZb2BxXdTY4KngCyEGFvpdPjkIrD1JodR/qNFLMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112083; c=relaxed/simple;
	bh=mE/+65aEPwvYlqTlMEPL4WseyABVe6B+aOJ/9TBqx+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QftTC4FBVJmU7+nKTWEBizQ/ArNDX0be6B4Ew/O65tsj6n2skty/ssQ9YjJkwBUkBfGD0Mh5Bq8SBcKDigIZHdxPBmSSM6mJVwVzhrU3dMmalx4zZzLkRF/z9uFw96ORqLfJ5Ue3BAxZfzzFE8286/hufThzaIEoaJYseYr5WsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ1Bwt4p; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60495209415so23746467b3.3
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 11:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708112080; x=1708716880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ra0cr0vr1EVCp/4JcNJQOsIOV+sBvwMMb5PQuJLIRfY=;
        b=fZ1Bwt4pRHHoXIG729ve50nNuxe6y7EMxooH3PpUfwD1XDe4GH6xdkWtqs3okfE9tE
         oz5q4cqTbuc/N/woQIflk02sfyn34C11wR+Ep6J4oKL6X4trFIXZTVpC+frzM8wDrZkJ
         gR8T1sR55+UTKPKytmpYJlKF3B4Chpqk9l2pwcWIFZQ4Q9Sbx/7d2N4zOcELko2iriza
         yRlHij9b/WaaNo7IDf5N5g9mbqW89VBBsF1BmQhpjDfOCR/mCF6FGU9ff9TethYbUwXa
         GoWxSRwkGcWSFsIrw4v9PnrpJuoVyuG7MlQgEj7HpAqdrI67jA4CzmGnXZs0rE7Of0La
         +BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708112080; x=1708716880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ra0cr0vr1EVCp/4JcNJQOsIOV+sBvwMMb5PQuJLIRfY=;
        b=UZcQenCSi6xnSBDu/wwDjsK3RR/Z4CCiGMvy4AuyK76LSNsaMymUw2aJXGfDmEAuQ2
         YA289fL3rfZlRm11EYW65/V03FKbOx1tJ/jlnshPbEFc8yRz+sLtFXFU8HY8UjBvl5k/
         LH/5ER+L7lMjiEqusTg4QijW//B88ghx9EZdFov4xl5qF20xQqFzmJG7b8ZJ9Eudf/Hn
         sESpIG6FF2GUqYO690BDujhihQmcQ1RI61iOiktX5bcPLSfvZZqXp4EnvmomiC3dVIax
         BDMlfBWU9hhvFKcvT2eBaIqDjBSxYh1GM8Qltm5IQNNSES3FqrBFCDqseHiADdPYQuuf
         Xg7w==
X-Gm-Message-State: AOJu0YyOPL+b9FlVc8aAbYjfNrs3E71ifXR20JeKm3UQz5xoUpt1knb9
	B76W2C9cHNUn+Q0pHCxJBnPQT5yD5QCwo3pbHWA87Kg9E2UpNk+S4Wqt3ydh
X-Google-Smtp-Source: AGHT+IHhANgkesTnF3StD3RwYLu3wpwGRcZr3inv67kfgPR8PKa14xeNuEDI601DtKeiQvM/KLenxQ==
X-Received: by 2002:a81:9a47:0:b0:604:999a:9c6d with SMTP id r68-20020a819a47000000b00604999a9c6dmr5148849ywg.24.1708112078694;
        Fri, 16 Feb 2024 11:34:38 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6477:3a7d:9823:f253])
        by smtp.gmail.com with ESMTPSA id i126-20020a0df884000000b00607c2ab443dsm470785ywf.130.2024.02.16.11.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:34:38 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v3 0/3] Check cfi_stubs before registering a struct_ops type.
Date: Fri, 16 Feb 2024 11:34:31 -0800
Message-Id: <20240216193434.735874-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Recently, cfi_stubs were introduced. However, existing struct_ops
types that are not in the upstream may not be aware of this, resulting
in kernel crashes. By rejecting struct_ops types that do not provide
cfi_stubs properly during registration, these crashes can be avoided.

---
Changes from v2:

 - Add a stub function for get_info of struct tcp_congestion_ops.

Changes from v1:

 - Check *(void **)(cfi_stubs + moff) to make sure stub functions are
   provided for every operator.

 - Add a test case to ensure that struct_ops rejects incomplete
   cfi_stub.

v2: https://lore.kernel.org/all/20240216020350.2061373-1-thinker.li@gmail.com/
v1: https://lore.kernel.org/all/20240215022401.1882010-1-thinker.li@gmail.com/

Kui-Feng Lee (3):
  x86/cfi,bpf: Add a stub function for get_info of struct
    tcp_congestion_ops.
  bpf: Check cfi_stubs before registering a struct_ops type.
  selftests/bpf: Test case for lacking CFI stub functions.

 kernel/bpf/bpf_struct_ops.c                   | 14 +++
 net/ipv4/bpf_tcp_ca.c                         |  7 ++
 tools/testing/selftests/bpf/Makefile          | 10 +-
 .../selftests/bpf/bpf_test_no_cfi/Makefile    | 19 ++++
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c     | 93 +++++++++++++++++++
 .../bpf/prog_tests/test_struct_ops_no_cfi.c   | 31 +++++++
 tools/testing/selftests/bpf/testing_helpers.c |  4 +-
 tools/testing/selftests/bpf/testing_helpers.h |  2 +
 8 files changed, 177 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c

-- 
2.34.1


