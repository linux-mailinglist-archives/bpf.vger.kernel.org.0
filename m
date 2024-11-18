Return-Path: <bpf+bounces-45076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E459D0B7F
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 10:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67AD281A34
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7B718B47E;
	Mon, 18 Nov 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt7l/bUN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2922F30;
	Mon, 18 Nov 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731921553; cv=none; b=iHnw7qfK2uE1MemyS376YPbpDwZ0OXsJOK/o9d2jyAv48hz+5ZrLh5lOMkLvDzY0OgiUX1uEms/IvnCOWiDElfJ0M/wxd8AzyVv7iYzJP2BxavWh+wy++qpgBT2m1V3+qeh5valtD8HXU8Z/2JqTPr1wMSEVGCMxpb56+mEJrBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731921553; c=relaxed/simple;
	bh=O+PI4OW0IWhlVdS71QY5FfS/+ja6U+8ecv2rzMkTL8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CFGNhhaTSyalFKQzASZFrZeN1841k8Jv+J3KO7LbXteevIC53SAqpB6y9uMd6SyrLMeFrQumJvLJ2uKinxaE7wo6iwSHOGrqNmDwzCMdle00He84m32OIdeiVLUplT9/dDU1l4dl5W2H2i7MLLxsnLyw3Y9hbNxM+gSPgf7ZlJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt7l/bUN; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20e6981ca77so28584305ad.2;
        Mon, 18 Nov 2024 01:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731921552; x=1732526352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vWMSyHTrfa12pSatkYAmKcsgbh3IA7p2GurKZou/Uv0=;
        b=Gt7l/bUNXdNaDoaix4ojSPyWQUwOtohQIPM4cf98cG1ZhwlgDn3o0FEGD800EIl/yU
         gkDWdfTyonF3/m+IrCbcdJLxUec6gYW3djcZ11PRdW9sv+37y1ctuA8awVLoZ2bsf+Go
         AdEiNcU/e7cd80TnC+OozxEAvgXRKZ+N0GRaO/UkWYc7Z4qyaHFvYlzj6cOxNszJ5Mg9
         kwG+86zA0By9yShUVVHw9tmW9QqcwymIOTG/Ft4+LPrDEsrFsUTPUVsrvroPW20oa++k
         0owCUoT+53SNjarxQRyvjjYopSFak8V0GYZEYs1qI6IF9M6hTIi1l8T+R6WJ+C2qSAdB
         2aTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731921552; x=1732526352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWMSyHTrfa12pSatkYAmKcsgbh3IA7p2GurKZou/Uv0=;
        b=Uu/DssE/yHZkIMDH225NooakFhNAdYq0hl5oQbnj2e3Ss43r5bBAVemPbQ9RLKt4x0
         mv8E3+8vLtM3SH8HsKpTIu42NUAOmXgZSf8p3+h9jEcbO8vATgUx9ZBjOKzjn0HfKeUI
         qVE1KxMdbw+R771jfqtg4QvDupng/1lfbvpY+2DHU/y3JDYTF/F0BHRV4shYBA5SLlXW
         0GFyv9Jyi9dqtHCKFkX28srUCqUhqF1p8WMc4ZvD4U09tH4KcU7L8yOVpLV8eDlLcLTF
         ObUu0+y4mcItXNUVn9086+KhUtQAyMDnTEOyZJRQl6SZZkx3Od+QlfevuACtTpIwVm9c
         zqSw==
X-Forwarded-Encrypted: i=1; AJvYcCUD6YH5G/EGuhwG4eDjcFNggkBe97Oaz2ixla39f/KB2hvqiFpwPqfSHGDVozfr81O0waJX/Zc3@vger.kernel.org, AJvYcCWuY2asIEqbnAjks3kljC63gnyv/0vAvl3NDsgah6FVIeiIlAojwh3LS3uf8gaaGSYGO/0=@vger.kernel.org, AJvYcCXgmNl7ebiycLK5kNuoMd0zI6Vl1yeeZfs7lMTh3f4lfbhf+uVprPwcEkSkAr7eKXn6rZzgQs6i+TD/uoVB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7T3pN0OidPJBqkT3IVIiwtG1sYNSn9ySFJk2pRsQkiqmASzLa
	J+XBYf9FW+NhySFLA3vgAtwnBhGpJ8t0hGTsdF8xpDNLsEzwm1g9
