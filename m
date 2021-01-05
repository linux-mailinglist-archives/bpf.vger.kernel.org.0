Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551912EAAAD
	for <lists+bpf@lfdr.de>; Tue,  5 Jan 2021 13:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbhAEM0V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jan 2021 07:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbhAEM0U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jan 2021 07:26:20 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A567C0617AA
        for <bpf@vger.kernel.org>; Tue,  5 Jan 2021 04:24:40 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c133so2842614wme.4
        for <bpf@vger.kernel.org>; Tue, 05 Jan 2021 04:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbacyc4brsO7fCWWmN34VX2kLRLEZOENYLDCsoU/LjI=;
        b=DUue5w4sNmjFSztZsNkWwJal7840OEUG93mZRmlUiovZ70//yuPDENjbD52th+i7Hm
         sdUmUp9itIyvkH+bVxW13cpTvKiuOoFtTAM9b2jR69Us3xR2j4YG49N7UMfFWGyjlbkr
         Ez328SRQClhxvGJJbfIoshkAgk7v9845j+VPzLikfjS4GNTjIUJSaSdmcTWV3sV6vJEk
         HHOQMvR2Z1U5CvJBLf+7abqQ/z50fRQosycKDyguVroZqnAXY03woxqd3JhAsN4rlTFT
         9W8P8yFomL3VZ70hq8o9+47grbwrBMLcaWSuhlDsgsZd/2K1YeD0fFoSHbMZuqcAp+zT
         b6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vbacyc4brsO7fCWWmN34VX2kLRLEZOENYLDCsoU/LjI=;
        b=qBWXL9421r1/v7yCPt/h/P1YRJpijgf28NiL/r7BvwnHiJH7dy2c9+/6Gxe3byimXr
         4mjpCQf2mxaW6IP5JnmKng7UzrJqTefKKbFomFzDHPIiNenU52LG1ocgd8RO2CQ4fPTz
         NSMUs9v3agPn9Y7CNoyn2WxalgcImUcmPyOgEXjAnkmFwH/u9az78qBaKC1VI0JDLGTz
         3HNvnizJ73wU740Uz+TrrltokTrh1xnlPKsc/9bcxo+ShWU8CAtp3FdJBcpVcZdC3Zg2
         ivWF3J1Fr6mRO/3GCACwSqKKSUeRzizAbZBtsWvU5uJ16Yi0I3ZN1YJ09J3Iv8e0bb0Z
         G/Wg==
X-Gm-Message-State: AOAM532rV9TSrMSygX2eaGbVaU3yzJf7Tpl8QrkWQAr6ZmRmMyHBtYfD
        7og8F88A6F+z8jIloWEk1YzxDg7e3O7Ptftv
X-Google-Smtp-Source: ABdhPJz7B+8XH+eWVDEfcl2ghSQU/ocHdDP7XOqYGm8XUD3QUk7ti4dvUlAJN39m/ISqwst8HvF+CQ==
X-Received: by 2002:a7b:cbcc:: with SMTP id n12mr3241318wmi.23.1609849478800;
        Tue, 05 Jan 2021 04:24:38 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net. [79.183.72.147])
        by smtp.gmail.com with ESMTPSA id 138sm4242281wma.41.2021.01.05.04.24.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jan 2021 04:24:38 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     yan@daynix.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC PATCH 6/7] tun: populate hash in virtio-net header when needed
Date:   Tue,  5 Jan 2021 14:24:15 +0200
Message-Id: <20210105122416.16492-7-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105122416.16492-1-yuri.benditovich@daynix.com>
References: <20210105122416.16492-1-yuri.benditovich@daynix.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If the BPF program populated the hash in the skb the tun
propagates the hash value and hash report type to the
respective fields of virtio-net header.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 drivers/net/tun.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 45f4f04a4a3e..214feb0b16fb 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -556,15 +556,20 @@ static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 {
 	struct tun_prog *prog;
 	u32 numqueues;
-	u16 ret = 0;
+	u32 ret = 0;
 
 	numqueues = READ_ONCE(tun->numqueues);
 	if (!numqueues)
 		return 0;
 
 	prog = rcu_dereference(tun->steering_prog);
-	if (prog)
+	if (prog) {
 		ret = bpf_prog_run_clear_cb(prog->prog, skb);
+		if (tun->bpf_populates_hash) {
+			*skb_hash_report_type(skb) = (__u8)(ret >> 16);
+			ret &= 0xffff;
+		}
+	}
 
 	return ret % numqueues;
 }
@@ -2062,6 +2067,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 
 	if (vnet_hdr_sz) {
 		struct virtio_net_hdr gso;
+		__u16 extra_copy = 0;
 
 		if (iov_iter_count(iter) < vnet_hdr_sz)
 			return -EINVAL;
@@ -2085,7 +2091,20 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 		if (copy_to_iter(&gso, sizeof(gso), iter) != sizeof(gso))
 			return -EFAULT;
 
-		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
+		if (tun->bpf_populates_hash &&
+		    vnet_hdr_sz >= sizeof(struct virtio_net_hdr_v1_hash)) {
+			struct virtio_net_hdr_v1_hash hdr;
+
+			hdr.hdr.num_buffers = 0;
+			hdr.hash_value = cpu_to_le32(skb_get_hash(skb));
+			hdr.hash_report = cpu_to_le16(*skb_hash_report_type(skb));
+			hdr.padding = 0;
+			extra_copy = sizeof(hdr) - sizeof(gso);
+			if (copy_to_iter(&hdr.hdr.num_buffers, extra_copy, iter) != extra_copy)
+				return -EFAULT;
+		}
+
+		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso) - extra_copy);
 	}
 
 	if (vlan_hlen) {
-- 
2.17.1

