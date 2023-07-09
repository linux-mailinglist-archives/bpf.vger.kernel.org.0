Return-Path: <bpf+bounces-4513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF88B74C07A
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 04:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A8B280E22
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 02:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95729187E;
	Sun,  9 Jul 2023 02:56:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74848185C
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:56:48 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DE9E45;
	Sat,  8 Jul 2023 19:56:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e97fcc60so2137307b3a.3;
        Sat, 08 Jul 2023 19:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871407; x=1691463407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBs3mktan1YmmX0M9dfKX3Pl7uyEaN9wbTRd5MR/QSA=;
        b=H+aVD1SdcgDIArYmzolhZ6vdAy22W5+nZPqDQhwFxqx/ZnHWVKOm3iYk6AlK3mPdf/
         AfNdb2Dy/SZ/AnbPDx7nab14DByiz7PZoU8IxXz3hbfOumNN7Qj3AARACWMFPUcqokRY
         +ElytCV9KqhzCxXKLc6aZAvC5HBjaQ9kXnHzK80bOqXR9uXf3jK4zslgmZpgNJohX0jg
         3yU7xE1gQChLnJSlLS4Do4I3y0LNzGc2i9Fe6d+w5j4NA6XS8TGuLir/ktuP5oi9KI2O
         dmfVT52VflAgl0VdNzn2L/XSF7HnqUGYsq01YaveqpAjQ2uJsX/Xyi3iHguj/6a+8wZn
         srDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871407; x=1691463407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBs3mktan1YmmX0M9dfKX3Pl7uyEaN9wbTRd5MR/QSA=;
        b=HOhmRoevA3wYg/qKCyD2amaQx8RHxaSQE1iXjC7aIfcOZJae/fUXuMma1n6wggv1Ey
         BK0AWbS66He4umld8YLNsC+X28XnQGuwRbzfgtH4c8xbcpszcl8kzASLGjimJ2mFEDvv
         nzhyF6NPTii97ynqkDX8LzGJJM1WH0oK311Ycc8BpWGmq7cCmJD7tTsBgYzXMWN9Jt/4
         3dgnah4qpYS87UGFO6nhUEhPF7HNIUymE+sRlKic1yeSRKERjBgKhjScF5sUyL7SnNXP
         S2S2sdwI1+NnA/FBeWfRNzsmyaiLnpe0GEULfFUkdcOb3oUSqtJf/l2s0Xoe2Kc5Fx34
         XwVw==
X-Gm-Message-State: ABy/qLbtRDVProNOeGYWeVkBfA3p43M9qoAlcIU5WajnJMuW00uF0qLE
	/yKQoYfQrsfQi1flGLm2fu0=
X-Google-Smtp-Source: APBJJlH0ViHiGDmT63SOTDc5gDjYRwd3bfCDyAoOi0spQrAIfg9b81xIZVVZfzMtIvlK6+/+cDH8Hg==
X-Received: by 2002:a05:6a00:1389:b0:682:4edf:b9b4 with SMTP id t9-20020a056a00138900b006824edfb9b4mr8442419pfg.23.1688871406892;
        Sat, 08 Jul 2023 19:56:46 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00682ad247e5fsm5043421pfn.179.2023.07.08.19.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:56:46 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 bpf-next 02/10] bpftool: Dump the kernel symbol's module name
Date: Sun,  9 Jul 2023 02:56:22 +0000
Message-Id: <20230709025630.3735-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230709025630.3735-1-laoar.shao@gmail.com>
References: <20230709025630.3735-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If the kernel symbol is in a module, we will dump the module name as
well. The square brackets around the module name are trimmed.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/xlated_dumper.c | 6 +++++-
 tools/bpf/bpftool/xlated_dumper.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index da608e10c843..567f56dfd9f1 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -46,7 +46,11 @@ void kernel_syms_load(struct dump_data *dd)
 		}
 		dd->sym_mapping = tmp;
 		sym = &dd->sym_mapping[dd->sym_count];
-		if (sscanf(buff, "%p %*c %s", &address, sym->name) != 2)
+
+		/* module is optional */
+		sym->module[0] = '\0';
+		/* trim the square brackets around the module name */
+		if (sscanf(buff, "%p %*c %s [%[^]]s", &address, sym->name, sym->module) < 2)
 			continue;
 		sym->address = (unsigned long)address;
 		if (!strcmp(sym->name, "__bpf_call_base")) {
diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated_dumper.h
index 9a946377b0e6..db3ba0671501 100644
--- a/tools/bpf/bpftool/xlated_dumper.h
+++ b/tools/bpf/bpftool/xlated_dumper.h
@@ -5,12 +5,14 @@
 #define __BPF_TOOL_XLATED_DUMPER_H
 
 #define SYM_MAX_NAME	256
+#define MODULE_MAX_NAME	64
 
 struct bpf_prog_linfo;
 
 struct kernel_sym {
 	unsigned long address;
 	char name[SYM_MAX_NAME];
+	char module[MODULE_MAX_NAME];
 };
 
 struct dump_data {
-- 
2.30.1 (Apple Git-130)


