Return-Path: <bpf+bounces-54759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631B2A71B39
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 16:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEF9188A2CD
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BD91F4734;
	Wed, 26 Mar 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dRzBgyrQ"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300BA1DB933;
	Wed, 26 Mar 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004692; cv=none; b=rVZb4u7TFTRmmbCdU+1dXExFfLBqRldW8aK1QrP/1kbYivyLBsTFgMdIfWDsTULAaa4ty8NpNLasYj4ejBUsoDAZd25mXMA4igMTMbpK8PoLQJrE1/hf3118CQKamRnkoQYu6KkqNS9IQewa9IwEw7ftx9fkEwIWt/nrb2SsZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004692; c=relaxed/simple;
	bh=MmR/aVOHY0L/NzbbfkfB4uycEt+rH3vhdCA4y3t3Sxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k2IVOEOPdeKQISS6KItfXrjwGSPihOUANhpL6Pe/0XcQcfRRihHq7OUpOtd7WJUbaS9hkOdYEQp+7fh8PHk3R+QBC5NeRC3sCn9cEZWVB3o1aUT9XRhr4zda/JOQb+RCLdMxGtGBEX7zMSN2kPMXmKbQZ0/k8AjCDwvO0kwkqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dRzBgyrQ; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 0133CC0005CF;
	Wed, 26 Mar 2025 08:58:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 0133CC0005CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1743004690;
	bh=MmR/aVOHY0L/NzbbfkfB4uycEt+rH3vhdCA4y3t3Sxg=;
	h=From:To:Cc:Subject:Date:From;
	b=dRzBgyrQm4OnogP3RVnMWWBAXjKtqqNJVKYYOE+v6Ds5b6xAsmcJ7QQYqYN/JM5So
	 3svDGu0+nFNYbr2nHMlWWjfvSmfcY5f4i+mmsFHEOLXfdCLahQnt74alWIUMpVaJ/D
	 VnnIjlvYAN70BGCuXvLGI187uhVvx/AH1bDt2y4c=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 724494002F44;
	Wed, 26 Mar 2025 11:58:07 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@gmx.fr>,
	Yan Zhai <yan@cloudflare.com>,
	Felix Huettner <felix.huettner@mail.schwarz>,
	Joe Stringer <joestringer@nicira.com>,
	Andy Zhou <azhou@nicira.com>,
	Justin Pettit <jpettit@nicira.com>,
	Thomas Graf <tgraf@suug.ch>,
	Luca Czesla <luca.czesla@mail.schwarz>,
	Simon Horman <simon.horman@corigine.com>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list),
	dev@openvswitch.org (open list:OPENVSWITCH),
	bpf@vger.kernel.org (open list:BPF (Safe dynamic programs and tools))
Subject: [PATCH stable 5.4 v3 0/2] openvswitch port output fixes
Date: Wed, 26 Mar 2025 08:57:58 -0700
Message-Id: <20250326155800.4133904-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series contains some missing openvswitch port output fixes
for the stable 5.4 kernel.

Changes in v3:

- correct SHA reference in the second patch

Changes in v2:

- use BUILD_BUG_ON_INVALID rather than DEBUG_NET_WARN_ON_ONCE which does
  not exist in Linux 5.4

Felix Huettner (1):
  net: openvswitch: fix race on port output

Ilya Maximets (1):
  openvswitch: fix lockup on tx to unregistering netdev with carrier

 net/core/dev.c            | 1 +
 net/openvswitch/actions.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1


