Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D177335C8BD
	for <lists+bpf@lfdr.de>; Mon, 12 Apr 2021 16:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbhDLO34 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 10:29:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10116 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241820AbhDLO3z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Apr 2021 10:29:55 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CEQX8W020446
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 07:29:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/J836uGdjnoZNS+SmzkhLb1RvwunfsbasQkPupPM6tU=;
 b=rbN0LpHiNLyvNkvegGXD5mzpGDZnjvAeYaCXFQMCNLaDKTXb5HWzWUGUYsYUuL1VVywA
 DyTirizRy7zwPHf6ExeIA+V3EZpD9wzWLlzt+sCqME4WXxZDUPgRjO5xvw7vmeY8ZTRN
 rGt36LxGuTT5hNEQY4vWLi7+FGEPikA4x9k= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37uv3pdj75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 07:29:37 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 07:29:36 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id CB0701569ABE; Mon, 12 Apr 2021 07:29:32 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH bpf-next v2 5/5] bpftool: fix a clang compilation warning
Date:   Mon, 12 Apr 2021 07:29:32 -0700
Message-ID: <20210412142932.268930-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412142905.266942-1-yhs@fb.com>
References: <20210412142905.266942-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FkUhaQDnZPgfhokW5tmdTHGUJxGudDcQ
X-Proofpoint-GUID: FkUhaQDnZPgfhokW5tmdTHGUJxGudDcQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=761
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With clang compiler:
  make -j60 LLVM=3D1 LLVM_IAS=3D1  <=3D=3D=3D compile kernel
  # build selftests/bpf or bpftool
  make -j60 -C tools/testing/selftests/bpf LLVM=3D1 LLVM_IAS=3D1
  make -j60 -C tools/bpf/bpftool LLVM=3D1 LLVM_IAS=3D1
the following compilation warning showed up,
  net.c:160:37: warning: comparison of integers of different signs: '__u3=
2' (aka 'unsigned int') and 'int' [-Wsign-compare]
                for (nh =3D (struct nlmsghdr *)buf; NLMSG_OK(nh, len);
                                                  ^~~~~~~~~~~~~~~~~
  .../tools/include/uapi/linux/netlink.h:99:24: note: expanded from macro=
 'NLMSG_OK'
                           (nlh)->nlmsg_len <=3D (len))
                           ~~~~~~~~~~~~~~~~ ^   ~~~

In this particular case, "len" is defined as "int" and (nlh)->nlmsg_len i=
s "unsigned int".
The macro NLMSG_OK is defined as below in uapi/linux/netlink.h.
  #define NLMSG_OK(nlh,len) ((len) >=3D (int)sizeof(struct nlmsghdr) && \
                             (nlh)->nlmsg_len >=3D sizeof(struct nlmsghdr=
) && \
                             (nlh)->nlmsg_len <=3D (len))

The clang compiler complains the comparision "(nlh)->nlmsg_len <=3D (len)=
)",
but in bpftool/net.c, it is already ensured that "len > 0" must be true.
So theoretically the compiler could deduce that comparison of
"(nlh)->nlmsg_len" and "len" is okay, but this really depends on compiler
internals. Let us add an explicit type conversion (from "int" to "unsigne=
d int")
for "len" in NLMSG_OK to silence this warning right now.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index ff3aa0cf3997..f836d115d7d6 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -157,7 +157,7 @@ static int netlink_recv(int sock, __u32 nl_pid, __u32=
 seq,
 		if (len =3D=3D 0)
 			break;
=20
-		for (nh =3D (struct nlmsghdr *)buf; NLMSG_OK(nh, len);
+		for (nh =3D (struct nlmsghdr *)buf; NLMSG_OK(nh, (unsigned int)len);
 		     nh =3D NLMSG_NEXT(nh, len)) {
 			if (nh->nlmsg_pid !=3D nl_pid) {
 				ret =3D -LIBBPF_ERRNO__WRNGPID;
--=20
2.30.2

