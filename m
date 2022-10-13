Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB24E5FD4AE
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJMGXd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJMGXc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:23:32 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B7912503D
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r18so747899pgr.12
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjLN2kDGdA40dyK6BR52sj7ZXQDEMFC74JFEol51cBQ=;
        b=lmWoFf+UGHR6/lr86fG+rrsvCozqBt+9gWnNgKA/JnJnnPiiWModlZK9HGNSZs3Gc7
         S5Kq6yKHcUhBXdikMq9ajJsHE/7s99mygnVy8bX2iBEvzwF/hSmKc9ZhcNxn9l7e/ThE
         xMI4USnhyefgRy8HgnP+IxQo+KqPf/S/Vfg3ColDDdhyBCL0SLE+DO7mSJ7iq7zNBznP
         DmNE024B7Vl50o3X33O6l5Ppe6OMJRvwOzoht7UFVjhvFXb41cFaL6SqobEqp/VU6HNN
         A4LLPIYvk9PSVes6dN+I2+rzZp86TEyJAT5PkIoTy2Dw1MYVAIctXFP+7gqYkfnXy2vz
         avGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjLN2kDGdA40dyK6BR52sj7ZXQDEMFC74JFEol51cBQ=;
        b=tS/BLGAAt9yhv7n2UT4dpkSGMQm6sr9QH3csf3Xd3sY0f4dRF6DUZo0zNPfyhvhZv6
         BdkKJEPgNDBQ8k88hpI9jrhptSjKlMC0M/d3XsLaf4Q6mpH4775YGDHXAxj8kY5geuzv
         7IzLgem29SfqVc5aMbbVcZ0Of32NYIHkXJBrtJFVdD3wBv52E/1vYXVxkuZjYfBy3wxd
         XCeHWT8+pF7/L9d+211FJoSDKIy9Tvi+rbFZWe8+fuCEa/5juAkotG6PTSMIvFMhfg2/
         7MixzQQIDnnh/T7Duonu9OG0iejmd8aQZoemRWS9h7L5aiZDQ2UcK06M76g2p52kLyWy
         cuQA==
X-Gm-Message-State: ACrzQf1wA/YMzObW92/QqEGmDi/RSF4M67P8+Pe50AK3w9gJmr1YUHC7
        OR6tmWdkqAggMHQqCkTjE0bTQWd+/aY=
X-Google-Smtp-Source: AMsMyM5rlJO0l9KXwgvLobJdeph05KNhSN559ksIaW1+7O19gG8NM9Gb/0QKnbn6eIVzl+0sDhFzLA==
X-Received: by 2002:a63:24d:0:b0:452:87c1:9781 with SMTP id 74-20020a63024d000000b0045287c19781mr29010218pgc.512.1665642209398;
        Wed, 12 Oct 2022 23:23:29 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d88d00b00176be23bbb3sm11683083plz.172.2022.10.12.23.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:23:29 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 04/25] bpf: Fix slot type check in check_stack_write_var_off
Date:   Thu, 13 Oct 2022 11:52:42 +0530
Message-Id: <20221013062303.896469-5-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916; i=memxor@gmail.com; h=from:subject; bh=eWks3c9McomnxfDdciNRbp+AwAMOJYjXQKnJedCaFRA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67Dd2Scp5qtmQj4wCGAK164sZwNyMgwXrFI4cTP MLO2oUaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euwwAKCRBM4MiGSL8RyhlLD/ sEvvcZJHBKfAfQ6P1/T9LAO8iTVadDJVs9iVdGQ5krE1d5QA5zSzu+mYrD57txwDlhdygDd0/RrdFt 3ANMAI5zoFRD+U1ZjHZ0NHsGd4PFQOzBg2QDx/8uK/lSk+M54Bup7X7Lj9qdupFG+MmQu8Lj9sQmGr 7rHlDW0ZQyu1KMG3lNaY40RXgKA2RTcdlovVqXooqzpbV5OrTadBW1wTNhnwozqhmCT02AH3S4mDz3 VlvDyI2R5yqbaUhTfcug0owYk+Rq53lYCOso4FtTq+FtZJsWAAG15JUtQ5poQElfcZdtZQaOZeU/3s ly8Rq9SlO5QU3qPCof83t4fNbRx3CTNpRbrr61IbvL6y2J7e57JJ1UXZJrHJOZsQWmywsCIK3BnBzn cydm7CY2/T480UknBM5vrHS9MU2N1NhrbiTeL/VKpOdK0kN4GV5PMo5XFWwfwBzwa4wvKgWonxr7F3 ckiB2RnTWKuK2vhXK9aMNzxtEmBBcvjIx+0Ggo+97iwj6jWEnq7umD7HFtOlnWOCYiiJVMfj599hIL sUwSmnMy5uT6fIXDXw09WmDwjCgenShxs+WNsless8jYtUWvIuJ1zSutVy0x2aB4InKhtKB0I9FfSS THvqyHCOtpL/KmCIEJmlBniZ+iObyjSiDD4czsmQ91C8XRMdfhsV2HIkjjHA==
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

For the case where allow_ptr_leaks is false, code is checking whether
slot type is STACK_INVALID and STACK_SPILL and rejecting other cases.
This is a consequence of incorrectly checking for register type instead
of the slot type (NOT_INIT and SCALAR_VALUE respectively). Fix the
check.

Fixes: 01f810ace9ed ("bpf: Allow variable-offset stack access")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 48a10d79f1bf..bbbd44b0fd6f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3181,14 +3181,17 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		mark_stack_slot_scratched(env, spi);
 
-		if (!env->allow_ptr_leaks
-				&& *stype != NOT_INIT
-				&& *stype != SCALAR_VALUE) {
-			/* Reject the write if there's are spilled pointers in
-			 * range. If we didn't reject here, the ptr status
-			 * would be erased below (even though not all slots are
-			 * actually overwritten), possibly opening the door to
-			 * leaks.
+		if (!env->allow_ptr_leaks && *stype != STACK_MISC && *stype != STACK_ZERO) {
+			/* Reject the write if range we may write to has not
+			 * been initialized beforehand. If we didn't reject
+			 * here, the ptr status would be erased below (even
+			 * though not all slots are actually overwritten),
+			 * possibly opening the door to leaks.
+			 *
+			 * We do however catch STACK_INVALID case below, and
+			 * only allow reading possibly uninitialized memory
+			 * later for CAP_PERFMON, as the write may not happen to
+			 * that slot.
 			 */
 			verbose(env, "spilled ptr in range of var-offset stack write; insn %d, ptr off: %d",
 				insn_idx, i);
-- 
2.38.0

