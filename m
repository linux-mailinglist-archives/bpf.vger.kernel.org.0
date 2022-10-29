Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64305611F73
	for <lists+bpf@lfdr.de>; Sat, 29 Oct 2022 04:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJ2CzL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 22:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJ2CzK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 22:55:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2572248D5
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 19:54:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c2so6360503plz.11
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 19:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aOLv5bd0FLV/mnE8/fEeex6Wf+bGxAwiWHAjCPeob8=;
        b=F1CIddvjILhqwJkQTMNC9hHvJYNArr9ey/ZbzNYqitzzHQZy3r7uM2qGWEgnpwLm8D
         2kScoECk2psL1KqyxHSF4Rd2eD8r7UkizqsMCsaURAOY8eTeMT9EhLycnkY/5dYIVixg
         Phcsf1C/VDjddGLVWbrt40HOPyI0z5cfUGem0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aOLv5bd0FLV/mnE8/fEeex6Wf+bGxAwiWHAjCPeob8=;
        b=6bQGxe2phyWupwirSsXT9AJVLgen2lUg/YL582GKS0LxvAMqEpMiI2Sbv87vlepIHU
         oVzuDaqvEDCeu3XMqnS+8qJtJUjj3wNhDWsejXKdYogLU7ZcDBM4CFYZT20HVfYPR8Ic
         mpbVtIW5q3jyhdjaHIpXWbi1SwOYPGFovNTXFTWJ8YFtwfD7y5F1MN0F6v7H3c98mPeS
         Pm4G8R0NYqENOEYtkWeqENG+S8pKKML4iiXFP/3aHbefMbMWSBj1VUSzn/oJEFuhxFnL
         Z4e0As810pGkKSs3CI/CYjnrV/nD1iAuPd7VD1eEE4g58RGAIMrH+LPeG15i8bZBZnQ1
         3D+Q==
X-Gm-Message-State: ACrzQf1Qym/GUXSebNzcAkUUGrUeJF1duy3MFeT1yx20FUue7n+bpQwP
        sAw/1tz+TD/ZvFPRasVs1BUhfA==
X-Google-Smtp-Source: AMsMyM6HJPQNNHUKo0hqSZ77eYX6lSBHvTuXFvuJmE1nVwBFZI8X4MsvRQFTWCL3yLz9vbqzCuWTBw==
X-Received: by 2002:a17:902:dad1:b0:183:243c:d0d0 with SMTP id q17-20020a170902dad100b00183243cd0d0mr2229535plx.157.1667012077434;
        Fri, 28 Oct 2022 19:54:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p15-20020a634f4f000000b00429c5270710sm166610pgl.1.2022.10.28.19.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 19:54:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH bpf-next v2 3/3] bpf/verifier: Take advantage of full allocation sizes
