Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8B642376D
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 07:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhJFFNR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 01:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhJFFNR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 01:13:17 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A210AC061749
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 22:11:25 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s75so1407007pgs.5
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 22:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqRd81efSFuFIw/cDLr3lKmlzmNiIVk6lw3SPXlaJTE=;
        b=ERZFChVZww8jUabUzUxTiQylMitX/kqXk6HaJA0bXX0ZovA2ZkIdLLcNBel0HQEdYj
         2n7nEylpFo4ImswkSKdX5cDIwAEuSfKHobR53lN0+kPBxqlP0T+lKjCUvMwdifusNFzh
         EQU85fTWOkoIwoY7ZIKkTA0Sg8wYklwfMQdSRcAojtVJqHBhBV1LqCVknYj50IGk64g5
         IXr5Ms4MKiPJIjHk/YaElynkuLRbG8+hGqZ5h412xOmCUYovfEdhQUZ+TB0rE4TXXsYf
         CbDe+eaOC6Ccha7YwPTF4/zYYuienVj/Fg8aDILHaZ8tdKhw2RE1NTPQZPDRtc1g+bAV
         lLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqRd81efSFuFIw/cDLr3lKmlzmNiIVk6lw3SPXlaJTE=;
        b=uWfQMivNzgw0qb9zhR6mx7H6yq60TlwutqFNt/HWsTLutR8Cq4cCFHcAshk1tn+wuM
         hqXduHuzNIt1ZhddWCccw/jujUtjwqIopR59X/KG+MvX0rGicrQAsmve/qwCEGW1HRbt
         8224zMcXfr+Uw4eC7FfmB67B5r8EVp1Fw2lIUmRGot8YzCICbOmR3GOfxMSp+f4t3lEV
         a0FPtEOgqfKU9Cc8c/77Lfw/SDWVt5pPyWa7WdFzhk0qNHyOR1V6UfzgfWzmc9piAWyk
         JeQfvFkV69CoCsH73wgjTp7RizGOXYo+vgup8qU3plRTFklgKyp1O9cgB8mmNBRQ/wI8
         K2FQ==
X-Gm-Message-State: AOAM532KdwPok5RedOI2PgRBxFmlWmAfyQlTb82nzOI3c3niXWFZEGfv
        FExgskqZ9ln6F556Ysplv1D7Wm4zLx/MhA==
X-Google-Smtp-Source: ABdhPJyf0sezkcZZQT9NHjMr4dAlO6Ku2OahWrJ0+QQB3PNAUplUYGXPlqgxO9q+i+D3Ud7O36BzLg==
X-Received: by 2002:a63:4e45:: with SMTP id o5mr19337611pgl.191.1633497085027;
        Tue, 05 Oct 2021 22:11:25 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:400::5:b85c])
        by smtp.gmail.com with ESMTPSA id t4sm13397361pfj.13.2021.10.05.22.11.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Oct 2021 22:11:24 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 bpf-next 3/3] selftests/bpf: test new btf__add_btf() API
Date:   Tue,  5 Oct 2021 22:11:07 -0700
Message-Id: <20211006051107.17921-4-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006051107.17921-1-andrii@kernel.org>
References: <20211006051107.17921-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

Add a test that validates that btf__add_btf() API is correctly copying
all the types from the source BTF into destination BTF object and
adjusts type IDs and string offsets properly.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/btf_write.c      | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/testing/selftests/bpf/prog_tests/btf_write.c
index aa4505618252..886e0fc1efb1 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -342,8 +342,94 @@ static void test_btf_add()
 	btf__free(btf);
 }
 
+static void test_btf_add_btf()
+{
+	struct btf *btf1 = NULL, *btf2 = NULL;
+	int id;
+
+	btf1 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf1, "btf1"))
+		return;
+
+	btf2 = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf2, "btf2"))
+		goto cleanup;
+
+	gen_btf(btf1);
+	gen_btf(btf2);
+
+	id = btf__add_btf(btf1, btf2);
+	if (!ASSERT_EQ(id, 20, "id"))
+		goto cleanup;
+
+	VALIDATE_RAW_BTF(
+		btf1,
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
+		"[19] TAG 'tag2' type_id=14 component_idx=1",
+
+		/* types appended from the second BTF */
+		"[20] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[21] PTR '(anon)' type_id=20",
+		"[22] CONST '(anon)' type_id=24",
+		"[23] VOLATILE '(anon)' type_id=22",
+		"[24] RESTRICT '(anon)' type_id=23",
+		"[25] ARRAY '(anon)' type_id=21 index_type_id=20 nr_elems=10",
+		"[26] STRUCT 's1' size=8 vlen=2\n"
+		"\t'f1' type_id=20 bits_offset=0\n"
+		"\t'f2' type_id=20 bits_offset=32 bitfield_size=16",
+		"[27] UNION 'u1' size=8 vlen=1\n"
+		"\t'f1' type_id=20 bits_offset=0 bitfield_size=16",
+		"[28] ENUM 'e1' size=4 vlen=2\n"
+		"\t'v1' val=1\n"
+		"\t'v2' val=2",
+		"[29] FWD 'struct_fwd' fwd_kind=struct",
+		"[30] FWD 'union_fwd' fwd_kind=union",
+		"[31] ENUM 'enum_fwd' size=4 vlen=0",
+		"[32] TYPEDEF 'typedef1' type_id=20",
+		"[33] FUNC 'func1' type_id=34 linkage=global",
+		"[34] FUNC_PROTO '(anon)' ret_type_id=20 vlen=2\n"
+		"\t'p1' type_id=20\n"
+		"\t'p2' type_id=21",
+		"[35] VAR 'var1' type_id=20, linkage=global-alloc",
+		"[36] DATASEC 'datasec1' size=12 vlen=1\n"
+		"\ttype_id=20 offset=4 size=8",
+		"[37] TAG 'tag1' type_id=35 component_idx=-1",
+		"[38] TAG 'tag2' type_id=33 component_idx=1");
+
+cleanup:
+	btf__free(btf1);
+	btf__free(btf2);
+}
+
 void test_btf_write()
 {
 	if (test__start_subtest("btf_add"))
 		test_btf_add();
+	if (test__start_subtest("btf_add_btf"))
+		test_btf_add_btf();
 }
-- 
2.30.2

