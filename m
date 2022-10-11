Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFDE5FA9F8
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJKBXy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiJKBXZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:23:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35A283F38
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:22:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id i3so2618866pfc.11
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcUcBBRKrnjKzadXKoBA33SiwgDlJ/ND5O+IVRvSvK0=;
        b=WN/MQuXy59H3GdRpGqPjMH4Oo4aNDNaVsxIP1PtfeYYn9+p81l4+gBxzh2O5Y5I8Fq
         LeoOHhToCohFUqQsaarwJvuMQ06NdiKKdiSbAztu1DLnLIGx2of8aoVGo42XL47SVyW/
         nMlaMMRH0ckzDNSaxaMKposiCMwNPPutUSUMk4og2cB+9YQq0Q5Laorgl4HEwhL3/04/
         /Jd7tESpActCrQ3FH6SD9aZ31M+zoqazcTaTBUGDDuElHFAKK1Khjr1RfgJrqaaYLx06
         sUvT9O8pMlW8jnJacp5xa05LS0MORzGI5WCZgYynMLbCYmc6Mnh0N6twxtnJtSvJu334
         FjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcUcBBRKrnjKzadXKoBA33SiwgDlJ/ND5O+IVRvSvK0=;
        b=w0x137NvQSt4082zJmGGT73X/LkniME/DDjtKmQgnErbLKJ3uh4YZ510LutJeck5uN
         MaUo2nFsIY7bUgMu6XDUVya+ojFxZtbdrc/MkP4LR//5yDB2Unirihu+lk5QupHK17HV
         ve5QYKPATbFbx0Bd95POYrKaFhQdBQBBGw9I1m2Sef7cesuhp4HZY8fxDcydUOJaZe+i
         0WKw4idQr40yXvlyzTigLXA4aNQ2flYBmvGIJAvJmyw6G37o1EgnpiQnn5rDRab6+Krz
         eEujFFhNM+cpm57WRMWekv502cIAuO+SSqsImcs5DGMO7wwI5hAFj0NSAPMC2DYERZQb
         Dhpw==
X-Gm-Message-State: ACrzQf30AHEYRJlCaEEGEUNzEdX+23SNsKsL6EihzyxOCJAllmdAbCnm
        yGKB6mJyFYQo0YAV08HYYG/+zrEmZDr86w==
X-Google-Smtp-Source: AMsMyM4NnBi65i8GWIKe5bSujlJQH9V2bep/JxT5pPFONfoZV/8WU56lOoJAYXnIRzz8gOFf4cJiyw==
X-Received: by 2002:a63:5d48:0:b0:43a:390b:2183 with SMTP id o8-20020a635d48000000b0043a390b2183mr19021748pgm.29.1665451378735;
        Mon, 10 Oct 2022 18:22:58 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id w66-20020a623045000000b0053dea60f3c8sm2617775pfw.87.2022.10.10.18.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:22:58 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 05/25] bpf: Drop reg_type_may_be_refcounted_or_null
Date:   Tue, 11 Oct 2022 06:52:20 +0530
Message-Id: <20221011012240.3149-6-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=memxor@gmail.com; h=from:subject; bh=dNkuFSgpPVNWQ/WXcU0CDhUXCDIDiyJQ1wNIKtKoEU8=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUaRNJcDcxMPDNRnG2GT4Ao4oTYxKIgYpEDeSJS oedjqoiJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGgAKCRBM4MiGSL8RyqnQD/ 9P8pEBNRrOvqCXdfw+V7Mr+eygTylQFkOAc5dRfKRPSJjRIc0D4BUJkXT1Fr6JuTGlOZ18TY17Fy+5 vhpfT6U7/mY1R5f76XtGd+f/qVqZYzziL2418VNhJRjV5tZGL0hrpMs7A3A6NLR7FDO4/LHh9ogpRj 9KEuxE+PAejSf+wwVsctujHvhsXoXMXgXJOhMHgnwSBVrDf8YER+OL/TrIn6CoGB5TVdZx1x9f28ew C+N5HLH/dLowwjDCUcvhkQFE1uHm3Qw82+ZoHo19AhVk5VqVvG37vo/Ox7ldMr+wNLMVuUxJxuGkAF tX3jKsmDVnBuh29vtiEudb4RygHei+69q5DGeWySK8lUMbi+pzjTwU++fIBhbo1wIWpuv9x3+yy+UM j6oMHOM8RI2Fd4yMDwQwQpeZEjcSoiamZtUg7xIRkpQSa8dFsRbAMyPMwygBrcRGGiyAX0a61BQZal WizXDGDjbOMv4Gb5TvOlF5E69IBkRMdovWpaShuMarpVJ+hYDKlP2JdU+uNndVZFuNwNPsMkPLQH9q a0nqAztWPSMbGhNrFDpqYUk497xk3w7hWwxLjNqVeeYYxY432GxrYiHIN0vogz/M7Ntjj5RWgLKsxm 68mD9OuHIK+UJtCYdaPnMX4XqU/onyGb94ZZl944ZbvWI1QUM/Vvi8UX2D3Q==
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

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bbbd44b0fd6f..c96419cf7033 100644
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
2.34.1

