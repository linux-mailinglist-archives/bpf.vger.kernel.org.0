Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9426972C
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2019 17:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbfGON5c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Jul 2019 09:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732702AbfGON5c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Jul 2019 09:57:32 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A6DE20C01;
        Mon, 15 Jul 2019 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199051;
        bh=E3eGmKm5nu0OPb0GNpkfQOq2G2P0cK/daWQvt8RA8sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jX02P9PZv/7bPJfl/R8+vNNBcgvXJo6zrg7QuZMsaXDejjqXs4bD7jxzqQA1JWaVn
         aMGXv9ty402bLhV4CkT59c2/29ULvSsxl4kIPruh+o8PbUJciRxdw32VynvBqCI9yd
         Yzn+cdtYXf1qxvMtZvNxCXskkQO0UNpq7TsEfsY8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, xdp-newbies@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.2 175/249] xsk: Properly terminate assignment in xskq_produce_flush_desc
Date:   Mon, 15 Jul 2019 09:45:40 -0400
Message-Id: <20190715134655.4076-175-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit f7019b7b0ad14bde732b8953161994edfc384953 ]

Clang warns:

In file included from net/xdp/xsk_queue.c:10:
net/xdp/xsk_queue.h:292:2: warning: expression result unused
[-Wunused-value]
        WRITE_ONCE(q->ring->producer, q->prod_tail);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/compiler.h:284:6: note: expanded from macro 'WRITE_ONCE'
        __u.__val;                                      \
        ~~~ ^~~~~
1 warning generated.

The q->prod_tail assignment has a comma at the end, not a semi-colon.
Fix that so clang no longer warns and everything works as expected.

Fixes: c497176cb2e4 ("xsk: add Rx receive functions and poll support")
Link: https://github.com/ClangBuiltLinux/linux/issues/544
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
Acked-by: Björn Töpel <bjorn.topel@intel.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk_queue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 88b9ae24658d..cba4a640d5e8 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -288,7 +288,7 @@ static inline void xskq_produce_flush_desc(struct xsk_queue *q)
 	/* Order producer and data */
 	smp_wmb(); /* B, matches C */
 
-	q->prod_tail = q->prod_head,
+	q->prod_tail = q->prod_head;
 	WRITE_ONCE(q->ring->producer, q->prod_tail);
 }
 
-- 
2.20.1

