Return-Path: <bpf+bounces-32876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4F091443D
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 10:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9AA4283DD6
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 08:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484D49645;
	Mon, 24 Jun 2024 08:08:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C3447F6C;
	Mon, 24 Jun 2024 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216518; cv=none; b=WgDbHyOTYBu62lV0FBwENghT9dA4p56zL184I5wlJSiQiMdMGaY62Sb7LBqixNF5KpOX3Ox50OvnAuPcDRgiDPObq0SNSGbC79qwZKen8Fgfy5DwAfNVQayvxtc0kwRPhyucFhmE7k2FCwsEGSRO0PRXkarSj2TCh2amAnK6RbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216518; c=relaxed/simple;
	bh=1EfVWLN8EujHeW9ugE6PQVP6G/uH1aYrSaJvrCJ+/xA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S6yYMyNuHseliQeJG95Q0HXBEJ+3D7sDtfv6lhkj0HB6k1+CEeSN49p9NivdLmqxqKZRJlQ5IQ5OnFomyuF87ZJmf6LFA/augfkhkcRQcyB7eaCrjn9CiONA4dTw/4MJtfQQvL7vkZaGhfd9LZyRgAB8yfR0pM1qla0vG6BTs5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Alexei Starovoitov <ast@kernel.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] xdp: remove WARN() from __xdp_reg_mem_model()
Date: Mon, 24 Jun 2024 11:07:47 +0300
Message-ID: <20240624080747.36858-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-01.aladdin.ru (192.168.1.101) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

Syzkaller reports a warning in __xdp_reg_mem_model().

The warning occurs only if __mem_id_init_hash_table() returns
an error. It returns the error in two cases:

  1. memory allocation fails;
  2. rhashtable_init() fails when some fields of rhashtable_params
     struct are not initialized properly.

The second case cannot happen since there is a static const
rhashtable_params struct with valid fields. So, warning is only triggered
when there is a problem with memory allocation.

Thus, there is no sense in using WARN() to handle this error and it can be
safely removed.

WARNING: CPU: 0 PID: 5065 at net/core/xdp.c:299 __xdp_reg_mem_model+0x2d9/0x650 net/core/xdp.c:299

CPU: 0 PID: 5065 Comm: syz-executor883 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__xdp_reg_mem_model+0x2d9/0x650 net/core/xdp.c:299

Call Trace:
 xdp_reg_mem_model+0x22/0x40 net/core/xdp.c:344
 xdp_test_run_setup net/bpf/test_run.c:188 [inline]
 bpf_test_run_xdp_live+0x365/0x1e90 net/bpf/test_run.c:377
 bpf_prog_test_run_xdp+0x813/0x11b0 net/bpf/test_run.c:1267
 bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 8d5d88527587 ("xdp: rhashtable with allocator ID to pointer mapping")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
v2: Removed unnecessary brackets as Jakub Kicinski <kuba@kernel.org>
suggested, also added Acked-by Jesper Dangaard Brouer <hawk@kernel.org>
Link: https://lore.kernel.org/all/20240617162708.492159-1-d.dulov@aladdin.ru/

 net/core/xdp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 41693154e426..022c12059cf2 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -295,10 +295,8 @@ static struct xdp_mem_allocator *__xdp_reg_mem_model(struct xdp_mem_info *mem,
 		mutex_lock(&mem_id_lock);
 		ret = __mem_id_init_hash_table();
 		mutex_unlock(&mem_id_lock);
-		if (ret < 0) {
-			WARN_ON(1);
+		if (ret < 0)
 			return ERR_PTR(ret);
-		}
 	}
 
 	xdp_alloc = kzalloc(sizeof(*xdp_alloc), gfp);
-- 
2.25.1


