Return-Path: <bpf+bounces-11233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9C87B5D2D
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 00:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EDCE8281890
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 22:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5F92031D;
	Mon,  2 Oct 2023 22:32:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4AE1F183
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 22:32:28 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F9791
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 15:32:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a20c7295bbso2015087b3.0
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 15:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696285945; x=1696890745; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kSFAh0qqGx45G6TQa/MZdM1IdFSztj1awjWbA+mcycU=;
        b=DxTvXFlnBlAEnK/Z/LDEasydqWeFp+BhkZSX1w3U/+eDhazMQfmeswKD3BdvlVraOn
         cTVbL4SHp5AOOa0dJqktCXfyWyfioimKkY/MAdiT3aF4A6cuqRjZq8mfW0TyfVdz+bAt
         IKvlW98J3gUn9EB5fPTWhk0GdC0rUcqK5QI/rrGgw7DgFWGKIJ3b9X6xKkuv6A9BlrsH
         kyEypAK0DNk+MltSxAJQKP3lgCvIvgAA50cJi+pAlVDpu+FDvTz6ZbfHbkqn3GYAf/ng
         ZrAjKdd8+0RsfW5mCkCYHk93OkdeloZ6ZOPRNY2M2zrUq+jdo70qm6UgMKIS/o80PYQP
         oyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696285945; x=1696890745;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSFAh0qqGx45G6TQa/MZdM1IdFSztj1awjWbA+mcycU=;
        b=n74zwA13/kUs2uYhBU1cRKaMDz8QpzyGMIsiNN4poaH7lhkDQyOy5z3r/UWDxtWFAg
         JqzTwHle3naRG05iNP63lvtLUvcpI3ic+bC0gZ1++K9bVf6ea54mlSKWBOHcfjyxDQ0h
         iiOdAmJIuOzbXvXv5mSspe3/2jForigA5XUsTGKtH4qdD41YuYLifCtfMXZaVkRiOE9p
         IvLDx0jepDshXVRq0o98ugArWAEOE/UfovT7jr9XZi4D8Vo0YrGFcpBPMubLz/rFOnhR
         xVsuSqmITE3nIf8Jw+ntW+016L+USHeMxj7Fm94KrE6atqOfYUNiFoLq1Q6MqR/RHio6
         PEew==
X-Gm-Message-State: AOJu0YyITE0TcdhGGrxpavt0Hab2AW41BrE9Y0Hwva6oxyUh4XN2M0rT
	43UYMxLF2ZMys2BvTF7cnWiRvf/1s5Dq
X-Google-Smtp-Source: AGHT+IGeGI7meiKgN62+V+QzM1QfTNOH6LmefzUD57qfCucPSiPf185y4PcRsqMKPnnkUk8hSDt7462RNtWP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a907:e439:3a86:b259])
 (user=irogers job=sendgmr) by 2002:a05:690c:4607:b0:595:7304:68e5 with SMTP
 id gw7-20020a05690c460700b00595730468e5mr19825ywb.0.1696285945027; Mon, 02
 Oct 2023 15:32:25 -0700 (PDT)
Date: Mon,  2 Oct 2023 15:32:19 -0700
Message-Id: <20231002223219.2966816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Subject: [PATCH v1] bpftool: Align output skeleton ELF code
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

libbpf accesses the ELF data requiring at least 8 byte alignment,
however, the data is generated into a C string that doesn't guarantee
alignment. Fix this by assigning to an aligned char array, use sizeof
on the array, less one for the \0 terminator.

Signed-off-by: Ian Rogers <irogers@google.com>
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