X-Google-Smtp-Source: AGHT+IGzx8yVMyM1WqjzZJ1G46lJB3y2YvZSz/Xf4kcsFo9q1n5kpz4ywYgP+pZnkeEuvv+evMCunQ==
X-Received: by 2002:a17:903:11c9:b0:20c:d428:adf4 with SMTP id d9443c01a7336-211d0ecb083mr178751585ad.38.1731921551694;
        Mon, 18 Nov 2024 01:19:11 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f54456sm52369485ad.245.2024.11.18.01.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:19:11 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	menglong8.dong@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com
Subject: [PATCH net-next] net: ip: fix unexpected return in fib_validate_source()
Date: Mon, 18 Nov 2024 17:14:27 +0800
Message-Id: <20241118091427.2164345-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The errno should be replaced with drop reasons in fib_validate_source(),
and the "-EINVAL" shouldn't be returned. And this causes a warning, which
is reported by syzkaller:

netlink: 'syz-executor371': attribute type 4 has an invalid length.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5842 at net/core/skbuff.c:1219 __sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
WARNING: CPU: 0 PID: 5842 at net/core/skbuff.c:1219 sk_skb_reason_drop+0x87/0x380 net/core/skbuff.c:1241
Modules linked in:
CPU: 0 UID: 0 PID: 5842 Comm: syz-executor371 Not tainted 6.12.0-rc6-syzkaller-01362-ga58f00ed24b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:__sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
RIP: 0010:sk_skb_reason_drop+0x87/0x380 net/core/skbuff.c:1241
Code: 00 00 00 fc ff df 41 8d 9e 00 00 fc ff bf 01 00 fc ff 89 de e8 ea 9f 08 f8 81 fb 00 00 fc ff 77 3a 4c 89 e5 e8 9a 9b 08 f8 90 <0f> 0b 90 eb 5e bf 01 00 00 00 89 ee e8 c8 9f 08 f8 85 ed 0f 8e 49
RSP: 0018:ffffc90003d57078 EFLAGS: 00010293
RAX: ffffffff898c3ec6 RBX: 00000000fffbffea RCX: ffff8880347a5a00
RDX: 0000000000000000 RSI: 00000000fffbffea RDI: 00000000fffc0001
RBP: dffffc0000000000 R08: ffffffff898c3eb6 R09: 1ffff110023eb7d4
R10: dffffc0000000000 R11: ffffed10023eb7d5 R12: dffffc0000000000
R13: ffff888011f5bdc0 R14: 00000000ffffffea R15: 0000000000000000
FS:  000055557d41e380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056519d31d608 CR3: 000000007854e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kfree_skb_reason include/linux/skbuff.h:1263 [inline]
 ip_rcv_finish_core+0xfde/0x1b50 net/ipv4/ip_input.c:424
 ip_list_rcv_finish net/ipv4/ip_input.c:610 [inline]
 ip_sublist_rcv+0x3b1/0xab0 net/ipv4/ip_input.c:636
 ip_list_rcv+0x42b/0x480 net/ipv4/ip_input.c:670
 __netif_receive_skb_list_ptype net/core/dev.c:5715 [inline]
 __netif_receive_skb_list_core+0x94e/0x980 net/core/dev.c:5762
 __netif_receive_skb_list net/core/dev.c:5814 [inline]
 netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5905
 netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5957
 xdp_recv_frames net/bpf/test_run.c:280 [inline]
 xdp_test_run_batch net/bpf/test_run.c:361 [inline]
 bpf_test_run_xdp_live+0x1b5e/0x21b0 net/bpf/test_run.c:390
 bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1318
 bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4266
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f18af25a8e9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee4090af8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f18af25a8e9
RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Fix it by returning "-SKB_DROP_REASON_IP_LOCAL_SOURCE" instead of
"-EINVAL" in fib_validate_source().

Reported-by: syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6738e539.050a0220.e1c64.0002.GAE@google.com/
Fixes: 82d9983ebeb8 ("net: ip: make ip_route_input_noref() return drop reasons")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/fib_frontend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 87bb36a5bdec..272e42d81323 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -447,7 +447,7 @@ int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 		 * and the same host but different containers are not.
 		 */
 		if (inet_lookup_ifaddr_rcu(net, src))
-			return -EINVAL;
+			return -SKB_DROP_REASON_IP_LOCAL_SOURCE;
 
 ok:
 		*itag = 0;
-- 
2.39.5


