Return-Path: <bpf+bounces-61890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90393AEE8E2
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 23:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4BD1BC2CDE
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC432E2EF2;
	Mon, 30 Jun 2025 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoo6iH4j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE76323497B;
	Mon, 30 Jun 2025 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317182; cv=none; b=oRws6/bq0tUJLSTQyTwxvDyWfTCqouUrRpdhMsPSVCGJm5BLx8rXYCoBPy2SnTCVSw/TcXNmbjaF39OuPC2SfK9Yq0sIKf8z7J55apf+0Sz5JMcWANQueWI+OoDH9IOcBxinB9rx+oJQXbpEgWqhwDVfU+U8hUMOREfMdOWNwLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317182; c=relaxed/simple;
	bh=l0jJzT6z2oJIpMQkpEb7GhJRoc5xgqv3OPQRXqyvSwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMQG94dtPQqoY7rA7DI4lhiWCTX2ZiSMvf26/EZwRQyyHd4xYc4byBIr5dvrm2i17kuy6bRdN7sn5smb7TZzeW05EnU0qWYrfgQs1uhBwO3meHMS4mdXwIMT6z9gJrQ5Q/a/4nVCtLAywXW0v6/2FnEwVSx4gTtvvMCDNfylXIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoo6iH4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DF6C4CEEB;
	Mon, 30 Jun 2025 20:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751317181;
	bh=l0jJzT6z2oJIpMQkpEb7GhJRoc5xgqv3OPQRXqyvSwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eoo6iH4jBVayj0zk5LqBDaIpXJLVTm7XX5VTQZ7+JBEDFznarQK8dp+b8Kqz2bqYL
	 NCG48oeL+RNJRnVRafvfSOqA/nAqYWtfe+5CUsjuj8c2UHez9begMn1srnXpLAufn5
	 mTvV6lIE7yVxwWopizMNRmTTlafx0v5yKcZywNsFB/haKONxYJ2sgGfucCqCM8Qi/O
	 +7WQ+0eXmv9eBAeZcVwLejR3tz3/f0BuvcxOIORLtUB6e2+ppqxWgMxOyb5Gfg7laE
	 QH2c3EaQuoag6f6NXLe/XHROI5Yi8WISSy3+RZXQ9d01u/NbtiEkZrhCGbWUFy1NJk
	 kj2FjowgF4SHA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	kernel test robot <lkp@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	geert@linux-m68k.org,
	agordeev@linux.ibm.com,
	guoweikang.kernel@gmail.com,
	tglx@linutronix.de,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 03/21] um: vector: Reduce stack usage in vector_eth_configure()
Date: Mon, 30 Jun 2025 16:45:18 -0400
Message-Id: <20250630204536.1358327-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630204536.1358327-1-sashal@kernel.org>
References: <20250630204536.1358327-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.35
Content-Transfer-Encoding: 8bit

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit 2d65fc13be85c336c56af7077f08ccd3a3a15a4a ]

When compiling with clang (19.1.7), initializing *vp using a compound
literal may result in excessive stack usage. Fix it by initializing the
required fields of *vp individually.

Without this patch:

$ objdump -d arch/um/drivers/vector_kern.o | ./scripts/checkstack.pl x86_64 0
...
0x0000000000000540 vector_eth_configure [vector_kern.o]:1472
...

With this patch:

$ objdump -d arch/um/drivers/vector_kern.o | ./scripts/checkstack.pl x86_64 0
...
0x0000000000000540 vector_eth_configure [vector_kern.o]:208
...

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506221017.WtB7Usua-lkp@intel.com/
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20250623110829.314864-1-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a real bug**: The commit addresses excessive stack usage
   (1472 bytes) that can lead to stack overflow, especially problematic
   on systems with limited kernel stack space. This is a legitimate bug
   that affects system stability.

2. **Compiler-specific issue with real impact**: While triggered by
   clang 19.1.7's handling of compound literals, the resulting stack
   usage of 1472 bytes is genuinely excessive and dangerous regardless
   of the compiler quirk that exposed it.

3. **Simple and safe fix**: The change is purely mechanical - converting
   from compound literal initialization to field-by-field
   initialization:
  ```c
  // From:
  *vp = ((struct vector_private) { .field = value, ... });
  // To:
  vp->field = value;
  ```

4. **Minimal risk**: The fix doesn't change any logic or functionality.
   It only changes how the structure is initialized, making it extremely
   unlikely to introduce regressions.

5. **Precedent from similar commits**: Looking at the historical commits
   marked "YES" for backporting:
   - Similar Commit #1: Reduced stack frame in qed driver using
     `noinline_for_stack`
   - Similar Commit #4: Reduced stack usage in ethtool with clang using
     `noinline_for_stack`

   Both addressed the same class of problem (excessive stack usage with
clang) and were considered suitable for stable.

6. **Measurable improvement**: The stack usage reduction from 1472 to
   208 bytes is dramatic and well-documented by the kernel test robot,
   providing clear evidence of the fix's effectiveness.

The commit meets the stable kernel criteria of fixing an important bug
with minimal risk and a contained change. While it doesn't explicitly
include a "Cc: stable" tag, the nature of the fix (preventing potential
stack overflow) makes it a good candidate for stable backporting.

 arch/um/drivers/vector_kern.c | 42 +++++++++++------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 64c09db392c16..7a88b13d289f1 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1592,35 +1592,19 @@ static void vector_eth_configure(
 
 	device->dev = dev;
 
-	*vp = ((struct vector_private)
-		{
-		.list			= LIST_HEAD_INIT(vp->list),
-		.dev			= dev,
-		.unit			= n,
-		.options		= get_transport_options(def),
-		.rx_irq			= 0,
-		.tx_irq			= 0,
-		.parsed			= def,
-		.max_packet		= get_mtu(def) + ETH_HEADER_OTHER,
-		/* TODO - we need to calculate headroom so that ip header
-		 * is 16 byte aligned all the time
-		 */
-		.headroom		= get_headroom(def),
-		.form_header		= NULL,
-		.verify_header		= NULL,
-		.header_rxbuffer	= NULL,
-		.header_txbuffer	= NULL,
-		.header_size		= 0,
-		.rx_header_size		= 0,
-		.rexmit_scheduled	= false,
-		.opened			= false,
-		.transport_data		= NULL,
-		.in_write_poll		= false,
-		.coalesce		= 2,
-		.req_size		= get_req_size(def),
-		.in_error		= false,
-		.bpf			= NULL
-	});
+	INIT_LIST_HEAD(&vp->list);
+	vp->dev		= dev;
+	vp->unit	= n;
+	vp->options	= get_transport_options(def);
+	vp->parsed	= def;
+	vp->max_packet	= get_mtu(def) + ETH_HEADER_OTHER;
+	/*
+	 * TODO - we need to calculate headroom so that ip header
+	 * is 16 byte aligned all the time
+	 */
+	vp->headroom	= get_headroom(def);
+	vp->coalesce	= 2;
+	vp->req_size	= get_req_size(def);
 
 	dev->features = dev->hw_features = (NETIF_F_SG | NETIF_F_FRAGLIST);
 	INIT_WORK(&vp->reset_tx, vector_reset_tx);
-- 
2.39.5


