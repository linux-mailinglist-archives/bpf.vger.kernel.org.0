Return-Path: <bpf+bounces-54201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD04AA65614
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 16:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643D23B7E8B
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAF2248872;
	Mon, 17 Mar 2025 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y2RrwcKR"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BEF1CFBC;
	Mon, 17 Mar 2025 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226070; cv=none; b=SKMXxMzUIwZwlovQUYq2ncXFmqx1S+oIHV9QS/k9xBBri/iGl+T9mEIyw6ej1zLzIfthSKoG2bHNlqHuT/B5JPUVSRPUzUkWGEuHKmPaktbfZy4++WinO0ddCUt3VVKbrnNfkT/5JDrHu5pOjrnn68/akn9ptyZNadnHtQTt1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226070; c=relaxed/simple;
	bh=15Ry4aHO6fQMMaVtRXYLQQBCBj3nCaxO3RdpAIRrMv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YApzxBm1QyNZjp6z76N+R3xebA96NK+VsX+SXC4ZPljJ2oFTUsb9kdcBhZi5xO3A/U88v+6onSMDihOfZCCZkFPfHqnZsYyGToB/0GKp+GBurmqT56YF0A+f0ocXX4trh2C//Qymn0RssVmm9UGLpO45hS0R3PPiT3Rtf7509jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y2RrwcKR; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B3F08C002803;
	Mon, 17 Mar 2025 08:41:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B3F08C002803
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1742226067;
	bh=15Ry4aHO6fQMMaVtRXYLQQBCBj3nCaxO3RdpAIRrMv0=;
	h=From:To:Cc:Subject:Date:From;
	b=Y2RrwcKRbLfHHcqveDeJXAoGSOwIvaDqgKXpzjmJWMfFpFbBA5WD3Nh3LDDepBrpV
	 vpzZ8bk5ULk8tX6j/gYkiPL46pBq1C2UE7XRsv6Rb4A61D7RxipwkzZUSUBHDgb7WI
	 XnhAsCarVV3UZEVYAaC6nq+OBIiejkX3L+Z3LHFE=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id E91774002F44;
	Mon, 17 Mar 2025 11:41:05 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Pravin B Shelar <pshelar@ovn.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Andrii Nakryiko <andriin@fb.com>,
	Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@gmx.fr>,
	Xin Long <lucien.xin@gmail.com>,
	Felix Huettner <felix.huettner@mail.schwarz>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list),
	dev@openvswitch.org (open list:OPENVSWITCH),
	bpf@vger.kernel.org (open list:BPF (Safe dynamic programs and tools))
Subject: [PATCH stable 5.4 0/2] openvswitch port output fixes
Date: Mon, 17 Mar 2025 08:40:21 -0700
Message-Id: <20250317154023.3470515-1-florian.fainelli@broadcom.com>
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

Felix Huettner (1):
  net: openvswitch: fix race on port output

Ilya Maximets (1):
  openvswitch: fix lockup on tx to unregistering netdev with carrier

 net/core/dev.c            | 1 +
 net/openvswitch/actions.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1


