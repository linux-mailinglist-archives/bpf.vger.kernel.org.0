Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94996616EA8
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiKBU1o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKBU1d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:27:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB9B624D
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:27:24 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y4so17694949plb.2
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkwkXpLm06UTSWgohjmuBvCQtXQ3S0L1pA6Xys1yG3o=;
        b=cFNbWtNMh3sijlOXWBTve7BNnwsxHOwZVN/zRI1gczht7zNznhaLx+ubaVhRWwv14u
         jaiitNADBqaF+4uAY/SjD2I1f6paY+9Ljam2GKlY+/Z04lISGwYB1IqFeGYgJs9oJHuK
         RqIK6tvWYSYhoYwtgJaK3yJjVen9AkDJzuP9gdTG01oRa0wBQAvN3PYwmnbOZgYSrZpm
         KWDlSCh9IAHGL3cs0hdS2N+/oAJKNsmj6BRPhSBhbP7R7iolK2zcOTInUQEuzUXCmbSg
         aATm7ZS1//N+QlarbBMU8fr5Jcy2lzsWukNJpDnmhBgehWz23GywCeDsRXKyRRvKkjVo
         q/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkwkXpLm06UTSWgohjmuBvCQtXQ3S0L1pA6Xys1yG3o=;
        b=iboXyjKIxIluKdmffJUbOR2sp4TnkuwtVF8dXfWDOxhvgL3ZvtNb2MBw1r6UiR+5kL
         UZ63sKfLun1YpesX7LhRhLGy8wf0duvuj+FGfQWp3EIMHUszquzrMES5cePEvcqMutKT
         mOkB0FjdyEuPSRXKGLUS7ZRGNpn5x0L09YCPjHHH2zFPJn8F1Mo4J9DeIG8Y30u4K1G1
         IaFDexD1Bs/4Qmb+tu8/nMkQ1Tq7w/rlUQTkAKIpEFCvdbwG8zi2vSXEm+DfWtmCIQ8U
         RP0/GAa/abBkRt1dV9QRHoVSCqeC+sxtO+AFRVshmPDr5AIZoCUDflm/hGsROCSnGt1o
         DrjQ==
X-Gm-Message-State: ACrzQf2bxuhdw0G692w95P70K51oRUKXP3mLswtG/MI9zWv2pcYriwed
        DlOPLzfaCmAGhfo/0QSKeRtMP8huNdS3vA==
X-Google-Smtp-Source: AMsMyM5suiXns+xz7PcBgzCB6QBxQommvnx8UG7QsLw6/8+dcv/YMjspVQk4AndrQ0ZwtzrcXOq7BQ==
X-Received: by 2002:a17:90b:48c3:b0:213:b5ad:742d with SMTP id li3-20020a17090b48c300b00213b5ad742dmr24105991pjb.172.1667420843688;
        Wed, 02 Nov 2022 13:27:23 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b00185402cfedesm8778119plh.246.2022.11.02.13.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:27:23 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 05/24] bpf: Drop reg_type_may_be_refcounted_or_null
Date:   Thu,  3 Nov 2022 01:56:39 +0530
Message-Id: <20221102202658.963008-6-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=memxor@gmail.com; h=from:subject; bh=IcoWnbM99hDAGzygGEbxloa2s0dtYPWA1lIzTj8kCfQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtICv2Nd48I6aOJnSC+F0zXvFTrcLSTfc8EJIOn+ RMNoTXKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSAgAKCRBM4MiGSL8RyuJMD/ 40jU4uqwZRDYmQ5bJTMngNBCnQhfqI+S94cVmB4ES2z9lelhr6DI4wA2k+kJvfhEspYHBclXpRIO0/ Ycn3rRC4T98iZROjehCUnoL24rFsI/nRgPLD0588PwU1f4WOdMwZuoEAjYtZMxuMFKgFY3uJgATNDp 9Fl8VmBMQctCHIMCUnevYf8GkWX1+y4YxlYv9nNasHx3Srd3BFCZbLe4/NYkshalQNQDDxMOLU0DPM N3aBrLJLmLgeNjPOyPHKzmf7WofctFPZm6pZSu4ZlvBeiWMBJRYculmAaFz+qTkeGp3n4V3bBZe2g/ E+a59HJppRDs+Z1nWgvV2L5Ld1TojLbAXaDEBiDk992bls9+NoIgDXQB/2nCZKzEg/6hQZlp2NiT8a 2Bfp4T5DDeaeo8LaAczDLRjxRd/E5aBVxg4XKstb5LZFaAjfEcg8e5G3QJx87evuzr+xFyUmOo6ezN xGUUXvjwH1KS7ZjGNcXDMlT23SH8rQz8dVWvCRwGMfncko6zeHnHHjy6353Iz2Ua6zxBza3UqNs4h5 YZAo/gQfpflmpomS+viQZDOecxClbZK5nKcehUJdGN5VT7atA56vrZiFkkOMJs+3dpJGl5x/7geu8S 4rBdla/nmNZ/UeT1010ER5V5dYFpSXQ34wVx+GmSUkD73amgz3uNuJ8dBDlw==
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

It is not scalable to maintain a list of types that can have non-zero
ref_obj_id. It is never set for scalars anyway, so just remove the
conditional on register types and print it whenever it is non-zero.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index abdd293e4358..bbe2c17bf05f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -457,13 +457,6 @@ static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 		map_value_has_spin_lock(reg->map_ptr);
 }
 
-static bool reg_type_may_be_refcounted_or_null(enum bpf_reg_type type)
-{
-	type = base_type(type);
-	return type == PTR_TO_SOCKET || type == PTR_TO_TCP_SOCK ||
-		type == PTR_TO_MEM || type == PTR_TO_BTF_ID;
-}
-
 static bool type_is_rdonly_mem(u32 type)
 {
 	return type & MEM_RDONLY;
@@ -875,7 +868,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 
 			if (reg->id)
 				verbose_a("id=%d", reg->id);
-			if (reg_type_may_be_refcounted_or_null(t) && reg->ref_obj_id)
+			if (reg->ref_obj_id)
 				verbose_a("ref_obj_id=%d", reg->ref_obj_id);
 			if (t != SCALAR_VALUE)
 				verbose_a("off=%d", reg->off);
-- 
2.38.1

