Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CF2320393
	for <lists+bpf@lfdr.de>; Sat, 20 Feb 2021 04:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBTDvF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Feb 2021 22:51:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229725AbhBTDvD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Feb 2021 22:51:03 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11K3fta1048917;
        Fri, 19 Feb 2021 22:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=qNVOCN/JpH74P+rs/uUChGVaRAT1ODRhEnuaWJBTSTI=;
 b=GJi80VjZ6rqQjSrSNjyEdYQs/AsD6zHtHN2BtG0ekVMgnLGuZ2f1dcHEm05uTmDtzfWu
 fF0VwbTAY2xhoZH4YXd03U4LP31Q7Yq9XxpcsDkLRgt6T9XEFBOPfWb/GnDvJSfwkprq
 JlDN3XrWxldAxD1QPplNNPSWEsHc76d5Jq2qa8/hI1+O/Jrij+FqIsAJ8BDNhguNxWVC
 5e7fkHX8b6sdEwd6nFvWq78lCiKZdMsBgnfi2fHr9qjnjjVkj/mFnHCimq5wwS5qqupT
 7nIn8UIfpfok+Whf1vzQfQwbTfvriI9sA377YGE+J24x1Paffj8UlgzPWGc2wxVd51rz Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ttrc8447-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 22:50:09 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11K3gxIO050880;
        Fri, 19 Feb 2021 22:50:08 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ttrc842u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 22:50:08 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11K3mskn005418;
        Sat, 20 Feb 2021 03:50:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 36tt2800rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Feb 2021 03:50:04 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11K3o1wg41681344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Feb 2021 03:50:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B084652051;
        Sat, 20 Feb 2021 03:50:01 +0000 (GMT)
Received: from vm.lan (unknown [9.145.178.56])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2EBA35204F;
        Sat, 20 Feb 2021 03:50:01 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 bpf-next 0/6] Add BTF_KIND_FLOAT support
Date:   Sat, 20 Feb 2021 04:49:53 +0100
Message-Id: <20210220034959.27006-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102200026
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some BPF programs compiled on s390 fail to load, because s390
arch-specific linux headers contain float and double types.
    
Introduce support for such types by representing them using the new
BTF_KIND_FLOAT. This series deals with libbpf, bpftool, in-kernel BTF
parser as well as selftests and documentation.

There are also pahole and LLVM parts:

* https://github.com/iii-i/dwarves/commit/btf-kind-float-v2
* https://reviews.llvm.org/D83289

but they should go in after the libbpf part is integrated.

---

v0: https://lore.kernel.org/bpf/20210210030317.78820-1-iii@linux.ibm.com/
v0 -> v1: Per Andrii's suggestion, remove the unnecessary trailing u32.

v1: https://lore.kernel.org/bpf/20210216011216.3168-1-iii@linux.ibm.com/
v1 -> v2: John noticed that sanitization corrupts BTF, because new and
          old sizes don't match. Per Yonghong's suggestion, use a
          modifier type (which has the same size as the float type) as
          a replacement.
          Per Yonghong's suggestion, add size and alignment checks to
          the kernel BTF parser.

v2: https://lore.kernel.org/bpf/20210219022543.20893-1-iii@linux.ibm.com/
v2 -> v3: Based on Yonghong's suggestions: Use BTF_KIND_CONST instead of
          BTF_KIND_TYPEDEF and make sure that the C code generated from
          the sanitized BTF is well-formed; fix size calculation in
          tests and use NAME_TBD everywhere; limit allowed sizes to 2,
          4, 8, 12 and 16 (this should also fix m68k and nds32le
          builds).

Based on Alexei's feedback [1] I'm proceeding with the BTF_KIND_FLOAT
approach.

[1] https://lore.kernel.org/bpf/CAADnVQKWPODWZ2RSJ5FJhfYpxkuV0cvSAL1O+FSr9oP1ercoBg@mail.gmail.com/

Ilya Leoshkevich (6):
  bpf: Add BTF_KIND_FLOAT to uapi
  libbpf: Add BTF_KIND_FLOAT support
  tools/bpftool: Add BTF_KIND_FLOAT support
  bpf: Add BTF_KIND_FLOAT support
  selftest/bpf: Add BTF_KIND_FLOAT tests
  bpf: Document BTF_KIND_FLOAT in btf.rst

 Documentation/bpf/btf.rst                    |  17 ++-
 include/uapi/linux/btf.h                     |   5 +-
 kernel/bpf/btf.c                             |  77 ++++++++++-
 tools/bpf/bpftool/btf.c                      |   8 ++
 tools/bpf/bpftool/btf_dumper.c               |   1 +
 tools/include/uapi/linux/btf.h               |   5 +-
 tools/lib/bpf/btf.c                          |  44 +++++++
 tools/lib/bpf/btf.h                          |   8 ++
 tools/lib/bpf/btf_dump.c                     |   4 +
 tools/lib/bpf/libbpf.c                       |  48 ++++++-
 tools/lib/bpf/libbpf.map                     |   5 +
 tools/lib/bpf/libbpf_internal.h              |   2 +
 tools/testing/selftests/bpf/btf_helpers.c    |   4 +
 tools/testing/selftests/bpf/prog_tests/btf.c | 129 +++++++++++++++++++
 tools/testing/selftests/bpf/test_btf.h       |   3 +
 15 files changed, 351 insertions(+), 9 deletions(-)

-- 
2.29.2

