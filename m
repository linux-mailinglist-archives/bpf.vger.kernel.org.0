Return-Path: <bpf+bounces-69990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B6BBAAA62
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 23:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48258189AF80
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 21:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A63242D94;
	Mon, 29 Sep 2025 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PdFUP21R"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E6917996;
	Mon, 29 Sep 2025 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759181729; cv=none; b=DXMPfJHFzq0JCd9uoy15BFMvNdz2up3+5hfhiW9YImuUgdE72htQzhf2zytOWQrQ1zKJ2qBQkPG+FgRiUuDrovgh4KTx21LqamLj+6CQRtXWqm5yuvJKkzdPJYKpeSYtbajEpvYOFdVaBy7GjJjImg+mWZheL5FinSRsMYDHZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759181729; c=relaxed/simple;
	bh=/1LF3ow2QXU6zaGZ/EHWPxaG61ocD+dLpIc5VbdHYmE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RBp/eE3Ev1RN7FM2sBAbuKSCD2x9caglb3rBMHi08Ro9o0MjPpr8gnHy0FnYNWR8nDeSIOiBT2Wbx6Fm5X8YmgkoNWmGq4dxRZpLuisUBaT5dU87jhiITfcF2XVy3yZwukDuih+SiRQB+OiKSSk/L3EA/yTpDKoux2tiSuhbC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PdFUP21R; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id BABB42012C01;
	Mon, 29 Sep 2025 14:35:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BABB42012C01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759181726;
	bh=kWBR9yq06L+BvTRJlnPjazfFPMVrVkQ0UlJCF9ARXBE=;
	h=From:To:Subject:Date:From;
	b=PdFUP21R5ZN1KTesluJoQO+W8VKBiAiuyi2lh2tpSFnNEY3LI68vfYJ6P7EOiowVZ
	 CuK4COGIOTt0WpFNfpRbhsme25VWCAYtRG1t15xmvih2Pf4Pb7L3/zMgEILOVxWd9e
	 t5EAh7tfUs8XkMdLe7fgQveg+U7pkK/HHnK6fl6w=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kpsingh@kernel.org,
	bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	James.Bottomley@hansenpartnership.com,
	wufan@linux.microsoft.com,
	qmo@kernel.org
Subject: [PATCH bpf-next v2 0/3] BPF signature hash chains
Date: Mon, 29 Sep 2025 14:34:24 -0700
Message-ID: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset extends the currently proposed signature verification
patchset
https://lore.kernel.org/linux-security-module/20250813205526.2992911-1-kpsingh@kernel.org/
with hash-chain functionality to verify the contents of arbitrary
maps.

The currently proposed loader + map signature verification
scheme—requested by Alexei and KP—is simple to implement and
acceptable if users/admins are satisfied with it. However, verifying
both the loader and the maps offers additional benefits beyond just
verifying the loader:

1. Simplified Loader Logic: The lskel loader becomes simpler since it
   doesn’t need to verify program maps—this is already handled by
   bpf_check_signature().

2. Security and Audit Integrity: A key advantage is that the LSM
  (Linux Security Module) hook for authorizing BPF program loads can
  operate after signature verification. This ensures:

  * Access control decisions can be based on verified signature
  * status.  Accurate system state measurement and logging.  Log
  * events claiming a verified signature are fully truthful, avoiding
  * misleading entries that only the loader was verified while the
  * actual BPF program verification happens later without logging.

This approach addresses concerns from users who require strict audit
trails and verification guarantees, especially in security-sensitive
environments.

A working tree with this patchset is being maintained at
https://github.com/blaiseboscaccy/linux/tree/bpf-hash-chains

bpf CI tests passed as well
https://github.com/kernel-patches/bpf/actions/runs/18110352925

v2 -> v1:
   - Fix regression found by syzkaller
   - Add bash auto-complete support for new command line switch

Blaise Boscaccy (3):
  bpf: Add hash chain signature support for arbitrary maps
  selftests/bpf: Enable map verification for some lskel tests
  bpftool: Add support for signing program and map hash chains

 include/uapi/linux/bpf.h                      |  6 ++
 kernel/bpf/syscall.c                          | 73 ++++++++++++++++++-
 .../bpf/bpftool/Documentation/bpftool-gen.rst |  7 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/gen.c                       | 27 ++++++-
 tools/bpf/bpftool/main.c                      |  9 ++-
 tools/bpf/bpftool/main.h                      |  1 +
 tools/bpf/bpftool/sign.c                      | 16 +++-
 tools/include/uapi/linux/bpf.h                |  6 ++
 tools/lib/bpf/libbpf.h                        |  3 +-
 tools/lib/bpf/skel_internal.h                 |  6 +-
 tools/testing/selftests/bpf/Makefile          | 18 ++++-
 12 files changed, 159 insertions(+), 15 deletions(-)

-- 
2.48.1


