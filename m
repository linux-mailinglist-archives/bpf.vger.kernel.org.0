Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7907551885
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2019 18:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfFXQYp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 12:24:45 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:48330 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbfFXQYn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 12:24:43 -0400
Received: by mail-pl1-f201.google.com with SMTP id i33so7577638pld.15
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 09:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2L5BO3TFAcuTUXuUy+gszkDxGDsun5OV31BgOFWHrj4=;
        b=UCuqefck5fwKfeSsXDKvVGT8+ZWbljGseRIo+hA37zKLozaDfG6fZATXAM00NHzcl+
         Dpmv35pUGNfo5VZA4mTwONVcJF2at2WqFWUnQFzt7iA4tGa5HXIDRf9KN17C9UPQPNHn
         hBBTbcqcndHBAWx0UOI47k9uuXZN6FfEZHn3SnRoZRyMKhRhKDTi6UG6+YrRWqFs5rkF
         BGaCBYpeQGeUfPar8ouPXf4Qz307Ic1FBe7QAaaCD+Cwta9tTgiS7Z3O/+NkV1HSbLjg
         4d1jO088WfWAa9wn4AV3cE7NjOx8mTDvT23YFXzQqyS/p+rMwqoo8RM2Yf8Cfc0i9UQJ
         qdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2L5BO3TFAcuTUXuUy+gszkDxGDsun5OV31BgOFWHrj4=;
        b=Zqg2spbXF5w0gs5ZHKyVp1XuJE/e9N+RLi4oZR9OW1W7XOt1ZqDsYA+TUUHqSDVGjg
         9hiBus33aIbRC6oRpp5zoBLlcV/eWO/8bBgrZIWSNHvSs7vF+2uKZVwqq/eUTVD67OKo
         JRq8XW5Fe4AOX1vuf7MZSlmF16DQZpYKD6Vxb0duvxMgvBKEvBs2Q5mRaiAQHKiaPGgF
         skJPinTdTTdv0t1nwu5rr+5oq59kDypf0LWAC2d3eVLkPGGZ25y17u4CPHSzhlMKAmGv
         ovv7AJLAIcsMKSXeiRBWmWCeEbPLpIScUTcnMgU7CMqGptuWiyP8VFVylpTQ9q7jKXS4
         qoXA==
X-Gm-Message-State: APjAAAVXKnlXdgtkQ9q+3Imfbu5+q3K84ZhTIQRhvLv2z2EhXYH5fZLA
        GoYJQS6RBEyy3CA9hIg0pg+ZROY=
X-Google-Smtp-Source: APXvYqyqVC0q1+YWgzdB5oDO3h7jmL8WpYtJdIhhW3YFTtJ/r9brcI2jgWkDOqgrpQrZvrsNRcUq7z0=
X-Received: by 2002:a63:3683:: with SMTP id d125mr11329611pga.252.1561393482878;
 Mon, 24 Jun 2019 09:24:42 -0700 (PDT)
Date:   Mon, 24 Jun 2019 09:24:24 -0700
In-Reply-To: <20190624162429.16367-1-sdf@google.com>
Message-Id: <20190624162429.16367-5-sdf@google.com>
Mime-Version: 1.0
References: <20190624162429.16367-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v8 4/9] selftests/bpf: test sockopt section name
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests that make sure libbpf section detection works.

Cc: Martin Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_section_names.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_section_names.c b/tools/testing/selftests/bpf/test_section_names.c
index dee2f2eceb0f..29833aeaf0de 100644
--- a/tools/testing/selftests/bpf/test_section_names.c
+++ b/tools/testing/selftests/bpf/test_section_names.c
@@ -134,6 +134,16 @@ static struct sec_name_test tests[] = {
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
2.22.0.410.gd8fdbe21b5-goog

