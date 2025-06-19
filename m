Return-Path: <bpf+bounces-61085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F68AE08BB
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 16:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4072176546
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F11D221549;
	Thu, 19 Jun 2025 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="XWPeZLyf"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D21AF0B5;
	Thu, 19 Jun 2025 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343340; cv=none; b=hwtV9oISS7KweQEVXpqtHRKKcBPi2lCHn6JRhAsnKrD9KE1cnmOjiIqz7683IMcR2Z+QU+BsoCMftK24A1riR6kN86fNGz63rKfqlDTS1BYU//XusUcK7dpz+AQdLcQAQxHc8pPk25zjHGmaZBIu7hbhXRzeIiy42Yzv11YT7xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343340; c=relaxed/simple;
	bh=HJmfgzgj0ndJEaGrG8+noTDVPzF8ReijeU84n6dffYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOE7eO73DUA0jHhkzgcHTpQvpCpcV6srkw/hM4wqp2HgdssmU0ulihO+zDe7T43eY5mdHlOFvaIPQfDw0ipL1dKJm442UBGe4JJZWb8wd4hM8YTXLS5iXzey3zkycNbSwlJPmTAVh6fB6VQKCuq3Ol2hrPN+M4fglTJAWehEBvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=XWPeZLyf; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1750343336; bh=S14nIAZKvZkp/VwnTFIYJCuXUidvu32HhMy8SRNMghs=;
	h=From:To:Cc:Subject:Date:From:To:CC:Subject;
	b=XWPeZLyf+OeOlBWfNzuhC15Vnxb95TmG2vo5NyCaRFC2kbC1jiYUkY0smdSnfkuFs
	 aiBCQ2SuVwtJBj19lPaJhJlWP9IZRsQu7PL6+4CrVDG3b1lU88UjEmkUXeoAybvumU
	 4rcOi5uhgJ01j0bek/6LpWvZgsbH4uUXgDE2WTdVgtltXmpA1UxSE9/pnJBY31N+Wd
	 Y/5C/qRyV2BxtU/PDuvH1p7E6ub9+EdEJjOJ+Apx4G7ohUV2DsoOu770hUJRx3iaVN
	 ZQROW8T15UrrOX4RCm662XlOqdWD1mZn8Vz9ff68GQfJbAQODbkzzWkQ+SPmfeVSQV
	 gTfJ5FIZViFCQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4bNNJl6ZMyz8sqg;
	Thu, 19 Jun 2025 16:28:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3610:e200:f74c:d89c:f3eb:14e2
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3610:e200:f74c:d89c:f3eb:14e2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19YMo4uslHrzyvMvsz98NrnEv3rvWYw/jc=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4bNNJh4dDMz8spN;
	Thu, 19 Jun 2025 16:28:52 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	bpf@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] powerpc/bpf: Fix warning for unused ori31_emitted
Date: Thu, 19 Jun 2025 16:26:47 +0200
Message-ID: <20250619142647.2157017-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without this, the compiler (clang21) might emit a warning under W=1
because the variable ori31_emitted is set but never used if
CONFIG_PPC_BOOK3S_64=n.

Without this patch:

$ make -j $(nproc) W=1 ARCH=powerpc SHELL=/bin/bash arch/powerpc/net
  [...]
  CC      arch/powerpc/net/bpf_jit_comp.o
  CC      arch/powerpc/net/bpf_jit_comp64.o
../arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_build_body':
../arch/powerpc/net/bpf_jit_comp64.c:417:28: warning: variable 'ori31_emitted' set but not used [-Wunused-but-set-variable]
  417 |         bool sync_emitted, ori31_emitted;
      |                            ^~~~~~~~~~~~~
  AR      arch/powerpc/net/built-in.a

With this patch:

  [...]
  CC      arch/powerpc/net/bpf_jit_comp.o
  CC      arch/powerpc/net/bpf_jit_comp64.o
  AR      arch/powerpc/net/built-in.a

Fixes: dff883d9e93a ("bpf, arm64, powerpc: Change nospec to include v1 barrier")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506180402.uUXwVoSH-lkp@intel.com/
Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 arch/powerpc/net/bpf_jit_comp64.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 3665ff8bb4bc..a25a6ffe7d7c 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -820,13 +820,12 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		case BPF_ST | BPF_NOSPEC:
 			sync_emitted = false;
 			ori31_emitted = false;
-#ifdef CONFIG_PPC_E500
-			if (!bpf_jit_bypass_spec_v1()) {
+			if (IS_ENABLED(CONFIG_PPC_E500) &&
+			    !bpf_jit_bypass_spec_v1()) {
 				EMIT(PPC_RAW_ISYNC());
 				EMIT(PPC_RAW_SYNC());
 				sync_emitted = true;
 			}
-#endif
 			if (!bpf_jit_bypass_spec_v4()) {
 				switch (stf_barrier) {
 				case STF_BARRIER_EIEIO:
@@ -849,10 +848,10 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 					break;
 				}
 			}
-#ifdef CONFIG_PPC_BOOK3S_64
-			if (!bpf_jit_bypass_spec_v1() && !ori31_emitted)
+			if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&
+			    !bpf_jit_bypass_spec_v1() &&
+			    !ori31_emitted)
 				EMIT(PPC_RAW_ORI(_R31, _R31, 0));
-#endif
 			break;
 
 		/*

base-commit: cd7312a78f36e981939abe1cd1f21d355e083dfe
-- 
2.49.0


