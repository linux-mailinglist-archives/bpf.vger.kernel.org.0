Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E72142C5E2
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 18:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhJMQLg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 12:11:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229514AbhJMQLf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Oct 2021 12:11:35 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DFxbtr031120;
        Wed, 13 Oct 2021 12:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=i6ddwjdwwDS+Fu4rGKlkoiTT64MOZn2URSdSy0CkfsU=;
 b=JmokuKMlQFv6hN5cJrVUZC9Z48kvyHgwbBqHQ7TsvGsm82JDFpamRPIPbr5OKllhR71+
 ZJt3yfijqa+ealmbVJTIlXzEVuxWKe9B/ylOUD7ZX/MQMoeam6kLtz3XMQDieiLaFtmU
 4sukO3W+3R87qQcFmlHa0qBa7PiZ+cTfGxPo64IdNjczdYRq0o1tmA6Zq0PqX1cfm+vd
 mBnIQCC6GEbeiAK1jgFaD7cvdpAcx2OFA1ugj9yF1Jsdne1vfXnH88xYnqy05RVhZuRd
 eXS7XZevmcNxpH0LRArK9aBGXovudxTRlcwLK/YCu2CeHtOXc7rQe8eGwr8z46I74cKJ DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnrncxdu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 12:09:17 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19DFSMOx006011;
        Wed, 13 Oct 2021 12:09:17 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnrncxdt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 12:09:17 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DG7XU8021046;
        Wed, 13 Oct 2021 16:09:15 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3bk2qacgb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 16:09:14 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DG94vn50594180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 16:09:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69F33AE063;
        Wed, 13 Oct 2021 16:09:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F2ABAE05A;
        Wed, 13 Oct 2021 16:09:04 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Oct 2021 16:09:03 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 0/4] btf_dump fixes for s390
Date:   Wed, 13 Oct 2021 18:08:58 +0200
Message-Id: <20211013160902.428340-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SrW0Jan83HSPRWc69pt73G7ctF60oxYd
X-Proofpoint-ORIG-GUID: pUg130uVhT5tnHL76xcuMm1jm_mO_2Hx
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_06,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130102
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v1: https://lore.kernel.org/bpf/20211012023218.399568-1-iii@linux.ibm.com/
v1 -> v2:
- Remove redundant local variables, use t->size directly instead.
- Add btf__align_of() patch.
Pending questions:
- Can things like defined(__i386__) break cross-compilation?
- Why exactly do we need both cpu_number and cpu_profile_flip? If we do,
  is there a suitable replacement for cpu_number in common code?

---

Hi,

This series along with [1] and [2] fixes all the failures in the
btf_dump testsuite currently present on s390, in particular:

* [1] fixes intermittent build bug causing "failed to encode tag ..."
  * error messages.
* [2] fixes missing VAR entries on s390.
* Patch 1 disables Intel-specific code in a testcase.
* Patch 2 fixes an endianness-related bug.
* Patch 3 fixes an alignment-related bug.
* Patch 4 improves overly pessimistic alignment handling.

[1] https://lore.kernel.org/bpf/20211012022521.399302-1-iii@linux.ibm.com/
[2] https://lore.kernel.org/bpf/20211012022637.399365-1-iii@linux.ibm.com/

Best regards,
Ilya

Ilya Leoshkevich (4):
  selftests/bpf: Use cpu_number only on arches that have it
  libbpf: Fix dumping big-endian bitfields
  libbpf: Fix dumping non-aligned __int128
  libbpf: Fix ptr_is_aligned() usages

 tools/lib/bpf/btf_dump.c                      | 34 +++++++++----------
 .../selftests/bpf/prog_tests/btf_dump.c       |  2 ++
 2 files changed, 19 insertions(+), 17 deletions(-)

-- 
2.31.1

