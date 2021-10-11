Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF04242888F
	for <lists+bpf@lfdr.de>; Mon, 11 Oct 2021 10:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbhJKIWx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 04:22:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22014 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234944AbhJKIWv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Oct 2021 04:22:51 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19AI3aIn009193
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 01:20:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Uez65aulhadKLJpn+NXYsgF0SuMdHpdNtV+Bqq7Fi3E=;
 b=itKuqBv0taOwbGH4zv5bHJr/qaYriXEY/LV6wvRnyhcpfO+iyjkjsE937SLMiIuZPWbx
 lhpz93FSNI5zmj/YNJMDlezG1fi7hjbBU40UkqUeYfJwQxIMw3ZWJ59QEQuwE4vP0BZ5
 Yys8qijXRb8zI4lvHgjDLcWMSJmKbo0QY2g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bm540ubwd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 01:20:51 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 11 Oct 2021 01:20:43 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 2EF737DCA117; Mon, 11 Oct 2021 01:20:35 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 4/4] libbpf: deprecate bpf_program__get_prog_info_linear
Date:   Mon, 11 Oct 2021 01:20:31 -0700
Message-ID: <20211011082031.4148337-5-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011082031.4148337-1-davemarchevsky@fb.com>
References: <20211011082031.4148337-1-davemarchevsky@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: FLOBmQ0i5tXXCEUyc4UrGGe7VXvLF5uv
X-Proofpoint-GUID: FLOBmQ0i5tXXCEUyc4UrGGe7VXvLF5uv
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_02,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=605
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110048
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

