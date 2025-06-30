Return-Path: <bpf+bounces-61895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30898AEE922
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 23:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D097A3E1529
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 21:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AD32E7F1D;
	Mon, 30 Jun 2025 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+glu4KO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC5290DB2;
	Mon, 30 Jun 2025 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317311; cv=none; b=WA1q4+jkGLSlHKNj+DnPaDC9s2nTHyp3zlKQaCTRLRfcAyVn+rw1r64mSSLKcDdUZbGk+PLovlZkggDZ0A9IL0yc8NEWgwk1Fz9jkEtMplyA8/xJBrvSKuwMj1kv5z1WBvdHpO+EixUbjjHP2jLUd9PiqvLdvJ1DolIE7ydtDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317311; c=relaxed/simple;
	bh=gbO8Q9MsevLLF5VsQv4jcp6XgaI8hqa4nce5a0JHavc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l0ux1EoZAVy/efu+5NbWWHyB0rqj1siCQFhQbd1sQcxYauHdBgXCWhmkD3LarzfXRaSA/OyBCkkKy/TOHKxYIuinCy0AUpjCMStKhC9sBmNNcL2qk5/bcHPE7PXXgAXDdff2KOQSzk269ps03y+mWcmEM5vrtSE6b5kmQW+y3aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+glu4KO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6C1C4CEEB;
	Mon, 30 Jun 2025 21:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751317311;
	bh=gbO8Q9MsevLLF5VsQv4jcp6XgaI8hqa4nce5a0JHavc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q+glu4KOGHUaZC+QLCAEDHMtBVJIFzqnIkaWFwc4m9MeTP3XeFZ54JUS9okDMB/St
	 rrzKg6QlcXxVUByBqXQRXHxmqadobJTXTWSw1fnUDTg/NDjX2KBbn8T/lqQPK46DtM
	 g9qLfS1w2NT1qfgA6I2fI1Avj6RfLD1Gi29AauxP3JIykS7nM4GS/xdazOwMtLop5W
	 u2zsnyzn3xEoWsJ8QhnpSpq24VIEfBMaVwOZD+r9J3m7F4TPzikedznP01TND8C8C2
	 Te3rKwHGD4C2gXqIxAf0EdylcJLtM06yhIv7HHxcHmsT5UGG2OVGoQrJez8+IN45nE
	 FkZt5LcWNp8Ew==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	kernel test robot <lkp@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	anton.ivanov@cambridgegreys.com,
	richard@nod.at,
	agordeev@linux.ibm.com,
	guoweikang.kernel@gmail.com,
	tglx@linutronix.de,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 2/7] um: vector: Reduce stack usage in vector_eth_configure()
Date: Mon, 30 Jun 2025 17:01:39 -0400
Message-Id: <20250630210144.1359448-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630210144.1359448-1-sashal@kernel.org>
References: <20250630210144.1359448-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.186
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
index c63ccf1ab4a20..41fc93ce4d372 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1603,35 +1603,19 @@ static void vector_eth_configure(
 
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
 	tasklet_setup(&vp->tx_poll, vector_tx_poll);
-- 
2.39.5


