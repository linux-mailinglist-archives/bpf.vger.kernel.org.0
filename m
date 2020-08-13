Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B504D24405F
	for <lists+bpf@lfdr.de>; Thu, 13 Aug 2020 23:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMVKa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 17:10:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60902 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbgHMVK3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Aug 2020 17:10:29 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DL8msA027005
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 14:10:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lebRymaAfQ9BjFWeAkazJFGEgnkqS8Y68Fu7bbEYQlU=;
 b=UJqKrkvBLGOUvgVvs1EiVE6o4rdjVQGl8qqWbXVT4/ckV+QqKhheP5/UkQtrSGjvylFp
 Xb8Qk0TQ6w4EEQRsgExsHMIx6AfEjwVzTIWHXrah+bs7z8yl3zsQ5yTkY+69rHpf3L4q
 hPQ3yp1TfTaqnDKRxoU8hBHWrtuSsDQSXLk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32v0kg45b5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 14:10:29 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 13 Aug 2020 14:10:27 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 20F582EC597F; Thu, 13 Aug 2020 13:50:04 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf 6/9] libbpf: enforce 64-bitness of BTF for BPF object files
Date:   Thu, 13 Aug 2020 13:49:42 -0700
Message-ID: <20200813204945.1020225-7-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813204945.1020225-1-andriin@fb.com>
References: <20200813204945.1020225-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_17:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=8 adultscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130151
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF object files are always targeting 64-bit BPF target architecture, so
enforce that at BTF level as well.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4a8524b2dda1..738579c338a5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2434,6 +2434,8 @@ static int bpf_object__init_btf(struct bpf_object *=
obj,
 				BTF_ELF_SEC, err);
 			goto out;
 		}
+		/* enforce 8-byte pointers for BPF-targeted BTFs */
+		btf__set_pointer_size(obj->btf, 8);
 		err =3D 0;
 	}
 	if (btf_ext_data) {
@@ -2542,6 +2544,8 @@ static int bpf_object__sanitize_and_load_btf(struct=
 bpf_object *obj)
 		if (IS_ERR(kern_btf))
 			return PTR_ERR(kern_btf);
=20
+		/* enforce 8-byte pointers for BPF-targeted BTFs */
+		btf__set_pointer_size(obj->btf, 8);
 		bpf_object__sanitize_btf(obj, kern_btf);
 	}
=20
--=20
2.24.1

