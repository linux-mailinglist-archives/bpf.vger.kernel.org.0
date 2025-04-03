Return-Path: <bpf+bounces-55236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E3EA7A6D9
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 17:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106E9179FC9
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 15:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35279250C19;
	Thu,  3 Apr 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4A3d11C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B363250BE5
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693931; cv=none; b=N7WAkIqdJ+iYT0koWMtyWDhFgOcM1yPuRXWEjzZovTFh3CXMPC7fqYCMeKxxAUGjyifYmbWiWRDzd4K602SIZBE35PDlds2GYrkRqTss0sQ2uuz7B1K07+yh9gBOhF9wv/2tQOqA0vCWQskdeCqEMAa2KUi3g7aBJd6H9PUKXPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693931; c=relaxed/simple;
	bh=R3DV8qor46XE6G7aJ2rO+4h8JczN81QqkEEnWqmnZFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GnOUeo8xq4lPeemMCezKxhwyhuj+4uKH8O7b/Pm/sr6xvwbd3SVFcJLcwQghMdPUyfirbN86aBwQ/0hSUgfahn25SCYE5U7YicffaChwqu/NvU3cVN6i3y6uCkRmIUN6lc9GWhb5C5g9d9bH+1G7J03R3IDWX20wDEe8/PWiPsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4A3d11C; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223f4c06e9fso10353445ad.1
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 08:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743693929; x=1744298729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sDWSzP1fwO8CMbczcHrMTEm2k/p/7fR9zVasBx4I2IU=;
        b=c4A3d11C5KZbtWpLn5Y5sv0oip+ithEVD/g72jUhRrsV2tfeAT99VWkAhB1mLIaXMQ
         xiMVRSXVBlLRcIEFCCjm4Px/O+lJ0swi1mWVj6wVrZ7MeusBUs9ta/0rAR/2fCD+Vxgp
         E9kGKHZibwfIvvmToUyLsKIz8BIdTt4zo32o7udt8cbIfYE8i9514LGP8l7RF547K0OV
         wEoqcI1o9OAlO0Gex9vDwKo7BdAEWaJFF3N9ez1cD2BaMxRy10HkFNJyEcC5axEeLvjy
         T7FpIUinol0cODEsp/Bm7JpqqmyBorlgfo1FpHUIxtuf1DxILz77aNi4img53hBH5gHg
         QVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743693929; x=1744298729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDWSzP1fwO8CMbczcHrMTEm2k/p/7fR9zVasBx4I2IU=;
        b=PsOMmVP6JDO1P6LbzekOEiBpYzrSI+rV7Osd6VOnjkq2HqX2DuKDPQgchFtn94HQfP
         MG4x3ot1Fm2GQjR+XwrS3/4djKsBAXBeY26EhYhuDQyttjvW/yDflTOTcIjhct707agM
         U0si0didynGffDWRL0Qn1ZTPA0w8WJuFnwY5Ms/NYvcDItSnZ0WN1m8MmUnNSLl1Ez9u
         vDY/URVeHrpUss6iI8ecMISt5RDNnZtzBZCcVcb4kguGYo2X1x8gfKRMVRmZ7wfjX9rM
         ttR+7HNvRPSUCTsWLn7RAi3Re9cwRAxih6cOASX5eO4A6BuuTy3v6Wph1GokX7xCAlVt
         YDcQ==
X-Gm-Message-State: AOJu0YzjsPAHowEgM+mDvs4ONYYN3KDgvzDv4Shj/WUUivuIExn7KIbJ
	lVUxWHLpADLsu8+4/OoR4QUClBStCAtBZ+3nPz2NEksvSibXEQwps51WTA==
X-Gm-Gg: ASbGncvSuTVELtE67iKqHVZ1+K9wrfg2YVqcJhHA5Jl+97sz9cwPjAleR7wO3+XfO/U
	ZJu4drQnx5W7ctwcz826FZoIVk3l0PdluYhxywWo9/j1avBTP+CCZeQWUlHluk6mS3NFg8ncX37
	BG5rOVhl4/12bHQrjAHlYfitnlnWoQkC7zxdHqStvENlyH0WIYR5fY2k3PdK/0IXYRxDQG5aGOV
	ImKK3aDmUtQP6rYpfLgBSbfCiWlLmhgTj1yeawWTEH3o6KHLVtiOj5RYP0dLJNSxOS0/Pz8ctz5
	WHGQRGpApsmMuO64FLXC+Af+1mD7RJSBfJKV11RhkOm6L/ONeILvdbtUjHRaMPHTZTQTf/CK3r2
	efKIx
X-Google-Smtp-Source: AGHT+IHld1KdmWNUFM8iqVsqWYWxT61CC/U4a5C+FLqrcyNmkNU/mA6XfDV9+BoQvCG8p7pV/cJHWQ==
X-Received: by 2002:a17:902:ef03:b0:215:44fe:163d with SMTP id d9443c01a7336-229765fefcemr48993545ad.17.1743693929345;
        Thu, 03 Apr 2025 08:25:29 -0700 (PDT)
Received: from ast-mac.thefacebook.com ([2620:10d:c090:500::4:dc5a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e161sm15793865ad.171.2025.04.03.08.25.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Apr 2025 08:25:28 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 6.15-rc1
Date: Thu,  3 Apr 2025 08:25:26 -0700
Message-Id: <20250403152526.9565-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit a1b5bd45d4ee58af4f56e49497b8c3db96d8f8a3:

  Merge tag 'usb-6.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2025-04-02 18:23:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 3f8ad18f81841a9ce70f603c45d5a278528c67e6:

  selftests/bpf: Fix verifier_private_stack test failure (2025-04-02 21:55:44 -0700)

----------------------------------------------------------------
- Fix BPF selftests expectations of assembler output and struct layout
  (Song Liu and Yonghong Song)

- Fix XSK error code when queue is full (Wang Liang)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Song Liu (2):
      selftests/bpf: Fix tests after fields reorder in struct file
      selftests/bpf: Fix verifier_bpf_fastcall test

Wang Liang (1):
      xsk: Fix __xsk_generic_xmit() error code when cq is full

Yonghong Song (1):
      selftests/bpf: Fix verifier_private_stack test failure

 net/xdp/xsk.c                                              | 5 ++++-
 tools/testing/selftests/bpf/progs/test_module_attach.c     | 2 +-
 tools/testing/selftests/bpf/progs/test_subprogs_extable.c  | 6 +++---
 tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c  | 6 +++---
 tools/testing/selftests/bpf/progs/verifier_private_stack.c | 6 +++---
 5 files changed, 14 insertions(+), 11 deletions(-)

