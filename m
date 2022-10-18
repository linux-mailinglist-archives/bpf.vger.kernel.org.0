Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEFD6027E8
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJRJGN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 05:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJRJGK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 05:06:10 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF71429346
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 02:06:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d10so13500445pfh.6
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 02:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cna04yyHG5Rhk1xjjargfMS4ggnGTAS3WSwG/JEXh5E=;
        b=O0bOCyKuWM6ro00csIDqMb58TdznDaihJ345kL5wtrCS/B5g04pki1wXd8VKlzgmiQ
         1sZUzbcg3izOdj8ZwHVMoFYMATdZGqOM66UrgHQIuzLac3IZkkaHxL+1Io9SEESmiHxr
         veAWICRC9Ec5xeTKww4QBxCwh8prsZliCpMdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cna04yyHG5Rhk1xjjargfMS4ggnGTAS3WSwG/JEXh5E=;
        b=LWORYmrxw3pKK/U1pBmFZRDtCiLRjcf+yTvHiaa1hWuIp6uDqaW4x9DQqJk9Tw0lkp
         vEu7pY6MzpRDTg3MrsO/WcthqewXBmKzl7fMouGLiWcZxYXaqNcwxtYZmxi3vS2c/k03
         oJCdcMGNDuM8Ggwt2Z0vgArWkfvgq+ZXtVe1TWK67PmCU59KdWf5KFIsLffnTgRPUJj4
         1SYvqMASObdMIIwYvQ84npQgcR9phIYlKppEvn0qBg8CSx1qUFidWcrFfyGXV5G5LN1l
         TH8DGqM8kjreNjDlMFDniUgxx8SE6VN6tUL6E9QmhtXJbNkJGdB8L9Rp8Ddue6vSvrfZ
         DULg==
X-Gm-Message-State: ACrzQf0jdkwiSMq//BhOj6PgfvWUQPAh02HWHQXup2SmW3q0Nk427N8k
        G5sPbBMY4G8xtLbZOYJmBNsLbZ7gzOo2VQ==
X-Google-Smtp-Source: AMsMyM7TUnkQMsPkmsIe5F8zLdnjl+piJYCgu3Tvl0nY91XJ8Z3I3mvS02CCYxb5HSIr54KGsItqbA==
X-Received: by 2002:a05:6a00:2409:b0:54e:a3ad:d32d with SMTP id z9-20020a056a00240900b0054ea3add32dmr1944105pfh.70.1666083967788;
        Tue, 18 Oct 2022 02:06:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902e74d00b0017854cee6ebsm8248168plf.72.2022.10.18.02.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 02:06:06 -0700 (PDT)
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
Subject: [PATCH] bpf: Use kmalloc_size_roundup() to match ksize() usage
Date:   Tue, 18 Oct 2022 02:06:04 -0700
Message-Id: <20221018090550.never.834-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4989; h=from:subject:message-id; bh=Fr0TEY0ebYJmqqj0qnCbteUTMJgo6T9lad66aRDP4mY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTmx8Q7PRu/upedhMQ7oIuLcTbRxOWvjAfTMHR04G 8tzjdt6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05sfAAKCRCJcvTf3G3AJn3fEA Cxi0d5b1UDtbZ3TZKY+eVP+pBkZ0uH/thgWCqgykpjyiuQsIrWljPsmPT6cuH1ZSe55Y1TyWO/PYh/ tAtET6fBm5Mz7pwiA+xhqkuNWvuYsHKaVvF27PzpUXgSrTGNUWEsKSYbCtm/G+QYbgKWkNo5dGAwnm dD8Juog1QZYQisUnzArLBufdznMN4ReXEl/utRC8hkTZZlnrApk7fPnnNutfvRyJW6TCwtsDxjfcTW 6+eVNbgrHFKOfXZjds/L57gfzxKOMyeVEQBeOa+/qOzgqopMGxGCloWfvb8CIc2XyMk0CxSE+cnLzq kA3HlnAjQd0+aieO/oskjhTzUe3xPUGZw2fs7zClyAbl13Hc/A+8hMXFL3BEYzrnRiJcuV8QI0RQpx CofbgLmMBXsAWzThWungCK4XzN+DndqzUTemCJHqRYjC7WSof6ny/c/751zkZ3NJrfUgdkE/O2tSZx d5gmARIx2Kzk0UAmk+dXdr/wXpZ3qLPICk6fBJzOOq457Le23+UX312rMIlQBuTI1Pbkk1UVqf2nwI uqbyNefb3Lch4nSsJbUBLhXEgSiIxRYVw17p8LONmU2AmUbWB0bTeQ8+uWH9Wrj32Mmo/VyeDVMUzj edIQzoWW76E4PZGUL2+Q5UmKMYj+m1F2+pyklEf9AfJM3ZHk64c6DHFbwdPQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Round up allocations with kmalloc_size_roundup() so that the verifier's
use of ksize() is always accurate and no special handling of the memory
is needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE. Pass the new size
information back up to callers so they can use the space immediately,
so array resizing to happen less frequently as well. Explicitly zero
any trailing bytes in new allocations.

