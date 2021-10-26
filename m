Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED9443A992
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 03:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbhJZBLR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 21:11:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236038AbhJZBLP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 21:11:15 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PLVr9o007203;
        Tue, 26 Oct 2021 01:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=YIkbn9kOA9DKdfabnoGi93tZy/uNUscPQTMk5USTEM8=;
 b=HdHmMkuMFHpoj4qrlGwvDZRgx5E8hWmOct+LRJ62z4L9SsBaffA9v5t2HG0spa7NAYMG
 SEg5oZuI4RJTpznYl7HNmYU40qWViDgJKJCZva+dshK4ryR9YgBCtVNtjm8QVArHfBhI
 shO4gHh53+jHC+JfCPFg+LKJIv+rQjdUIofFZy4CHjK/b6IdvCWB3lUjs/v5E0hWmUk7
 5o5mlHnEVob9UUjbPLvNM8rRv5k9CgBOpK6DMd2CG3eJLeW51x6RRLQZ16JOwMTyeZ3E
 eNWXwUpcWz8/qBObnLLz2u9tzB2oPDtFqFAuh8rxEbWbAzitZRVy+tr2jXzjS9f7aOAy YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k23wuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:38 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19Q10EDV007123;
        Tue, 26 Oct 2021 01:08:38 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bx4k23wtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19Q13b3O017579;
        Tue, 26 Oct 2021 01:08:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3bx4edgtb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 01:08:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19Q12SJe50397622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Oct 2021 01:02:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DF844203F;
        Tue, 26 Oct 2021 01:08:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFBFF4204D;
        Tue, 26 Oct 2021 01:08:31 +0000 (GMT)
Received: from vm.lan (unknown [9.145.12.156])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Oct 2021 01:08:31 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 0/6] core_reloc fixes for s390
Date:   Tue, 26 Oct 2021 03:08:25 +0200
Message-Id: <20211026010831.748682-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SRfaNuvifMCxpis0iZLGdInpaZJmjPyW
X-Proofpoint-ORIG-GUID: uqqBThCZMYcBB7PtjEP8UjRTw9tj9JdD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260004
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v2: https://lore.kernel.org/bpf/20211025131214.731972-1-iii@linux.ibm.com/
v2 -> v3: Split the fix from the cleanup (Daniel).

v1: https://lore.kernel.org/bpf/20211021234653.643302-1-iii@linux.ibm.com/
v1 -> v2: Drop bpf_core_calc_field_relo() restructuring, split the
          __BYTE_ORDER__ change (Andrii).

Hi,

this series fixes test failures in core_reloc on s390.

Patch 1 fixes an endianness bug with __BYTE_ORDER vs __BYTE_ORDER__.
Patches 2-5 make the rest of the code consistent in that respect.
Patch 6 fixes an endianness issue in test_core_reloc_mods.

Best regards,
Ilya

Ilya Leoshkevich (6):
  libbpf: Fix endianness detection in BPF_CORE_READ_BITFIELD_PROBED()
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

