Return-Path: <bpf+bounces-75705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3C5C921B8
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7650334E77E
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A5532D422;
	Fri, 28 Nov 2025 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="QVtQ61w/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968D828E0F;
	Fri, 28 Nov 2025 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764336106; cv=none; b=akU86HF+GRmOkUsPoBkyGR+Hnn/YZonwDPu/i9vcY7jY+B/ofqNWraNF2opx3Wl9e0eHWmkYsnabH53EnfnEicpqevQhZ6aM5awVeAbNjGTmRJ4dRf+WC0W0PSZDEv1oPgpzExM7hCQubsnZ7SulZEPzfXOHrErD95HhgAoEE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764336106; c=relaxed/simple;
	bh=sla0taQGuw5CohFCnF5fZ8vtj9eN3uOItu5MSoBqxtI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DKEsJSHjXOLJ/cqx6MyrA+VOKi3PTWA7kY7xhuKc6XKEHvCVY7q/gfzdJQxa5xnivQpOl9UMWcRCmWkn1gDiuFCdq3U0ZqFj045BIgKpAMOmKbmR7DNEXsELFfNUQQSrVbR5bHHdlQV59dghJkXdSG9EZjhAoXkvpSn0JQNWDKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=QVtQ61w/; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1764336102;
	bh=sla0taQGuw5CohFCnF5fZ8vtj9eN3uOItu5MSoBqxtI=;
	h=From:To:Cc:Subject:Date:From;
	b=QVtQ61w/1rr/bCD8wri4jC8LSJya7eIxDM27jU7X4tiTbAAwbaalIs+iSrXLxm33T
	 1etFgXi6RB4sE0bEl6S0FcKwirCFaT3GltnU1X1VqBoWPM+sR5cNgYHQu7Z+6myFrn
	 bDXA8xD2GlebimS1Ucn1xcRlDDt9CrDNIt569ve3Ygmyh9Q2cvd20Qs0dvLD+j7cJN
	 W1GgKrZqRHE/uedQ/JQdQinaCl7h6NK0Gxli+NBBzToLCt6GproTODTLJeOt/LoXqa
	 GPrsmzEMfv7gk3Mv3YcLbYM9OwQC2Z5m+ft8jevk1S8YpF43hFBo4Q8ceQh/d8RCRh
	 NcLS6bRNU85Mw==
Received: from gca-msk-a-srv-ksmg01 (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id A7F481F745;
	Fri, 28 Nov 2025 16:21:42 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Fri, 28 Nov 2025 16:21:39 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru.astracloud.ru (rbta-msk-lt-156703.astralinux.ru [10.198.57.41])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4dHv8G29bfzJqN4;
	Fri, 28 Nov 2025 16:21:34 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Veaceslav Falico <vfalico@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Moni Shoua <monis@Voltaire.COM>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	bpf@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10 v3 0/3] Backport fix for CVE-2023-53103
Date: Fri, 28 Nov 2025 16:21:23 +0300
Message-Id: <20251128132126.7467-1-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/11/28 10:15:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 81 0.3.81 2adfceff315e7344370a427642ad41a4cfd99e1f, {Tracking_one_url}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, syzkaller.appspot.com:7.1.1,5.0.1;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 198520 [Nov 28 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.20
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/11/28 12:43:00 #27986045
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/11/28 10:15:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

Changes in v3:
  - Fixed patch numbering (previously sent as 2/3 instead of 3/3)
Changes in v2:
  - Added a new patch fixing bonding regression, based on the Fixes tag in
    c484fcc058ba ("bonding: Fix memory leak when changing bond type to Ethernet")
  - Added a cover letter
  - No changes in patches 1 and 3
  - Retested the reproducer [1]

Tested with the syzkaller reproducer [1].
The issue triggers on vanilla v5.10.y and no longer reproduces with these
patches applied.

Additionally, c484fcc058ba ("bonding: Fix memory leak when changing bond type
to Ethernet") has a Fixes tag pointing to
9ec7eb60dcbc ("bonding: restore IFF_MASTER/SLAVE flags on bond enslave ether
type change"), so it should be ported as well.

[1]: https://syzkaller.appspot.com/bug?extid=9dfc3f3348729cc82277


Ido Schimmel (1):
  bonding: Fix memory leak when changing bond type to Ethernet

Nikolay Aleksandrov (2):
  bonding: restore IFF_MASTER/SLAVE flags on bond enslave ether type
    change
  bonding: restore bond's IFF_SLAVE flag if a non-eth dev enslave fails

 drivers/net/bonding/bond_main.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

-- 
2.39.5

