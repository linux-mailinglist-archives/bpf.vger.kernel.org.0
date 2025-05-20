Return-Path: <bpf+bounces-58528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EEDABD01A
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 09:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538714A358C
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2146C25D1FE;
	Tue, 20 May 2025 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSn7oaup"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A191799F;
	Tue, 20 May 2025 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725129; cv=none; b=jbcglPQhFaC+RacMdr8H904j3az7guh0jLhgIl/crGfPaLUZgOIKoBfMo65YLAPcmD5SPdC3njX0esuyzch+BF+rAr0Y1BBh8KUknv2Pv1b0+E+ZRU/TokvLatl8SIwVKQZVFGvOcCNiLnYk1LnuIL9+akTQs9B9vJQ/HZNCCgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725129; c=relaxed/simple;
	bh=b5evWBJTWGYuIaCIoTvtE54TQUp1U7E1wACj5i6XqmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rJw36ci/+TcKI+MEZunCZ9KgWoQ+7wzkN1mMyaKSugYm+xE5nCz3iBee3yTCACE/ZYSpMhQOxGSEEpNKL4FmyyqHfiMzOJ7GEEtrdNToum6oCKzzhGVMGie1hSy8/7mjHKX9h2oAr7ArCho4ENLkkECI0BUCoIkxzktbEBv5L5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSn7oaup; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af548cb1f83so4765958a12.3;
        Tue, 20 May 2025 00:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747725127; x=1748329927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gqLN9mzzftYCgqVGJEUOnli3rFmc56NiTfRVJ7wT24o=;
        b=CSn7oaupxoKtxyuHhg16rig9HEMPZicSYuSQJ7QdR/WWpu2+soKIKnjrgWStemgx9+
         vM2AZ8S6RFKOGqwaWmtXA68dJ91Ad98M909dWvVD0hXDDM6D+XCrFvm55hF6rLhEQW0w
         9tWv19tmpGwDm7PkDdOnM5Mq+o0qDfsH0HDmrz1PZR51zoC75Ejw+nYGQlK4g+Njow8x
         Me2nu6hON63RGN3lfiAN+JvQcCdA5UV0Gb/Mtj/Nc40M/TnfThoMc9Qpar3OzRYrrsd3
         /TiXiNm8d/wPRgJYZI3w8M45F9v+GziGRd6YmJzhXbhUCqh1yOS+SXT9YtdBhKnaZ0x4
         d/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747725127; x=1748329927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqLN9mzzftYCgqVGJEUOnli3rFmc56NiTfRVJ7wT24o=;
        b=B50kWvLd9htTvLQ8Ko09Rrpis4Y6caiiBLBVLT5kasSVsnmyNH74WScYm3b9SEXN55
         B3PN/Xc6zeME9qfPWOFH4bJHo+F/RDqy0vVR7ok5n21+zcTte/s4jGWCsvlxMsZKFhZv
         02mDWcFsyZ5VJwLx19Vqtmcb+y3kzuYwi0x8k3j/OJnwy4lQCFJSkN2d2E7gcjLyCOnJ
         K4RRaoFkAoSoV5mM8Tz2bE+ocUjQHV4GpXsUzTK3kWJjhn2kp25d+Gi1rNMW2iYxH9rE
         wAcrSQOGqEyo3t7K6Lkuo3lP12x+ih8I7MdDsXra1QpPyczsGUqHzsTKEx4ITSV7MimF
         NOxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgdIeGRX4GF8t0FCQ+UiZvki8SeGg6JnQE2SO2+QWGa/JQIK47qQaRnDsg/s56Q6359gel8aoU@vger.kernel.org, AJvYcCWJjupj1BWP6bcdCjyO4HpHU9GW5u2qbol0c7CqUegFi5NSIxFxqHpp3oT5YKwQnHOzWc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxINE71et89VZGjq2awDsDLzE5Eynin/xGwYAW+2REgIRQIDMl2
	amMpiVPqKcHntQcM1vlS62/tuH3g2gUxFKM1qU1ECIfLeQg/MU3+bsn9
X-Gm-Gg: ASbGncvMtzMSV+PoOHEehDHSpuoJFq+oFUfrxFugBbmIHFDODRLepQs+WAHM9GVtwRK
	Uu+8b4grg4aELMqcGforqtlGCWGJuUoBDb5nObOz/YslqpAr+Yy6QcafUCkTXkOPfnXUwlGNYjW
	ytUbWhdO2KuMpy/FUyIe1sJsYE0cRVNQ/JvlR4C6mRMKj8YWxQPklZmbMgWcABgSYPEhYUtOMzC
	AiGQI4lEiyTJwITp1/dJp9No4q1G3825cYv/5jK0KRBvnPkrwX9ZtqljqMwUuY4+cGYFLZbM7Yy
	IJDSXeJOGDn5odG2roMflv8Mb8O+vTV/eSnFX+Wp
X-Google-Smtp-Source: AGHT+IHM+7tBAY1QQz54ggrEM9D+VZ2vlPPl16veJPN1EV5EnWA1SyFd3q8YAR4AxI3eZqRWm05E3g==
X-Received: by 2002:a17:902:dac7:b0:21f:7a8b:d675 with SMTP id d9443c01a7336-231de3515ccmr225945305ad.4.1747725127365;
        Tue, 20 May 2025 00:12:07 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e977f6sm70542395ad.131.2025.05.20.00.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 00:12:05 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: jdamato@fastly.com,
	martin.lau@kernel.org,
	hramamurthy@google.com,
	ap420073@gmail.com
