Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772374A54C2
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 02:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiBABqS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 20:46:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46002 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229824AbiBABqR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 31 Jan 2022 20:46:17 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21111PGN009200
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 17:46:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=FmSTvm0Ii+vy4ZhORbNMsUpp23j4kFGrD6lHPXCnGew=;
 b=Nl2T8R1Lab9qaTmuRJagb2ikNi3BUT01xlfhvfgEGG7SYq1qms8hr1/u2/8rzkPzBcz1
 Sekta8xWO0Q4jxnWijP/mdYlHWsYp2Ifd6U5pd/Y2GImMLf0iKo6fobiwSJ7nnczu9dG
 y+LCAcTVk/J2OanU4grZVB48peuLH0wdUw0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxm2p2yr5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 17:46:17 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 17:46:16 -0800
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 2AF45D2D6072; Mon, 31 Jan 2022 17:46:12 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next] libbpf: deprecate btf_ext rec_size APIs
Date:   Mon, 31 Jan 2022 17:46:10 -0800
Message-ID: <20220201014610.3522985-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Wbe8605bZeBlUVglS_PeRAPtOMC9bqvO
X-Proofpoint-ORIG-GUID: Wbe8605bZeBlUVglS_PeRAPtOMC9bqvO
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010008
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

v2: LIBBPF_DEPRECATED_SINCE -> LIBBPF_DEPRECATED to match
    reloc_{func,line}_info deprecations [Daniel]

 tools/lib/bpf/btf.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 96b44d55db6e..b10729fd830c 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -168,8 +168,10 @@ int btf_ext__reloc_line_info(const struct btf *btf,
 			     const struct btf_ext *btf_ext,
 			     const char *sec_name, __u32 insns_cnt,
 			     void **line_info, __u32 *cnt);
-LIBBPF_API __u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_ext=
);
-LIBBPF_API __u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext=
);
+LIBBPF_API LIBBPF_DEPRECATED("btf_ext__reloc_func_info is deprecated; writ=
e custom func_info parsing to fetch rec_size")
+__u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_ext);
+LIBBPF_API LIBBPF_DEPRECATED("btf_ext__reloc_line_info is deprecated; writ=
e custom line_info parsing to fetch rec_size")
+__u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext);
=20
 LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
 LIBBPF_API int btf__add_str(struct btf *btf, const char *s);
--=20
2.30.2

