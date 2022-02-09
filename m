Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E9D4B011E
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 00:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiBIXUY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 18:20:24 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiBIXUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 18:20:17 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E696FE06A60A
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 15:20:12 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso522225pjb.1
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 15:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d/pfInyWzHhLX7qVlbRTVmblefgi/6AR2+KaR8dBVpk=;
        b=UIxY1vkpq3sYwGSCbucy3N6gHsmgs9/DeMUBxL2va+twTCcJDnIV3N/GmDgutWrmCm
         I1OXVsgMZunxBR14dlRlmsngHeYE4pOk1Wvwc4rHVwwf7m7bI4aer8t3oaoRV67z4Kyc
         yMJfRrZ2uy249Z1iCD9zJoaIfOgSmORswHFCaVr8KyZhA6rd1IVuKMUjGu7ZVZwWmce4
         AL59wN+3tGKyWCveYRAggqMVtyrgw6n36GKKR+noqJUjOcJ0+QeXAWbMWYN8N8LW4Wdm
         nuoHsWcupQQQ48vOEWsRVcUazPwRUvmnPZ0VmxjffNuGiPReHVwNcgajyga2Y+UlKbBc
         BHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/pfInyWzHhLX7qVlbRTVmblefgi/6AR2+KaR8dBVpk=;
        b=o5yzFuM/piKdLgk4W0xvFOm4z9Jq7xiQJebweIsJXTXG9Sg/NSo+jg5u5fhL3QS8tD
         BrMIzpBgiA/c1uDQadqLwVE0V7P1FTRqtCVMnVWZN1xplSh7rQauy7StAcHilm8YpW93
         7pl8ieW/3jYyx73xWuc3FxiIL5ba91MkmAbgtybMgZfmHQ+CAe9lOqd7tjmiJ08hnUzm
         KEExrTCT13dEOJuAPKhBI/3MvY1Lr78zwbrkjakE4NIRUb2ORpaGuPFWbTg5rpoJKiH1
         TZvRanvh9hS1oe5v3qfkK528mp6+FIEvH2XAuAlXZ1+TvQIhg8k1zmotOwfl78ZIydnq
         0ffA==
X-Gm-Message-State: AOAM5324r5d3U6n1370JYJqCg5UElsiPLWcSipd2NBzJphX8uz8GORfN
        oKww5dZn1L/VltJiWOtMV6M=
X-Google-Smtp-Source: ABdhPJyYb8WzXlHiXw4DE/VNDQ2y0fBLqOFBUwYnwETSCRLZHhZhLTVUp7+pABiURVGwD5fzzgUmhg==
X-Received: by 2002:a17:90b:3908:: with SMTP id ob8mr5249072pjb.73.1644448812358;
        Wed, 09 Feb 2022 15:20:12 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::2:9eba])
        by smtp.gmail.com with ESMTPSA id h27sm14780409pgb.20.2022.02.09.15.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:20:11 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 3/5] bpftool: Generalize light skeleton generation.
Date:   Wed,  9 Feb 2022 15:19:59 -0800
Message-Id: <20220209232001.27490-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220209232001.27490-1-alexei.starovoitov@gmail.com>
References: <20220209232001.27490-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
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

From: Alexei Starovoitov <ast@kernel.org>

Generealize light skeleton by hiding mmap details in skel_internal.h
In this form generated lskel.h is usable both by user space and by the kernel.

Note that previously #include <bpf/bpf.h> was in *.lskel.h file.
To avoid #ifdef-s in a generated lskel.h the include of bpf.h is moved
to skel_internal.h, but skel_internal.h is also used by gen_loader.c
which is part of libbpf. Therefore skel_internal.h does #include "bpf.h"
in case of user space, so gen_loader.c and lskel.h have necessary definitions.

Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/gen.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index eacfc6a2060d..6f2e20be0c62 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -472,7 +472,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 			continue;
 		if (bpf_map__is_internal(map) &&
 		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
-			printf("\tmunmap(skel->%1$s, %2$zd);\n",
+			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zd);\n",
 			       ident, bpf_map_mmap_sz(map));
 		codegen("\
 			\n\
@@ -481,7 +481,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
 	}
 	codegen("\
 		\n\
-			free(skel);					    \n\
+			skel_free(skel);				    \n\
 		}							    \n\
 		",
 		obj_name);
@@ -525,7 +525,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		{							    \n\
 			struct %1$s *skel;				    \n\
 									    \n\
-			skel = calloc(sizeof(*skel), 1);		    \n\
+			skel = skel_alloc(sizeof(*skel));		    \n\
 			if (!skel)					    \n\
 				goto cleanup;				    \n\
 			skel->ctx.sz = (void *)&skel->links - (void *)skel; \n\
@@ -543,19 +543,18 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 			continue;
 
 		codegen("\
-			\n\
-				skel->%1$s =					 \n\
-					mmap(NULL, %2$zd, PROT_READ | PROT_WRITE,\n\
-					     MAP_SHARED | MAP_ANONYMOUS, -1, 0); \n\
-				if (skel->%1$s == (void *) -1)			 \n\
-					goto cleanup;				 \n\
-				memcpy(skel->%1$s, (void *)\"\\			 \n\
-			", ident, bpf_map_mmap_sz(map));
+		\n\
+			skel->%1$s = skel_prep_map_data((void *)\"\\	    \n\
+		", ident);
 		mmap_data = bpf_map__initial_value(map, &mmap_size);
 		print_hex(mmap_data, mmap_size);
-		printf("\", %2$zd);\n"
-		       "\tskel->maps.%1$s.initial_value = (__u64)(long)skel->%1$s;\n",
-		       ident, mmap_size);
+		codegen("\
+		\n\
+		\", %1$zd, %2$zd);					    \n\
+			if (!skel->%3$s)				    \n\
+				goto cleanup;				    \n\
+			skel->maps.%3$s.initial_value = (__u64) (long) skel->%3$s;\n\
+		", bpf_map_mmap_sz(map), mmap_size, ident);
 	}
 	codegen("\
 		\n\
@@ -611,9 +610,13 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		else
 			mmap_flags = "PROT_READ | PROT_WRITE";
 
-		printf("\tskel->%1$s =\n"
-		       "\t\tmmap(skel->%1$s, %2$zd, %3$s, MAP_SHARED | MAP_FIXED,\n"
-		       "\t\t\tskel->maps.%1$s.map_fd, 0);\n",
+		codegen("\
+		\n\
+			skel->%1$s = skel_finalize_map_data(&skel->maps.%1$s.initial_value,  \n\
+							%2$zd, %3$s, skel->maps.%1$s.map_fd);\n\
+			if (!skel->%1$s)				    \n\
+				return -ENOMEM;				    \n\
+			",
 		       ident, bpf_map_mmap_sz(map), mmap_flags);
 	}
 	codegen("\
@@ -751,8 +754,6 @@ static int do_skeleton(int argc, char **argv)
 		#ifndef %2$s						    \n\
 		#define %2$s						    \n\
 									    \n\
-		#include <stdlib.h>					    \n\
-		#include <bpf/bpf.h>					    \n\
 		#include <bpf/skel_internal.h>				    \n\
 									    \n\
 		struct %1$s {						    \n\
-- 
2.30.2

