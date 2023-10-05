Return-Path: <bpf+bounces-11483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C13E7BAE95
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 00:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BA57A28245E
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 22:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3961B43680;
	Thu,  5 Oct 2023 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYswqO6J"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C7541E45
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 22:03:33 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8CFD8
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 15:03:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8b2eec15d3so1912689276.1
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696543410; x=1697148210; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVyzgez16PpY3NCo1AOr8fto/XvcbmDay0gklILgDzE=;
        b=IYswqO6J+SmFD9DG+x6HgQL2SYH4r5NPT0OHxnaXvJeMgEpARUYKbWGeMNEmEgSY4K
         XtWZ59GDUzgo8G+ChlOdqYX+4Btc4YASULsF3Ggm0q7690AwN07qUy/SJoHvcqdn6OXs
         aHBW+l+KKd76kTv8+/poGxalkomK85gnWcXe/jxE1TDxi5fz0frVcjsQ2VPaUwIsoU7I
         Fe/pTtqxArCfzNaOhkT1ydYp9Dr7Y820jp+HHIwF8FV+lHxH7e0IPqt9isD88+8EYGay
         lPjEfqXj/mlBYn0aWuKwm40amj0wUDF2fidz1MUjaFYyFKrsdcZCefK0jG3jAJzE323P
         2kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696543410; x=1697148210;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mVyzgez16PpY3NCo1AOr8fto/XvcbmDay0gklILgDzE=;
        b=xR9sZEEaKM4ELVpoedSYjSRapR0rZoxgMoeu36jZ4R/8bDgZ+kaTJSHkv/9uMutBe3
         pLApB4R9auVmn74lAWcyhEgNbaTK2zzA6GZgIsouMKb1TUZ0HRiG9Z3HdXX4xVzqrmW4
         x8Y2AmrC75yS1km/tZEkVURBvEIJZI1jy1hlmUhOyvzccCV5DpJVuukIUdcD/JWVlJo8
         Eab9GjvWRIqvv+RdzAQie3+LFkYKwiw5M1XCrnWvAnUxirfedAM27XXZpeltm/h2jEC9
         ZQkbhW7PiE+FkFWpqEgiglO1gDDPejOQRRWMTNp8flm63f9C+v+f4sFR/s26nkwpCN/Q
         bgMA==
X-Gm-Message-State: AOJu0Yxcz/HzpzQ1z8JXOuZTqLSuTcnM9oO3y+OssZEh5eBqLRYVl4b1
	w6yWQfTl1oblqig9qYjUmj6unLUq2tA5
X-Google-Smtp-Source: AGHT+IFzGQ7/u5GAMNrdTuQZOM1fzUztDurt1lna0A99CvX1ih1Jeqr/kZ1vBVk0V7ny/McibUOziYwOwkV8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:e002:0:b0:d80:bea:ca87 with SMTP id
 x2-20020a25e002000000b00d800beaca87mr102852ybg.1.1696543410782; Thu, 05 Oct
 2023 15:03:30 -0700 (PDT)
Date: Thu,  5 Oct 2023 15:03:24 -0700
In-Reply-To: <20231005220324.3635499-1-irogers@google.com>
Message-Id: <20231005220324.3635499-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005220324.3635499-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v5 2/2] bpftool: Align bpf_load_and_run_opts insns and data
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
Acked-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/gen.c | 43 ++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index b8ebcee9bc56..bcd26946d10e 100644
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


