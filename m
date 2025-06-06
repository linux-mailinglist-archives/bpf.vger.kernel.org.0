Return-Path: <bpf+bounces-59947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF638AD098A
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7485C189E958
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DE6218EB1;
	Fri,  6 Jun 2025 21:31:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557DA218ABD
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749245464; cv=none; b=oqBwfGYwRq4tdW5n2ADedqR0vQg3LGPtoO8EuJq7GWL9EBjmlOqxboSqGJ2g2kecAn1FqKdOJ4KLvfpTiHzgJIe+CErPi/2rXPLMrxpTpaWa4hvTSRVymJgBmUHPzvhcbo/C2eOErC6oBjuL0+XX+ps+DZ32bS9Ny+aqoZcTjNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749245464; c=relaxed/simple;
	bh=+t4kwPB9BG24lIscLL/ZklajC/RZJgLmE9H0mLnP8Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFabWCHoKV4vCrhgSed8CUOFh2yiV+u+hPlR6DlhMZ6MCp7Bi8NJdR1g8mia3zHFNFOHhBftSKwLwy02buN1uQrRZ8/tVaSMvltADIP9o1R6XB1WchkLFtDPu79aJE2g6ChnCF9mq6YF71z/2tezFE7R8n5MjmBG5j9gf2F7WNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1C32F906E1F6; Fri,  6 Jun 2025 14:30:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 0/4] selftests/bpf: Fix a few test failures with arm64 64KB page
Date: Fri,  6 Jun 2025 14:30:48 -0700
Message-ID: <20250606213048.340421-1-yonghong.song@linux.dev>
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
 .../selftests/bpf/progs/test_ringbuf_write.c   |  9 ++++++---
 5 files changed, 28 insertions(+), 15 deletions(-)

--=20
2.47.1


