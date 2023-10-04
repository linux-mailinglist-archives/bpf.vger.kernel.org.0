Return-Path: <bpf+bounces-11410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4F77B97E8
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 00:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id BC1F61F23175
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 22:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842CC25111;
	Wed,  4 Oct 2023 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1p1zilIW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F301250F7
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 22:23:42 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E13EC6
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 15:23:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a22029070bso3489347b3.3
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696458208; x=1697063008; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LzX5wmLYyGVenVJvmQO+om+eWA+EBs8Xg6bCWmXIBDQ=;
        b=1p1zilIWrwSNTANPn5G0v5HRoO9ieIdCyRoZ2y5TUs4Zoj/KYvQPn5DRdzJ+y+HqEn
         PEot3QoYi9lkp0CkZRMVEsDqyXVs1jwRDaqbW6rPNVbljYsGZiKFsJaRJRS5sgXPdmz1
         bnTGa8kl1/WHAXgepXDpkmnV/W59yKpHJ2qcMHseoFiw7TYekiAlM2GrOYkp+Y+bAPK5
         sunIZL8eCph5unFqJX2M0wMILp0yvCLG0y5iEXtXwFinvbTWFQd8Z/e+wZdblcMTfGrd
         832u5tudEExvzGxhHW6RSycKL0jsHbKdCevJm5T8azlYuV15MfcqLaVABM/VGUXTMzVB
         erNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696458208; x=1697063008;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LzX5wmLYyGVenVJvmQO+om+eWA+EBs8Xg6bCWmXIBDQ=;
        b=u0tNnYDlf/oNRtfBiTgZat/UsuHTODQOsd738iOJc2xlFGY9GuvDZW1QgR6OZ7eOOh
         fXqHyyb/9YzeQBRN2T14tib7jKmXZOqOFmDAWowP0Tccg39HW+mX8HRsl+6rd9QV/5BL
         stY2ruUbqzOFK4v6TDWU1kGKVmzdh0zwxRUS5kvfJ7ltLVLtdntceBt2fmYkDiMjxRzk
         HVApdAX9+MDDNdNuUg7LlxY8ellRmYptqXNllWexEavkmXY6d+lyeptE/Hercptv5Ucw
         7lp+AAwFXcYqzs5W1Ip3GG/2C+ZPY/UVH4MBhi0HL+eCFPgrkp0pLdWoWv6gCV3/PZEa
         pMYw==
X-Gm-Message-State: AOJu0YwU3gOkTccRaPTr/ZIjqiI/55iBNeiuUOLpULkT0Yfq2WdL3IR0
	1n+F8IFRfMkrQLFP4nP+33LSFNt1lVjW
X-Google-Smtp-Source: AGHT+IHvF9BgEMqd3YfEZKmvnvOMOqNldSm6WrYskTN1Aec+uolfJJ3OTjlsrxKR9NYynPcHuWje6mMl7RUT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f42:a09e:8ee2:1491])
 (user=irogers job=sendgmr) by 2002:a25:dc51:0:b0:d7a:bd65:18ba with SMTP id
 y78-20020a25dc51000000b00d7abd6518bamr52326ybe.3.1696458208397; Wed, 04 Oct
 2023 15:23:28 -0700 (PDT)
Date: Wed,  4 Oct 2023 15:23:23 -0700
In-Reply-To: <20231004222323.3503030-1-irogers@google.com>
Message-Id: <20231004222323.3503030-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231004222323.3503030-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v4 2/2] bpftool: Align bpf_load_and_run_opts insns and data
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
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
index b8ebcee9bc56..7a545dcabe38 100644
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
+				static const char data[] __attribute__((__aligned__(8))) = \"\\\n\
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
+			static const char opts_data[] __attribute__((__aligned__(8))) = \"\\\n\
 		",
-		obj_name, opts.data_sz);
+		obj_name);
 	print_hex(opts.data, opts.data_sz);
 	codegen("\
 		\n\
 		\";							    \n\
+			static const char opts_insn[] __attribute__((__aligned__(8))) = \"\\\n\
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


