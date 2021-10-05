Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAFD421F0C
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 08:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhJEGtI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 02:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhJEGtI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Oct 2021 02:49:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7C1C061745
        for <bpf@vger.kernel.org>; Mon,  4 Oct 2021 23:47:18 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h1so5862021pfv.12
        for <bpf@vger.kernel.org>; Mon, 04 Oct 2021 23:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ViaagKYBiQzdmafvF50+XcDXMX1X48FTWoaZfW884NI=;
        b=mWl7MTjw+7C6OjebmjBHwS87aLPcpbP+qukZpmD+kXciWlBG+oyH+j2fzWHmALjBdU
         1P6eUOaHhNhTaRyiJfi6Jh0+zJ5mSmyDMFykPVu++1HI2NPxYnH+u6OC4FlfhihV1VKD
         HjW1VxaXhCdv3Lqzrh+tgAPDMDj8LVg9Ktj39gR70pyPegr8Pw2M8LKDQe9m6zhXDQ01
         c9YRy7yym6HHMSuOI9z0vdQouLJjYlRwwXUiW9Q6hZMrrsLBeLpWoLuxhNJDXYYN21pM
         uRjL8Y1T1rGIJWdFAbh7fUnK9yk/ur9QihbQ3UFSR+V3BqrBiE0+o7c4Qc0igx/0BCwk
         u9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ViaagKYBiQzdmafvF50+XcDXMX1X48FTWoaZfW884NI=;
        b=jOhe6N02Bjsza1zDMjaOuObV5NkXfFk3mktf9vgO0LGUvdvd4AbkQJhO7GU5+nVO5x
         JFjwGoN6PdXkWd3iYvY5C02XHwzkYZrYfG6/R0LIlqOti7TkOMDRf0YTgvMu7SQWuELX
         KkYBpM/RFDqvXjhkHH9X7oe9/zYadeYx5U85UWjgb0ABGRbHtqNJmotmIJxf4D5ZcM8d
         XtPTJ8CRI6yejT1RHM8S1sIOVAf8HiEIExyiRvxQOeEkanysTHr7LjO0pf7H91WxgyPh
         QoRC68z5el4xCe1BSQMQyowITQtYAckAi4uAPRpm8i7gybgnpJht78IVqNM6RnvrYL+X
         ZQdQ==
X-Gm-Message-State: AOAM5320VIeRyqBDv+TitI6gIkFhCVzfBh7JIBRVUUgzPmifS/m+aHq5
        TUNVO/8T7lGPdGGLA3VHwQgXZtJL6K7cRA==
X-Google-Smtp-Source: ABdhPJxBktPjUOWV3orreyso6p26Bn5uw0FdryOPtxmXuYyxxtGkDS4lSbV0ccEyKmkRATPYuCL/6w==
X-Received: by 2002:a62:e210:0:b0:44b:ae4c:8c01 with SMTP id a16-20020a62e210000000b0044bae4c8c01mr28822145pfi.45.1633416438045;
        Mon, 04 Oct 2021 23:47:18 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:400::5:381e])
        by smtp.gmail.com with ESMTPSA id u5sm915135pjn.48.2021.10.04.23.47.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Oct 2021 23:47:17 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH bpf-next 2/3] selftests/bpf: refactor btf_write selftest to reuse BTF generation logic
Date:   Mon,  4 Oct 2021 23:47:02 -0700
Message-Id: <20211005064703.60785-3-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005064703.60785-1-andrii@kernel.org>
References: <20211005064703.60785-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

Next patch will need to reuse BTF generation logic, which tests every
supported BTF kind, for testing btf__add_btf() APIs. So restructure
existing selftests and make it as a single subtest that uses bulk
VALIDATE_RAW_BTF() macro for raw BTF dump checking.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/btf_write.c      | 55 +++++++++++++++++--
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/testing/selftests/bpf/prog_tests/btf_write.c
index 76548eecce2c..aa4505618252 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -4,19 +4,15 @@
 #include <bpf/btf.h>
 #include "btf_helpers.h"
 
-void test_btf_write() {
+static void gen_btf(struct btf *btf)
+{
 	const struct btf_var_secinfo *vi;
 	const struct btf_type *t;
 	const struct btf_member *m;
 	const struct btf_enum *v;
 	const struct btf_param *p;
-	struct btf *btf;
 	int id, err, str_off;
 
-	btf = btf__new_empty();
-	if (!ASSERT_OK_PTR(btf, "new_empty"))
-		return;
-
 	str_off = btf__find_str(btf, "int");
 	ASSERT_EQ(str_off, -ENOENT, "int_str_missing_off");
 
@@ -301,6 +297,53 @@ void test_btf_write() {
 	ASSERT_EQ(btf_tag(t)->component_idx, 1, "tag_component_idx");
 	ASSERT_STREQ(btf_type_raw_dump(btf, 19),
 		     "[19] TAG 'tag2' type_id=14 component_idx=1", "raw_dump");
+}
+
+static void test_btf_add()
+{
+	struct btf *btf;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "new_empty"))
+		return;
+
+	gen_btf(btf);
+
+	VALIDATE_RAW_BTF(
+		btf,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] CONST '(anon)' type_id=5",
+		"[4] VOLATILE '(anon)' type_id=3",
+		"[5] RESTRICT '(anon)' type_id=4",
+		"[6] ARRAY '(anon)' type_id=2 index_type_id=1 nr_elems=10",
+		"[7] STRUCT 's1' size=8 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=1 bits_offset=32 bitfield_size=16",
+		"[8] UNION 'u1' size=8 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0 bitfield_size=16",
+		"[9] ENUM 'e1' size=4 vlen=2\n"
+		"\t'v1' val=1\n"
+		"\t'v2' val=2",
+		"[10] FWD 'struct_fwd' fwd_kind=struct",
+		"[11] FWD 'union_fwd' fwd_kind=union",
+		"[12] ENUM 'enum_fwd' size=4 vlen=0",
+		"[13] TYPEDEF 'typedef1' type_id=1",
+		"[14] FUNC 'func1' type_id=15 linkage=global",
+		"[15] FUNC_PROTO '(anon)' ret_type_id=1 vlen=2\n"
+		"\t'p1' type_id=1\n"
+		"\t'p2' type_id=2",
+		"[16] VAR 'var1' type_id=1, linkage=global-alloc",
+		"[17] DATASEC 'datasec1' size=12 vlen=1\n"
+		"\ttype_id=1 offset=4 size=8",
+		"[18] TAG 'tag1' type_id=16 component_idx=-1",
+		"[19] TAG 'tag2' type_id=14 component_idx=1");
 
 	btf__free(btf);
 }
+
+void test_btf_write()
+{
+	if (test__start_subtest("btf_add"))
+		test_btf_add();
+}
-- 
2.30.2

