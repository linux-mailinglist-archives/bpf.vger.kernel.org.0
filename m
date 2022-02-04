Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B3D4AA427
	for <lists+bpf@lfdr.de>; Sat,  5 Feb 2022 00:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiBDXRX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 18:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378004AbiBDXRW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 18:17:22 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FA7DFDA6F3
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 15:17:22 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v4so1124319pjh.2
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 15:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Imcqa94K6qmkHgNev/2e7jXS6AGjkc6K2IMNqaaw6eM=;
        b=FfqwNDqQSwCQ1YJXqcggO0CtYlh8W/0NWfQ3PtOoP7W0u8nXCrE9yug1UCALNCgndq
         vndh0fwOAvgmoJPZ2ktncpMGdv0odWK59PtMdX7Izdfsfli56WdDSXbyOlB4z/R5lCrf
         ZUuV284nVZzRI204VEa9FwSLUulk3t/dWypuvfKYQ2fTELPp+SHrwr8vVk9sP5jD00HQ
         qg5yDvBpmh0ow20CDvcOnO5W/5BLhkdKw1xcEz/lZ/HjaAl9gIIpU6GnCTKbPYw/X63B
         GHLw2bTzmtlYVCddcZQM9thtpHGKJQ03gTcwNV6e7DNGNAx6U1/5ksbO+YdGY2+mz+qe
         qs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Imcqa94K6qmkHgNev/2e7jXS6AGjkc6K2IMNqaaw6eM=;
        b=g3CBJfFM8+sL/BvtbbJGujM11AaTe8yXLN9KerfJyWndQ21cUjI4QZjKiKk6Iu/nLP
         7vHCR1uEEPX/CDfyWhtWvOocxnffwyMlhQTx6D8HXZUEEnM66B5aACDqnq6ZkGi30bSj
         DKGEOVK5K5Rky3B4N2n/jx3FoxbvA4W/91Pj6H2upU+5BmQ0N7lIVUcYz2L9WDMQilLs
         Xs3dWKmVgVftFqZawhwgh8zmoyrz4QyNInZ9eLH8v8lgwZ3Q+CS0sILccCwaNm7beNTj
         LQO8SosL8YGuFtc0DbMEtZ/PA3R9RxFXLXIxOG3ydqZorORwSvMxmxoHDvIFJa9nV1C2
         YQHw==
X-Gm-Message-State: AOAM531CQOuvFN5er0hRDjrEH0eE2QnscutFV8LXeL64gPyJgzvXlAez
        lH+mrExj488EYTURqc0RY9M=
X-Google-Smtp-Source: ABdhPJxWOCTR44LY1VeUBnzj2LZbbJWMDPGZDILUY567eHNNFoC6suHBGn3iP3r83dxHArAeXA8bnw==
X-Received: by 2002:a17:90b:1187:: with SMTP id gk7mr3760759pjb.199.1644016641774;
        Fri, 04 Feb 2022 15:17:21 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:e4ee])
        by smtp.gmail.com with ESMTPSA id lj14sm7931576pjb.45.2022.02.04.15.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:17:21 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next 3/5] bpftool: Generalize light skeleton generation.
Date:   Fri,  4 Feb 2022 15:17:08 -0800
Message-Id: <20220204231710.25139-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220204231710.25139-1-alexei.starovoitov@gmail.com>
References: <20220204231710.25139-1-alexei.starovoitov@gmail.com>
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

