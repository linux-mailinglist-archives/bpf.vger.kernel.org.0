Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0843E40BB6E
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 00:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhINWbw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 18:31:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62624 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235429AbhINWbw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 18:31:52 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.0.43) with SMTP id 18EG31OI026919
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:30:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=u67k1aJZ5CCtvemXNPWvkAGXCnUmWXRfcEr178n/ot8=;
 b=C1XK2j+lG7C2AHwJaE5D4bXceq4aLB9J7w7SjemCdkohwLIx6mxWpj0s4I+4WljYCcWF
 NKXWtM5zxTgI4ODJABN7HXMB4VgwYk9rwfglXzARC0IumwyAshvQIXU1Nj0kK1kw0TpR
 T24/how+f1MRIBYuMNwvbokqI7Kit0CrZ4s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3b2k1rp8gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 15:30:34 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 15:30:32 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 63BCF7382234; Tue, 14 Sep 2021 15:30:31 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 05/11] bpftool: add support for BTF_KIND_TAG
Date:   Tue, 14 Sep 2021 15:30:31 -0700
Message-ID: <20210914223031.246951-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914223004.244411-1-yhs@fb.com>
References: <20210914223004.244411-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Bgum0DIei3gPHeXNX5gy9DTBpfk4UxyM
X-Proofpoint-ORIG-GUID: Bgum0DIei3gPHeXNX5gy9DTBpfk4UxyM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_08,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added bpftool support to dump BTF_KIND_TAG information.
The new bpftool will be used in later patches to dump
btf in the test bpf program object file.

Currently, the tags are not emitted with
  bpftool btf dump file <path> format c
and they are silently ignored.  The tag information is
mostly used in the kernel for verification purpose and the kernel
uses its own btf to check. With adding these tags
to vmlinux.h, tags will be encoded in program's btf but
they will not be used by the kernel, at least for now.
So let us delay adding these tags to format C header files
until there is a real need.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/btf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index f7e5ff3586c9..49743ad96851 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -37,6 +37,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] =3D=
 {
 	[BTF_KIND_VAR]		=3D "VAR",
 	[BTF_KIND_DATASEC]	=3D "DATASEC",
 	[BTF_KIND_FLOAT]	=3D "FLOAT",
+	[BTF_KIND_TAG]		=3D "TAG",
 };
=20
 struct btf_attach_table {
@@ -347,6 +348,17 @@ static int dump_btf_type(const struct btf *btf, __u3=
2 id,
 			printf(" size=3D%u", t->size);
 		break;
 	}
+	case BTF_KIND_TAG: {
+		const struct btf_tag *tag =3D (const void *)(t + 1);
+
+		if (json_output) {
+			jsonw_uint_field(w, "type_id", t->type);
+			jsonw_int_field(w, "component_idx", tag->component_idx);
+		} else {
+			printf(" type_id=3D%u component_idx=3D%d", t->type, tag->component_id=
x);
+		}
+		break;
+	}
 	default:
 		break;
 	}
--=20
2.30.2

