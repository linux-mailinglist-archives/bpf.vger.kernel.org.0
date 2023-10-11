Return-Path: <bpf+bounces-11955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A268C7C5D09
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 20:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2C128291B
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 18:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB0412E77;
	Wed, 11 Oct 2023 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebsSC8vT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7EB3159B;
	Wed, 11 Oct 2023 18:51:36 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79A29E;
	Wed, 11 Oct 2023 11:51:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-406618d080eso2297105e9.2;
        Wed, 11 Oct 2023 11:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697050293; x=1697655093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YjuVQHIQgD5W10M1uWpzIJVt7wmnvOPH+yvmEP+NAo=;
        b=ebsSC8vTbICwmSv58oxdUwuWO207pQl6m0OPAm4DvIBE81nnDCiTbvbc1fT9wxRP0r
         h20ze6+LpSD2fIqW2DqMUTu1q1PkTU6hfwb8A4qJR7L0b6HsaLCWr+yFPtO7ygSH0sLo
         JY1bn5SiQ0elEBFDcnzyK7DM6teejrDGLwdm9iGc7GGrxYMX8/B+urWl3Yg5mKpZFMZn
         Q1gjZNuEOrp3x+Iri7JYhLCj+7NO2PYk7zT25HPX6fnkf5/iWoHjV8EBszpc2VOFtim9
         +SAWRitNoV7shzt2Yiz+xYJ8NBYBp7tPVgKhMn28PSNzOL5c9wLeeAZfgfFaFuv888Ps
         Ik/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050293; x=1697655093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YjuVQHIQgD5W10M1uWpzIJVt7wmnvOPH+yvmEP+NAo=;
        b=Lk3LUesl1FzwXHLYGzFCvrd7RUeCYy1inpOSpf4Bva+V7PvsyzYUIgRSi8edx/gHZ7
         zrbzEKQ8TP5OPnVL4LpXQK+ythlWv/5DVJL1HFOy0w4fTYTMRxQFNO/LwkZxqwmn8aDn
         Mm4wFCtvDLHlH0LLCw46cH6MvAqK41iJ2fMoVog6DVMl8sVy641sv431oB8OT8yZ6sct
         /fI5jP5yU3CPqBCnhhxo/aFsEyg7/9LR2WTRxxuuYE0d2bOUtkd7Ndz2YMJglNnIsFbi
         lnaHFnlLXkj+zd4nNztxV78G19huK8JOknO0lkA6Kas1E/s0YemrieIpJuMotYvX6SlQ
         KK5g==
X-Gm-Message-State: AOJu0YyWAgfRUd8QY2NaFJjrO1mpGdac13ezxlYi14mEFOQfWZZ+VrXf
	6JcPFHlxQRHzZPQ7Mj5gxD5bQ0drLSmwMxdv
X-Google-Smtp-Source: AGHT+IE0nfiTluxrivhBYmJZMk4TNDeR1nRN0IFI4kdmIntkNC63Eyc9ocgLbPxTCwenldzm/2Gm9g==
X-Received: by 2002:a5d:4942:0:b0:323:1a0c:a5e0 with SMTP id r2-20020a5d4942000000b003231a0ca5e0mr18654841wrs.13.1697050292903;
        Wed, 11 Oct 2023 11:51:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id h9-20020a5d6889000000b0031c52e81490sm16424484wru.72.2023.10.11.11.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:51:32 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v11 8/9] selftests/bpf: Make sure mount directory exists
Date: Wed, 11 Oct 2023 20:51:10 +0200
Message-ID: <20231011185113.140426-9-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011185113.140426-1-daan.j.demeyer@gmail.com>
References: <20231011185113.140426-1-daan.j.demeyer@gmail.com>
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
index 24ba56d42f2d..5b1da2a32ea7 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -199,6 +199,11 @@ int setup_cgroup_environment(void)
 
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


