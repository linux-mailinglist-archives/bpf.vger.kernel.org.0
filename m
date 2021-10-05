Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EAC421F0E
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 08:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhJEGtM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 02:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhJEGtM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Oct 2021 02:49:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ADAC061745
        for <bpf@vger.kernel.org>; Mon,  4 Oct 2021 23:47:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j15so1627277plh.7
        for <bpf@vger.kernel.org>; Mon, 04 Oct 2021 23:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oTRi7CdXsxRuWtD22xkp24bvf7B38TEOIke8y7xV1hw=;
        b=djOvcoxDP1BABArGLpzwQrfevdRRSZyc4aLqjm6ale2vuMSPo4jb95K6wODpPpXHbC
         O+N9MAKBjPuIDoxwBjE/LholedLNnRYGr3wPoM2RsG+VQelYW/EJTSwELSQuGhs7LswB
         VauQzRR+N5piJpnX0NEluVffWLfmg4205xmzAOznKQuddz7G6CCEG5o8mCzxWaxu+ET8
         8yCOn8QmNDT9/MyrILuZuNHSOHR4IieLFAmuUDet1r5ds8xp2VqDEtcKq9acnZT29+DJ
         2zU9VsTVDZTJnB7ve635iaLDhVpnXu0V3UptDIGiVs9esatUihDAd/uSpnnncBbnzkVn
         NjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oTRi7CdXsxRuWtD22xkp24bvf7B38TEOIke8y7xV1hw=;
        b=UE23PWcz7tB5ZDxZRhQqoa8rFPfx4gd76FJgAate0sJxMq/9U1YBAyP0s1JL47YBIV
         yHa0t2fI7CHyu8a1SubWL/7arsbMtvMiVGCDWvF4Ii/zzMuNB2OiurXoiD0hXHOee0YW
         n8yATnph4L68K73ZLLmj2LuuLK9Ggba643VaYQJwGxaW9OrXKn/ybTVT0YU8wVzYYI6H
         qj9bY8Lz9QUSkgobl9qug0dk+XM4UM+gM0U8Gj5QCh8vrtSt2a6EdKd6PzNhOy9U/l2n
         9tB5xSdAG62MRLAztx+9zz9f4n4ODzLp2bxC3tJ267lt6UP4rFfccVzlZsSQnPnwtUuC
         XUQQ==
X-Gm-Message-State: AOAM530Ir1Wjm/IEkKokWXGcvK69w4C1LpFcgBY2EFYN793m7deQ21jc
        nY4eN8FVPL+O6JTOhzBtxYo+DUZO3B0Qtg==
X-Google-Smtp-Source: ABdhPJwm2qDmK2pxbYhOHIq/NjEPi91Tzhi+K7VlPVLT7t10QnWdnAgUN6uKjf5VM5gIUFm/pAsC5Q==
X-Received: by 2002:a17:90b:3b8b:: with SMTP id pc11mr1867120pjb.180.1633416441859;
        Mon, 04 Oct 2021 23:47:21 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:400::5:381e])
        by smtp.gmail.com with ESMTPSA id s22sm7266248pfg.137.2021.10.04.23.47.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Oct 2021 23:47:21 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH bpf-next 3/3] selftests/bpf: test new btf__add_btf() API
Date:   Mon,  4 Oct 2021 23:47:03 -0700
Message-Id: <20211005064703.60785-4-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005064703.60785-1-andrii@kernel.org>
References: <20211005064703.60785-1-andrii@kernel.org>
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
index aa4505618252..75fd280f75b2 100644
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
+		return;
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

