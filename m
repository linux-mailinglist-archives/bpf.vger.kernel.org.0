Return-Path: <bpf+bounces-37942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779E195CBEC
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 14:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31913285609
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AA1183CD4;
	Fri, 23 Aug 2024 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OWq2inMq"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF1184552
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414470; cv=none; b=EgfzczrXmJDySvRbQi4QItNXDJxdoqMfRahjEV+WwBYMcQrew9j0mnLz5SI3GKqN6O7eWNszcoZYBN6hSds4Op+7566LIu9FIfoUN9wD+sjutlrTec4YWyTyODV9bvzxx6SUjCDdhM9OVl0YErOiRn9Rq/csgofMOS2ao+fIpIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414470; c=relaxed/simple;
	bh=CmePMmbZfX9d7eZmAoHu//jTeD1Lk5kCSbfC1RbMFGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YST6XB4a+xEW095+1FCt3nJ/3FH8hxQSRsuRRSluDfG9I+wjUpJw/9kJX2OVbjcozH3CbRdToIQkHAFEZEfP4dz0MK9CWddMpzjfrF9HlblHtmWpJtB2uhf3YaQg3efhDQdVURgr/Idgb++qCvUm5FXy2ZqyOGgXboy+cPdgh88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OWq2inMq; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=hISEhYnlvaLtV3Wk7h12KaQGq+1ZIk4mJsP5PdkfPQc=; b=OWq2inMqfBt/yilMNuY+lEal86
	Oq1toGk9RAFJe2JE05RRBVwvG9ok69RHKnC7vQuLZx77jrttlZZsPwu4PTvB9bZhsM18VcKIth0MR
	TbnhqbxydVs2WRiAkwouIzOSKucUM9G9lL6e9eupv/x9rbJ7STQ/6x+N+FDow4rlVGoyw0lB9DlYT
	wgf7L8Fo5vGc5feJa2/6ptRmVayqcrkjzojkfMJXKL2hAsN0pGA1aEtOWxy7HmSpjWkfaTYM1pq5y
	5Hcd/gbxYYPOLlivwqnaLUXz8P1XLHcXKFYbx7rMihJ7xa2kBUsA3lzOPOSI3TMNAIwkYHJ2JEXMT
	7u5hz68Q==;
Received: from 23.248.197.178.dynamic.cust.swisscom.net ([178.197.248.23] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1shSyN-000MSU-Nf; Fri, 23 Aug 2024 14:00:55 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kafai@fb.com
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Breno Leitao <leitao@debian.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH bpf-next] netkit: Disable netpoll support
Date: Fri, 23 Aug 2024 14:00:53 +0200
Message-Id: <eab2d69ba2f4c260aef62e4ff0d803e9f60c2c5d.1724414250.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27376/Fri Aug 23 10:47:45 2024)

Follow-up to 45160cebd6ac ("net: veth: Disable netpoll support") to
also disable netpoll for netkit interfaces. Same conditions apply
here as well.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Breno Leitao <leitao@debian.org>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 16789cd446e9..0681cf86284d 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -255,6 +255,7 @@ static void netkit_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
 	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 
 	dev->ethtool_ops = &netkit_ethtool_ops;
 	dev->netdev_ops  = &netkit_netdev_ops;
-- 
2.21.0


