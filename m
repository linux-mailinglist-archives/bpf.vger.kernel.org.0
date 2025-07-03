Return-Path: <bpf+bounces-62285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E92AF76C8
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 16:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDEF57BBD13
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F81C126C03;
	Thu,  3 Jul 2025 14:11:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918A122F177
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551877; cv=none; b=J8V0mYZNtxVLNJ24qpZrd6mnksPTKZEzRZqlEdjpnPGM0jsAV0yf+Z1cgj4l4kzTp8Hh98PdUFzd6xeTKH/E0IhfcIa/lxKA/NFziwMuNzJ/vNI7VPP6sIQkVyusFzSoLWaLMOg7I149HY6US3ZkuQLNmYBQDtdn2jl8aOALpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551877; c=relaxed/simple;
	bh=Lwql0BBL33bLrbIebMNyg3nwt5vVUM7pGhtMeRYXwTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvJEs6jMjknlACqQFuY8USWi8ZxSm2r9zf23MEFRFbavZI7wrCPLnArV72WsXoym0+NPPm5nSe+9QzgGRKNdQtbdK8YuNCOkh0m/OsHBt6lp3HO7DOgrhKdUNJJ+hwNc7DHtsRIlbKwkd1PXTznA+5xPO87Mh+hDkQ1dzJGvrVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BBC67AC9F59E; Thu,  3 Jul 2025 07:11:01 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 0/3] bpf: Reduce verifier stack frame size
Date: Thu,  3 Jul 2025 07:11:01 -0700
Message-ID: <20250703141101.1482025-1-yonghong.song@linux.dev>
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
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20250702171134.2370432-1-yonghong.s=
ong@linux.dev/
    - Rename env->callchain to env->callchain_buf so it is clear that
    - env->callchain_buf is used for a temp buf.
     =20
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
 kernel/bpf/verifier.c        | 230 +++++++++++++++++------------------
 2 files changed, 113 insertions(+), 118 deletions(-)

--=20
2.47.1


