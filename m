Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4B834DDFC
	for <lists+bpf@lfdr.de>; Tue, 30 Mar 2021 04:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhC3CKX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Mar 2021 22:10:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15096 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhC3CKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Mar 2021 22:10:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8Xsk5lm1z17P9j;
        Tue, 30 Mar 2021 10:08:10 +0800 (CST)
Received: from k03.huawei.com (10.67.174.111) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 10:10:09 +0800
From:   He Fengqing <hefengqing@huawei.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <ongliubraving@fb.com>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>
Subject: [Patch bpf-next] net: filter: Remove unused bpf_load_pointer
Date:   Tue, 30 Mar 2021 02:48:43 +0000
Message-ID: <20210330024843.3479844-1-hefengqing@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.111]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove unused bpf_load_pointer function in filter.h

Signed-off-by: He Fengqing <hefengqing@huawei.com>
---
 include/linux/filter.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index eecfd82db648..9a09547bc7ba 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1246,15 +1246,6 @@ static inline u16 bpf_anc_helper(const struct sock_filter *ftest)
 void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb,
 					   int k, unsigned int size);
 
-static inline void *bpf_load_pointer(const struct sk_buff *skb, int k,
-				     unsigned int size, void *buffer)
-{
-	if (k >= 0)
-		return skb_header_pointer(skb, k, size, buffer);
-
-	return bpf_internal_load_pointer_neg_helper(skb, k, size);
-}
-
 static inline int bpf_tell_extensions(void)
 {
 	return SKF_AD_MAX;
-- 
2.25.1

