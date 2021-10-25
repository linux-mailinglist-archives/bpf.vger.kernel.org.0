Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA3E439741
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhJYNO7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 09:14:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233371AbhJYNO6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 09:14:58 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PCM6rg028877;
        Mon, 25 Oct 2021 13:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=G0GWFK8CqDfBJlic01i4S1HzVZ6TV2at09DO1LpCong=;
 b=MTmQCsUNKC/Ta+dxqKkSE9oYRmKOK82mI9XLmwMr7BitNw+16wk+8sj9OWUTXkcOIvn6
 rLhGqD5KvqIg3poURN9qPlytmU1zZJHJiIThsmMG+kgsIWdPU+vBv5zo3zSaocEwc2Yh
 Ny0i9CRAP86jQJVB21zGwvgbtfjBH21PERB3npCaRpm0uTgL4CqV7e/Rckffhe97BfC6
 aDHqzO19cfBb0IlEEfsiWK71rHEAcFEBFY+tTF/FiG86KaWHs9KtgJ7q4uCw8OL3vj3x
 ZBAuFvUWps1x5931Av8ZsKsj1Q8+kKSt4CGTbOFRpWAP17IoWLWsm4l9NLctrIbrq3b0 +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bwt0twesd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:22 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19PCeaFj010637;
        Mon, 25 Oct 2021 13:12:22 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bwt0twerq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:22 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19PD8HXI000379;
        Mon, 25 Oct 2021 13:12:20 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3bva19pxnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 13:12:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19PD6D7g56492426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Oct 2021 13:06:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22490A406B;
        Mon, 25 Oct 2021 13:12:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C28F2A4069;
        Mon, 25 Oct 2021 13:12:15 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Oct 2021 13:12:15 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 0/5] core_reloc fixes for s390
Date:   Mon, 25 Oct 2021 15:12:09 +0200
Message-Id: <20211025131214.731972-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c3bI0yAhAkdwGh9e4trczTbTFo4QFJ-x
X-Proofpoint-GUID: Y1FmJQ9k5J0ddBz8m-TwdjKDOLsvond-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_05,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110250081
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v1: https://lore.kernel.org/bpf/20211021234653.643302-1-iii@linux.ibm.com/
v1 -> v2: Drop bpf_core_calc_field_relo() restructuring, split
          __BYTE_ORDER__ change.

Hi,

this series fixes test failures in core_reloc on s390.

Patches 1-4 replace __BYTE_ORDER with __BYTE_ORDER__ in order to fix an
endianness bug and make the code consistent.
Patch 5 fixes an endianness issue in test_core_reloc_mods.

Best regards,
Ilya

Ilya Leoshkevich (5):
  libbpf: Use __BYTE_ORDER__
  selftests/bpf: Use __BYTE_ORDER__
  samples: seccomp: use __BYTE_ORDER__
  selftests/seccomp: Use __BYTE_ORDER__
  selftests/bpf: Fix test_core_reloc_mods on big-endian machines

 samples/seccomp/bpf-helper.h                       |  8 ++++----
 tools/lib/bpf/bpf_core_read.h                      |  2 +-
 tools/lib/bpf/btf.c                                |  4 ++--
 tools/lib/bpf/btf_dump.c                           |  8 ++++----
 tools/lib/bpf/libbpf.c                             |  4 ++--
 tools/lib/bpf/linker.c                             | 12 ++++++------
 tools/lib/bpf/relo_core.c                          |  2 +-
 .../testing/selftests/bpf/prog_tests/btf_endian.c  |  6 +++---
 .../selftests/bpf/progs/test_core_reloc_mods.c     |  9 +++++++++
 tools/testing/selftests/bpf/test_sysctl.c          |  4 ++--
 tools/testing/selftests/bpf/verifier/ctx_skb.c     | 14 +++++++-------
 tools/testing/selftests/bpf/verifier/lwt.c         |  2 +-
 .../bpf/verifier/perf_event_sample_period.c        |  6 +++---
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  6 +++---
 14 files changed, 48 insertions(+), 39 deletions(-)

-- 
2.31.1

