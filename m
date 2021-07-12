Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B897A3C614D
	for <lists+bpf@lfdr.de>; Mon, 12 Jul 2021 18:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhGLRBd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 13:01:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55294 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232710AbhGLRBd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Jul 2021 13:01:33 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 16CGtxkM007933
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 09:58:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=3Y/h1e9+vZgPe6o7sigLh3gqYaOVWBmnpx3f95YD2eI=;
 b=XQMi8AProB8LhEplgOsUx0VJgyFzVYrTsG/+Yogz2ePCZE06zbugCqK3aDToinp+PjQ7
 EDj/py/X7Zq2tok8lqZrvUGM8QbIvQIIofKIlt6B7JcbMJenmjnDYZsLrGty4xlPQ2Tn
 2hg7LkbxYE6xZKHPULuM5F8JofUDyvfjDwM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 39rsbn87ba-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 09:58:44 -0700
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 09:58:40 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 2A7F14AE63AD; Mon, 12 Jul 2021 09:58:32 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2] libbpf: fix compilation errors on ubuntu 16.04
Date:   Mon, 12 Jul 2021 09:58:32 -0700
Message-ID: <20210712165832.1833460-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-GUID: rrZYkxEyhMWjHeHqAiK7btr3ezruDSKG
X-Proofpoint-ORIG-GUID: rrZYkxEyhMWjHeHqAiK7btr3ezruDSKG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_09:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=856 clxscore=1015 mlxscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf is used as a submodule in bcc.
When importing latest libbpf repo in bcc, I observed the
following compilation errors when compiling on ubuntu 16.04.
  .../netlink.c:416:23: error: =E2=80=98TC_H_CLSACT=E2=80=99 undeclared (=
first use in this function)
     *parent =3D TC_H_MAKE(TC_H_CLSACT,
                         ^
  .../netlink.c:418:9: error: =E2=80=98TC_H_MIN_INGRESS=E2=80=99 undeclar=
ed (first use in this function)
           TC_H_MIN_INGRESS : TC_H_MIN_EGRESS);
           ^
  .../netlink.c:418:28: error: =E2=80=98TC_H_MIN_EGRESS=E2=80=99 undeclar=
ed (first use in this function)
           TC_H_MIN_INGRESS : TC_H_MIN_EGRESS);
                              ^
  .../netlink.c: In function =E2=80=98__get_tc_info=E2=80=99:
  .../netlink.c:522:11: error: =E2=80=98TCA_BPF_ID=E2=80=99 undeclared (f=
irst use in this function)
    if (!tbb[TCA_BPF_ID])
             ^

In ubuntu 16.04, TCA_BPF_* enumerator looks like below
  enum {
	TCA_BPF_UNSPEC,
	TCA_BPF_ACT,
	...
	TCA_BPF_NAME,
	TCA_BPF_FLAGS,
	__TCA_BPF_MAX,
  };
  #define TCA_BPF_MAX	(__TCA_BPF_MAX - 1)
while in latest bpf-next, the enumerator looks like
  enum {
	TCA_BPF_UNSPEC,
	...
	TCA_BPF_FLAGS,
	TCA_BPF_FLAGS_GEN,
	TCA_BPF_TAG,
	TCA_BPF_ID,
	__TCA_BPF_MAX,
  };

In this patch, TCA_BPF_ID is defined as a macro with proper value and thi=
s
works regardless of whether TCA_BPF_ID is defined in uapi header or not.

I also added a comparison "TCA_BPF_MAX < TCA_BPF_ID" in function __get_tc=
_info()
such that if the compare result if true, returns -EOPNOTSUPP. This is use=
d to
prevent otherwise array overflows:
  .../netlink.c:538:10: warning: array subscript is above array bounds [-=
Warray-bounds]
    if (!tbb[TCA_BPF_ID])
            ^

Fixes: 715c5ce454a6 ("libbpf: Add low level TC-BPF management API")
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/netlink.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Changelog:
  v1 -> v2:
    - gcc 8.3 doesn't like macro condition
        (__TCA_BPF_MAX - 1) <=3D 10
      where __TCA_BPF_MAX is an enumerator value.
      So define TCA_BPF_ID macro without macro condition.

diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 39f25e09b51e..e00660e0b87a 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -22,6 +22,24 @@
 #define SOL_NETLINK 270
 #endif
=20
+#ifndef TC_H_CLSACT
+#define TC_H_CLSACT TC_H_INGRESS
+#endif
+
+#ifndef TC_H_MIN_INGRESS
+#define TC_H_MIN_INGRESS 0xFFF2U
+#endif
+
+#ifndef TC_H_MIN_EGRESS
+#define TC_H_MIN_EGRESS 0xFFF3U
+#endif
+
+/* TCA_BPF_ID is an enumerate value in uapi/linux/pkt_cls.h.
+ * Declare it as a macro here so old system can still work
+ * without TCA_BPF_ID defined in pkt_cls.h.
+ */
+#define TCA_BPF_ID 11
+
 typedef int (*libbpf_dump_nlmsg_t)(void *cookie, void *msg, struct nlatt=
r **tb);
=20
 typedef int (*__dump_nlmsg_t)(struct nlmsghdr *nlmsg, libbpf_dump_nlmsg_=
t,
@@ -504,6 +522,8 @@ static int __get_tc_info(void *cookie, struct tcmsg *=
tc, struct nlattr **tb,
 		return -EINVAL;
 	if (!tb[TCA_OPTIONS])
 		return NL_CONT;
+	if (TCA_BPF_MAX < TCA_BPF_ID)
+		return -EOPNOTSUPP;
=20
 	libbpf_nla_parse_nested(tbb, TCA_BPF_MAX, tb[TCA_OPTIONS], NULL);
 	if (!tbb[TCA_BPF_ID])
--=20
2.30.2

