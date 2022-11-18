Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FF562EB7A
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiKRB6t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241040AbiKRB4x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:56:53 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F8173B9A
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:52 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id y4so3329167plb.2
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI0cSLMpOLZbEZfTLKGuck/t/mpojqsult6wbsm/RSE=;
        b=kSFuOorTdTkEZlonT4XUOwCRAi2dhlKkJkQgTZadMEazBgCJOvdVGFeyIv9UNAsdZZ
         KN9M18PMSx6h5GVGnmNBnfOvZ8KQhD3UyhpjWz6yAazcTmoP/JLPyAKx6ysGp3+sjuwW
         pwzvORnKJvDBbyk6wi8iH1NPmbE8PhSvHA/P6hv97OPrV3Fa1xSJnPs/2DZBauyCvNHZ
         gKzV19no2bv+Ltyuiw9i3MF7gqhTXW/XpzAA8NoK9DhLsKfHAY5DRwYU9QBwth6wjg4X
         1XJbjsOX+NeG9T2ekej6JTRbZGHhxueHHD/UMCFk3ieFaEzf/P9LvnkSzBT91z+XE8JP
         iIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI0cSLMpOLZbEZfTLKGuck/t/mpojqsult6wbsm/RSE=;
        b=pNIQpbiiYu4npApi6dvrt1vaHkapwJsi6svHxwd2ruX+KYW1j/u9Z9WjXflACgGA7K
         ERnIjYZiWdNd5l7e5PtivMmjM6fLTtrGSCgbRqwHjE9sGpzSUB9srJe8cMpN2m+2wbuW
         ElhyO63tGuQRQx+lgqJdMG0akc+BRQHxOs2M4ngn9TMHL5ouc6wPRPTEfyWeldyalpF7
         /90XBf5uTW5pC/IVN1K5u7kOqyCsdk471AF8n2ExjSuHFgbfUdDRNvBe47ODuUaHT9mT
         bGUnGLkA+YfbXk3qnSQkJt6kCluyvIaILPw81lJr+rx88U/kOcOYw3Uq37gmbll8IOir
         zbxA==
X-Gm-Message-State: ANoB5pkg7Byv6MXXqWmbHw/+P+FRoFhp8fjQ56E0b1x1d+XRdm+y3Juj
        AtZYUfwSGJMvE8BBv+Ar32vADu1cQLs=
X-Google-Smtp-Source: AA0mqf76FywigXIkJHzroLRiXdlnADI1u/hAMXaOvCTayE7soI3R28WT/EBvEA5L6EVpPe2a+rT5Pw==
X-Received: by 2002:a17:90b:354e:b0:212:e307:b59f with SMTP id lt14-20020a17090b354e00b00212e307b59fmr5471069pjb.208.1668736612150;
        Thu, 17 Nov 2022 17:56:52 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id z24-20020a62d118000000b0056cd54ac8a0sm1788191pfg.197.2022.11.17.17.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:56:51 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 10/24] bpf: Allow locking bpf_spin_lock in inner map values
Date:   Fri, 18 Nov 2022 07:26:00 +0530
Message-Id: <20221118015614.2013203-11-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=memxor@gmail.com; h=from:subject; bh=P1undU+At1PLzL1SYYwDyVj3bpoUrN/Ux1z3PCPdpx8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXOGd5ei57JxekHdh/Q140Pjn7yTFd8i7NCFmoN wsh9V0OJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzgAKCRBM4MiGSL8RylNeEA Cxlg3orpkfvIAskPmxgn1HKiYoPJMgUUDFZTjBCn3P4Nr8Sl7+3MVDTMsOrVWswnLsDsfdVX+ouNiU e1PBXFJ4X5QULzrxs0awh5MADJfI2ZOcDbbwmW+l8LRisdME2SY3n5rSvhf2Py7dZeSSm/59W7z31J qeM8gvYNsE1M7sZNtg7RX28w6M7TLS36x3j9EI5ELfqOgWrLFketHYe9sUOYhk28cuarp5zR5P52ND ngf5sNEgM9UYR2SCKZdHN8Q6xXv/LvDTY4Po2JDzK5iTayVhcr9YlBMQxTAquEXm0yWSrt5SANOhbp CVcnqVB7VAWnLouCAmfA4RGh7uhEEMTw43R0x/ZmPNpcRyJQqAK+D4T8qDYr7/uYqqU+0tMXsRITQU OcmAvtgyfcFcnZGWcQpD2huHPnieL8xYKs1pv9sN8Lgr+EizsP50rQ5e4tbrnAe5O8/pScc1r3nFqF 4N3oW85dfrq96eg/lMuT0CO/UUcofDsRxRVOZFHuQaJNFBKrHwA9CESRewQY6ByLYZxbjgWUR0yGmP ZKmrKiCK943myK7wWP3YzvD3fxtO+Pl4tdZbNtrDEOEk+jRE26XNsmDBqKh0J7vmGB35dxto2RbDCM /EZYd17qeIejA+vO4nsbJqcsZKGA7f7K+bb9ehw6LHYwfQtNVX6IgudxV2Ww==
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
index fae6a6c33e2d..7cce2047c6ef 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -30,11 +30,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		goto put;
 	}
 
-	if (btf_record_has_field(inner_map->record, BPF_SPIN_LOCK)) {
-		ret = -ENOTSUPP;
-		goto put;
-	}
-
 	inner_map_meta_size = sizeof(*inner_map_meta);
 	/* In some cases verifier needs to access beyond just base map. */
 	if (inner_map->ops == &array_map_ops)
-- 
2.38.1

