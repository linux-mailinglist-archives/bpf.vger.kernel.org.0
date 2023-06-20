Return-Path: <bpf+bounces-2931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A117C737193
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 18:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D269D1C20CDE
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D8117AB9;
	Tue, 20 Jun 2023 16:30:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B626182A1
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 16:30:22 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9724B1980;
	Tue, 20 Jun 2023 09:30:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-25eb401995aso2189969a91.2;
        Tue, 20 Jun 2023 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687278620; x=1689870620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AizcmEHPbR6PfE4uUAF8Goz2I5beEO+/ft4PBffEArk=;
        b=Smv3nPK2LQCRLYIpX7JYrbGjQvAbjHbGttsPiIJGzzqPoasl4DU6nQGvWjBdSBjo59
         uAldKWHjEUR0VvnInXg8CfADZ+LDuiAOztwAZfyL3+q32uvj59CcT/V/46pVIsed2u+f
         dXyjlBskOQm11j2K/6pgReL2igIUfSijnJZWqtWlYCplRgzXXeIpYr4QA2kSm6iYgLDM
         hAt6ivBZTwSDbdI9bLAzT8AupCa0tzsZjt5Dd4x/WYGpAz3N7TuT4edK3T+2NtPjr7L9
         suU/05MR5iiRS3EqQhJnoCqD0vemsVTzCWa8AFRmN3TuiN3WkuydDJIChs7XDQVOP3wx
         I9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278620; x=1689870620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AizcmEHPbR6PfE4uUAF8Goz2I5beEO+/ft4PBffEArk=;
        b=KUQftoLlqdX7O0CY8aBvPKh1/X7YbqjzlowCo1Rtv6tHcwkAKDyglquZhE511R65qN
         mRXH5uoR4AQuBK+ilL2cnCPUCnBA41EkIvehjGcocApzr5hNe3r2UoqHF8fABXJaOqSm
         q4aZnGan8VDqPvNhujy29IAOaSUOVETBRx1DnW8r4j/ReK1ogW5MUDhx6R3Flx61emO5
         rv7iNkMCfRDFcWvTBYLEKr7RcUMbi67pRnnMWSrxpiX0fBg1W1mhHSQGC8Pov4IOZft5
         tLcd2ZdpARJEIFaoFMhhWjvHbm8RSVVBsKQUTu3OVtJbemGch7ljIQZ61GSX+KcQ0URj
         JXnQ==
X-Gm-Message-State: AC+VfDxG1UPlZjCd8VOkku+ub+/UcCcz2u0yiU40tmXh0jV5EbfKz6v7
	rjDOcFsttfPn3KJuVVF84g8=
X-Google-Smtp-Source: ACHHUZ7hORov/0liiH06C00mtXxWypX/E0obGWOGEsYSKrCdpCls/Mht80VmzgsPohRVNufnkorJtA==
X-Received: by 2002:a17:90b:11cf:b0:25e:df16:892a with SMTP id gv15-20020a17090b11cf00b0025edf16892amr4993079pjb.34.1687278619951;
        Tue, 20 Jun 2023 09:30:19 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b96:5400:4ff:fe7b:3b23])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a3b4800b0025c1cfdb93esm1854286pjf.13.2023.06.20.09.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:19 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 02/11] bpftool: Dump the kernel symbol's module name
Date: Tue, 20 Jun 2023 16:29:59 +0000
Message-Id: <20230620163008.3718-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230620163008.3718-1-laoar.shao@gmail.com>
References: <20230620163008.3718-1-laoar.shao@gmail.com>
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


