Return-Path: <bpf+bounces-11527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A727BB29B
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 09:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7D12826B2
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 07:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD5212B9A;
	Fri,  6 Oct 2023 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grGAp/cS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC777469;
	Fri,  6 Oct 2023 07:46:00 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCFDEA;
	Fri,  6 Oct 2023 00:45:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso17478565e9.3;
        Fri, 06 Oct 2023 00:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696578356; x=1697183156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YjuVQHIQgD5W10M1uWpzIJVt7wmnvOPH+yvmEP+NAo=;
        b=grGAp/cSaVNe6PplCRUdD/xiAZTqb1hGMVWBlXoBc9FofQ83oW3gz1XTZQiXLgw1mn
         kne2afYhoT+e1hAsMdq1YMJ02AG0NO4yNsWOQVxug1Jkp3+hYydMO6O/ROQqtabEZ/Q8
         vZsKVL0wRswU6lu6q1UFX1+IVSGThd4mCeXcSxAIigZXWCOQJ0ZEjvmxsZN2rEPEpKBm
         TaWP6AuesZWoOxyXafhxs+8sx0SRpvFepx2T5Z2GlUFsPZ1yC5myICOVzFNw45y60aoe
         2toA48pMNwAuooHQ9/SD6+xtYIefcpUkmHAtVR3KDPHOg9sUcFcAeJAcAxePKpp0KsOb
         pxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696578356; x=1697183156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YjuVQHIQgD5W10M1uWpzIJVt7wmnvOPH+yvmEP+NAo=;
        b=NSHZba5wlnVGQ/bDwsiAIiHYh+V6YX4Nk71Y8ft7f+3oIbfetrWKjJp7ur0EmvFMKy
         fpTy0UWIugGEoUDpXSJu58x+xXWMyYjNOJNB67SbTXdIOe8iCT8iHF0RjkQL/7Le0zD7
         ids51ueFs5IOx33m7/TPzogCyd46Gy3hfYfUPYrvKlO4hwdcwTOSX0MRLwJlw8r3BWLH
         eYku0gHyajrny/oPJ/3mLy5k+IJHeFa6cOWuf/gUXGVGouZnqQgo4fYhJLkhkvE7GvMR
         ccOmcFJT5ycxCNeYcOnIRuMQcMTGJj9IdNGJaRNpbfVwAdA9eyBYpMeySoPpzxDy85o+
         ROzQ==
X-Gm-Message-State: AOJu0Yw2YXDXFgD7nyHRAEp67Yzwt6NHxfIVa5qvJW+8tfVcdnr4wglc
	EEhoB6fGm+Dhfo9OwwfSFIwQ78Edz4wPIQPA
X-Google-Smtp-Source: AGHT+IGixg2GXB3fWZFkTY3WA7q0yarvmrSMgdH9suXu8AZRL5jk34L89PwOXZxjid/2i9qZiZBqMQ==
X-Received: by 2002:a7b:c4d6:0:b0:400:419c:bbde with SMTP id g22-20020a7bc4d6000000b00400419cbbdemr6757433wmk.18.1696578355984;
        Fri, 06 Oct 2023 00:45:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:e534:34f4:1c34:8de7])
        by smtp.googlemail.com with ESMTPSA id k22-20020a7bc416000000b00404719b05b5sm3126888wmi.27.2023.10.06.00.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 00:45:55 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v9 8/9] selftests/bpf: Make sure mount directory exists
Date: Fri,  6 Oct 2023 09:45:02 +0200
Message-ID: <20231006074530.892825-9-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006074530.892825-1-daan.j.demeyer@gmail.com>
References: <20231006074530.892825-1-daan.j.demeyer@gmail.com>
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


