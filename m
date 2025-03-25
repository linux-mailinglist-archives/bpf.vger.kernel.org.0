Return-Path: <bpf+bounces-54716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C17A70A4E
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 20:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDE6189BC4A
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 19:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B26D1F460E;
	Tue, 25 Mar 2025 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="qslzw++u"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FED1EE7B1;
	Tue, 25 Mar 2025 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930571; cv=none; b=Hjt4x98HxHZ83PMFo8poq6tAScPoMCN03kBZiuUccxnpAjNAe1nnVAtu9Knl4Qa25DkJ91W+4FoXE5/KX1SatH7/zofF/sI/cM7ghhIqZc4xmBcw6nkfvqGPKydefeOa83R+dWVeqt2daNqUEPkeVb/Oe5pNfNTT+XCdOA63Cl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930571; c=relaxed/simple;
	bh=m/dB6ooePQO+780W0u+LM/RXcUN7Ax8U357sB5EC7uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fGcDSfGWjHFOQUf91CFfXu7JwjAStRvhVqsNyD3yjRGObJC2BpzB2TP0jf7gNJfxNLqsHARCZAPSnm/z2bXNZPjsCJYUTXbNjRJ4uUHBXWFwgwXQOaoGot0+nhOBnkGojNvIAfIx+UpxBUuCAdNJQHjxXSAA/HhTcMGQEc/neek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=qslzw++u; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 62904C0003E2;
	Tue, 25 Mar 2025 12:22:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 62904C0003E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1742930568;
	bh=m/dB6ooePQO+780W0u+LM/RXcUN7Ax8U357sB5EC7uc=;
	h=From:To:Cc:Subject:Date:From;
	b=qslzw++uyqmWCMzWBNSa+ycCpBdFKPCCdc2tyMkfKP2f0WMDQQdJiTy14cq9sx1ll
	 OLOXE2l4AibXv8Q+JbOGKaUxlgxQh2v/FoZnkicm6L+W5gTvrjar1qhD4GJyx/4eWq
	 6Ei+3VtDghZMLLsbLljIJTP1jOfKtczMs3EQPG9U=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id DA07D18000530;
	Tue, 25 Mar 2025 12:22:47 -0700 (PDT)
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Felix Huettner <felix.huettner@mail.schwarz>,
	Breno Leitao <leitao@debian.org>,
	Yan Zhai <yan@cloudflare.com>,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@gmx.fr>,
	Joe Stringer <joestringer@nicira.com>,
	Justin Pettit <jpettit@nicira.com>,
	Andy Zhou <azhou@nicira.com>,
	Luca Czesla <luca.czesla@mail.schwarz>,
	Simon Horman <simon.horman@corigine.com>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list),
	dev@openvswitch.org (open list:OPENVSWITCH),
	bpf@vger.kernel.org (open list:BPF (Safe dynamic programs and tools))
Subject: [PATCH stable 5.15 v2 0/2] openvswitch port output fixes
Date: Tue, 25 Mar 2025 12:22:44 -0700
Message-Id: <20250325192246.1849981-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series contains some missing openvswitch port output fixes
for the stable 5.15 kernel.

Changes in v2:

- use BUILD_BUG_ON_INVALID rather than DEBUG_NET_WARN_ON_ONCE which does
  not exist in Linux 5.15

Felix Huettner (1):
  net: openvswitch: fix race on port output

Ilya Maximets (1):
  openvswitch: fix lockup on tx to unregistering netdev with carrier

 net/core/dev.c            | 1 +
 net/openvswitch/actions.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1


