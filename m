Return-Path: <bpf+bounces-11299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 322467B7194
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 21:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4D8C71C20282
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 19:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0D33CCFB;
	Tue,  3 Oct 2023 19:15:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85903CCED
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 19:15:08 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED94E9E
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 12:15:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d816fa2404aso1573908276.0
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 12:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696360506; x=1696965306; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DJOW1cRndRnD6u1zoIC+jIQu2Yw55MSP06y/ktBFUbM=;
        b=yNyvNMbSL0y5xjTXnhme9KSZR05SSUpDq5O0ghbV21+Fx8LCrsRixX8ODc7jCv9jB8
         Y8HZqIhN6GTh87Pzkx/1NC2BA8/fnHBtMTgLM27TdHSJugGQ1GmJZfJHVL9gpnDlM9r3
         EFoXWrT3np/HMs4cfDdgfgX+mIBUKgcfJW5WDscfIkp58kRftvJEFVBzM1SexfqWuwyE
         5P9ky4qOYNaDb3cLAF8mh4J0haQxXdT4lXXgT2AT3uch/anPsFqv4VzQJ9u3zmC/7g2W
         8EwmEUQEsBH2BhqJbDmokvLYTlEbN3TZdI1m8lcmEaQCd/lpNy6fVQwyKI/bF3mw3xPJ
         8wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696360506; x=1696965306;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJOW1cRndRnD6u1zoIC+jIQu2Yw55MSP06y/ktBFUbM=;
        b=Ewm+NyeQT1xN668gDqpxM1ERb0PZeeOYTvK/ctwPD07A9qpOBqY2NKNECxpc1InjpT
         AUoRiu3B0oPPG2iBLhpCxF8uGlPqxXADa41w9gug6XrmHRyHW7lWnv+CJOFD+9fPV1c7
         k/sdB7Pi/g3CzYHm0MQ7pJgXkdEaacKuZ0H8AvkJx9zaaGuoT26bjR4jJEmAMc68MdOU
         +cMeXqQUytxIAIEE28hoGSXj1Dq9pOCxQPFlWfOet/bt8Q0w1WqIu84Rf+FeZ3+OZBf0
         4J2zlwx2ez0b0kTXd85zvdFG5brJvZ9eeV6z79iOo2EJx89C1mSquyiSZmB1eZpVlQDy
         l+qA==
X-Gm-Message-State: AOJu0Ywaj0eMONSmVl/gqyXoJJcB2O/hKt8EoYgB3scAKpFboKIVW1vh
	Z8cfgan73MR1ECG4vZZ0nNO6a+0SuJJk
X-Google-Smtp-Source: AGHT+IGYcOJgNvoSVWzy2L5c6hkFXm1/Pg3MYXRBpB1h+5OFOsqbKD3loQoJmupL6OgyShodwAT3B9/Rnq1p
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:51d:1f25:c2d8:4514])
 (user=irogers job=sendgmr) by 2002:a25:db4b:0:b0:d77:bcce:eb11 with SMTP id
 g72-20020a25db4b000000b00d77bcceeb11mr2196ybf.10.1696360506122; Tue, 03 Oct
 2023 12:15:06 -0700 (PDT)
Date: Tue,  3 Oct 2023 12:14:11 -0700
Message-Id: <20231003191412.3171385-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Subject: [PATCH v2 1/2] bpftool: Align output skeleton ELF code
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
2.42.0.582.g8ccd20d70d-goog


