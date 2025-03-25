Return-Path: <bpf+bounces-54713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBD2A70A48
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 20:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F90188BD8F
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 19:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BC61F2BA1;
	Tue, 25 Mar 2025 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QLAeI8ZD"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703D1E2838;
	Tue, 25 Mar 2025 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930560; cv=none; b=PhkHMt/CJmirZStzF8MJdfr0tpN7aMl1fzf0c7MimZdXbNQwQNKt3Y6cicEyKb3Zu7R9xXTB3z/k4WNn0eFxJJiN2gFCNDluXiNQIMib0PlZ/2bPHBi4RLFV28TVk5rOSe+D5sKba9xQGs1Wqzba/q3g4J85IrOBSyKvl4Odvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930560; c=relaxed/simple;
	bh=pQkOmvNp+wGkRrAuIAEx0YcfA5B/7lhyWQ4fmFS+KTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NTkbJPNtJ7t/k+KW52KON7HBLKJCUcItehYBXZLVFlcNXir9FVggq3juDkVe6Uctj3+tWuNHMaveMzbb/lEBNs31ZLku8LJEIhCUyfQBu3ELlOyYe8to7scT6tEr1wRzLCyXyVCY0+Sxj859XQZd+e8iVdBisX5DpBxfsAw1OFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QLAeI8ZD; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E020EC00034A;
	Tue, 25 Mar 2025 12:22:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E020EC00034A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1742930558;
	bh=pQkOmvNp+wGkRrAuIAEx0YcfA5B/7lhyWQ4fmFS+KTQ=;
	h=From:To:Cc:Subject:Date:From;
	b=QLAeI8ZDHidpJkloadX68SX5i+5uNDL5qhs+xhcmHDvcaOG6keZ2Wk0NTOt0wNmj+
	 dMvdiv2yc2zkltMahApWRJzQfmzF3L0jfUfZE47/Xa+7a6aQYuXa+g/iUcL5eH2ngq
	 cP37kmq5P6Fy8sjgBNDidkCh22WD57gy7RDWI8e0=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 9558518000520;
	Tue, 25 Mar 2025 12:22:37 -0700 (PDT)
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
	Felix Huettner <felix.huettner@mail.schwarz>,
	Yan Zhai <yan@cloudflare.com>,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@gmx.fr>,
	Thomas Graf <tgraf@suug.ch>,
	Justin Pettit <jpettit@nicira.com>,
	Andy Zhou <azhou@nicira.com>,
	Simon Horman <simon.horman@corigine.com>,
	Luca Czesla <luca.czesla@mail.schwarz>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list),
	dev@openvswitch.org (open list:OPENVSWITCH),
	bpf@vger.kernel.org (open list:BPF (Safe dynamic programs and tools))
Subject: [PATCH stable 5.10 v2 0/2] openvswitch port output fixes
Date: Tue, 25 Mar 2025 12:22:34 -0700
Message-Id: <20250325192236.1849940-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series contains some missing openvswitch port output fixes
for the stable 5.10 kernel.

Changes in v2:

- use BUILD_BUG_ON_INVALID rather than DEBUG_NET_WARN_ON_ONCE which does
  not exist in Linux 5.10

Felix Huettner (1):
  net: openvswitch: fix race on port output

Ilya Maximets (1):
  openvswitch: fix lockup on tx to unregistering netdev with carrier

 net/core/dev.c            | 1 +
 net/openvswitch/actions.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1


