Return-Path: <bpf+bounces-58632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F86DABEA64
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 05:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6D2189F0A2
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 03:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D5922DA14;
	Wed, 21 May 2025 03:21:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B58A22DA00
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747797663; cv=none; b=UfRBzCwAwP2WPA0+Mb1WXaDPZfYBkTyizdLPkeeaeoYZ7RT/DUhYAgiB/hFhGXPsHTJy+Ka+QKenndQOdlxwC3Gk25Hia4mMQyaKS5bj74KOB2qxazOCGDZROyWtTxvCBdLhUXYjUyzCGntSlG7pFIk6NlHcYx3Pokn7J6gS80Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747797663; c=relaxed/simple;
	bh=ExVHmjslfoUmKldghVKXY65lz6sAass0bckEy777f2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dctrxOwdeDfWRldPFvUY0oDhiG6D7lT2mYPKQtVD4iPjHC7hX0o0pe1PeDeampF8g4r+IQYM486k4wUIuWE2JX4V5KH5AKkCfLM6H6jesb8NPx684FOnnmrml5inVpFkhkHIOqd4r6L6H9KhiVlb3DtKoggj0n8TznrG/dLkZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B9A917E53E37; Tue, 20 May 2025 20:20:47 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 0/3] bpf: Warn with bpf_unreachable() kfunc maybe due to uninitialized variable
Date: Tue, 20 May 2025 20:20:47 -0700
Message-ID: <20250521032047.1015381-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Marc Su=C3=B1=C3=A9 (Isovalent, part of Cisco) reported an issue where an
uninitialized variable caused generating bpf prog binary code not
working as expected. The reproducer is in [1] where the flags
=E2=80=9C-Wall -Werror=E2=80=9D are enabled, but there is no warning as t=
he compiler
takes advantage of uninitialized variable to do aggressive optimization.
Such optimization results in a verification log:
  last insn is not an exit or jmp
User still needs to take quite some time to figure out what is
the root cause.

To give a better hint to user, bpf_unreachable() kfunc is introduced
in kernel and the compiler ([2]) will encode bpf_unreachable()
as needed. For example, compiler may generate 'unreachable' IR
after do optimizaiton by taking advantage of uninitialized variable,
and later bpf backend will translate such 'unreachable' IR to
bpf_unreachable() func in final binary. When kernel detects
bpf_unreachable(), it is able to issue much better verifier log, e.g.
  unexpected bpf_unreachable() due to uninitialized variable?

  [1] https://github.com/msune/clang_bpf/blob/main/Makefile#L3
  [2] https://github.com/llvm/llvm-project/pull/131731

Changelogs:
  v3 -> v4:
    - v3: https://lore.kernel.org/bpf/20250519203339.2060080-1-yonghong.s=
ong@linux.dev/
    - Remove special_kfunc_set in verifier.
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/CAADnVQL9A8vB-yRjnZn8bgMrfDSO17FFBt=
S_xOs5w-LSq+p74g@mail.gmail.com/
    - The newer llvm patch (above [2]) added 'exit' insn if the last insn
      in the function is bpf_unreachable(). This way, check_subprogs()
      handling is unnecessary and removed.
    - Remove the big C test (above [1]) and add a simple C test and three
      inline asm tests.

  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20250511182744.1806792-1-yonghong.s=
ong@linux.dev/
    - If bpf_unreachable() is hit during check_kfunc_call(), report the
      verification failure.
    - Add three inline asm test cases.

Yonghong Song (3):
  bpf: Remove special_kfunc_set from verifier
  bpf: Warn with bpf_unreachable() kfunc maybe due to uninitialized
    variable
  selftests/bpf: Add unit tests with bpf_unreachable() kfunc

 kernel/bpf/helpers.c                          |   5 +
 kernel/bpf/verifier.c                         | 381 +++++++++---------
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_bpf_unreachable.c      |  61 +++
 4 files changed, 252 insertions(+), 197 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bpf_unreac=
hable.c

--=20
2.47.1


