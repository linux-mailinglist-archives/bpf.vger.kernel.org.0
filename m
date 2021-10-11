Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCFA428520
	for <lists+bpf@lfdr.de>; Mon, 11 Oct 2021 04:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhJKC3Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Oct 2021 22:29:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42116 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233260AbhJKC3Q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 10 Oct 2021 22:29:16 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19A8144s005420
        for <bpf@vger.kernel.org>; Sun, 10 Oct 2021 19:27:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Uez65aulhadKLJpn+NXYsgF0SuMdHpdNtV+Bqq7Fi3E=;
 b=ps3Y68hI3bVV05nMD7n9f2YvEU4FjLgl3pCaGTOWFMyqnd2GNf6NbLHlyHMjd4hGrMtW
 gQZmE/wN/zejshiJyn/Kx1lwLHijDxM57Qs6h4SrbKBmqxhjJaC3Jl4674ZRRE7XQbs6
 mU8hhd2fotHBS29SDoyIxtJL0MU0xbU1lf4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bkv9gv1r8-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 10 Oct 2021 19:27:16 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 10 Oct 2021 19:27:14 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 3DAAF7D98F84; Sun, 10 Oct 2021 19:27:10 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 4/4] libbpf: deprecate bpf_program__get_prog_info_linear
Date:   Sun, 10 Oct 2021 19:27:04 -0700
Message-ID: <20211011022704.2143205-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011022704.2143205-1-davemarchevsky@fb.com>
References: <20211011022704.2143205-1-davemarchevsky@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 9BxHOdRKsplU8ikkcOQpgGBNso7HAK9z
X-Proofpoint-ORIG-GUID: 9BxHOdRKsplU8ikkcOQpgGBNso7HAK9z
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-10_07,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=606 suspectscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110012
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As part of the road to libbpf 1.0, and discussed in libbpf issue tracker
[0], bpf_program__get_prog_info_linear and its associated structs and
helper functions should be deprecated. The functionality is too specific
to the needs of 'perf', and there's little/no out-of-tree usage to
preclude introduction of a more general helper in the future.

[0] Closes: https://github.com/libbpf/libbpf/issues/313

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/lib/bpf/libbpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 89ca9c83ed4e..285008b46e1b 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -877,12 +877,15 @@ struct bpf_prog_info_linear {
 	__u8			data[];
 };
=20
+LIBBPF_DEPRECATED_SINCE(0, 7, "use a custom linear prog_info wrapper")
 LIBBPF_API struct bpf_prog_info_linear *
 bpf_program__get_prog_info_linear(int fd, __u64 arrays);
=20
+LIBBPF_DEPRECATED_SINCE(0, 7, "use a custom linear prog_info wrapper")
 LIBBPF_API void
 bpf_program__bpil_addr_to_offs(struct bpf_prog_info_linear *info_linear);
=20
+LIBBPF_DEPRECATED_SINCE(0, 7, "use a custom linear prog_info wrapper")
 LIBBPF_API void
 bpf_program__bpil_offs_to_addr(struct bpf_prog_info_linear *info_linear);
=20
--=20
2.30.2

