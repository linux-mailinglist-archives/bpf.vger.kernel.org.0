Return-Path: <bpf+bounces-11409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F6A7B97E7
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 00:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4BB7C281B2A
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 22:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B52125109;
	Wed,  4 Oct 2023 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QYfC+wRu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391E924212
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 22:23:41 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD75710FB
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 15:23:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d865f1447a2so592381276.2
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 15:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696458206; x=1697063006; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=raoMQ3SQ/7ZFelkz0l8EiT5sUCvEdkA2km5MKOLJhzo=;
        b=QYfC+wRugJ4lQvqgBCiqmcgXHB6ESxeWYPtjzQSoBgY8qUxYUMV3L0OGnyhLxVaOsr
         cxsqzQ/YEGh7N8UldMs/u2nV20Kr+nvcsiokgQPUdT3xNyLYy+DdZBs6BEiB+Rs7ucLj
         LMKfYgoIWNgmLYHuIOaEPYtqwtdcjSe9duR2Bu4C2dQz2h3wERt1NbRupbCPadAYuYGB
         qu/+m9oX+SJRad8fShgk+yHFuVdJvVQssA0AOmvKhDlnn+IAztWjw9gkAA0STxN5cc0N
         FHOFYKtItacqE/0RgR05bzroVIuuYZzGo3qkRNAJOMC0/HBncopjRm3VtlGu+IPwu2XO
         /PtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696458206; x=1697063006;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=raoMQ3SQ/7ZFelkz0l8EiT5sUCvEdkA2km5MKOLJhzo=;
        b=l4oZYxsZProrflaLiR9k8qRxQWwa/Q30cdAWI3nNciLJlVV5brHFg0xGIQtD2ljeaV
         dKkMCznTbxJ0jMk3CfXQSiieE/yMWRD3Qn+QcfCF6J5BJ61NRYrgZAGc8ritvwTI6EYZ
         cij7P/zmVeHbwl2N0vRYuwhY9xHdLNAU2JOGG8meljrR2y7h7ivLeREKHSlCoCmcjDdN
         ISM+z1Q8mc+gyOqUQ637r7QNeEvgydA89T9NmWyGlF853lb5u9ithLlzkWoM53ww+gMQ
         NpOvDw4RbqWojTROc9pzA5UvMdhqEEjnvMyg/VKNTz62aikTgS0KLF/QMfBHKvhYvNYu
         GxGg==
X-Gm-Message-State: AOJu0Yx0V/yqtoRg/j6ZIeY6eOhRF2HsR0Fdov39ZNwndYxSN4pgDaAJ
	t/bJSrSsdXGTPlPJrfWEdWXt67D8JBqa
X-Google-Smtp-Source: AGHT+IHuWIDrX75i83mVKUxiuU6q58yAN8CALuDciPIg46gAx0U1ncoVbvRysJAxkkItHi9M7Z9Ux8p3GNvU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f42:a09e:8ee2:1491])
 (user=irogers job=sendgmr) by 2002:a25:3442:0:b0:d0e:e780:81b3 with SMTP id
 b63-20020a253442000000b00d0ee78081b3mr48786yba.2.1696458206114; Wed, 04 Oct
 2023 15:23:26 -0700 (PDT)
Date: Wed,  4 Oct 2023 15:23:22 -0700
Message-Id: <20231004222323.3503030-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v4 1/2] bpftool: Align output skeleton ELF code
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
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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


