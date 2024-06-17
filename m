Return-Path: <bpf+bounces-32317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A931A90B6C2
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 18:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4FF1C23648
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 16:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E4B1662E3;
	Mon, 17 Jun 2024 16:43:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA6820B3E;
	Mon, 17 Jun 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642589; cv=none; b=G/14lKUwR/4BC5wdUjUwpXI6tAJ73VYGbmGRF4qaTP0+ovdv2hl0KLLBElSZQ00n0NuhC3nxPMM31BBGFVlgC/BHSGA1tRHsYaA5nRHXGBuo8QQtv0aJPDAyNmhMH62oFefTkXF0UTy3wyJk20cAOwCUm/YX9lJCjXlyl+A019c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642589; c=relaxed/simple;
	bh=T66CKAQdjo08E7zecAEgrpzt9lx/5uvhDB/wmiDkH54=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UIIm8uxAaR7lzgICaBy0T7DbgES9j89+c+4xJ0Y8MP3XHggYe2dHKaanrFRlO7fyqjKIX1vjC2NXWEgwEuBgqGfH/sfJ7fDGw9raKpX32cxlSw4S5BzwAaTKYiqDALHOE5cYma/UXaRGDGcUiOAiB/KmsRn8WXCP2lyh/jMB/r8=
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
Subject: [PATCH] xdp: remove WARN() from __xdp_reg_mem_model()
Date: Mon, 17 Jun 2024 19:27:08 +0300
Message-ID: <20240617162708.492159-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-02.aladdin.ru (192.168.1.102) To
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
---
 net/core/xdp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/xdp.c b/net/core/xdp.c
index 41693154e426..fb2f00e3f701 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -296,7 +296,6 @@ static struct xdp_mem_allocator *__xdp_reg_mem_model(struct xdp_mem_info *mem,
 		ret = __mem_id_init_hash_table();
 		mutex_unlock(&mem_id_lock);
 		if (ret < 0) {
-			WARN_ON(1);
 			return ERR_PTR(ret);
 		}
 	}
-- 
2.25.1


