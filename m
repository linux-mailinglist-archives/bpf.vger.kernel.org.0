Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87C558DA10
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 16:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiHIOGY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 10:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiHIOGY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 10:06:24 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E4412755
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 07:06:22 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b16so15257399edd.4
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 07:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lA8aNYn5GcpEeBChVJr+v2FYW/hkhlzKAPSwDlrDwXU=;
        b=FgXsqU9K1PnETMkn4Toyb/NtI/8YGwkosJ6GlyV8kgfaKGew95s2JMDMYICcmZ6rH+
         vUIrGTwTA71whkW803vpyoE3PYBLjTPI109wd/c4R1sC6NHtubYcD+d9KNi5wTVCnZdC
         lAVhXa2N9IRzbWNNlNXmaQgp4lfA8Evn0w52ajQ9LyI/9W7T2Na1rkT99p1QLyWG5/bz
         pwzIpSpGKBt8Ih0NS58ddJek6Hcs7NSqKAhg9GROb7YbXUjOkqWciX80pUh/x/OuV6rS
         /ADM6TcKc26LxOIZSvc7bh6tlcB9xuYxp5KbR5sZPkVJNuehHpr146czGxHpvqB6yvJp
         GdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lA8aNYn5GcpEeBChVJr+v2FYW/hkhlzKAPSwDlrDwXU=;
        b=d1vzsuXCT2VE+OGUjGLXAQJSGp4Ioz0gyzLvt0B+63seX6IkvZmL+nOZ/nJP45oxBX
         1G/YGRqGdLqfXBzW06V7bhhWVm1l0HKGGiCxxpeLcxXTWDuRGvp4iEyol/o3A07YtiRG
         q/UqUbomW03sEvJSqiSx2Vo1s1Rl0amEYrWQ2o0o5Z+ZMr8Ne2nFvPWTV+3NbOS3Tsn4
         GcuB845+qhX05G6o+3nP2Ce9wecGJda694Q43IBi6p3hWMhA81hOvolrnDb3Pe8dl/zI
         Wt5OgaGiv60eY7rVvWq9r2bRqkEEk2WQjnXeNX9yMCSgEvZvaC1luCHoIQmwFigCp5Lh
         do+A==
X-Gm-Message-State: ACgBeo2uFrzP4hktCb7Sqs4aN+zcDjaLSRLZybj956V4WP1SXTSUkkAz
        YCaeV58T/FxfbSlO3b2NNGFbVKxToBo=
X-Google-Smtp-Source: AA6agR7udWP6JBlqLrbzyofNs/Z8ujSQgKeLZm6WaJ4rp3PRa08e6eL6KMqBMPCwFnLscTWcL6XRbw==
X-Received: by 2002:a05:6402:1211:b0:441:f8bd:dc92 with SMTP id c17-20020a056402121100b00441f8bddc92mr1411342edw.100.1660053980605;
        Tue, 09 Aug 2022 07:06:20 -0700 (PDT)
Received: from localhost (icdhcp-1-189.epfl.ch. [128.178.116.189])
        by smtp.gmail.com with ESMTPSA id la24-20020a170907781800b00730b3bdd8d7sm1167643ejc.179.2022.08.09.07.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 07:06:20 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 2/3] bpf: Don't reinit map value in prealloc_lru_pop
Date:   Tue,  9 Aug 2022 16:06:14 +0200
Message-Id: <20220809140615.21231-3-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220809140615.21231-1-memxor@gmail.com>
References: <20220809140615.21231-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2523; i=memxor@gmail.com; h=from:subject; bh=gE05QV4z9hT4P04L5K2fQdpjun7hubXc/rbqVKSbJ2k=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi8mm8PpHNT2gmMDsIypb/6lnUCES5kyv+sR9Z9GR1 1q4BY66JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYvJpvAAKCRBM4MiGSL8RyjCpD/ 9DH+8HC7ayfgxpPzbPVl0cpC8yva+OZcG9/uqYhI0Suo10CBiNjAGZtocs4KziSWKlTY/li2ymrPEm e6W4+k8ovHNR3Kp1GlblWC/E60R8uFgFhnc6ZJoyu7N1gNTVJPHZvFFkzyWTovhAfp6T2x9ImeEU+K 0n9rZ5+yaHOAB2Tx76AGIv8naumC/luwyxBICCZU40xP27Q8JjtXXcN8rH8crZBc/wkkrHEATE4HG8 0SDbt+UoFAHLkAXeSXBEPIGEgrRpLefCS1bov5MoV94Dt4uXlE7+X6YA6DgoMo6zmphnZq9RqnRpAq aECdxsuEeqqJVpvxSHl05ktqKZY2CPbP2jOCM1ziJ0YACcv5606CIe5Pm5zlysOVczZfl+CKh1bctm QQYB4ZU8WyXM127vEYdXRs/XrQ8xjgv2wbi7GDb4253LkDNGYUiWIhGK7JSRrwyXIUi2CiIScw4JDx 3hRrz6042WK1E4jijQSCC58++jxjoMOkOCRu6NqPzF3XppVD6Dz0bs8ZqRLmDCA6blOE8ZGbJtD/LV fGE5FDAcca8R86NarLqkRWtikeTB8E2uIDMsiFRw9lks/9wdBWLQJ9sq8Skg46ImkkZLw9knOMt4DP 4Q3273JbX/zMo3OI5iGeIaoqF/hS+UomOgJjTq9cG+bOp1X/GbG1G0bmHhaA==
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

