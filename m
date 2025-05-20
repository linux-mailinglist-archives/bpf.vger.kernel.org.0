Return-Path: <bpf+bounces-58544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08435ABD479
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 12:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356433B4938
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 10:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7D526A1D4;
	Tue, 20 May 2025 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOjh7YS8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051C258CF9;
	Tue, 20 May 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747736642; cv=none; b=JCADDS2ETSMJtGr89l0tAv782+11WeY/sXMHeQWSEPAHr/J9q51X8QgIOmmjC6e2uEKcEUXfdDeGLQ8BNIHTWOTYlexrjif9EhdBQhI1cHSpoH+PaRfNb90lQ+xyQqC6byBZRU8bOwMZ2TsUy/325iR8MgpUX59vLawMc/JpWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747736642; c=relaxed/simple;
	bh=0QnjGAo7sOd2BF/4aVFYHcBW3acqApl8OAZGSRI8Pjo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F7Jvznoq8/huNb5NA/i6tSe+gD8SyabKGO3iaP6PJ/+Cveom/3umk1qr5PjWuEvhZnFvx8mKUNbJe5v75GFgvlkoMGmoGeF8LhRd1qjFVjE1V4KCoOs21WrPHE7piN1S/cP2oOfxABy4frI4jgSxwd4zuewYXP8k3R6z4XAI0I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOjh7YS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B875DC4CEE9;
	Tue, 20 May 2025 10:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747736641;
	bh=0QnjGAo7sOd2BF/4aVFYHcBW3acqApl8OAZGSRI8Pjo=;
	h=From:Subject:Date:To:Cc:From;
	b=FOjh7YS8lw5s4E8comfYlVGMn2A/g6YpbozbdFRcWULq2xbtDVtCpjOLpogte719I
	 dCMljl57pxsPs9/dLgJlL5hzxPvi7WADwVO+rfLU5iHKKwR8PHPuNaWOSOmRvyr1im
	 qhndnc2d6uZjjSmjLrDjTynmxS+vsWI0aSm1TB6qgiOb2BEVJ+hk2+t1QTAEeAZxnI
	 K1zQvQK7l22yqodWq7zVxLYewou78LHnQfeb7cfY9LQSGkXc+TdNeBo7KDY8+MENHt
	 grcbUAv0Y39gzzghNjRKSmhzkDhjQaoaSQKOTfNiZnq0Tnjyo/bomd+gmlI61LZ1ED
	 7fjltvs2Uz3uw==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH RFC net-next 0/5] net: ethernet: ti: am65-cpsw: add AF_XDP
 zero copy support
Date: Tue, 20 May 2025 13:23:49 +0300
Message-Id: <20250520-am65-cpsw-xdp-zc-v1-0-45558024f566@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADVYLGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNT3cRcM1Pd5ILict2KlALdqmRdo8Q0y1STpFRDY1MzJaC2gqLUtMw
 KsJHRSkFuziCxvNQS3bzUihKl2NpaAHAbgmJzAAAA
To: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=0QnjGAo7sOd2BF/4aVFYHcBW3acqApl8OAZGSRI8Pjo=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBoLFg8/lm2uxS1tq8aEIrThEIaaMdO/kORclCDs
 tIBvpLVS+GJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCaCxYPAAKCRDSWmvTvnYw
 kwQ3D/47Ci+RJI7Jm8Qjvox5MHpWdTBIr/TUCYsMKXmhcFdt+Fizbr1MpHi2sAT2xuSnuAonazJ
 SSNRieG/yyud8zKYQbZ0351yBkue87WReTxSyJ0/zBLwz5LanzTbdsXLsJpRAthky29NakDZUkx
 2luYfY6OzaLWtVBwlPyhrFVg6HMeBguOudR5foIWsyzbKZnHhmCmmXF+zyfLH03ZfBlee38zUDV
 AAwjQ+v7y+S/Ngfl+oBK/yGxmXWrlOHq2qYAGhShknacDJAFi1AfTK7OERKXSvZ2PepksqT2bxi
 VYrGzr+A/1/LiiYXoDLA24YBGUx2I7uEJkWp2cgnpmDMrDx7qqce7wU+TZNzktvnm0trJ5lKwS6
 g9GPRHm2mE9CcGLDVzXcfcTFyibEfr1DQFUCA7URKO1221CoAVZYOn41urE7eO5wmAFlblsswoJ
 nXoQNJFzHaBmecD9wPyaWnQWduykxDhSO0PzGGeDKqOmqAjLh3/K0l/J8PfAQKYJyvft+uZjIcH
 ghwY7IFKJJA77UUHlBGaRp/TRXcwV7Rk3wtaSUcXgGjNJqNL8/iMNXuhfRF0yAU0txJHuhC97eE
 ZzQZ9CNuxq0OclA37oxKRaaoPakCZgX7C35o8OjVtETMHBgr/67AZOQDJc9RmEPHHnRbuGvsM4r
 phrgKJdHQYi8NUQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

This series adds AF_XDP zero coppy support to am65-cpsw driver.

Tests were performed on AM62x-sk with xdpsock application [1].

A clear improvement is seen in 64 byte packets on Transmit (txonly)
and receive (rxdrop).
1500 byte test seems to be limited by line rate (1G link) so no
improvement seen there in packet rate. A test on higher speed link
(or PHY-less setup) might be worthwile.

There is some issue during l2fwd with 64 byte packets and benchmark
results show 0. I'm still investigating this issue.

AF_XDP performance using 64 byte packets in Kpps.
Benchmark:	XDP-SKB		XDP-Native	XDP-Native(ZeroCopy)
rxdrop		317		504		824
txonly		400		405		757
l2fwd 		207		264		0

AF_XDP performance using 1500 byte packets in Kpps.
Benchmark:	XDP-SKB		XDP-Native	XDP-Native(ZeroCopy)
rxdrop		82		82		82
txonly		82		82		82
l2fwd 		82		82		82

[1]: https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-example

To: 

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Roger Quadros (5):
      net: ethernet: ti: am65-cpsw: fix BPF Program change on multi-port CPSW
      net: ethernet: ti: am65-cpsw: add XSK pool helpers
      net: ethernet: ti: am65-cpsw: Add AF_XDP zero copy for RX
      net: ethernet: ti: am65-cpsw: Add AF_XDP zero copy for TX
      net: ethernet: ti: am65-cpsw: enable zero copy in XDP features

 drivers/net/ethernet/ti/Makefile         |   2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 526 +++++++++++++++++++++++++++----
 drivers/net/ethernet/ti/am65-cpsw-nuss.h |  37 ++-
 drivers/net/ethernet/ti/am65-cpsw-xdp.c  | 155 +++++++++
 4 files changed, 656 insertions(+), 64 deletions(-)
---
base-commit: 9f607dc39b6658ba8ea647bd99725e68c66071b7
change-id: 20250225-am65-cpsw-xdp-zc-2af9e4be1356

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


