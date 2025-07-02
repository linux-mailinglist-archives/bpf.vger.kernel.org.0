Return-Path: <bpf+bounces-62162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 314BAAF5F92
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB167B4EF5
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E702FF498;
	Wed,  2 Jul 2025 17:11:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7B923C4E9
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476309; cv=none; b=jaX35GRUnzU5uu1vBFPVyIErDtCmHf+ZjzgvJCI/rNdS4H5GznY3VMjwR01UFP3CgsmLUW0ol8BsX7/bmbWVURl/Y1neFZ/gA6wjhJ4Ah2qZWd4uRgnreteFOgR1JLJpSAYND9Qms67Lno8zl6AsfKzFJhqYk0Elh0N/Af7/eQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476309; c=relaxed/simple;
	bh=Gbfj/Ygy8gxAkOlPOX+on12+0edxE050wxcpf9RxrG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BoJRg5ZYme0P6RStg5tpl61+E50QLnBA9MkJ9Xm/deFCGYoABWqolCQXWhYGeK5osmJY5Hd2ov+agf/BzogBYXM5Vf1mLPnnBJVZp1jSzTHeJdeYOrPrX2Q07QAt//nBKh1HdISnGH3ZJHAN1LnN5EBCCZ5qBCJPmJjGm7jEurQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4B1E0ABB2E38; Wed,  2 Jul 2025 10:11:34 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 0/3] bpf: Reduce verifier stack frame size
Date: Wed,  2 Jul 2025 10:11:34 -0700
Message-ID: <20250702171134.2370432-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Arnd Bergmann reported an issue ([1]) where clang compiler (less than
llvm18) may trigger an error where the stack frame size exceeds the limit=
.
I can reproduce the error like below:
  kernel/bpf/verifier.c:24491:5: error: stack frame size (2552) exceeds l=
imit (1280) in 'bpf_check'
      [-Werror,-Wframe-larger-than]
  kernel/bpf/verifier.c:19921:12: error: stack frame size (1368) exceeds =
limit (1280) in 'do_check'
      [-Werror,-Wframe-larger-than]

This patch series fixed the above two errors by reducing stack size.
See each individual patches for details.

  [1] https://lore.kernel.org/bpf/20250620113846.3950478-1-arnd@kernel.or=
g/

Changelogs:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20250702053332.1991516-1-yonghong.s=
ong@linux.dev/
    - Simplify assignment to struct bpf_insn pointer in do_misc_fixups().
    - Restore original implementation in opt_hard_wire_dead_code_branches=
()
      as only one insn on the stack.
    - Avoid unnecessary insns for 64bit modulo (mod 0/-1) operations.

Yonghong Song (3):
  bpf: Simplify assignment to struct bpf_insn pointer in
    do_misc_fixups()
  bpf: Reduce stack frame size by using env->insn_buf for bpf insns
  bpf: Avoid putting struct bpf_scc_callchain variables on the stack

 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/verifier.c        | 229 +++++++++++++++++------------------
 2 files changed, 112 insertions(+), 118 deletions(-)

--=20
2.47.1


