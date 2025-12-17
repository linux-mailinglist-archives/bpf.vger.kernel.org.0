Return-Path: <bpf+bounces-76808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14392CC5E65
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 04:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F730300315C
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 03:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B54285072;
	Wed, 17 Dec 2025 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESf3B24H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77D1A76DE
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 03:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765941994; cv=none; b=GJZNzZzBGDLShmJYbQZuoVq9AauCqetwnLE+G41kWeQQalrI9M8eu6Y6SCWNe0CmR5peD/w3gOLaV0HEQql2/2Pb2lbA+sB5y7MStEywveCcgleMef0F69AqchT4R1rwKtUJ5HYmMcN7rLeQzA6ZEBBeABPXIw6QiVMVvAdHl3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765941994; c=relaxed/simple;
	bh=LHpsNCXL/bOO7gUQ1S1nSG7Px4JIPVzP6GHN69VWN7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ck6h5BEbs9yeuKKQ33Jq9K970/LRKSX2KBNEmi9KwDiPTTRZUEVcgR+85NCfk3vmPq0frZg0H+DHpxBtSV5qbCbxjci/P0MvNSVw7wSf9QpJkSKE6KpdiCB4gDhyWUkLans1Bb8NTePt9xMjzApM7MRAbSnKXc5iIakapoD87Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESf3B24H; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed66b5abf7so1596861cf.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765941992; x=1766546792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Vk9SUSPMqpeXO4V0g80Rs4e7ekOb6wqfhBJbRc5PHQ=;
        b=ESf3B24HZqcQfVx8gZNGUdEMt/25Fl7r1tfHXE/yoW7qSsunu5z/atvcpO3bbM6sLB
         rXWBJg5iKzqVy28dUh68nwfwbWUjLajL5YJpaCrIRD8De7jlqDlmCdhP+OxgPgbnz0+X
         w2D4l55Gu+eeVYdhz/waPkQvWvkUYmmw5xDVrip+OAVYUqf8l5xAu4/fpo1vO/GX94Yv
         d4qgPEb45ji5DSFE/Y8NjV+HlUl6TSw77WpDUeUCzBXl+41f+BBArAJfthr8RhyvPulY
         b3lqRXsUGzkHcbx+dw+ylM82+FVLs/4yTKid3jjcwANAR1ApJij2FTk/zAGCsjmulzWv
         rfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765941992; x=1766546792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Vk9SUSPMqpeXO4V0g80Rs4e7ekOb6wqfhBJbRc5PHQ=;
        b=jkjd+FsVGFZmTJGDhkjIcNAqAEhg0ikmIdpIQN1oe8hOVrkxNE8HMo7a1NTUKPRh0P
         BLlFHLcZDzKSyrFA5m/fe73tGqwLThN2e/msz5v1kx4Wb7ZldQOcxoZqRPKFm/QEjzYe
         qR2SjCb+KL7+8qE9ZV/Xg3Bipdl6SbiWHzuqUk4yehjxWhuZclOB+rgJAXa1kRPBy8+c
         avhNtNNEflzfpoLeEd8M19S2yMOyhsNfeKqCeKRr2ByHc15BeJqYRgVzxTPZqR6TFuaQ
         1JH02rzqdoBSfTf/M2xzijijEMqJuiLssrYgZCrunA7p97wst+jTllUp3BCXBOFcZaH1
         XISQ==
X-Gm-Message-State: AOJu0YyzUmRoaRAYSFfbbIfSTMVry3Jf2eW3gjgniYwu//U1ZvK/FCET
	ofzYIilROdCJoIbcPTHo+nVcNhn7AExG+xv0dJHGLzFmjYkBr0LRdo0MZYbcEg==
X-Gm-Gg: AY/fxX4XXqViC3iFksLN5/NgBodFP7snYo2jnV2rg3SURpRhsAM49YLKr0R45yHkdy+
	iOy1O+puvhoRT2dhEdmORIcoQJ35eTmwGpMqaMzOxxGv6Yz6XQlmC0zOlzHaeSGuNLPmvl8fI5A
	+MAjpdx6VEks2f6x8IH/tRpnHck/Wq0ugdt2L6I+pXluCPkTqfFCIK75pzKjL1kL8W1BLs0mRZx
	0d8gLOsV4Id23laoiyqgdYLU3qpBvBgFnzC4mLUfoOBEt2QpX6wxSbGbTtRoW7zPD6mgBLC7gPZ
	p0Rj+eeK2whE3qwRtfUQONcQTEEDux6m3BjUSMkO8QRsLu8/PikY7oD+tpIzc6dbe+yGeZAhi1n
	K5+2RfX+zSdcW3YsA63X+T8eHikcMQlX/kSeP9dZuMkNOh6PGJrkYRYbKJj8JPjWQWF9G7tCS8N
	UUO/1Bwve30QIkl4eOANFCRjcukYZu7aUEUJDpNNzoI/dppWGX7eqJKlvsMgEZ
