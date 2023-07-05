Return-Path: <bpf+bounces-4065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0418A7486C8
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 16:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37862809DF
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 14:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3955111BA;
	Wed,  5 Jul 2023 14:47:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856173233
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 14:47:45 +0000 (UTC)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0AD131
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 07:47:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1b8a462e0b0so10273605ad.3
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688568463; x=1691160463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLgXET5GN50Vn8yz0ucBvMMOL5Vw+DEQS5xWCgueJ3o=;
        b=O6D+34fCUUEpbd5WTwJTRH5y5N1MeiWOZcziAh0K118RL8RZeYWyLkn714yx6z2p4R
         QXchQdh1btJxCeCqTmKPiim+DbQc0KW85vBCvyrXjbLu0orAyd3gonYQ5V2lDLETgm5q
         icGSbf03cIixjtfMU+KbvVW49CZ05DFAzt80EuV9jIQ4eoVzqAh9F59OF7pArytBm5VR
         OLL4kmf5GizplQaYx7QMu/cBOsEWHgU3axwg+d3746jjlsMpTDLHCNxVQFEO2vyvyVxL
         OkfbzLxUJZ0Pfn9weouiAzFsXZ3RMkj2q1IUZKsj7H1IOCXvtXljTLeZ96BclOc8UIwC
         1yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688568463; x=1691160463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLgXET5GN50Vn8yz0ucBvMMOL5Vw+DEQS5xWCgueJ3o=;
        b=kKcMhVsI7lfl5p8nniHc+VJ2k0fUmwZGWZKstmP1mhIqUK1QrND4PNpOR5K+QhQSb7
         q64u8Tu3pKGDiSds7RrXkG39YU9igyJLSBYKX2g9rcisfBoHkJyn/U5a7arYm7E01elb
         bQ+rO3d0Ed64v2Ry+UA28hWR+KDHqVi42qsy57kM1yAFuvExX1Q4itTLaFKlpMp7EeVA
         c8m15dVM2b9LEwuEZSJJICIjEftYRfm0uD+k8roAJ9FAGh1PgmzVTJXTIu8OoZeHaVOf
         Ix/0gzN/tnaNIo2/7lCyn+NL/P1lpCb0WTxFoM7VCMZS1hNnvCSZJI1xh+Fn41Zl3zOe
         FmWA==
X-Gm-Message-State: ABy/qLYscdoZy2QBmS++DfiL+nXlscMLjUH+sGqaxy36tv3mGfbjq7PH
	aHSgr/laeRPb/fHl+JwZQPDIRjRdRyRPt6o+
X-Google-Smtp-Source: APBJJlHB/IpmTMAvQIEnUlL9KXxlrOns5qWNkSsWJ9mSxOGwz2HUQ+6POwXSJDE3xArM+881RtbU1A==
X-Received: by 2002:a17:902:e845:b0:1b0:6c10:6836 with SMTP id t5-20020a170902e84500b001b06c106836mr14974051plg.33.1688568463141;
        Wed, 05 Jul 2023 07:47:43 -0700 (PDT)
Received: from localhost ([49.36.209.255])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902b20400b001b85a56597bsm10917157plr.185.2023.07.05.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:47:42 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf v1 1/2] bpf: Fix max stack depth check for async callbacks
Date: Wed,  5 Jul 2023 20:17:29 +0530
Message-Id: <20230705144730.235802-2-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230705144730.235802-1-memxor@gmail.com>
References: <20230705144730.235802-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030; i=memxor@gmail.com; h=from:subject; bh=Ee8gRv5X/5pH0jZN2VrHE0zNKVstwLXYEYOysRbKFeQ=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkpYFoSuD39iaY8V4MoFBptFmwR0ePYb3yLmyE4 cQHjJlRaxaJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZKWBaAAKCRBM4MiGSL8R yoXsEACUvOML7cGLEMdjLqUtAvHEqkrfzcW9nF8VOO8apjI6n/fXss9910ApsA5FIpXhIhu1P2g afZ84jt6rb3SQ/EnWPuhe5zqwn+cfwzNrXaHqJ/nRdpkQEQEhqxCByJLQ5fOu6v3ttlVCBhcrSn 2G4ZrgNJdY/HCxp9cIFy1aG098OlTZ9a0tipENIcI6FSAPf8HbtXDmEkWyOwd/6FhaxYyy9Y10O 3X0q0W+HQv5tgccJFKd7qERuJfHfsMA8hSRvcyJWcxBbt4n6/PVubvmQBwiRJriQ2hcA++nrr3X b2etSU4NAl77Vv25qI1yC6GUInmXTerYcmEnbym1aoCP1hZZpAUeJrdH7Pl8z4kU8f9qM4fmn+n Ci4S68vUZyQIjB0lsxdO0WfTPI6qvTFeADfqMSRmRKMgAPO0uHgaws/zMkv8f9XhGusfADw3dYr v8ghgDqqAK6pfNd3HOUy1j96zVTgvuAT9Fy/+Z3XkFOpK5mALGWMxlffoPlY+adoPNpp0U2g7fF UvnNmV90T/PZHsnmWUbKiCUNF/P6qsYaSRduX29fNaJMNoVNdVEuQq1NgYrLhyMWuT2jWOTlwPk ++Bkw2EJ5V71qkiR7uVlKlu1XyFFq6RnzM8sQWepBCV0ChJAqAJ81rFGzEtbVyVxykGefO5v8Ua Qn8rdfqNA5XSWXg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The check_max_stack_depth pass happens after the verifier's symbolic
execution, and attempts to walk the call graph of the BPF program,
ensuring that the stack usage stays within bounds for all possible call
chains. There are two cases to consider: bpf_pseudo_func and
bpf_pseudo_call. In the former case, the callback pointer is loaded into
a register, and is assumed that it is passed to some helper later which
calls it (however there is no way to be sure), but the check remains
conservative and accounts the stack usage anyway. For this particular
case, asynchronous callbacks are skipped as they execute asynchronously
when their corresponding event fires.

The case of bpf_pseudo_call is simpler and we know that the call is
definitely made, hence the stack depth of the subprog is accounted for.

However, the current check still skips an asynchronous callback even if
a bpf_pseudo_call was made for it. This is erroneous, as it will miss
accounting for the stack usage of the asynchronous callback, which can
be used to breach the maximum stack depth limit.

Fix this by only skipping asynchronous callbacks when the instruction is
not a pseudo call to the subprog.

Fixes: 7ddc80a476c2 ("bpf: Teach stack depth check about async callbacks.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11e54dd8b6dd..930b5555cfd3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5642,8 +5642,9 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 				verbose(env, "verifier bug. subprog has tail_call and async cb\n");
 				return -EFAULT;
 			}
-			 /* async callbacks don't increase bpf prog stack size */
-			continue;
+			/* async callbacks don't increase bpf prog stack size unless called directly */
+			if (!bpf_pseudo_call(insn + i))
+				continue;
 		}
 		i = next_insn;
 
-- 
2.40.1


