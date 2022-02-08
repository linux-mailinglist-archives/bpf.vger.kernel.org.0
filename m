Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9144AE201
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 20:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385896AbiBHTNW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 14:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385647AbiBHTNU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 14:13:20 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907DDC0613CB
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 11:13:17 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z35so177450pfw.2
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 11:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Imcqa94K6qmkHgNev/2e7jXS6AGjkc6K2IMNqaaw6eM=;
        b=WhHwMVMwPjza6VuLYbwUUsPEb4XQQ2WA+VXiZikUEunjhLv9SFXwdNLCZQs1f1ia8b
         gZYJVFro9fErOHZHD2yA/kRL37mjVjyNwIlxVVI2T8QYwhqHBrB0dbk0e8Gr0OjW31Xo
         UejDyHpEvVOo1TWDczUYTxydoISwxi5e2CAjCdjnCSWZJgGOne/MGW/njeaBPlSHk99j
         K3qVcdoCGN/gZnyjb/eMSHiFL5s5PF5LyXvm/qdOwu+qDtZhpP4E2Nn/O7c+gkzcmPSD
         LI9jiQkSSOJGvu/o31AnScvlEAyNUNDR+TuYgNAcC3Oa+CxYSzyOmXMhpct8p0uSe7xh
         IZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Imcqa94K6qmkHgNev/2e7jXS6AGjkc6K2IMNqaaw6eM=;
        b=Cdiz2LnYvyQs7JmHn6w5NqXW9nh4aHcd2KqhmLN48cuqQ7LpHrgGKEEYMT+T7nkhoL
         gVBi/BI2aH8lwm4rxCl0fWKwB+GcOEzVcsBo+l8L1reUEjvZRry3C7/nkGwvArBc5evT
         lsLEahNkRwpNNNiq0LP+i31yr74Bkxjn5iMOfM9dY6Ss4BdgRwJsseZm9ISZ9GpHSMr8
         3sTX6kFg7QMPRyFCRmSfmJL078XUfhxC5fGSVitxBWIl39oDfHxzeK5DwacnOxXs0Ru/
         AzyDzsDQR1V0faM3ik/UyGvkYU525pE7ST4Yj+ZkrHh/UCuCxcQdFkrlSJQt2Ls66Fwd
         tNkw==
X-Gm-Message-State: AOAM530uOkWma36hmBgOwVxmATE9RmOOu9xlVwpzALsydt+EytUzrwBj
        Y+Pltj+/DtP7kv/yCR/DIVCpPNTCmmA=
X-Google-Smtp-Source: ABdhPJx5XUfrYs+GJppXTzij6c1gDSVE0DLisYhgozzfIiX13yFcZI/pxzfsf5jLKbzxQz3R5wea3Q==
X-Received: by 2002:a05:6a00:8c5:: with SMTP id s5mr5884723pfu.34.1644347596986;
        Tue, 08 Feb 2022 11:13:16 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:500::2:72b2])
        by smtp.gmail.com with ESMTPSA id j8sm3541080pjc.11.2022.02.08.11.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:13:16 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 bpf-next 3/5] bpftool: Generalize light skeleton generation.
Date:   Tue,  8 Feb 2022 11:13:04 -0800
Message-Id: <20220208191306.6136-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/gen.c | 45 ++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index eacfc6a2060d..903abbf077ce 100644
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
@@ -544,18 +544,12 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 
 		codegen("\
 			\n\
-				skel->%1$s =					 \n\
-					mmap(NULL, %2$zd, PROT_READ | PROT_WRITE,\n\
-					     MAP_SHARED | MAP_ANONYMOUS, -1, 0); \n\
-				if (skel->%1$s == (void *) -1)			 \n\
-					goto cleanup;				 \n\
-				memcpy(skel->%1$s, (void *)\"\\			 \n\
-			", ident, bpf_map_mmap_sz(map));
+				skel->%1$s = skel_prep_map_data((void *)\"\\	 \n\
+			", ident);
 		mmap_data = bpf_map__initial_value(map, &mmap_size);
 		print_hex(mmap_data, mmap_size);
-		printf("\", %2$zd);\n"
-		       "\tskel->maps.%1$s.initial_value = (__u64)(long)skel->%1$s;\n",
-		       ident, mmap_size);
+		printf("\", %1$zd, %2$zd);\n",
+		       bpf_map_mmap_sz(map), mmap_size);
 	}
 	codegen("\
 		\n\
@@ -592,6 +586,24 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	codegen("\
 		\n\
 		\";							    \n\
+		");
+	bpf_object__for_each_map(map, obj) {
+		size_t mmap_size = 0;
+
+		if (!get_map_ident(map, ident, sizeof(ident)))
+			continue;
+
+		if (!bpf_map__is_internal(map) ||
+		    !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
+			continue;
+
+		bpf_map__initial_value(map, &mmap_size);
+		printf("\tskel->maps.%1$s.initial_value ="
+		       " skel_prep_init_value((void **)&skel->%1$s, %2$zd, %3$zd);\n",
+		       ident, bpf_map_mmap_sz(map), mmap_size);
+	}
+	codegen("\
+		\n\
 			err = bpf_load_and_run(&opts);			    \n\
 			if (err < 0)					    \n\
 				return err;				    \n\
@@ -611,9 +623,8 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		else
 			mmap_flags = "PROT_READ | PROT_WRITE";
 
-		printf("\tskel->%1$s =\n"
-		       "\t\tmmap(skel->%1$s, %2$zd, %3$s, MAP_SHARED | MAP_FIXED,\n"
-		       "\t\t\tskel->maps.%1$s.map_fd, 0);\n",
+		printf("\tskel->%1$s = skel_finalize_map_data(&skel->maps.%1$s.initial_value,\n"
+		       "\t\t\t%2$zd, %3$s, skel->maps.%1$s.map_fd);\n",
 		       ident, bpf_map_mmap_sz(map), mmap_flags);
 	}
 	codegen("\
@@ -751,8 +762,6 @@ static int do_skeleton(int argc, char **argv)
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

