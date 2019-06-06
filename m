Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C9737B84
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 19:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfFFRwA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 13:52:00 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:35653 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730344AbfFFRv7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 13:51:59 -0400
Received: by mail-yw1-f73.google.com with SMTP id d19so2709939ywb.2
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k+Brm8PUBExjWcHqIDpG6xNNa/FsZCQsubsibU0l2Vk=;
        b=Qywn5ijBycEily7sluOTT3mS0gxokAFikJ+sLb++TYmzEV+/9v2TBCLxUfBENAea+V
         Yh5yCQTz3Qi9AMB0ArMkATiOVk1eLVxx1Riuz8ya9t7iBCRry888zCw4RRiECHdvWMWy
         SUuPvHsSI/H/4wOlx9bKtNZ1qwKmRAuMmlb58odcEOCuhztsPJqcjaZWta77l4NUI68r
         BQ/ywdht4yJgCZ2pVT8xGzWZttQteTe4cEIjEKsmVjtFweF54uJQb/YuA7KGyS2xUzgi
         prsTBWrrPPL0zrsudAJksWDapKHhe3hL+PXFIWZIiEHkamp4kQZuYyhbaFdgjXg70zkM
         psPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k+Brm8PUBExjWcHqIDpG6xNNa/FsZCQsubsibU0l2Vk=;
        b=aHCZe784iuG+yjwW/4urd+Qqolz0yHRik80PGxbty8xRMQBAAKAisFKsSZhScUaZ6a
         ug1kpC3O6KPB+lyX058tx+gS08jNaJnc3bJlVc8LDrQrnSCG59D0hxr2riERLsye6Ndr
         hEhfhYj81YU4qkhaF4GffyNeTtgiYex1g8NCMh1NWBZMucv8nsPyuNxdba9DctDRCIgi
         JEmMAKzCOTWpVaJgqFx6vjQ3U7fTfJQe79RdS52QSpeCiFiMmKD2rJSAyL17+u6dA4rV
         rvXeSP0LqP/gcSX/Ez6wC9HI8lanQm8sS6DuYiyLOf7qavPS1MoHl50WF/2hldDCIx7U
         1STQ==
X-Gm-Message-State: APjAAAWTIhasEh7Xt/+ijevFr+9ooKl2vDZmVo/mVk7hcMxtr5mecsaS
        vn/vot07dDoWwExfPj4UywfQERk=
X-Google-Smtp-Source: APXvYqzbNJc+UA1vtLZY/wMWLc2KlyEvdUwEQABOc43aQT6T8llB8HS9/CHai0rzJO3sBmjWufE9I3o=
X-Received: by 2002:a25:ef42:: with SMTP id w2mr23913697ybm.440.1559843518728;
 Thu, 06 Jun 2019 10:51:58 -0700 (PDT)
Date:   Thu,  6 Jun 2019 10:51:42 -0700
In-Reply-To: <20190606175146.205269-1-sdf@google.com>
Message-Id: <20190606175146.205269-5-sdf@google.com>
Mime-Version: 1.0
References: <20190606175146.205269-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH bpf-next v2 4/8] selftests/bpf: test sockopt section name
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests that make sure libbpf section detection works.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_section_names.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_section_names.c b/tools/testing/selftests/bpf/test_section_names.c
index bebd4fbca1f4..5f84b3b8c90b 100644
--- a/tools/testing/selftests/bpf/test_section_names.c
+++ b/tools/testing/selftests/bpf/test_section_names.c
@@ -124,6 +124,16 @@ static struct sec_name_test tests[] = {
 		{0, BPF_PROG_TYPE_CGROUP_SYSCTL, BPF_CGROUP_SYSCTL},
 		{0, BPF_CGROUP_SYSCTL},
 	},
+	{
+		"cgroup/getsockopt",
+		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT},
+		{0, BPF_CGROUP_GETSOCKOPT},
+	},
+	{
+		"cgroup/setsockopt",
+		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
+		{0, BPF_CGROUP_SETSOCKOPT},
+	},
 };
 
 static int test_prog_type_by_name(const struct sec_name_test *test)
-- 
2.22.0.rc1.311.g5d7573a151-goog

