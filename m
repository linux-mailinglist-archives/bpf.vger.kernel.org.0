Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238CA4C2B53
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 12:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiBXL7n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 06:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiBXL7m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 06:59:42 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52765488A3
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 03:59:11 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K4BCd0T0Cz1FCwZ;
        Thu, 24 Feb 2022 19:54:37 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 24 Feb
 2022 19:59:08 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Update btf_dump case for conflicting names
Date:   Thu, 24 Feb 2022 07:09:43 -0500
Message-ID: <20220224120943.1169985-3-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220224120943.1169985-1-xukuohai@huawei.com>
References: <20220224120943.1169985-1-xukuohai@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update btf_dump case for conflicting names caused by forward
declaration.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 54 ++++++++++++++-----
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 9e26903f9170..a224207cdcc4 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -148,22 +148,38 @@ static void test_btf_dump_incremental(void)
 
 	/* First, generate BTF corresponding to the following C code:
 	 *
-	 * enum { VAL = 1 };
+	 * enum x;
+	 *
+	 * enum x { X = 1 };
+	 *
+	 * enum { Y = 1 };
+	 *
+	 * struct s;
 	 *
 	 * struct s { int x; };
 	 *
 	 */
+	id = btf__add_enum(btf, "x", 4);
+	ASSERT_EQ(id, 1, "enum_declaration_id");
+	id = btf__add_enum(btf, "x", 4);
+	ASSERT_EQ(id, 2, "named_enum_id");
+	err = btf__add_enum_value(btf, "X", 1);
+	ASSERT_OK(err, "named_enum_val_ok");
+
 	id = btf__add_enum(btf, NULL, 4);
-	ASSERT_EQ(id, 1, "enum_id");
-	err = btf__add_enum_value(btf, "VAL", 1);
-	ASSERT_OK(err, "enum_val_ok");
+	ASSERT_EQ(id, 3, "anon_enum_id");
+	err = btf__add_enum_value(btf, "Y", 1);
+	ASSERT_OK(err, "anon_enum_val_ok");
 
 	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
-	ASSERT_EQ(id, 2, "int_id");
+	ASSERT_EQ(id, 4, "int_id");
+
+	id = btf__add_fwd(btf, "s", BTF_FWD_STRUCT);
+	ASSERT_EQ(id, 5, "fwd_id");
 
 	id = btf__add_struct(btf, "s", 4);
-	ASSERT_EQ(id, 3, "struct_id");
-	err = btf__add_field(btf, "x", 2, 0, 0);
+	ASSERT_EQ(id, 6, "struct_id");
+	err = btf__add_field(btf, "x", 4, 0, 0);
 	ASSERT_OK(err, "field_ok");
 
 	for (i = 1; i < btf__type_cnt(btf); i++) {
@@ -173,11 +189,20 @@ static void test_btf_dump_incremental(void)
 
 	fflush(dump_buf_file);
 	dump_buf[dump_buf_sz] = 0; /* some libc implementations don't do this */
+
 	ASSERT_STREQ(dump_buf,
+"enum x;\n"
+"\n"
+"enum x {\n"
+"	X = 1,\n"
+"};\n"
+"\n"
 "enum {\n"
-"	VAL = 1,\n"
+"	Y = 1,\n"
 "};\n"
 "\n"
+"struct s;\n"
+"\n"
 "struct s {\n"
 "	int x;\n"
 "};\n\n", "c_dump1");
@@ -199,10 +224,12 @@ static void test_btf_dump_incremental(void)
 	fseek(dump_buf_file, 0, SEEK_SET);
 
 	id = btf__add_struct(btf, "s", 4);
-	ASSERT_EQ(id, 4, "struct_id");
-	err = btf__add_field(btf, "x", 1, 0, 0);
+	ASSERT_EQ(id, 5, "struct_id");
+	err = btf__add_field(btf, "x", 2, 0, 0);
+	ASSERT_OK(err, "field_ok");
+	err = btf__add_field(btf, "y", 3, 32, 0);
 	ASSERT_OK(err, "field_ok");
-	err = btf__add_field(btf, "s", 3, 32, 0);
+	err = btf__add_field(btf, "s", 6, 64, 0);
 	ASSERT_OK(err, "field_ok");
 
 	for (i = 1; i < btf__type_cnt(btf); i++) {
@@ -214,9 +241,10 @@ static void test_btf_dump_incremental(void)
 	dump_buf[dump_buf_sz] = 0; /* some libc implementations don't do this */
 	ASSERT_STREQ(dump_buf,
 "struct s___2 {\n"
+"	enum x x;\n"
 "	enum {\n"
-"		VAL___2 = 1,\n"
-"	} x;\n"
+"		Y___2 = 1,\n"
+"	} y;\n"
 "	struct s s;\n"
 "};\n\n" , "c_dump1");
 
-- 
2.30.2

