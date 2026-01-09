Return-Path: <bpf+bounces-78298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E1ED08B4C
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 11:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A23030AB27F
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 10:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F0918A956;
	Fri,  9 Jan 2026 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwZyxbcr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC6B33985D
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955630; cv=none; b=pO+OE3DNXneBZDIWvAgGdlJ8QmczGhGP6xBbe6bmSEHjlHOLX583xx9jqbx220wRKREcvMXcRSF08GxkA+znFeH9nxzb4VVqR7AJK2rmq2laTr+aNSatRjmAnh524gh5vcfyeEm6YHjHrufX+4rTUFDMebaV82pN9eXYAz7gu7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955630; c=relaxed/simple;
	bh=n9M11tBs8r2SrFxtYr5Ez/2oL4MzSjaOy5sEeftcY74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jguKcyfLZtND3T2aViCE90oWntcj1RLQwFqGG8s/vyVm2dlZVa0jhYwPF4u55RccY90sZQYtGiHL7sZp+P33Jok92hYrMYRZc3Uj9cb69t3HHtEQWTzrXF4FnJ0i56/kIPS/v8I3UsrpT25YfsCJCgU1mjCDxDeKOISYB+6TnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwZyxbcr; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-11b992954d4so4126740c88.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 02:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767955628; x=1768560428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eHxiKPDxb+EGlvCWb1cuF8PeWUOAx5k4hd0veXvmtEk=;
        b=XwZyxbcrdeToN+zCzvK1xCE5b1g1kXGCMRJbYLaPZ36WXbMzCkmP+p9ibz4nFeKL8D
         O3lKftYZrJ+T7x2sbbgpN0NyV5xenkt3DssvYJKUucp45G6REgqHFplTeVCXZ6ab1ZDj
         SDxx9gyFsXbV9jiF6nFcr33P5JcfECr8eZ/EKwwgVpIULetrSJyORtsRmM1zMLEVjea5
         i0XwMeSpdXgggWJUXEW46OmskZ33dI3RPiud0toqHeuCjLow09+wDpXCgGrHJCUCzZOD
         trf+gVAjnU68wcLD+8gFwZtf2DQgCs9uWdykbM2kqVp8ros0aLm8nRR3nd65wd8znEbT
         rDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767955628; x=1768560428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHxiKPDxb+EGlvCWb1cuF8PeWUOAx5k4hd0veXvmtEk=;
        b=G4SCpv3tojLsAmzpSN2FxoRiNwai4Q5Wmf9Bv7u61pCMzbfQEZnmh28B/PhzqzacHJ
         hl+pd3gTANxmhreUgps4DcOoKZF/RPEaHdN+C99yFcRmJCwDgphwmddS5SnVfcetrbxC
         AgrWSNnefpluWS+3t020Erb61XJFxKxpqo+qCZbwck7uN150084wbiJhJ6vxUX54gyOa
         OoMt1lrf5y86FeE3xg/LAvlKU680yDHLfUqdmKyqAWP0dJ3biAMHy/6tzUlGGIbykAyq
         fu+F1wWLWxrHAdbo72aG/xCap4orPu5ntnWr76N3uwbwPBshESrtfG0wpWFb4obC6SCb
         cQTg==
X-Gm-Message-State: AOJu0YyJcsOdGfObich3fMbtUCwWERR3f7OuOvoImAxYE13z1Xg537ns
	/5pAQtvD/U5zmHTBQzT/Zs/QcU3e89f0LsrTllQUrWID0Yf9AikEjJucaglnKoxeM287dnc=
X-Gm-Gg: AY/fxX6XxNUv7YdodooGQf5usF3yW3SBUeVnHxYxfLbOZbJYgw7KJBEgZTM9jf6qF4Q
	mxxdSwOEzsLPOYRqLDw3kssfVpJKaUWgBsjLH5N5IrsGOmzJaDtcPlihZBLlauGWDpwoEHTFJj2
	97HO81/kf4fSjGHtjLaTNaCYNfYDcLEoyx2Ar3gEuWs6hlQg1k8E0uxJqUXzaEq2O606cxLLTSD
	Q+e9lAR0+QWm7rQfr2WLW3D7dhiUsyLuN2xfmG75I7NWm2jaAxFXs/0707Cy24MgrmI+AcA1uwy
	FGjmWWSc+IrdgHuA1AJpK5d8RnUPUlyRiaR+Z2Ypq4ZrZl4eVooRI8mCxcGcZZ7S9xc/riaF2NA
	MdH1mwBTRImxJDyrj4ufeHXdJ6QyARn9mlHSYHaXqciThUQaXN2azj65D8WDogZ8PS9k6bBRUji
	BjltM68UoreC9S3vU=
