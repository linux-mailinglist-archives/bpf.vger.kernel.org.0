Return-Path: <bpf+bounces-74707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B28C62E90
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 09:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3433D3577DC
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 08:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD49A31C58A;
	Mon, 17 Nov 2025 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtFbea2w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC0A30C350;
	Mon, 17 Nov 2025 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763368567; cv=none; b=le2MEYKMpmjbW32SgLr3q+ziGOksWGckuQ4lMrSh4OYUkNw1wL3e03Bn5v69Toq1ZoSy7krhZ53ohL4AV2jCMVCrR76GU/x7i45TzZQuCpa41WDbuDlRQbuoVkbpZOkCUVB+WlqQECKYr5KLqHMsQDvi40Fs8dEilK8jxdFg0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763368567; c=relaxed/simple;
	bh=olQbUe5IZt/ljD1Q81LAQnamNFR6NjTUhsvIq9sgYnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ucy5l3K564wLXWn4kPvS6xHb+Y1t5kixjVQPrSk9veYCvOq+TasSovV3K+sP1ZkGkiKi3GJsGiV8C6L5nKYVfiEsuxYMYIvUx2rV48wm5AOEFM2BvD26i7p+l4FVkNFPIRyCwfGTgcxizzPOW1dr/+wt6wSRoBl1921Th03qP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtFbea2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753FCC116B1;
	Mon, 17 Nov 2025 08:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763368563;
	bh=olQbUe5IZt/ljD1Q81LAQnamNFR6NjTUhsvIq9sgYnQ=;
	h=From:To:Cc:Subject:Date:From;
	b=gtFbea2wiWDYoD/YcEG8XvNP+5q/iGhAkYRx4uUqs0hWMCEjD+INq4ggF1ZhIvKJ6
	 2eILNCQIspy7mFpxam2UKrppr7fpEjOBbW1Myta5VUjb7g7YyYjsZ4351i6LS5FKwz
	 fboKBulVfEjwlKmS0RYk54gNK4ldCW0F36GbybSVLhYaiKae9DRo5aB/SQu6GPBid4
	 p6Ylfcx1dF2pbbRRUWaeuHmgUnEb2KonIJm3ECpEpHfOAEkw1fUwmDk2QV27fVPdAr
	 y7vlrQtnkWOERckOsQ4M4BgVMzwxCLFWLqFCKzBIlFVq4KiGSraSxqPAzYBP4O5Ixm
	 fwyMdZBK5K8nw==
From: Jiri Olsa <jolsa@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next 0/4] libbpf: Make optimized uprobes backward compatible
Date: Mon, 17 Nov 2025 09:35:47 +0100
Message-ID: <20251117083551.517393-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we can currently optimize uprobes on top of nop5 instructions,
so application can define USDT_NOP to nop5 and use USDT macro
to define optimized usdt probes.

This works fine on new kernels, but could have performance penalty
on older kernels, that do not have the support to optimize and to
emulate nop5 instruction.

This patchset adds support to workaround the performance penalty
on older kernels that do not support uprobe optimization, please
see detailed description in patch 1.

Note patch 1 will need to get pushed to libbpf/usdt [1] as well.

thanks,
jirka


[1] https://github.com/libbpf/usdt
---
Jiri Olsa (4):
      selftests/bpf: Emit nop,nop5 instructions for x86_64 usdt probe
      libbpf: Add uprobe syscall feature detection
      libbpf: Add support to parse extra info in usdt note record
      selftests/bpf: Add test for checking correct nop of optimized usdt

 tools/lib/bpf/features.c                      | 22 ++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h               |  2 ++
 tools/lib/bpf/usdt.c                          | 27 ++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/.gitignore        |  2 ++
 tools/testing/selftests/bpf/Makefile          |  7 ++++++-
 tools/testing/selftests/bpf/prog_tests/usdt.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_usdt.c |  9 +++++++++
 tools/testing/selftests/bpf/usdt.h            | 17 +++++++++++++++++
 tools/testing/selftests/bpf/usdt_1.c          | 14 ++++++++++++++
 tools/testing/selftests/bpf/usdt_2.c          | 13 +++++++++++++
 10 files changed, 193 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/usdt_1.c
 create mode 100644 tools/testing/selftests/bpf/usdt_2.c

