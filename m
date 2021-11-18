Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC8D4562E3
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 19:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhKRSvP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 13:51:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3114 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229514AbhKRSvP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 13:51:15 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIFv2UV032731
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 10:48:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=XR9xj7f8QNwIPgJFhDAD3hyjnvKWt2z6nLq0UAbpknA=;
 b=DCDDIbLFp3MormieyI99kN4+p3xx4p8dcwUeo+VRFLaDldY/zB6eYs+psyxaEzRSQoHo
 k1ozFBfXnycrJCYuLHB6PMGNROw8iDhrPdvfRmaHIRx1e4/xvYT+9mJeGoG2m/Uftuje
 2Uu0Dj4IaxfM6Hmy1w7/O9SJ9NiOfNOuyMY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cdswy9e01-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 10:48:14 -0800
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 10:48:13 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id DD0F829A3E6C; Thu, 18 Nov 2021 10:48:10 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next v2 0/3] compiler attribute: define __user as __attribute__((btf_type_tag("user")))
Date:   Thu, 18 Nov 2021 10:48:10 -0800
Message-ID: <20211118184810.1846996-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: LY5nN6HdiGEjYeLGLpMoFu5Rx6K0NA7l
X-Proofpoint-ORIG-GUID: LY5nN6HdiGEjYeLGLpMoFu5Rx6K0NA7l
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=871 suspectscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111180099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Latest clang compiler supports a type attribute like
  __attribute__((btf_type_tag("<arbitrary string>")))
which can be used in places like __user/__rcu.
With the above attribute, clang was able to preserve the "<arbitrary string=
>"
info in dwarf and subsequently BTF. For example __user/__rcu
attribute can be preserved in BTF, which currently is loaded inside
the kernel. Such information can then be used by verifier to check
bpf program memory access conforms to the access attribute.
Please see Patches 1 and 2 for details.

This is a RFC patch as it depends on pahole patch and
a new pahole version. The following is pahole patch link:
  https://lore.kernel.org/bpf/20211117202214.3268824-1-yhs@fb.com/
Second, for bpf verifier use of this new __user tag information,
I only implemented support to check function parameter
dereference. More work will be needed to check other
non function parameter memory accesses.

Changelog:
  RFC v1 -> RFC v2:
   - kernel test bot reported a compilation error. Fix it.

Yonghong Song (3):
  compiler_types: define __user as __attribute__((btf_type_tag("user")))
  bpf: reject program if a __user tagged memory accessed in kernel way
  selftests/bpf: add a selftest with __user tag

 include/linux/bpf.h                           |  1 +
 include/linux/bpf_verifier.h                  |  1 +
 include/linux/btf.h                           |  5 ++++
 include/linux/compiler_types.h                |  2 ++
 kernel/bpf/btf.c                              | 13 ++++++++--
 kernel/bpf/verifier.c                         | 17 ++++++++++---
 lib/Kconfig.debug                             |  5 ++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  9 +++++++
 .../selftests/bpf/prog_tests/btf_tag.c        | 23 ++++++++++++++++++
 .../selftests/bpf/progs/btf_type_tag_user.c   | 24 +++++++++++++++++++
 10 files changed, 95 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag_user.c

--=20
2.30.2

