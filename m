Return-Path: <bpf+bounces-67589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9DDB46039
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 19:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2681BC8D53
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 17:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D5B35A28D;
	Fri,  5 Sep 2025 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDjljn+b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173EE352FEF;
	Fri,  5 Sep 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093635; cv=none; b=YrL535HNV5mnkvm2m36HpJniHN6ElcB5qPaFX/DGiP6pNIBdrwVwv9Qx4+6t7rq2DosdNZehlKAmx+o9xQjUblX5N6fVHFdq6v5vnxgdCnW4U6xGJpH0eYYrDaaq5tSQlZfWyVSjYgpTw5bXWqzI2kd+85teEKa0iYKwDO+v67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093635; c=relaxed/simple;
	bh=HVZB1MmylaVxOm+jXUHO6m2dOZroYixExcyQ13jTf2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cfo0LK6tGuyBekjlkmf8N+NwkIqtnnfkliI318OeoBiwZqhCxt610SzYYaHudo7uyiq9ixFLMfBMZxrZrBWW88lcuI9YG2KKjzRuOTCUNynlDw4ZIIoQMpC8fWbhd1PlcmQERwuizG4YHcYnoXjYx3uT0qw508XgR10lBqTbT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDjljn+b; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4e84a61055so1691822a12.0;
        Fri, 05 Sep 2025 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757093633; x=1757698433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kiE89QJUAsvDI3W9wNpGleqnJi9RNLLz1gprJWoXutE=;
        b=aDjljn+bBkKBcOeVarhnMjNxHM71xLDwlUHj8AI33fL1TcNT3Bz6104GDe+aZMTwfc
         rBtJE7ifUGuMob35bnAyTynl6vG57fbASbuQ+A+s2uiEidB33HfrsD8rChqH6rYpclzU
         26Kb2EScEetaY85ZRhmLhHl2ZblfGKQDJPgGLORQA9JhNW0iVKcF+Mb2Zh2Fxk2kjGf3
         OpTn8ANKLE5oeQtCLPzQGqfMCujZ7cEQY4m/AMr6DkcJimLMI4EzD7VkMuZtpuUYOz3x
         czV7PpvBiqI+o01POqFRo7QMXOjdfBUXKTeeug5SmiSWA7urQXc6j6w0rr9vYdJlETUT
         F26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093633; x=1757698433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiE89QJUAsvDI3W9wNpGleqnJi9RNLLz1gprJWoXutE=;
        b=XygkIqiMnMtQ+NzKbHWlK4oap9G+xI6k9JRM9Ms3mysOO3c84ASQGglSiRrpL9cfwC
         Ouf8Drl3ZDtCxWk66bmamaRBwB5kOAlKjjBs9204m81+0wuKeyYHJnbiQDNgKtSBHBNG
         VTg60tHvFtBuTeTDEH7zRySEr3OUv4eo63GwF0JxEOQXwP6O1X9uNDFzYg/DyP+HLijI
         si4gu1dRHv3JBmt9SlqiBxOvG0DhhaiZfe2HPHb0bMewLbY2g25NRPvuGPkf+sGsD2cz
         AlNv3MS7IyDY+qtKOWNfQIemmckb+G/xwMe4pmhjDv6jBFt0ol/xjFSAadzleTXHnnqk
         vRug==
X-Gm-Message-State: AOJu0Yx7HhILCSsfbG/lLZi2WEAHVkIWORSGqeKJqzkt2LejFnsXmrYm
	CdawtkcLt1iZexKIrixglyXNFC26uD/zcAuPwcta3PG28llSgo1Adcurohezzw==
