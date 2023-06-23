Return-Path: <bpf+bounces-3266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C1E73B9B6
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 16:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739EA281AC6
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0883A959;
	Fri, 23 Jun 2023 14:16:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90DA926
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 14:16:20 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B41D2126;
	Fri, 23 Jun 2023 07:16:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666edfc50deso546320b3a.0;
        Fri, 23 Jun 2023 07:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687529779; x=1690121779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AizcmEHPbR6PfE4uUAF8Goz2I5beEO+/ft4PBffEArk=;
        b=sLm8qIJgN8FGYOi0nzzy6oD6S3zWWuJ+4NIC6zvHq7wtQnOohgy4gdjBstl9Oh+Rkb
         q2up3Tw/YsERiIikmzJ8jotr/GZZJi0BSTq97p1/HMit9cw2nEMLx7IyIKnQ56JoIp2/
         6/o7VlFunYrB6FAe3krG7joqoKkpJgmbDxECMBsFgZLnJv/H83S/ESng6oJIpyvkEZQH
         o6d8PERhXmWtslzdk2hPZYcHTge3fvwhljhi4XU/i/18QBrrFlLs+9nejrQBvOmK4+07
         CBWoLP4L14mYi7PyT7mBCBstf3BmeGUwIAd94aMzlB+B/A6zbpJ9YZjC5LYVSF6MTSA4
         WH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529779; x=1690121779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AizcmEHPbR6PfE4uUAF8Goz2I5beEO+/ft4PBffEArk=;
        b=Te1DyezbYHYRq+3PpRRLQeDZUS8sgeOnYx3XZAaON14I9LK2BbVhYAZIplwFf5NRX8
         kOLP7bLNnXKteCS6DtYcZapNySl/GoyakqGgJd3KLZrU+sc9Rmkw/x2gW4Jg78TkP0Tw
         8KP1clfpledZ+TkXlWHnJljeQ1Z4vbAY+OR0qXnuMcq94V0b4UV7Um0ml+eyIZeqAYEA
         I62B4QCZvfe+XCk5XkqhYlVBDIU4D+SNh/3pIVSZrUPeLXBy/3Hx1uZnBtBO8Zjk6WhB
         zVeN07BTfHNaxRGMvhFzvD6FLX9RwGL5Q7Wj4uWY/oCrroPxD+xb1KtN394xaenGGDtM
         UjAg==
X-Gm-Message-State: AC+VfDzp4kFmftq4crdlkOyB4KNTSCEV9XSfNpkvMXMPGAMRYQLiy7o7
	6CWCyU42dZzLZ4k+prg/U6U=
X-Google-Smtp-Source: ACHHUZ60PCAucPZtgr018uHG8m7nIzteypWnXQXLrGFQGjV4ll1/lLj8F54tdc6XVyxtt5Pvxz5W0Q==
X-Received: by 2002:a05:6a20:3d10:b0:125:c3f7:f863 with SMTP id y16-20020a056a203d1000b00125c3f7f863mr2454255pzi.8.1687529778834;
        Fri, 23 Jun 2023 07:16:18 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1058:5400:4ff:fe7c:972])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b005533c53f550sm6505942pgj.45.2023.06.23.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:16:18 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 02/11] bpftool: Dump the kernel symbol's module name
Date: Fri, 23 Jun 2023 14:15:37 +0000
Message-Id: <20230623141546.3751-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230623141546.3751-1-laoar.shao@gmail.com>
References: <20230623141546.3751-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If the kernel symbol is in a module, we will dump the module name as
well. The square brackets around the module name are trimmed.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/xlated_dumper.c | 6 +++++-
 tools/bpf/bpftool/xlated_dumper.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index da608e1..567f56d 100644
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
index 9a94637..db3ba067 100644
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
1.8.3.1


