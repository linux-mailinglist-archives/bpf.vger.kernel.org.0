Return-Path: <bpf+bounces-66252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B24B302C0
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 21:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676175E846E
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 19:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBA0341AA6;
	Thu, 21 Aug 2025 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OshmbL8c"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5F2773FF
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803929; cv=none; b=Hfws8OoTgeQ8k2o1bJFzTAeoGuSLnPk1grjHJ65ENPUQ4p/RdHzvvScGc9mt8HCHsXUWsH5YZdF0YBw3/hAP2ewZnQLx/nKmKCnMNY5TzEjaVrWOcn4HEfbjCvec7oJwLjnmTdZpmk2XkDtBwvy7aDQ6BwuI+yKzlTUm08KBHuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803929; c=relaxed/simple;
	bh=g9x9B5OYSe6Smaa9/9ePcR6hM4yyyrgEsOom1cMqOMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XiUIIUqTmLMV9ZdR7kh4iLDj7/6jGt0g7LyAlHRcEIqIo+8mftNykwQA80bL5s1zu1PlfHhGfvrqd7OsALhYmeL1trOPDZwPCMHA4v431b3wiwrKK/bNHim7DQGaJOvFozJq5vaq2ce3ruUHPfQfG+ZJMOMKTl4X7LMdPbkVF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OshmbL8c; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755803915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C65/PLAVphk0l2XpxNVqWE26zjBU0wPwVUSCkRxnNe0=;
	b=OshmbL8ckmjbCh9CtTPhVD0kSRPjScqvZhRsbQHC2jL/3e/N4BAmH5UgLiCL+4WusT8Vj+
	P4dBivmudWPpl7RoEiWN1MAuQgr7AftLBJ3mIA4q3FuXy3Jfedmw7n0kDFYkKHO/VuOoZa
	WX+A4lu5zekSt4h+GHgTtPFUzkk27xw=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2025-08-21
Date: Thu, 21 Aug 2025 12:18:27 -0700
Message-ID: <20250821191827.2099022-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 9 non-merge commits during the last 3 day(s) which contain
a total of 13 files changed, 1027 insertions(+), 27 deletions(-).

The main changes are:

1) Added bpf dynptr support for accessing the metadata of a skb,
   from Jakub Sitnicki.
   The patches are merged from a stable branch bpf-next/skb-meta-dynptr.
   The same patches have also been merged into bpf-next/master.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Eduard Zingerman, Jesse Brandeburg

----------------------------------------------------------------

The following changes since commit bab3ce404553de56242d7b09ad7ea5b70441ea41:

  Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue (2025-08-15 18:13:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 7e1371023accc40423ee27264480307a1ca70aa6:

  Merge branch 'bpf-next/skb-meta-dynptr' into 'bpf-next/net' (2025-08-18 17:58:21 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Jakub Sitnicki (9):
      bpf: Add dynptr type for skb metadata
      bpf: Enable read/write access to skb metadata through a dynptr
      selftests/bpf: Cover verifier checks for skb_meta dynptr type
      selftests/bpf: Pass just bpf_map to xdp_context_test helper
      selftests/bpf: Parametrize test_xdp_context_tuntap
      selftests/bpf: Cover read access to skb metadata via dynptr
      selftests/bpf: Cover write access to skb metadata via dynptr
      selftests/bpf: Cover read/write to skb metadata at an offset
      selftests/bpf: Cover metadata access from a modified skb clone

Martin KaFai Lau (2):
      Merge branch 'add-a-dynptr-type-for-skb-metadata-for-tc-bpf'
      Merge branch 'bpf-next/skb-meta-dynptr' into 'bpf-next/net'

 include/linux/bpf.h                                |   7 +-
 include/linux/filter.h                             |   6 +
 kernel/bpf/helpers.c                               |  11 +
 kernel/bpf/log.c                                   |   2 +
 kernel/bpf/verifier.c                              |  15 +-
 net/core/filter.c                                  |  57 +++
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   3 +
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   2 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 218 +++++++++--
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 258 +++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c |  55 +++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 419 +++++++++++++++++++++
 13 files changed, 1027 insertions(+), 27 deletions(-)

