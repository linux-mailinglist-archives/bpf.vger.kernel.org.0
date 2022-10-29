Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38500611F74
	for <lists+bpf@lfdr.de>; Sat, 29 Oct 2022 04:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJ2CzO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 22:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJ2CzK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 22:55:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB98248F7
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 19:54:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso6064805pjc.2
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 19:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tl37lwqGAPyFTOLYOb65cx9juvzNTvoWHjwD7xYuFQ=;
        b=Cd9tmgsJJdWf0loxgAfE2HPeppCYbVz4D5gJ5tQcKB6L+ovA12Ew9mChsqPQXbuSUK
         P+EKoy+7WwL8q2rj931dqINtyZh6kEENAED1WS3uD8thf4KfTiTnMhSt3//hP3fVmfyz
         3nim0DVM7yPvIiHCyNEkq1nGp3MR8CSWdqGbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tl37lwqGAPyFTOLYOb65cx9juvzNTvoWHjwD7xYuFQ=;
        b=I3SQK+WFLo6k5Gzqu/PS5uFJgz/8SAuPQ0KdjjmL9OdATbO7nMsUasTkh1rVY2chKs
         tAVMhu9JRm0EVKhWE1nI+9sLH2IyInORk7Ij1vZWZ6PiiftOjhRin2B6yF8mCz/+0X2c
         WP96JboMgKf/2XT7dQowaSD4BLdGu3c9dZyHkQgx7lQMuomwhWePf0+SDXHkCxyXlnMn
         p/aTO0phBpq9NBJH2Qi49GkarHfqi3XW5m3ONWb4weZsWKk8oXGVB5qmRsNzYbGvg5xt
         5gQESBDMixoqzssmu6Uz5GyeEE+3Ri5Ieylrb/AMMHNmmhzwsuCXKZP6KpVkRs7qhiWa
         kNgA==
X-Gm-Message-State: ACrzQf2jXFA5JYCheqyp+iz01TeH2fzXgEZZ/Om9nw5sSwFWuoMbBO0c
        AUNCsI5WRBdWE7QOEaRlXuYtPg==
X-Google-Smtp-Source: AMsMyM4pP7ShODaS+Vv2buYU2g/jVJzW9tIyo/uOr9kvGNsRBVt6bMvVzIkugYCjOKGHoyJnVIuKXA==
X-Received: by 2002:a17:902:6b45:b0:186:878e:3b92 with SMTP id g5-20020a1709026b4500b00186878e3b92mr2222756plt.173.1667012077781;
        Fri, 28 Oct 2022 19:54:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p68-20020a625b47000000b0056b9c2699cesm170223pfb.46.2022.10.28.19.54.34
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
Subject: [PATCH bpf-next v2 2/3] bpf/verifier: Use kmalloc_size_roundup() to match ksize() usage
Date:   Fri, 28 Oct 2022 19:54:31 -0700
Message-Id: <20221029025433.2533810-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029024444.gonna.633-kees@kernel.org>
References: <20221029024444.gonna.633-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2473; h=from:subject; bh=cAZzQf4nJI/2AavYPElJQqPl11xZNu41P29+G33SJ9M=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjXJXnQGC8fPZwalh9l14/jG4kobQw8yjDcH8NbjSJ /XPIE3yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY1yV5wAKCRCJcvTf3G3AJtu9EA CXJjb2SNBE0dlmaXWQ51VUbBpWbuJYO6erazxkwDl20aLVHHY3Axth5HAjZff0RAgI1VuEgK0XZp1r RE0TT1eYl9G5ixdAC59qd1CyEHIcrq8+ifEZo8FgjuCM+csjbDGyrKYcgszia+gdt0jTBIbTc9RPDk h49CV0gy5UmirPGgX8dGIyGnpKI4FNyJSxPrtKEYB1NNT0NKDCYYx+RfELfzFCEUHszzQjq2QGPcoS MQCDLvOy6b2RiQLtsraXNMaGqb45mx9P5O9CTysRsnzDMvCA7NXwCuQuXsdjO/2HsBfxhz7Ar/YR9W Q9PmyZ/L0otSPcROBpRG2q6CUmDpOthzfBzcW58TTyDeLip32DmQpFbyiXtSgKMujj/DUh8fnY/DR8 2j1VH+mqdaYP7FiWIMA+ed88554A/22x76JzNS5Caj75Gk5klIWA9DRXxqyAIhkWj0AZZY0oDA+/bI BaXI9irmdN/ojaCMS7GiewpfSz1XqXzoo+a2/IHb6qtOmcwGzuRXjvvCvZc3nO7FmlQUzB23V63ndC YIDPWXj/8EpTHHzYIkslH/ROZny/WlLvaMSrDlNnM8CWhQz5RGWiBaLDqtr2+lr8CzFydwOd9JaxoT 275n7Yb5433TpvdeSuKo/IQkPJI9tpzIZx8/08+btiQkdvPTHYsFe9hnV9Iw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
so array resizing to happen less frequently as well.

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
 kernel/bpf/verifier.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb8c34db74c7..1c040d27b8f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1008,9 +1008,9 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
 		return NULL;
 
-	if (ksize(dst) < bytes) {
+	if (ksize(dst) < ksize(src)) {
 		kfree(dst);
-		dst = kmalloc_track_caller(bytes, flags);
+		dst = kmalloc_track_caller(kmalloc_size_roundup(bytes), flags);
 		if (!dst)
 			return NULL;
 	}
@@ -1027,12 +1027,14 @@ static void *copy_array(void *dst, const void *src, size_t n, size_t size, gfp_t
  */
 static void *realloc_array(void *arr, size_t old_n, size_t new_n, size_t size)
 {
+	size_t alloc_size;
 	void *new_arr;
 
 	if (!new_n || old_n == new_n)
 		goto out;
 
-	new_arr = krealloc_array(arr, new_n, size, GFP_KERNEL);
+	alloc_size = kmalloc_size_roundup(size_mul(new_n, size));
+	new_arr = krealloc(arr, alloc_size, GFP_KERNEL);
 	if (!new_arr) {
 		kfree(arr);
 		return NULL;
@@ -2504,9 +2506,11 @@ static int push_jmp_history(struct bpf_verifier_env *env,
 {
 	u32 cnt = cur->jmp_history_cnt;
 	struct bpf_idx_pair *p;
+	size_t alloc_size;
 
 	cnt++;
-	p = krealloc(cur->jmp_history, cnt * sizeof(*p), GFP_USER);
+	alloc_size = kmalloc_size_roundup(size_mul(cnt, sizeof(*p)));
+	p = krealloc(cur->jmp_history, alloc_size, GFP_USER);
 	if (!p)
 		return -ENOMEM;
 	p[cnt - 1].idx = env->insn_idx;
-- 
2.34.1

