Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FB347D2AC
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 14:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245259AbhLVNKj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 08:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240747AbhLVNKj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Dec 2021 08:10:39 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090FFC061574
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 05:10:38 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640178636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9wggsQ+/g3Cpp7vBrIbfDsRyczwlBopQjgkuWcfZ/6c=;
        b=VuoWit134t3gkyCcuNlYIn/w6v6QHyC+FEFXUd8JvpMvIeEYCOW1p9PENXudiQfPEGfbs0
        mIalG13S+oGqPZ9k0RV1+eL3H83bS0hsxBGwMQOYJP/qJae+PK0ggV4metk04CmmXcjlTk
        Np1rUtUBYGVH2j9sxc9s1UA1YlYC7eU=
From:   Jackie Liu <liu.yun@linux.dev>
To:     daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, ast@kernel.org, liu.yun@linux.dev
Subject: [PATCH] bpf: clean up unnecessary conditional judgments
Date:   Wed, 22 Dec 2021 21:10:05 +0800
Message-Id: <20211222131005.1380289-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

s32 is always true regardless of the values of its operands. let's
cleanup.

Fixes: e572ff80f05c ("bpf: Make 32->64 bounds propagation slightly more	robust")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 kernel/bpf/verifier.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b532f1058d35..43812ee58304 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1366,11 +1366,6 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
 	reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
 }
 
-static bool __reg32_bound_s64(s32 a)
-{
-	return a >= 0 && a <= S32_MAX;
-}
-
 static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
 {
 	reg->umin_value = reg->u32_min_value;
@@ -1380,8 +1375,7 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
 	 * be positive otherwise set to worse case bounds and refine later
 	 * from tnum.
 	 */
-	if (__reg32_bound_s64(reg->s32_min_value) &&
-	    __reg32_bound_s64(reg->s32_max_value)) {
+	if (reg->s32_min_value >= 0 && reg->s32_max_value >= 0) {
 		reg->smin_value = reg->s32_min_value;
 		reg->smax_value = reg->s32_max_value;
 	} else {
-- 
2.25.1

