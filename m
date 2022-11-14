Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEA4628911
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiKNTQg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbiKNTQc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:16:32 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9B4264BF
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:31 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id g62so11922768pfb.10
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYvHeXAuVygr4ZcQHncrz4UIBOo5UsmMrsEx+4QLuhc=;
        b=fPYo/BT+M5gjOzRAA70Wb/DVvcXEx2jFAxcEZdoPz0VKxdcX4p3kz64r2zeTUZi9gl
         QDXlclg2eJj2a/bHwfDEl66G1e11MnxdbqM5cSLvJpf5LzW98d72SMbu4QgINKZoEqzy
         jSKInhrmIuBTv9SNCx17Nimk88jVjFSYMYVJFms1YL9ijZhNNOZ9mjAgEUQ2jaN4gv8Q
         lCHeU1C1mLBNKp2j/ct8Iks1/F9KnwhxulEufwoZTwbqhceFvMd+9SKu4/NAgaZJxwv8
         CjT+3zi8Q9K6cZVJqekDuqgCrR2W6FFjQvxIRkkkqIGIazSr41vas8rhAP8c0+k+06dK
         pf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYvHeXAuVygr4ZcQHncrz4UIBOo5UsmMrsEx+4QLuhc=;
        b=GgFVcx9L2YIbKW4uVfc8PO3prVIGS9PjtT1C2hrYyoSDagyJXcdYRJ8j3vjejWl+/A
         9pFnIxo7BM5DTrkIg3UAFdVIr+umHbNmzch94PLdLSpox0WnMs1LsOhex5zPDarddDSt
         b8VuAiCI7kBdztm+ns9UrcDUHvhsIycwQzPvlnzxv82dGubGg9r3SweAANJpLoq09sco
         pEQJPXyduCpt6anuJye2Z+hnpLtQ5yrn32hdbkJgEr4eY1/XPzn6y7pRrkkRl+2KW5Le
         8PqUdu3qofyWEKqeMAe0eYYR7rUiMmhJ4PjFgK7lWLplzeYGEjMCdXlTyBmRA/SLsRm2
         /w0Q==
X-Gm-Message-State: ANoB5pkZk3bQ2XNYmAodtbJ97G2LgJbZrq6yXI4sqB1iEFXYJK3s/AG9
        6cPVHkH/QdX1/BrG3JHagrMpBKO6V2ufQw==
X-Google-Smtp-Source: AA0mqf7bARKReq5MgRNPlsHgOqffQytDxVaPa/ZetEXebHStVc3SkdO8osZlxXW56i/CguwNrme/Sw==
X-Received: by 2002:a63:1a19:0:b0:46f:f4c1:7d34 with SMTP id a25-20020a631a19000000b0046ff4c17d34mr12946661pga.75.1668453390489;
        Mon, 14 Nov 2022 11:16:30 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090a441300b0020af2bab83fsm6899723pjg.23.2022.11.14.11.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:16:30 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 13/26] bpf: Allow locking bpf_spin_lock in inner map values
Date:   Tue, 15 Nov 2022 00:45:34 +0530
Message-Id: <20221114191547.1694267-14-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=memxor@gmail.com; h=from:subject; bh=vEeT2/iSWZHC3KMjxfZP18u7ktP/IseF8QZTy1MJn24=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPJHwor9e+vDGcaQsSs/hJmvUZYJzEVob7xslb7 HsZAtuOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyQAKCRBM4MiGSL8Rys7+D/ 9aHZAugrk/mRYwdbRDLBrP1EuqblnypI30UswomWd7kVV24T1cpQpzKn+J//tTYkmUx8N/2ePoYRfg JNh3DjIVrS//NFzSbr2fOgBqRNq9/dzVVkR4d/M01g/FT5xiOAhkcGfkhdavC2sINuWB1uIpR3x7hR 5kMPtOBzzA1G9Icq64YktVXL5xPcLs4oAYc8cWOEMautRfdyujsLNZFNU1WytLELEUKam6L1axSkVc 6SfgfBb+StMNDO4IiPVOdVyjCyUhFIa9NdC83Dg3VfP2MY6k3ZFNLscTJE5Jh9/xRgtwZ7zwfAM30E t60Py8U4psKPzqCmwegXQnM5K0lWhOisMEfpJ+JH424WchG40B64RrhrsYMJKeop1ubSHEbkzR68Y2 HW0PsFdZAzm9bwwcrA91KhJ4tstXqYyob6d4PICjWOYBHD/gRZWueOCq4B9HJwI7/aE9QwrioK0nlq EwZFJrx7bLklGGYN61GLYN8lf0ZobQ7VUcGsQrFyaijewMcxZX1NWCfdffb4T6DjvC9vN4gbhCM8y4 N2ndW+teDdj2MJDPuUdLHs7hH9E3a/+fwTtWyq+ZKAXqdHAhE5TTrp1tfJuKQyuJ67CnD0o20iKBrx y9ivSZakdRdGjM8Sr8b+Ac+scfyFTbq5FeEnE3uoXqLwTJqKE2mQ/IICL5Sw==
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

