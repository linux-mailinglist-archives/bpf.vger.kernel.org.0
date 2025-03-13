Return-Path: <bpf+bounces-54007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F4018A60419
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 23:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A3019C5279
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA91F540C;
	Thu, 13 Mar 2025 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GZk4DNPt"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951091E86E
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904192; cv=none; b=u0aCCLPv8OS8f9shyD3bW1NyKcnFNxFZaMKBI/pza/D/F3mQ66jlhABvlGumrcAc9v9Bw2AFxtFEeK40I6PFYaQ/68HtR1gKsCgHOI12cUMKwy8PE4DYiwQKZmTFTOa1H1waluTd7EX2bsG9lYTIo5XY4Oyvq0NUjrZkIY6E/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904192; c=relaxed/simple;
	bh=rqwkEAyAYDLFU9EStmA3tICOpjpDqbzkwaYQgakIZnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzSPc3x0TALsYqwrAO8IR8WjwILHgnFZrkb+Fje9D4yq+1m1MD1YlYwHgJn5Z3kpRHYJqXfEqiWPf98Uaejc3Nj5oZPKB750TdKHutwyvvGY/CjK1+jio/kp6Nj62X731E57VkjxZ8IkK4BWe7elZWCFcOyCfGsBf1MVChDCeac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GZk4DNPt; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741904188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vmsl3OAB7Tz4vQWYidUGp4du18OGCwxzpodnK8srQts=;
	b=GZk4DNPtvLiVBmAtR5gh79Ot4wVit9fUfbzunheVRHsXY8jDJB38xmv6LkHL8YkvnD1rWJ
	rOXq3dRKdS9huOUlRcWuvnxoBUekLMW0T4Wtgq7vsSFUcLUTPEm3J5rgeqDvezTC5xlDIG
	9y9en2sIQSjWLfnDaVcegsb21CTx2AA=
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
Subject: pull-request: bpf-next 2025-03-13
Date: Thu, 13 Mar 2025 15:16:20 -0700
Message-ID: <20250313221620.2512684-1-martin.lau@linux.dev>
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

We've added 4 non-merge commits during the last 3 day(s) which contain
a total of 2 files changed, 35 insertions(+), 12 deletions(-).

The main changes are:

1) bpf_getsockopt support for TCP_BPF_RTO_MIN and TCP_BPF_DELACK_MAX,
   from Jason Xing

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

----------------------------------------------------------------

The following changes since commit 6d99faf2541d519ec30a104d6b585484563e2c45:

  Merge branch 'net-ti-icssg-prueth-add-native-mode-xdp-support' (2025-03-11 11:10:16 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to c468c8d299341adf348f1d9cfaacca3cb4f91003:

  Merge branch 'tcp-add-some-rto-min-and-delack-max-bpf_getsockopt-supports' (2025-03-13 14:43:15 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Jason Xing (4):
      tcp: bpf: Introduce bpf_sol_tcp_getsockopt to support TCP_BPF flags
      tcp: bpf: Support bpf_getsockopt for TCP_BPF_RTO_MIN
      tcp: bpf: Support bpf_getsockopt for TCP_BPF_DELACK_MAX
      selftests/bpf: Add bpf_getsockopt() for TCP_BPF_DELACK_MAX and TCP_BPF_RTO_MIN

Martin KaFai Lau (1):
      Merge branch 'tcp-add-some-rto-min-and-delack-max-bpf_getsockopt-supports'

 net/core/filter.c                                  | 45 ++++++++++++++++------
 tools/testing/selftests/bpf/progs/setget_sockopt.c |  2 +
 2 files changed, 35 insertions(+), 12 deletions(-)

