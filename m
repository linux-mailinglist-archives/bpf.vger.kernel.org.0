Return-Path: <bpf+bounces-72849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D8AC1CCC1
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E8A3B2113
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C4A3563E2;
	Wed, 29 Oct 2025 18:37:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE36355046
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761763024; cv=none; b=ugvmhyAUHX2iDSLl2dJbSF0rhLtPehu3fD+SM0+bxH7sRb4ucSBS/5czwInLjQ7HkDlRsfAH7wDfJhWYNVArMjDI6NBfmTDJphjDrEXb12alpIrdkgo/LxUo/S13ig6h0Ds8JD98SSUT1Kq2m8IU6AyKPbhwkjV8jgvOf7HNyt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761763024; c=relaxed/simple;
	bh=ZOkMM2ph0ZER6+FvMuqEIdRndImcMBsPp9hLiMM32kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkM89qol/KOsmyW894o2PyDIDemzk9Z2ibjR/sGmwytDc8ePEkguzZ8VB5I6fyPCbH1baJV1edgBhPbeSlKIIXHiMDjsL5341EUb4lHldnJ+pl4OOVVGJA5jbvD4TRoU+Viqec5BP8D9+KeZO3SQhOFS8zvzM0LvTV8bhtEzguE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4941E1396F93F; Wed, 29 Oct 2025 11:36:46 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: [PATCH bpf] bpf: Make migrate_{disable,enable} always inline if in header file
Date: Wed, 29 Oct 2025 11:36:46 -0700
Message-ID: <20251029183646.3811774-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With latest bpf/bpf-next tree and latest pahole master, I got the followi=
ng
build failure:

  $ make LLVM=3D1 -j
    ...
    LD      vmlinux.o
    GEN     .vmlinux.objs
    ...
    BTF     .tmp_vmlinux1.btf.o
    ...
    AS      .tmp_vmlinux2.kallsyms.o
    LD      vmlinux.unstripped
    BTFIDS  vmlinux.unstripped
  WARN: resolve_btfids: unresolved symbol migrate_enable
  WARN: resolve_btfids: unresolved symbol migrate_disable
  make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:72: vmli=
nux.unstripped] Error 255
  make[2]: *** Deleting file 'vmlinux.unstripped'
  make[1]: *** [/home/yhs/work/bpf-next/Makefile:1242: vmlinux] Error 2
  make: *** [/home/yhs/work/bpf-next/Makefile:248: __sub-make] Error 2

In pahole patch [1], if two functions having identical names but differen=
t
addresses, then this function name is considered ambiguous and later on
this function will not be added to vmlinux/module BTF.

Commit 378b7708194f ("sched: Make migrate_{en,dis}able() inline") changed
original global funcitons migrate_{enable,disable} to
  - in kernel/sched/core.c, migrate_{enable,disable} are global funcitons=
.
  - in other places, migrate_{enable,disable} may survive as static funct=
ions
    since they are marked as 'inline' in include/linux/sched.h and the
    'inline' attribute does not garantee inlining.

If I build with clang compiler (make LLVM=3D1 -j) (llvm21 and llvm22), I =
found
there are four symbols for migrate_{enable,disable} respectively, three
static functions and one global function. With the above pahole patch [1]=
,
migrate_{enable,disable} are not in vmlinux BTF and this will cause
later resolve_btfids failure.

Making migrate_{enable,disable} always inline in include/linux/sched.h
can fix the problem.

  [1] https://lore.kernel.org/dwarves/79a329ef-9bb3-454e-9135-731f2fd5195=
1@oracle.com/

Fixes: 378b7708194f ("sched: Make migrate_{en,dis}able() inline")
Cc: Menglong Dong <menglong8.dong@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index cbb7340c5866..b469878de25c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2407,12 +2407,12 @@ static inline void __migrate_enable(void) { }
  * be defined in kernel/sched/core.c.
  */
 #ifndef INSTANTIATE_EXPORTED_MIGRATE_DISABLE
-static inline void migrate_disable(void)
+static __always_inline void migrate_disable(void)
 {
 	__migrate_disable();
 }
=20
-static inline void migrate_enable(void)
+static __always_inline void migrate_enable(void)
 {
 	__migrate_enable();
 }
--=20
2.47.3


