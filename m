Return-Path: <bpf+bounces-54211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C103A6573C
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1895E16C8FC
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047551A4F21;
	Mon, 17 Mar 2025 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UbClLc2j"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0EA18C907;
	Mon, 17 Mar 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226896; cv=none; b=Q7DTwiV3pYeo2ExJR31xt5IIQVnFgNxhgfloLnnQK/oElmkD9T3KKkJyJBqfxdWk6pxG8e79FbsaVZCek5XoZghOxi/X6DoxwR9q4T5dHRNtrFLFX5aoyy+OzojwdaIJiMCSJ0AcmSaSW6kFiyRd5amFxbCoztky9snxv0vD8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226896; c=relaxed/simple;
	bh=oEy+pBfckozdSe5v/wiPO0WmE8rDPJNn6pqUnWhhqq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oaSse8WLlUZn8ICHhFJxXL3ZuVMWHp5FANPmBpnFoxQhu0tucE+bW0O4suLUFn3pJ1NIU0YtLhe72hUw02Sa3jVBvALHKI+PUSypyGVj6+i8TKifhIG0AVs+9W+6FvQJl48MK/46TS0fJ/yKbcuO1VZAwLc36UQJhb464j7+Liw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UbClLc2j; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E5748C0000FF;
	Mon, 17 Mar 2025 08:45:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E5748C0000FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1742226343;
	bh=oEy+pBfckozdSe5v/wiPO0WmE8rDPJNn6pqUnWhhqq4=;
	h=From:To:Cc:Subject:Date:From;
	b=UbClLc2jQx3jhDI+IFzhpeIhBo4hOoXxi8BmNJbC1Y5KLB78f5c2jmM363UD3UrHi
	 5qm6HT8/5LQISKptP6gNmdJIq05E6t8ACWz78HW1Lr7A0Illi9Mn8lLgKUq8brAoOC
	 szJw9aXT9HfHXTSzklRmwY7iR2dTqya7Br+EwzpE=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 4DE5B4002F44;
	Mon, 17 Mar 2025 11:45:40 -0400 (EDT)
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
Subject: [PATCH stable 5.10 0/2] openvswitch port output fixes
Date: Mon, 17 Mar 2025 08:45:35 -0700
Message-Id: <20250317154537.3633540-1-florian.fainelli@broadcom.com>
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

Felix Huettner (1):
  net: openvswitch: fix race on port output

Ilya Maximets (1):
  openvswitch: fix lockup on tx to unregistering netdev with carrier

 net/core/dev.c            | 1 +
 net/openvswitch/actions.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1


