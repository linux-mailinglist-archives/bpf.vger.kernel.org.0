Return-Path: <bpf+bounces-70504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2BBC1893
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 15:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3823E1A75
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 13:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984B32E1C57;
	Tue,  7 Oct 2025 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7DvWDUt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC332E1749
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844266; cv=none; b=Z3JFvSAatrKMFJydoSYrXQ8mYhsTZHO/Q1c/qlqFpOOkUGx/SXS9sTvsfMngCQ11hPHy9vmCBFINZ2qX1bbH5x24GvNidUK1IwLOVS1bhqv/f79LXwD+AbhyLZPouLAq6+6TstaYRk+rsqFudV7w5lY0Ba2pmnituexq18am9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844266; c=relaxed/simple;
	bh=JT//uUo3QD7Z8XClOZp52xHiiry7eH1sR+F2EwggIXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MO+fxp84wksZJETW21ZZgEMmQNZNn79N5dewfnB1a62IMD3aZ2GTU8387XYBVT8Ca+jphP385uxkJaUoITaySG/3nN0f3C5ZCe4GAYLchSIJmhrD11DC51KNJmzRBm0MnJNR/U1JGaQSO1JZk+1H152FL7O9J5r4oTrxZQMltLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7DvWDUt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so990070f8f.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 06:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759844263; x=1760449063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9t7fsApCE40DcnimQb1eR1S9jsNRTF6IWEsg41a3xE=;
        b=B7DvWDUt752tzp9ikDq8BxoE0ybpLILJ/ZkZv6wFeHzgPk60Em9Ep3GyHhj9KjrYdD
         SMGaMSyAIrkvTE5eH7S4rApDNgAP80e5YUbA7f1CBmA/EZ/0RQaNSi8uinZKHPjSLrrX
         u9FAf7Bppg0fpqCMXE2glxMNvi7cWKQK3A3fEk7YBUpvo41/atCRGHqVoDGGkm+z0puR
         LlHoKxgqtdag+nY08A2miC8Icr5khiZI6dWCpPf+4D/JX1OijlcsF/yy+Vk71P3xh3y7
         RrMHdss6jACI4YvYhOMnsvXviGaK35xZcl5t4xb1HEw7z8U5NwWkY6lIOqOjn7Dfh9WQ
         bsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844263; x=1760449063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9t7fsApCE40DcnimQb1eR1S9jsNRTF6IWEsg41a3xE=;
        b=uP4WO6+6ynbxEBvcLgLCVoQQ4GmITbfDuHFcMTQYInGEItbXSROcDJZsL5YAp5QtfE
         G9O28+1eA9cSybvPk7B4Vusbx6IUIUn/F4VGXwMarEEub2esr9Qrj1HhqZgrzLnyFbHz
         GOVLKhG1/9Eyk1BISkokJusfqpioxMIHSG/bCdknDbzTSkBFJUT1tGT7Ox3mxirrJJt6
         7tqQImrYeVdtys9OzPT5L7xjSJQtUcTzCvIKXEq1hCKUJ8ulQIl2koiM1Kz1V4PTlCqh
         jmkCpQ9gySDnPB9mldDZnkOeiUWzZkeude4d2c39GiI6k7rSUo4DAdEde2XG1vgxMQ3s
         m4fA==
X-Gm-Message-State: AOJu0Ywb4xKLDL1q5j4G2rKRplYURoR9ZUrt982k9Pa/jWStWMl1L9SH
	qwlWmChaGHX8bWZHat5w47KiM4wAC2btOeCsFSXMOzAfmFdDm19ikiXYW8eCcVkH
X-Gm-Gg: ASbGncsRQJdPXMYyqhcjv0nMBENb++QPRDxfj7qQ0ewaV9eAqDE9dg5EcKooiKjbxlg
	NhxzLVJKLRxZTgQ0TYcrAg9SdkaLz5krr/p5PwvybfNaXh8kwNvt42UlBCrXyZv83CKym0n98Sf
	P4rBu7Kxd18yXeXI3KPHybHNnewYyhiHl3A2vFMDA6GjcUpdW+YOMNmvafkF1rLZKtjl19/jzCT
	K+tgGVvzzcfNASYKu0aBKXpUeRcXD8XSG565o8NxWd1SvD/V/OUd0d9QbJpgX8epRSrr6ZID6wT
	VDEL/aeXr823Jyy9/nItoMBBVl84Muo7czqCR0ae/RY8OY9VIuX7N49DwnOgqeqEfffLfZ6Hg4M
	G2DjOZXSf1W9+dg31wjoV4arVBacBowxJ3CAvVsprRFcUTPho++F669Fmht1eETNtOh6Q3gymEg
	ieJfY+mqSA/+WuPR67zY10yylevlftyvrH4rd+oVrpsNh5/g==
X-Google-Smtp-Source: AGHT+IEYpq9ZcXtrGp8Mxy1wtPDTBzRSTvgpVHGxAxxE2G5XViSTm+qcCr4UK9iSxmjrYQk0+Ba1tg==
X-Received: by 2002:a05:6000:481e:b0:425:75b1:1690 with SMTP id ffacd0b85a97d-42575b1170emr6650691f8f.46.1759844262503;
        Tue, 07 Oct 2025 06:37:42 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0079f574fca42e1d7a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:79f5:74fc:a42e:1d7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e960asm25291313f8f.37.2025.10.07.06.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:37:41 -0700 (PDT)
Date: Tue, 7 Oct 2025 15:37:40 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v6 1/5] bpf: Refactor cleanup of
 bpf_prog_test_run_skb
Message-ID: <9af429b6be7bdf33e7c524a6fad979abed322e41.1759843268.git.paul.chaignon@gmail.com>
References: <cover.1759843268.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759843268.git.paul.chaignon@gmail.com>

This bit of refactoring aims to simplify how we free memory in
bpf_prog_test_run_skb to avoid code duplication.

Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/bpf/test_run.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfb03ee0bb62..a39b26739a1e 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -990,10 +990,10 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	u32 size = kattr->test.data_size_in;
 	u32 repeat = kattr->test.repeat;
 	struct __sk_buff *ctx = NULL;
+	struct sk_buff *skb = NULL;
+	struct sock *sk = NULL;
 	u32 retval, duration;
 	int hh_len = ETH_HLEN;
-	struct sk_buff *skb;
-	struct sock *sk;
 	void *data;
 	int ret;
 
@@ -1012,8 +1012,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
 	if (IS_ERR(ctx)) {
-		kfree(data);
-		return PTR_ERR(ctx);
+		ret = PTR_ERR(ctx);
+		ctx = NULL;
+		goto out;
 	}
 
 	switch (prog->type) {
@@ -1033,21 +1034,20 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 	sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
 	if (!sk) {
-		kfree(data);
-		kfree(ctx);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 	sock_init_data(NULL, sk);
 
 	skb = slab_build_skb(data);
 	if (!skb) {
-		kfree(data);
-		kfree(ctx);
-		sk_free(sk);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 	skb->sk = sk;
 
+	data = NULL; /* data released via kfree_skb */
+
 	skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
 	__skb_put(skb, size);
 
@@ -1142,7 +1142,9 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (dev && dev != net->loopback_dev)
 		dev_put(dev);
 	kfree_skb(skb);
-	sk_free(sk);
+	kfree(data);
+	if (sk)
+		sk_free(sk);
 	kfree(ctx);
 	return ret;
 }
-- 
2.43.0


