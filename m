Return-Path: <bpf+bounces-11404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 678CC7B8E40
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 22:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CDEE5281CD0
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 20:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEB622EF0;
	Wed,  4 Oct 2023 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZruWNVAf"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E2224E5
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 20:43:56 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C6ECE
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 13:43:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c09bcf078so2572027b3.1
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 13:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696452234; x=1697057034; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=raoMQ3SQ/7ZFelkz0l8EiT5sUCvEdkA2km5MKOLJhzo=;
        b=ZruWNVAfzd3QgvkZtWTdyvtnZEJ/B7pM4jN0z0HZxlWk+mwvz7456s9KFrrQPQRHOk
         LTa6ERqV72R5E/BXJd9g5pz14+Gc1jJWyG4+7MALIHuECmS5Bj/Hxr56ANyfylSrtbvF
         HIGw0U0HgxCYVKMufVSRhcadxW9hix1r3dcJvgEJQIfSRGQMbXp2UD2/Fdy5wNgarMMJ
         ozKLY9bQ7+GkT0uZGY9Ev62GIFzhcbVEIK8gFo6UQdgKGdplu3o2HFIOEui4gKPNOzGS
         yzY07PMQpHMRRB4hTi4xRSQr76P7N32kUaR9XM5pQkHa3j2SoqQzB1gPDGg64+HTspM1
         Dgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696452234; x=1697057034;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=raoMQ3SQ/7ZFelkz0l8EiT5sUCvEdkA2km5MKOLJhzo=;
        b=JO9Ch0tnNCkrSmuAE4SA2dZ1Xxus/bgw49KJucb1vNrIsuSZPqgYjHnlXcm04HEnpp
         /fIwgNbM+7tTQJ59kluQOpFztN8oj9vUh6rdf1Aqi1XeaqPevYO9s42N/MvvAk1XX/6Y
         FfKWVG37SZ4gS51dCtzuGc/9jYxandP/dE9GcQQ83rtv+qjg3GYAOJJslGucLllda+Wa
         tiAqelGlqO1/LOLrU4d5YhKgNPjaWpfuh1SGYEYzbUWFNS0ws6aE+5Idtm31Q5xetvM6
         w+QTZjrddfbPHCN3JEnfULUfAihrFlfsUeUEjZlwssBejo8Yu8B+aOXaNF4VcPqvwJhQ
         q2mg==
X-Gm-Message-State: AOJu0YzMoo7vxgPFJnUB/9GpyZICBdVLbBD12Lk9DOyczTZdkZOK5HGp
	ANS6E/YrRN5DLOFMlUndocrc9wvkmqva
X-Google-Smtp-Source: AGHT+IHOTTSKdRgnVHjbgvjquFSKOS4KvwkFUDh31IJpUYqwHfKeHqaIlVYt9UxjR55jvbhdZjGcx1Y3S2fA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f42:a09e:8ee2:1491])
 (user=irogers job=sendgmr) by 2002:a81:b3c3:0:b0:59b:f863:6f60 with SMTP id
 r186-20020a81b3c3000000b0059bf8636f60mr58579ywh.4.1696452234270; Wed, 04 Oct
 2023 13:43:54 -0700 (PDT)
Date: Wed,  4 Oct 2023 13:43:33 -0700
Message-Id: <20231004204334.3465116-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 1/2] bpftool: Align output skeleton ELF code
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <quentin@isovalent.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

libbpf accesses the ELF data requiring at least 8 byte alignment,
however, the data is generated into a C string that doesn't guarantee
alignment. Fix this by assigning to an aligned char array. Use sizeof
on the array, less one for the \0 terminator, rather than generating a
constant.

Fixes: a6cc6b34b93e ("bpftool: Provide a helper method for accessing skeleton's embedded ELF data")
Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/bpf/bpftool/gen.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 2883660d6b67..b8ebcee9bc56 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1209,7 +1209,7 @@ static int do_skeleton(int argc, char **argv)
 	codegen("\
 		\n\
 									    \n\
-			s->data = (void *)%2$s__elf_bytes(&s->data_sz);	    \n\
+			s->data = (void *)%1$s__elf_bytes(&s->data_sz);	    \n\
 									    \n\
 			obj->skeleton = s;				    \n\
 			return 0;					    \n\
@@ -1218,12 +1218,12 @@ static int do_skeleton(int argc, char **argv)
 			return err;					    \n\
 		}							    \n\
 									    \n\
-		static inline const void *%2$s__elf_bytes(size_t *sz)	    \n\
+		static inline const void *%1$s__elf_bytes(size_t *sz)	    \n\
 		{							    \n\
-			*sz = %1$d;					    \n\
-			return (const void *)\"\\			    \n\
-		"
-		, file_sz, obj_name);
+			static const char data[] __attribute__((__aligned__(8))) = \"\\\n\
+		",
+		obj_name
+	);
 
 	/* embed contents of BPF object file */
 	print_hex(obj_data, file_sz);
@@ -1231,6 +1231,9 @@ static int do_skeleton(int argc, char **argv)
 	codegen("\
 		\n\
 		\";							    \n\
+									    \n\
+			*sz = sizeof(data) - 1;				    \n\
+			return (const void *)data;			    \n\
 		}							    \n\
 									    \n\
 		#ifdef __cplusplus					    \n\
-- 
2.42.0.609.gbb76f46606-goog


