Return-Path: <bpf+bounces-8905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C552B78C243
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 12:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8013C280DAE
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 10:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8B3154A2;
	Tue, 29 Aug 2023 10:19:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9CA1549B
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 10:19:30 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6FDCE0
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:22 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so63781041fa.3
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 03:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693304360; x=1693909160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlA2jD7/5Fov3zVHxVaFl05n3Jhm1ipRR10MXMbbwdo=;
        b=gDUOqD+BSfa9mewMmtPmgHdckn/y+GzW5UmwkshCfpZEfRjz0oFthsJMUuE656e/1A
         EKvBibUtp7LYOfC00teKPCMOZv4sHvbJXgIaULxBuZCWsouFsnUWCd97mI26oSX69qgT
         aNuSVblo4ljqYMXBLp1IGH1viOEuQP6uKrQe5Z6kMvbqfAXnJ3uUy/APci1DOsmi5Wth
         xkMREDeSn8BFQGhAbzB/6ggFANxPfOpUmd/QfS/bS5HzdcYDJ2kuCq1csLjscyfQIVJ4
         h6Cl0Zix6W3IXPh37aRh99Uk7FlW2dT8Nt23b5HzRRmH9WDGNiqn7SWURiyPWBSSplkw
         4FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693304360; x=1693909160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlA2jD7/5Fov3zVHxVaFl05n3Jhm1ipRR10MXMbbwdo=;
        b=fo6Z1wgSftlFfjZBMO5+wBmLii01IRjaLECwqm0bK9cOP9rA2jGxGGrhoEtUkilm0k
         g6ZL8nyLIhcRT9FuwM7aqwR5N6lasbRzT+YND/F0Fl+40WSu36c6PqhRn1I+Q2MNhXDt
         gBuf4cVNvQlmK+HAncd56JlJ/WTfLv3hoDxqrqISKuFSVTOQDBM2QV/PXxgEJe/RJt4Y
         KELQamICUcviSOCT5BKVsYOXmjw5x+3JyccTkI4GHC0nO0Ek5a10aYMX6eLwb0dmimUg
         LNQgZZX1r4MxMcobiEntIVCe4Cwr2hM9FpBqCDdbCtlyDEHwRUNUB0BDWUDQ1ioCcpjh
         WJyw==
X-Gm-Message-State: AOJu0YwdZdagA84riTzzAZB4yhjLCcB+jWoaHvL/qiSTqd23FRhhiV/Q
	lanVKoJfYh646N5ugpmZK0SSZFmgofG69Pz3PKk=
X-Google-Smtp-Source: AGHT+IFPRilEyPL9SNI5dZZ0BuLhkyYqc7zoPTdhunFXHFsmUw7/PR+act+Rn4sJAOqGJrWBkvST1w==
X-Received: by 2002:a05:6512:202c:b0:4f8:7772:3dfd with SMTP id s12-20020a056512202c00b004f877723dfdmr16654983lfs.11.1693304360410;
        Tue, 29 Aug 2023 03:19:20 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-67a4-023c-67c4-b186.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:67a4:23c:67c4:b186])
        by smtp.googlemail.com with ESMTPSA id f15-20020a50ee8f000000b0051e2670d599sm5545606edr.4.2023.08.29.03.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 03:19:19 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 8/9] selftests/bpf: Make sure mount directory exists
Date: Tue, 29 Aug 2023 12:18:32 +0200
Message-ID: <20230829101838.851350-9-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
References: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The mount directory for the selftests cgroup tree might
not exist so let's make sure it does exist by creating
it ourselves if it doesn't exist.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 2caee8423ee0..860043d473fd 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -195,6 +195,11 @@ int setup_cgroup_environment(void)
 
 	format_cgroup_path(cgroup_workdir, "");
 
+	if (mkdir(CGROUP_MOUNT_PATH, 0777)) {
+		log_err("mkdir mount");
+		return 1;
+	}
+
 	if (unshare(CLONE_NEWNS)) {
 		log_err("unshare");
 		return 1;
-- 
2.41.0


