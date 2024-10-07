Return-Path: <bpf+bounces-41113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F08992BCF
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 14:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B37B0B25791
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBC91C2324;
	Mon,  7 Oct 2024 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kgiFrxQ0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6lES4Fbi"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8C1C173D;
	Mon,  7 Oct 2024 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304294; cv=none; b=hhYs74WMqKUm4ZjrHb/yD0WjaDPfCx2KSJYQkUUXTFzWjQMpTSyDQvVoft9rBisjWRjHxQv9mps1uFeMq7ZEqMelJ3u67ERTXpcwdkTrTRm2UyQu7SIjEBUB7WbfAEdtAo3E0jKZnenYGrGNpJ9nYP+Mh2w8padJFpt4gtzbdNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304294; c=relaxed/simple;
	bh=cSr16lHesup0jyZsTm8sLeSAjC1XAE7gBsDOVQ5e4JU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xbju8BDR4zDTSavZysWZZVXVa8TzayODqaXOTlhCMsYrqnDV/4+XxSi+CTTAg7cAngW/dWxd5JPHb9a5Xv1Rb6Eyi9wKTF/rTGDUT5liGln8GzwzU7OfSiOIA1E1wcGiZSMP6dNWLG3g54YG2+qDr6358NpiEG6pE+A4L98xlIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kgiFrxQ0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6lES4Fbi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728304289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n80mNWK26mFk+wt7hmAWZnpX8w+IrgjsndVOCDRIpmw=;
	b=kgiFrxQ04lY6D31fMCum7QILrsSiNRvqfK3W7T8Sb6/09kPFtBql69t6hMtFJlOh/N16au
	8QAXgu3iADVWzAlYBINBUFs28FVjG1O+jLYbAtFdP5kLikmgwOXmr3o42+ndE3UL4CWNkY
	HeEdKRa0jgCxgqMxy8K3ktsqHMPAjRCRJEErUGEqjLn7KbYjzKotkyYWQ+MyzCA+3DFh6p
	NDLsr9iDDqA3WldZQkSTbgJgiL2OeIaXncaJePBul3rYJl3ay9FmX87ij698yy+oz+E3HY
	TM8W7AFWBpmlM4x+VCoNjTkop/IzTDTdZZdrxR04kixCXF7Ld+Psros3rZUluQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728304289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n80mNWK26mFk+wt7hmAWZnpX8w+IrgjsndVOCDRIpmw=;
	b=6lES4Fbi17ybIvKVBiXpXUFozPYE13Qb+N33Nic4R1xhLs2CKi14AO//E+AoTGJwdOaxxJ
	5FbKbaYmZqar3mBw==