X-Google-Smtp-Source: AGHT+IHGZZvre9Q0sLUGFl2WViHF679c3kOLK8MwcJYpsokl7wywksfV3DWgiCiy59cqiv6zQtjEXA==
X-Received: by 2002:a05:7300:b28a:b0:2a4:61d1:f433 with SMTP id 5a478bee46e88-2b17d2525eamr4881696eec.16.1767955628094;
        Fri, 09 Jan 2026 02:47:08 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([209.141.36.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078dd8fsm12814933eec.20.2026.01.09.02.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 02:47:07 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bjorn@kernel.org,
	hawk@kernel.org,
	pabeni@redhat.com,
	magnus.karlsson@intel.com,
	daniel@iogearbox.net,
	maciej.fijalkowski@intel.com,
	kuba@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	ast@kernel.org,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH bpf] xsk: fix init race causing NPD/UAF in xsk_create()
Date: Fri,  9 Jan 2026 18:46:44 +0800
Message-ID: <20260109104643.1988-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xsk_init() previously registered the PF_XDP socket family before the
per-net subsystem and other prerequisites (netdevice notifier, caches)
were fully initialized.

This exposed .create = xsk_create() to user space while per-netns
state (net->xdp.lock/list) was still uninitialized. A task with
CAP_NET_RAW could trigger this during boot/module load by calling
socket(PF_XDP, SOCK_RAW, 0) concurrently with xsk_init(), leading
to a NULL pointer dereference or use-after-free in the list manipulation.

To fix this, move sock_register() to the end of the initialization
sequence, ensuring that all required kernel structures are ready before
exposing the AF_XDP interface to userspace.

Accordingly, reorder the error unwind path to ensure proper cleanup
in reverse order of initialization. Also, explicitly add
kmem_cache_destroy() in the error path to prevent leaking
xsk_tx_generic_cache if the registration fails.

Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 net/xdp/xsk.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..d402f23dfd8e 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -23,6 +23,7 @@
 #include <linux/netdevice.h>
 #include <linux/rculist.h>
 #include <linux/vmalloc.h>
+#include <linux/slab.h>
 #include <net/xdp_sock_drv.h>
 #include <net/busy_poll.h>
 #include <net/netdev_lock.h>
@@ -1922,13 +1923,9 @@ static int __init xsk_init(void)
 	if (err)
 		goto out;
 
-	err = sock_register(&xsk_family_ops);
-	if (err)
-		goto out_proto;
-
 	err = register_pernet_subsys(&xsk_net_ops);
 	if (err)
-		goto out_sk;
+		goto out_proto;
 
 	err = register_netdevice_notifier(&xsk_netdev_notifier);
 	if (err)
@@ -1939,17 +1936,21 @@ static int __init xsk_init(void)
 						 0, SLAB_HWCACHE_ALIGN, NULL);
 	if (!xsk_tx_generic_cache) {
 		err = -ENOMEM;
-		goto out_unreg_notif;
+		goto out_notifier;
 	}
 
+	err = sock_register(&xsk_family_ops);
+	if (err)
+		goto out_cache;
+
 	return 0;
 
-out_unreg_notif:
+out_cache:
+	kmem_cache_destroy(xsk_tx_generic_cache);
+out_notifier:
 	unregister_netdevice_notifier(&xsk_netdev_notifier);
 out_pernet:
 	unregister_pernet_subsys(&xsk_net_ops);
-out_sk:
-	sock_unregister(PF_XDP);
 out_proto:
 	proto_unregister(&xsk_proto);
 out:
-- 
2.34.1


