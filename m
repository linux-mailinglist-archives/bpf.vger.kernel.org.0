Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3650B49EA47
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 19:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243801AbiA0SWF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 13:22:05 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32704 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231634AbiA0SWE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 13:22:04 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RHIolc025270
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 10:22:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=bNnwjkogBsgTRzOWl+HXrib8phuz1G4UYxe3aEwSvGM=;
 b=Wc0WMHUcQZVUu8SXf+uO6l+8YO48qvkiJp2pMbBTQe0/v2iwoD3K9SsrMEK4kEZDk4Gj
 GAnUh+Evptqmut//UmCFEhsaIpKVh5MAltvW1y+41TIGhbsSm8CmyPfKgG6MIyUTfORZ
 BGU6/zIT1ZNOvDlK/fOaIJa7ej3TIGrW34c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dujva4ec6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 10:22:02 -0800
Received: from twshared2974.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 10:22:01 -0800
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 17FFBCF9E1AD; Thu, 27 Jan 2022 10:21:56 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next] libbpf: deprecate btf_ext rec_size APIs
Date:   Thu, 27 Jan 2022 10:21:54 -0800
Message-ID: <20220127182154.751999-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: MoXBKF083Pan9He8Q-aSy208loC__2PB
X-Proofpoint-ORIG-GUID: MoXBKF083Pan9He8Q-aSy208loC__2PB
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0
 mlxlogscore=954 adultscore=0 clxscore=1011 mlxscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_ext__{func,line}_info_rec_size functions are used in conjunction
with already-deprecated btf_ext__reloc_{func,line}_info functions. Since
struct btf_ext is opaque to the user it was necessary to expose rec_size
getters in the past.

btf_ext__reloc_{func,line}_info were deprecated in commit 8505e8709b5ee
("libbpf: Implement generalized .BTF.ext func/line info adjustment")
as they're not compatible with support for multiple programs per
section. It was decided[0] that users of these APIs should implement their
own .btf.ext parsing to access this data, in which case the rec_size
getters are unnecessary. So deprecate them from libbpf 0.7.0 onwards.

  [0] Closes: https://github.com/libbpf/libbpf/issues/277

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/lib/bpf/btf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 96b44d55db6e..c2f89a2cca11 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -168,7 +168,9 @@ int btf_ext__reloc_line_info(const struct btf *btf,
 			     const struct btf_ext *btf_ext,
 			     const char *sec_name, __u32 insns_cnt,
 			     void **line_info, __u32 *cnt);
+LIBBPF_DEPRECATED_SINCE(0, 7, "btf_ext__reloc_func_info is deprecated; wri=
te custom func_info parsing to fetch rec_size")
 LIBBPF_API __u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_ext=
);
+LIBBPF_DEPRECATED_SINCE(0, 7, "btf_ext__reloc_line_info is deprecated; wri=
te custom line_info parsing to fetch rec_size")
 LIBBPF_API __u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext=
);
=20
 LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
--=20
2.30.2

