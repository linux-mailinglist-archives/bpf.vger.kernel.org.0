Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1BA4260E4
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 02:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhJHAFw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 20:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhJHAFt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 20:05:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC32BC061570
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 17:03:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so6470933pjb.3
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 17:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ux3VswJbAAteYj64iek3WRdvf/ffQGTeFKUkNbzRlb0=;
        b=LsE94JbbSTs21kYrbGV01BBM+/TJdOZQJrYIZ6S7E62csIHQL3pagbHlfhel4o7Dwn
         l/JXcpIhyFfFByygUDE1816MO769BlzJhgyf/LfTrwKZ3IckXHmpmSnM0ZxrYZf36e+E
         bG2QHrNDXY4bQHeuCLwnfc0SSUbM92qV87zk+7jK43Hc+EhBLhJ+zacmPqA5hXbM2GwA
         fJ59VPfI2idlF7ZF6ILky7C0+vpB7GL/uBF4ASCKDxoN1dPZpYhAKDRgs8rjncMbeTKi
         UuAF/ugFInSeD46fLURu6VqU4j9mV+KpkuxjAqzvkHmv19I9fCUy0uzEgiQz0za8zPMk
         HHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ux3VswJbAAteYj64iek3WRdvf/ffQGTeFKUkNbzRlb0=;
        b=yeI/RNBXOrZICXbBhC3SHowIM+YeiXP+Rk0PJE+pOOwZIJfRpHVhW/AejxlE6Ccg41
         mONPBb512RCWrkpRS+m34SunsW98mRUrHBtzmDXRETUWIFrZokOaZvA3Sf8UqvGa/Djp
         Yo5hr+GFDBOOqA25r1ssTwu0fc8h4L7m59iSZotE7If6KgfJaQyGQQKhJFHVi/RFkg/A
         jroN7/PcvAaLMNAYH2gujY5hXhcXo1f8LTsPSu6q9lnbh17yHs3lnTjWdr/asN+Sp/yW
         sHDwbCszA18LsEONqcMaARPQtL7WQPvQKftmdZlyHoillMD6ZMTQFKPSKuLU7h2l4iiu
         hysA==
X-Gm-Message-State: AOAM533SiknE8raYSsoSlXKjcDaJd24tVI0G6Pmq/u+oDLXZY7QZDjyg
        iXZLDWJZZ+IfSH/aa43vhsu4UtopJitqBg==
X-Google-Smtp-Source: ABdhPJxx9pT36Q8SXWnQdwZFLLX3XgEut5myBR4SywFu+7LdOBViW1rLZqfXqTEoXEKUXKe4HKULXA==
X-Received: by 2002:a17:90a:5ac2:: with SMTP id n60mr8114816pji.184.1633651434742;
        Thu, 07 Oct 2021 17:03:54 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:500::e050])
        by smtp.gmail.com with ESMTPSA id b10sm490013pfi.122.2021.10.07.17.03.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Oct 2021 17:03:54 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 10/10] selftests/bpf: switch to ".bss"/".rodata"/".data" lookups for internal maps
Date:   Thu,  7 Oct 2021 17:03:09 -0700
Message-Id: <20211008000309.43274-11-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008000309.43274-1-andrii@kernel.org>
References: <20211008000309.43274-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

Utilize libbpf's feature of allowing to lookup internal maps by their
ELF section names. No need to guess or calculate the exact truncated
prefix taken from the object name.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/core_autosize.c  |  2 +-
 tools/testing/selftests/bpf/prog_tests/core_reloc.c   |  2 +-
 tools/testing/selftests/bpf/prog_tests/global_data.c  | 11 +++++++++--
 .../selftests/bpf/prog_tests/global_data_init.c       |  2 +-
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c    |  2 +-
 tools/testing/selftests/bpf/prog_tests/rdonly_maps.c  |  2 +-
 6 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_autosize.c b/tools/testing/selftests/bpf/prog_tests/core_autosize.c
index 3d4b2a358d47..2a0dac6394ef 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_autosize.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_autosize.c
@@ -163,7 +163,7 @@ void test_core_autosize(void)
 
 	usleep(1);
 
-	bss_map = bpf_object__find_map_by_name(skel->obj, "test_cor.bss");
+	bss_map = bpf_object__find_map_by_name(skel->obj, ".bss");
 	if (!ASSERT_OK_PTR(bss_map, "bss_map_find"))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 763302e63a29..cc50f8feeca3 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -867,7 +867,7 @@ void test_core_reloc(void)
 			goto cleanup;
 		}
 
-		data_map = bpf_object__find_map_by_name(obj, "test_cor.bss");
+		data_map = bpf_object__find_map_by_name(obj, ".bss");
 		if (CHECK(!data_map, "find_data_map", "data map not found\n"))
 			goto cleanup;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data.c b/tools/testing/selftests/bpf/prog_tests/global_data.c
index 9efa7e50eab2..afd8639f9a94 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data.c
@@ -103,11 +103,18 @@ static void test_global_data_struct(struct bpf_object *obj, __u32 duration)
 static void test_global_data_rdonly(struct bpf_object *obj, __u32 duration)
 {
 	int err = -ENOMEM, map_fd, zero = 0;
-	struct bpf_map *map;
+	struct bpf_map *map, *map2;
 	__u8 *buff;
 
 	map = bpf_object__find_map_by_name(obj, "test_glo.rodata");
-	if (CHECK_FAIL(!map || !bpf_map__is_internal(map)))
+	if (!ASSERT_OK_PTR(map, "map"))
+		return;
+	if (!ASSERT_TRUE(bpf_map__is_internal(map), "is_internal"))
+		return;
+
+	/* ensure we can lookup internal maps by their ELF names */
+	map2 = bpf_object__find_map_by_name(obj, ".rodata");
+	if (!ASSERT_EQ(map, map2, "same_maps"))
 		return;
 
 	map_fd = bpf_map__fd(map);
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index ee46b11f1f9a..1db86eab101b 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -16,7 +16,7 @@ void test_global_data_init(void)
 	if (CHECK_FAIL(err))
 		return;
 
-	map = bpf_object__find_map_by_name(obj, "test_glo.rodata");
+	map = bpf_object__find_map_by_name(obj, ".rodata");
 	if (CHECK_FAIL(!map || !bpf_map__is_internal(map)))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
index ddfb6bf97152..a9e00960127c 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
@@ -92,7 +92,7 @@ void test_kfree_skb(void)
 	if (CHECK(!fexit, "find_prog", "prog eth_type_trans not found\n"))
 		goto close_prog;
 
-	global_data = bpf_object__find_map_by_name(obj2, "kfree_sk.bss");
+	global_data = bpf_object__find_map_by_name(obj2, ".bss");
 	if (CHECK(!global_data, "find global data", "not found\n"))
 		goto close_prog;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c b/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c
index 5f9eaa3ab584..fd5d2ddfb062 100644
--- a/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c
+++ b/tools/testing/selftests/bpf/prog_tests/rdonly_maps.c
@@ -37,7 +37,7 @@ void test_rdonly_maps(void)
 	if (CHECK(err, "obj_load", "err %d errno %d\n", err, errno))
 		goto cleanup;
 
-	bss_map = bpf_object__find_map_by_name(obj, "test_rdo.bss");
+	bss_map = bpf_object__find_map_by_name(obj, ".bss");
 	if (CHECK(!bss_map, "find_bss_map", "failed\n"))
 		goto cleanup;
 
-- 
2.30.2

