Return-Path: <bpf+bounces-11405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D57B8E3F
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 22:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 31BE11C2090C
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 20:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619D122EE9;
	Wed,  4 Oct 2023 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xoJ/4GCC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524F22F0B
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 20:43:59 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF17DD
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 13:43:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7ec535fe42so400847276.1
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696452236; x=1697057036; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=62TaHeKznYGJNCCBRaj8AgsGHCErkYyX8npqYRMhtgg=;
        b=xoJ/4GCCvARflY83Xzl/+LuHonxdBfiLWf8Cf5mFmzqP1HYL2wBDu/L84XIvxm0n+z
         NWYTYk0L1qh/XQ0/2H3rDiw1Yd6cjgogPUS24mQJyCIsosU1Ob846qmhfJUOdrCCfc9k
         1M+Ss139+t/sfmDKi5atuHFpBzQTHoj+ZmZWjdfnXVMr1nkmDeK2fga7D3aaSum4wHAs
         ZTpYk/0k9vvkOolwmtV2wj444G4bojJwVR/zhBMNaBNPGrX89xo1TMBRBgbmD+ylXQcJ
         i5ZRtCHQAkJGwf7lv7WAjidWW65CvlkRuHs1ek1Aa/MWVc4fuOgKoz/lHIuA4sVhwyUd
         pPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696452236; x=1697057036;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62TaHeKznYGJNCCBRaj8AgsGHCErkYyX8npqYRMhtgg=;
        b=Dmu8VTsPikp4957OqVmo3BCkDd5IB9OChR3sPvDo5g5FnrrQz4bgX0YR2Zv43bh6gI
         n44B7sGo/JwRbh2Fk4iTEdxnzg0Vbfvbk60XrD9Zpp+s+YwP7OOOuc7L18xd7IAjwoel
         38U/0G7xPfAi+6QFIoJNqoU23zJHZHP+iFig6PURkbWniUFhm+C+6BZZoCde2TdppnRb
         xKS+3Ds+POmsuRcBJ8MDA6GLe4EreoyAQeQ2ttDN2T91mxNWp17nvC99THg0AqysEnu8
         0xzlJsL1bI8Qji/uUF1XXaxukGgcdmP+RDbjH/kEn5LfcztZmlb14NZjHnX1gBrkxW1f
         r+7g==
X-Gm-Message-State: AOJu0YxJD6cb2Bb8s019pDJhmqRCofGLBqND0qFZWkm6Vo9kEZXbRDxS
	fhCmAu1RG72vjafzD4VHz5SsSZqJ8RMp
X-Google-Smtp-Source: AGHT+IHnS2q4BQaNebBUwC8Wa6GFTLy93u8/Au3kJwkZeXtUpMl/qENTslwujnEYg/SeROm1frLjDzvPM40A
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f42:a09e:8ee2:1491])
 (user=irogers job=sendgmr) by 2002:a25:b18f:0:b0:d86:55b7:97b0 with SMTP id
 h15-20020a25b18f000000b00d8655b797b0mr53834ybj.9.1696452236615; Wed, 04 Oct
 2023 13:43:56 -0700 (PDT)
Date: Wed,  4 Oct 2023 13:43:34 -0700
In-Reply-To: <20231004204334.3465116-1-irogers@google.com>
Message-Id: <20231004204334.3465116-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231004204334.3465116-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 2/2] bpftool: Align bpf_load_and_run_opts insns and data
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <quentin@isovalent.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A C string lacks alignment so use aligned arrays to avoid potential
alignment problems. Switch to using sizeof (less 1 for the \0
terminator) rather than a hardcode size constant.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/bpftool/gen.c | 47 ++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index b8ebcee9bc56..8c36c96cd692 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -408,8 +408,8 @@ static void codegen(const char *template, ...)
 		/* skip baseline indentation tabs */
 		for (n = skip_tabs; n > 0; n--, src++) {
 			if (*src != '\t') {
-				p_err("not enough tabs at pos %td in template '%s'",
-				      src - template - 1, template);
+				p_err("not enough tabs at pos %td in template '%s'\n'%s'",
+					src - template - 1, template, src);
 				free(s);
 				exit(-1);
 			}
@@ -708,17 +708,22 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 
 		codegen("\
 		\n\
-			skel->%1$s = skel_prep_map_data((void *)\"\\	    \n\
-		", ident);
+			{						    \n\
+				static const char data[] __attribute__((aligned__(8))) = \"\\\n\
+		");
 		mmap_data = bpf_map__initial_value(map, &mmap_size);
 		print_hex(mmap_data, mmap_size);
 		codegen("\
 		\n\
-		\", %1$zd, %2$zd);					    \n\
-			if (!skel->%3$s)				    \n\
-				goto cleanup;				    \n\
-			skel->maps.%3$s.initial_value = (__u64) (long) skel->%3$s;\n\
-		", bpf_map_mmap_sz(map), mmap_size, ident);
+		\";							    \n\
+									    \n\
+				skel->%1$s = skel_prep_map_data((void *)data, %2$zd,\n\
+								sizeof(data) - 1);\n\
+				if (!skel->%1$s)			    \n\
+					goto cleanup;			    \n\
+				skel->maps.%1$s.initial_value = (__u64) (long) skel->%1$s;\n\
+			}						    \n\
+			", ident, bpf_map_mmap_sz(map));
 	}
 	codegen("\
 		\n\
@@ -733,32 +738,30 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		{							    \n\
 			struct bpf_load_and_run_opts opts = {};		    \n\
 			int err;					    \n\
-									    \n\
-			opts.ctx = (struct bpf_loader_ctx *)skel;	    \n\
-			opts.data_sz = %2$d;				    \n\
-			opts.data = (void *)\"\\			    \n\
+			static const char opts_data[] __attribute__((aligned__(8))) = \"\\\n\
 		",
-		obj_name, opts.data_sz);
+		obj_name);
 	print_hex(opts.data, opts.data_sz);
 	codegen("\
 		\n\
 		\";							    \n\
+			static const char opts_insn[] __attribute__((aligned__(8))) = \"\\\n\
 		");
-
-	codegen("\
-		\n\
-			opts.insns_sz = %d;				    \n\
-			opts.insns = (void *)\"\\			    \n\
-		",
-		opts.insns_sz);
 	print_hex(opts.insns, opts.insns_sz);
 	codegen("\
 		\n\
 		\";							    \n\
+									    \n\
+			opts.ctx = (struct bpf_loader_ctx *)skel;	    \n\
+			opts.data_sz = sizeof(opts_data) - 1;		    \n\
+			opts.data = (void *)opts_data;			    \n\
+			opts.insns_sz = sizeof(opts_insn) - 1;		    \n\
+			opts.insns = (void *)opts_insn;			    \n\
+									    \n\
 			err = bpf_load_and_run(&opts);			    \n\
 			if (err < 0)					    \n\
 				return err;				    \n\
-		", obj_name);
+		");
 	bpf_object__for_each_map(map, obj) {
 		const char *mmap_flags;
 
-- 
2.42.0.609.gbb76f46606-goog