X-Gm-Gg: ASbGncsIwfESPyy3PTdT6xFnhsXCVvTWN0aXoEgdujS2CpQEJOQnyCU1xROvWHMi5mg
	/GYDQGkSir8c6jvht5pJafW2CiGYskhyXbWmZT9/9z+0eqAx9ysmryduPSjIHvX35EdUYdwx23d
	pP344SHC0SzZORn9YVvq0Wp4WJkYZBG334wBb4djBC4uezHEt4pgnpDXxxxh+PEgL5+CgA4E22r
	WP3apz366GQXABfOwp7a62wQYVGetphuelDC0DYXGojB81tucS6NstHc+WSLM6sKrgdfPRA980C
	Hr3H+q5/rOw1/X57mJ+xhGH1uDLkBnTPUEKn/lBX/4dybUk1Xh4vAelYNapxPz9TKfyLRo5RjRb
	7SobzcfHn8LFBBQ==
X-Google-Smtp-Source: AGHT+IGZnY4Pnm5ZbLHfjinl55/DL4q1p8dxljnnVXbwiwgHxNe8NopIed9ithKokeu8KAsaiq4k4w==
X-Received: by 2002:a17:902:ce03:b0:248:cd0b:3454 with SMTP id d9443c01a7336-24944873445mr255606935ad.9.1757093633054;
        Fri, 05 Sep 2025 10:33:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b0e860ab5sm111845055ad.5.2025.09.05.10.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:33:52 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/7] Add kfunc bpf_xdp_pull_data
Date: Fri,  5 Sep 2025 10:33:44 -0700
Message-ID: <20250905173352.3759457-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC v1 -> v2
  Rebase onto bpf-next

  Will rebase on the mlx5 patchset that avoids copying payload
  to linear part by Christoph if that got merged first, or seperate the
  mlx5 fix from this set.

  patch 1
  - Remove the unnecessary head frag search (Dragos)
  - Rewind the end frag pointer to simplify the change (Dragos)
  - Rewind the end frag pointer and recalculate truesize only when the
    number of frags changed (Dragos)

  patch 3
  - Fix len == zero behavior. To mirror bpf_skb_pull_data() correctly,
    the kfunc should do nothing (Stanislav)
  - Fix a pointer wrap around bug (Jakub)
  - Use memmove() when moving sinfo->frags (Jakub)
  
---

Hi all,

This patchset introduces a new kfunc bpf_xdp_pull_data() to allow
pulling nonlinear xdp data. This may be useful when a driver places
headers in fragments. When an xdp program would like to keep parsing
packet headers using direct packet access, it can call
bpf_xdp_pull_data() to make the header available in the linear data
area. The kfunc can also be used to decapsulate the header in the
nonlinear data, as currently there is no easy way to do this.

This patchset also tries to fix an issue in the mlx5e driver. The driver
curretly assumes the packet layout to be unchanged after xdp program
runs and may generate packet with corrupted data or trigger kernel warning
if xdp programs calls layout-changing kfunc such as bpf_xdp_adjust_tail(),
bpf_xdp_adjust_head() or bpf_xdp_pull_data() introduced in this set.

Tested with the added bpf selftest using bpf test_run and also on
mlx5 with the tools/testing/selftests/drivers/net/{xdp.py, ping.py}. mlx5
with striding RQ always pass xdp_buff with empty linear data to xdp
programs. xdp.test_xdp_native_pass_mb would fail to parse the header before
this patchset.

Thanks!
Amery

---

Amery Hung (7):
  net/mlx5e: Fix generating skb from nonlinear xdp_buff
  bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
  bpf: Support pulling non-linear xdp data
  bpf: Clear packet pointers after changing packet data in kfuncs
  bpf: Support specifying linear xdp packet data size in test_run
  selftests/bpf: Test bpf_xdp_pull_data
  selftests: drv-net: Pull data before parsing headers

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  38 ++++++-
 include/net/xdp_sock_drv.h                    |  21 +++-
 kernel/bpf/verifier.c                         |  13 +++
 net/bpf/test_run.c                            |   9 +-
 net/core/filter.c                             | 104 ++++++++++++++++--
 .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
 .../selftests/bpf/prog_tests/xdp_pull_data.c  |  96 ++++++++++++++++
 .../selftests/bpf/progs/test_xdp_pull_data.c  |  36 ++++++
 .../selftests/net/lib/xdp_native.bpf.c        |  90 ++++++++++++---
 9 files changed, 372 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c

-- 
2.47.3


