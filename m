Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272E062891D
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbiKNTRI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbiKNTQx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:16:53 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC1B29361
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:49 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 140so10474749pfz.6
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWiYAsRgE6BX8qJ0Iu8jZXDm2tAGkdrg9ETQquXoTlI=;
        b=QRVu4fG/sV68FEzalpq4wde8k2XK2PKZnTvpnREks7okA046FlAJvDFjyT5e4rpY2r
         0sXeuF1vBubW0/lqHXUbOTZrXXSdvB1Iuq0JpQw3ubinAnOwY4V1ghH24VmO2H3kPLRG
         kk3uD2QFptyJc5vDUqs9CJ3CdyLpS4rsD+C5CqNwuPsNI6OS9uHaraJRDvhx7z/h2PVs
         vDn/fX9vZTjB8EaNCnZqgsLOi3SS9vKAtN2enZenJhiwdXbDR5bvNPh4UNBDoJnEDpEc
         SXWj6oPYnkpBtYGmOx5/IajhyrZKCjjzS0sLZzNeQkOT0NUom0e8zkofiBLrS8vTx24r
         9npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWiYAsRgE6BX8qJ0Iu8jZXDm2tAGkdrg9ETQquXoTlI=;
        b=xATtYLGVGzH9+KwwWLhDH+j/JezMl3eChQyimIq7fLIsEMc/2uxd+sOAgkSZpB5rP6
         7VhEJ7jYgkfTscvAmy1ili1VtTk8Sy/Mxs/E1gezU2OwAXE7P7XvfvNBXvt/6ybHdh1d
         0j8JOIH4+Ynmk1kRsRUe4O9LrxkJUNMT+pEHc0ROcg1TXvOx5xitPN+nCWw+yYtHs0GN
         Hl0YYJsCJmc7O1g4+9Rx4Q9cDvfvlANZ7qn7ai703KeXHczKzrN42mS/UVa0NQUNxDW4
         LmH6xB9x1l5ACZCc8xYF6G/fj29AuiivwfRcniWeX37aOSVDMDPbQE5+T3Zic3EL9LA1
         yUSw==
X-Gm-Message-State: ANoB5pks56WjyN0/+NdYmcWZ+5XOxK7FfDiQs0jR2DLqAdrvk7IVFX5Z
        zOURfY91gJl3/waWk1BlKvX/AraQQVCylw==
X-Google-Smtp-Source: AA0mqf4P0INbQDx/ifVJwKXR1ahUnXCKfXUk44hJU4eRWwySdXay/iGhGY/PCXkVw6GPUfk4mUBd1Q==
X-Received: by 2002:a63:1949:0:b0:46f:38ad:de99 with SMTP id 9-20020a631949000000b0046f38adde99mr13050820pgz.218.1668453409427;
        Mon, 14 Nov 2022 11:16:49 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id v64-20020a626143000000b0056bcd7e1e04sm7081365pfb.124.2022.11.14.11.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:16:49 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 19/26] bpf: Permit NULL checking pointer with non-zero fixed offset
Date:   Tue, 15 Nov 2022 00:45:40 +0530
Message-Id: <20221114191547.1694267-20-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2227; i=memxor@gmail.com; h=from:subject; bh=6Xyei5T2AP1FaAFXmRhfrqj1zOfW3ny611AeNkXJLek=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPJKfgXhqUoqyJsCCsCEvXFyun4/h/CISksRirh Gy+8s76JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyQAKCRBM4MiGSL8Ryqi8EA C9lxKSSHIs/86mXCDuRVZ0SAQMM1+i3eRUC0/NkGWPl94SGQ5d0DW93J6JkGHJdQOl9xAmJJLowVoX XUBytFukbja1u91DDX7tNEQn4VDMvErnIrRu46HXIUktXBu7hjSTSAkkXQA0pDEYuQ6yeteax/hTt1 RiLeowgw+LFoF48NFiti+2lzuKxcfbgSsNfp4rmteWkklvd/3PfX1ocWxAIEGPSCs6J5n0uanvUp+d Gl8DsY8cE4iMS8f7DSFSjonEo7Uxfhq5WzF4IU57RbC99QhtbwMFCvBPWmIN2YxOU5dTLrNPDxXP2X TvKzpXoLhLkfjhKq9096knbmSPzjKxqFmBKeWL28JfNS2FiAD8ixI2cFci05zWKIeKXJc46iUZ0zMa cyHLyU5tpt6Cz9QuQZjXQOCbdwOh2N94d59643/0TLAT5kDtuvesIjVNz33v0EbefkP4qE/VnjZJ4J jow9WRCzKKNv8xrVrey4yPWO5SVTEnmoYkODoRRzv8BxOrLVH0mqEhTTwjx8ruK49vZAbYK32sY8Tu G9AO7wg1J8GG1/jZ6EmOvdUtuc5Wj1F+ZZFMY33f0mKm7EAj9eheawqNlDoav6Elfu67Nv0rZ2Vcap wuW1aHPkiilDb9UXuZ0kc0W+GAJ0YBe3FCnarikJtbXQkds0LebZZIX7WtSg==
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

Pointer increment on seeing PTR_MAYBE_NULL is already protected against,
hence make an exception for PTR_TO_BTF_ID | MEM_ALLOC while still
keeping the warning for other unintended cases that might creep in.

bpf_list_pop_{front,_back} helpers planned to be introduced in next
commit will return a MEM_ALLOC register with incremented offset pointing
to bpf_list_node field. The user is supposed to then obtain the pointer
to the entry using container_of after NULL checking it. The current
restrictions trigger a warning when doing the NULL checking. Revisiting
the reason, it is meant as an assertion which seems to actually work and
catch the bad case.

Hence, under no other circumstances can reg->off be non-zero for a
register that has the PTR_MAYBE_NULL type flag set.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7372737cbde9..e194c3feb01f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10800,15 +10800,20 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 {
 	if (type_may_be_null(reg->type) && reg->id == id &&
 	    !WARN_ON_ONCE(!reg->id)) {
-		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value ||
-				 !tnum_equals_const(reg->var_off, 0) ||
-				 reg->off)) {
+		if (reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0) || reg->off) {
 			/* Old offset (both fixed and variable parts) should
 			 * have been known-zero, because we don't allow pointer
 			 * arithmetic on pointers that might be NULL. If we
 			 * see this happening, don't convert the register.
+			 *
+			 * But in some cases, some helpers that return local
+			 * kptrs advance offset for the returned pointer.
+			 * In those cases, it is fine to expect to see reg->off.
 			 */
-			return;
+			if (WARN_ON_ONCE(reg->type != (PTR_TO_BTF_ID | MEM_ALLOC | PTR_MAYBE_NULL)))
+				return;
+			if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
+				return;
 		}
 		if (is_null) {
 			reg->type = SCALAR_VALUE;
-- 
2.38.1

