Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE62315DAF
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 04:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhBJDEr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 22:04:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233471AbhBJDE3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 22:04:29 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11A33G4w107263;
        Tue, 9 Feb 2021 22:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=RrgcVWEG+j2Tfz8xUfMsS8x55HqZlE+Wbf7hNs75Y9g=;
 b=e1IKH3MdCIXpkL5YLeQcM2DbnzkesDSnPpw/kc2XL6TNPX9V+0LpX8qyJ+X+pt6Z4eUi
 t7iuh/x+og/bkagGAz68jpQIT71wr8sjvfRLrCkZ5uZmc+z5sK5i8uUta/5HVM3Jf4gH
 gHSdQfLIpQLl71X8ltRI5NJBBy8uMFVym1kbftEkXhHBQCGG+H9fMO49kpzVEBCdhr0Z
 ttvd3Gt6UJXhYQPxDNGFTBgIo6fB6fWgKAXQIQhu3fGPPsn1WfHultsxGTZAoDWdbtbX
 EOfeyTa7HrBDFoUDmMrHW8vb0m/C3bG/WvzKVmesRLdMR+t2DSdcWgvnFJuTFmH8a/Z4 Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36m72x874d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 22:03:33 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11A33WJR108489;
        Tue, 9 Feb 2021 22:03:32 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36m72x873t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 22:03:32 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11A33V2I005100;
        Wed, 10 Feb 2021 03:03:31 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 36hjr7t5v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 03:03:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11A33SF9524922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 03:03:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E45C3A404D;
        Wed, 10 Feb 2021 03:03:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CA89A4040;
        Wed, 10 Feb 2021 03:03:27 +0000 (GMT)
Received: from vm.lan (unknown [9.171.67.27])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Feb 2021 03:03:27 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC 0/6] Add BTF_KIND_FLOAT support
Date:   Wed, 10 Feb 2021 04:03:11 +0100
Message-Id: <20210210030317.78820-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 mlxscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100031
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some BPF programs compiled on s390 fail to load, because s390
arch-specific linux headers contain float and double types.
    
Introduce support for such types by representing them using the new
BTF_KIND_FLOAT. This series deals with libbpf, bpftool, in-kernel BTF
parser as well as selftests and documentation.

There are also pahole and LLVM parts:

* https://github.com/iii-i/dwarves/commit/btf-kind-float-v1
* https://reviews.llvm.org/D83289

but they should go in after the libbpf part is integrated.

There is also an open question: should we go forward with
BTF_KIND_FLOAT, or should this be merely a BTF_KIND_INT encoding? The
argument for BTF_KIND_FLOAT is that it's more explicit and therefore
less prone to unintentional mixups. The argument for BTF_KIND_INT
encoding is that there would be less code and the overall integration
process would be simpler.

Ilya Leoshkevich (6):
  bpf: Add BTF_KIND_FLOAT to uapi
  libbpf: Add BTF_KIND_FLOAT support
  tools/bpftool: Add BTF_KIND_FLOAT support
  bpf: Add BTF_KIND_FLOAT support
  selftest/bpf: Add BTF_KIND_FLOAT tests
  bpf: Document BTF_KIND_FLOAT in btf.rst

 Documentation/bpf/btf.rst                    |  19 ++-
 include/uapi/linux/btf.h                     |  10 +-
 kernel/bpf/btf.c                             | 101 ++++++++++++-
 tools/bpf/bpftool/btf.c                      |  13 ++
 tools/bpf/bpftool/btf_dumper.c               |   1 +
 tools/include/uapi/linux/btf.h               |  10 +-
 tools/lib/bpf/btf.c                          |  85 ++++++++---
 tools/lib/bpf/btf.h                          |  13 ++
 tools/lib/bpf/btf_dump.c                     |   4 +
 tools/lib/bpf/libbpf.c                       |  32 +++-
 tools/lib/bpf/libbpf.map                     |   5 +
 tools/lib/bpf/libbpf_internal.h              |   4 +
 tools/testing/selftests/bpf/btf_helpers.c    |   4 +
 tools/testing/selftests/bpf/prog_tests/btf.c | 145 +++++++++++++++++++
 tools/testing/selftests/bpf/test_btf.h       |   5 +
 15 files changed, 418 insertions(+), 33 deletions(-)

-- 
2.29.2

