Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5458432F0C7
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 18:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCERJb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 12:09:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231373AbhCERJI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Mar 2021 12:09:08 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125H4Y6t077480;
        Fri, 5 Mar 2021 12:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5ld40VVUx76aagFHxZNPAx0PXlW8S5/XSil9SI+w8Ls=;
 b=V1Ulo0Kg6CFUsTUE3gX3zcPJjEqUGB5rlPfGtCMO7i1YZE9y8cEToFfIg3Za8rL/RGgA
 j3v/pnua/zlEcn5/4lCagn878lecK3BRAzhXaVj7Z8ps/b7/yXEQt28+alpfViymc0s0
 PNONIjlHDzB8aUolpLbXVAQc5pENDb4pqiCBbNOBJXGqEwACZjyau1NuYkF5JziLETs0
 Sqx4/3A2wei2wyRPm+nQH+VCvOfbIMCPpxgbBxLXew3+M/WAtc0jgqOCB0KCg/mwh9YT
 1lbX6z6dK5BRdzZhg0Qvtn/dboq+5EPQgWVweIS/z4bZb+JPvpNMViNwYUGRFSsuQPbQ +A== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 373rn80aky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 12:08:56 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 125H8sWd009823;
        Fri, 5 Mar 2021 17:08:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 371a8esweb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 17:08:54 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 125H8p6218284808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 17:08:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B59DA4055;
        Fri,  5 Mar 2021 17:08:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE532A4057;
        Fri,  5 Mar 2021 17:08:50 +0000 (GMT)
Received: from vm.lan (unknown [9.145.31.74])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Mar 2021 17:08:50 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/2] selftests/bpf: Add clang-based BTF_KIND_FLOAT tests
Date:   Fri,  5 Mar 2021 18:08:42 +0100
Message-Id: <20210305170844.151594-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_10:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=899 bulkscore=0 adultscore=0 mlxscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103050086
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The two tests here did not make it into the main BTF_KIND_FLOAT series
because of dependency on LLVM.

Ilya Leoshkevich (2):
  selftests/bpf: Add BTF_KIND_FLOAT to test_core_reloc_size
  selftests/bpf: Add BTF_KIND_FLOAT to btf_dump_test_case_syntax

 tools/testing/selftests/bpf/README.rst                   | 9 +++++++++
 tools/testing/selftests/bpf/prog_tests/core_reloc.c      | 1 +
 .../selftests/bpf/progs/btf_dump_test_case_syntax.c      | 7 +++++++
 tools/testing/selftests/bpf/progs/core_reloc_types.h     | 5 +++++
 tools/testing/selftests/bpf/progs/test_core_reloc_size.c | 3 +++
 5 files changed, 25 insertions(+)

-- 
2.29.2

