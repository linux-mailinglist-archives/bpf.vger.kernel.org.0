Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289884BF2D4
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 08:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiBVHmA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 02:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBVHl4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 02:41:56 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338E9D5F69
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 23:34:47 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K2rWL45p2zdZWs;
        Tue, 22 Feb 2022 15:33:34 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Feb
 2022 15:34:44 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Update btf_dump case for conflict FWD and STRUCT name
Date:   Tue, 22 Feb 2022 02:45:24 -0500
Message-ID: <20220222074524.1027060-3-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222074524.1027060-1-xukuohai@huawei.com>
References: <20220222074524.1027060-1-xukuohai@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Update btf_dump test case for conflict FWD and STRUCT name.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 9e26903f9170..2539a8f8b098 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -150,6 +150,8 @@ static void test_btf_dump_incremental(void)
 	 *
 	 * enum { VAL = 1 };
 	 *
+	 * struct s;
+	 *
 	 * struct s { int x; };
 	 *
 	 */
@@ -161,8 +163,11 @@ static void test_btf_dump_incremental(void)
 	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
 	ASSERT_EQ(id, 2, "int_id");
 
+	id = btf__add_fwd(btf, "s", BTF_FWD_STRUCT);
+	ASSERT_EQ(id, 3, "fwd_id");
+
 	id = btf__add_struct(btf, "s", 4);
-	ASSERT_EQ(id, 3, "struct_id");
+	ASSERT_EQ(id, 4, "struct_id");
 	err = btf__add_field(btf, "x", 2, 0, 0);
 	ASSERT_OK(err, "field_ok");
 
@@ -178,6 +183,8 @@ static void test_btf_dump_incremental(void)
 "	VAL = 1,\n"
 "};\n"
 "\n"
+"struct s;\n"
+"\n"
 "struct s {\n"
 "	int x;\n"
 "};\n\n", "c_dump1");
@@ -199,7 +206,7 @@ static void test_btf_dump_incremental(void)
 	fseek(dump_buf_file, 0, SEEK_SET);
 
 	id = btf__add_struct(btf, "s", 4);
-	ASSERT_EQ(id, 4, "struct_id");
+	ASSERT_EQ(id, 5, "struct_id");
 	err = btf__add_field(btf, "x", 1, 0, 0);
 	ASSERT_OK(err, "field_ok");
 	err = btf__add_field(btf, "s", 3, 32, 0);
-- 
2.30.2

