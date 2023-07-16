Return-Path: <bpf+bounces-5068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AD0754E92
	for <lists+bpf@lfdr.de>; Sun, 16 Jul 2023 14:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE61E2814A6
	for <lists+bpf@lfdr.de>; Sun, 16 Jul 2023 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF348825;
	Sun, 16 Jul 2023 12:11:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3EB79C1
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 12:11:02 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5C710E
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 05:11:01 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6831e80080dso2366721b3a.0
        for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 05:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689509461; x=1692101461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6bydLkzhMc3r2IRFMFsEVdVArhhEy6BXo6ljUYKD2o=;
        b=jcstni45c961WxcwMSxSTHmDySMkZLQHs8P6sk8AjU8tFD/uHCInXCob1wGR5hh8UY
         jWWt/+mZB81liVyTrgmdLVBiuD3zh/6t1HH6Y24UFUsWZ5ANB04psIBmcmBwp8oQ3LEu
         pYvOtLF16NyiMGRoNUNhy8vSrZN/TdH45DdxMal1nxjyMKgngqeGJcvrPLZZSZSx3n0t
         RXj8Cjaj6/ut7x+XFGqnR0Ve3HKTNTXh69QF9OLD47BiwMVc02fPDKk0p0Cznepsq51A
         yG9TwCrpiBBLyshxw2GYurGwlzod/a4Y0q0b05i9k6+RE4gvMsjKwP0rxZGtv2WQ1Rbl
         uC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689509461; x=1692101461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6bydLkzhMc3r2IRFMFsEVdVArhhEy6BXo6ljUYKD2o=;
        b=Iq40F2dsKGKcfBNnWHoUwph7DsEDbjjvjO2xE9dgRNk96HGMUXTMCYuHdkUC3FJlSp
         ZoJ3LmKAwb5DnyeOSbOp7jaxT4E5zbwCEiW2gk98HFwaaGCKEefe3yrcDbflHVSwrbzJ
         CilAs8kZvs1WpuTIlf8TFWjC723TzN0+Ht7Hi6XGG4bExRzJUgTHoBEKkFd1sv7zfI0s
         aqfxJGD+EKRKcxgM6c4cdnoObJnQHXP/8NkbphupqdxgzkgPGewhGlz7LMCy/BNid5Lb
         4OeUzHRCS1Ba6/knNvAc4A21j/B0csyMVPYwyNKddgKnCmB6Lmnc817MuizQmfuOdbCw
         nwfQ==
X-Gm-Message-State: ABy/qLadgvWuXZcgzTV0jdbZAfYDYHw0rYFSVnf3ADvZ3i1Pa4Gi3OPN
	3p9/vNKQe2kBblzaoOjkBAQ=
X-Google-Smtp-Source: APBJJlFvCCKTkgcR1c2yMUqf6IS0tRHNmMArN6LqoSx5PAs48XCkT2dtv6z4faSgjFR7iZKK9pGEeA==
X-Received: by 2002:a05:6a20:938b:b0:126:f64b:668e with SMTP id x11-20020a056a20938b00b00126f64b668emr11039898pzh.5.1689509460830;
        Sun, 16 Jul 2023 05:11:00 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:697:5400:4ff:fe82:495b])
        by smtp.gmail.com with ESMTPSA id u8-20020a62ed08000000b0062cf75a9e6bsm10128730pfh.131.2023.07.16.05.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 05:11:00 -0700 (PDT)
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
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 3/4] bpftool: Add support for cgroup_task
Date: Sun, 16 Jul 2023 12:10:45 +0000
Message-Id: <20230716121046.17110-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230716121046.17110-1-laoar.shao@gmail.com>
References: <20230716121046.17110-1-laoar.shao@gmail.com>
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

we need to make corresponding changes to the bpftool to support
cgroup_task iter.

The result:
$ bpftool link show
3: iter  prog 15  target_name cgroup_task  cgroup_id 7427  order self_only

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 65a168df63bc..efbdefdb1b18 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -158,7 +158,8 @@ static bool is_iter_map_target(const char *target_name)
 
 static bool is_iter_cgroup_target(const char *target_name)
 {
-	return strcmp(target_name, "cgroup") == 0;
+	return strcmp(target_name, "cgroup") == 0 ||
+	       strcmp(target_name, "cgroup_task") == 0;
 }
 
 static const char *cgroup_order_string(__u32 order)
-- 
2.39.3


