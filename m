Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065E7446BF0
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 02:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhKFBnG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 21:43:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1112 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229816AbhKFBnE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 21:43:04 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A5MEwdA002760
        for <bpf@vger.kernel.org>; Fri, 5 Nov 2021 18:40:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=gfEUzRmCyhPdQ3AtalMDI+uHreoWYlATE4aQD3JaTAg=;
 b=LTgGGcdlm2SqMDX4tnVatTmlRAnk15n5xxf//LqbJCq07HOWRQUYg6A0s2UsWPZiFVCi
 rAIojTwoSyC8D62axTiJHD2PvmSML1JSS5mYnTS0von+lF3XYCRE5JHretw8Oi6DmpcI
 wvaHipcfOGf+u386DPlTjb6zyIYv2qjTHcw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3c5cjxh864-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 18:40:23 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 5 Nov 2021 18:40:22 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 637441F57C7B; Fri,  5 Nov 2021 18:40:20 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf 2/2] bpf: selftest: Trigger a DCE on the whole subprog
Date:   Fri, 5 Nov 2021 18:40:20 -0700
Message-ID: <20211106014020.651638-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211106014007.650366-1-kafai@fb.com>
References: <20211106014007.650366-1-kafai@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 6AM5CDNT40fnZOvngPUncDNdGlvNSPrg
X-Proofpoint-ORIG-GUID: 6AM5CDNT40fnZOvngPUncDNdGlvNSPrg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_03,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 mlxlogscore=861 mlxscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111060006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a test to trigger the DCE to remove
the whole subprog to ensure the verifier  does not
depend on a stable subprog index.  The DCE is done
by testing a global const.

Signed-off-by: Martin KaFai Lau <kafai@fb.com>
---
 .../selftests/bpf/progs/for_each_array_map_elem.c    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/for_each_array_map_elem.c =
b/tools/testing/selftests/bpf/progs/for_each_array_map_elem.c
index df918b2469da..52f6995ff29c 100644
--- a/tools/testing/selftests/bpf/progs/for_each_array_map_elem.c
+++ b/tools/testing/selftests/bpf/progs/for_each_array_map_elem.c
@@ -23,6 +23,16 @@ struct callback_ctx {
 	int output;
 };
=20
+const volatile int bypass_unused =3D 1;
+
+static __u64
+unused_subprog(struct bpf_map *map, __u32 *key, __u64 *val,
+	       struct callback_ctx *data)
+{
+	data->output =3D 0;
+	return 1;
+}
+
 static __u64
 check_array_elem(struct bpf_map *map, __u32 *key, __u64 *val,
 		 struct callback_ctx *data)
@@ -54,6 +64,8 @@ int test_pkt_access(struct __sk_buff *skb)
=20
 	data.output =3D 0;
 	bpf_for_each_map_elem(&arraymap, check_array_elem, &data, 0);
+	if (!bypass_unused)
+		bpf_for_each_map_elem(&arraymap, unused_subprog, &data, 0);
 	arraymap_output =3D data.output;
=20
 	bpf_for_each_map_elem(&percpu_map, check_percpu_elem, (void *)0, 0);
--=20
2.30.2

