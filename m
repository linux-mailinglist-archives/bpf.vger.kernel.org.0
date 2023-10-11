Return-Path: <bpf+bounces-11942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 535737C59EE
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 19:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0942F282656
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCB739942;
	Wed, 11 Oct 2023 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVCJk1GJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298AB39930;
	Wed, 11 Oct 2023 17:03:46 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF5598;
	Wed, 11 Oct 2023 10:03:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40572aeb673so1311705e9.0;
        Wed, 11 Oct 2023 10:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697043819; x=1697648619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YjuVQHIQgD5W10M1uWpzIJVt7wmnvOPH+yvmEP+NAo=;
        b=TVCJk1GJvUpr6DQspCr3EBktIMlhsNlIFY0uz/JDR8mbD/pm/xZnAtff3E40Vq1+nc
         b1xO8qzdFpO0fnEjf9lCqezzL6nKWOgGNiWOFteIyz9VihiXbTbHTdeht0msvgRFCDe9
         IE2tFRkJRfKqS1WTYN4DHsMA+B56YpynRqXQBGUpfzoJy+I1+wQ+LuuXIhCNsg5S9aXC
         SUBCMEaz4qpb4h7uMNPUO4aA0JOBp2oRhTwc7jElDdBY2EJHuGpGnmpPXUQ1705Y2puu
         y7n1XtJ2TZjS/y1AArP0jOc0xQvDexpYMlyaClJbrZ8avdcW1WOmxH2z5HCZVsDv2YNj
         UR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043819; x=1697648619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YjuVQHIQgD5W10M1uWpzIJVt7wmnvOPH+yvmEP+NAo=;
        b=USGEXoqtAUSTnAfCpsXyH++nwZTCbaPmiRVRxfstpUKq3B6Z38LhSpEZgXSF+B3oTu
         Mb8CQeaJPeiIKNrsi/4oFVEtgnOAHw9h4vhvVbqN2m0FL2AQ0UL6HbAFWfSFWWAQixAf
         ea0rkS5LT1lc7RttScaRsQloSL+1TKFvsV7IHAsucrgVHdopbl+VS+Bmm1AgB9pOdzMl
         sUIl7S+rLoRjwQSm75vku+hCBzTJVuwTKMW4hCa5k3Np5R43rxgxmQJmB3MEMgf2MM/9
         NpGVGjFZTB8s+TaT8/zSMlb+AuI8oOC5F8Z8MgSUJCaTXssGxsC+Yb2HZ6FleAgFw8Jk
         JxZA==
X-Gm-Message-State: AOJu0YwP40IKxSgAOoQdfZzsnptbt3qed44uchFe+2QlXUr/VFI9zD/M
	0czzcRCmwIjcHu5l9ct4gGm3y7ppr7I310nA
X-Google-Smtp-Source: AGHT+IE+5LVxhmN+nam0+wHJrv3NnAwqo1RU174ov/pkv/mEPdHMz28eblFI9xOyF65GU/S2eDdgsA==
X-Received: by 2002:a05:600c:3d93:b0:406:f832:6513 with SMTP id bi19-20020a05600c3d9300b00406f8326513mr14703469wmb.3.1697043818674;
        Wed, 11 Oct 2023 10:03:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id h28-20020adfa4dc000000b003296b913bbesm2335480wrb.12.2023.10.11.10.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:03:38 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v10 8/9] selftests/bpf: Make sure mount directory exists
Date: Wed, 11 Oct 2023 19:03:18 +0200
Message-ID: <20231011170321.73950-10-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011170321.73950-1-daan.j.demeyer@gmail.com>
References: <20231011170321.73950-1-daan.j.demeyer@gmail.com>
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


