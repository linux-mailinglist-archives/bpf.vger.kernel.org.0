Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8274AE974
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiBIFqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:46:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiBIFnW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 00:43:22 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8150C033254
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 21:43:26 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso4192233pjg.0
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 21:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qDd6O2Hs1f+j69m+PHz/HDfRMdHuvEJ3v5002RScnFs=;
        b=koimXrkp9MHL5RqfPXfIpSSBasRJiAPwqIerL6bTHMjqd7qomw0gFc2QSTzYV75mQD
         O709qbkF9UJFXPJt/KhzPvUbJMy4Y8CnqtR+YOOXIV5f+JuiLBoN1AiNmMJ+1Jj8wdnM
         SmuBNUdqeKjXPChc4OdENJ9X5/qzP2JtiUsDB7LofBxgyT8AF+OFACXcXxXGKjlbuY9Y
         FZNyeFw3HxBks98Boiq9UIeZcfq9vn/10JX1FmgGdW/NfWo3s0Pe+sIh7OVOhaUQLuOS
         JA1ZkjvcmCEeDbaHV55rRP2+cw+txJNdr2zjsN4MMC3ctaw5VSW0ZPDu36VyBehlbk3v
         SI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDd6O2Hs1f+j69m+PHz/HDfRMdHuvEJ3v5002RScnFs=;
        b=3NRYhTfEt2X9LggaQHAWSj2bS3yWDfCUGhQa96sEc7e9a0hVKkgPyg4cqn1BV9gAAE
         EFhHQpyMJmfYi913cUv/zCDYVHAVkdwv0E2CY64ebkt3ati7o5zYKfTz5gmXYxKV2Pm4
         Llhcg1O+3Yw6phqfzbAjfWLsRYTRMnDEt8CcP08HnL1/i1FXgtbH2CR4ONni6hNU4gvM
         yDVfRn+Wi0WMSGVBHpgmQW7W+r6nt4jucfQYhV16GdQH9ZRJElK9X4PmwXHydWXdd94k
         q3DIxOm8zvnZ+f2CzMV5ySaRwCxHOOthpH/uDwVB/jlE/1Xxsk/PaP7NTp9a1uA27Mms
         Y1HQ==
X-Gm-Message-State: AOAM531wAEHgQgIYM6/aPq3CmdVoY+g4mMz0WZukT2ia1RE7v31upHn6
        frfX1LqP9BaJYEbDWnhQSM22MidfS5Y=
X-Google-Smtp-Source: ABdhPJwVGLxl8zc7fA1QRj12ODZj6eCiVB+Djc5+yPUFfv1+IQr49dZDplPqqjWBUQfptmgEAYcJ9g==
X-Received: by 2002:a17:902:ec82:: with SMTP id x2mr647708plg.139.1644385406141;
        Tue, 08 Feb 2022 21:43:26 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:cbf])
        by smtp.gmail.com with ESMTPSA id z13sm18344717pfj.23.2022.02.08.21.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 21:43:25 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 3/5] bpftool: Generalize light skeleton generation.
Date:   Tue,  8 Feb 2022 21:43:13 -0800
Message-Id: <20220209054315.73833-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220209054315.73833-1-alexei.starovoitov@gmail.com>
References: <20220209054315.73833-1-alexei.starovoitov@gmail.com>
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
 tools/bpf/bpftool/gen.c | 55 +++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index eacfc6a2060d..9e0b45bdc5cb 100644
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
@@ -544,18 +544,14 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 
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
+		printf("\", %1$zd, %2$zd);\n"
+		       "	if (!skel->%3$s)\n"
+		       "		goto cleanup;\n",
+		       bpf_map_mmap_sz(map), mmap_size, ident);
 	}
 	codegen("\
 		\n\
@@ -592,6 +588,24 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
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
@@ -611,14 +625,21 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
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
+				goto cleanup;				    \n\
+			",
 		       ident, bpf_map_mmap_sz(map), mmap_flags);
 	}
 	codegen("\
 		\n\
 			return 0;					    \n\
+		cleanup: __attribute__((__unused__));			    \n\
+			%1$s__destroy(skel);				    \n\
+			return -ENOMEM;					    \n\
 		}							    \n\
 									    \n\
 		static inline struct %1$s *				    \n\
@@ -751,8 +772,6 @@ static int do_skeleton(int argc, char **argv)
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

