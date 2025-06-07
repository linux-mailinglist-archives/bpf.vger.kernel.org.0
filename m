Return-Path: <bpf+bounces-59979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A699AD0AD9
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 03:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1835117260F
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E763421D5BF;
	Sat,  7 Jun 2025 01:36:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570398F6B
	for <bpf@vger.kernel.org>; Sat,  7 Jun 2025 01:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749260181; cv=none; b=fzitZatQzDwK7MQNOn9j9bwQWTcQq/HIEj57LEHWckMnLRCGMKiApf086O70iucwR43qf5VCEIjENe0V9d0ZX/JMPJnWEg1V+K4BTg8NQgOViUOqJXCqidCRmmcuv5FJG7hvsLbbeqA2Yb5AoEzT46Ie7SidSsjTfAp6LaKWtwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749260181; c=relaxed/simple;
	bh=LKECqPOYbZn+gcdtEfQrb414zazuqol9AWbWW+cciEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwybns0UhwwX5s8bh6kZ3u7+30PvPaj6ZQXNINJbOISQggkPPMgCtIc0J5gCu8CGdOr0+Oc1gyux4lW41iXp5ecsPAXSMOy+cghGtSpm+wYJeUTGGHEqW+0553PEhEKtdQY5EvwSWp0b1BsOwNQlRVBUlG0+ukirQZsVdfcWCaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BE06D9097399; Fri,  6 Jun 2025 18:36:05 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 0/4] selftests/bpf: Fix a few test failures with arm64 64KB page
Date: Fri,  6 Jun 2025 18:36:05 -0700
Message-ID: <20250607013605.1550284-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

My local arm64 host has 64KB page size and the VM to run test_progs
also has 64KB page size. There are a few self tests assuming 4KB page
and failed in my environment.

Patch 1 reduced long assert logs so if the test fails, developers
can check logs easily. Patches 2-4 fixed three selftest failures.

Changelogs:
  v3 -> v4:
    - v3: https://lore.kernel.org/bpf/20250606213048.340421-1-yonghong.so=
ng@linux.dev/
    - In v3, I tried to use __kconfig with CONFIG_ARM64_64K_PAGES to deci=
de to have
      4K or 64K aligned. But CI seems unhappy about this. Most likely the=
 reason
      is due to lskel. So in v4, simply adjust/increase numbers to 64K al=
igned for
      test_ringbuf_write test.
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20250606174139.3036576-1-yonghong.s=
ong@linux.dev/
    - Fix veristat failure with bpf object file test_ringbuf_write.bpf.o.
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20250606032309.444401-1-yonghong.so=
ng@linux.dev/
    - Fix a problem with selftest release build, basically from
      BUILD_BUG_ON to ASSERT_LT.

Yonghong Song (4):
  selftests/bpf: Reduce test_xdp_adjust_frags_tail_grow logs
  selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB page size
  selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 64KB
    page size
  selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size

 .../selftests/bpf/prog_tests/bpf_mod_race.c    |  2 +-
 .../testing/selftests/bpf/prog_tests/ringbuf.c |  4 ++--
 .../selftests/bpf/prog_tests/user_ringbuf.c    | 10 +++++++---
 .../selftests/bpf/prog_tests/xdp_adjust_tail.c | 18 ++++++++++++------
 .../selftests/bpf/progs/test_ringbuf_write.c   |  4 ++--
 5 files changed, 24 insertions(+), 14 deletions(-)

--=20
2.47.1


