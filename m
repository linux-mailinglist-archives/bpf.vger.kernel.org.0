Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1885FD4AD
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiJMGXb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJMGXa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:23:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D15122BEA
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n18-20020a17090ade9200b0020b0012097cso5179287pjv.0
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jk6PAVGQztOJdQWmR6e9RUWoJmrg4EfJ6kafVLgDVaM=;
        b=XdZyda0L4kyqmj/EASDjpKsEDtWXAtW7CJZBiDqJbDeXYp8e8neOKtwlmSYzJosW/R
         QpUtbszLuNMBPyOEqqvOeakcbcNuJLxOLRcgCroFytdpQD6UGLmBISAx68BhuGuDoPPh
         tR6j2/JyzX78SG3KtExLfcXHHHhnNtoxWL2Eaf+8Br/VRuEvQ0MU1qbUoptk9oY/A7jO
         bbBQSBGpSdZ0pF+MnqX5uiRII3OeU+1J65dSh+DQou4lbnGjMnkXI2xJXbpsC70vNycq
         nYOqPhdz3UvSFOswhupYdqsSJ5HrYmlIs9X2NbSNclYF2pgCRxPN9mGJbkAA16lurSeG
         seyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jk6PAVGQztOJdQWmR6e9RUWoJmrg4EfJ6kafVLgDVaM=;
        b=LRrucOXhHsEkjnRAbF+Mjmnr+mAWQ/6WskagTibbo5PVC9WePRZv196UF5OxvEHDCw
         VaR6+LV1QzAf8x/qW4CHtqQA0bK93oLhzkWowQpHiAEMkWlfIWugVz+xRnJ2qit4KQos
         Y9uGeZwXkCESw3Ctsb8AOyIa+lzUIdclaHTb6SksjAisRycZf+6Q1dEO3/n71T8Npann
         VTll7ek311DbzZ9G7sA98VdJdqhQFfnrd745Pik9Mn8Bf8EszQ6ePR9aIuclv2WBRv5D
         gXbl4gTRmfZbR3ELUiIi5XSl3e9qBIFKGGSJeg1WHGBg20/x4hr/73Kp72gC7MBYKeYM
         4lkw==
X-Gm-Message-State: ACrzQf1Jz5AEHpXMAHkNNbXPjIjUdxAreBa/MvLgAXTe6yf+kBZ8Yzl7
        Kux66k6VR3IcrIlV9GFrTPu0SiC5eqM=
X-Google-Smtp-Source: AMsMyM6pbaPB4oa6xjWGGv+1X7FreOq00P8ybuEL8R30xHNXGj+Xz5KtMWKYSovW2P8dT6SGzuTz4A==
X-Received: by 2002:a17:902:e88b:b0:17f:93a4:e31b with SMTP id w11-20020a170902e88b00b0017f93a4e31bmr34633529plg.51.1665642205491;
        Wed, 12 Oct 2022 23:23:25 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id y193-20020a62ceca000000b005635477c42dsm964584pfg.133.2022.10.12.23.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:23:25 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@meta.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 03/25] bpf: Clobber stack slot when writing over spilled PTR_TO_BTF_ID
