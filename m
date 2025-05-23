Return-Path: <bpf+bounces-58862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A0AC2B1E
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 22:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595803A79F2
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 20:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455CE1FCFE2;
	Fri, 23 May 2025 20:53:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61DD157A6C
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748033611; cv=none; b=rFOQLweZk8Kj1Xtci64jqG00djoDPUT0GljO1A0b/FjgfM4ciBQfY3yLZT4qCrqJVkSSVvFHdrqaDG4HZ+HZa7PPRheJIwOH0qd6CIIbnJ2/w1eL3ER4dD6aXkUIsbiG9bt5pkmG9YuU6WAMpv3AEXP4xOhjaKn3hoIO34PaO5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748033611; c=relaxed/simple;
	bh=h4F0+k3Wt1fr112GDTLHyHxRoVK5kALDQVTblXlsGxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UZGlRWmi5gmacshIf63HRgp2yQyp5yA2OS1L0wdG9cc0rKxri+L/p9MTm52nT67HoxEmeapuLGnp5nLrB3kszi0jiE9ZSPNlVDoaTQJ9yd0IKRA5uo+3bKMMPfPx9xTmYzp9eSPWr1SBqvxVY4ThWr1TlZTRMN/Om6SvFiN8rsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4C3298141E15; Fri, 23 May 2025 13:53:16 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 0/3] bpf: Warn with __bpf_trap() kfunc maybe due to uninitialized variable
Date: Fri, 23 May 2025 13:53:16 -0700
Message-ID: <20250523205316.1291136-1-yonghong.song@linux.dev>
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

To give a better hint to user, __bpf_trap() kfunc is introduced
in kernel and the compiler ([2]) will encode __bpf_trap()
as needed. For example, compiler may generate 'unreachable' IR
after do optimizaiton by taking advantage of uninitialized variable,
and later bpf backend will translate such 'unreachable' IR to
__bpf_trap() func in final binary. When kernel detects
__bpf_trap(), it is able to issue much better verifier log, e.g.
  unexpected __bpf_trap() due to uninitialized variable?

  [1] https://github.com/msune/clang_bpf/blob/main/Makefile#L3
  [2] https://github.com/llvm/llvm-project/pull/131731

Changelogs:
  v4 -> v5:
    - v4: https://lore.kernel.org/bpf/20250521032047.1015381-1-yonghong.s=
ong@linux.dev/
    - Change original kfunc bpf_unreachable() to __bpf_trap().
    - Better codes for function check_special_kfunc().
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
  bpf: Warn with __bpf_trap() kfunc maybe due to uninitialized variable
  selftests/bpf: Add unit tests with __bpf_trap() kfunc

 kernel/bpf/helpers.c                          |   5 +
 kernel/bpf/verifier.c                         | 379 +++++++++---------
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_bpf_trap.c   |  71 ++++
 4 files changed, 260 insertions(+), 197 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bpf_trap.c

--=20
2.47.1


