Return-Path: <bpf+bounces-61888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F40AEE8AF
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 22:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C96441F17
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 20:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A38B28A73C;
	Mon, 30 Jun 2025 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAM7Qt/q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7011885A5;
	Mon, 30 Jun 2025 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751317114; cv=none; b=O84087SAyVf06P273R9TsX/aiKB3WNWRluqJWylomTGdOUzzh29CXQhemjoM5CEkD28S2vAyjd+o4uSuupAVHtLxnDBGpEkFUzRdOuECdygvIWbsWyLxOu9xyDgmxs2ATLB7KYIi4L9G/Isi1Indmw4SvxxijUBzhWZoEulS9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751317114; c=relaxed/simple;
	bh=Zz1nS+miBXSOVdimTwx8BnW0//1SMhchoE4PdZERmj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cS8RpgobBA4kMCprfQMgAtZP0ZmbYMbJpVe3j0ZtWHiahDDVU0H9SonK+PzRPno2VgHbLVJBIFCqUCEMx/ufmIuOKo3u4lErGd0G7L6CF/Z7aFZg5JSalnnjLNlrtj68Qdppva1RLbksAp2mX2ea19/Tw2wkyLrtuX33/D7KaCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAM7Qt/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D632C4CEE3;
	Mon, 30 Jun 2025 20:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751317114;
	bh=Zz1nS+miBXSOVdimTwx8BnW0//1SMhchoE4PdZERmj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAM7Qt/qBXtvc03ruid0U2WS2qHHKhlrH2pxLA0qWpuSEPPJyN8v7G8Q1h59YNYdI
	 yiubN4YBaCnPKSxxkff699MlRy1mVbVRvPHRcD6WWQMsDWCoADOEdYr0qJAF3vIeHp
	 pk66uxIPX21AbZCvykpWQjB2Lg7MvY+zK3Lz1FJcDocHXMa67PPj2+eP4JqMSExG8V
	 KlF9nVQe2HsyhxM/hMoydyazKaINW69sQjmfyrkHwmA+YDWhF5RqvgWEIRT8wtrAmE
	 M3k1+Ocqs0R3ZIwiL+PWpdEV7SHarNMZzrcvKfjhrtwKF/v1xnuHERDCus4vpx54GS
	 RWhZqX+A1p3Ng==
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
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	guoweikang.kernel@gmail.com,
	tglx@linutronix.de,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.15 03/23] um: vector: Reduce stack usage in vector_eth_configure()
Date: Mon, 30 Jun 2025 16:44:08 -0400
Message-Id: <20250630204429.1357695-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630204429.1357695-1-sashal@kernel.org>
References: <20250630204429.1357695-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.4
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
index b97bb52dd5626..70f8d7e87fb81 100644
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


