Return-Path: <bpf+bounces-10901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560FA7AF527
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 22:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CBAE4282BA6
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 20:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206424A551;
	Tue, 26 Sep 2023 20:28:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16664B22E;
	Tue, 26 Sep 2023 20:28:18 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CD2139;
	Tue, 26 Sep 2023 13:28:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso1843899866b.0;
        Tue, 26 Sep 2023 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695760096; x=1696364896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5t+zBQuHK7J2v55Cd/nUoBpjLhPWqb/Jbv3ggXNu9ck=;
        b=X/P10Qj93CCkxJQgjn4FyCVqAm69SjWqtAAVdEyPLJ+cmMo3Rj87DKQnq00f/gJvnQ
         8SO6827olEl4ATRkglQspRuYA6bFHCIFgCt7Jm7aAFs+ywDgciDjBjW6TEWfVg4hrtJR
         KjG5nqUkv9+Fc/ddLuWtmedTL6byNc1fQcifDKIJY0tBvGfBHFrUKU/vGSXH1iIHmJB0
         xQUWtzEVM0EBlC2uA6l0Uv+MOJmzFroHDcQfFZRaYIDd94P1H17W9QmDaK1KYyS77f2/
         ycTvsReO+AznU1cBBmcwJ5JQzUl9/Q9H52+AkMGvoVbokzz00/9GnazwhLLjeh0ppwYP
         YtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695760096; x=1696364896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5t+zBQuHK7J2v55Cd/nUoBpjLhPWqb/Jbv3ggXNu9ck=;
        b=WS1yKKitobyZZ3mlEIQL2jer2XNQ+L3akjdfc6jpSnnqQIM9Npb0kqVHBIyQ/szMIe
         sILOaDCHH+dT6hkq6i7meUANKipiUSnafO5+fU14UqtSAyYbnejrPdFML8yt25uk1RBc
         o/WSUrJnpKzCh8c0cXiLW1LUrVxg44DbXkg9WzrdMA6vjOYygPB0omtGQoDQJrPkouni
         YAHZX2tN8OHD+NC4bODvng2iuAJf5A9RW0W4/rGQQyuHKWywke0KhD/U6bUwBCdP/1bN
         qhQQmjiV187Y5WW6p/tEn1oyQN+x1bHvOybXyAubRlUGkna9RozFIDfMAYJiw/+H7w2j
         DAYQ==
X-Gm-Message-State: AOJu0YxawhpoV+pthrsHlO+ZQuqd8pEQq6mA5fys9RkD3MewmEQaO+TX
	+f9QK3hzdXilkz16dFudngzhle8M8ehW9P6R
X-Google-Smtp-Source: AGHT+IGopEzvk6AB3ATkiTL+OeS3HR/OZ3Y1h2BO59qxdysO7dbjhWdmsQg2cfrDkiaqokCMrgDzWw==
X-Received: by 2002:a17:906:76d1:b0:9a1:b85d:c952 with SMTP id q17-20020a17090676d100b009a1b85dc952mr9811ejn.12.1695760095738;
        Tue, 26 Sep 2023 13:28:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id c19-20020a170906529300b00992e94bcfabsm8204664ejm.167.2023.09.26.13.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 13:28:15 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v6 8/9] selftests/bpf: Make sure mount directory exists
Date: Tue, 26 Sep 2023 22:27:47 +0200
Message-ID: <20230926202753.1482200-9-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926202753.1482200-1-daan.j.demeyer@gmail.com>
References: <20230926202753.1482200-1-daan.j.demeyer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index 2caee8423ee0..6dcf0cd375c4 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -195,6 +195,11 @@ int setup_cgroup_environment(void)
 
 	format_cgroup_path(cgroup_workdir, "");
 
+	if (mkdir(CGROUP_MOUNT_PATH, 0777) && errno != EEXIST) {
+		log_err("mkdir mount");
+		return 1;
+	}
+
 	if (unshare(CLONE_NEWNS)) {
 		log_err("unshare");
 		return 1;
-- 
2.41.0


