Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219E7626203
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiKKTd6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiKKTd6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:33:58 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3C91D66E
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:57 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y4so4987344plb.2
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYvHeXAuVygr4ZcQHncrz4UIBOo5UsmMrsEx+4QLuhc=;
        b=JYbPeRSHU/80WEiCO32CR3dSg8Ez470M5OHfO68M3G4w51ogjFbpyLXyVQFAdeswwH
         YIWBRAg4ZK7EYx1PFaXBrAwop1aAOoG3CMuC4ixH6MSrf0SHdbxh8uSY2w3HIWm8onjX
         CYdL1VZoJ7LbUmDOdlwWiM1cG70UwpYa4Tw9pthyh3BcjlhcDV0V4RE9R2TXJ1w3ENU8
         fw3dZ6fnk/f+3DoRNUvb4SFoOf56w8FypJi/glAW6bY3FlKqbafel1x5BiAY6wCc+TKf
         zcttDPCPOp7rt7isoptfQgCXvvf2ZzIuv7bA9bqREy8QWdGqJCrN6aqqhO6ljk7cK3rn
         BHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYvHeXAuVygr4ZcQHncrz4UIBOo5UsmMrsEx+4QLuhc=;
        b=WJw5OTQazweV/oxcw7CdT2EyntkFBw6C9gn8T9UNv1Ai9he3P2ZeH2UCCyjC5rqFP+
         LsWbblsED0OP9+Al9sGZ5EjimNVMWoas+THLILQGf74am5ZkqHyKdBQEZNorpZ1QWw/n
         YeKcsAD4FxndWs6Y7XbfO4AV8VLS0agZmvgfYesJRY2W5skS0ui3Iqdd2xZqfQajWA5E
         faXI2CDDDjeRtaQGBvIYI86eFMwJ1xyF1I4sHcCkZnjF+KjqPElOvp4XDB2ZJEb6VSCc
         HxarnM1VXGCoyPBDt0rFgFlTCCjOteBjV/1i+UaX2CIDpwGhjl5H/KWlbVBiV45NPmH/
         IXMw==
X-Gm-Message-State: ANoB5pmibsUz7u4mkQ3hYAtlexeunWVtnWaaD68e5O0d69gUTvan32j4
        0m/W2n3zuw6e4TOuiCBziWjE50q7lLTfuQ==
X-Google-Smtp-Source: AA0mqf764e53X/4OxLqDS0jvroyN6qzuwZZuHVrDAkgN0ixFZB0KJarF2XAVxkod5YTOeIT4g9i4aQ==
X-Received: by 2002:a17:903:25cd:b0:188:4f86:e4d5 with SMTP id jc13-20020a17090325cd00b001884f86e4d5mr3793831plb.16.1668195236684;
        Fri, 11 Nov 2022 11:33:56 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709027fcd00b001871f532cf9sm2045692plb.286.2022.11.11.11.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:33:56 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 13/26] bpf: Allow locking bpf_spin_lock in inner map values
Date:   Sat, 12 Nov 2022 01:02:11 +0530
Message-Id: <20221111193224.876706-14-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=memxor@gmail.com; h=from:subject; bh=vEeT2/iSWZHC3KMjxfZP18u7ktP/IseF8QZTy1MJn24=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqIoHwor9e+vDGcaQsSs/hJmvUZYJzEVob7xslb7 HsZAtuOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iKAAKCRBM4MiGSL8RyvS+D/ 9fZJv4CFdTzpCSSZj8RgMhIkuNs6Yifw54whIwBJg6sLHesXesBm/lWQ1/yx1bsGFdXsMQtxWFet/d wHQoyO6ZzfLye4YV1fFJvZFyyx+w194n0LY3Rkqiut7+NL/UBQw2LufhpLwPxI7KRNqfNBLmdTe49D iDNHgtRR9hUPO61l5zjsg0U4pXIjtldVFd2AXJJHkO6Gcos48l14wRuQ9Ei5BmTaFUqhoyA1MubAgx SXRZB7vCum63NV/Cf8KbmP1wUgF6oQa2wzdwKdj/Olng3/CRTjXqHFKrdYoL8QKgwFLxQN9okJwo4B G6IdeO+6AUQlqPYRkqfkbtmQtSFk0Xth0YbKyZAgyoacZA1mRzr00atRiX7K1bO48HGELHfn6ZYcRb UElXRlFE6SxFEcyKUlaSzoYR/j8RRuGXUBl62dNXDHLCXab0HLPoW1lfsuRyVSGBoVTjwlLvqwMtSR EJYtA78wzGmCAE91OYtNCHLS/sQJok4ozeQhT1gqu28cDjRmJ2Sge0f+QYCWE+97682hN+Ec1cpDsY 5qXsUqs2y/NyfGueb+RcaC93l5CBpRQ6ovqjC7vAf1/qHhhohSxLpkMS80PudG/fEO/G91nG4kmEuC SbPiVYZCE8/zm3/wMpXK7kb2271PHMY2CviMwHRTxEkS1ynA0tRu4HQ/LUFg==
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

There is no need to restrict users from locking bpf_spin_lock in map
values of inner maps. Each inner map lookup gets a unique reg->id
assigned to the returned PTR_TO_MAP_VALUE which will be preserved after
the NULL check. Distinct lookups into different inner map get unique
IDs, and distinct lookups into same inner map also get unique IDs.

Hence, lift the restriction by removing the check return -ENOTSUPP in
map_in_map.c. Later commits will add comprehensive test cases to ensure
that invalid cases are rejected.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/map_in_map.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 8ca0cca39d49..f31893a123a2 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -29,11 +29,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		return ERR_PTR(-ENOTSUPP);
 	}
 
-	if (btf_record_has_field(inner_map->record, BPF_SPIN_LOCK)) {
-		fdput(f);
-		return ERR_PTR(-ENOTSUPP);
-	}
-
 	inner_map_meta_size = sizeof(*inner_map_meta);
 	/* In some cases verifier needs to access beyond just base map. */
 	if (inner_map->ops == &array_map_ops)
-- 
2.38.1

