Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF034FA675
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 11:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbiDIJfD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 05:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiDIJfC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 05:35:02 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE2102C
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 02:32:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so10762164pjw.2
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 02:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eIivlly+MpYNB233qfDWvo6mC2WlDKYDs9pwQQ6zLjo=;
        b=QO0bUh2U50dVfcJAaF50GifvvEFeHiWA6fVl4w07Au/T8q8V8Oqiza2FuO3qBawMfm
         9VHWcObZySKZvhLivUakd/t+tfI0qApYs+3bieln/SIdQCz1a8ScDXyYLycnKnjhIC4F
         4LSucEDBUqY53pgcrqHLFVpOXI9IbBFKafID8rr0bOla5hMDVV/es7b3g36soIZS4Vc4
         7BDvxUxJIW8XwlQgr+R5M7VOtGbudZAcrcoJBBOPv31LkkO3LA9enQrjalAUSCypWFBK
         +N9aU0cwtBIPPv3uqEsSXvL40aHX6heR93nkT9nCS77jM8qyxOTi5fEBMRkUCln3WSWC
         nJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eIivlly+MpYNB233qfDWvo6mC2WlDKYDs9pwQQ6zLjo=;
        b=qvK55jqRlDhtFsrfAf7CTO1FhsjBVlfQuASUvClmLwZvbtGvnwd4sESMHmV77Xbs+I
         I8OydOrgFKZUD0ytthVlND3Xx9XTdI72Tgx0E1o966/Z2uDC7wnz5yiZ6IOUf3Mi5c2H
         Quj14xRypYbLIb+9bHnTTVllcSd5FbpHXbD7Nrler0VdBI/9t6Uf0i2MKdJxnycwDmGD
         Vrfme1MkgxX42JLYmj2Cdq6TsRzS4XJqxT5XVqJ5fQN1OZdroZ6J9pglRjKx1VPfKXyt
         AhGheJZsOibNJk67zwiZ/nXbTBafzthlhenZmaE/MNfFJuYoXb1y7f8m0PMWT0U18j49
         teKQ==
X-Gm-Message-State: AOAM530pab/71WJ1ogRpPFjBTTmsQRCtkMn/2fF5qWWBoZd7yHtGyr3i
        Ik7O+VptdOP1DZQjcC3Om70sCGrB1y4=
X-Google-Smtp-Source: ABdhPJzZ6uWYYuGjl96T37s54KW/5kvKZiJtdwy5Ax3yb8LKds8qP/uNl9IL9t/Y9WOc1EpXaOxA8g==
X-Received: by 2002:a17:90a:2f46:b0:1ca:88b6:d0cf with SMTP id s64-20020a17090a2f4600b001ca88b6d0cfmr26617106pjd.12.1649496775206;
        Sat, 09 Apr 2022 02:32:55 -0700 (PDT)
Received: from localhost ([112.79.142.148])
        by smtp.gmail.com with ESMTPSA id n4-20020a637204000000b00398522203a2sm24243215pgc.80.2022.04.09.02.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:32:54 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v4 02/13] bpf: Move check_ptr_off_reg before check_map_access
