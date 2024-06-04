Return-Path: <bpf+bounces-31303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F52C8FB22C
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 14:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7BEB23037
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 12:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97198146005;
	Tue,  4 Jun 2024 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTWmFolI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878033236;
	Tue,  4 Jun 2024 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504196; cv=none; b=TUIcAEjfBRxGkyg0vERZYBWbJ/U58PXY8gkQVZ3ybzQF7e/mS3AW2aOk3JEvTVJVKbMn0y9muUgbNc/CjWqLmuOD26+EJOj79kPCtfBeZroHPwHQPdZ2g+n+1x3fTHUDHuYDwJ4yUujuQoF3sEy6KPC3NAjFQIG9scPKkOKyVSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504196; c=relaxed/simple;
	bh=4JlS2aIeGj0k3WKqynWnDcOqAO2h670JTw/62kYLEi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ry2RufPGN4r98s9/J2cnPD7Y2GdDmB6PiEL5qDAE3vhMxXNYVYevcrxdP2p3xTLbKN+Dr44uZwWp3sW7gW1lXSZ2fvtS/8D3+vyuvJR8xFTX3WB6BJPHsP1tGKl7rH87Zxg2z4zO/eI6ywC4L0v/pos7TZCan6w1y4+eY98j7uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTWmFolI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35e50de01e5so225491f8f.3;
        Tue, 04 Jun 2024 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717504193; x=1718108993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SEy/JnpykSFlMVVDpNV9Nfzw4k+5jlopBP5r+KNm31Q=;
        b=XTWmFolI03BH6tB/cewd4dUM9itp14eQUCZuI8iiYq9DO+KPUrx1f/rhv5zbCEEGrg
         tViQTjY8EysxxrjG4ylcVo1ZjOzstlRvwo0iei0urhRxoKLFMt9Ebiz+wf9StR7pST4L
         NASCva2i3nMOGPMc/1eBaXut4twwMn0cSwukI70lFbT0lRmR01NEV6KguBJmkYoP52hn
         8GcdkoLy/d/x5+0FMcpftsnb42X6zG1ihaaVo47dVrK8EBg3Jo2B253jf47ap5QYHlGs
         SLrdAgVqF5iVjYHs1CJFiljW526BKtKruvKU5/3MIpz0HG9bXGtKsz2/OekdjnMCaQ4B
         T0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717504193; x=1718108993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEy/JnpykSFlMVVDpNV9Nfzw4k+5jlopBP5r+KNm31Q=;
        b=XD02+opakMMzCq0dQ1i5ki10ozr6NRleq/1fBcxRFk2Y+TtS0Vv6c0tSOJZF2gwje9
         y6Xm+mDiL5uGKWvcG0phIt4laobiXUhaa7qoWN4LwvgW/0qD4tO1Mrr004y+7XO4lH/8
         /ho7BzF8S66sSpcUYvGjHpKfRu++2G8U2RH/MRZyckiv23dj3NFIm3ZOfIBjXTNLmivT
         oubUnv2rmx9ptJzbrVsYdC6lY9eZCerXLZrqQ05XnFcCqNiKUwIpSlW83qR6Uctr31Ip
         dxBmCx3Pp93tnVw8PDC0AFEYFVh0d/T6VJFynm7OibvFCdCNg1ylEFq14c78BOffMbW2
         5gzA==
X-Forwarded-Encrypted: i=1; AJvYcCVKL8zIWZBaaZZSrq/QY+JVbncz2qZ4199j/G3LGU5ES77Yvs/GiYez/tSUYHBplan7H0jkkxp0gcx6GuHk1v7+zsBPiuxR+70RQpbu3Bs5zAliYMBCohw4g9ag
X-Gm-Message-State: AOJu0YzUELQRy7cLOBVEqEdGYnCLN6fIwRYaULBrNWbu22LBQGsXEMdS
	mcCLbXCL6FYimBhTtNSeugcJKbh7R47Q7bO/olPWMqsB6tGnTKjC
