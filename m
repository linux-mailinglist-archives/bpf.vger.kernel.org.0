Return-Path: <bpf+bounces-50133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 323A3A232AA
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 18:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DB83A332E
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 17:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE371EEA5F;
	Thu, 30 Jan 2025 17:16:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259388831;
	Thu, 30 Jan 2025 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257412; cv=none; b=oojkVJXdTcAbeHBnrdvC70mkikbsZoeI1pg7Dc3KfvTg+WmI/qa/zyn1N0ls4eby6vexk9BEozG6zKM0Jp/kjD3DeI65WLlBnCLXSIbX5AS2XXNx79FmgkeHzQlwbpOup/QojEeDV4sqWvzei7kcGTwKEdH7J4sy0soE2d5BLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257412; c=relaxed/simple;
	bh=fK+/9oym63si8P9jIBuNpwIi3xmkIpi+BfwvMmUDJ9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r4rxH1I/plgYVvmMKo5Sy9ffnRvltmoj6/OgQ1my0PAYvrGFEaD+Vh7/3YBtmrlQ9HhewbY1qrRH2iAtWTfMDDlkzYGLHlS7/qSjXFvifiLpfeuMqOcR3n1RLrH2yBXSLEDK6ywYAds9zIsiULd04iKwscUkUDlphlIowCSyA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tdY9P-000OMK-HA; Thu, 30 Jan 2025 18:16:23 +0100
Received: from [2a0d:3344:1523:1f10:f118:b2d4:edbb:54af] (helo=marcus-worktop.lohne.int.wichelmann.cloud)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tdY9P-000163-0l;
	Thu, 30 Jan 2025 18:16:23 +0100
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Subject: [PATCH 0/1] XDP metadata support for tun driver
Date: Thu, 30 Jan 2025 18:16:13 +0100
Message-ID: <20250130171614.1657224-1-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27534/Thu Jan 30 10:34:41 2025)

Hi,

please check out the following patch that adds XDP metadata support to
the tun driver.

This is my first patch sent to a Linux kernel mailinglist (and more are
planned), so please let me know if there is something to improve.

Kind regards,
Marcus

Marcus Wichelmann (1):
  net: tun: add XDP metadata support

 drivers/net/tun.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
2.48.1


