Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B7616EB8
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiKBU2S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiKBU2Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:28:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64A31017
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:28:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so2948995pjk.1
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2j/18MfBiHKOhLAwkRnmyxGjPVRlY4jaVV2Gj76wQU=;
        b=L71Vnd2wXqLOuHIt9W3HKbsK+1bCQdv2V422yrgcZyiXrWYeLX2IeGQjXcQEMMekKq
         NbSpPIC+GWxzOmLLtWqCjusx9Dku/n1n3IZJlRz2VjIZuXC/idB9otsrthgoYw4dnlm8
         dX5zj8MFCXm4SGQ3jE/TD0rqHv6OWItcufI+YWrO5dlIqNCql0rqWuwO2lnKXnkHNr9a
         u+0AudJJiy+OEb9gecm1c11HJ8TcqmPTY/haQHEreEVxrVHEFFc+jEoD5HTMTCeZyZRR
         ySMH5+OY9w1Ek5JDMVEX0WYuLihdGxicER66uqtX01ADlZOiyxIeZpsWLNqozA3XNLJj
         HlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2j/18MfBiHKOhLAwkRnmyxGjPVRlY4jaVV2Gj76wQU=;
        b=Q1PDRz0Ci2HLUaG7mbjAaUf7/5xDU9VkNm/5D0Z5CsYAXncRQfIQUzKAIfqozBYZhL
         Pbn5RHPLty5XPkqk+IEg9qQ2bTJfwZFKLl3NMibETY+JqJcNd6tck3v4eKF80TyV7e82
         oF02ZQ/0/OhcaI1uqOcjL6VQwdv4So7YZtAnr2aYoMRr79WkQGiFHONWkvH6bUIMax60
         yiYmoPyDLH2HBEYEZL8Kpf/T2t1c9pRXuxNdVtLsXkTYn8TQfbSLwCYHOUEM4V6tYY1t
         F04Zb/NnvyMuMhgEPcnNE5qRzYPEEoP2/lkDOFaB02Iv/3CyBeD4xlh9d3P077Qk8Yyp
         FAJg==
X-Gm-Message-State: ACrzQf1Av7rojjEwO4ba8gNTD40GFy3wT33zwMXopONua8iyGSUuCI4H
        dT6Sigi3ov+909zgdkXwBcWOjg6s+b/XBw==
X-Google-Smtp-Source: AMsMyM57SnQc/1lqbwor+RUqCOnF1yhuUyYOqOx2hp87Ae/DG1Uy7PxwX5/DOpVjCfL1kOJh8/RSgw==
X-Received: by 2002:a17:902:d48d:b0:186:cf83:4be3 with SMTP id c13-20020a170902d48d00b00186cf834be3mr26313388plg.22.1667420895206;
        Wed, 02 Nov 2022 13:28:15 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id k14-20020a170902ce0e00b00186b9196cbesm8787131plg.249.2022.11.02.13.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:28:14 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 21/24] bpf: Permit NULL checking pointer with non-zero fixed offset
Date:   Thu,  3 Nov 2022 01:56:55 +0530
Message-Id: <20221102202658.963008-22-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2157; i=memxor@gmail.com; h=from:subject; bh=/pAtpr+VyoBuzcpvdV4MOiUrTG7JUlchQRgdCaQ/hf8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtIEN51qoU0ubwBc8M3PT0s2S0977eJJb/zPUkN1 riUsQt2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSBAAKCRBM4MiGSL8RynXED/ 9/im20euwfO3AiCKmz0QNDlpxGr4wrAufM58sSlTMWakMvdLwapHFdjyfXQ28iW6zux5uPlYiygHkf +HMGAB0JJHUc8EVKxWc8uGGdVM40Bjg2KDDfslGRwboJxdzszgpz3t0UfhnNfDGhQ6LWHfW+gJYv27 36DvBwUU/6tG3I4EHRhLyuGPgczUk0JrXKW7xqJXwiJ6TVDx7bxyjNOO/WJaz99E4R/2l9eEz/kOzL dikSn80epHKm+sA3mJK4+WbDeBqJXwipL0k8MuntIAPGwUSJeL6wheH+oI04SbzmZdxXo9jwT7N6Wl 4fmYrSPvIOn3Yo4JEJHPQSXPSVTYxQIyyAwXf3drfzsheIkzcxo9Etd+0wPt9Ot2szLif+PsFlsLN1 4kZ2yV/HzFvymzqG+lQsL0kLCdg15HopGxjVE1eBxzDdqefnR+EFsCSSoo+9kazv+XzMW3xrP/26zw hW/5rPXHuqwmcvF0PV/lVlw2rAz//O7cozMUKmjRqbV3i2S2DJ3Xcal3ASWox0TVZ5SiurFbeTAgF7 QmG2v5WVj/mmMrka23jtpFxR4+YjphsTn5CdTwxQ4WvY18blFL93GV+6rOSr1QStHWGmY3Y0tnxgYD HafDSSgei1YYFNjHo2PLTiC9E7JGkwCwzxD98Ol/Qs+/knmfMorO01Iom33w==
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
hence make an exception for local kptrs while still keeping the warning
for other unintended cases that might creep in.

bpf_list_del{,tail} helpers return a local kptr with incremented offset
pointing to bpf_list_node field. The user is supposed to then obtain the
pointer to the entry using container_of after NULL checking it. The
current restrictions trigger a warning when doing the NULL checking.
Revisiting the reason, it is meant as an assertion which seems to
actually work and catch the bad case.

Hence, under no other circumstances can reg->off be non-zero for a
register that has the PTR_MAYBE_NULL type flag set.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb47eb8b0254..73bfbf3628b3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10621,15 +10621,20 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
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
+			if (WARN_ON_ONCE(reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL | PTR_MAYBE_NULL)))
+				return;
+			if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
+				return;
 		}
 		if (is_null) {
 			reg->type = SCALAR_VALUE;
-- 
2.38.1

