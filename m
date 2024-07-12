Return-Path: <bpf+bounces-34634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D21E92F75E
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 10:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD5CB22B75
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F651442ED;
	Fri, 12 Jul 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="um9lUo34";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+I5gGEvC"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3003142903;
	Fri, 12 Jul 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774556; cv=none; b=ZKe1JQ10p9OHEvG+XYD7FZ3c/MYzs83T/t++WAqY/qCUd5StHriGYuMuVak3NT3lUWUgKbgy6dceC0IGowSrBJFffwdcOusUNLxcEli2C8AENtCnuiBetH1HjWH32ChYAU13k1lJlJXckmjRKb1fFVxxuvU38PBH1VGygTY2Qlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774556; c=relaxed/simple;
	bh=bzZ/1VBPkM1Y2l73oHvsrDybWmcjoURQWVULOSP7hAQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Swp/td94K8S75wvrdbm5dOSUo/X8dbKVPfyzs6J76nHV/9O2HJeMkubjB2PniIxoE117wQcwvci83fk9+f2A1pv8IsCyKc/LGcSt96ijudnpH4wrSmzrOmLnOhsIWD2LjTLOyZFEjezyEUI/c2GiCeNnWqd3H2iWC2vDdYjMyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=um9lUo34; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+I5gGEvC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720774552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Z/Fz9ARX3TbHcqBtR1E6kdAR1Rn0Sr+B9M8f/oJ2vk=;
	b=um9lUo348lxFZFvB3wzvTPZJKIjJ2IjeQUu2BCS5DAlIkdAzGGHYxHutGER+8i2SGxMaGm
	rkEJyzH8yE0d/NKFK7MNbepB8O2Vc1GXpXnTLXENQ2LU5BUtHfwYKReTbvq3aEJsBy+ieP
	FV3kx8bzFbKIYwPZgFz0G+CrURyxg2MyN8qXxbMQEj4ljZVHXVYHYahKera26oAUzx3tWr
	c+LI9jCrKzRdY78XRdcYOYRJa3XcnN/BAby1kVKXRMnBh53f9KRDeW/skgkGNtDA9V1iIO
	QIS4HyMoNe6ue4myIH6i+aLYwEPoXOMuYppIxeMZ6HyMMykCBhsM0HuLgXKt8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720774552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Z/Fz9ARX3TbHcqBtR1E6kdAR1Rn0Sr+B9M8f/oJ2vk=;
	b=+I5gGEvCnszFkumtMEYHEnq+kaNihomMmBESMr9BGswdGr0C7tc0UXKB7hKYMWLeKV7ba7
	gktKEr1/KbKbfGAQ==
Subject: [PATCH iwl-next v5 0/4] igb: Add support for AF_XDP zero-copy
Date: Fri, 12 Jul 2024 10:55:28 +0200
Message-Id: <20240711-b4-igb_zero_copy-v5-0-f3f455113b11@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIDvkGYC/x2N0QrCMAwAf2Xk2UA7JwN/RWQ0NdsCpR2p0+nYv
 xt8vIPjdqiswhWuzQ7KL6lSssHl1ECcQ54Y5WEMrWs713uP1KFMNHxZyxDL8kGi3oWz50huBMs
 oVEbSkONsYV5TMrkoj7L9PzeQd8LM2xPux/EDEjdwyIEAAAA=
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Benjamin Steinke <benjamin.steinke@woks-audio.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2983; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=bzZ/1VBPkM1Y2l73oHvsrDybWmcjoURQWVULOSP7hAQ=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBmkO+V+xXly1mMzX8r36JIFCPESwSq+6+l1mJNR
 4TYFZNWPkqJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZpDvlQAKCRDBk9HyqkZz
 gk+7EACInF4oC1+RbgHdj9yu93XqJE7Qx+bSmOJwzbZY6QG0fkzw9/sTQfXnj+QmNmeKHzAK3As
 fYCDb0dyi2cfglpFy2WS0MHSWPdzVkJmbtPS1gUHTF+w19nftS8on90te2olQaSxjeuJ7u91C20
 SMwXsXH8ErKsZSJ5Xethl3pPR49uDq3D8tDjVoW60LYwOxRVJ71v/VJMlqVT9gkaKVpmyhcGi8M
 PmZs9jWF61304AeI4XYFXq9oJ//dPT/ET6U6oN1p0nxcwsFfjgabgDIGx6PwWPcbpZaEwh2d9gQ
 5VFGnRnzq1PRmBI+MZit5xbiyWYhZWb9omsIHoKB/zgQOPORraZy5PgBdiEo66hi1pr4lPhI7y5
 CY2F7ill3v6Oa3PgZfmlhDtg4wgtgO4XsPMHzJslVsmuUdoUolcQssG0hknOmJTWH65zB0ezDYW
 13tfngMJ68bwwNB6gwR5+6hvo8oU/VaSurXryyY0JKbiE3Yhw+NA5L7AMJRyoAbS0WxCbQ1Ni8H
 XLPv7g8vltRspA2xxRxuvIKdYe2g/m8TCfGRnxzaZnHyhH8aLkKdHsScM2a+CJRWdSNIehSJHUR
 wzrDPJGGPX4UQc5N7V2gF5Ic9455Sw/fRxo3ob+rZrIBcrhEnJF4uVp78hQneu/CVk9aEe3bivD
 W9u8JDUX/GccYgA==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