Date:   Fri, 28 Oct 2022 19:54:32 -0700
Message-Id: <20221029025433.2533810-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029024444.gonna.633-kees@kernel.org>
References: <20221029024444.gonna.633-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3544; h=from:subject; bh=kUtgUSzjHG/StpxeZ/gAkJuSWQ81P7If0wKJuguKsQA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjXJXoKq5ZWOaEe0w9wu2rU5+gTlHcFnfDONzx5rl8 2MO2kVmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1yV6AAKCRCJcvTf3G3AJjZFEA CbaiZHl1X/Eo7Q6u7OrXXEEu/Fc8P8Egz+2f9weQmvTFT6k8pHEJ646zRGYaElHNuF8dWLLFMJzM1Y uArHQVBqs6LQJ42PuY5l3YGl7j7pmWZwLgscvoR5jyYaXK+/r4zeRdhSbld8X/9cqZ6Jxk8SiPWveK dR/nJPs+tNkPLMdmyWbiEcz5A5+/tAzCBLmZjrgFBEokROEOl+TXx4IIpQbyqgzIDH3+gZ70I1NUhW lPjsvBvh52LVVOaWPV+GLV49VL/tK9veQLcWdWjSMzbnibeWn/xi9OCf94VNP/sAud9eO3w2PFBOij dA4dB88NxOwPgBSoN72V20mybNtqDdfmFCsI3osTyRAdnS+aFgUZ46I72yHpxd016UXEu6QcEUoTgu hKZz6nCyDNN/LfR5C6KER5YAYDzU+MC2uVFAdvE8GeabTsB5cO9kmujEadXdzd4j3C/ZCm6NsUSXG8 LtqGbSpbXDkuteqDDR8dhqIwYkp1t6sajZpOkWVSrKCyEaP65KGhzNwurPBOwlkjyg/K1aQxVys/l4 WVq86oBHhGxemD+KPFGaiLNBxljDw59+kpBi/I8VyCjT7lfHHIqmjFTKNREDkjg5izXZHA9wWJEJ7z CXrUKoUSAdUN08z2u+RbVOxApyfeLHAPi9Jty6yKPofgiYJneRRiZCO0gQjg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since the full kmalloc bucket size is being explicitly allocated, pass
back the resulting details to take advantage of the full size so that
reallocation checking will be needed less frequently.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/bpf/verifier.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c040d27b8f6..e58b554e862b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1020,20 +1020,23 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
 	return dst ? dst : ZERO_SIZE_PTR;
 }
 
-/* resize an array from old_n items to new_n items. the array is reallocated if it's too
- * small to hold new_n items. new items are zeroed out if the array grows.
+/* Resize an array from old_n items to *new_n items. The array is
+ * reallocated if it's too small to hold *new_n items. New items are
+ * zeroed out if the array grows. Allocation is rounded up to next kmalloc
+ * bucket size to reduce frequency of resizing. *new_n contains the new
+ * total number of items that will fit.
  *
- * Contrary to krealloc_array, does not free arr if new_n is zero.
+ * Contrary to krealloc, does not free arr if new_n is zero.
  */
-static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
+static void *realloc_array(void *arr, size_t old_n, size_t *new_n, size_t size)
 {
 	size_t alloc_size;
 	void *new_arr;
 
-	if (!new_n || old_n == new_n)
+	if (!new_n || !*new_n || old_n == *new_n)
 		goto out;
 
-	alloc_size = kmalloc_size_roundup(size_mul(new_n, size));
+	alloc_size = kmalloc_size_roundup(size_mul(*new_n, size));
 	new_arr = krealloc(arr, alloc_size, GFP_KERNEL);
 	if (!new_arr) {
 		kfree(arr);
@@ -1041,8 +1044,9 @@ static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
 	}
 	arr = new_arr;
 
-	if (new_n > old_n)
-		memset(arr + old_n * size, 0, (new_n - old_n) * size);
+	*new_n = alloc_size / size;
+	if (*new_n > old_n)
+		memset(arr + old_n * size, 0, (*new_n - old_n) * size);
 
 out:
 	return arr ? arr : ZERO_SIZE_PTR;
@@ -1074,7 +1078,7 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
 
 static int resize_reference_state(struct bpf_func_state *state, size_t n)
 {
-	state->refs = realloc_array(state->refs, state->acquired_refs, n,
+	state->refs = realloc_array(state->refs, state->acquired_refs, &n,
 				    sizeof(struct bpf_reference_state));
 	if (!state->refs)
 		return -ENOMEM;
@@ -1090,11 +1094,12 @@ static int grow_stack_state(struct bpf_func_state *state, int size)
 	if (old_n >= n)
 		return 0;
 
-	state->stack = realloc_array(state->stack, old_n, n, sizeof(struct bpf_stack_state));
+	state->stack = realloc_array(state->stack, old_n, &n,
+				     sizeof(struct bpf_stack_state));
 	if (!state->stack)
 		return -ENOMEM;
 
-	state->allocated_stack = size;
+	state->allocated_stack = n * BPF_REG_SIZE;
 	return 0;
 }
 
-- 
2.34.1

