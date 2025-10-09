Return-Path: <bpf+bounces-70697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84493BCACDE
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 22:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8751A64C8D
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 20:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C165270EBF;
	Thu,  9 Oct 2025 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b="KPdhb2XY"
X-Original-To: bpf@vger.kernel.org
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A160B2701B1
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.0.186.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041745; cv=none; b=AUKbDg3J3xRsOSTQZNkMh2De1MPrQsCE61jZA6ab3O5RwoNpkA7C8KdJI8soScviGvHUA4aC+zvYjirU1v90/YDyW1WfNlzfTzVosnALfoDxUjpITP2KNsGAGYCQbbYdyuH+Eq2sxIfXZbwZ40h8x3hn3f8VXUGIDM04a1uyRBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041745; c=relaxed/simple;
	bh=BqmL8qSCaK+MZ1CoMJtzzo3fv2sANfeQJJcqeOfYyUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DmYAU0aZxBZXKAiZTXnRQ2n4T9u5X7hyeqBy5UMEpEZgk6MutFo5N6jHnhMWWDGuNpB5Y+CQOr+N1EI+4aIzG9IlRw2YeAu3tIgsnyW6KSKJGdQ0WX3Odc9xYUKOxaDR70GN4phz/sjmtrZYm9vQTbu2y4aAgzdPdw/HgdIhFx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com; spf=pass smtp.mailfrom=email-od.com; dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b=KPdhb2XY; arc=none smtp.client-ip=142.0.186.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email-od.com
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1760041743; x=1762633743;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
	bh=fNeFEOfUOZVVJm8zrFxKc3lRrfCO7pVZbIyZXfxTnGs=;
	b=KPdhb2XY9FwsuPTF3XHNclWDg7CJE08YXpzrmYtFhJ047aZhy+JdiFH0QVTRTxE98Ra/52yE6a1EbFW4hcoTNn7jd00/sh3+Oc8FRcW5OJkgRMiRk7MJXVV1DKoEceJd9K3fWqT6Fldtky3kE67emlzLvYg6AdW2tOH5Sg3RvhI=
X-Thread-Info: NDUwNC4xMi5hNjBiZjAwMDBhZmJhZDIuYnBmPXZnZXIua2VybmVsLm9yZw==
x-xsSpam: eyJTY29yZSI6MCwiRGV0YWlscyI6bnVsbH0=
Received: from nalramli-fst-tp.. (d4-50-191-215.clv.wideopenwest.com [50.4.215.191])
	by nalramli.com (Postfix) with ESMTPSA id E79E42CE000D;
	Thu,  9 Oct 2025 15:28:40 -0400 (EDT)
From: "Nabil S. Alramli" <dev@nalramli.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	lishujin@kuaishou.com,
	xingwanli@kuaishou.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	team-kernel@fastly.com,
	khubert@fastly.com,
	nalramli@fastly.com,
	dev@nalramli.com
Subject: [RFC ixgbe 0/2] ixgbe: Implement support for ndo_xdp_xmit in skb mode and fix CPU to ring assignment
Date: Thu,  9 Oct 2025 15:28:29 -0400
Message-ID: <20251009192831.3333763-1-dev@nalramli.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Kyle,

Please take a look at this patch that I plan to submit upstream, let me
know if you agree.

Hello ixgbe maintainers,

This patch is a RFC to add the ability to transmit packets using
BPF_F_TEST_XDP_LIVE_FRAMES in skb mode to the ixgbe driver. Today this
functionality does not exist because the ndo_xdp_xmit operation handler,
ixgbe_xdp_xmit, expects a native XDP program in adapter->xdp_prog. This
results in a no-op essentially. To add this support, I use the tx_ring
instead of the xdp_ring and allocate a skb based on the xdpf, and then us=
e
dev_direct_xmit to queue the xdp for tansmission.

May I get feedback on the idea and the approach in this patch?

Thank you.

Nabil S. Alramli (2):
  ixgbe: Implement support for ndo_xdp_xmit in skb mode
  ixgbe: Fix CPU to ring assignment

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 16 +++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 43 +++++++++++++++++--
 2 files changed, 47 insertions(+), 12 deletions(-)

--=20
2.43.0


