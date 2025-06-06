Return-Path: <bpf+bounces-59906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E98AD079F
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 19:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C513B1EC8
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6228BAA9;
	Fri,  6 Jun 2025 17:41:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E762A1DE2BD
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749231714; cv=none; b=MBJ5WPSqvjD5sXim3BXc2zq8Lb+5G6RErUtv+ELGYL/W4pYY3L7UuEGAAzduHrLbbnXNkOMV9hX8FhGW5NEpIF36M4EewmeriICeCLYSRivYlsyQc9gw9WGmZGbtwH5wyJOIsCwcu47zoKO13Wz3tqJuTMzS2RllhGUuX9CKE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749231714; c=relaxed/simple;
	bh=il+T6FvUGyIzQ/pfFH0F7T2y8DPsjKo5zxrOO2xJ00k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hz2DxrRNST5XJVooz36H3LjzyBuicjTt17MFlYsA4fg8tC9MVD51bdSydFWDBlscwcE8cmTKAdvyCVsIg/2ZHtSD5V71fyEsvx236Y8rsm3Eqbgee6FmBRtQTeQWpXjqrpPV5OnkDWSWr2PFUuX0qYLB68o8+r8Q4GxnwHoGTJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 06F699046CD8; Fri,  6 Jun 2025 10:41:40 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 0/4] selftests/bpf: Fix a few test failures with arm64 64KB page
Date: Fri,  6 Jun 2025 10:41:39 -0700
Message-ID: <20250606174139.3036576-1-yonghong.song@linux.dev>
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
 .../testing/selftests/bpf/prog_tests/ringbuf.c |  5 +++--
 .../selftests/bpf/prog_tests/user_ringbuf.c    | 10 +++++++---
 .../selftests/bpf/prog_tests/xdp_adjust_tail.c | 18 ++++++++++++------
 .../selftests/bpf/progs/test_ringbuf_write.c   |  5 +++--
 5 files changed, 26 insertions(+), 14 deletions(-)

--=20
2.47.1