Subject: [PATCH iwl-next v7 0/5] igb: Add support for AF_XDP zero-copy
Date: Mon, 07 Oct 2024 14:31:22 +0200
Message-Id: <20241007-b4-igb_zero_copy-v7-0-23556668adc6@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJrUA2cC/4WOQQqDMBREryJZNyXRaKSr3qMU8euPfpBEErVa8
 e4NLguly5lh3szOAnrCwG7JzjwuFMjZKPQlYU1f2w45tVGzVKRKaCk5KE4dVG/0rmrcuHEALep
 MYgPCsFiDOiAHX9umj0U7D0M0R4+G1nPnweg1cIvrxJ4x6SlMzm/ngSU/899bS84FN5lReS5lB
 lLeB7Lz5J2l9driCVyKf5AiQhQYKEqtI6T8hhzH8QFgrhf2GAEAAA==
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
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3979; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=cSr16lHesup0jyZsTm8sLeSAjC1XAE7gBsDOVQ5e4JU=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnA9SfeeE7eiysY3Z4ekSZ3cnBTHezh25rJ8ZTx
 IF1aAvXFj2JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZwPUnwAKCRDBk9HyqkZz
 gtybD/9uAO8asrLO30z7y9hDi2VfpP0uJpDNT34qFt0fWBDe3/C2UdkuKhBW1LIG+oSRd7jMD1g
 t6CdfdQTVc1Vv6uChpgAFibi4z4DM2WLzZxOKsVnmexrKLuDXFFhSmBMFvI2mmwfdgKF4iZKThA
 Y/lCZNfPCR9WZbt1BrkC027ETR3pqQqAiyLQqnVfxZh8oYmYaqXQZcBi+1gF9+FJAnggV+grMHn
 KwWwhZOoKFtZPy6ImPAwMCArlQ1eyZZMvB6TL+cEu84xJxHXKFGLt5rZPHU0mqb0FK8YoiTdIUj
 HhQYOPks65HK9a5DE6bJ9QZS1bARCoab97jn07eYDMFn1PJh1A5xMvwg/Tl8zyNvfsVGOpDjnR/
 Q1XtKXxNVizN1hafyJs/0wdbKgdzLmwvGSwsAUOIHT1MEtxqcduFsgn1jJMgidNe9ljCyqBluUd
 UlPef6WoQDWyQNF1Bb8v+wmLFKvzzgWHb687W5S1oarmhGXq2jgoNK71uE+wzqOgWEq/TDd+Mhu
 3Y2BIV461HPpGMkJXS8jft6dZyykPK0J2Sy0MUUsGoLeAj87Zz89laWo2VLUWt7p0Ghh+PV5nyo
 Ze/klIIjFHHk4Y2yHKOihvZ98lzIxKToVTOmxB04r/rVHbbep8wiYmI1lwRFGv4mCCMgoZivJRe
 wtc96/IoysbIqmQ==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

This is version v7 of the AF_XDP zero-copy support for igb. Since Sriram's
duties changed I am sending this instead. Additionally, I've tested this on
real hardware, Intel i210 [1].

Changes since v6:

 - Rebase to v6.12
 - Collect tags
 - Merged first patch via -net
 - Inline small functions (Maciej)
 - Read xdp_prog only once per NAPI cycle (Maciej)
 - Use u32 for stack based variables (Maciej)
 - Link to v6: https://lore.kernel.org/r/20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de

Changes since v5:

 - Rebase to 6.11
 - Fix set-but-unused variable warnings
 - Split first patches (Maciej)
 - Add READ/WRITE_ONCE() for xsk_pool and xdp_prog (Maciej)
 - Add synchronize_net() (Maciej)
 - Remove IGB_RING_FLAG_AF_XDP_ZC (Maciej)
 - Add NETDEV_XDP_ACT_XSK_ZEROCOPY to last patch (Maciej)
 - Update Rx ntc handling (Maciej)
 - Move stats update and xdp finalize to common functions (Maciej)
 - "Likelyfy" XDP_REDIRECT case (Maciej)
 - Check Tx disabled and carrier in igb_xmit_zc() (Maciej)
 - RCT (Maciej)
 - Link to v5: https://lore.kernel.org/r/20240711-b4-igb_zero_copy-v5-0-f3f455113b11@linutronix.de

Changes since v4:

 - Rebase to v6.10
 - Fix issue reported by kernel test robot
 - Provide napi_id for xdp_rxq_info_reg() so that busy polling works
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
Sriram Yagnaraman (5):
      igb: Remove static qualifiers
      igb: Introduce igb_xdp_is_enabled()
      igb: Introduce XSK data structures and helpers
      igb: Add AF_XDP zero-copy Rx support
      igb: Add AF_XDP zero-copy Tx support

 drivers/net/ethernet/intel/igb/Makefile   |   2 +-
 drivers/net/ethernet/intel/igb/igb.h      |  57 ++-
 drivers/net/ethernet/intel/igb/igb_main.c | 247 ++++++++-----
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 560 ++++++++++++++++++++++++++++++
 4 files changed, 783 insertions(+), 83 deletions(-)
---
base-commit: 1e37963a388fe7361259f1a769cef4bac2012534
change-id: 20240711-b4-igb_zero_copy-bb70a31ecb0f

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


