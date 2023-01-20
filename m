Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AB4674DA9
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 08:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjATHET (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 02:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjATHES (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 02:04:18 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05FD40FB
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:17 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so4076302pjl.0
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJTE+2IiThjMO3PC0iuCb5HXJeu+oAk3QS1io4LW83g=;
        b=A7s4MhGg+4do/NyS56v6JrVz0LzTivVOUmV1UQ0Ba96E4TxbVA6lgYSHRi2zVTLaIe
         yI/B3K6RkD0jEW1H5Z/Rppmce7JbnEe4XfhKEBODd5WhmRtw833pzlVQK2GTW/FpbHnU
         YpVJJk4OgdrJTmDAu/lCftnmsj9uDg9qkYP5GOGBGciiej5xVMvhB/24sZHuZc+0LS1Y
         2ypJLe1yyfd4ZQ4c9rnnTG+5FFP/IMoNb0YxoJJO2QYtT8gyiXxKWSdDmmt6hmXmcRqa
         t0X+wHX3MF0ChcrWWc9+9SNeBj0SrO1E2cLAxcq4/ZJ1XDGgRa9+IhL5OOEkSUqjReyJ
         jDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJTE+2IiThjMO3PC0iuCb5HXJeu+oAk3QS1io4LW83g=;
        b=YvSxGg+PzTpgUKg/qUePJbqXAC1j8Mc1QMJMIi7mKNKZ8L5H4bF9NWIsK4NMXx1/eS
         KWmRDVDqVIYrS3/OeSVNBVA7xhDY43n2hl1qePekNIytiQIdCH5GvK3oYUZvVTNuuNAr
         XaFb5M4zYnff5N/SHo2h72a9ZZY9QQRb8wLqBEMrbpF81KM+gbL76qp5jRbDCB1/YCU9
         vvvZ6lTXcMk+W0y6s8I5YIErp1Vfaevc/M/hIxxF5CGhCXhaJ4x0BH1gjeGGZqmZwIwk
         lZMsVYjxFP/K12OhfD63hvMuSquTWbF2BPw3E7ANyfKM0LF0wjBF8jPTMqNJL0bL9aYD
         gNIQ==
X-Gm-Message-State: AFqh2krb01gkhFzimzlG6bTYXduxIzouxzw8dAvhfRNXEFJVFsyD9AUs
        Ui3BWNdY7TFe5pbjECk2bxdF2qj8oaI=
X-Google-Smtp-Source: AMrXdXt/IXcjM5b/aAyyZ40wJM498xSBaLg8yjEx0PBZCEjsYC69sjp/4IbSlkKhbSRMc+YN8ZFULQ==
X-Received: by 2002:a17:90b:1206:b0:229:188a:c0e7 with SMTP id gl6-20020a17090b120600b00229188ac0e7mr13801813pjb.49.1674198257290;
        Thu, 19 Jan 2023 23:04:17 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id gp6-20020a17090adf0600b00219186abd7csm766152pjb.16.2023.01.19.23.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:04:16 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 05/12] bpf: Allow reinitializing unreferenced dynptr stack slots
Date:   Fri, 20 Jan 2023 12:33:48 +0530
Message-Id: <20230120070355.1983560-6-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120070355.1983560-1-memxor@gmail.com>
References: <20230120070355.1983560-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3888; i=memxor@gmail.com; h=from:subject; bh=YkhcRHw6M8R1uNyUytIog/IKy6jL6P3mgH0kEKFhQB8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyjzLJqykp549TuD8qfi+l8J7mju9PTDOmDmMoZB7 eluhbseJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8o8ywAKCRBM4MiGSL8RyoYxD/ 9aqXjUHfv3Ewq2IQuoLFusL8z9DK1rNpN0O9+Fq/lVB594vNcwDiLO1pv2xfDpr6qC8HgpTo73fbip g70arQIo5wrFQFAqhjIZW+RDdk9kBN0p6unV9R/q6oqm3+SWJSe9J4jm+8DLyx61oh7+bkSifSVCYl V84sY/9DWVklgMaM9fCcph9zFH26rcelQLOg+6cqVDGFxEWyRwCSlb7SLcmN8TDltxuU8SXUthgUVk jTCZsCWhkjp9r/f//LJrSDy76TT+79lNWcXtdT6LmNBLNNfAv43duEfIXltBuaRxa810UPl5dU1rEx Bt3/RGvEouZbNMb1+JpG7c4446GN+6kx5BPF+xY27aOR6eqHqc8HYbpSWE1skdK5yp+yXcn1dE0Xl6 O+hW7wBfmJTzQQ+MAUc3vsrhnCshkBXGKJvuADaZ9SBZV1Eu2ZpCXBheaTZK3YHwzlpyQzibCFAyDB BNvlVAAIIq50vTejkX/eMWJBNQ8/Jjfh3r69mfIIU6tlCae8pDnZGt1skyN4BZPHteGLFLhCE9g0bo F/Peh0XbDTDr9ryEFVgRpD6OM8oCSLL3YYRhtpmAgcFEbKlEx3h3xvxh/2wPCNx0OM6LRmyJarY/Mi m0O0VkrrObGMWpYmzMyleTUVz/vGlOrKH7DO78eInrMtkBzqK88I0yxDIV9g==
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

Consider a program like below:

void prog(void)
{
	{
		struct bpf_dynptr ptr;
		bpf_dynptr_from_mem(...);
	}
	...
	{
		struct bpf_dynptr ptr;
		bpf_dynptr_from_mem(...);
	}
}

Here, the C compiler based on lifetime rules in the C standard would be
well within in its rights to share stack storage for dynptr 'ptr' as
their lifetimes do not overlap in the two distinct scopes. Currently,
such an example would be rejected by the verifier, but this is too
strict. Instead, we should allow reinitializing over dynptr stack slots
and forget information about the old dynptr object.

The destroy_if_dynptr_stack_slot function already makes necessary checks
to avoid overwriting referenced dynptr slots. This is done to present a
better error message instead of forgetting dynptr information on stack
and preserving reference state, leading to an inevitable but
undecipherable error at the end about an unreleased reference which has
to be associated back to its allocating call instruction to make any
sense to the user.

Acked-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01cb802776fd..e5745b696bfe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -782,7 +782,7 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 {
 	struct bpf_func_state *state = func(env, reg);
 	enum bpf_dynptr_type type;
-	int spi, i, id;
+	int spi, i, id, err;
 
 	spi = dynptr_get_spi(env, reg);
 	if (spi < 0)
@@ -791,6 +791,22 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return -EINVAL;
 
+	/* We cannot assume both spi and spi - 1 belong to the same dynptr,
+	 * hence we need to call destroy_if_dynptr_stack_slot twice for both,
+	 * to ensure that for the following example:
+	 *	[d1][d1][d2][d2]
+	 * spi    3   2   1   0
+	 * So marking spi = 2 should lead to destruction of both d1 and d2. In
+	 * case they do belong to same dynptr, second call won't see slot_type
+	 * as STACK_DYNPTR and will simply skip destruction.
+	 */
+	err = destroy_if_dynptr_stack_slot(env, state, spi);
+	if (err)
+		return err;
+	err = destroy_if_dynptr_stack_slot(env, state, spi - 1);
+	if (err)
+		return err;
+
 	for (i = 0; i < BPF_REG_SIZE; i++) {
 		state->stack[spi].slot_type[i] = STACK_DYNPTR;
 		state->stack[spi - 1].slot_type[i] = STACK_DYNPTR;
@@ -936,7 +952,7 @@ static int destroy_if_dynptr_stack_slot(struct bpf_verifier_env *env,
 static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct bpf_func_state *state = func(env, reg);
-	int spi, i;
+	int spi;
 
 	if (reg->type == CONST_PTR_TO_DYNPTR)
 		return false;
@@ -949,12 +965,14 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
 	if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
 		return true;
 
-	for (i = 0; i < BPF_REG_SIZE; i++) {
-		if (state->stack[spi].slot_type[i] == STACK_DYNPTR ||
-		    state->stack[spi - 1].slot_type[i] == STACK_DYNPTR)
-			return false;
-	}
-
+	/* We allow overwriting existing unreferenced STACK_DYNPTR slots, see
+	 * mark_stack_slots_dynptr which calls destroy_if_dynptr_stack_slot to
+	 * ensure dynptr objects at the slots we are touching are completely
+	 * destructed before we reinitialize them for a new one. For referenced
+	 * ones, destroy_if_dynptr_stack_slot returns an error early instead of
+	 * delaying it until the end where the user will get "Unreleased
+	 * reference" error.
+	 */
 	return true;
 }
 
-- 
2.39.1

