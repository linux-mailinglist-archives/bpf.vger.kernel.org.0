Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B470A618845
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiKCTK7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKCTKu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:10:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550221DA46
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:10:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b29so2483979pfp.13
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWNWU+rpm/znUboQ79cVvJ3dKaQne7Zb81TBz9MAS/c=;
        b=ZV/slZxAG3UlrWX7j6I7QLthC5jbfL/bFq3K3/WBPXkIXNHrLjTHvB135jaC+Isn2k
         sl5G48CmCGBpWwH7IzvTSVHrMTgg12gnZsgmZeJOCNVshPAbgI465NNbC6wPQbVyl227
         s8af4Xh4jOJTuS5EPwIS29OI8G9gSE6X43Iv3b8bK4QAYyTaLTlL10GvIfySLarrhdIR
         /S/V78XVtqq4ZTVsSiQwOzKdiX2sgfaQxoQy4H2EG19teUiE08D5AC4C1+B7hmEptMMp
         +dgoOUiTcG9XLSEH85rEbFNlWpjJYAncM6b5DDo6CGQtM5KE5T1pO7gphfeQGqqgwmFJ
         gg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWNWU+rpm/znUboQ79cVvJ3dKaQne7Zb81TBz9MAS/c=;
        b=q8hXnHIHyKpCUqG389SbgnO3/4eOC5oS46U/0cm6Y1JM/IYNQmu9K2CTgqJI4MzE8k
         LRIg6SGrp6RvmM+HfBO/CUxgiEXeN/uWEcLS6v9GJUZT0/RPBcSHbdhAk5VFVMFwCS9I
         gJIrFOad0weq729CxBVBzEHzuq2mwTC7/32Qq2HCOUsQmPBmk/q9xRRBHtgYofAFUSrA
         4mEAOGc3iEkG9wHgtnJDpRxhjhl0M1wv79i/LH0Ngdb+j7DAWIUjUyoO0YAbXyGy6a4l
         IxMq1b+WLLG3DNQJz00338Hofue4I8pLScEL2A6WxwPlGvNdYjDO0lHLFzMM4A6Z09Ma
         sOCA==
X-Gm-Message-State: ACrzQf2F7SAjuupshth4nUE5fSQTG06m+uKlKC3dTMyPqYKCH32WHCG2
        PxCzOIFT2dZ9Erv1g+LXnj/KQzLv+kTiEQ==
X-Google-Smtp-Source: AMsMyM6JinA8Lo9JD7+VSRgRChFlZo3K3VC0PG+H3el77ws3fCvMsqWm+h7AyvMR0ribiLgwH8itvg==
X-Received: by 2002:a62:174a:0:b0:56b:9fc2:4ebd with SMTP id 71-20020a62174a000000b0056b9fc24ebdmr15192558pfx.21.1667502649648;
        Thu, 03 Nov 2022 12:10:49 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090a024c00b00216df8f03fdsm181661pje.50.2022.11.03.12.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:10:49 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 05/24] bpf: Drop reg_type_may_be_refcounted_or_null
Date:   Fri,  4 Nov 2022 00:39:54 +0530
Message-Id: <20221103191013.1236066-6-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=memxor@gmail.com; h=from:subject; bh=OdEU+XhKjjL3g72X1QeGogc2ys6Rld1HoFOogFMSOK8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIAdDRsbgpAMYnESbhZrG1sgpvd6j6fnEp0Jj7k chQc65uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAAAKCRBM4MiGSL8RyujeD/ 4z7qS2axoDelEwvV5Za1Pdf+9rz0FYJtcdLYfO6EqAcuurNOS/+WvYn7dbWd1O4Uew4xEnvm/DsqoL OBvLHm2fWD3vf85+beXlcoPxu4PVooHxX22Si+Rd/i7TK6/QSIeNV5RqocwSKOS0w+5C75Mc/CuxRk oAuvbDNLTcxBJ0AHc3xJAJKwYWr5eP1rcdtfJiWv9MO4xvRW/8laxEmm8hj4vuH1rDHbyubOSsoCuL YXiVQVPP7x8WKXFK5v7hhuO0o6Hmmi6mCmfQdmBI6KwsAKRZGixdvVsi0t/bxpXt501/ka2wnUa58o fP+zXOSQVgHuu2NoIvekivxiNY75wcPrxl4q84VXAkSB15PpK7lFeqKiSbHkda7ACXqJKnzzs2bkOE ltf/DCfh57KL9rySmbz52CsKu0VOMd4EZ9jtQYx+cIjkKsHqlrnJjuWmkbVp+JRB4cGZ4LDh1Jl/EJ R5FxgEJAkjtSSC5sT1a9dfSJzGPKbCl2OH9Q/7FuglNmN3KGlpZRfzS0YPIJRM16DvEZuXAXlnftp6 PRW0M0b6pMYwV+0FCrKI90ksWn2c8xClNGVpQy5+tSgkHT97FEkjzgTri1Rq4Ybh6D/UhYJsL3WJ++ lr5B8iIkUgmjJ+ovcpnQ/UshqzElbHnzSWEE0uZfjaFsiOF+99IRgCXbsTow==
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
index eb111a8034e7..14d350a25d5d 100644
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

