Return-Path: <bpf+bounces-60690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 003BAADA30D
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 20:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2333AF42D
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 18:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3680D279DDE;
	Sun, 15 Jun 2025 18:54:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314781AC8
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750013641; cv=none; b=YQi4lhPbGTjXULd2SycgOryLvppefuUkMWKHv2MBAYGyMskHwr+uYSjpf9pU2T3lmDLq2korgidUOrunXdS6/N62YMnVNf8FQwac6ptWCT8ExsVYsTuUByZEUKWh53GN4amdaE9LSMsv6eSQTf2x4gbf2TlG0d6pCajVV3FZKCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750013641; c=relaxed/simple;
	bh=+BJdPTaAbkAz626kutRqfD8PI0iseuSIgvuRVmszogs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxlSq60i+Cn5ZDBad31Y9DO6CX/ZemK3qD/iGiTkYbMsD5YAmNR91uq6h9PA6N6Nnc7F5+Dj5GOr3ksOvNHKNTiLQvk8TUX/P9IlI0hAytsgnzOa2dF3hooLLcbx9dxa7FF8B3IGccmAXQchEXOQHc/kOKzO+jbJTcBgwkXW+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 082889A90F4C; Sun, 15 Jun 2025 11:53:46 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 0/3] selftests/bpf: Fix usdt/multispec failure with arm64/clang20
Date: Sun, 15 Jun 2025 11:53:45 -0700
Message-ID: <20250615185345.2756663-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The usdt/multispec test failed with arm64 arch and clang20 compiler.
On arm64, gcc11 and clang20 generates significantly different usdt
probes and such a difference caused clang20 built selftest failed.

Patches 1 and 2 are refactoring and Patch 3 adjusted BPF_USDT_MAX_SPEC_CN=
T
for arm64/clang which fixed the issue.

Changelogs:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20250613153446.2256725-1-yonghong.s=
ong@linux.dev/
    - The commit description in v1 is not right, it checks sdt's for usdt=
_100
      while actually it usdt_300 should be checked. Patch 1 has proper
      descriptions.
    - Refactor the code to add a new test ust/multispec_fail where a new
      prog is added and in that new prog BPF_USDT_MAX_SPEC_CNT can overwr=
ite
      the default value in order to pass the test.

Yonghong Song (3):
  selftests/bpf: Refactor the failed assertion to another subtest
  selftests/bpf: Add test_usdt_multispec.inc.h for sharing between
    multiple progs
  selftests/bpf: Add subtest usdt_multispec_fail with adjustable
    BPF_USDT_MAX_SPEC_CNT

 tools/testing/selftests/bpf/prog_tests/usdt.c | 36 +++++++++++++------
 .../selftests/bpf/progs/test_usdt_multispec.c | 28 +--------------
 .../bpf/progs/test_usdt_multispec.inc.h       | 30 ++++++++++++++++
 .../bpf/progs/test_usdt_multispec_fail.c      | 10 ++++++
 4 files changed, 67 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_multispec=
.inc.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_multispec=
_fail.c

--=20
2.47.1


