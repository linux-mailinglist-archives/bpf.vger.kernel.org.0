Return-Path: <bpf+bounces-76041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D0ECA3397
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 11:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B071303B86A
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1B7335BD5;
	Thu,  4 Dec 2025 10:29:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F763321CB;
	Thu,  4 Dec 2025 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764844177; cv=none; b=WyQYPkNAjpQ13eqkKATmlPm0838BoFiFAJvaKA9H2jIa5h6rrtl8mP/8OuxD+B0vj0g1RB2ZTn/g53YQMIMj3yFaN7i9QiSCiizlrplH32xsN4J9Cww1P+6ukE9Fy0cryYYJzuOulzgWK9JR1nV0XvCLaCYT59mQD+iyW0vgrWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764844177; c=relaxed/simple;
	bh=D3T2AMT30nWRzQ3VWQSFkn04vH46kQJw10GK3fbvv1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzhCLFYWOrF3UuKh3qMy+B4KbER+gMwlK6Mr4QafJ8SH3mYYW+IsGbI9NHGVTa/78ObXLXo8HbYdQdUsF23KIR0ET+YehIVuQ8wfGBKFr8PhwrajNi77SEgdM62n3JoIT8IoTsA5bMosdYhACLVL/AudfJICLNH+9bf6GG6dvCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869C3C4CEFB;
	Thu,  4 Dec 2025 10:29:32 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kui-Feng Lee <thinker.li@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] net: smc: SMC_HS_CTRL_BPF should depend on BPF_JIT
Date: Thu,  4 Dec 2025 11:29:16 +0100
Message-ID: <988c61e5fea280872d81b3640f1f34d0619cfbbf.1764843951.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1764843951.git.geert@linux-m68k.org>
References: <cover.1764843951.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If CONFIG_BPF_SYSCALL=y, but CONFIG_BPF_JIT=n:

    net/smc/smc_hs_bpf.c: In function ‘bpf_smc_hs_ctrl_init’:
    include/linux/bpf.h:2068:50: error: statement with no effect [-Werror=unused-value]
     2068 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
	  |                                                  ^~~~~~~~~~~~~~~~
    net/smc/smc_hs_bpf.c:139:16: note: in expansion of macro ‘register_bpf_struct_ops’
      139 |         return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl);
	  |                ^~~~~~~~~~~~~~~~~~~~~~~

While this compile error is caused by a bug in <linux/bpf.h>, none of
the code in net/smc/smc_hs_bpf.c becomes effective if CONFIG_BPF_JIT is
not enabled.  Hence add a dependency on BPF_JIT.

While at it, add the missing newline at the end of the file.

Fixes: 15f295f55656658e ("net/smc: bpf: Introduce generic hook for handshake flow")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 net/smc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index 325addf83cc69f6c..277ef504bc26ef89 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -22,10 +22,10 @@ config SMC_DIAG
 
 config SMC_HS_CTRL_BPF
 	bool "Generic eBPF hook for SMC handshake flow"
-	depends on SMC && BPF_SYSCALL
+	depends on SMC && BPF_JIT && BPF_SYSCALL
 	default y
 	help
 	  SMC_HS_CTRL_BPF enables support to register generic eBPF hook for SMC
 	  handshake flow, which offer much greater flexibility in modifying the behavior
 	  of the SMC protocol stack compared to a complete kernel-based approach. Select
-	  this option if you want filtring the handshake process via eBPF programs.
\ No newline at end of file
+	  this option if you want filtring the handshake process via eBPF programs.
-- 
2.43.0


