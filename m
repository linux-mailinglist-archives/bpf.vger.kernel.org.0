Return-Path: <bpf+bounces-49394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D67A180C0
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 16:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B42816B55F
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 15:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAC41F5413;
	Tue, 21 Jan 2025 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jz+ur9PB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E66F1F4715
	for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737472030; cv=none; b=NqRKoVbWBClST7uT08UQK/dLzESZwuw+MWbi4rP0HQXaQgWj1M1OQE55KWiM28TjPTUue68nouQIzEO6qeNco/BeVOFH2C4huvYgF7f6w8pNTo40n02HJCOtyjbEwQZ024TEyHt8WRKfa4PPQKUTp+QI8uGeem9cWOHEBMEiny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737472030; c=relaxed/simple;
	bh=E4awb02GfOMHu6yIjUy62+GVOVOjQQgO9J5MZBqVA58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZtzR/mEPJhpKA/KZC1NB9B9j78Y4ygwjleHlO7xb6BW6bEaiLOMsjbdnRt5DQqnHgSVXSRWcU31uFFiSmrWWkfKTcYxXkf2YfUExGeu7Ikh/0CPO4SsjoSPOWUdClKeFknpcY9egedwnfLi0g7t0KOAB0FasyjBivuEYD+xseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jz+ur9PB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737472027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S0A13FjhF2U6qOIcW/juVfvCcYxku+JtO5E2OXUx59g=;
	b=Jz+ur9PB+tUJ0Yz2oAPrxLPBZpzJqy3PewsJd51DiMCdUDtnfTr2rIohS20uKI9+bv1beC
	6Zo/R4MAuGBfTAoG7SIBlQtZ2k/aOajl4o5JXIw0ou+OWht1mEoUdfhTWstAw5I0MeIfSC
	IST2pKxX50KNskKdc9YFF+x2RrBkAOo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-3FwZ7jY8OVeIE14nCbnp1Q-1; Tue, 21 Jan 2025 10:07:05 -0500
X-MC-Unique: 3FwZ7jY8OVeIE14nCbnp1Q-1
X-Mimecast-MFC-AGG-ID: 3FwZ7jY8OVeIE14nCbnp1Q
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2161d5b3eb5so102841375ad.3
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 07:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737472025; x=1738076825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0A13FjhF2U6qOIcW/juVfvCcYxku+JtO5E2OXUx59g=;
        b=d+LcSa7kV+9I+8yBe7OffQOD36DztqedCL29rpaLFx5qPnwWozUt3Es3j4u0m9dC3i
         yXBF4J4XETbwo5qKv06u1r5It4bLM4xPpwKe40GI3wR9BU8IvZCybPFFxsCsVPdti8+K
         QgM9Qb/LoSCbpmRC113rXjKNYXbq9kcrNwGZsJ4waqmCWRlAAmrMureJgaPy9De25EzQ
         3eYqzDcwynICxerf118PEbMAu72RraLSfcY7lYfiBEfw9uG8nekW9nhiyLbCm1vNHtSV
         QRvupPrYqUXuWzM3fDeZhmNLsGMgRzoODXNfO2kWVwxw+ZNb2oTFNL49E7D7aeE9oI69
         AGBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSe7VFXuoWZM0OpUylFI4C29iNu53kt4hj2tNif0BYuMEqrvEtghwHmZDeNtDQQ/4sX7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6YMeKNBLyRxdRQ4v2SXt/wA+/JPTTGtifkshefY4wjeW26eJ2
	0aPG528sjkPkcZod4XMcBfhsH81Ubt6dy9RNCCmmYR42uYh6qbCgcC7IKraPIWGqjwaukjP2W0W
	ZXTsBBJ4i9bjYd6pWAfXy0wTu3gpFHvOmuJkI/zCOeLZOvz8Ejw==
X-Gm-Gg: ASbGncvPyNNvp2J/U3G9LU/4dk6lbVcl4XxzdhOxSN1n1y1TNYWG9JJDwPuDscht7Ta
	sdKLg98KEIR8p7cnVod9PVRjGezJEX8ZoZJ2gZUXsGpn76BAOB6I6QXngpWSg89em6SwaKYBjsL
	e9L+pZc0zAq4hGJXVmNeSIfKz7MzDrGOIA6iCCb1rawzfPkfecVablHpNmR1MymW4U6E+9YA0uE
	esVkQamYcnGqcA7IakJp9o5MkTW20TSnvAJMlg/QgsFp1xHby3ULFi84SH2KyF1LAslgfzpAZ8F
	vXndqaoWsjiUdipzfJJGT4XARmB6+M8rlyM=
