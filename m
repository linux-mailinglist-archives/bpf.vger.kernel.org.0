Return-Path: <bpf+bounces-60437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010DFAD6642
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 05:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892283AD178
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 03:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173F71A8401;
	Thu, 12 Jun 2025 03:50:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB9319994F
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 03:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700242; cv=none; b=MlLaaEe1H2bIby8NHQfbRo2ew9WYQGsVVsaSbEj3vueyfwdIuu5N4/TcJLvh9OBeLCjlCFfj9LsbC2Hy3D+6eEqPTDRZ2F15zVzIiC7ajVHJCjFwXxR1EftMjCV/xZHk8ooxXkpaChJm1zaCyPW+yCRGHhjOX5coEMiVw7z3fUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700242; c=relaxed/simple;
	bh=FENqPwmk+ww3DAzwrqWR76zOkWUN4oKTFQtc7nwFrn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWYcraBbPHjU/D/+muHKT2CgB8xAyfML1/i1G5reKSIn3gMZ4pKeC62168pVTn1UnFQyUy74MmOtKMoOKWFcf5a74zBh4lF75FbtThrWgwQ8BWdxUJnLkzKvrZCJMgBDlODJgVHbMMG+jefUHh+FtGEY3bbTIbhmIgN7WfIMlso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8225296FFB8F; Wed, 11 Jun 2025 20:50:27 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 0/3] bpf: Fix a few test failures with 64K page size
Date: Wed, 11 Jun 2025 20:50:27 -0700
Message-ID: <20250612035027.2207299-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changelog:
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20250611171519.2033193-1-yonghong.s=
ong@linux.dev/
    - Add additional comments for xdp_adjust_tail test.
    - Use actual kernel page size to set new_len for Patch 2 tests.
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20250608165534.1019914-1-yonghong.s=
ong@linux.dev/
    - For xdp_adjust_tail, let kernel test_run can handle various page si=
zes for xdp progs.
    - For two change_tail tests, make code easier to understand.
    - Resolved a new test failure (xdp_do_redirect).

Yonghong Song (3):
  bpf: Fix an issue in bpf_prog_test_run_xdp when page size greater than
    4K
  selftests/bpf: Fix two net related test failures with 64K page size
  selftests/bpf: Fix xdp_do_redirect failure with 64KB page size

 net/bpf/test_run.c                            |  2 +-
 .../bpf/prog_tests/xdp_adjust_tail.c          | 96 +++++++++++++++++--
 .../bpf/prog_tests/xdp_do_redirect.c          | 13 ++-
 .../bpf/progs/test_sockmap_change_tail.c      |  9 +-
 .../selftests/bpf/progs/test_tc_change_tail.c | 14 +--
 .../bpf/progs/test_xdp_adjust_tail_grow.c     |  8 +-
 6 files changed, 122 insertions(+), 20 deletions(-)

--=20
2.47.1


