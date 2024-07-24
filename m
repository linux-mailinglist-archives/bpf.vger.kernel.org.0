Return-Path: <bpf+bounces-35488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A5493AEB8
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 11:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96A55B231D7
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFAB152178;
	Wed, 24 Jul 2024 09:17:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36E41BF2B;
	Wed, 24 Jul 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812677; cv=none; b=eA2IOvfkTDTLadDwPni4gDYwD2D1h5t2jyua8QTIwd9MXrPYcLne+OIiqgIJZ0tIZzE8cOzA+ZuJ86xyG0FL++mxDlkv8jyWZs8ugA/p8jHpL+mk+XsqCdWyxZQV6fCdn816rHGzXEQLBLI+IWHLNYEIm+3QmIGEbVQXU/9fnGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812677; c=relaxed/simple;
	bh=ADQwfaAi6+FBnsv6DVYor0JNnSinek0KacXvJfxySQ8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Nbs5wI6/QvvrvbXufZqTZG8/qA1+g0/PJmrBkvyJznjznqPrWUg7b6Tl3UD/Xu1sd/LPI5jUwTbyJo6Vf2ClRSDfasHXgvxsIQUwxO1t2EjZH7AN10cDVdve9BNmS7f8X3QLUzFdCwrlf99tGg8uOI4AK7OeZ8l97L00rKJwqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee266a0c6b8f79-cef7d;
	Wed, 24 Jul 2024 17:17:44 +0800 (CST)
X-RM-TRANSID:2ee266a0c6b8f79-cef7d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee566a0c6b7edd-a181d;
	Wed, 24 Jul 2024 17:17:44 +0800 (CST)
X-RM-TRANSID:2ee566a0c6b7edd-a181d
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] samples/bpf:Remove unused variable
Date: Wed, 24 Jul 2024 02:17:40 -0700
Message-Id: <20240724091740.10307-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The variable is never referenced in the code, just remove them.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 samples/bpf/xdp2skb_meta_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/xdp2skb_meta_kern.c b/samples/bpf/xdp2skb_meta_kern.c
index d5631014a176..af29a1bde4e4 100644
--- a/samples/bpf/xdp2skb_meta_kern.c
+++ b/samples/bpf/xdp2skb_meta_kern.c
@@ -32,7 +32,7 @@ SEC("xdp_mark")
 int _xdp_mark(struct xdp_md *ctx)
 {
 	struct meta_info *meta;
-	void *data, *data_end;
+	void *data;
 	int ret;
 
 	/* Reserve space in-front of data pointer for our meta info.
-- 
2.17.1




