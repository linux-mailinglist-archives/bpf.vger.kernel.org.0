Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145B6676257
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 01:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjAUAZW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 19:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjAUAY6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 19:24:58 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CC0BC77D
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:21 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id 5so1409721plo.3
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tmo0le0cUJOBzWSdrlYEJJL3gLctaWM5TmJR0sXVqHw=;
        b=BrF7Cz1NYMkWC33zj7SG7Hl6MRL96n9ijAW2w0pH85p1aXh0ObQoAg64nzORaHI4Pg
         toyFQPXRScj1GLglHxDbQDrtcAy+Gq7CWXNllBqdZuVbaQLuju/9uHygeepYve95s8qq
         IDCC++jdAmfkTaJ/U3ejAc5PCNu5DLXR02Lb28fHlMK2FJHa2HdoFLDkNNGmIF2WIXQR
         Q8hv4Rv8WR/7HYEOA1uelvLeEWbM9mwSbOTF5qk42RK4bMihirLUqo2iKyUlzQabFsot
         w980YBfdZbdlo9Ph90gSnWr1xDU8qA3BpLDDibmCySoJKsdG5GTzX2NcgHa+CftecW/s
         +CFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tmo0le0cUJOBzWSdrlYEJJL3gLctaWM5TmJR0sXVqHw=;
        b=evm1pRLcjijbhTt61P44gFcFIlXuu/VcCnwsGCUW8d0/Z+cDwGmK03AO3gRSi823ev
         qlcIr8jTGttZOWPjaTgZXTym1Zr4GHHO+44dpnAb4zx0+ep8z8l9uwijgihS3/WQwlz9
         cow9uDOmbOQNzF3hC4esRibCbp0aJkJFO017mdMXouypeCsxwUzi8dPSG1R3GjvglzbI
         D43spjYhe7tEF50yvBuGTKWA5Goy/XQvi0TYh67F3HjOA8R3EcQhw0GmHXWJZhGKuF/L
         vSCo/VOLxQC0GMaM845k92x20EOGrhJ/t6FFIrJa3RF4oqNBy/5Ku/0hvJgDd+D3HeP7
         QxEA==
X-Gm-Message-State: AFqh2kp8DS5UHsPUUGM4s45PFR9uNloekqWGlvU9s/Lpd4VZjy4afQfk
        kSmHNW57Y/q7Dbs5Q1+z3ZLO1fjhmAA=
X-Google-Smtp-Source: AMrXdXt5FiOt4T4GmUIzpPMavTBt8O4nNxyZI63mwbVu1U7QmS5eVqOZAMz5Z1aimWI4MiqG2JaFwQ==
X-Received: by 2002:a17:90a:ea86:b0:229:9369:e13 with SMTP id h6-20020a17090aea8600b0022993690e13mr17211032pjz.36.1674260590591;
        Fri, 20 Jan 2023 16:23:10 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090a3f8d00b00223ed94759csm2027823pjc.39.2023.01.20.16.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:23:10 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 07/12] bpf: Avoid recomputing spi in process_dynptr_func
