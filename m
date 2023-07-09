Return-Path: <bpf+bounces-4515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215FA74C07C
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 04:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519B31C208C9
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 02:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A710C1FA8;
	Sun,  9 Jul 2023 02:56:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835EC1C3F
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:56:51 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B97EE46;
	Sat,  8 Jul 2023 19:56:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666eef03ebdso1437992b3a.1;
        Sat, 08 Jul 2023 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871410; x=1691463410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuX1Oey0L/NEX0/2PFEsrmGZ26pzBt0sRqMiZlxNdvM=;
        b=iHgDWAMnzwd+k0xbl8Okq9Wounrr51goxhCZHyxdXcAaDoKSKjVMrwLwECo+oArKph
         m7JDqA4FdVzQ7dBG0LACK4BfJ4NpoeHqWRvkgqCn6kWR7jGnHCYaHt/Ni1dnUV40aONu
         V+CNdYKztIbzcE5KkK7ibjM09hB/v6hTvWqACkhGeAJjbcz3pgkO3RKBar/rqtPq83eB
         a/BWsAbzsa9cFSeDR8Kx4So7ImR8zaoC5TvX/skPUgtWRDT8zJ2KtxsvFckQIMyLAmi5
         Q68A1mhMt/gxZHS7kQBGlWtPzjxDIdQ7OKSw+sx7S36KAf+n/wAlIPOOIjdm5oMT31Eo
         9+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871410; x=1691463410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuX1Oey0L/NEX0/2PFEsrmGZ26pzBt0sRqMiZlxNdvM=;
        b=V8ifbj8E53bm7MbbdZuCm33jQ3q94oCD8SJlwJ8kgQmRIxNIY+FqQ6MCUB0iq0wQ9y
         hbrWDf2eY5Sjxwx01OfyU7XllUxnKe+dOAebG8WDSJenuyu0DuCWw7RR/efQBGq6shwu
         f6fJHtfacNZTOFPJXV3O7K9DsJ9Tu49CT22JgVPZIo6r0uDjpal0UgXXC4X3oOv3UUL6
         sa3szfzakBUmuAAeFa/7IELu7gD8R+6D8mhb56IufpMyFNkxQNQfqZus97S1r0a6L28H
         lUTknRvDzbUCoHCIHLHDOopkUxWY6zi2fJPYV2FDHG3THYkw+yC+Y/gODd3vxuxsj9gU
         kX7A==
X-Gm-Message-State: ABy/qLZ2Dgodfonou0Oaq6LyxVZEGWIWG7maqs+Vj0uZEJRToTI9EyCT
	yMSpoBPXan/aF8iw/OgCT2o=
X-Google-Smtp-Source: APBJJlFnksx8/ZuiwKN9h/J7cSZ4seVEXhQAv9HGBVT29+OmDyeEqJnzwrmf86va5K0twuPKozCuAA==
X-Received: by 2002:a05:6a00:80a:b0:666:a46b:63c9 with SMTP id m10-20020a056a00080a00b00666a46b63c9mr8172172pfk.11.1688871409813;
        Sat, 08 Jul 2023 19:56:49 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00682ad247e5fsm5043421pfn.179.2023.07.08.19.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:56:49 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 04/10] bpf: Protect probed address based on kptr_restrict setting
Date: Sun,  9 Jul 2023 02:56:24 +0000
Message-Id: <20230709025630.3735-5-laoar.shao@gmail.com>
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

The probed address can be accessed by userspace through querying the task
file descriptor (fd). However, it is crucial to adhere to the kptr_restrict
setting and refrain from exposing the address if it is not permitted.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/trace_kprobe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 1b3fa7b854aa..249eb14d0f7a 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1551,7 +1551,10 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	} else {
 		*symbol = NULL;
 		*probe_offset = 0;
-		*probe_addr = (unsigned long)tk->rp.kp.addr;
+		if (kallsyms_show_value(current_cred()))
+			*probe_addr = (unsigned long)tk->rp.kp.addr;
+		else
+			*probe_addr = 0;
 	}
 	return 0;
 }
-- 
2.30.1 (Apple Git-130)


