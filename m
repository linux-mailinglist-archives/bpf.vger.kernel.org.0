Return-Path: <bpf+bounces-41368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A71996250
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 10:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530D7281C8E
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 08:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC4F1885A6;
	Wed,  9 Oct 2024 08:21:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798E93BB48;
	Wed,  9 Oct 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462112; cv=none; b=uPOWEiPkoC2QgwQzuMO3mfphDd1kUPMBm3RFiwOukYGsz7pe9dfYQiv2d8pVqHcb27nzDVxbuCq2MkvzPGf42IHsFPQrUSK6XIaE4HAuzkyGz71/iEkaS5p2tiagZ0p6eUwGrqTV7qJbT7xC3yHFBUwebNJVc3neaPCZFwdTMsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462112; c=relaxed/simple;
	bh=wUFhe5P4fg7+GoRLwsdIunBM1RfcBOBDZVvW0+Lqr2E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=W69Xs7SHLOVw1xZxpZvvpcqAeo0/QQZw6GBsMg+3EvqBhMkR7Z9TLoMdh6GT4v4jeGgp8VZlV6fIMX8HWIRyAGTTKUL2kxrUqlIObFvp82SQ4g5wEiDIOh+IQINFvxm0y27oUnd/3+nWaQbLXOHqR2ihHonO3rc7anZThAMMqu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee667063d14b0f-ba3d6;
	Wed, 09 Oct 2024 16:21:40 +0800 (CST)
X-RM-TRANSID:2ee667063d14b0f-ba3d6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee467063d12e51-e1616;
	Wed, 09 Oct 2024 16:21:40 +0800 (CST)
X-RM-TRANSID:2ee467063d12e51-e1616
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: martin.lau@linux.dev
Cc: eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] samples/bpf: Remove unused variables
Date: Wed,  9 Oct 2024 01:21:38 -0700
Message-Id: <20241009082138.7971-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

These variables are never referenced in the code, just remove them.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 samples/bpf/tc_l2_redirect_kern.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/samples/bpf/tc_l2_redirect_kern.c b/samples/bpf/tc_l2_redirect_kern.c
index fd2fa0004330..0b48f7ddf521 100644
--- a/samples/bpf/tc_l2_redirect_kern.c
+++ b/samples/bpf/tc_l2_redirect_kern.c
@@ -58,7 +58,6 @@ static __always_inline bool is_vip_addr(__be16 eth_proto, __be32 daddr)
 SEC("l2_to_iptun_ingress_forward")
 int _l2_to_iptun_ingress_forward(struct __sk_buff *skb)
 {
-	struct bpf_tunnel_key tkey = {};
 	void *data = (void *)(long)skb->data;
 	struct eth_hdr *eth = data;
 	void *data_end = (void *)(long)skb->data_end;
@@ -205,7 +204,6 @@ int _l2_to_ip6tun_ingress_redirect(struct __sk_buff *skb)
 SEC("drop_non_tun_vip")
 int _drop_non_tun_vip(struct __sk_buff *skb)
 {
-	struct bpf_tunnel_key tkey = {};
 	void *data = (void *)(long)skb->data;
 	struct eth_hdr *eth = data;
 	void *data_end = (void *)(long)skb->data_end;
-- 
2.17.1




