Return-Path: <bpf+bounces-17474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5469F80E088
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 01:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100EA282689
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 00:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDAA64F;
	Tue, 12 Dec 2023 00:54:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871ED99;
	Mon, 11 Dec 2023 16:54:41 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VyKKfOP_1702342477;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VyKKfOP_1702342477)
          by smtp.aliyun-inc.com;
          Tue, 12 Dec 2023 08:54:38 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev
Cc: kpsingh@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] bpf: remove unused function
Date: Tue, 12 Dec 2023 08:54:36 +0800
Message-Id: <20231212005436.103829-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function are defined in the verifier.c file, but not called
elsewhere, so delete the unused function.

kernel/bpf/verifier.c:3448:20: warning: unused function 'bt_set_slot'
kernel/bpf/verifier.c:3453:20: warning: unused function 'bt_clear_slot'
kernel/bpf/verifier.c:3488:20: warning: unused function 'bt_is_slot_set'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7714
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/bpf/verifier.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 727a59e4a647..49292f37c0de 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3445,16 +3445,6 @@ static inline void bt_clear_frame_slot(struct backtrack_state *bt, u32 frame, u3
 	bt->stack_masks[frame] &= ~(1ull << slot);
 }
 
-static inline void bt_set_slot(struct backtrack_state *bt, u32 slot)
-{
-	bt_set_frame_slot(bt, bt->frame, slot);
-}
-
-static inline void bt_clear_slot(struct backtrack_state *bt, u32 slot)
-{
-	bt_clear_frame_slot(bt, bt->frame, slot);
-}
-
 static inline u32 bt_frame_reg_mask(struct backtrack_state *bt, u32 frame)
 {
 	return bt->reg_masks[frame];
@@ -3485,11 +3475,6 @@ static inline bool bt_is_frame_slot_set(struct backtrack_state *bt, u32 frame, u
 	return bt->stack_masks[frame] & (1ull << slot);
 }
 
-static inline bool bt_is_slot_set(struct backtrack_state *bt, u32 slot)
-{
-	return bt_is_frame_slot_set(bt, bt->frame, slot);
-}
-
 /* format registers bitmask, e.g., "r0,r2,r4" for 0x15 mask */
 static void fmt_reg_mask(char *buf, ssize_t buf_sz, u32 reg_mask)
 {
-- 
2.20.1.7.g153144c


