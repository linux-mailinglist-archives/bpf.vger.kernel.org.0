Return-Path: <bpf+bounces-69480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E430B976FD
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 22:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF8767B4EEF
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 20:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C8530CD87;
	Tue, 23 Sep 2025 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4jOnM9Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4324930C617
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657658; cv=none; b=n3D6db/c7ttXRrAgTBexukMqWOj1euBW45l9RLDZGobVE62Zkjn/COtID8mwnFDxZf+yMbj1GALLRWn90VEZBTIYZKjTPV+5/95PeNkfQ+rzCFKX4dRaGQ4GucSKSvE2w+V+Kjcwcj6rT+6KEEvvlRJHqTXivjcdyuv8preJZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657658; c=relaxed/simple;
	bh=za6eoflza+eI0daPO52VrArrXQQh9oKqLFL2yU7G4qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zm6p8CfojwXez2r1shtwlqfnRt8NDsMa1WuBMrTZZFtRoaXqpAIT05LyBlNJJ/zDuiVcgs4WS2sqTr0q3K8Rgji1zg+nMEHb3/OtePkhj8s5sPcJpPCZTlsJI8xDbI9TLECq5zd2s+i9F7pMZO4dI40r7eu2av9nNk25x+mO9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4jOnM9Q; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b2a1a166265so49778566b.2
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 13:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758657656; x=1759262456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvM5EG3LMIQuZITndtrZP0Eki684ON50PFEBay054lA=;
        b=c4jOnM9QEkWDqPrR+CsDuHhhX2WaAYDyMzb0l2y9LULpcKUAItkDpwx5lt6sjg4kE+
         UyPAFDmu4aR2C5snhubvV28QfEVemUgyCWRvisVCCCtw36vDRb/fgyIausDx0hNS7+xB
         57jqpD25HqdsXSXljGRYdGUfnjEXAFbQ7tRukTAtUzlFgb7gjcHlLxIdbLmijBrHhplW
         QXCoglWLdYwq97XzTljwFvTr1dlmJZse6/8/FGPS3aNtVUUL+cq8i55XS+mWTpYQcdLZ
         suuPqkJnieST71cj0UPW5T8J/XmqrgQFIarUYWIDiIAHpbJN4c6bRBxXmyh+4IEipQrM
         Z5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657656; x=1759262456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvM5EG3LMIQuZITndtrZP0Eki684ON50PFEBay054lA=;
        b=E4M9ampBVQmBIpUxx3NNCN8XeFccVd2HTHl1MfgehJ7a1KmmMUizBblzIKwxF3YF7m
         OKwo059gUWhc41hENen1zEb2/Vs1VLg7G9caX5NxYpLQc1JIHThPH2dvDjwereQljYo4
         uQL99IWQLSY7rgT3Jox7hDdrmVVWs85o3CKrKFFX/dY8r26w7Sni+cyX5RWmfA0H0XAD
         2V8hOdG/GY7W8O8GKCMinVBs3c5cvLpupM+EaNknLRXSCcl874mbe7cFOn69g9v2jABw
         lgUIAoofIBR1paBnC+JkipoYGGYeCXFQb+ks+LvJr6x6y0TCaIKTfLMbY8fG0Lksw/FQ
         tC1w==
X-Forwarded-Encrypted: i=1; AJvYcCVnLgCxwVh6tqtM0Pf+/FH3KpBUfys+i4yrhYDUNRd7lTSBSoEBAMdlwaOyD8bINnvB0Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqqVCFI0EVTTFcx7ncPrtGuatz9wMOfuPs1t/JYY8nkzCuVBqg
	fYVXeqTN8oCVQRkLhRkQ1uGMFeMhyk6ocdTPBqOuYwRMh3yrcfrk+6JW
X-Gm-Gg: ASbGncs6Pk1hGAmYVW4o0a+4XTHYhA0DfViAyqCVixSKMq5lXtu2Q1O0mqJhbflsZdD
	qWCUbUw9gvVY0qQJj2CuohiGFCUc8kGaoXt20LK6VfB7AV6hMfpCxapiHSBm8pkl48dsr4xeDfQ
	8eHo3csdq4Wj7U7dq0lMA3VOkNxDdDcok7ue68e/GZWS03IUvYPoKzlcXs7k293d6VtnxZnyy5a
	P1s+aOKdO14g9Th67JdXabWQ6pdCuhO+uzH7axWIoT5bMoTSm6tBEsy/psd5mI8s9ypZL+BQnGU
	F41/PcKdmVlb8xbASvgwO49eCBPq9x8GJ8MdI+VdFBmh3TH7XC8FusF6nxSfWHdqeB8aHZ8CqIi
	ZCpDhdk98KxFmk3RGn28Cph2T
X-Google-Smtp-Source: AGHT+IFnbqnzDpvcF1npAo3gJlRiN0aWJNOZlV40ujMaGftot7QGowUdecTibpSbqF5TWABjiIk+nA==
X-Received: by 2002:a17:907:3f1b:b0:afe:88ac:ab9 with SMTP id a640c23a62f3a-b302c10a6acmr180708366b.9.1758657655543;
        Tue, 23 Sep 2025 13:00:55 -0700 (PDT)
Received: from bhk ([165.50.1.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2ac72dbe92sm672074066b.111.2025.09.23.13.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:00:55 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	jdamato@fastly.com,
	skhawaja@google.com,
	dw@davidwei.uk,
	mkarsten@uwaterloo.ca,
	yoong.siang.song@intel.com,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Cc: horms@kernel.org,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH RFC 4/4] net: veth: Implement RX queue index XDP hint
Date: Tue, 23 Sep 2025 22:00:15 +0100
Message-ID: <20250923210026.3870-5-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement xmo_rx_queue_index callback in veth driver
to export queue_index for use in eBPF programs.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 drivers/net/veth.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a3046142cb8e..be76dd292819 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1692,6 +1692,17 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	return err;
 }
 
+static int veth_xdp_rx_queue_index(const struct xdp_md *ctx, u32 *queue_index)
+{
+	const struct veth_xdp_buff *_ctx = (void *)ctx;
+
+	if (!_ctx->xdp.rxq)
+		return -ENODATA;
+
+	*queue_index = _ctx->xdp.rxq->queue_index;
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1717,6 +1728,7 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
+	.xmo_rx_queue_index		= veth_xdp_rx_queue_index,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
-- 
2.51.0