X-Google-Smtp-Source: AGHT+IHHAHnXTnSBGNZDaCxF/LGnacaJN2CUM/gIw160lQc3t5eeaWcaTG8V3ShyG0Yc81KSkKN2Ww==
X-Received: by 2002:a5d:51c6:0:b0:35e:7e09:c3cc with SMTP id ffacd0b85a97d-35e7e09dbe8mr1294259f8f.6.1717504192491;
        Tue, 04 Jun 2024 05:29:52 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-45.NA.cust.bahnhof.se. [158.174.22.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c10f2sm11409863f8f.10.2024.06.04.05.29.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:29:51 -0700 (PDT)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	bpf@vger.kernel.org
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>,
	YuvalE@radware.com
Subject: [PATCH bpf 0/2] Revert "xsk: support redirect to any socket bound to the same umem"
Date: Tue,  4 Jun 2024 14:29:24 +0200
Message-ID: <20240604122927.29080-1-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revert "xsk: support redirect to any socket bound to the same umem"

This patch introduced a potential kernel crash when multiple napi
instances redirect to the same AF_XDP socket. By removing the
queue_index check, it is possible for multiple napi instances to
access the Rx ring at the same time, which will result in a corrupted
ring state which can lead to a crash when flushing the rings in
__xsk_flush(). This can happen when the linked list of sockets to
flush gets corrupted by concurrent accesses. A quick and small fix is
unfortunately not possible, so let us revert this for now.

[  306.997548] BUG: kernel NULL pointer dereference, address: 0000000000000008
[  307.088372] #PF: supervisor read access in kernel mode
[  307.149079] #PF: error_code(0x0000) - not-present page
[  307.209774] PGD 10f131067 P4D 10f131067 PUD 102642067 PMD 0
[  307.276608] Oops: 0000 [#1] SMP
[  307.313712] CPU: 3 PID: 1919 Comm: sp1 Tainted: P           OE     5.15.117-1-ULP-NG #1
[  307.408219] Hardware name: Radware Radware/Default string, BIOS 5.25 (785A.015) 05/11/2023
[  307.505779] RIP: 0010:xsk_flush+0xb/0x40
[  307.552099] Code: a0 03 00 00 01 b8 e4 ff ff ff eb dc 49 83 85 a0 03 00 00 01 b8 e4 ff ff ff eb cd 0f 1f 40 00 48 8b 87 40 03 00 00 55 48 89 e5 <8b> 50 08 48 8b 40 10 89 10 48 8b 87 68 03 00 00 48 8b 80 80 00 00
[  307.773694] RSP: 0000:ffffb7ae01037c80 EFLAGS: 00010287
[  307.835401] RAX: 0000000000000000 RBX: ffffa0a88f8ab768 RCX: ffffa0a88f8abac0
[  307.919670] RDX: ffffa0a88f8abac0 RSI: 0000000000000004 RDI: ffffa0a88f8ab768
[  308.003922] RBP: ffffb7ae01037c80 R08: ffffa0a10b3e0000 R09: 000000000000769f
[  308.088172] R10: ffffa0a1035ca000 R11: 000000000d7f9180 R12: ffffa0a88f8ab768
[  308.172405] R13: ffffa0a88f8ebac0 R14: ffffa0a2ef135300 R15: 0000000000000155
[  308.256635] FS:  00007ffff7e97a80(0000) GS:ffffa0a88f8c0000(0000) knlGS:0000000000000000
[  308.352186] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  308.420043] CR2: 0000000000000008 CR3: 000000010cf6e000 CR4: 0000000000750ee0
[  308.504309] PKRU: 55555554
[  308.536296] Call Trace:
[  308.565209]  <TASK>
[  308.590026]  ? show_regs+0x56/0x60
[  308.630218]  ? __die_body+0x1a/0x60
[  308.671433]  ? __die+0x25/0x30
[  308.707529]  ? page_fault_oops+0xc0/0x440
[  308.754897]  ? do_sys_poll+0x47c/0x5e0
[  308.799188]  ? do_user_addr_fault+0x319/0x6e0
[  308.850659]  ? exc_page_fault+0x6c/0x130
[  308.896992]  ? asm_exc_page_fault+0x27/0x30
[  308.946398]  ? xsk_flush+0xb/0x40
[  308.985546]  __xsk_map_flush+0x3a/0x80
[  309.029824]  xdp_do_flush+0x13/0x20
[  309.071043]  i40e_finalize_xdp_rx+0x44/0x50 [i40e]
[  309.127653]  i40e_clean_rx_irq_zc+0x132/0x500 [i40e]
[  309.202736]  i40e_napi_poll+0x119/0x1270 [i40e]
[  309.256285]  ? xsk_sendmsg+0xf4/0x100
[  309.315969]  ? sock_sendmsg+0x2e/0x40
[  309.359244]  __napi_poll+0x23/0x160
[  309.400482]  net_rx_action+0x232/0x290
[  309.444778]  __do_softirq+0xd0/0x270
[  309.487012]  irq_exit_rcu+0x74/0xa0
[  309.528241]  common_interrupt+0x83/0xa0
[  309.573577]  asm_common_interrupt+0x27/0x40

Thanks: Magnus

Magnus Karlsson (2):
  Revert "xsk: support redirect to any socket bound to the same umem"
  Revert "xsk: document ability to redirect to any socket bound to the
    same umem"

 Documentation/networking/af_xdp.rst | 33 ++++++++++++-----------------
 net/xdp/xsk.c                       |  5 +----
 2 files changed, 15 insertions(+), 23 deletions(-)


base-commit: 2317dc2c22cc353b699c7d1db47b2fe91f54055c
--
2.45.1

