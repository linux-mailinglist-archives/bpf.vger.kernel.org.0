Return-Path: <bpf+bounces-11197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1687B532A
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6740E2847AF
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 12:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DCA199AF;
	Mon,  2 Oct 2023 12:28:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60237199C2;
	Mon,  2 Oct 2023 12:28:19 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C94B0;
	Mon,  2 Oct 2023 05:28:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-533df112914so17493423a12.0;
        Mon, 02 Oct 2023 05:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696249694; x=1696854494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YjuVQHIQgD5W10M1uWpzIJVt7wmnvOPH+yvmEP+NAo=;
        b=WKYNRMogmzlwxVf9B9V+9nn6an31bHUDALs6ePTSOJhNplsmqYQFXidAglT69BKJzw
         R/JYJ36uR005M76+kbHCu03jyxWE1pOJxKCj/iiwg6KXgtXhJFBB7GNsX7+LOceEDtc0
         vZVw3uKE+kBmk9wLmeAZDByidFdznhvMAGZ5Kar1+OPPSNlYEaG8hGM+HU4BPABJoGTM
         6NPI9hy+cHD4nlpbgptyjwjSam8MqNgb+JHMH2DbSmK/9/ZPWUR4nad16qPo9V6oZoes
         +g/nfzz8zBcU7YawydN0xrubDVZVB/QwG6MTKBmIFyVAEJ1Bb6fE1Du8isFR4URUJTCE
         ePUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696249694; x=1696854494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YjuVQHIQgD5W10M1uWpzIJVt7wmnvOPH+yvmEP+NAo=;
        b=LfxkrnhnqA8qZoRZifU1fVt83GA3Z9jQOiabzUndg9hzP01vEl2SKqNjqfYI3NJPzm
         S2MV5B3oH8scY/pHfPL9geC32PC+6yg6a3NUlqCYOOipy8lQkPTejmYFOiaZF3WdLlM2
         uVpAasrSw8ZeY8osBbUiy4wbU9HGr/icRjNDE4f82jKWqO9TNedRrKObIoHIT0He6Qrr
         /20iKMy+LkA6R25FV5pD40z0oa9kh/XQtxAqj0QIX0WoiYS2xHllsAi+J4kF5f3/d2O+
         NpbVLULGmOzdKkBP0zK+Pp5/UlR4NH/J83fAfmh/MZflbrhGSYu8/NepEiR6xOHB/vAO
         DZsg==
X-Gm-Message-State: AOJu0Yy1y/9cm1TEC7v14Xpt9iv6xsY1Oedmg51N2cvm5cdRIbSXXuMB
	Ug1CSaxHt0aJSruvJEj6EoVqKdxxiHDzk78q
X-Google-Smtp-Source: AGHT+IFt8hnT4eNx8TWv40YEG7XF4LK6AeSBRPeeM6yODI218Pp+440VPZjFEyXZ3LZ2nkvF9r9N9g==
X-Received: by 2002:aa7:c749:0:b0:522:3a89:a7bc with SMTP id c9-20020aa7c749000000b005223a89a7bcmr7675247eds.42.1696249694437;
        Mon, 02 Oct 2023 05:28:14 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-aa0d-0bb2-d029-8797.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:aa0d:bb2:d029:8797])
        by smtp.googlemail.com with ESMTPSA id v10-20020aa7dbca000000b005330b2d1904sm15263099edt.71.2023.10.02.05.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:28:13 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v7 8/9] selftests/bpf: Make sure mount directory exists
Date: Mon,  2 Oct 2023 14:27:54 +0200
Message-ID: <20231002122756.323591-9-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002122756.323591-1-daan.j.demeyer@gmail.com>
References: <20231002122756.323591-1-daan.j.demeyer@gmail.com>
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


