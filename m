Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1FC4A68A7
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 00:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242927AbiBAXmV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 18:42:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229921AbiBAXmV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 18:42:21 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211LwAwp010082;
        Tue, 1 Feb 2022 23:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=YhuuXR/mMMnXv1C62C7F07DUCSr7xpUk/pULf0oEdzI=;
 b=cxtowzz8OCxVa+s/6E5ZcgHeeCf9kBqNd3qGk2rOV0hEJkY/6s2gZxm85VBFvaKyI1GX
 sEW8OtVaYnMtDLwhtnk2gcGekqzhz1qIhMrJXsdsFigPhAOhucpLXFJKkBYCEqKWxfkN
 d0qcRQF8HNfBJKED/WWBpbU0d3jZQbTzE7mHkEJOJEQ40brPbzbN6lrj35BCdO35wMUJ
 YmK7OTupM1H2D3p5niQB+2q2uNnpkpZZFQ5ZYhuoWzN7VnKvd9QMC08NTb40RxVQE0r/
 mePzdlv6YHHe6r7Y11Jyaor6jijWc2OEsY7kOCYbsHD50W/jq2ERgUdmHXXnAVPk9aPN dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyd8ahfak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 23:42:08 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211Ng8st018845;
        Tue, 1 Feb 2022 23:42:08 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyd8ahfa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 23:42:08 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211NcuA4022556;
        Tue, 1 Feb 2022 23:42:06 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3dvw79rn62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 23:42:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211NWCo449676674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 23:32:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EA5C11C04A;
        Tue,  1 Feb 2022 23:42:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B34211C04C;
        Tue,  1 Feb 2022 23:42:02 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 23:42:02 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 0/3] libbpf: Fix accessing the first syscall argument on s390
Date:   Wed,  2 Feb 2022 00:41:57 +0100
Message-Id: <20220201234200.1836443-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aOefDmFthO0J-3rp12sL536D4qDvO_t6
X-Proofpoint-ORIG-GUID: K35qkGh08_dmwyOhbY6Eh6_uAkh9ZuUs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_10,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010130
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf CI reported a bpf_syscall_macro test failure on s390 [1], which
happens because the code uses gprs[2] instead of orig_gpr2 to access
the first syscall argument. Patches 1-2 are preparations, patch 3 fixes
the issue.

@Heiko, @Vasily, @Christian, @Alexander - could you please review
patch 1, which touches arch/s390? Would it be ok to put it into
bpf-next tree?

[1] https://github.com/libbpf/libbpf/runs/5025905587

Ilya Leoshkevich (3):
  s390/bpf: Add orig_gpr2 to user_pt_regs
  selftests/bpf: Fix an endianness issue in bpf_syscall_macro test
  libbpf: Fix accessing the first syscall argument on s390

 arch/s390/include/asm/ptrace.h                        | 2 +-
 arch/s390/include/uapi/asm/ptrace.h                   | 1 +
 tools/lib/bpf/bpf_tracing.h                           | 9 +++++++++
 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c | 5 ++++-
 4 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.34.1

