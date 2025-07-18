Return-Path: <bpf+bounces-63693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC93B099CB
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 04:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34331C436D2
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 02:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D1C1A5BBC;
	Fri, 18 Jul 2025 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzmecD9V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC151922DD
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 02:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752805853; cv=none; b=NSfde3/ZoR6NsX41/5or900mnEUl8TBm0yIC97ZP9Hy9VRiNcxJnRuPShiznQOJPiOz9tw8Q2rJ6+9hSfhdDGVSadYxX2OI0A0pvoPpKtafIjCRWZhhu8YLeL/ZLoHt2IYzhE+3Vajf+hOsilDXiYilAKqL1DO1+a248S7ThcnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752805853; c=relaxed/simple;
	bh=o9KwF8vRMG6hwQT/nsEPyd1PTKYW+O8c0Iwz27pkUHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GrIyCgLYuAVlKWXtaOnd5AQpef9mFPBM+0cwfV1p1wnyj5GKeE+qwofAn1hlg1nO5Qle1gCvWRRvyeWQcllv8rsFLfzXGUgs6axs6EovfjUSQC545QXc2cQn2C7ZzTUSfVKE/DGms4sz1IvN35+8xx2q+zk8OQ1sUWyzHLpf6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzmecD9V; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-748e378ba4fso2026003b3a.1
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 19:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752805851; x=1753410651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/0wFwhyUZcBI1Q3XyM0Mizy0G9N256iTuBxZiuRPdI=;
        b=fzmecD9V8mIFN0eDkJd711sPtbJS534PVFUtqROMIhYJrFppFJL1Bo94PipPEIus8R
         JONQqmr7SVwReyCHZ0ov6b78N29AhtN6k2TUFs71e7lu+eHvCAg8eNroUOqnFra/jGU1
         F/FWu615e6dd9EZqgUVa1kZg9YRezTvS+PI4rK3TRFn5bP6B36fky1D5s65T0KTRS037
         twXb72eOZL/tzoiD5tSfsNDYoKaDkfLpfMLqPU4IE7wLaYNKXPRhCORUPsJ5E/awdVG1
         DiuYcgStWh7eSpTRv+imbihuE5WAynsBoC1QdloHB4VHwNaiJkh4KefCO8JUg8yyf7Yy
         hIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752805851; x=1753410651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/0wFwhyUZcBI1Q3XyM0Mizy0G9N256iTuBxZiuRPdI=;
        b=gHp8zSOdtMJf2TFVtyT1xsthDSnK5sr5goJUWZGjT6nYJeE8k+HH5TI+/oYCYdbZGM
         +uz9cvWjOv3M2NCqgv2xQNGcNRMRk2knzzeIxor8sEvwz6Agb2c11MSy+lDRQyOSrBVu
         +8AT62g/nHvgNzWN/AWaruV7DafbzMqZDJWsTo3znClw5+R3vjpjwMvOtsmrljn7BTkM
         rZn5a2z2J2kA3Vy0SULsh5TNX40JtGYbWNlItKLefnuCEPpBf7gKyCGAdaTm71t1RCc9
         R0eyPAEyw2dG1L4mOlZj1CR/QtObLY9+zx8390MtvXll0GSdN8e4WNTAC/OYNKoYtZGh
         lJhg==
X-Gm-Message-State: AOJu0YywoJSXUsrwlj5r5gr9EXTHKG40t9y8FSOjeQlKDS5Pems0tHmK
	OefAFwdCT21V2loHE9t9P4kNdyqIwsk6GlN2i/A7xbnZq173jsnrr9lB
X-Gm-Gg: ASbGncvjsCfwoJuu0Pv14L2AePlguyrQ/a0+L9KlNpMxTle+Pi0ISTPB/qRDdS23jMb
	IbxjIeNpPs+HdTUaeYwBwNDFbnI2F0qmFsNmgDamvy5VU5KMFZNK5Cv0vhbdaNsC1TeNBkkSGVW
	sqpea6Gs+v9KEIYQSGPxl47GA8TEbtPL0K6AtIa6E0cGvb9zVCd6zbiFEyE+aT9MtTQoTSZGe33
	8FuRTF13NHoB2mz768EIs2dNhP3U29hKz30z7NUyfm5DxPfkDZe3L4WZQSi9MOP6VKYYnkcuzB5
	6sDZZf5D0wpyVrY33YFkiSZvDIkb+xf2vKgJc/txuhbV17s426+40At/ePaG7TfPtARwWfAxvoD
	tR+RL6vc2qM9MVwhJ/zXRhHdLzN7efQlTCxPvJxIAB8IAmEDN6S/CKyyjzGMBvp4=
X-Google-Smtp-Source: AGHT+IG0C71l553Oh4hsDnrOqJ1T9p0jTqNzo5uzC78ItGDFy3mG68fPRM9d0VJXcAC10FzatRzCCA==
X-Received: by 2002:a05:6a00:847:b0:748:e150:ac77 with SMTP id d2e1a72fcca58-7584b631b94mr6354402b3a.22.1752805850861;
        Thu, 17 Jul 2025 19:30:50 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb155e01sm237618b3a.88.2025.07.17.19.30.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Jul 2025 19:30:50 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 6.16-rc7
Date: Thu, 17 Jul 2025 19:30:48 -0700
Message-Id: <20250718023048.78396-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 66701750d5565c574af42bef0b789ce0203e3071:

  Merge tag 'io_uring-6.16-20250630' of git://git.kernel.dk/linux (2025-06-30 16:32:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 0238c45fbbf8228f52aa4642f0cdc21c570d1dfe:

  libbpf: Fix handling of BPF arena relocations (2025-07-17 19:17:46 -0700)

----------------------------------------------------------------
- Fix handling of BPF arena relocations (Andrii Nakryiko)

- Fix race in bpf_arch_text_poke() on s390 (Ilya Leoshkevich)

- Fix use of virt_to_phys() on arm64 when mmapping BTF (Lorenz Bauer)

- Reject %p% format string in bprintf-like BPF helpers (Paul Chaignon)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 's390-bpf-fix-bpf_arch_text_poke-with-new_addr-null-again'

Andrii Nakryiko (1):
      libbpf: Fix handling of BPF arena relocations

Ilya Leoshkevich (2):
      s390/bpf: Fix bpf_arch_text_poke() with new_addr == NULL again
      selftests/bpf: Stress test attaching a BPF prog to another BPF prog

Lorenz Bauer (1):
      btf: Fix virt_to_phys() on arm64 when mmapping BTF

Paul Chaignon (2):
      bpf: Reject %p% format string in bprintf-like helpers
      selftests/bpf: Add negative test cases for snprintf

 arch/s390/net/bpf_jit_comp.c                       | 10 +++-
 kernel/bpf/helpers.c                               | 11 +++-
 kernel/bpf/sysfs_btf.c                             |  2 +-
 tools/lib/bpf/libbpf.c                             | 20 ++++---
 .../selftests/bpf/prog_tests/recursive_attach.c    | 67 ++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/snprintf.c  |  2 +
 6 files changed, 100 insertions(+), 12 deletions(-)

