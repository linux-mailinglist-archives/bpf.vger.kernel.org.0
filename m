Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0187764906B
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 20:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLJTge (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 14:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLJTgd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 14:36:33 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1FC167CD
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:32 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 204-20020a1c02d5000000b003d21f02fbaaso352261wmc.4
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaoYPTAQOA25MweamW5K0tNS7T2q3wT7z4sSwJiVyYw=;
        b=RwJBCXFyUjQk+C4Y/5q7CEycCvc/GnzqaKSWpuDdvyzEU21w22EArmYNnIP+2s4wTZ
         kZzWxdbqdpkSI535miwtlOeilp/5pgcJApi5mY+H437CMIAgsV6i3TI5TUHtva8WYnsH
         KU0jYsLMu2lfyK3E48CcYBVhxmgG9ifJd9XvvUvHGPY4yntwtuwBZ7xwDqHguOUz3SLC
         qR6oZcXXxthYeU9JIUVK5TjN6w0fENqGCQycRBtb30t13tE3UYI8gOG8rnvpOGvNLd1R
         L4Ce7Ukn8U2gqjZzx01K71rcRyCf2zOgjWUwzmo+NaaYZPlxxIHROTdVwThRS8o/Tn/X
         KMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaoYPTAQOA25MweamW5K0tNS7T2q3wT7z4sSwJiVyYw=;
        b=RaTDgY8ZzfArHYz8otqpvbePhaCFcXT+DBgBl0MTyqw5COHc+7OL1scgZCfhkFOuyl
         297YN+qDynutJiCNUJEfi3TR3h+qTgmv69YLm7jfUYVYj3zb3E+OXt6SmqzPKGsC66zq
         X1bjkbGUB4+apG/Cid756OcO8rImW0kpom3FU39gPeu9ybW3Iau/1bcekTpTcXyNBroo
         1QASn+qlV2IzSgKA6i5HzR6P9ihoUKKI3BIh1yqXHzhtqKyexHBu4TZ/H//APF8LdrJc
         XCoJxSq4jleABfeW3eb5rEh61qOJ4Z0rW9qPROmSRXLpp2vdUcbJQj8Abb3/VehyRIhI
         9+hA==
X-Gm-Message-State: ANoB5pkH9DgV0pr6RM4cZXRvNW63+D0Ct7TmH3BGYU/bBbuD8itwsNRh
        AiwATnj3nrskx1+nhCRQjYgPJapPESrl2g==
X-Google-Smtp-Source: AA0mqf7idvLfydq5lGWgGwACLD3hu0xgq7UQMjlVGmt7uBWfUG+SUsFQlIq+n7iQbtjejYaLivQL+Q==
X-Received: by 2002:a05:600c:3d8f:b0:3c6:e62e:2e74 with SMTP id bi15-20020a05600c3d8f00b003c6e62e2e74mr8502061wmb.15.1670700990570;
        Sat, 10 Dec 2022 11:36:30 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:366e])
        by smtp.googlemail.com with ESMTPSA id az18-20020adfe192000000b002423a5d7cb1sm4584676wrb.113.2022.12.10.11.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 11:36:30 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/9] selftests/bpf: Add missing section name tests for getpeername/getsockname
Date:   Sat, 10 Dec 2022 20:35:51 +0100
Message-Id: <20221210193559.371515-2-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 .../selftests/bpf/prog_tests/section_names.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/section_names.c b/tools/testing/selftests/bpf/prog_tests/section_names.c
index 8b571890c57e..fc5248e94a01 100644
--- a/tools/testing/selftests/bpf/prog_tests/section_names.c
+++ b/tools/testing/selftests/bpf/prog_tests/section_names.c
@@ -158,6 +158,26 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
 		{0, BPF_CGROUP_SETSOCKOPT},
 	},
+	{
+		"cgroup/getpeername4",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETPEERNAME},
+		{0, BPF_CGROUP_INET4_GETPEERNAME},
+	},
+	{
+		"cgroup/getpeername6",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETPEERNAME},
+		{0, BPF_CGROUP_INET6_GETPEERNAME},
+	},
+	{
+		"cgroup/getsockname4",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_GETSOCKNAME},
+		{0, BPF_CGROUP_INET4_GETSOCKNAME},
+	},
+	{
+		"cgroup/getsockname6",
+		{0, BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME},
+		{0, BPF_CGROUP_INET6_GETSOCKNAME},
+	},
 };
 
 static void test_prog_type_by_name(const struct sec_name_test *test)
-- 
2.38.1