Additionally fix a memory allocation leak: if krealloc() fails, "arr"
wasn't freed, but NULL was return to the caller of realloc_array() would
be writing NULL to the lvalue, losing the reference to the original
memory.

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
 kernel/bpf/verifier.c | 49 +++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 014ee0953dbd..8a0b60207d0e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1000,42 +1000,53 @@ static void print_insn_state(struct bpf_verifier_env *env,
  */
 static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t flags)
 {
-	size_t bytes;
+	size_t src_bytes, dst_bytes;
 
 	if (ZERO_OR_NULL_PTR(src))
 		goto out;
 
-	if (unlikely(check_mul_overflow(n, size, &bytes)))
+	if (unlikely(check_mul_overflow(n, size, &src_bytes)))
 		return NULL;
 
-	if (ksize(dst) < bytes) {
+	dst_bytes = kmalloc_size_roundup(src_bytes);
+	if (ksize(dst) < dst_bytes) {
 		kfree(dst);
-		dst = kmalloc_track_caller(bytes, flags);
+		dst = kmalloc_track_caller(dst_bytes, flags);
 		if (!dst)
 			return NULL;
 	}
 
-	memcpy(dst, src, bytes);
+	memcpy(dst, src, src_bytes);
+	memset(dst + src_bytes, 0, dst_bytes - src_bytes);
 out:
 	return dst ? dst : ZERO_SIZE_PTR;
 }
 
-/* resize an array from old_n items to new_n items. the array is reallocated if it's too
- * small to hold new_n items. new items are zeroed out if the array grows.
+/* Resize an array from old_n items to *new_n items. The array is reallocated if it's too
+ * small to hold *new_n items. New items are zeroed out if the array grows. Allocation
+ * is rounded up to next kmalloc bucket size to reduce frequency of resizing. *new_n
+ * contains the new total number of items that will fit.
  *
- * Contrary to krealloc_array, does not free arr if new_n is zero.
+ * Contrary to krealloc, does not free arr if new_n is zero.
  */
-static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
+static void *realloc_array(void *arr, size_t old_n, size_t *new_n, size_t size)
 {
-	if (!new_n || old_n == new_n)
+	void *old_arr = arr;
+	size_t alloc_size;
+
+	if (!new_n || !*new_n || old_n == *new_n)
 		goto out;
 
-	arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
-	if (!arr)
+	alloc_size = kmalloc_size_roundup(size_mul(*new_n, size));
+	arr = krealloc(old_arr, alloc_size, GFP_KERNEL);
+	if (!arr) {
+		kfree(old_arr);
 		return NULL;
+	}
 
-	if (new_n > old_n)
-		memset(arr + old_n * size, 0, (new_n - old_n) * size);
+	*new_n = alloc_size / size;
+	if (*new_n > old_n)
+		memset(arr + old_n * size, 0, (*new_n - old_n) * size);
 
 out:
 	return arr ? arr : ZERO_SIZE_PTR;
@@ -1067,7 +1078,7 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
 
 static int resize_reference_state(struct bpf_func_state *state, size_t n)
 {
-	state->refs = realloc_array(state->refs, state->acquired_refs, n,
+	state->refs = realloc_array(state->refs, state->acquired_refs, &n,
 				    sizeof(struct bpf_reference_state));
 	if (!state->refs)
 		return -ENOMEM;
@@ -1083,11 +1094,11 @@ static int grow_stack_state(struct bpf_func_state *state, int size)
 	if (old_n >= n)
 		return 0;
 
-	state->stack = realloc_array(state->stack, old_n, n, sizeof(struct bpf_stack_state));
+	state->stack = realloc_array(state->stack, old_n, &n, sizeof(struct bpf_stack_state));
 	if (!state->stack)
 		return -ENOMEM;
 
-	state->allocated_stack = size;
+	state->allocated_stack = n * BPF_REG_SIZE;
 	return 0;
 }
 
@@ -2499,9 +2510,11 @@ static int push_jmp_history(struct bpf_verifier_env *env,
 {
 	u32 cnt = cur->jmp_history_cnt;
 	struct bpf_idx_pair *p;
+	size_t size;
 
 	cnt++;
-	p = krealloc(cur->jmp_history, cnt * sizeof(*p), GFP_USER);
+	size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
+	p = krealloc(cur->jmp_history, size, GFP_USER);
 	if (!p)
 		return -ENOMEM;
 	p[cnt - 1].idx = env->insn_idx;
-- 
2.34.1