X-Google-Smtp-Source: AGHT+IENgctDhJxEQNYVjK/r0BvGCi6u1c6Qx8uMbHHqsv6Wi52gLm1bHHz2JYBgpfKTfWXb1Kt1uw==
X-Received: by 2002:a05:6a00:2884:b0:781:1110:f175 with SMTP id d2e1a72fcca58-7f667e16c85mr15887547b3a.14.1765935441801;
        Tue, 16 Dec 2025 17:37:21 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcb8f106fdsm843724b3a.19.2025.12.16.17.37.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Dec 2025 17:37:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 6.19-rc2
Date: Tue, 16 Dec 2025 17:37:19 -0800
Message-ID: <20251217013719.85504-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88:

  Merge tag 'net-next-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-12-03 17:24:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 1d528e794f3db5d32279123a89957c44c4406a09:

  Merge branch 'bpf-fix-bpf_d_path-helper-prototype' (2025-12-10 01:36:26 -0800)

----------------------------------------------------------------
- Fix BPF builds due to -fms-extensions. selftests (Alexei Starovoitov),
  bpftool (Quentin Monnet).

- Fix build of net/smc when CONFIG_BPF_SYSCALL=y, but CONFIG_BPF_JIT=n
  (Geert Uytterhoeven)

- Fix livepatch/BPF interaction and support reliable unwinding through
  BPF stack frames (Josh Poimboeuf)

- Do not audit capability check in arm64 JIT (Ondrej Mosnacek)

- Fix truncated dmabuf BPF iterator reads (T.J. Mercier)

- Fix verifier assumptions of bpf_d_path's output buffer (Shuran Liu)

- Fix warnings in libbpf when built with -Wdiscarded-qualifiers under C23
  (Mikhail Gavrilov)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (3):
      selftests/bpf: Add -fms-extensions to bpf build flags
      Merge branch 'bpf-x86-unwind-orc-support-reliable-unwinding-through-bpf-stack-frames'
      Merge branch 'bpf-fix-bpf_d_path-helper-prototype'

Geert Uytterhoeven (1):
      net: smc: SMC_HS_CTRL_BPF should depend on BPF_JIT

Josh Poimboeuf (2):
      bpf: Add bpf_has_frame_pointer()
      x86/unwind/orc: Support reliable unwinding through BPF stack frames

Mikhail Gavrilov (1):
      libbpf: Fix -Wdiscarded-qualifiers under C23

Ondrej Mosnacek (1):
      bpf, arm64: Do not audit capability check in do_jit()

Quentin Monnet (1):
      bpftool: Fix build warnings due to MS extensions

Shuran Liu (2):
      bpf: Fix verifier assumptions of bpf_d_path's output buffer
      selftests/bpf: add regression test for bpf_d_path()

T.J. Mercier (2):
      bpf: Fix truncated dmabuf iterator reads
      selftests/bpf: Add test for truncated dmabuf_iter reads

 arch/arm64/net/bpf_jit_comp.c                      |  2 +-
 arch/x86/kernel/unwind_orc.c                       | 39 +++++++---
 arch/x86/net/bpf_jit_comp.c                        | 12 +++
 include/linux/bpf.h                                |  3 +
 kernel/bpf/core.c                                  | 16 ++++
 kernel/bpf/dmabuf_iter.c                           | 56 ++++++++++++--
 kernel/trace/bpf_trace.c                           |  2 +-
 net/smc/Kconfig                                    |  4 +-
 tools/bpf/bpftool/Makefile                         |  2 +
 tools/lib/bpf/libbpf.c                             |  7 +-
 tools/testing/selftests/bpf/Makefile               |  2 +
 tools/testing/selftests/bpf/prog_tests/d_path.c    | 89 +++++++++++++++++-----
 .../testing/selftests/bpf/prog_tests/dmabuf_iter.c | 47 ++++++++++--
 tools/testing/selftests/bpf/progs/test_d_path.c    | 23 ++++++
 14 files changed, 256 insertions(+), 48 deletions(-)

