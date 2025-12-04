Return-Path: <bpf+bounces-76039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F22C9CA338C
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 11:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D72B302DBCA
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 10:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AD8333752;
	Thu,  4 Dec 2025 10:29:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1493310785;
	Thu,  4 Dec 2025 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764844168; cv=none; b=fUUopq02HU3taef1Em1Rs7O1ivAB4wVv0aQUY/9Do1E2uDyQBHi9M4AfD2Os8nD31H2GNmCvr07bYRnSEsL2VY+t96CrYAiFiznDQ8JIoebSzVBdPxp7dLTyJC4c/6MF5SVt9Z57TA4rkPwcBDovQXc1qMRqCncOD5pKgZNK56Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764844168; c=relaxed/simple;
	bh=kLKHKJTW5exLdI8W1ZtjxZ864Kgwu9Jh34DqM4y0svU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NQYcSRV64LzbGp0zWkpVgEL1SvTgHgN5UlyGkvXHNKRTHsxht5vJuGVECN98Ic0PhC1hvMr58Zy5QGavQaGaGmweV7ZUQQTel+iP10Fudip7fyJ8RENd9QyUBxcHy6h0q4R0Hg+6PMva2qGtHPZ9b9KFuoswp2m2HN6PqrgM5Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5FEC4CEFB;
	Thu,  4 Dec 2025 10:29:23 +0000 (UTC)
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
Subject: [PATCH 0/2] bpf, net: Fix smc for CONFIG_BPF_JIT=n
Date: Thu,  4 Dec 2025 11:29:14 +0100
Message-ID: <cover.1764843476.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

	Hi all,

If CONFIG_BPF_SYSCALL=y, but CONFIG_BPF_JIT=n (e.g. m68k/allmodconfig),
net/smc/smc_hs_bpf.c fails to build.

This patch series fix the issue in two ways, by:
  1. fixing the dummy variant of register_bpf_struct_ops(),
  2. making SMC_HS_CTRL_BPF depend on BPF_JIT.

So far the broken dummy was never detected: until the introduction of
SMC_HS_CTRL_BPF, all users of register_bpf_struct_ops() depended on both
BPF_SYSCALL and BPF_JIT.

Thanks!

Geert Uytterhoeven (2):
  bpf: Fix register_bpf_struct_ops() dummy
  net: smc: SMC_HS_CTRL_BPF should depend on BPF_JIT

 include/linux/bpf.h | 6 +++++-
 net/smc/Kconfig     | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

