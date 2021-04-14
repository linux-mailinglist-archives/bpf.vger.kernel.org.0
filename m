Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957EA35EC4F
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 07:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245694AbhDNFpm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 01:45:42 -0400
Received: from mx313.baidu.com ([180.101.52.140]:59785 "EHLO
        njjs-sys-mailin06.njjs.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1345352AbhDNFpk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 14 Apr 2021 01:45:40 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Apr 2021 01:45:39 EDT
Received: from unknown.domain.tld (unknown [10.168.57.222])
        by njjs-sys-mailin06.njjs.baidu.com (Postfix) with ESMTP id D88E6185C0031;
        Wed, 14 Apr 2021 13:39:12 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     bpf@vger.kernel.org, magnus.karlsson@intel.com
Subject: [PATCH] xsk: align xdp socket batch size with dpdk
Date:   Wed, 14 Apr 2021 13:39:12 +0800
Message-Id: <1618378752-4191-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DPDK default burst size is 32, however, kernel xsk sendto
syscall can not handle all 32 at one time, and return with
error.

So make kernel xdp socket batch size larger to avoid
unnecessary syscall fail and context switch which will help
increase performance.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/xdp/xsk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index a71ed66..cd62d4b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -30,7 +30,7 @@
 #include "xdp_umem.h"
 #include "xsk.h"
 
-#define TX_BATCH_SIZE 16
+#define TX_BATCH_SIZE 32
 
 static DEFINE_PER_CPU(struct list_head, xskmap_flush_list);
 
-- 
1.7.1

