Return-Path: <bpf+bounces-10558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9F77A9C20
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A382827AB
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82624405CF;
	Thu, 21 Sep 2023 18:10:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC9171A8;
	Thu, 21 Sep 2023 18:10:44 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D576AF69A;
	Thu, 21 Sep 2023 11:07:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c108e106f0so21888911fa.1;
        Thu, 21 Sep 2023 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695319640; x=1695924440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5t+zBQuHK7J2v55Cd/nUoBpjLhPWqb/Jbv3ggXNu9ck=;
        b=atLYajckDJjCAgUSOOS0esn5uCpHZo5eQ05Zn06TYr14Jf3tFcRui1Dk6q+MiAKwA2
         Ix1EydI3NAO8lYhdbkxE3be5mqtyi9DXAJiIbcbjQd7hwWdNvPYj/eWaqSGXTV6AldAM
         oauh2OkTzJrObZEhCLCuzwsM8/en0vB8Jwo5/GTuMXZi7Fu6wGtewOubmh/wGzwQbPET
         YdrnMcH8sOqkc+MlKcfJMNu7AxnN3sTI2ZTUU5zvc9EXGVIt0XTNkRayQRmbWM9n+c5d
         XLPn+QL6/4E6GH+xMJX4SbZUXQVp4P4nEabQQ0vJjYV64sQoT06zYPyWRi49OM4lWgcP
         Ekig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319640; x=1695924440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5t+zBQuHK7J2v55Cd/nUoBpjLhPWqb/Jbv3ggXNu9ck=;
        b=twDm0514psZwKLfXQtmCUSpJRIT62HFzhgXo6Mso9p1F2sV1i/TMiBNDLxHHtBN3ba
         x5OEMcjK7gge7s8nZ3DBl2FdAYAj/B7P3l+5uPqnFRToLYEbGP6sDdlO3VAQdBliJ6tg
         6shJ+9cKvK57wiApOneODMSuzHPy5rxF/Ydifs9EHuu/g9N7oP5R4s85/FIaRnN7d8fF
         SIwzta2WM30e0tyNz7bV2EzFtUfDT73D1I+OD5UQUZ2Yad/CmDIMdSPYMruh4b1AhVFE
         xs/ukg8a6y5H/SIiSllmoOw852pYi+fkqiXffbW35DGqLvzIiuaPnr452mBPHEZ3Hvp6
         IBEw==
X-Gm-Message-State: AOJu0Yz6FS9jnArkBgnMtMKiIudH9/KEo4HXsemavTANSyI6u5A/QRCN
	pyP1hYcyPDg8UTRlyHsIFvR5MMFElcGYrHu2FLY=
X-Google-Smtp-Source: AGHT+IEsF4k6+4hSypg1cAgtjFoQNRSEnFY2zhy/I4OJXwoQHyIUTn1zt+SY4Cb3FhSOwMk12jwVfA==
X-Received: by 2002:a17:907:2ced:b0:9ae:6648:9b67 with SMTP id hz13-20020a1709072ced00b009ae66489b67mr1004642ejc.1.1695298177299;
        Thu, 21 Sep 2023 05:09:37 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::4:2a59])
        by smtp.googlemail.com with ESMTPSA id gx10-20020a170906f1ca00b0099cb349d570sm952258ejb.185.2023.09.21.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 05:09:36 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v5 8/9] selftests/bpf: Make sure mount directory exists
Date: Thu, 21 Sep 2023 14:09:10 +0200
Message-ID: <20230921120913.566702-9-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921120913.566702-1-daan.j.demeyer@gmail.com>
References: <20230921120913.566702-1-daan.j.demeyer@gmail.com>
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


