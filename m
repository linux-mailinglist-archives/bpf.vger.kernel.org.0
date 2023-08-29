Return-Path: <bpf+bounces-8923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871ED78C8D0
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 17:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A6C1C20A7D
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6776717FE3;
	Tue, 29 Aug 2023 15:43:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DE228E7
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 15:43:39 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CE7E52
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 08:43:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so3616586b3a.1
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693323792; x=1693928592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHVVbpoJklDEumyY4IggHfPNadIGMNOUB/HIluIeeVo=;
        b=FviM8ueGnKko2876EwEGEwr5/UVZnYJuRh45m8NVqRS9MNg0NioXXazkB3umRnmKCc
         A6+JyfrNH+T4mwsgwJNwzslESM8hkPZY3EBm9vQ5VBhdt/VJNly+FBexrt/uwHHkcVjD
         CXX9baNWtDAdU2l8PMLi8QLY5KcZ2GO3vupSRNHWkB2l1rvvrXmUDpE4J8IIiXdGHHbm
         QeTASJG51oOtl01a614hzjm+RBr21NbXIf2J7c5jnVkidE6+2hoFYkEPdn+wmnr0IgqS
         ry6uyfZARlSIeXRN+REB86uLH1l+ShtzNqNt5pq73uoNl1QB7iG8KHW3v6lWX8j+q8v5
         dJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693323792; x=1693928592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHVVbpoJklDEumyY4IggHfPNadIGMNOUB/HIluIeeVo=;
        b=bZYYX7b86f5Wfp6MVUC4Z+/MB6eBQqhRizBva6f9JTWD2iyDgEUSWaokmbDZBF6ijr
         Wgj1Hrn3XM0uQ7f9qXzdGUg5TtrQPZ/f2PjUu0GiteaPbVvXE3GHQ5mK8S2Jwvp+lqvz
         zsjT3jZuKbx0FBdqQHtdq94NAaJsMltGd+X/1qPrPWieb7qvV0w6bbEgT2gIA3UVUWvp
         HXd1OkMrhi42TUUk9brS5I6vOEPEu5y8Fd+gnZb3z4xo0uqoEVLz3MOvtNDvGc6xi3Zz
         F2259CQK+7ZYO4/h1n1T2nuvB4dzI43Ag/A2GNeoT15L9BTmBX15o3UyIz7XtP9AWQXJ
         qNzg==
X-Gm-Message-State: AOJu0Yy/2k+dnIs0Br+NpMih6psE9gpqyxJenTGOyobaKKBGM8FrSF5R
	fxux8d6WN1b94jej8tsdHZg=
X-Google-Smtp-Source: AGHT+IG1eVCMZHNRthKFb/BKw3Ekkq7xW2dDMOgv+oYXwVtvAMV4UO0/axUyOQEqfzytB2U1xUW4Wg==
X-Received: by 2002:a05:6a21:4847:b0:137:30db:bc35 with SMTP id au7-20020a056a21484700b0013730dbbc35mr26376017pzc.27.1693323791753;
        Tue, 29 Aug 2023 08:43:11 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id p25-20020aa78619000000b00686b649cdd0sm8650111pfn.86.2023.08.29.08.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 08:43:11 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: quentin@isovalent.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next] bpftool: Fix build error with -Werror=type-limits
Date: Tue, 29 Aug 2023 15:42:48 +0000
Message-Id: <20230829154248.3762-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Quentin reported a build error as follows,

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


