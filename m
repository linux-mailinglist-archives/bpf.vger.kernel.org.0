Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B089C436B9D
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 21:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhJUT7D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 15:59:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43422 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230272AbhJUT7D (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 15:59:03 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LJbCXS019248
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 12:56:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=odxo8q+ndNoaeL7Q1OAj5W0qsPgbBx5PmpZFPef9VXw=;
 b=SV6vs/OFu85405Kne3TRRUen0xP1F3WIcR7rVAL+vXAErhvhyyS77mhZWTwA/S9B4JUI
 AZZJ7ooqZWQvMaG8cQWCdWVPjlp7cM/BZSWzTqluiegPgDZj7WviBBGpuoCYlpPez8jX
 AAdX9OtYUyzwVV9mwRUC0bddlEzKt4NoUp8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bu2k1p4pe-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 12:56:46 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 21 Oct 2021 12:56:45 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id D007C1516872; Thu, 21 Oct 2021 12:56:43 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/5] selftests/bpf: add BTF_KIND_DECL_TAG typedef example in tag.c
Date:   Thu, 21 Oct 2021 12:56:43 -0700
Message-ID: <20211021195643.4020315-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021195622.4018339-1-yhs@fb.com>
References: <20211021195622.4018339-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 62h_fBG-D1oG2bg7bnQ6Rebalo7WgExU
X-Proofpoint-GUID: 62h_fBG-D1oG2bg7bnQ6Rebalo7WgExU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_05,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change value type in progs/tag.c to a typedef with a btf_decl_tag.
With `bpftool btf dump file tag.o`, we have
  ...
  [14] TYPEDEF 'value_t' type_id=3D17
  [15] DECL_TAG 'tag1' type_id=3D14 component_idx=3D-1
  [16] DECL_TAG 'tag2' type_id=3D14 component_idx=3D-1
  [17] STRUCT '(anon)' size=3D8 vlen=3D2
        'a' type_id=3D2 bits_offset=3D0
        'b' type_id=3D2 bits_offset=3D32
  ...

The btf_tag selftest also succeeded:
  $ ./test_progs -t tag
    #21 btf_tag:OK
    Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/tag.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/tag.c b/tools/testing/self=
tests/bpf/progs/tag.c
index 672d19e7b120..1792f4eda095 100644
--- a/tools/testing/selftests/bpf/progs/tag.c
+++ b/tools/testing/selftests/bpf/progs/tag.c
@@ -24,18 +24,23 @@ struct key_t {
 	int c;
 } __tag1 __tag2;
=20
+typedef struct {
+	int a;
+	int b;
+} value_t __tag1 __tag2;
+
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(max_entries, 3);
 	__type(key, struct key_t);
-	__type(value, __u64);
+	__type(value, value_t);
 } hashmap1 SEC(".maps");
=20
=20
 static __noinline int foo(int x __tag1 __tag2) __tag1 __tag2
 {
 	struct key_t key;
-	__u64 val =3D 1;
+	value_t val =3D {};
=20
 	key.a =3D key.b =3D key.c =3D x;
 	bpf_map_update_elem(&hashmap1, &key, &val, 0);
--=20
2.30.2