Subject: [PATCH net-next] eth: bnxt: fix deadlock when xdp is attached or detached
Date: Tue, 20 May 2025 07:11:55 +0000
Message-Id: <20250520071155.2462843-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When xdp is attached or detached, dev->ndo_bpf() is called by
do_setlink(), and it acquires netdev_lock() if needed.
Unlike other drivers, the bnxt driver is protected by netdev_lock while
xdp is attached/detached because it sets dev->request_ops_lock to true.

So, the bnxt_xdp(), that is callback of ->ndo_bpf should not acquire
netdev_lock().
But the xdp_features_{set | clear}_redirect_target() was changed to
acquire netdev_lock() internally.
It causes a deadlock.
To fix this problem, bnxt driver should use
xdp_features_{set | clear}_redirect_target_locked() instead.

Splat looks like:
============================================
WARNING: possible recursive locking detected
6.15.0-rc6+ #1 Not tainted
--------------------------------------------
bpftool/1745 is trying to acquire lock:
ffff888131b85038 (&dev->lock){+.+.}-{4:4}, at: xdp_features_set_redirect_target+0x1f/0x80

but task is already holding lock:
ffff888131b85038 (&dev->lock){+.+.}-{4:4}, at: do_setlink.constprop.0+0x24e/0x35d0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev->lock);
  lock(&dev->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by bpftool/1745:
 #0: ffffffffa56131c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_setlink+0x1fe/0x570
 #1: ffffffffaafa75a0 (&net->rtnl_mutex){+.+.}-{4:4}, at: rtnl_setlink+0x236/0x570
 #2: ffff888131b85038 (&dev->lock){+.+.}-{4:4}, at: do_setlink.constprop.0+0x24e/0x35d0

stack backtrace:
CPU: 1 UID: 0 PID: 1745 Comm: bpftool Not tainted 6.15.0-rc6+ #1 PREEMPT(undef)
Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01/2021
Call Trace:
 <TASK>
 dump_stack_lvl+0x7a/0xd0
 print_deadlock_bug+0x294/0x3d0
 __lock_acquire+0x153b/0x28f0
 lock_acquire+0x184/0x340
 ? xdp_features_set_redirect_target+0x1f/0x80
 __mutex_lock+0x1ac/0x18a0
 ? xdp_features_set_redirect_target+0x1f/0x80
 ? xdp_features_set_redirect_target+0x1f/0x80
 ? __pfx_bnxt_rx_page_skb+0x10/0x10 [bnxt_en
 ? __pfx___mutex_lock+0x10/0x10
 ? __pfx_netdev_update_features+0x10/0x10
 ? bnxt_set_rx_skb_mode+0x284/0x540 [bnxt_en
 ? __pfx_bnxt_set_rx_skb_mode+0x10/0x10 [bnxt_en
 ? xdp_features_set_redirect_target+0x1f/0x80
 xdp_features_set_redirect_target+0x1f/0x80
 bnxt_xdp+0x34e/0x730 [bnxt_en 11cbcce8fa11cff1dddd7ef358d6219e4ca9add3]
 dev_xdp_install+0x3f4/0x830
 ? __pfx_bnxt_xdp+0x10/0x10 [bnxt_en 11cbcce8fa11cff1dddd7ef358d6219e4ca9add3]
 ? __pfx_dev_xdp_install+0x10/0x10
 dev_xdp_attach+0x560/0xf70
 dev_change_xdp_fd+0x22d/0x280
 do_setlink.constprop.0+0x2989/0x35d0
 ? __pfx_do_setlink.constprop.0+0x10/0x10
 ? lock_acquire+0x184/0x340
 ? find_held_lock+0x32/0x90
 ? rtnl_setlink+0x236/0x570
 ? rcu_is_watching+0x11/0xb0
 ? trace_contention_end+0xdc/0x120
 ? __mutex_lock+0x946/0x18a0
 ? __pfx___mutex_lock+0x10/0x10
 ? __lock_acquire+0xa95/0x28f0
 ? rcu_is_watching+0x11/0xb0
 ? rcu_is_watching+0x11/0xb0
 ? cap_capable+0x172/0x350
 rtnl_setlink+0x2cd/0x570

Fixes: 03df156dd3a6 ("xdp: double protect netdev->xdp_flags with netdev->lock")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

This is a bugfix patch but target branch is net-next because the cause
commit is not yet merged to net.

 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index e675611777b5..4a6d8cb9f970 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -425,9 +425,9 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 
 	if (prog) {
 		bnxt_set_rx_skb_mode(bp, true);
-		xdp_features_set_redirect_target(dev, true);
+		xdp_features_set_redirect_target_locked(dev, true);
 	} else {
-		xdp_features_clear_redirect_target(dev);
+		xdp_features_clear_redirect_target_locked(dev);
 		bnxt_set_rx_skb_mode(bp, false);
 	}
 	bp->tx_nr_rings_xdp = tx_xdp;
-- 
2.34.1


