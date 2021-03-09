Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49294331BF6
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 01:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhCIA5J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 19:57:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20336 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229730AbhCIA5I (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Mar 2021 19:57:08 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1290XPej118841;
        Mon, 8 Mar 2021 19:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=QDKfWgbZimMx1NFqaWxdW8Cg+yDTBScPlFvKPdYzuz8=;
 b=nvX8gehLAbQtwvF62wamWxlh7S9fyb4GOWBtRYm1wVEdMywXwSupx/DgO498LWpcfTUn
 SotPnepI1XGdOAa42QkQw9qJBfeR0wt3H9pzGy9v89dx3Zaa6Gh+AQGX/09KDff0m9ps
 2A5Hc3IkXq7g9Mcm2UwTAk8TzCN8vmzn06mYhxsYn+Ll3BzqMJ67CASvO2OZS9fa0lly
 sWPztmvIQdmUO1nM6kWty14D/j9Nn721V9/ntKSz9ZHsbQdbrkIELEepcTrxELEwTWKX
 g4RDMsUwg6oFrd/a70mcfdCh2GuQUydzSU7Z1Q7Hn7+vzeIp+OSmXjskJBew2BPvhTrN 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375wckst8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 19:56:55 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1290XU9Y119141;
        Mon, 8 Mar 2021 19:56:55 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 375wckst8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 19:56:55 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1290sShG016191;
        Tue, 9 Mar 2021 00:56:53 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3741c8169s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 00:56:53 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1290uZIm25231684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 00:56:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D703DAE051;
        Tue,  9 Mar 2021 00:56:50 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F540AE04D;
        Tue,  9 Mar 2021 00:56:50 +0000 (GMT)
Received: from vm.lan (unknown [9.145.31.74])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Mar 2021 00:56:50 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 bpf-next 0/2] Add clang-based BTF_KIND_FLOAT tests
Date:   Tue,  9 Mar 2021 01:56:47 +0100
Message-Id: <20210309005649.162480-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_22:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090000
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The two tests here did not make it into the main BTF_KIND_FLOAT series
because of dependency on LLVM.

v0: https://lore.kernel.org/bpf/20210226202256.116518-10-iii@linux.ibm.com/
v1 -> v0: Per Alexei's suggestion, document the required LLVM commit.

v1: https://lore.kernel.org/bpf/20210305170844.151594-1-iii@linux.ibm.com/
v1 -> v2: Per Andrii's suggestions, use double in
          core_reloc_size___diff_sz and non-pointer member in
          btf_dump_test_case_syntax.

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