This is version 5 of the AF_XDP zero-copy support for igb. Since Sriram's
duties changed I am sending this instead. Additionally, I've tested this on
real hardware, Intel i210 [1].

Changes since v4:

 - Rebase to v6.10
 - Fix issue reported by kernel test robot
 - Provide napi_id for for xdp_rxq_info_reg() so that busy polling works
 - Set olinfo_status in igb_xmit_zc() so that frames are transmitted

Link to v4: https://lore.kernel.org/intel-wired-lan/20230804084051.14194-1-sriram.yagnaraman@est.tech/

[1] - https://github.com/Linutronix/TSN-Testbench/tree/main/tests/busypolling_i210

Original cover letter:

The first couple of patches adds helper funcctions to prepare for AF_XDP
zero-copy support which comes in the last couple of patches, one each
for Rx and TX paths.

As mentioned in v1 patchset [0], I don't have access to an actual IGB
device to provide correct performance numbers. I have used Intel 82576EB
emulator in QEMU [1] to test the changes to IGB driver.

The tests use one isolated vCPU for RX/TX and one isolated vCPU for the
xdp-sock application [2]. Hope these measurements provide at the least
some indication on the increase in performance when using ZC, especially
in the TX path. It would be awesome if someone with a real IGB NIC can
test the patch.

AF_XDP performance using 64 byte packets in Kpps.
Benchmark:	XDP-SKB		XDP-DRV		XDP-DRV(ZC)
rxdrop		220		235		350
txpush		1.000		1.000		410
l2fwd 		1.000		1.000		200

AF_XDP performance using 1500 byte packets in Kpps.
Benchmark:	XDP-SKB		XDP-DRV		XDP-DRV(ZC)
rxdrop		200		210		310
txpush		1.000		1.000		410
l2fwd 		0.900		1.000		160

[0]: https://lore.kernel.org/intel-wired-lan/20230704095915.9750-1-sriram.yagnaraman@est.tech/
[1]: https://www.qemu.org/docs/master/system/devices/igb.html
[2]: https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-example

v3->v4:
- NULL check buffer_info in igb_dump before dereferencing (Simon Horman)

v2->v3:
- Avoid TX unit hang when using AF_XDP zero-copy by setting time_stamp
  on the tx_buffer_info
- Fix uninitialized nb_buffs (Simon Horman)

v1->v2:
- Use batch XSK APIs (Maciej Fijalkowski)
- Follow reverse xmas tree convention and remove the ternary operator
  use (Simon Horman)

---
Sriram Yagnaraman (4):
      igb: prepare for AF_XDP zero-copy support
      igb: Introduce XSK data structures and helpers
      igb: add AF_XDP zero-copy Rx support
      igb: add AF_XDP zero-copy Tx support

 drivers/net/ethernet/intel/igb/Makefile   |   2 +-
 drivers/net/ethernet/intel/igb/igb.h      |  35 +-
 drivers/net/ethernet/intel/igb/igb_main.c | 189 ++++++++---
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 522 ++++++++++++++++++++++++++++++
 4 files changed, 700 insertions(+), 48 deletions(-)
---
base-commit: 2a4183f864dad50f84edb6b67a2807a438f944fd
change-id: 20240711-b4-igb_zero_copy-bb70a31ecb0f

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


