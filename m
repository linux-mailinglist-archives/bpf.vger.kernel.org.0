Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AA13C6399
	for <lists+bpf@lfdr.de>; Mon, 12 Jul 2021 21:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbhGLTXw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 15:23:52 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5836 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234944AbhGLTXv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Jul 2021 15:23:51 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CJE4tD030700
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 12:21:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=UAAezNFLEH4x1ONLEHgNL646rA8fzaw9Su10l3zRVbc=;
 b=aOmghXJvzJonxGCzm/BhCOHlKp/sKNlt8EIaa2rTq88O/lBuj2ChPvtCKpJVx9BZmigt
 ZCKMjn6NBDV1Gedjx5nKq7e2vm+ramUIF7kg0jo25qMrdQDe9Wj1GacJyfWHaebNBdog
 gSYUcZGh24kJ8dP8SF4eBIDptYE2WW9D/4w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39q92y4568-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 12:21:02 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 12:20:59 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id F05834AF8858; Mon, 12 Jul 2021 12:20:55 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v3] libbpf: fix compilation errors on ubuntu 16.04
Date:   Mon, 12 Jul 2021 12:20:55 -0700
Message-ID: <20210712192055.2547468-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-GUID: mvS7r13frc8WUvhfcpuhwZN3H1gup6O0
X-Proofpoint-ORIG-GUID: mvS7r13frc8WUvhfcpuhwZN3H1gup6O0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_11:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 mlxlogscore=901
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120137
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
TCA_BPF_MAX is also adjusted in a similar way.

Fixes: 715c5ce454a6 ("libbpf: Add low level TC-BPF management API")
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/netlink.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

Changelog:
  v2 -> v3:
    - define/redefine TCA_BPF_MAX based on latest uapi header.
      this enables to remove the v2 check "TCA_BPF_MAX < TCA_BPF_ID"
      in __get_tc_info() which may cause -EOPNOTSUPP error
      if the library is compiled in old system and used in
      newer system.
     =20
  v1 -> v2:
    - gcc 8.3 doesn't like macro condition
        (__TCA_BPF_MAX - 1) <=3D 10
      where __TCA_BPF_MAX is an enumerator value.
      So define TCA_BPF_ID macro without macro condition.

diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 39f25e09b51e..37cb6b50f4b3 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -22,6 +22,29 @@
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
+/* TCA_BPF_ID is an enumerator value in uapi/linux/pkt_cls.h.
+ * Declare it as a macro here so old system can still work
+ * without TCA_BPF_ID defined in pkt_cls.h.
+ */
+#define TCA_BPF_ID 11
+
+#ifdef TCA_BPF_MAX
+#undef TCA_BPF_MAX
+#endif
+#define TCA_BPF_MAX 11
+
 typedef int (*libbpf_dump_nlmsg_t)(void *cookie, void *msg, struct nlatt=
r **tb);
=20
 typedef int (*__dump_nlmsg_t)(struct nlmsghdr *nlmsg, libbpf_dump_nlmsg_=
t,
--=20
2.30.2

