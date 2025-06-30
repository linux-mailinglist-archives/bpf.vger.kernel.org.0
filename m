Return-Path: <bpf+bounces-61892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5055AEE900
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 23:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D613E11A2
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 21:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD92E5404;
	Mon, 30 Jun 2025 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMphcLvU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15BB1FBCB0;
	Mon, 30 Jun 2025 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317245; cv=none; b=uR+wiSzHi9uPKgCKgrTr9ITOfQY7t0x2pc1iBchKYeGfqw33J+k3JE7KEwdjLyisfUbZMl6warDiU/K6NZmRiv50UBn8FtKq6FM4IUMDEwdLH4x0yFOrJYsUppymtUBFCnOtYKSs1sf169tQhOUECcPsBSDuRH5J1BtjHJqT690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317245; c=relaxed/simple;
	bh=fd5TTcR4xrv7LlfCWv7RjAxXvv5McMMYbPwkZziGVRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U4zWzkinsh1kLnEfg7yXQoQa8e8cn0uYIag5S3BJa7NYKOHdEevHhmJwlSA6DEN+LIp7cMFJOHd9J4vQMapmZbE7ysZ4eSi7WE0YUzNE9Etmp7RFJJbGO6OCnjUW5V3D47SvxskZZOoPzjxMQ+mhkx+GG4Qi227sBib4hkUoHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMphcLvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AE6C4CEE3;
	Mon, 30 Jun 2025 21:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751317244;
	bh=fd5TTcR4xrv7LlfCWv7RjAxXvv5McMMYbPwkZziGVRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iMphcLvUTdKfDPiBseFwOr9hJvu0BIEMQEKlVDH+c/caveDzE4A5xuPjE4ElHpaat
	 OHHGxobNGnvLKE6hA/pi/87wuleOXhn+RVEdUvl//rPt/R+vgIK1n0b/D+S62/jW1C
	 JoH7MXtOW/gVhSxma8+DwfU9D2L9m9DK3nnABNw+kCPhCYRPbEUow/7h7ads+2O5OV
	 A7bjbH+t4Fo7zTowx0Bvqc2VNF9d/+jrJzlxJ0vpnbfD8ljP9hSB1P7ad0Ets7WiZj
	 axcGW2/QzWxDO8yU5FtYE3A9gufjbbLk/TVF+wyiGs5a1C+aUMxOPointR7lUdBGG7
	 EFOj7k8OORAjQ==
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
	tglx@linutronix.de,
	akpm@linux-foundation.org,
	guoweikang.kernel@gmail.com,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 03/14] um: vector: Reduce stack usage in vector_eth_configure()
Date: Mon, 30 Jun 2025 16:46:28 -0400
Message-Id: <20250630204639.1358777-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630204639.1358777-1-sashal@kernel.org>
References: <20250630204639.1358777-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.95
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
index 2baa8d4a33ed3..1a068859a4185 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1600,35 +1600,19 @@ static void vector_eth_configure(
 
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


