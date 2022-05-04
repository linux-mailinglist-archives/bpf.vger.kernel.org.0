Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910C251A521
	for <lists+bpf@lfdr.de>; Wed,  4 May 2022 18:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349930AbiEDQTO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 May 2022 12:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353288AbiEDQTB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 May 2022 12:19:01 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE501C93C
        for <bpf@vger.kernel.org>; Wed,  4 May 2022 09:15:24 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id eq14so1167818qvb.4
        for <bpf@vger.kernel.org>; Wed, 04 May 2022 09:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mdaverde-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRTT3Khcb1rZ/aGFwRbPNDE/jeWlp1F0NgwR7yaPUME=;
        b=MVEwt4lEQ6odj4JoF+ekWEO601myqPUssVHGiuBUWjYeEk+C9+mjc+l5YmEzVre3wm
         oPHisIb2b7rw3Vl1n0uzeWrxDQ2jd+MZfaZQ2mO9wbchYzPrHzE5tXh1hEdD0neRiBWs
         t63roERMr0X3TbTo3+J/O0aWy0hzRNzyEqrrG9pZ1yIKBX0zorrkDwbAFY1IxQO1sZ1k
         x/LWIhGKSHkg4sKxgV6ZkpA1y4SEiVYAAnCuzTXZmaHUjl8O3dYpodQ50sZKuN4FVz3n
         vaMmLwN9gXgsCLUZSo8hf0yWnVJLeq7oskBqjm2qTnmEvnXceq8Cl5mERkSrwlWNY9vH
         mZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRTT3Khcb1rZ/aGFwRbPNDE/jeWlp1F0NgwR7yaPUME=;
        b=OI8ClnujdTiR4QZsv33FdeZNmiV7xSK8BFXHapvyIvD5pksy1NW41ADkwNt6vJcMPu
         3YcuvC9Bmv+xaJBtEkWNt7L5TqDV4en/tQScM6TRWRw66ya667Gt9NOMzfNrJwZbsbjH
         LUqFDA9d9lkzRSX/sKf6546rSd90NZbR5ldkVZ8bB27k3GVsu/9VQgBqAUrxVR1Y01Z/
         n7u9efe+qpiTxj/y7nWy6KkxPn0mDJqrSZZBjvTSL3M/tbTBKTaBeimrcl9VK8K9zs+1
         GTtXMZiXUcQGD9WKDN3SNyy5KYk9dOSLjwmxuq1u7Olk8X7SjJP5AyJhRrIn+u4g4Pzd
         r1iw==
X-Gm-Message-State: AOAM531z59d5g5RtiEsnhJKeW8ekGPpsE7QtlJxOvs4KtHocxfIK+u9C
        oAAUrY9cYk1DB4pE5V92eDs1ww==
X-Google-Smtp-Source: ABdhPJxVYo/IWIg5lLnfnd4q5/JBFnRFyOg9pQqgHLIhnd2mJGMlex3zVNr4pwIGyKX3YYDu+DyO5w==
X-Received: by 2002:a0c:f1d2:0:b0:45a:8012:1a90 with SMTP id u18-20020a0cf1d2000000b0045a80121a90mr16256965qvl.31.1651680923269;
        Wed, 04 May 2022 09:15:23 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:1d10:5830:4611:5fd6:ef88:7605])
        by smtp.gmail.com with ESMTPSA id 18-20020ac85652000000b002f39b99f66dsm7594467qtt.7.2022.05.04.09.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 09:15:22 -0700 (PDT)
From:   Milan Landaverde <milan@mdaverde.com>
Cc:     milan@mdaverde.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Paul Chaignon <paul@isovalent.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] bpftool: output message if no helpers found in feature probing
Date:   Wed,  4 May 2022 12:13:32 -0400
Message-Id: <20220504161356.3497972-3-milan@mdaverde.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504161356.3497972-1-milan@mdaverde.com>
References: <20220504161356.3497972-1-milan@mdaverde.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently in libbpf, we have hardcoded program types that are not
supported for helper function probing (e.g. tracing, ext, lsm).
Due to this (and other legitimate failures), bpftool feature probe returns
empty for those program type helper functions.

Instead of implying to the user that there are no helper functions
available for a program type, we output a message to the user explaining
that helper function probing failed for that program type.

Signed-off-by: Milan Landaverde <milan@mdaverde.com>
---
 tools/bpf/bpftool/feature.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index c532c8855c24..d12f46051aac 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -690,7 +690,7 @@ probe_helper_ifindex(enum bpf_func_id id, enum bpf_prog_type prog_type,
 	return res;
 }
 
-static void
+static bool
 probe_helper_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 			  const char *define_prefix, unsigned int id,
 			  const char *ptype_name, __u32 ifindex)
@@ -723,6 +723,8 @@ probe_helper_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 		if (res)
 			printf("\n\t- %s", helper_name[id]);
 	}
+
+	return res;
 }
 
 static void
@@ -732,6 +734,7 @@ probe_helpers_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 	const char *ptype_name = prog_type_name[prog_type];
 	char feat_name[128];
 	unsigned int id;
+	bool probe_res = false;
 
 	if (ifindex)
 		/* Only test helpers for offload-able program types */
@@ -764,7 +767,7 @@ probe_helpers_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 				continue;
 			/* fallthrough */
 		default:
-			probe_helper_for_progtype(prog_type, supported_type,
+			probe_res |= probe_helper_for_progtype(prog_type, supported_type,
 						  define_prefix, id, ptype_name,
 						  ifindex);
 		}
@@ -772,8 +775,17 @@ probe_helpers_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 
 	if (json_output)
 		jsonw_end_array(json_wtr);
-	else if (!define_prefix)
+	else if (!define_prefix) {
 		printf("\n");
+		if (!probe_res) {
+			if (!supported_type)
+				printf("\tProgram type not supported\n");
+			else
+				printf("\tCould not determine which helpers are available\n");
+		}
+	}
+
+
 }
 
 static void
-- 
2.32.0

