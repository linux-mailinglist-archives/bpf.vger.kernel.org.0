Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4174146EDC
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 18:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgAWRAA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 12:00:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34250 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729797AbgAWQ7s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 11:59:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so3945960wrr.1
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 08:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzJSOoo0RY3SkOVg99jXaD0hCIShOjvh87S5WEoUKHA=;
        b=rmcV1F+uEgQl1C9Bw8jxZiHVIX5+T5T3sxYSgR7I6GG/JUWe0M8tWN2DUqqzWdoYgX
         N2B0KivXpJcrI72myxxmd5mlC6uuOjeJuGV48CFZb+1C4xJ7slk65KxrEZJDZHcr+vJB
         gTkFp0ARrz5plhGXPSwjmnDPxsDwOS9CKDuE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzJSOoo0RY3SkOVg99jXaD0hCIShOjvh87S5WEoUKHA=;
        b=N/Cp2Lcyumci+MIdvLImrhJp1QluBNc71FCS/sBrWzjBHQYXvSWApkNZ5mUlswWsVn
         W7rTnD/iDDcNj/KqRGeN5aeCHDtezbsWclXogyiatdif/7q1k438Ytzwgkbllr4Dj4Dp
         MVdGyZjreRDL+rTPwJ1N1IvYSSFH9K1V8Y+irP66qlYAoVopfy3rJuuFjh2884/W6l/I
         r7PFmwN6Nor/8pEY/KuZy/TayvOnj7icpEjlr9k4c03TkyLdTq/QfIhXRsCuE6IeuGg+
         Y5SNedgsVtTB8b0dLZDEAVsVYfjO7hspALwFWTk+SH3ZtaxQ74PB8r8O2CzKZmFPaBvI
         m1vw==
X-Gm-Message-State: APjAAAVA7sjovsIJEygB6ftFWzDLQZIr67izaPE++SZ7CSFj9Z2wrIsS
        ys4uzN7Z68vu8FXvZ0c3s37C8g==
X-Google-Smtp-Source: APXvYqznD+zC0q/A4MhGzomvxakH4li9R6cnks1twXRbQNsnspUm7dxAarVtPVqc3Z3Kl1zIo2bzig==
X-Received: by 2002:adf:fc03:: with SMTP id i3mr18956626wrr.306.1579798787004;
        Thu, 23 Jan 2020 08:59:47 -0800 (PST)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:d0a9:6cca:1210:a574])
        by smtp.gmail.com with ESMTPSA id u1sm3217698wmc.5.2020.01.23.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 08:59:46 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf 4/4] selftests: bpf: reset global state between reuseport test runs
Date:   Thu, 23 Jan 2020 16:59:33 +0000
Message-Id: <20200123165934.9584-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123165934.9584-1-lmb@cloudflare.com>
References: <20200123165934.9584-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, there is a lot of false positives if a single reuseport test
fails. This is because expected_results and the result map are not cleared.

Zero both after individual test runs, which fixes the mentioned false
positives.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/select_reuseport.c    | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 09a536af139a..0bab8b1ca1c3 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -699,7 +699,19 @@ static void setup_per_test(int type, sa_family_t family, bool inany,
 
 static void cleanup_per_test(bool no_inner_map)
 {
-	int i, err;
+	int i, err, zero = 0;
+
+	memset(expected_results, 0, sizeof(expected_results));
+
+	for (i = 0; i < NR_RESULTS; i++) {
+		err = bpf_map_update_elem(result_map, &i, &zero, BPF_ANY);
+		RET_IF(err, "reset elem in result_map",
+		       "i:%u err:%d errno:%d\n", i, err, errno);
+	}
+
+	err = bpf_map_update_elem(linum_map, &zero, &zero, BPF_ANY);
+	RET_IF(err, "reset line number in linum_map", "err:%d errno:%d\n",
+	       err, errno);
 
 	for (i = 0; i < REUSEPORT_ARRAY_SIZE; i++)
 		close(sk_fds[i]);
-- 
2.20.1

