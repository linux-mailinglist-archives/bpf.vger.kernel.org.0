Return-Path: <bpf+bounces-9081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1191878F07F
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 17:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06AA28164E
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AA31643D;
	Thu, 31 Aug 2023 15:35:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376DC16413;
	Thu, 31 Aug 2023 15:35:24 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4275BE4F;
	Thu, 31 Aug 2023 08:35:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-977e0fbd742so106818166b.2;
        Thu, 31 Aug 2023 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693496121; x=1694100921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5t+zBQuHK7J2v55Cd/nUoBpjLhPWqb/Jbv3ggXNu9ck=;
        b=RgcSi96U1RUMUDHkcZsFwv80w7ZUZqR/3gd4cEellBoYkGF8L3suXDZ9uch0+htOPv
         y7/gzjSlSaDBAfog4AXqqf41ZXQsCrySOJuJoC9rMqU34KTAmXmsm834/EF9h3jYER4x
         umo0Oxg6McAI1VgQvCjpAcHY6uJ/rdI7atDD6kA5Ou9zbsexG7l0QyODPj9UUPjjwLhZ
         wOLCS1xKEfryKECaPkZOYKq9SE8/drBIpguzMMC8TX5i3kZ8XTQtFkFLH3fcLSBkHJsR
         SZUg4ULbNKCvG/owW5JxknALbM9O44u8f1LDHzmcYYZtOe8dQIwf/JCt+kSnrVdBt/PH
         xKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693496121; x=1694100921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5t+zBQuHK7J2v55Cd/nUoBpjLhPWqb/Jbv3ggXNu9ck=;
        b=jNPUBgQVwyi+Za3dkQZANWK+/ZxmO0//IM9BrjAS79iiGwuEUmh5WFz2uKFwYMAuBX
         emUXSCHHgEYU4Y7y7zOTZu6lsjTR5S9Wwk6eAyJGSawuXPNVLk8Y74M/2gzpoUxkwj6c
         KatjNIwxmZfyUZBZpsljUf+SJwlu0aEqy2kj0ParjwDqd0wAXl3tjSbAiydiQkykFXfx
         r9vzOWp1tKfYzmmokc33vrDS4zpJ2VBimpAo58ueiZKTmMJKA2Ya0WFFyEKhuS+XF2IM
         aKVQZJ0fjp23HkJXv7qG1W26CZ8UtRaUKxDfE/Gnu2N8yI/AW6gVyq4cc+OO+0q1T75t
         7dKw==
X-Gm-Message-State: AOJu0YzNSJpzAdbUXOHDRjb+B2Z+dymEMi5V+YL8jVvODnGNJ3fSNDdb
	oOztmDm9CqAztV9KBChnudOSnfKfqD3ajvzoht0=
X-Google-Smtp-Source: AGHT+IG28aSla33NzSNLI0uU3fqwkrvZRBxJhOIYcjP/NEEiiR8ZK4cBSCy1f4e5T1mkRcg6vL6IHg==
X-Received: by 2002:a17:907:1622:b0:9a2:2842:f1c6 with SMTP id hb34-20020a170907162200b009a22842f1c6mr5416199ejc.28.1693496121452;
        Thu, 31 Aug 2023 08:35:21 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:a62f])
        by smtp.googlemail.com with ESMTPSA id ds11-20020a170907724b00b0099bcf9c2ec6sm868583ejc.75.2023.08.31.08.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:35:20 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 8/9] selftests/bpf: Make sure mount directory exists
Date: Thu, 31 Aug 2023 17:34:52 +0200
Message-ID: <20230831153455.1867110-9-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
References: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
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