Date:   Thu, 13 Oct 2022 11:52:41 +0530
Message-Id: <20221013062303.896469-4-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2821; i=memxor@gmail.com; h=from:subject; bh=E0Su+oiTVXKacKk3/hOSywORjcOqC3sBT2haSDOJxhs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67CY4srnRgxZjq/wl6KGsW/5htYGg/L3fpgLqKH 5/HL9O6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euwgAKCRBM4MiGSL8RylPgD/ 9m7+xC1eZnHWzikdFhX5Bt/pGg10bIiZLA099TQC44f1fV7uSne7wHp7C7Azzdjy6HvcndXp4dli9r GMKH1SobkKhRAwZAkrXz4Ts64J3EiFU4Oy9ViolW6Ju63bUu+hN1SlBFvirqf2ezAAIYOcB8AUIilA juzmzX2gUSEszjz0yPbpIleqSCHGTzTfQFtGa0tCoI3ofbqfk223yqK+wFrzJCjflVjKFta+pcD3sH mvUHaUQ8Z2s5vodXfn3iYWP8UFm9y+AJ9uuCMGwuGquix97XB3UKjdsAyvuI1hwmh4K/Gbm5TKPl0P Hd3LFp8t9wJvAAkZP0x754b+WY/Egb6iWppVRCPTyCC5JG2pKsauA5REEpomRjyOKb+4hPMz4mpxDT o7w7XBVNrut4vkFzoeWJn0BoDRuw+VpfkxPSKF/rZTzJcgn6PaYUpGGiWWJRloFkuq3RFMal3bj/07 ZYB6W635AJcr6wCjONLATa8GIWoyG0fMPuM/zp+PPUHIWAMSRxocVLSSxh6/yRsotmXJDMAUZC031b mWMJG0kq3vKXuSbGSFnZVYq5+glIDtkdCZoOygqt0iMvKiUQUNEbV/AO5t3UyaZ8GPBPBz5d6xthJ+ kWxp2ON3cRQjKLGQTJct9IzkNbof507DDIhVp1fw2FMHHHMBnOpaqfVBoiQg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When support was added for spilled PTR_TO_BTF_ID to be accessed by
helper memory access, the stack slot was not overwritten to STACK_MISC
(and that too is only safe when env->allow_ptr_leaks is true).

This means that helpers who take ARG_PTR_TO_MEM and write to it may
essentially overwrite the value while the verifier continues to track
the slot for spilled register.

This can cause issues when PTR_TO_BTF_ID is spilled to stack, and then
overwritten by helper write access, which can then be passed to BPF
helpers or kfuncs.

Handle this by falling back to the case introduced in a later commit,
which will also handle PTR_TO_BTF_ID along with other pointer types,
i.e. cd17d38f8b28 ("bpf: Permits pointers on stack for helper calls").

Finally, include a comment on why REG_LIVE_WRITTEN is not being set when
clobber is set to true. In short, the reason is that while when clobber
is unset, we know that we won't be writing, when it is true, we *may*
write to any of the stack slots in that range. It may be a partial or
complete write, to just one or many stack slots.

We cannot be sure, hence to be conservative, we leave things as is and
never set REG_LIVE_WRITTEN for any stack slot. However, clobber still
needs to reset them to STACK_MISC assuming writes happened. However read
marks still need to be propagated upwards from liveness point of view,
as parent stack slot's contents may still continue to matter to child
states.

Cc: Yonghong Song <yhs@meta.com>
Fixes: 1d68f22b3d53 ("bpf: Handle spilled PTR_TO_BTF_ID properly when checking stack_boundary")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6f6d2d511c06..48a10d79f1bf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5154,10 +5154,6 @@ static int check_stack_range_initialized(
 			goto mark;
 		}
 
-		if (is_spilled_reg(&state->stack[spi]) &&
-		    base_type(state->stack[spi].spilled_ptr.type) == PTR_TO_BTF_ID)
-			goto mark;
-
 		if (is_spilled_reg(&state->stack[spi]) &&
 		    (state->stack[spi].spilled_ptr.type == SCALAR_VALUE ||
 		     env->allow_ptr_leaks)) {
@@ -5188,6 +5184,11 @@ static int check_stack_range_initialized(
 		mark_reg_read(env, &state->stack[spi].spilled_ptr,
 			      state->stack[spi].spilled_ptr.parent,
 			      REG_LIVE_READ64);
+		/* We do not set REG_LIVE_WRITTEN for stack slot, as we can not
+		 * be sure that whether stack slot is written to or not. Hence,
+		 * we must still conservatively propagate reads upwards even if
+		 * helper may write to the entire memory range.
+		 */
 	}
 	return update_stack_depth(env, state, min_off);
 }
-- 
2.38.0

