Return-Path: <bpf+bounces-8957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A01678D250
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 05:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B1C1C20A88
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 03:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD1C1112;
	Wed, 30 Aug 2023 03:03:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A236910EF
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 03:03:39 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3952B1BD
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 20:03:38 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a9ee3c7dbbso701123b6e.1
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 20:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693364617; x=1693969417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vScUfoGK75nE8Zm1Z1v6FNvJuIyVvVMORYVVkX1wLBM=;
        b=sS778T5+HNLNs4t9tHtuqOvQepgxfR1PfUwsXNbX/2ly08KN14QMPLwHGuPGp630Er
         /rHjcAlxY2HZrmox2lQi8tvGsNXHT9E5yD2jXz9RehQlvmrVLqadjnO2k+H08FnQewKI
         y0dCFtzW1IVq2KCo5FyIte6ItiVAHX4HzuRAAMgYDI2/lUj37w+F8WjtieUtipIu8n4h
         6b482bd36Z4HFZylA4F70tbaPTFgNnRRjsN9Dx+yLNjQkEpTQQCcwYqNPHe3ecydXTKu
         5uFOSXs6066EJL9DBPl2wIVo63Sb+/Nz8M2VDX28rUTsBaOwcoUlZfXY8c5lcNJkSWlC
         rcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693364617; x=1693969417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vScUfoGK75nE8Zm1Z1v6FNvJuIyVvVMORYVVkX1wLBM=;
        b=STLVgy8GstVORbnHQhrSnbks+RMWK6JG5e+vntc/9lwMngc1isF+c/YVWdpQKotn6H
         PzMzOGNCb3mvAjoC35lloER5FdjOaonEYsFy12653GCj5boyGE4hlT4Bq2AQ4DC6OzGz
         kuZ2exmlFXkpWxSDRrcFSedX37nl5WB6zkq04le1S8HnoO4HiQ8YgaOLRKXxn+km4YeV
         2afmpu8s2MzvFBFJy3YE4Jp9xaeWlCjJr6ZOiYsDmVxIAHfuenNvXjBczkG2CX0X7lXW
         RyQeXsA46Dm1tlzVSYL+6pl4h2sHYxx4aJU6E/Nvnt5ZrF5tR8Vqo/mZ4xBHMGFSGsf4
         GvLw==
X-Gm-Message-State: AOJu0Yzn0YZTCYTKcGFYvSbqDXiGjY3mR9lmK2BNXkwR1V8nHqBpVFPM
	sw1yi/1EYSddrerL/oGRJuc=
X-Google-Smtp-Source: AGHT+IGk9ghCUbrxH79Et3pbg1+krhx6B+k39I0f4plpkYAROVvBr0xUa9Dvltb+IDabsaMR3Tlbeg==
X-Received: by 2002:a05:6808:210c:b0:3a7:57a6:e077 with SMTP id r12-20020a056808210c00b003a757a6e077mr1189108oiw.37.1693364617482;
        Tue, 29 Aug 2023 20:03:37 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1860:5400:4ff:fe8e:4a7f])
        by smtp.gmail.com with ESMTPSA id q19-20020a62e113000000b00687f845f41fsm9075721pfh.119.2023.08.29.20.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 20:03:36 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: quentin@isovalent.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	laoar.shao@gmail.com,
	martin.lau@linux.dev,
	sdf@google.com,
	song@kernel.org,
	yhs@fb.com
Subject: [PATCH v2 bpf-next] bpftool: Fix build warnings with -Wtype-limits
Date: Wed, 30 Aug 2023 03:03:25 +0000
Message-Id: <20230830030325.3786-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <af79f4da-232b-4990-b7c0-74b4708953ba@isovalent.com>
References: <af79f4da-232b-4990-b7c0-74b4708953ba@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Quentin reported build warnings when building bpftool :

    link.c: In function ‘perf_config_hw_cache_str’:
    link.c:86:18: warning: comparison of unsigned expression in ‘>= 0’ is always true [-Wtype-limits]
       86 |         if ((id) >= 0 && (id) < ARRAY_SIZE(array))      \
          |                  ^~
    link.c:320:20: note: in expansion of macro ‘perf_event_name’
      320 |         hw_cache = perf_event_name(evsel__hw_cache, config & 0xff);
          |                    ^~~~~~~~~~~~~~~
    [... more of the same for the other calls to perf_event_name ...]

He also pointed out the reason and the solution:

  We're always passing unsigned, so it should be safe to drop the check on
  (id) >= 0.

Fixes: 62b57e3ddd64 ("bpftool: Add perf event names")
Reported-by: Quentin Monnet <quentin@isovalent.com>
Closes: https://lore.kernel.org/bpf/a35d9a2d-54a0-49ec-9ed1-8fcf1369d3cc@isovalent.com
Suggested-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 0b214f6ab5c8..2e5c231e08ac 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -83,7 +83,7 @@ const char *evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
 #define perf_event_name(array, id) ({			\
 	const char *event_str = NULL;			\
 							\
-	if ((id) >= 0 && (id) < ARRAY_SIZE(array))	\
+	if ((id) < ARRAY_SIZE(array))			\
 		event_str = array[id];			\
 	event_str;					\
 })
-- 
2.34.1


