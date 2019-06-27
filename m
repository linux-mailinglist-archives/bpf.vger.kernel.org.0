Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A5458BC7
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2019 22:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfF0UjJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 16:39:09 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:36837 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfF0UjJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 16:39:09 -0400
Received: by mail-pf1-f202.google.com with SMTP id b195so1882643pfb.3
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=axzDTyujNDDUo8hYgpJ8wFZojv2hAsxN7xd8iorthG4=;
        b=ClAAJn3dnqZJXhl6rH+nelVPYc52FZq4Q+ahWd9XGROCHNQLQQ+GGUAjz59D6OR1Jk
         jpwCSzwV1n9zXHjxI0A1wRoT9R3eqMBR4hXL0QiNR0gimT6Ywa/uSjO6X+frBmv5uW8l
         6lUKqepSE9bQbhVZEOmd3DmqKu8wE1ZzlYNdvHQYLrfQXX13oPiqFz/bv9baVAxBIW5A
         PlV+tVa+vQmqju1yjlE0SDs6TvPybwj/o50VD7RNJLywu8XC02uwBE+Lr5jjJrER6MLc
         3QLVr9Nr+Blcp1ul+puF5Fv1u6HdIryh2zoilbgCY+dmGBNRhCbkU8J6/T5a4bzONUXx
         GErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=axzDTyujNDDUo8hYgpJ8wFZojv2hAsxN7xd8iorthG4=;
        b=BG+sbFCUcRYkozb+LTgehI1DeEGaNbaBEhu/WdYGMiqM4GjUm1AspR2CmhLmgzApZ/
         xQZyM29mIQJW7QYnXZnGsVkLkwD5TW3boKENBY6uRrHdnywlPxnUvNaZcl7paIgueYY1
         ItIfVT44oLuV5Uta2RFQDLKFGoY2m9T9TMi8y2wYPEv6+kmmYKWZoK9rqClxV1dPom6H
         bN+4YzNxrQOQqSbRqEaI65Sof7aVRSHYAwcYchC3XW+8uI0z4IQnCACZtVj6cQmmzYnx
         ONA5Vkwdd7tXXrnvkiUtqRPvGxlW4LA2br6lvgu4yMljElPjbg01Vm/I1ScMkJ8LbjgX
         JBrg==
X-Gm-Message-State: APjAAAXX7qG1OeDRpDerTCjvqRruLG1Wv4u+CrbzmJrS1Ei/4WvhKL+H
        VNCRrGvkjXqzkgd3f4xzB+iJdN0=
X-Google-Smtp-Source: APXvYqyZuc2PcUfyMb4ySy+6N/D3iTk05tFHPRGM6ASL2gC/m/WRBDFtG0P2gLT9wFL0fLlOyCGpoeI=
X-Received: by 2002:a63:4c52:: with SMTP id m18mr5086260pgl.302.1561667948206;
 Thu, 27 Jun 2019 13:39:08 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:38:50 -0700
In-Reply-To: <20190627203855.10515-1-sdf@google.com>
Message-Id: <20190627203855.10515-5-sdf@google.com>
Mime-Version: 1.0
References: <20190627203855.10515-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v9 4/9] selftests/bpf: test sockopt section name
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests that make sure libbpf section detection works.

Cc: Andrii Nakryiko <andriin@fb.com>
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

