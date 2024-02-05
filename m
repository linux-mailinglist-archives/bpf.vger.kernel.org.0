Return-Path: <bpf+bounces-21218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1A849A4F
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 13:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED37BB26372
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 12:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35CC20B3E;
	Mon,  5 Feb 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JryIJRDC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB91946B;
	Mon,  5 Feb 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136252; cv=none; b=rTp2kO0xAQp6ojWQ8sfjLMx1El/pzgxU28IIA2B3aDeMhzzTnZOT/Tyru1tNYlPz7Bscf33OoT1pHXmEDjowA7x+cfsjbjBluUmf1T04/4CriwfoygW+oSctE+X/g8T+Q+PMvyuXJ/pz5kFNnBRUppVui98jdn4fJzwvPKxLZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136252; c=relaxed/simple;
	bh=V9+JP0licFL9nzTN/zTG2SC4wjoCTONLqvfkJZQyCU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aezQoiRPJbDPq31VaGGl3i9b9BFbk/FqDBhGTbJfQRPfS8vVSU+In/SRuZmCkh7W6hmGn1RObqKHtnS/SxZvnlVKLF/Yo4sT3Kik3rXQaN+RfVLDjsTihWiM6W7qfhgfThe+FZ45+VEHDgF+bt3A68EyGKw8KULFNq1jqn7mvrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JryIJRDC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fcc74a0a0so5039415e9.1;
        Mon, 05 Feb 2024 04:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707136248; x=1707741048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+JHEgaj3hU/Ynjh/YYf+I2MAvdE2p0r3dpPmOBXTatE=;
        b=JryIJRDCVPa3t1/yCS4sDaapckRK73bHVj7k5x4xjOONV2x4XczJpQRzJ/fPzDvpP8
         GDmk+YZTXZ5IdN8KwmkrYz8LPb5JOdF+1C5XE4C6g/a8aAwFPLjEhWeSEjSw3ncmGLEM
         BitJ6Xe6FqgA8tlgtTQndW96PzMcyLW3bvDNNs2OaJWbhB655q98YRId57SuyxrEkUiC
         klhIJcWxVz/L5XWkhAQiagTcY6KVdtTSnRQd4ma2zg5hPhkvX/ZOPNfa6osHiU5aFUvN
         V7HaonqTgtTATDCa+1MNfLy4ulhw8egxNgl0eEHbyYmmPPTb2805qvm8+tZFnBrKrQaM
         Tfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136248; x=1707741048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JHEgaj3hU/Ynjh/YYf+I2MAvdE2p0r3dpPmOBXTatE=;
        b=RaJcqUVQYHbFVzpf1oEyoXLhlXkFWWCCoCsRtUQw5VKYghkjAYkzNs7SHHzTl//JPQ
         WOdYQoo7XVsW5WTJ2Jb59qrUmIKwYAzcS8SuD6sDnFqa7/oD3u5cN7vadN8Z/Vma3j+o
         Weil4BxSSTRZUTiDeJWRS4riWZdSPSgN/3WkgzP+R8croEb73CxfWvf952CwWskVwDVK
         ijNfNZ0yz7VlEgGt625MTM5/xbwnd2j3Wl/gZSpD9pJks9sSPwGVJEuNhMIgb5xaxxLQ
         EDJJPfcklUmOfHe1SvUeqikozE6y0urs2FxxsiZy1JP3uFjB/GodWiQTWyQqjUxomPwh
         0SFw==
X-Gm-Message-State: AOJu0Yw9aajnePJiaEVeQn4nUAO38cr7htlsSS32EykzXLaubuwUKgCF
	zT2kgtq6Wn7qVC11zsdJqQlFB4J1e+WgM2ZattUamd3lrdjJhaM1
X-Google-Smtp-Source: AGHT+IGyd6b2b55JgFuonGHUvNQF86Xov+P+gkyQLAVZbblgIgcHMCxrQQ1MWtVDccFM82NgbvZtdQ==
X-Received: by 2002:a5d:400e:0:b0:33a:e4ff:57dc with SMTP id n14-20020a5d400e000000b0033ae4ff57dcmr8666430wrp.4.1707136248416;
        Mon, 05 Feb 2024 04:30:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVSqh9k+UR7uY89kKun4wDXnZxWX5jHgyTT2fkrg1OXvu+rl9ViHf4oYH+wv/N6a/VQHCdP3N5BqLelRGY2k8IQkMkwmAUQye9I3dD5XzmZVTNTjHiNjXG7vCoXTDdbiobX8EVu7+t0r2f0RkMG8DiLeHcbaCj6FZHdME6U6YBdi87cbNQl0PkAKFkfI10MDg7jlU/kDhjyp6Jd54Rj8Nd0dplNofSXXUhlmH+mBepPbsQNQioADZHIcfZDr8mbUahUWvhLHv+/2qIue1fLmoFEVAD615KEWbG4m5bVX+GZr3OPVXSqlM6kir/VGc2UbA5MzGdS34aqb99zSc/nUu8ipHpAQzAuuySbgqK3m+sAhylqvFGivgGTPWCoNbxNuMJu3XnY/RqwM5IbHNnMkDlvhTlLTyd5WYas4LvJaBxHVemLCrN1Fys64dwns3NcTBEQS4o0iuwdRbwTfLT70LgVXalzHPhmStQ=
Received: from localhost.localdomain (c188-149-162-200.bredband.tele2.se. [188.149.162.200])
        by smtp.gmail.com with ESMTPSA id z12-20020adfe54c000000b0033ae54cdd97sm7951740wrm.100.2024.02.05.04.30.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:30:47 -0800 (PST)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	kuba@kernel.org,
	toke@redhat.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	j.vosburgh@gmail.com,
	andy@greyhouse.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	edumazet@google.com
Cc: bpf@vger.kernel.org,
	Prashant Batra <prbatra.mail@gmail.com>
Subject: [PATCH net] bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY
Date: Mon,  5 Feb 2024 13:30:08 +0100
Message-ID: <20240205123011.22036-1-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Magnus Karlsson <magnus.karlsson@intel.com>

Do not report the XDP capability NETDEV_XDP_ACT_XSK_ZEROCOPY as the
bonding driver does not support XDP and AF_XDP in zero-copy mode even
if the real NIC drivers do.

Fixes: cb9e6e584d58 ("bonding: add xdp_features support")
Reported-by: Prashant Batra <prbatra.mail@gmail.com>
Link: https://lore.kernel.org/all/CAJ8uoz2ieZCopgqTvQ9ZY6xQgTbujmC6XkMTamhp68O-h_-rLg@mail.gmail.com/T/
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/net/bonding/bond_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4e0600c7b050..79a37bed097b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1819,6 +1819,8 @@ void bond_xdp_set_features(struct net_device *bond_dev)
 	bond_for_each_slave(bond, slave, iter)
 		val &= slave->dev->xdp_features;
 
+	val &= ~NETDEV_XDP_ACT_XSK_ZEROCOPY;
+
 	xdp_set_features_flag(bond_dev, val);
 }
 
@@ -5910,8 +5912,10 @@ void bond_setup(struct net_device *bond_dev)
 		bond_dev->features |= BOND_XFRM_FEATURES;
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-	if (bond_xdp_check(bond))
+	if (bond_xdp_check(bond)) {
 		bond_dev->xdp_features = NETDEV_XDP_ACT_MASK;
+		bond_dev->xdp_features &= ~NETDEV_XDP_ACT_XSK_ZEROCOPY;
+	}
 }
 
 /* Destroy a bonding device.

base-commit: fdeba0b57d61b40a708de361294fde3e1495588d
-- 
2.42.0


