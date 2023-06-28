Return-Path: <bpf+bounces-3653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E1741073
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3619F1C203D6
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAE7BE7A;
	Wed, 28 Jun 2023 11:53:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D70DBA32
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:53:41 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1591F30CB;
	Wed, 28 Jun 2023 04:53:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b7e1875cc1so23639905ad.1;
        Wed, 28 Jun 2023 04:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953218; x=1690545218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2E0julkhzoBPe9cX8HwmnN11LbKtm1JrxHNAtMjvgDs=;
        b=bkMlGCb5aciMjugoiLuuf3D+Gzw5id4J2UgNM8HFk9VPoOCl8gjSOXRdLvN1KncWCO
         sCdZ6Ps1nuksUyfktnKgg4prmq7X73ZrGf84uFLiUzj07GFZau/RSwvZNzig3a2uZr0F
         dZ3mWJh5GqdX6X4zi+4tN3+1Lz2ZldO3Xr9OqNR+ZA04F4abgwql6+Ea3iwiIlM+/W1H
         Q1Fwnj2de6lhCKFP9gw2+xX2xhQC3ow2Kj9h7g5La+zYXOLh4NJc+jNAGlIQ7s2tH4dB
         bd1meaXynknOT4lRCom6BtPw4C5PYpYfdZraqJk3Yl3B0CII0UgjsQreIEVTAWF44a0D
         RR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953218; x=1690545218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2E0julkhzoBPe9cX8HwmnN11LbKtm1JrxHNAtMjvgDs=;
        b=cv/RJKiYima2beSJduRE9lakXq6wnP0mgtitHW4gvtMlMAt3LtFAqt/zWDWcm0EE9O
         hHj0m8CWckw6dst35/py5m33/W3eQNIWDZoJHpmOsAMvvKVgPPWYXzsXW6xZp5ai/AR2
         CDbDXyx4nhKysGiZrJjZ65Z3YuVTtmGaJCyalbsZSfwMhXYfQkNVSqykA7aXR1rKDMfE
         AQRr3yt6as1aEnaHJwZOdSg32SoMq9OAXqfEVDZwkuBUt+OFT4sj0jVcEN0hoZBDqhPW
         H9elDhHoBOIiY2ggC140lBNHZ+V19ILU4hAI0HLj8ByrZSdUOCtoTs8BzkR7WsPckqnr
         rOeQ==
X-Gm-Message-State: AC+VfDx6nv9ex3CxdGftvtfcgLQlhoo74O/bORg8Gv5Wela62SG796EZ
	ejEcmx8qdZsSe4sip/gL55Q=
X-Google-Smtp-Source: ACHHUZ6EM0HMjybfesbfT5miJlp0dFay3xgldEDzmLMI72tP4tI6pnA2vhtiVrHmct9PJoXnIe7g+w==
X-Received: by 2002:a17:90a:ea89:b0:263:3ccc:dfe4 with SMTP id h9-20020a17090aea8900b002633cccdfe4mr1299618pjz.1.1687953218517;
        Wed, 28 Jun 2023 04:53:38 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id n91-20020a17090a5ae400b002471deb13fcsm8000504pji.6.2023.06.28.04.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:53:38 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 02/11] bpftool: Dump the kernel symbol's module name
Date: Wed, 28 Jun 2023 11:53:20 +0000
Message-Id: <20230628115329.248450-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230628115329.248450-1-laoar.shao@gmail.com>
References: <20230628115329.248450-1-laoar.shao@gmail.com>
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
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
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
2.39.3


