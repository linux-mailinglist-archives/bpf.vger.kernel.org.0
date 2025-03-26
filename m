Return-Path: <bpf+bounces-54764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C67A71B58
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 17:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A29F3A74AF
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 16:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981FD1F4E5F;
	Wed, 26 Mar 2025 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sk0K3f1q"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38101F4CA3;
	Wed, 26 Mar 2025 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004742; cv=none; b=dtNfOGLo/+Hh4CbO2lun8za9qp/vSr60Drb1XxMuQlASOCKuYIIReCRzPoblN2B3kd6YKPxqZgpAbcmzkJYOQbyhZZshyXeHDc90uWBwxwFOnpvaKJMh1Q6ESzYHxWm8wfQirp1tL2KpTYcjE4fUXX9aaiAFaN7FVz0IZfX4NZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004742; c=relaxed/simple;
	bh=g3yWTTkNSjxZJdNNNw6NTB1rQm39W+F26WZz3Efrnuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tl2lVrlsoBLrlnYVwztcMy9FtuKu35bX6FXpZDLKXA8UyIhBgJjkWn/eZDTnz8cd9TQH85tJcbV8XTD8d3lQ4OdwuuYIuRMZPI+IDR7nmrJQ+AmZlJ68pCiHAdTTL0uUtIiJiOlFeayiTUJigAS022QETRRAzh7NGTrRnsxxEKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Sk0K3f1q; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 25961C003ACB;
	Wed, 26 Mar 2025 08:59:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 25961C003ACB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1743004740;
	bh=g3yWTTkNSjxZJdNNNw6NTB1rQm39W+F26WZz3Efrnuk=;
	h=From:To:Cc:Subject:Date:From;
	b=Sk0K3f1qe4IlOqejs6AjiZRWo0BVL1c+yjhKUoa+7AtRSMedpWitBiTbLqahVFene
	 YAqSpz/4ASJg1LKBhVksZWZS/tgQBa9kGMYLLY2zw9eZyZI7bAZAwpT1XeAR3tX+sN
	 66mqy7ngbi48f++LdJesxzFvrFCDW3HIFBSDDAVw=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 20A014002F44;
	Wed, 26 Mar 2025 11:58:58 -0400 (EDT)
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
Subject: [PATCH stable 5.15 v3 0/2] openvswitch port output fixes
Date: Wed, 26 Mar 2025 08:58:54 -0700
Message-Id: <20250326155856.4133986-1-florian.fainelli@broadcom.com>
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

Changes in v3:

- correct SHA reference in the second patch

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


