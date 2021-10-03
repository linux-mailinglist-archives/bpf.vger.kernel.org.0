Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D8A4202F8
	for <lists+bpf@lfdr.de>; Sun,  3 Oct 2021 18:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhJCQvS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Oct 2021 12:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230504AbhJCQvR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 3 Oct 2021 12:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633279769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9nTD5DvOEAb5Ts4GxYiTYCkd/jR9/VxYpeKb+vjDz+Y=;
        b=BvSCiCQitKjBMwGaA1waN6hLi3rjiSp9R/6eB9wge8cGNqZBnZf5lcEf7tOlr/p44wqgCG
        Xtj1IXyIrTBa4ltvV5EB2PMY7HUioylOH+eD75TeP6xUhJNWcRv24Qo0t8g/riLGPeWsHP
        WllsVrfnqZxBxTkg5PfXt0nPNYY1HJk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-HN8M5jrqP36gKBZcfVN36w-1; Sun, 03 Oct 2021 12:49:28 -0400
X-MC-Unique: HN8M5jrqP36gKBZcfVN36w-1
Received: by mail-wr1-f72.google.com with SMTP id r25-20020adfab59000000b001609ddd5579so895125wrc.21
        for <bpf@vger.kernel.org>; Sun, 03 Oct 2021 09:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9nTD5DvOEAb5Ts4GxYiTYCkd/jR9/VxYpeKb+vjDz+Y=;
        b=luR5gudubzfpsNoWzRNU2IMnQ5l5rIeDt9CY0FXxsp1P0V2RNuWTO8GVEzwkJ8JNhH
         A6DivaCVchArZnodDYCTT2ynSr7b7Wl0+SdQk03uwWiGYaZdDbEvdQdgGXWLPOMuXtB8
         hsqIsV1fRdaT77Kj0MapzYcRpxkte51VKuzjCYerMxtq7p4pRj441gej8P53D+NynY7+
         G8d5V2JCMO9DF+CKhHPM72C4i2djQlscjvVX17xstCtB4psELGXqS31eeqRUKEh9aiCw
         pMdbSkZBLgcnOXGSVQV4wTQS+6TjU3EneTVxaJjrHeL6rMeEBZ3xlnijMjZn0fB4PWiW
         oT8w==
X-Gm-Message-State: AOAM531Ucu9Pgp49XwJ9q3ur4VZYp1Wh3PZ5CN99/1lz/xg8pyhC2mZn
        jNY88/rw5qtFDQ2BSyP4NjaS8p6HGMoDTevsF0Eylp5lhim5FgTj12jf3NzfBhSg4Vpxg3vhEPE
        rcjhg9J4eLd23
X-Received: by 2002:a05:600c:19cf:: with SMTP id u15mr13376696wmq.45.1633279767647;
        Sun, 03 Oct 2021 09:49:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6Qs2wCvk7zvI3FmshKL4tuBa7S4kxLFXXMASGobB+wNY7upJ5+cPuGuMeBHQcGyrpYQcwDw==
X-Received: by 2002:a05:600c:19cf:: with SMTP id u15mr13376682wmq.45.1633279767447;
        Sun, 03 Oct 2021 09:49:27 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id s13sm10758395wrv.97.2021.10.03.09.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 09:49:27 -0700 (PDT)
Date:   Sun, 3 Oct 2021 18:49:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next] selftest/bpf: Switch recursion test to use
 htab_map_delete_elem
Message-ID: <YVnfFTL/3T6jOwHI@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently the recursion test is hooking __htab_map_lookup_elem
function, which is invoked both from bpf_prog and bpf syscall.

But in our kernel build, the __htab_map_lookup_elem gets inlined
within the htab_map_lookup_elem, so it's not trigered and the
test fails.

Fixing this by using htab_map_delete_elem, which is not inlined
for bpf_prog calls (like htab_map_lookup_elem is) and is used
directly as pointer for map_delete_elem, so it won't disappear
by inlining.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/recursion.c | 10 +++++-----
 tools/testing/selftests/bpf/progs/recursion.c      |  9 +++------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/recursion.c b/tools/testing/selftests/bpf/prog_tests/recursion.c
index 0e378d63fe18..f3af2627b599 100644
--- a/tools/testing/selftests/bpf/prog_tests/recursion.c
+++ b/tools/testing/selftests/bpf/prog_tests/recursion.c
@@ -20,18 +20,18 @@ void test_recursion(void)
 		goto out;
 
 	ASSERT_EQ(skel->bss->pass1, 0, "pass1 == 0");
-	bpf_map_lookup_elem(bpf_map__fd(skel->maps.hash1), &key, 0);
+	bpf_map_delete_elem(bpf_map__fd(skel->maps.hash1), &key);
 	ASSERT_EQ(skel->bss->pass1, 1, "pass1 == 1");
-	bpf_map_lookup_elem(bpf_map__fd(skel->maps.hash1), &key, 0);
+	bpf_map_delete_elem(bpf_map__fd(skel->maps.hash1), &key);
 	ASSERT_EQ(skel->bss->pass1, 2, "pass1 == 2");
 
 	ASSERT_EQ(skel->bss->pass2, 0, "pass2 == 0");
-	bpf_map_lookup_elem(bpf_map__fd(skel->maps.hash2), &key, 0);
+	bpf_map_delete_elem(bpf_map__fd(skel->maps.hash2), &key);
 	ASSERT_EQ(skel->bss->pass2, 1, "pass2 == 1");
-	bpf_map_lookup_elem(bpf_map__fd(skel->maps.hash2), &key, 0);
+	bpf_map_delete_elem(bpf_map__fd(skel->maps.hash2), &key);
 	ASSERT_EQ(skel->bss->pass2, 2, "pass2 == 2");
 
-	err = bpf_obj_get_info_by_fd(bpf_program__fd(skel->progs.on_lookup),
+	err = bpf_obj_get_info_by_fd(bpf_program__fd(skel->progs.on_delete),
 				     &prog_info, &prog_info_len);
 	if (!ASSERT_OK(err, "get_prog_info"))
 		goto out;
diff --git a/tools/testing/selftests/bpf/progs/recursion.c b/tools/testing/selftests/bpf/progs/recursion.c
index 49f679375b9d..3c2423bb19e2 100644
--- a/tools/testing/selftests/bpf/progs/recursion.c
+++ b/tools/testing/selftests/bpf/progs/recursion.c
@@ -24,8 +24,8 @@ struct {
 int pass1 = 0;
 int pass2 = 0;
 
-SEC("fentry/__htab_map_lookup_elem")
-int BPF_PROG(on_lookup, struct bpf_map *map)
+SEC("fentry/htab_map_delete_elem")
+int BPF_PROG(on_delete, struct bpf_map *map)
 {
 	int key = 0;
 
@@ -35,10 +35,7 @@ int BPF_PROG(on_lookup, struct bpf_map *map)
 	}
 	if (map == (void *)&hash2) {
 		pass2++;
-		/* htab_map_gen_lookup() will inline below call
-		 * into direct call to __htab_map_lookup_elem()
-		 */
-		bpf_map_lookup_elem(&hash2, &key);
+		bpf_map_delete_elem(&hash2, &key);
 		return 0;
 	}
 
-- 
2.31.1

