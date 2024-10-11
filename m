Return-Path: <bpf+bounces-41727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60089999F95
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 11:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A78AB219ED
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 09:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212A820C480;
	Fri, 11 Oct 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ooNSTFEP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i1LeZAFi"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6EF804;
	Fri, 11 Oct 2024 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637273; cv=none; b=vCcH+wWSrXVHIdbstfXmY7Hw7v2kjyul9RVRw2CeOQRxnPFq5E8g+LYrB2hVc09ex3Iy1HWm3uD/aSAAewmyhYv1gdd7Fke3GUxeC/sCPY6wVNQqWyRxjuRPhqVEqnwtuOnCY2DR+FAWCRjn/WdnetkSyeghVKL5O4WqebFV5WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637273; c=relaxed/simple;
	bh=zRsBZmcR44mwRdEcxQ8uNtRRLKAB0Wf+n8rpm6sYX0Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ptcEqjrMcmhZNyGTAlTg80naqkKskyZ4uEYaRnNHNvozA7S14McCmo4nzDDPHTfBMzOmTLKOmC54D5AzLGmfXFff9+yDIjeh+kF0qGD1gA7pc63sBN7xi/FJkY4Uym32aSrZUr2zsU72lsSf7BjT+ApgRq97FkXfBKlsRWl0f8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ooNSTFEP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i1LeZAFi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728637269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SNoU83pdmMYp5IKr04g1xQTk3F9nU+Iqgxe0aJZi9iw=;
	b=ooNSTFEP6Ppu0CV2vMF1T4rqCPDatCZV82WtOtEimdBd4Ce5B+FwmdH6AiWt0nSJ4MggKz
	+WNE8czKRWGaCFISZ1Ay7sAIVLhVYwr/PDhBtczcH/XmIfXJqlNrQfB4Fw+4c5HiSiXlpk
	MM1qO/PiOCVX3LpooC6mOq/E66iMMutUufmwXLQoxMM/F8d56KdzZgF7B8S/nSwPR+k7Qx
	1qXefdUeTN99sSSSnPQmquxemsQBOGS5JySDz7c0GWwQvJ7pxmtKd74LKlSPtH5EJT1MeY
	KPRy4ntfUuV3eZexBzpbU5AM0SgM2QNbDFXLdQMvlxZ2pqii0XKBZ7tMphpOzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728637269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SNoU83pdmMYp5IKr04g1xQTk3F9nU+Iqgxe0aJZi9iw=;
	b=i1LeZAFiJQYCBjQcewW0IA/jA2nuHfkFZ/Om+K3Cx7lxV2/Bed3MRIYOwzhLSKwI0Z6NnR
	UqjGcPCKZLM/AgCA==
Subject: [PATCH iwl-next v8 0/6] igb: Add support for AF_XDP zero-copy
Date: Fri, 11 Oct 2024 11:00:58 +0200
Message-Id: <20241011-b4-igb_zero_copy-v8-0-83862f726a9e@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAErpCGcC/4XOwWrDMAwG4FcpPs/DTmI77NT3GKNYjtwIgl3sN
 E1b8u4TOewwOnb8JfT9eoqKhbCKj8NTFFyoUk4c+reDCKNPZ5Q0cBaNajrltJbQSTrD6YEln0K
 +3CWAU77VGEBFwWfgK0ooPoWRD9N1mnh4KRhp3Xs+Bd0mmXCdxRdvRqpzLvf9gcXs+7+7FiOVj
 G3sjNG6Ba2PE6XrXHKi9X3AHVzsf4hlpIMItneOkf4V4n4QrZR7gThGmtYYa23vh2B/I9u2fQO
 NyWupXQEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4346; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=zRsBZmcR44mwRdEcxQ8uNtRRLKAB0Wf+n8rpm6sYX0Q=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnCOlS3eky7C00qRl6tH9wz1qVg4PJXePyuWaMd
 MUF7SjV9OOJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZwjpUgAKCRDBk9HyqkZz
 gjJgD/9qenkSprkR07E3a9KWjoJg4Nli8NZaKH4dZPtW4a2pFkYcFLwGF3QXHqfNKzqyKmeLpNW
 gKhQCEbkIay0f/qY1+P0FasHeie+gFvqUFHkHV60UTn4FtDpY5KvITidNnGr0jOlEcPXmzpbHCb
 9/O/sGav/A8zj+Wa9rrcWCs85QOKj2bodTNw4HyockPjzaKnzD4apuLi0ca+2cscRBjUkLgdWuh
 PtnQS4rIJ5INJ+Y+lfzLYqYVQ853Q9mzs3jysmmRv++bH9CCSfImgzhxKyqwXk+fDXqhtRxzNlL
 SG6o0iaa/gyLrOyX93qtiPhc2RnoXz83cdH64gq2Uj+JG/gT/ZtVlENFozODk3hiK4oMV5spsus
 m+jNoDC9X47x8Ig9Q+xcntYvZH9d3cRs3BakQrWJv6Pw2plDKCYlp3IA+Pr8WsavSm1HPOqcGYc
 pRneUcSdD05fNS6P6rkxlvhQ2TTZDTitVRDrUTwfMMcrhj3MuT5HoO1yp+x2Gdp14ZEx7hjb2hM
 kM0/LwykJck8pezscrfiJ7QoXslCE/ug4NwpRNLUarTjG21Q0XF0AdxsjB0V895lAJ+IGiyGvPZ
 MTlMw1FMxGoKoTqsQSXW9Qyk/qbbn0XPgU5xVLPH5Z2tV8l8FssYS9iuNvo1bTIBAkBydbEa5rS
 dhJBsscAFVoCZqg==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

This is version v8 of the AF_XDP zero-copy support for igb. Since Sriram's
duties changed I am sending this instead. Additionally, I've tested this on
real hardware, Intel i210 [1].

Changes since v7:

 - Collect tags
 - Split patches (Maciej)
 - Use read once xsk_pool pointer in igb_alloc_rx_buffers_zc() (Maciej)
 - Add FIXME about RS bit in Tx path (Maciej)
 - Link to v7: https://lore.kernel.org/r/20241007-b4-igb_zero_copy-v7-0-23556668adc6@linutronix.de

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
Kurt Kanzenbach (1):
      igb: Add XDP finalize and stats update functions

Sriram Yagnaraman (5):
      igb: Remove static qualifiers
      igb: Introduce igb_xdp_is_enabled()
      igb: Introduce XSK data structures and helpers
      igb: Add AF_XDP zero-copy Rx support
      igb: Add AF_XDP zero-copy Tx support

 drivers/net/ethernet/intel/igb/Makefile   |   2 +-
 drivers/net/ethernet/intel/igb/igb.h      |  58 ++-
 drivers/net/ethernet/intel/igb/igb_main.c | 248 ++++++++-----
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 567 ++++++++++++++++++++++++++++++
 4 files changed, 792 insertions(+), 83 deletions(-)
---
base-commit: f5cae3d7f24df1e8ebcc8b5890a655fa151f3461
change-id: 20240711-b4-igb_zero_copy-bb70a31ecb0f

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


