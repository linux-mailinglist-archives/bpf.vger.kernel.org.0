Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29D44EE2B
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 21:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhKLU4L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 15:56:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12016 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235335AbhKLU4K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Nov 2021 15:56:10 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ACKpvvL016201
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 12:53:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HbkCpS4xSO5+Wl8k5HkroNNAn+OrwvM0u56evJ3qjOs=;
 b=W9+exQAsIqkFQ4I971I35Hxzh48OIA2MRGzLKMciQ2Leu2+o1I2y4yfa8O6xNJk5WHlX
 KviTFQS9eit4kTC3SHxscK4NqNurz3CcyeNuK0dZQNJeTlqL6nXO7T3qxTXEHu0XVodo
 V6jsJWdEEIAWDIGh2ijwvvtzRZFN3+ouY0k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c98k5a339-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 12:53:18 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 12 Nov 2021 12:48:40 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id F266D25602D1; Fri, 12 Nov 2021 12:48:38 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: fix a tautological-constant-out-of-range-compare compiler warning
Date:   Fri, 12 Nov 2021 12:48:38 -0800
Message-ID: <20211112204838.3579953-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211112204833.3579457-1-yhs@fb.com>
References: <20211112204833.3579457-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: KdMkE9lUmfawbQq8bgtUurCkmr6sF4Bb
X-Proofpoint-GUID: KdMkE9lUmfawbQq8bgtUurCkmr6sF4Bb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_05,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When using clang to build selftests with LLVM=3D1 in make commandline,
I hit the following compiler warning:

  benchs/bench_bloom_filter_map.c:84:46: warning: result of comparison of=
 constant 256
    with expression of type '__u8' (aka 'unsigned char') is always false
    [-Wtautological-constant-out-of-range-compare]
                if (args.value_size < 2 || args.value_size > 256) {
                                           ~~~~~~~~~~~~~~~ ^ ~~~

The reason is arg.vaue_size has type __u8, so comparison "args.value_size=
 > 256"
is always false.

This patch fixed the issue by doing proper comparison before assigning th=
e
value to args.value_size. The patch also fixed the same issue in two
other places.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../bpf/benchs/bench_bloom_filter_map.c         | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c =
b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
index 6eeeed2913e6..5bcb8a8cdeb2 100644
--- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
+++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
@@ -63,29 +63,34 @@ static const struct argp_option opts[] =3D {
=20
 static error_t parse_arg(int key, char *arg, struct argp_state *state)
 {
+	long ret;
+
 	switch (key) {
 	case ARG_NR_ENTRIES:
-		args.nr_entries =3D strtol(arg, NULL, 10);
-		if (args.nr_entries =3D=3D 0) {
+		ret =3D strtol(arg, NULL, 10);
+		if (ret < 1 || ret > UINT_MAX) {
 			fprintf(stderr, "Invalid nr_entries count.");
 			argp_usage(state);
 		}
+		args.nr_entries =3D ret;
 		break;
 	case ARG_NR_HASH_FUNCS:
-		args.nr_hash_funcs =3D strtol(arg, NULL, 10);
-		if (args.nr_hash_funcs =3D=3D 0 || args.nr_hash_funcs > 15) {
+		ret =3D strtol(arg, NULL, 10);
+		if (ret < 1 || ret > 15) {
 			fprintf(stderr,
 				"The bloom filter must use 1 to 15 hash functions.");
 			argp_usage(state);
 		}
+		args.nr_hash_funcs =3D ret;
 		break;
 	case ARG_VALUE_SIZE:
-		args.value_size =3D strtol(arg, NULL, 10);
-		if (args.value_size < 2 || args.value_size > 256) {
+		ret =3D strtol(arg, NULL, 10);
+		if (ret < 2 || ret > 256) {
 			fprintf(stderr,
 				"Invalid value size. Must be between 2 and 256 bytes");
 			argp_usage(state);
 		}
+		args.value_size =3D ret;
 		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
--=20
2.30.2

