Return-Path: <bpf+bounces-54205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BE6A6569A
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 16:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10FD3BD8DA
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCB919EEBD;
	Mon, 17 Mar 2025 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="awRwO0/0"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B219CC28;
	Mon, 17 Mar 2025 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226429; cv=none; b=a/SufumR6x+F1536Qaz3zMIF+uFcb7cw1ZG9L0BVKkdyGBkyGOw0BUmek1znGYdr9ZUpmNPJjxbC76lP7C0pMgp7U6de0qXItGdbWOmz3lUeKZ4Y8TOy5DDfBnmYQom+9T0Nf6jIV3ahm8FUiFdU/qBjFN5EWjx11VBySp7fhaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226429; c=relaxed/simple;
	bh=FeDLfPilyt04kd1fxTM2keQjawC1S6ECjfrgz1ifUrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FjL9y2wXNaq5TpGon/Y0DOWQj1mmaTq/Ts3uAo0lRRO6vvgA07KLms7MM9WkGQFE5L/6RTmy7hlop32DvmQyaASmKZnhL3wxLXZMD+vOxE7teY8cHgxwwkOYLt7ww9YMKrGcavYH9DwnsnslIdGuplSbCxOoRoqDrrxatnIphsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=awRwO0/0; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1E1B3C0000EC;
	Mon, 17 Mar 2025 08:47:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1E1B3C0000EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1742226427;
	bh=FeDLfPilyt04kd1fxTM2keQjawC1S6ECjfrgz1ifUrs=;
	h=From:To:Cc:Subject:Date:From;
	b=awRwO0/06IRE03IV7DFSPeB3WnhQbNuUzzOMrssFllkkVIEe8Q4F3DbryK4gAwINk
	 /ITFbdkIDBOIkgoaWkGHRmPSscsaIfO5vh2/mhFTRQncGTob11oSmy7p8tHW3aH2BB
	 Dc3O7pblEZ/ZpglPdKgWkJSWBDsLhsghwY2lXgqY=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 2844D4002F44;
	Mon, 17 Mar 2025 11:47:05 -0400 (EDT)
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
Subject: [PATCH stable 5.15 0/2] openvswitch port output fixes
Date: Mon, 17 Mar 2025 08:47:01 -0700
Message-Id: <20250317154703.3671421-1-florian.fainelli@broadcom.com>
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

Felix Huettner (1):
  net: openvswitch: fix race on port output

Ilya Maximets (1):
  openvswitch: fix lockup on tx to unregistering netdev with carrier

 net/core/dev.c            | 1 +
 net/openvswitch/actions.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1


