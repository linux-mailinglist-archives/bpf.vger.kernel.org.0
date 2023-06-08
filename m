Return-Path: <bpf+bounces-2107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BDD727CEA
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 12:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89DE1C20FEB
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 10:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280F7C8DC;
	Thu,  8 Jun 2023 10:35:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ECCC2D4
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:35:44 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9EA2720
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:35:41 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6260e771419so1985956d6.1
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 03:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220541; x=1688812541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZ7jUkbT4JEijzfbm7zfDaqWfOi1VdugfizMyGWzInU=;
        b=VJnEV2oT6MCSXgGi9yAX5ZDKMe/AiQgFhz0GSy3BO/GxpabcJJ0rFUMqbCUG5y55hH
         JWkJEsS7fesNSYO1dHqSoG+cRsd2muIrbYqd4j1nFuhFWnseEO1HTldPVLUCEOdcacLb
         gugfKncLXynFsoaKPrrC4OkUfbeRT1/xjpQrI4W/b5FiAV8cX5ronhE23jDVcUGocEyB
         dQjYqNJxSB4/CUgWw2lGokKKlstOBm3O2q6z8en4Yu7zWTTW9shpChKO127HmHX9bhRT
         Sx7ajmCC6HksetNfWhNxDunFtnn7dd/T9oGDKISKmnBA6Gdwt3nN9D4P228H2asEAEug
         +CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220541; x=1688812541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZ7jUkbT4JEijzfbm7zfDaqWfOi1VdugfizMyGWzInU=;
        b=YiBjpyuysrPtNbzFrq3AKLtk/OLB6sF5sMrz5sTBBxqpNA8A4VhJpY2KlEb3zsAYrC
         xjWQUv8uOsV4btG+xfQhbf7tWzwC0Tp4ySAih7U41+kU/mcreXR1osCkUlbqcTEtFYkw
         RFsrvowFurUl3Uc/gnDrvgotttic0Vm6Z5HAWcHpBkAQbjoa6CPfhh6npW1XSw2uJ61R
         4wXmrFJ22Qhns3VbbyE9W7gnz/luUqUe1WkoBo0yYgRutq8SqIg8A5zV4Y6ViV2nahQf
         FGVnOEUsfytp6R2I3xu5QaTyEtfqvELrsaiW/X1Ple/LIUP3B16nD0jUkhDStbxEhqio
         TYXA==
X-Gm-Message-State: AC+VfDzXUCw8hGugQhSddGIUEEaAdnVLDFBxFDjxNv51tF0Qips/eRGe
	FryIyeNa7zRTmOzjP4zY/aw=
X-Google-Smtp-Source: ACHHUZ4b8cVmQFzEDWD86f0Voftfk2Ky2ZMD4FDEfj1gtcKDcuf1ybyQL/F9Pg3be20B78uoFLDSqw==
X-Received: by 2002:a05:6214:2488:b0:56e:c066:3cd2 with SMTP id gi8-20020a056214248800b0056ec0663cd2mr981156qvb.2.1686220541047;
        Thu, 08 Jun 2023 03:35:41 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:2418:5400:4ff:fe77:b548])
        by smtp.gmail.com with ESMTPSA id p16-20020a0cf550000000b0062839fc6e36sm302714qvm.70.2023.06.08.03.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:35:40 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 06/11] bpf: Expose symbol addresses for precise identification
Date: Thu,  8 Jun 2023 10:35:18 +0000
Message-Id: <20230608103523.102267-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230608103523.102267-1-laoar.shao@gmail.com>
References: <20230608103523.102267-1-laoar.shao@gmail.com>
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

Since different symbols can share the same name, it is insufficient to only
expose the symbol name. It is essential to also expose the symbol address
so that users can accurately identify which one is being probed.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/trace/trace_kprobe.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 6564541..61911e0 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1547,15 +1547,14 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	if (tk->symbol) {
 		*symbol = tk->symbol;
 		*probe_offset = tk->rp.kp.offset;
-		*probe_addr = 0;
 	} else {
 		*symbol = NULL;
 		*probe_offset = 0;
-		if (kptr_restrict != 2)
-			*probe_addr = (unsigned long)tk->rp.kp.addr;
-		else
-			*probe_addr = 0;
 	}
+	if (kptr_restrict != 2)
+		*probe_addr = (unsigned long)tk->rp.kp.addr;
+	else
+		*probe_addr = 0;
 	return 0;
 }
 #endif	/* CONFIG_PERF_EVENTS */
-- 
1.8.3.1


