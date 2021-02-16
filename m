Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA46A31C4E0
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 02:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBPBNY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 20:13:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229708AbhBPBNX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 15 Feb 2021 20:13:23 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11G131Bs065457;
        Mon, 15 Feb 2021 20:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=X/f2fiu3YKAKwxv8gY4jMSco9on7jhwB4NceCBmBVWY=;
 b=QMgaSPrPBrQH/Eo7VcWQChdCDIdYwdY1hWRvg+nYk2I4DH3JDPIeyjNnRmXsHUvPuc5K
 xivHDCnCnuo7jyF5irz2h0Mdf5WUIUX69WOyKGEwJkN5YBoaJbYoBrF9dm51NJX3qdwf
 M2e1m6dFt44e6qevF0bPYcp78mQ5XtU117+F1LA/ytQvibX5PaaJ7EiOsUwgIMk2mjOq
 CuhV+JFzF/29t/jCBAFY4XCbI2Egq3t8AI4GKG1rfFtKUHf58g8OSa3lUv6oN4cH0v9Q
 /EKwZhH3xg6/b4ry49Nm2h4pwAsXnhd0oTb1do/zy1NXUWXUWSuCTtemH+dYro0BBlGe 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36r40u09me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 20:12:28 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11G13QG8069834;
        Mon, 15 Feb 2021 20:12:27 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36r40u09ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 20:12:27 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11G1BnQd022730;
        Tue, 16 Feb 2021 01:12:24 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 36p6d8aanj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 01:12:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11G1CM2d41746880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 01:12:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0862B11C050;
        Tue, 16 Feb 2021 01:12:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B76011C052;
        Tue, 16 Feb 2021 01:12:21 +0000 (GMT)
Received: from vm.lan (unknown [9.171.16.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Feb 2021 01:12:21 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/6] Add BTF_KIND_FLOAT support
Date:   Tue, 16 Feb 2021 02:12:10 +0100
Message-Id: <20210216011216.3168-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0
 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102160008
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

 Documentation/bpf/btf.rst                    | 17 +++-
 include/uapi/linux/btf.h                     |  5 +-
 kernel/bpf/btf.c                             | 66 ++++++++++++++-
 tools/bpf/bpftool/btf.c                      |  8 ++
 tools/bpf/bpftool/btf_dumper.c               |  1 +
 tools/include/uapi/linux/btf.h               |  5 +-
 tools/lib/bpf/btf.c                          | 44 ++++++++++
 tools/lib/bpf/btf.h                          |  8 ++
 tools/lib/bpf/btf_dump.c                     |  4 +
 tools/lib/bpf/libbpf.c                       | 29 ++++++-
 tools/lib/bpf/libbpf.map                     |  5 ++
 tools/lib/bpf/libbpf_internal.h              |  2 +
 tools/testing/selftests/bpf/btf_helpers.c    |  4 +
 tools/testing/selftests/bpf/prog_tests/btf.c | 84 ++++++++++++++++++++
 tools/testing/selftests/bpf/test_btf.h       |  3 +
 15 files changed, 276 insertions(+), 9 deletions(-)

-- 
2.29.2

