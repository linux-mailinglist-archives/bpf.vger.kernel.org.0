Return-Path: <bpf+bounces-59693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA4DACE731
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 01:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A54B3A9905
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 23:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCC62741A0;
	Wed,  4 Jun 2025 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB3V5mR6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610BE4C98
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749079833; cv=none; b=CN1tjk+W08Y6deM+H0ebth4ZGN1p79T6XmS9g5DzQmi2OtL64swnX8q9BxANn+RweDXA5pPVPQZ6tQ+Kqs8zn7EUMz3FD1Xbl+eEgc6pr9zyZEZj8GNKpB9BjjM4bsinlkuJfP35/iTDFeutK1wchrEtoFV4zq1Hjsise/aalIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749079833; c=relaxed/simple;
	bh=ECD+eVoOZ3mMD+xgoW2GDXT9mUSkXTccbSsp05ei5G4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t3qDolUZSba2/QZPNxkAhbgR8aXdFrbagTZS9ovJR2VRdhTHSn6au8h3Z0OxXI9+5mz3bK1jvmm+kQqv+M8fkXYT+rGOJHgeBOJJ/8aRFXKB9tA0KKBRP34nCWFdmW3FQBXYu3LoUbx/zSoUervFd3y2fkv9FiwKVJvSJBVhG8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB3V5mR6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso482524b3a.2
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 16:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749079831; x=1749684631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTxqQsBBcDCn9nQ5jgb+HzCDVkmeEWCEZ/mYGqzRnF0=;
        b=iB3V5mR6UoNdy91GjGo4jzR3jt5YTrnC8P+OrZgRxpi9qVm+6GUWXu+cBMmaKUBvZE
         E+4aoE4fK31Z/99LnYoWd9EmwIyR/2XEhKUCnFOhU60ee4NKt+ziPAlmBcx2Iy/Gxhe7
         e/eQSHI9Y9NlXCNq+ub22dhFPjuoDHNM/lvDjAYqiffUWe4C/u2L9XM1pVuFL3lu6CkT
         cPwKeK4FomT8dkIRsMWDU5OqJud+a2O/7a5KzrqjmpbURmxCvaiMt6uR9ar3M9QaIsKR
         vU7757JwDjdy8PBC/slnrqkDQgSw4Kw3PzcsgFx8rPL+5HZdP9dSrsJWjIoQWU+oNO+g
         /tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749079831; x=1749684631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTxqQsBBcDCn9nQ5jgb+HzCDVkmeEWCEZ/mYGqzRnF0=;
        b=BEN4aGyagS+v84xs5fTqMYyGN73I+l4CRZOvVblEIMF4baNBjEFqA5PudgL9lisj7p
         t9pj/eq6ms5BAqoFWNud9CC+GDrVMiffTVsOuvhAEx+Csjuwf5TPDY3NakplNs+wpgRt
         K8LMQgT4+3Tp0O0QZg7Lymbp3QM27FosJ3+FBO9FgoCwYBNcOiPKCKfMXs5YsrKJws/I
         7PdKOchvKWvoTXL/3grWGIWi3m70wAFVm1ZJREeeKUTmM7xfRxUcJTUUydGx2T3AclYB
         cRXj4u1YgfaV0rtgCAS0T4grsXbe/vPHcJzn+sZg6uygRbgRzl7uBZS4wv+DA3dh4vvs
         w+sg==
X-Gm-Message-State: AOJu0YxPC905+dPdpgcrl4VPWIz1V5Pfv8WN2SCPDmgSd63ob/OaQkLK
	pp8JYewvAQpuQhhegEVs9LxgpQPIT/3g3ZGaGvbiIjTDZK1H54qWsEc4eMmQ4Q==
X-Gm-Gg: ASbGncskL3jay8JgyM6MWKe+yQa79RwWw+y38IAQzbBUlRvh8hgo0PSf25RVMtSJvX1
	lRNxYiZT/hoOP1eu927Csp3BcQkW3vHLzb4hdPnqW1ayhD7+r41cyYU+seWG/mbk/WfA3sbZLtW
	OtjtIeOaZHk44zO95rIXuy6HzAtZFlI1RHwNLWYtzZsy1T9S/7x4R9ohfvypORHUZF2qJxWykss
	GlG0rBtuYJjITq8LsSq2Vje0SH96E+KE2aVT2E2Ve5xEb4CHFIlfGpKKh7XafrS/eqMX25ZcUHn
	b1Igi7g1L/ITHQsCElkCxi1Vr5kYtqfATblmlkjajyYm8k8N7f6TOIIbFVibH7rROtkUE+Oz0qF
	zkWQaQTexa5J+MfFgT1tB4A==
X-Google-Smtp-Source: AGHT+IEqseC1OpCvuedqrOSzkN56AGaJd48SNcOuvjADbOf4mPjLpBdGtW16W9c/VJUO2g5fnhVBjg==
X-Received: by 2002:a05:6a00:3d13:b0:742:362c:d2e4 with SMTP id d2e1a72fcca58-7480b226180mr5960483b3a.5.1749079831418;
        Wed, 04 Jun 2025 16:30:31 -0700 (PDT)
Received: from ast-mac.thefacebook.com ([2620:10d:c090:500::5:1fe8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb4ea6sm7976710a12.66.2025.06.04.16.30.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Jun 2025 16:30:30 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 6.16-rc1
Date: Wed,  4 Jun 2025 16:30:28 -0700
Message-Id: <20250604233028.41784-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit bb1556ec94647060c6b52bf434b9fd824724a6f4:

  Merge tag 'linux-watchdog-6.16-rc1' of git://www.linux-watchdog.org/linux-watchdog (2025-06-01 09:01:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to baa39c169dd526cb0186187fc44ec462266efcc6:

  selftests/bpf: Fix selftest btf_tag/btf_type_tag_percpu_vmlinux_helper failure (2025-06-01 13:07:47 -0700)

----------------------------------------------------------------
Two small fixes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Saket Kumar Bhaskar (1):
      selftests/bpf: Fix bpf selftest build error

Yonghong Song (1):
      selftests/bpf: Fix selftest btf_tag/btf_type_tag_percpu_vmlinux_helper failure

 tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c | 6 +++---
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c    | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

