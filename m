Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EB23E1ED6
	for <lists+bpf@lfdr.de>; Fri,  6 Aug 2021 00:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbhHEWff (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Aug 2021 18:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241267AbhHEWfe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Aug 2021 18:35:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9017CC0613D5
        for <bpf@vger.kernel.org>; Thu,  5 Aug 2021 15:35:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cl16-20020a17090af690b02901782c35c4ccso9426226pjb.5
        for <bpf@vger.kernel.org>; Thu, 05 Aug 2021 15:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MtJ8xI/B+EIULIghvMhd6tf0lsFMRQDGP/UDMzZQQ5Q=;
        b=Y8xWYKiGkLHqWdZqITr38dcexqL02zUhTxsLkBgfnBycmx1SLWHTRrsVTU1i9b4XCs
         ALabm7tnRXogSsnibLjjXzVVgE9sRsieh5LjHs+J1C6erBaJuI8GdCMyfDK1eyubAeu3
         3gA5zFZSfYThBeBrJCpSnmtU/gXqrE4HLVo06m13kXd/U7X4Iw9guHGT0Qeq39CvAwWX
         1j4sQRim9bK9wSH6j/Jb0yDtb96+wQdv13MtGZxZ8nA/aRugBKEGMYsvqkWm0YhMr5Nn
         rxAm3Qaxs0evK34lJpptPGWP3HtOC/mXc5q6H0UNWIvtijH8hcdyV/LAdc10Qqk5/Hjy
         JkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MtJ8xI/B+EIULIghvMhd6tf0lsFMRQDGP/UDMzZQQ5Q=;
        b=rg7C4AijpwOedw6VYijl2xwaBqVJBw4tXvOuRCIJgOwO5f+PvbBbvz9fR+ZnDVdFCj
         vnPCDjjvGt6M3mW6SnC6dhLvvhDwah4RIo3/S0ZEy4gZaBDH18M0FQPItCqU63s0W4Z9
         PpUlh6SZFl7K2GnBl6zeiOZM5MG4S2Oilo1s2RgH+aHX6hiTEXraA2Y/KAdQ5ditV+9Z
         6VOsio1bFxzKzT91IlXLAj8ZbLVuHbNbgtrbeTEWVyrXl6WP49H0+KYPg4h3/94z5QiQ
         fh8/a/QvV6nA6fEzpCRW8Zh0BNgvHawHg4qYq10NIWVFcVIXNuVddXYlrKctBFQODKEc
         CHAw==
X-Gm-Message-State: AOAM530WOIdcA4OYnbsBVQBEUAXiFzq6nxbcjIvOauMgXVlIpKSjwXHi
        vQusVLi6fw4onKeQgn6J2yuYNw==
X-Google-Smtp-Source: ABdhPJzjfRHiHFhLWxxll0QihyIiKCjSi2hFZKyNq28KkC/xt7fqXcotdkDp6/L7UKiLXgaqeaqiAQ==
X-Received: by 2002:a63:e947:: with SMTP id q7mr285626pgj.324.1628202919156;
        Thu, 05 Aug 2021 15:35:19 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
        by smtp.gmail.com with ESMTPSA id z8sm7931638pfa.113.2021.08.05.15.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:35:18 -0700 (PDT)
From:   Jiang Wang <jiang.wang@bytedance.com>
To:     netdev@vger.kernel.org
Cc:     cong.wang@bytedance.com, duanxiongchun@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 3/5] selftest/bpf: add tests for sockmap with unix stream type.
Date:   Thu,  5 Aug 2021 22:34:40 +0000
Message-Id: <20210805223445.624330-4-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805223445.624330-1-jiang.wang@bytedance.com>
References: <20210805223445.624330-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two tests for unix stream to unix stream redirection
in sockmap tests.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_listen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index a9f1bf9d5dff..7a976d43281a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -2020,11 +2020,13 @@ void test_sockmap_listen(void)
 	run_tests(skel, skel->maps.sock_map, AF_INET);
 	run_tests(skel, skel->maps.sock_map, AF_INET6);
 	test_unix_redir(skel, skel->maps.sock_map, SOCK_DGRAM);
+	test_unix_redir(skel, skel->maps.sock_map, SOCK_STREAM);
 
 	skel->bss->test_sockmap = false;
 	run_tests(skel, skel->maps.sock_hash, AF_INET);
 	run_tests(skel, skel->maps.sock_hash, AF_INET6);
 	test_unix_redir(skel, skel->maps.sock_hash, SOCK_DGRAM);
+	test_unix_redir(skel, skel->maps.sock_hash, SOCK_STREAM);
 
 	test_sockmap_listen__destroy(skel);
 }
-- 
2.20.1

