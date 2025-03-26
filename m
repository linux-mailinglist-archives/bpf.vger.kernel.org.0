Return-Path: <bpf+bounces-54767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D9EA71B8A
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 17:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952C017B8A6
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A816F1F5433;
	Wed, 26 Mar 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O5G6ouAo"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14CB1E5218;
	Wed, 26 Mar 2025 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743005284; cv=none; b=T52yBvZIPTfTpdSPithyCTL6gJVoHnoGWMQNzu56Im2G0nxt6Yhz8+r8Q404fbz+bbv4OeAhS7Qw1ZkjFgfKRsmWjmPiz5R69883oaFcDoUblMn8NvXwVBB9bIep+QOGCNk5OleL71d+vLEaF3MoTGOZbnC4Ab+w4RRXX2HnTWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743005284; c=relaxed/simple;
	bh=yEOuG5slLf2Bs5mYTsF93aba5cxTjjJSx2dwLNCgnkI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sPnhfzEc0ubWFzyKLWforctcaBh3Z4QzdTKNVs62gJgCv4CSBhMRvniR63YHXzgqbkygrlBLfx6MyK4m3YI/bNfkylcwBhs9+oQb5oESjllHmrrLVHuO4od4dkccrbcS9tGyGot0BCNsCEEedGiKneDgX3Eks/auKSZ8RLPcHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O5G6ouAo; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7BD73C000548;
	Wed, 26 Mar 2025 08:58:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7BD73C000548
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1743004726;
	bh=yEOuG5slLf2Bs5mYTsF93aba5cxTjjJSx2dwLNCgnkI=;
	h=From:To:Cc:Subject:Date:From;
	b=O5G6ouAorN9KBLqUaElb424mKCJiKtCtC1kKj8MMqqNlohakr+yAzT5Hi+JqPhwzb
	 RAbx0EbKJRgdAEEmOdI4PHidmqOm3sa3Oujw5d5UMIZ7hamM2j3WSsXWu55gpHF+P3
	 TsSqqwlReixwilrjEZFWjpW9Z6O0wC1OWsQoAUu0=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id DCE8B4002F44;
	Wed, 26 Mar 2025 11:58:43 -0400 (EDT)
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
Subject: [PATCH stable 5.10 v3 0/2] openvswitch port output fixes
Date: Wed, 26 Mar 2025 08:58:39 -0700
Message-Id: <20250326155841.4133945-1-florian.fainelli@broadcom.com>
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

Changes in v3:

- correct SHA reference in the second patch

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


