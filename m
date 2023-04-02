Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87576D37B3
	for <lists+bpf@lfdr.de>; Sun,  2 Apr 2023 13:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjDBLnI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 07:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDBLnH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 07:43:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1D6F773
        for <bpf@vger.kernel.org>; Sun,  2 Apr 2023 04:43:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eg48so106728564edb.13
        for <bpf@vger.kernel.org>; Sun, 02 Apr 2023 04:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680435783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khdHooPVD4gdseBvwjWPXBkzVMncpOff1c5k6XwHx7I=;
        b=ihCwRlnLK/Q+cf3PVOGf41TjpINSmqEhgLylpUAVEBlQVtW+j6uqn1p0AdQRPe9MbQ
         fVKOrd8yV3dc5JMLKa1g6v+ZhTFLKTNw5ZzKchoCdrupUg2PGzXNGIRc4oQGGG4p5CjY
         DztOnghCg++uteKfih1i40dLgHmG8wyrt4ppe06084CHupZwC9xx2k/Z+/KdO9QFi79S
         inATmjlTvhu3FVgGta7874mnBOs3ndn51ltE9ZVq5OFKDdl5xecKbFOBKKX+wqRFiuI9
         /q/3Znq60jhCUoKqmvDXhxqQ/2noWZNUfj/QEB/e5Xz/ZpAqnjjmKvTFy6trpevS1Z8c
         OnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680435783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khdHooPVD4gdseBvwjWPXBkzVMncpOff1c5k6XwHx7I=;
        b=AcLpIiRWrA9peB7KiXguMl1O8noadEjwBPSxof2Ah0wVuCMML+pPz60WUuCSV6Azoj
         ubU+z8j+qQ8CabtR3FlA52WcHmdlGICSPjE9dk5noFUvrcc2CyKtB3ix7hs/Zl/b9XQ7
         2ClSVw1uRafF/RpcGhBN/vFd1tOAxpcR/Odr+5exmuk/2QRLDTp5DlWWIMldvddif/er
         jyb7nFWkh6bcLg+HC8vILl4DFu1LT3uVB0wEY01QKeB1zNfd4DY24R+gCwiuWeUOcnhD
         uQGuvmDtRWKS+/4Zr7/k4PZLaVaQnIjEd7v/aXl4EFkJL7S6O4AXjODUSImXwf86hLdk
         TfSw==
X-Gm-Message-State: AAQBX9dTtiXdHix7QUXaWWQOM8qSZVxg1RofWfn5VksklWj/WQUbx/2S
        DSoIBwGhC8Q+R4tX3sIwqBz2ccAplTOm0j0SyDLeHA==
X-Google-Smtp-Source: AKy350YGl8cKkc62FjWzG6g70uApwBtvgCkGM4UZs8txvMC4ADMjb7B4ufiZHRhanuDjme70cWW53Q==
X-Received: by 2002:a17:906:3703:b0:947:eafc:a738 with SMTP id d3-20020a170906370300b00947eafca738mr4625971ejc.60.1680435783625;
        Sun, 02 Apr 2023 04:43:03 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id p6-20020a170906498600b009321cd80fdfsm3129824eju.158.2023.04.02.04.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 04:43:03 -0700 (PDT)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next] bpf: compute hashes in bloom filter similar to hashmap
Date:   Sun,  2 Apr 2023 11:43:40 +0000
Message-Id: <20230402114340.3441-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If the value size in a bloom filter is a multiple of 4, then the jhash2()
function is used to compute hashes. The length parameter of this function
equals to the number of 32-bit words in input. Compute it in the hot path
instead of pre-computing it, as this is translated to one extra shift to
divide the length by four vs. one extra memory load of a pre-computed length.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/bloom_filter.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index db19784601a7..540331b610a9 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -16,13 +16,6 @@ struct bpf_bloom_filter {
 	struct bpf_map map;
 	u32 bitset_mask;
 	u32 hash_seed;
-	/* If the size of the values in the bloom filter is u32 aligned,
-	 * then it is more performant to use jhash2 as the underlying hash
-	 * function, else we use jhash. This tracks the number of u32s
-	 * in an u32-aligned value size. If the value size is not u32 aligned,
-	 * this will be 0.
-	 */
-	u32 aligned_u32_count;
 	u32 nr_hash_funcs;
 	unsigned long bitset[];
 };
@@ -32,9 +25,8 @@ static u32 hash(struct bpf_bloom_filter *bloom, void *value,
 {
 	u32 h;
 
-	if (bloom->aligned_u32_count)
-		h = jhash2(value, bloom->aligned_u32_count,
-			   bloom->hash_seed + index);
+	if (likely(value_size % 4 == 0))
+		h = jhash2(value, value_size / 4, bloom->hash_seed + index);
 	else
 		h = jhash(value, value_size, bloom->hash_seed + index);
 
@@ -152,11 +144,6 @@ static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
 	bloom->nr_hash_funcs = nr_hash_funcs;
 	bloom->bitset_mask = bitset_mask;
 
-	/* Check whether the value size is u32-aligned */
-	if ((attr->value_size & (sizeof(u32) - 1)) == 0)
-		bloom->aligned_u32_count =
-			attr->value_size / sizeof(u32);
-
 	if (!(attr->map_flags & BPF_F_ZERO_SEED))
 		bloom->hash_seed = get_random_u32();
 
-- 
2.34.1

