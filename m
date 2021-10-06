Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6EF42376C
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 07:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhJFFNO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 01:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhJFFNN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 01:13:13 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DC6C061749
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 22:11:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r2so1383207pgl.10
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 22:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zC7G2rZNPZFCtNAj8bw9gQL2MPj0wsjaRrx2PwatbnY=;
        b=RAc5xdoZRQffcUDRWgyqvEQwTV/3B8RMrkktFOme5RkVAo7Xwtn7jp+k1PSFIqnw+t
         Sm7yXfF0LVsizPpUTsrLtrwntPYFgP31OaPc/Z8wEy1BBUxUPDzjr0svjlign++vQlMp
         UlmUvMXFGPAXAj4CEN7HECALNqy+1do3fcCp+Lhe0kT96wjpQLXLIZkfVyOZkXLpS1Td
         sDus3AJvLcGnyoFNt2DfPtTujZx6SHcvxO2EkBazp5Qw6yxqw+vRfZ3d5MpXKH+WHhaN
         +p3xgkx8Fr6CA5EdOUkWp+dJ/ttllYEwCjnk4hm9eGmSjQqsVIbnE7kATvABFz4UPkNF
         e9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zC7G2rZNPZFCtNAj8bw9gQL2MPj0wsjaRrx2PwatbnY=;
        b=zGWPzjvtFCp1bLyeuMnMOpqkp7s+PAkxbZXDfmksucf5WV2MvmvfbVXnSP/Lvlkovg
         3vPFTipH/BsgWkh0+OVeTSWpCL1L5SVq790FvPUj/i0Ncuuxh0w7E+p9IgrzwrGw8qkM
         k6eYRkxH8BcHB+j1xIriQGdVy3NhiAGdWP4G2RNpKzG/a9GSqjuRpLe4hvCcHeufU7ZE
         sfB5pb6Wn1XjBKpx7GFxEvF68w20GdHDUMTGyNElm2r1yylA4258xgojui/Cf7Inwu1p
         bZPEKIWDGCRZfv8miFR1zf2SKJMzI0LcUQ3JW676Zv+5u7mhwWFvbR9QoeKjSvr5sS9d
         iNgQ==
X-Gm-Message-State: AOAM532M5isyQYNavAOleG3r6t0sbasYvAUntQ2+aA/w4yi8u4m/3Ey8
        +qc204x49ReOvMzav8Km8wsn2/CxcWx4YA==
X-Google-Smtp-Source: ABdhPJzKKosZrgEU+NREMHC5TxI7aYOWoFqrq3QCRoLdPPSrAaQGlKO58DVuofUYDDXLAg+vBchZ8g==
X-Received: by 2002:a05:6a00:b8f:b0:44c:6220:3396 with SMTP id g15-20020a056a000b8f00b0044c62203396mr14339746pfj.58.1633497081190;
        Tue, 05 Oct 2021 22:11:21 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:400::5:b85c])
        by smtp.gmail.com with ESMTPSA id s25sm19396609pfm.138.2021.10.05.22.11.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Oct 2021 22:11:20 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 2/3] selftests/bpf: refactor btf_write selftest to reuse BTF generation logic
Date:   Tue,  5 Oct 2021 22:11:06 -0700
Message-Id: <20211006051107.17921-3-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006051107.17921-1-andrii@kernel.org>
References: <20211006051107.17921-1-andrii@kernel.org>
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

Acked-by: Song Liu <songliubraving@fb.com>
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

