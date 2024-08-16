Return-Path: <bpf+bounces-37354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19765954564
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 11:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C122B28357A
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 09:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50EC1422A6;
	Fri, 16 Aug 2024 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CHoz5yWQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H/zBfc8L"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07B13D89D;
	Fri, 16 Aug 2024 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800254; cv=none; b=pMqW6pWluIFz8HUONofrqB80u5uFnQnib6cvNuouu6gsLaJ7Mh0zFQwHkvvT6zNdefLylE7xnBD/ogmEtmEZcUhmqU5fSihuKz2t+PpzZhDfA6MFJourCgUjEhyrpphoUn7/TWQW50h6zuRNCnvYSEMQKhVr7IFkFNZygSuYhpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800254; c=relaxed/simple;
	bh=Gb6QRR5jysbQSl51/QdRrHdyDo168wqI4HXcsDMjKlc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hhcy9N/oc2kbX8Hb1Z3WSm2bECZQxXNumBavZ6XURLfoTpMeNVXlh6qddRPvlAkWvd44Zc4/nyfnGYrnwOwczw8GP4/a+mtmJAuiyVPGwqXX7dlpuQ7P4NYCICz/u6IUw/A4aWRmDQ8fOH/9+MSqQk+PJ7EqmRmltksD4+OrbiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CHoz5yWQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H/zBfc8L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723800244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OjQqFntsvDuAxQl80KmsrmmiyaLtqImbfI9hDyu3YTc=;
	b=CHoz5yWQy2I6fMiB2osjin2/oHnZKxCA6EdFzNrZUyhzHwWHM5G8ryqlNXRG6KBkLX6SRQ
	BomOf5/XGhFltDB2iLdJbBzStURNEfdrl2QbX2X7dEIEMM7BWxAxnTGc88T249+UHHhcQC
	Vv4gC8W5pkjLra2lQSNSAi/Z0EH+6ybCjvteqxN+EeVE4n4DtC1oN5LXfXpbQjFZUqEMTJ
	jj48nk4xLMAfJ3yhloQyMRCRwulQ9qhqDpHbOOsSHk/akZykwxLUUuqk5N2ZivSbgaL/z8
	gp9tJOx2EmLeDsrGjb47IQOSz84XytGeNAtDziu3yb+QCKNnQNaGdk7uWfwfWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723800244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OjQqFntsvDuAxQl80KmsrmmiyaLtqImbfI9hDyu3YTc=;
	b=H/zBfc8LRkFappTM2UUOOlYym42O1KXlfJ8xkYSUHNfSMj7XmmHkjDVOmlmyWST4FV25/f
	3iHWzzXzfHDt0MAg==
Subject: [PATCH iwl-next v6 0/6] igb: Add support for AF_XDP zero-copy
Date: Fri, 16 Aug 2024 11:23:59 +0200
Message-Id: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK8av2YC/3WOQQqDMBREryJ/3ZRETYWueo8iksQf/RASSdRqx
 bs3uO/yzTC8OSBhJEzwLA6IuFKi4DM8bgWYUfkBGfWZoeRlzRshmK4ZDbr7YgydCdPOtG64qgQ
 azS3kmVYJmY7KmzEP/eJcDqeIlrbL8wb6OOZxm6HNzUhpDnG/Dqzy6v+7Vsk4s5WtpRSi0kK8H
 PlljsHTdu8R2vM8f8vSHIrTAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3714; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=Gb6QRR5jysbQSl51/QdRrHdyDo168wqI4HXcsDMjKlc=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBmvxqxtR5pqRONVvDOxYo0Lh3MAXft5V3TPSMsU
 Gk5WCcQ23qJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZr8asQAKCRDBk9HyqkZz
 gj0UEACNvHqM4f+/BKtaYYeNJRf72G1rUutJ73ULy6YPaTonvc8Sj8j6/zq7uGOgPGLB4WbooWT
 YxtOiyqQokV7yybWNQjmYEMGFnp0EIWM2gZL0MJg+dyCydViXN4fpTfcT+6gMwZxBf+iCwrpsOs
 tv9p05n8GPp5Q1OrD3T512nr0QW9LWk8uDshEnLsKKTrL9Y5lF2eOXPT89B/cdt5dSBCpypE5rY
 pxupUmHgorJv9oxIJ2o+LdqnCRmi1VfikIxUF/1PQRcPz93ncpEihMJBrWS/oJvrUK4SfOVbQll
 uuJPMsheIK4r1vgejkMdcQmPXrw0+IaAJ5M8vSoYDLIW/9MemGWtjWqCemtnuSYXC5zacS1RkFd
 Ov9TBw6CfUy6GM2KoZGbrAOtqgeBJcAwanEsKJhv84ZBe8XTA9re5yrMh6GCChB9BqtkBtFoNuu
 thlH6WEVlRdXU1PlbYCPTWv6sA2Qf87UQc5MHRjYBGb7XehfkMx808Mknn5tSAPgEPq6vRXn3MO
 87i+RE2Fvlh8SXliyxASXCQ6ICcag1VLyjG7F6mGwwpKwDJQ7EQVExRqxgsEVmvoip0px9AApso
 bir1D4q0j7QTfewLoz4BEFvz/Y+IOUxtiGzTHBixGEtRRUaTFVD3AhU/IzfB3ORQVG4PaVddBIG
 aNY5+A0rmgo0iKQ==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

This is version 6 of the AF_XDP zero-copy support for igb. Since Sriram's
duties changed I am sending this instead. Additionally, I've tested this on
real hardware, Intel i210 [1].

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
Sriram Yagnaraman (6):
      igb: Always call igb_xdp_ring_update_tail() under Tx lock
      igb: Remove static qualifiers
      igb: Introduce igb_xdp_is_enabled()
      igb: Introduce XSK data structures and helpers
      igb: Add AF_XDP zero-copy Rx support
      igb: Add AF_XDP zero-copy Tx support

 drivers/net/ethernet/intel/igb/Makefile   |   2 +-
 drivers/net/ethernet/intel/igb/igb.h      |  36 +-
 drivers/net/ethernet/intel/igb/igb_main.c | 232 ++++++++----
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 561 ++++++++++++++++++++++++++++++
 4 files changed, 770 insertions(+), 61 deletions(-)
---
base-commit: e7d731326ef0622f103e5ed47d3405f71cdcd7f6
change-id: 20240711-b4-igb_zero_copy-bb70a31ecb0f

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