Date:   Sat,  9 Apr 2022 15:02:52 +0530
Message-Id: <20220409093303.499196-3-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409093303.499196-1-memxor@gmail.com>
References: <20220409093303.499196-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3314; h=from:subject; bh=V+oSZMJCeqNDrjaqkVnlur5r4kljwOC9jDh+AhirwJg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiUVFzE4fgV5E/HgZztWGyklJqHgmojtVB2rCydEt4 7m3cz4yJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlFRcwAKCRBM4MiGSL8RyuLNEA C+3Wvn3i+WvR3HCcEL6VtisOlVdC9Y3S9XfQKPHs8XhzbhhG/BE3d3N1Kl+N7IvqpydafoS0/LqVNk tInd6Vvn7+EYrSJ6LDWKlksnD51z3om/q35SGiqIIJ8vIBoTXy6kZdWaSQiocDM0/4cGtRg1g5M+hq /5PASq9q082PIOGOC0ys7J9Gn1j3Cm1ozZrPtYrEoZdApuTZfPHjlEJmuGbmTZHVepAMZEFzzx/p5C jmyoKeHgLOqelQrwfdAc4bjL4KrbJFuOFnf7wuoqh9YP/ytqba9cFXD4ucwF3jHkDzmO8iqnGjnMVT KKg3gd5hfq10YDx8H5BUzx97XHUUX4uqgeOpYQvk9YySxu4exJmrNv+840K3LSwwaJhRh0K9G1bs4j VKEOoyKkF7mmitJFwzfYuSSABbKiRuBqBYL4Gn+xESvn9RaglxF97i+hi/0TIbDJqQGglB9Kfg7x0X 9cl2hDSGL7N+boivem/A3Yk6WDpMAPPmO38KrmLVlJML/lDuZ+tohfZMUiR9tEHH8mXP/2eKwu76+E mlHd2DEYJSTlKBU+nTzrqVPL12Earp2SK2amPn94W9TVJXKpPQYcdYLKkbsAphxIm9mdtfXLkWtBio oJHM+vdLF6snppN9YAdNqFb4XtbcJIb88Fv3XHV/kWed2XtYGTwdyohWkq1w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some functions in next patch want to use this function, and those
functions will be called by check_map_access, hence move it before
check_map_access.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 76 +++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c1a02b82ecd..71827d14724a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3469,6 +3469,44 @@ static int check_mem_region_access(struct bpf_verifier_env *env, u32 regno,
 	return 0;
 }
 
+static int __check_ptr_off_reg(struct bpf_verifier_env *env,
+			       const struct bpf_reg_state *reg, int regno,
+			       bool fixed_off_ok)
+{
+	/* Access to this pointer-typed register or passing it to a helper
+	 * is only allowed in its original, unmodified form.
+	 */
+
+	if (reg->off < 0) {
+		verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
+			reg_type_str(env, reg->type), regno, reg->off);
+		return -EACCES;
+	}
+
+	if (!fixed_off_ok && reg->off) {
+		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
+			reg_type_str(env, reg->type), regno, reg->off);
+		return -EACCES;
+	}
+
+	if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
+		char tn_buf[48];
+
+		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
+		verbose(env, "variable %s access var_off=%s disallowed\n",
+			reg_type_str(env, reg->type), tn_buf);
+		return -EACCES;
+	}
+
+	return 0;
+}
+
+int check_ptr_off_reg(struct bpf_verifier_env *env,
+		      const struct bpf_reg_state *reg, int regno)
+{
+	return __check_ptr_off_reg(env, reg, regno, false);
+}
+
 /* check read/write into a map element with possible variable offset */
 static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 			    int off, int size, bool zero_size_allowed)
@@ -3980,44 +4018,6 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
-static int __check_ptr_off_reg(struct bpf_verifier_env *env,
-			       const struct bpf_reg_state *reg, int regno,
-			       bool fixed_off_ok)
-{
-	/* Access to this pointer-typed register or passing it to a helper
-	 * is only allowed in its original, unmodified form.
-	 */
-
-	if (reg->off < 0) {
-		verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
-			reg_type_str(env, reg->type), regno, reg->off);
-		return -EACCES;
-	}
-
-	if (!fixed_off_ok && reg->off) {
-		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
-			reg_type_str(env, reg->type), regno, reg->off);
-		return -EACCES;
-	}
-
-	if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
-		char tn_buf[48];
-
-		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-		verbose(env, "variable %s access var_off=%s disallowed\n",
-			reg_type_str(env, reg->type), tn_buf);
-		return -EACCES;
-	}
-
-	return 0;
-}
-
-int check_ptr_off_reg(struct bpf_verifier_env *env,
-		      const struct bpf_reg_state *reg, int regno)
-{
-	return __check_ptr_off_reg(env, reg, regno, false);
-}
-
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
-- 
2.35.1

