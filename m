Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F3360DA49
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 06:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiJZE3O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 00:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiJZE3M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 00:29:12 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D60ABD6A
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 21:29:12 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29PMGp5Z017152
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 21:29:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wACzkICuFUy1koR0kNDOm9qZRLnGGbs+j7tqe3R5c68=;
 b=VXDujoVdAq2wlGEsQEdsFWJL8YNAjsRu2ndQE3h0/zPb99dfrhIXdxYgX3Du90xYaCK5
 SYB1a+PQYQB4afHgB2Go1PCJb9LsT3l3ul9mfra1fILnqOKtX9E7/oTxgECrxAdCp4cv
 Y1YYzyxRJWcZ9wdvddqjmTilc1Ye7CLwSTk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ke9ydm62k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 21:29:11 -0700
Received: from twshared13931.24.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 21:29:09 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id AA10F1131B894; Tue, 25 Oct 2022 21:29:06 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v6 6/9] selftests/bpf: Fix test test_libbpf_str/bpf_map_type_str
Date:   Tue, 25 Oct 2022 21:29:06 -0700
Message-ID: <20221026042906.674830-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221026042835.672317-1-yhs@fb.com>
References: <20221026042835.672317-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: flCx3m2PGPz25X475sPYXoKrNPy_GRHt
X-Proofpoint-GUID: flCx3m2PGPz25X475sPYXoKrNPy_GRHt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_01,2022-10-25_01,2022-06-22_01
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previous bpf patch made a change to uapi bpf.h like
  @@ -922,7 +922,14 @@ enum bpf_map_type {
        BPF_MAP_TYPE_SOCKHASH,
  -     BPF_MAP_TYPE_CGROUP_STORAGE,
  +     BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
  +     BPF_MAP_TYPE_CGROUP_STORAGE =3D BPF_MAP_TYPE_CGROUP_STORAGE_DEPRE=
CATED,
        BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
where BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED and BPF_MAP_TYPE_CGROUP_STOR=
AGE
have the same enum value. This will cause selftest test_libbpf_str/bpf_ma=
p_type_str
failing. This patch fixed the issue by avoid the check for
BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED in the test.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/libbpf_str.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/=
testing/selftests/bpf/prog_tests/libbpf_str.c
index 93e9cddaadcf..efb8bd43653c 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -139,6 +139,14 @@ static void test_libbpf_bpf_map_type_str(void)
 		snprintf(buf, sizeof(buf), "BPF_MAP_TYPE_%s", map_type_str);
 		uppercase(buf);
=20
+		/* Special case for map_type_name BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECAT=
ED
+		 * where it and BPF_MAP_TYPE_CGROUP_STORAGE have the same enum value
+		 * (map_type). For this enum value, libbpf_bpf_map_type_str() picks
+		 * BPF_MAP_TYPE_CGROUP_STORAGE.
+		 */
+		if (strcmp(map_type_name, "BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED") =3D=
=3D 0)
+			continue;
+
 		ASSERT_STREQ(buf, map_type_name, "exp_str_value");
 	}
=20
--=20
2.30.2

