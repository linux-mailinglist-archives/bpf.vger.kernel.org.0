Return-Path: <bpf+bounces-11263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8447B658B
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 11:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 31D181C20842
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 09:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DA0208AC;
	Tue,  3 Oct 2023 09:30:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865DDF64;
	Tue,  3 Oct 2023 09:30:49 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66B0AC;
	Tue,  3 Oct 2023 02:30:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b2cee55056so117261966b.3;
        Tue, 03 Oct 2023 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696325446; x=1696930246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YjuVQHIQgD5W10M1uWpzIJVt7wmnvOPH+yvmEP+NAo=;
        b=OL1sMg+GoExtE71V1lX0MbjwFOZ3Lx5c7SdX8mctHlCDTW4qVj/t8EVEt8pPP0JGLQ
         Q8Fo6Cs8VlQcslvTWXDViQmhdJwlcaZGn0lJ87CcIdfvFxhOujgDJQHnpf4rvXRVCM6w
         Z/vO5I5NRK8lFbUV8OFveocR1RZhgNLWMUtsL8k5nqsx/wBQ/k0yNr/Ue0KmNolnHjJq
         UGxV2nNke+k1FwXHE0BHZh969bxy0NpL8cyQ0UdA91mvsHtKKjGH8/blzBYXXKu0ylaG
         HJOZcNm7+ofDbLm9LoyJkysdzmq+bK0q/6/PwAqDrAIp0KSJlXur6ZQNhq3jKgTTumCh
         1zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696325446; x=1696930246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YjuVQHIQgD5W10M1uWpzIJVt7wmnvOPH+yvmEP+NAo=;
        b=Pf9bviyOGjTdHmYoUqwnxqFahR7rRvZ1nRA0QAJCN/MOezfAl+A3jyQY//qyQ8pJwa
         ryNzoQH+YRjq7eYmpmceUAy4SYLZT2RrAr62IQYm98eljP/IvC0gbw2ZM10Ws47OCuJN
         a1xYnkug/7sx3f7+wquDcHj20l4s4BgiFWiKY155ZZp3VdAM85OfdJxkK1l/p0O955j/
         89CpJ4ZYQh5Z8a03Mhlc8Ak6S5qNY2Bf2qSiZ19QMOC48OnNur5GlJoaesFMqJB+yRar
         40BYEhRXA2jn2spYSs58TjQd49FaHLKVnza19YOWpBRgp3GUZydWmGAg6ao6H8sa0UY2
         BCDg==
X-Gm-Message-State: AOJu0Ywrtby0VnIgaT0GFtL9op0XPTFDe8MhMNBtTNyOgimEpshQZCrI
	epy9ZKvnUZjc0OILDJro89E7t9iEqqe9YE0y
X-Google-Smtp-Source: AGHT+IGOs2CuZM6te65RHp6FO2eVH/iCMuc0GSBxcgb1ya/kErpWvwqj9CDlN/IZ9IJpyP8Et9tUjg==
X-Received: by 2002:a17:906:2243:b0:9ae:522e:8f78 with SMTP id 3-20020a170906224300b009ae522e8f78mr10380791ejr.74.1696325445811;
        Tue, 03 Oct 2023 02:30:45 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-15f4-3ba0-176b-cb00.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:15f4:3ba0:176b:cb00])
        by smtp.googlemail.com with ESMTPSA id g5-20020a170906594500b0098f33157e7dsm749851ejr.82.2023.10.03.02.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 02:30:45 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v7 8/9] selftests/bpf: Make sure mount directory exists
Date: Tue,  3 Oct 2023 11:30:22 +0200
Message-ID: <20231003093025.475450-9-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003093025.475450-1-daan.j.demeyer@gmail.com>
References: <20231003093025.475450-1-daan.j.demeyer@gmail.com>
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


