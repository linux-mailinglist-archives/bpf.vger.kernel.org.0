Return-Path: <bpf+bounces-2407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471F072C997
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D4B1C20A87
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339961D2BC;
	Mon, 12 Jun 2023 15:16:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111FE1C744
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:16:20 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B269E57;
	Mon, 12 Jun 2023 08:16:19 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f9e207f5f0so12343291cf.1;
        Mon, 12 Jun 2023 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582978; x=1689174978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xkj+HxvtsWB3P7BPDfdU8j3ErfZlhCpn+4TayEbVjl0=;
        b=WLDguKq4d+ZIiQk+a0THiwRYc2SOqsEyA9pgexw1AOcr4KaoZZQApukXsQ6jp25XD4
         wZOIWlxvEd+bfzQHNJObTfWUEdi90f9F/fUryjXB/K+lJsRriN4lPNz7ZrocAxKQxuDZ
         LCFXx5HBHjuTthSdu2Acu/aIJrPygubJuoZCYWBOGI4zw/SUmqKTbFxZiLXA7ToMSkWC
         PzLW8w7MIveynGvbCyMFySE35DglbK9D/OSUgvlgYDDFn5a6NCTI2OqjN7KTbTEEWzuL
         411IeCcyo2z7h7HiTq59MrMA1gTI2pY3ioKqNA7ZGvO3slOiKxYriuJQ0LDjFxkYZ2xH
         U5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582978; x=1689174978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xkj+HxvtsWB3P7BPDfdU8j3ErfZlhCpn+4TayEbVjl0=;
        b=YZ5pV0AjuSWKB7oNQdpzgQtKxEM45vmyr4fUKLzSHFesd5x/spqfuXcU68vi2p9LRe
         DndWnSFoLsDgH6g2NT1UecR1XJYXdWaH6RJdVLyzBMED5Ljgj1z9zSOpgwUa7vzu7Zuy
         +WlWDIv1zcHR2ybeAwNPfG8OZbw1gaNU1a5XuxkFm0TKmJX3KJuUrdMFJzbV/H7kQ7+1
         EGZ/r9L09/HkMmbGf1xOG9YzvVSboqeFIDcnr6tZSWqJN1WGHHSKQvmxrQNf1/TSooZ/
         uNws3IPKEfhKH0M4gzgSM4adoIY77yb1RigmURnymIHKGtx8AiiNWAUuM9UhM9kRKyos
         XfCw==
X-Gm-Message-State: AC+VfDwUBeyIJCVYs6k+klj4wdwRBU0Iaa+68e8ydUl8FO2AnFvrbzgz
	Zjx2JszddVePUzBt0gBF1Fk=
X-Google-Smtp-Source: ACHHUZ5HcCz0cl2iTr6Y8+ezyIij3ZOgt8SA+gKvZS3o1j0k7i6+rD59Ssx+WlLbJlMSV5MGaHW9aw==
X-Received: by 2002:a05:6214:268e:b0:62b:6f7e:f5f with SMTP id gm14-20020a056214268e00b0062b6f7e0f5fmr16315744qvb.23.1686582978149;
        Mon, 12 Jun 2023 08:16:18 -0700 (PDT)
Received: from vultr.guest ([108.61.23.146])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cf4d1000000b0062de0dde008sm1533953qvm.64.2023.06.12.08.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:16:17 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 02/10] bpftool: Dump the kernel symbol's module name
Date: Mon, 12 Jun 2023 15:16:00 +0000
Message-Id: <20230612151608.99661-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230612151608.99661-1-laoar.shao@gmail.com>
References: <20230612151608.99661-1-laoar.shao@gmail.com>
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
well.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/xlated_dumper.c | 6 +++++-
 tools/bpf/bpftool/xlated_dumper.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index da608e1..dd917f3 100644
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
+		if (sscanf(buff, "%p %*c %s %s", &address, sym->name,
+		    sym->module) < 2)
 			continue;
 		sym->address = (unsigned long)address;
 		if (!strcmp(sym->name, "__bpf_call_base")) {
diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated_dumper.h
index 9a94637..5df8025 100644
--- a/tools/bpf/bpftool/xlated_dumper.h
+++ b/tools/bpf/bpftool/xlated_dumper.h
@@ -5,12 +5,14 @@
 #define __BPF_TOOL_XLATED_DUMPER_H
 
 #define SYM_MAX_NAME	256
+#define MODULE_NAME_LEN	64
 
 struct bpf_prog_linfo;
 
 struct kernel_sym {
 	unsigned long address;
 	char name[SYM_MAX_NAME];
+	char module[MODULE_NAME_LEN];
 };
 
 struct dump_data {
-- 
1.8.3.1