Date:   Sat, 21 Jan 2023 05:52:36 +0530
Message-Id: <20230121002241.2113993-8-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230121002241.2113993-1-memxor@gmail.com>
References: <20230121002241.2113993-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3698; i=memxor@gmail.com; h=from:subject; bh=n4U1dXvfeNH1zRNe/co4rVPmlxHdSUzypJJY0IRJzjw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyzAk1RvlX6RfReOLAFbMWC9wK/gvWsxIfRy4IvoV dOq3G5OJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8swJAAKCRBM4MiGSL8RyqKGEA CqWcomND/5jfg8ip0Mj/py7B5U47HQFLbmlgo2okv4V8mWQfqvQhOunSfJdlK3o//AtqzVMs054eUF 8Z8x+kkR+R5cmBT2Cq8d0hqwnYrPWrQ2+ZrsUJlCnpW/2/q4DuIJ6KYCtN3qXWVqrkkXh9JsES63H/ uLFtFQlLyRohmUE7rg5l1JKSLf6tpwbzSvXAnZfE+lN50JP1TWCUExsClCfR/gRoBQMQnosjNAJjBV 8X/Jnd7Ue916+xF8ivBzOJmMfzZVfXZaLeEp8t/HXN4TGcA4I1tOmtHjH1q5F8j4w9nQAk3TytBjL6 +VCRQjPpVUJlrOnkTu+RL9MB28Bvs1+TIQ3vAxJtJ8jjR5IObvik2Htv7Mc/ANLvKVRy2HZq4dvgW5 /99+plj+U2VcwgqERMa4+DuklNqh9ji/cANczr8BujJfRW+d1cmVlmIHZlCjFVwugo6Y1Vhh1+CQap OWaFw1WOezGhPrxW84za6r4sQCe+QvN/GpuiOxOgC1F0VlA34YlhQoDac6D4YH1jgBjvDcf8MbX+ZG ZSXDTBpMwqaSsmgeDqC88n3Q26KaonE8kz2c/D01bkCpjy3N3AAy4613iVxwLGiuEfFwlKYUCCJC9y 6EqiTEVEYeUPzgT/2Rn2sFcHM7kpiQ/CoMHOlGMpgvXgqFwSszj195t6K2NA==
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

Currently, process_dynptr_func first calls dynptr_get_spi and then
is_dynptr_reg_valid_init and is_dynptr_reg_valid_uninit have to call it
again to obtain the spi value. Instead of doing this twice, reuse the
already obtained value (which is by default 0, and is only set for
PTR_TO_STACK, and only used in that case in aforementioned functions).
The input value for these two functions will either be -ERANGE or >= 1,
and can either be permitted or rejected based on the respective check.

Suggested-by: Joanne Koong <joannelkoong@gmail.com>
Acked-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 29cbb3ef35e2..ecf7fed7881c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -946,14 +946,12 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				       int spi)
 {
-	int spi;
-
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return false;
 
-	spi = dynptr_get_spi(env, reg);
 	/* For -ERANGE (i.e. spi not falling into allocated stack slots), we
 	 * will do check_mem_access to check and update stack bounds later, so
 	 * return true for that case.
@@ -971,16 +969,16 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	return true;
 }
 
-static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+				     int spi)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, i;
+	int i;
 
 	/* This already represents first slot of initialized bpf_dynptr */
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return true;
 
-	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
 		return false;
 	if (!state->stack[spi].spilled_ptr.dynptr.first_slot)
@@ -6139,6 +6137,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 			enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	int spi = 0;
 
 	/* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to an
 	 * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
@@ -6152,10 +6151,9 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 	 * and its alignment for PTR_TO_STACK.
 	 */
 	if (reg->type == PTR_TO_STACK) {
-		int err = dynptr_get_spi(env, reg);
-
-		if (err < 0 && err != -ERANGE)
-			return err;
+		spi = dynptr_get_spi(env, reg);
+		if (spi < 0 && spi != -ERANGE)
+			return spi;
 	}
 
 	/*  MEM_UNINIT - Points to memory that is an appropriate candidate for
@@ -6174,7 +6172,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 	 *		 to.
 	 */
 	if (arg_type & MEM_UNINIT) {
-		if (!is_dynptr_reg_valid_uninit(env, reg)) {
+		if (!is_dynptr_reg_valid_uninit(env, reg, spi)) {
 			verbose(env, "Dynptr has to be an uninitialized dynptr\n");
 			return -EINVAL;
 		}
@@ -6197,7 +6195,7 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
 			return -EINVAL;
 		}
 
-		if (!is_dynptr_reg_valid_init(env, reg)) {
+		if (!is_dynptr_reg_valid_init(env, reg, spi)) {
 			verbose(env,
 				"Expected an initialized dynptr as arg #%d\n",
 				regno);
-- 
2.39.1

