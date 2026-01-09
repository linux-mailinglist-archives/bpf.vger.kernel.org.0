Return-Path: <bpf+bounces-78293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D48EAD08802
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 11:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 380CF307F9B2
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 10:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513253385B1;
	Fri,  9 Jan 2026 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErAySkM8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91415336EFF
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767953094; cv=none; b=VjPv8XIF++SHmypQ/6mUUKlglY0bq+2F2MPbBMlH7tdpPSit/szCYcLfEVDArfEy9eIPhynZ6LGHnH4/p3vDjR6FCe+d8kKff9UsJtNaL3cGAEJ9MSfp2JutB08W1LTc2QiAze8mTmED8gcCzKSrZ8xRAhJ3LAHju9Ljmo4va4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767953094; c=relaxed/simple;
	bh=5jrWyB4XCBVBz8ho+oQz/OHpCGaaHiVH2B1jpdtutqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dLNjqz7vWqXmBMHMdbBz/LEvPE3C4mi60ZojJ6tDnIVmktvnHbhA7NpSQpSfK+TIY7cxChxCBm7HhgbJhEXLN35fKHDfDLU5LKneR67qv7p9z5wNCNs/+ILkKK90wgAL/jtpCoQLFV82UH5qgrxczEWw+Bzb0UiTJvq3LCDWw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErAySkM8; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-11f3a10dcbbso3352410c88.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 02:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767953092; x=1768557892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug9UXruECokBl2MPfxQMo1D+f+1ql2Retnj+DiiH+DY=;
        b=ErAySkM8BKnthtcpMjJ0dL565BjnYt4vwBhSp2uQSYlhpk/u4gOvM5bR8MXwsrriD0
         imStvU5oHJh9G/+68LCuu0jjPTPEpyOwOJPtu7+PW19F/mcSmmBcZ2OPfsMQTLxReIeL
         DYNtSua3MT+rq0pcgnX/ifj++XTCRq+TmmqJL7uiyPwZqDIw2i4iUij1ZK7q5FUFO0wr
         Prtu/Efl8a2+BUW2tIKXMx+4qtw/RgdEj+H17xpsCdgn7G5NTkN/2b+LMFaAR4RJYMRQ
         MGOzvsRabqQ2UEDyt/znFdXx/LnrRkwmpmzO0S9npozLw0shuaMSPCnNq+3fpeiDUoqd
         Kifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767953092; x=1768557892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ug9UXruECokBl2MPfxQMo1D+f+1ql2Retnj+DiiH+DY=;
        b=JBYSk9VP8uQWT5DzR067mmfRIXnof5YTQ+ZiB6ntr146hJSGcmG1FQsgPkU4ycGGtO
         UNgKjRhmRVaWBCCJjgnRSlmZpbfqYIlQ+mKPfjpJzIESdXt+7BO9oM86akQv3yS3gdyv
         pCA7t6Z4mwWPkjx7m6W4LltPGgoj0PpuyKjax7nBQxZdlKY1FDQhSvCWfQ9YWv7DKKNX
         8IYBfLItZ0BFG40SpPdw9Sb/D9r/Tol/S1wW7EnQPQsAkyTJCZq69HaLQyF1ZMjCAu+D
         zEzkLhbqWYiDkOoHwuY2QzvgTrP6dfYVErDHNxR9ht/EfORX7RNAIkAqda/sEx8TBhc4
         1yjg==
X-Gm-Message-State: AOJu0YyhFCo7J/zIuFAGqZaa8WTX4MCmovKeg5jmtqDOpPPjbGJdTNPm
	cnUsLoGk9fkCrsALpuNSzZAGrwzQa3XHcQY0VfilwIk9rEKJgrXbX8Fe05Hs/W6E+TdL0A8=
X-Gm-Gg: AY/fxX4M8A9QtF/ys6B3KygFEobKFibAC99EtyhtnxVyTrFABV7zVO7ckOjTUMRuhhE
	pEdIR68hLxXxIPamNHpFSv78G5RB6N5NNWS5lMJxnRAeEEGH0K6dM1EeFhdVWqC6+CLgMaq4bx9
	iPwUtPMzaK6P9IxDSVY14w3NFbphlMvxa7Ed15H1E40nDdkIIGRHKEKUq8Zh3yCBPD1Bnj7p9ld
	QADyqK1xTncpHs/PK6QmW+OzfPCzsNrtVOtIIbLtFKGjID0rEHWA/tWERhyWD3hmpppei2ibq5r
	AFRWrEv/FFDQV0gxUnCKfSNsHC7c9riWdjjJmlbLQ66MAMllQ9IErF4+dVcq6BjvrJlskm9CAxa
	zC+DmA22R0oM/CUCOysK2ukA/AVIlAYrhdgsbjJszvk0mq9bXG/MrX1AKAfHdru5ZsGrHEmEsih
	ctIR3OD26v9zpRdH0=
X-Google-Smtp-Source: AGHT+IEuXoXtHTnUokSTkV/047cQ2XVT2pT27RHEC/fHpKbJH7+a13ZDPg9quvun7MxRLm7ESuhhCQ==
X-Received: by 2002:a05:7022:48d:b0:11b:ceee:a49f with SMTP id a92af1059eb24-121f8afbcd2mr7993025c88.8.1767953091595;
        Fri, 09 Jan 2026 02:04:51 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([209.141.36.37])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243f6c7sm12742527c88.7.2026.01.09.02.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 02:04:50 -0800 (PST)
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
Date: Fri,  9 Jan 2026 18:04:20 +0800
Message-ID: <20260109100420.1967-2-qikeyu2017@gmail.com>
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
 net/xdp/xsk.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..58e9c61c29e0 100644
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
@@ -1922,10 +1923,6 @@ static int __init xsk_init(void)
 	if (err)
 		goto out;
 
-	err = sock_register(&xsk_family_ops);
-	if (err)
-		goto out_proto;
-
 	err = register_pernet_subsys(&xsk_net_ops);
 	if (err)
 		goto out_sk;
@@ -1942,16 +1939,21 @@ static int __init xsk_init(void)
 		goto out_unreg_notif;
 	}
 
+	err = sock_register(&xsk_family_ops);
+	if (err)
+		goto out_proto;
+
 	return 0;
 
+out_proto:
+	proto_unregister(&xsk_proto);
+	kmem_cache_destroy(xsk_tx_generic_cache);
 out_unreg_notif:
 	unregister_netdevice_notifier(&xsk_netdev_notifier);
 out_pernet:
 	unregister_pernet_subsys(&xsk_net_ops);
 out_sk:
 	sock_unregister(PF_XDP);
-out_proto:
-	proto_unregister(&xsk_proto);
 out:
 	return err;
 }
-- 
2.34.1