X-Received: by 2002:a17:902:f60f:b0:215:8270:77e2 with SMTP id d9443c01a7336-21c34cb5bf8mr290507585ad.0.1737472023285;
        Tue, 21 Jan 2025 07:07:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFip8Sgzo2DHVqMP4MZArU5I4YQ9MZM/9OeVcTT5mtCY+uCBZ3gqY1GJj53CP0hgom4XvZXlA==
X-Received: by 2002:a17:902:f60f:b0:215:8270:77e2 with SMTP id d9443c01a7336-21c34cb5bf8mr290506035ad.0.1737472021406;
        Tue, 21 Jan 2025 07:07:01 -0800 (PST)
Received: from kernel-devel.local (fp6fd8f7a1.knge301.ap.nuro.jp. [111.216.247.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ce9efe3sm79066215ad.20.2025.01.21.07.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 07:07:00 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	hawk@kernel.org,
	lorenzo@kernel.org,
	toke@redhat.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	stfomichev@gmail.com,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH bpf v2 1/2] bpf, test_run: Fix use-after-free issue in eth_skb_pkt_type()
Date: Wed, 22 Jan 2025 00:06:42 +0900
Message-ID: <20250121150643.671650-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported a use-after-free issue in eth_skb_pkt_type()[1]. The
cause of the issue was that eth_skb_pkt_type() accessed skb's data
that didn't contain an Ethernet header. This occurs when
bpf_prog_test_run_xdp() passes an invalid value as the user_data
argument to bpf_test_init().

Fix this by returning an error when user_data is less than ETH_HLEN in
bpf_test_init(). Additionally, remove the check for "if (user_size >
size)" as it is unnecessary.

[1]
BUG: KMSAN: use-after-free in eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
BUG: KMSAN: use-after-free in eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
 eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
 eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
 __xdp_build_skb_from_frame+0x5a8/0xa50 net/core/xdp.c:635
 xdp_recv_frames net/bpf/test_run.c:272 [inline]
 xdp_test_run_batch net/bpf/test_run.c:361 [inline]
 bpf_test_run_xdp_live+0x2954/0x3330 net/bpf/test_run.c:390
 bpf_prog_test_run_xdp+0x148e/0x1b10 net/bpf/test_run.c:1318
 bpf_prog_test_run+0x5b7/0xa30 kernel/bpf/syscall.c:4371
 __sys_bpf+0x6a6/0xe20 kernel/bpf/syscall.c:5777
 __do_sys_bpf kernel/bpf/syscall.c:5866 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5864 [inline]
 __x64_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:5864
 x64_sys_call+0x2ea0/0x3d90 arch/x86/include/generated/asm/syscalls_64.h:322
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd9/0x1d0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 free_pages_prepare mm/page_alloc.c:1056 [inline]
 free_unref_page+0x156/0x1320 mm/page_alloc.c:2657
 __free_pages+0xa3/0x1b0 mm/page_alloc.c:4838
 bpf_ringbuf_free kernel/bpf/ringbuf.c:226 [inline]
 ringbuf_map_free+0xff/0x1e0 kernel/bpf/ringbuf.c:235
 bpf_map_free kernel/bpf/syscall.c:838 [inline]
 bpf_map_free_deferred+0x17c/0x310 kernel/bpf/syscall.c:862
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa2b/0x1b60 kernel/workqueue.c:3310
 worker_thread+0xedf/0x1550 kernel/workqueue.c:3391
 kthread+0x535/0x6b0 kernel/kthread.c:389
 ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

CPU: 1 UID: 0 PID: 17276 Comm: syz.1.16450 Not tainted 6.12.0-05490-g9bb88c659673 #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014

Fixes: be3d72a2896c ("bpf: move user_size out of bpf_test_init")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
v2:
- Rewrote the code as suggested by Martin.
- Fixed the broken tests.
v1:
- https://lore.kernel.org/all/20241201152735.106681-1-syoshida@redhat.com/
---
 net/bpf/test_run.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 501ec4249fed..8612023bec60 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -660,12 +660,9 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 user_size,
 	void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
 	void *data;
 
-	if (size < ETH_HLEN || size > PAGE_SIZE - headroom - tailroom)
+	if (user_size < ETH_HLEN || user_size > PAGE_SIZE - headroom - tailroom)
 		return ERR_PTR(-EINVAL);
 
-	if (user_size > size)
-		return ERR_PTR(-EMSGSIZE);
-
 	size = SKB_DATA_ALIGN(size);
 	data = kzalloc(size + headroom + tailroom, GFP_USER);
 	if (!data)
-- 
2.48.1


