Return-Path: <bpf+bounces-11300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B00F7B7196
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 21:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 44B14B208DA
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 19:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ECD3CD02;
	Tue,  3 Oct 2023 19:15:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F4F3CCED
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 19:15:10 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1B5AB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 12:15:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c09bcf078so20975407b3.1
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696360509; x=1696965309; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6N4htVJIGGb5h3erLQS3Hd93PuTJER9wVr3iHSknNQY=;
        b=UFcwdhuuCbyuM9r8KJhOm8K7BhN5+pS+CtOGM3l/0IvsEnA1tiC2mnu9jFWkcHE/Kb
         TWEYpPbi2vdIyHbih0y68SHVGdX6K2QTn+EQWvNGfdUAInEbMZg0SHy/cTNiZCum7tXg
         mQFUVSoBm2LnKHNel8V6j1Otww5Tcp31ZCaws2QrQgLBbhg/k6kcfND8goBaLj1wwlk6
         pRXsQtmbmzdiNHPnjbBbqbfZnnYwgljubGwP8Czu4QITDq2qq+2KLPxTddEvDnACl1Jc
         WtufP0K18NXD+QJtLRj6uwJm7lMiVYV1coCOjKbBac1DZXa69AIb9LUuz23i6K45F5iu
         /gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696360509; x=1696965309;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6N4htVJIGGb5h3erLQS3Hd93PuTJER9wVr3iHSknNQY=;
        b=kYEDoGkqLw3rZA2iQmmTXZwQ7QMa2GM/8N/MBvr0e5x+L293/iJg7v+pBAh29f16TM
         cQPe4gSLb33dNNO18viQVkUUkyHemvzWOqLEjHi+4PMAX+jUQ7KCbp+9gGwwfjIX1+cv
         Qp18rVJhi0wPgm4KWbP466z3TLVsb+5o/rnPexF42/gLRTTHJlwbdq1yWJG80WVunh2p
         KhENzn52xBFCQc4Sh2Z8XD88/K0xHvlRi2DO2oMi/ttLSMVg3kfxzDET+toJQa3usPLW
         vjgLEJAl33atXSo0YrogSRpFkt8teKzQ/alH1nY4t3otNusonAd2m7knuFzx/E8VSL+/
         nd6Q==
X-Gm-Message-State: AOJu0Yw7n2NWYV53gLmDRLqcAtTF9CQbZ7hZp1v7ZSdth3cUib6mbZOS
	BKLZoiaWfuZptRH94V8uci/363IekTW/
X-Google-Smtp-Source: AGHT+IEYZ1pBWCmXLN1j2N35fPF2rv8nARnMlWixIYVn+j22HysMgdNODZ6bnzSYzPGqFXn01/UUVNBsXHhZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:51d:1f25:c2d8:4514])
 (user=irogers job=sendgmr) by 2002:a81:d444:0:b0:59b:ebe0:9fcd with SMTP id
 g4-20020a81d444000000b0059bebe09fcdmr9061ywl.7.1696360508657; Tue, 03 Oct
 2023 12:15:08 -0700 (PDT)
Date: Tue,  3 Oct 2023 12:14:12 -0700
In-Reply-To: <20231003191412.3171385-1-irogers@google.com>
Message-Id: <20231003191412.3171385-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231003191412.3171385-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Subject: [PATCH v2 2/2] bpftool: Align bpf_load_and_run_opts insns and data
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
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A C string lacks alignment so use aligned arrays to avoid potential
alignment problems. Switch to using sizeof (less 1 for the \0
terminator) rather than a hardcode size constant.

Signed-off-by: Ian Rogers <irogers@google.com>
---
I was unable to find a test case for this part of the codegen using
Linux perf and libbpf tools code bases.
---
 tools/bpf/bpftool/gen.c | 43 ++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index b8ebcee9bc56..e9a59b254c66 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
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
+			}						    \n \
+		", ident, bpf_map_mmap_sz(map));
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
2.42.0.582.g8ccd20d70d-goog


