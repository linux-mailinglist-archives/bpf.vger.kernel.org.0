Return-Path: <bpf+bounces-11596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEB87BC4BB
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 06:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B0328200A
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 04:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505CA5394;
	Sat,  7 Oct 2023 04:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBv3h5ZS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE155252
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 04:45:06 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722ACBD
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 21:45:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9299cac11aso2962912276.2
        for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 21:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696653904; x=1697258704; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPsPdGtdKQ/v+DaiUF2STLjrD0JxItabAMPBxz4xd3o=;
        b=qBv3h5ZSjnKAZMcIR3rEeG8D9YBorLBnlRnH+5KnfHKBS/njECi+rzSr14+qRGsklf
         OA8RdosWCQCLkCXcBxB8kcS3RN5zjO+cXmz1DT6eI0Xkr53FJvXzsvxMrDHnQXYlSdnG
         MKYAD2nbqyZ61Nlbo/KyIuiCTyRoPE78HokmLxZlwM9wzigPoFzhzm4dHcA2vSZDV7lc
         BVQKApSCQEyfk7lHyBTflDKh88lfNvX/GjnDknT6gQFr7AaaybrEpok9ZUqwtW2m7iNx
         ets0NELxQBxspjtd53+OqhOPGcULjXiFdNz3WA07xBLO5nWk11MYLV2DXAS0cHeBQLAN
         BYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696653904; x=1697258704;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yPsPdGtdKQ/v+DaiUF2STLjrD0JxItabAMPBxz4xd3o=;
        b=gYl9gaJhk7jLPjsqYI75QFmFEiD9zQpJQP70bI0mHzQNaH2lOhL77sWyub9dz5hLLS
         ZS4BowFtLUcWuuT9en2ps+kuYPBuXWT0ntCCSG1IpMvEf5SosG6kDxvBF54P03KCYvKB
         wR857KJnf0PvRW28rtLZ1QgS1QOlu1g3uZHCQ8SAKJXI1ZHVkbQJMOsJg4JfUcAP/0ka
         7m+1wb7X/nZ8O6Z/KZl4P0uLcSqpyW6Qz8r1Fx9qf6t3WvxXHnuzc5AVDYwyghuDuZki
         tGEfufLYghAEaLOzPQleEd/bRxVj0IbG9CmheMlD4gq8kXwiPIr4JQE7dpnxVX1zisqg
         AlvA==
X-Gm-Message-State: AOJu0YziiNGvadFZrcVhdK4XCp6Bob5jkOLekK5RcOTXiqfJvPVJD3qp
	5zRgzJ1nzVhxo1BKNuMEcU2hsgYWM1NO
X-Google-Smtp-Source: AGHT+IHzbgs54ou2YatAT0qKH8s7DIqxUdn8GunFexNWDbAOBMS09tyfscwUD2Nf5+CdRIxy28Y311Twj5CM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7031:b36b:6c77:bfd0])
 (user=irogers job=sendgmr) by 2002:a25:248:0:b0:d8c:cc9b:81cc with SMTP id
 69-20020a250248000000b00d8ccc9b81ccmr148880ybc.3.1696653904627; Fri, 06 Oct
 2023 21:45:04 -0700 (PDT)
Date: Fri,  6 Oct 2023 21:44:39 -0700
In-Reply-To: <20231007044439.25171-1-irogers@google.com>
Message-Id: <20231007044439.25171-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231007044439.25171-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v6 2/2] bpftool: Align bpf_load_and_run_opts insns and data
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <quentin@isovalent.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Smith <alastorze@fb.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A C string lacks alignment so use aligned arrays to avoid potential
alignment problems. Switch to using sizeof (less 1 for the \0
terminator) rather than a hardcode size constant.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/gen.c | 43 ++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 882bf8e6e70e..ee3ce2b8000d 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
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


