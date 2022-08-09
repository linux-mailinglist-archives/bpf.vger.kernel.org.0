Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCA058E1CB
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 23:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiHIVbG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 17:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiHIVal (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 17:30:41 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197C94C61A
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 14:30:41 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j8so24423078ejx.9
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lA8aNYn5GcpEeBChVJr+v2FYW/hkhlzKAPSwDlrDwXU=;
        b=kHX86bBweqvJFE69S7vTCv4d17JVFScqK+R9BQO2CmHMx7UbgLMOADTvjwkUjNLyb6
         ouAb4tGDWN3JzoWW2k82ysCSJavgO0HNFJSh7aXyBIMguXHdq5SxZli65GtQnGLHm3Ex
         PHWDzRNb3Ei9Nthu+5QnUu9Ij3TKLiCHd18n+cGt63o/ek5bwXCdoSaV1JBnX3FJBbjD
         pgn0dSBw49u6l1Y0dno1tKvZ6972rTYAxK6hv3RtnbM4bXmZvXv1lQkYzqYKrquFTNAM
         9dclYoG6kBTq1whaoyu7F5pZvvwW9FrRK2e7ncZW9ls8yI+aOitR354G1TFwQuzBdptd
         MK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lA8aNYn5GcpEeBChVJr+v2FYW/hkhlzKAPSwDlrDwXU=;
        b=jc1rzK87uitsrMT6SBJRlAjV1rzh7KQ/xYpn/cLsC3XZu9fBwRLFFmN4jC1Bs9YJwG
         aC0wV0PCedvY2t3ebIVJff1iZoYA/Gd/FlSkfV+M5Px219tkIiKattNn0e6qWFhbkiOA
         M0PGOba/43MyORnOK7uaz5GKuKuvjYVEDnc2MfLtUSrnhEYr+IWgmHZYP1f/wo6+Jtzn
         lWEXaBnAMoweOBS7ioz9BUOTQYQWsiU6AcFwgkdQBxrhmilv4M+KH0GMwYhWZWECr08y
         PH0R1m78QHwAWxPvq74hbXXCXImdK7S4gKOYffM3tDWvG3sNEKAWf0A1UJVYIx/DCNbT
         YKdg==
X-Gm-Message-State: ACgBeo00xLbabOQaC3w/zLuv2bLgTpKfAH5CmihpxKk7LTjOpFPh19RW
        EKTKfea6ix3tm4wttvZprnFO/3w5r2U=
X-Google-Smtp-Source: AA6agR6ljG5bLY8cBqf6ZAS/1AOJiyacTxv4e0kwyCnJn4Ll/ZtBpA6MXWZm7diKK/mLYBaAiJBdKg==
X-Received: by 2002:a17:906:8a78:b0:730:7a4f:fb36 with SMTP id hy24-20020a1709068a7800b007307a4ffb36mr17968367ejc.624.1660080639330;
        Tue, 09 Aug 2022 14:30:39 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id e6-20020a056402104600b0043d18a875d1sm6557264edu.79.2022.08.09.14.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:30:39 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v3 2/3] bpf: Don't reinit map value in prealloc_lru_pop
Date:   Tue,  9 Aug 2022 23:30:32 +0200
Message-Id: <20220809213033.24147-3-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809213033.24147-1-memxor@gmail.com>
References: <20220809213033.24147-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2523; i=memxor@gmail.com; h=from:subject; bh=gE05QV4z9hT4P04L5K2fQdpjun7hubXc/rbqVKSbJ2k=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi8tHvPpHNT2gmMDsIypb/6lnUCES5kyv+sR9Z9GR1 1q4BY66JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYvLR7wAKCRBM4MiGSL8Rysd5D/ 48D5AMld8xF6r4AHhKMsCPsL94WAZ9XoKBsFf6/6V39bubLKilzhB0HyzAJNMHFBt4uNcej/vRGcXU 61VNKD2EEjksw9h/n250Sjrc/73HTwzzLjdxO7cH5d6aNqVOtOyMRQwO9LChhNYunCRuX7gyFspf6N Tb09EYgCEKDKTjguutqL6ZmtQPg7YrDtgPXftaURcqGbBl7ZyNOyD/LQE3c4vqhDrAfIQOhgjVCSiz pnnioRKqRUAQnBVZYA47cU1uGLYyZnAIdJ/X1Xpb2fFhRpWsIjwiPvm3rDBQYYc8+x/u/KJJFNvgz+ PduRVMWAL2e4mqdhitTqATSra/bGjr0R3+Hr1PWQYMOfmDlOT83/CWw5PmHP25LrlsGKU+VNaXze/q oUbOkVUj5U0WooPlPBo/8CdwdewCAzvjqmjmMBw5q01Tk200g0+EcSm3Saddc82Aoo3NZEfV+EvjVC LmkIJPTWEVwJyMtp2foyTzAzZQ3Iy+m056TS5XwulKYoQ3MsNfKblx3KDJUXsDBapvThIZ8RbqO1o2 Da96Kyh8yRAAg1s3aWr704VA5DsCg3DNQFKLkwAIVEt1/7Ih6IkPfQnEWhc1IZmG3oKN0eKAzFndkG 32F/WuJBl/2BxreKFH4kSJqtuwxDAXOtsEpTeR1PCW9O9HKq+aROe1VBz0MA==
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

The LRU map that is preallocated may have its elements reused while
another program holds a pointer to it from bpf_map_lookup_elem. Hence,
only check_and_free_fields is appropriate when the element is being
deleted, as it ensures proper synchronization against concurrent access
of the map value. After that, we cannot call check_and_init_map_value
again as it may rewrite bpf_spin_lock, bpf_timer, and kptr fields while
they can be concurrently accessed from a BPF program.

This is safe to do as when the map entry is deleted, concurrent access
is protected against by check_and_free_fields, i.e. an existing timer
would be freed, and any existing kptr will be released by it. The
program can create further timers and kptrs after check_and_free_fields,
but they will eventually be released once the preallocated items are
freed on map destruction, even if the item is never reused again. Hence,
the deleted item sitting in the free list can still have resources
attached to it, and they would never leak.

With spin_lock, we never touch the field at all on delete or update, as
we may end up modifying the state of the lock. Since the verifier
ensures that a bpf_spin_lock call is always paired with bpf_spin_unlock
call, the program will eventually release the lock so that on reuse the
new user of the value can take the lock.

Essentially, for the preallocated case, we must assume that the map
value may always be in use by the program, even when it is sitting in
the freelist, and handle things accordingly, i.e. use proper
synchronization inside check_and_free_fields, and never reinitialize the
special fields when it is reused on update.

Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/hashtab.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index da7578426a46..4d793a92301b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -311,12 +311,8 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
 	struct htab_elem *l;
 
 	if (node) {
-		u32 key_size = htab->map.key_size;
-
 		l = container_of(node, struct htab_elem, lru_node);
-		memcpy(l->key, key, key_size);
-		check_and_init_map_value(&htab->map,
-					 l->key + round_up(key_size, 8));
+		memcpy(l->key, key, htab->map.key_size);
 		return l;
 	}
 
-- 
2.34.1

