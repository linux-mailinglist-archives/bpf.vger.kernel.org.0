Return-Path: <bpf+bounces-34769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DF393094B
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 10:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998121F216C0
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5EC1F5FF;
	Sun, 14 Jul 2024 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7V9IigM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458561C2BE;
	Sun, 14 Jul 2024 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720946292; cv=none; b=PGwk8ncl4fbyCFX7nL5KM5abc34rJG846VhuNXIAIRycZWos3ePbhKvm51qvL3Vq0jH0BODllc4v3L3XYWUNTQyRePUgLQTxhoxmHFo7+iRVHrAAt13JKYbNjZP4afkwGCwzudWGcaN+BIof3WkXr+D/06Y1UyQJYQJNe9yqmN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720946292; c=relaxed/simple;
	bh=LjwBIK+b2D+BSfM5bKhp6MDPM+Wpr0//MiA+sJQ0Hkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pW6YWxBonxigY+/l1bkiLAemu3k7nOXrefg4sBhuq1tRzZhUtBl8vtMQcaMJoH2dipuBcAh6dqlMK+CE+IO8GPSCaQB/4a5ENLqr7r3rG/T58skyLJzHXNFdSgRy1bcxoNrBNMgmmioBd1Y3KL5+eO3rDJs/uhZMPoVECQ0x4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7V9IigM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20085C116B1;
	Sun, 14 Jul 2024 08:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720946291;
	bh=LjwBIK+b2D+BSfM5bKhp6MDPM+Wpr0//MiA+sJQ0Hkk=;
	h=From:To:Cc:Subject:Date:From;
	b=B7V9IigMd1vltmXQQzdLePysQGC25irDQsTeBZhiuyTK6DiKPbjso+5cKcYut2oAI
	 jcBAl7QQYDurz2fXbYh2sIUTXqcCVYK9hpOO/sxzpE/nX56RTYXcgg1sJ4qxUypVZm
	 KxP3OlU3CxWx/O8dbdjmx/k/+Q4Yj3JHyyN1rzVV77LDQ0cnX6sh/eOir7VkSc/IPn
	 KTlMqM4Lq0JkVyKlw65LSbFChJUFP1e9tKIObLfqN3J49D3t41ippEfv1L3LWvF3tz
	 RR5avVH+fgk6VOlNbcJ3sXmS0iHO46T/cJXAJsc3SJ+C3eeuqptkGdJmMnEe5fIxxo
	 +zUsYmQHmycgg==
From: Naveen N Rao <naveen@kernel.org>
To: <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>,
	<bpf@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/2] MAINTAINERS: Update email address of Naveen
Date: Sun, 14 Jul 2024 14:04:23 +0530
Message-ID: <fb6ef126771c70538067709af69d960da3560ce7.1720944897.git.naveen@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have switched to using my @kernel.org id for my contributions. Update
MAINTAINERS and mailmap to reflect the same.

Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 .mailmap    | 2 ++
 MAINTAINERS | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 81ac1e17ac3c..289011ebca00 100644
--- a/.mailmap
+++ b/.mailmap
@@ -473,6 +473,8 @@ Nadia Yvette Chambers <nyc@holomorphy.com> William Lee Irwin III <wli@holomorphy
 Naoya Horiguchi <nao.horiguchi@gmail.com> <n-horiguchi@ah.jp.nec.com>
 Naoya Horiguchi <nao.horiguchi@gmail.com> <naoya.horiguchi@nec.com>
 Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
+Naveen N Rao <naveen@kernel.org> <naveen.n.rao@linux.ibm.com>
+Naveen N Rao <naveen@kernel.org> <naveen.n.rao@linux.vnet.ibm.com>
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <quic_neeraju@quicinc.com>
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <neeraju@codeaurora.org>
 Neil Armstrong <neil.armstrong@linaro.org> <narmstrong@baylibre.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index fa32e3c035c2..05f14b67cd74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3878,7 +3878,7 @@ S:	Odd Fixes
 F:	drivers/net/ethernet/netronome/nfp/bpf/
 
 BPF JIT for POWERPC (32-BIT AND 64-BIT)
-M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
+M:	Naveen N Rao <naveen@kernel.org>
 M:	Michael Ellerman <mpe@ellerman.id.au>
 L:	bpf@vger.kernel.org
 S:	Supported
@@ -12332,7 +12332,7 @@ F:	mm/kmsan/
 F:	scripts/Makefile.kmsan
 
 KPROBES
-M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
+M:	Naveen N Rao <naveen@kernel.org>
 M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
@@ -12708,7 +12708,7 @@ LINUX FOR POWERPC (32-BIT AND 64-BIT)
 M:	Michael Ellerman <mpe@ellerman.id.au>
 R:	Nicholas Piggin <npiggin@gmail.com>
 R:	Christophe Leroy <christophe.leroy@csgroup.eu>
-R:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
+R:	Naveen N Rao <naveen@kernel.org>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 W:	https://github.com/linuxppc/wiki/wiki

base-commit: 582b0e554593e530b1386eacafee6c412c5673cc
-- 
2.45.2


