Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9D5413EB6
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 02:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhIVAvC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 20:51:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50498 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhIVAvB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 20:51:01 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLH2s1009291
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 17:49:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=XMUHHa/K7lioQtz84WDFJxJ/CgYLvKZCfbIuR5A8C48=;
 b=nS4TE3kuxnF60UOcYnqAvAER9Y3iQjeJ6Ppjjzp/bZNINcVIhfMeFMrGuBco0HhBT0GG
 V2XBMHBxD//0SRESuP184eXlS4kZ4qPAEZknkc/zWIZyb0QdGsvzLs+PK2wDfB0/7g2O
 SZW41QIq+g9Z55WRVWGm3e5kE+Ni+HHyQ3E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q62h5kr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 17:49:32 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 17:49:31 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 8C1E729416FF; Tue, 21 Sep 2021 17:49:28 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH v2 bpf-next 0/4] bpf: Support <8-byte scalar spill and refill
Date:   Tue, 21 Sep 2021 17:49:28 -0700
Message-ID: <20210922004928.622871-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: gINzBxb84mct6WW0G53o9PTrbkW4LG4w
X-Proofpoint-GUID: gINzBxb84mct6WW0G53o9PTrbkW4LG4w
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 mlxlogscore=540 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The verifier currently does not save the reg state when
spilling <8byte bounded scalar to the stack.  The bpf program
will be incorrectly rejected when this scalar is refilled to
the reg and then used to offset into a packet header.
The later patch has a simplified bpf prog from a real use case
to demonstrate this case.  The current work around is
to reparse the packet again such that this offset scalar
is close to where the packet data will be accessed to
avoid the spill.  Thus, the header is parsed twice.

The llvm patch [1] will align the <8bytes spill to
the 8-byte stack address.  This set is to make the necessary
changes in verifier to support <8byte scalar spill and refill.

[1] https://reviews.llvm.org/D109073

v2:
- Changed the xdpwall selftest in patch 3 to trigger a u32
  spill at a non 8-byte aligned stack address.  The v1 has
  simplified the real example too much such that it only
  triggers a u32 spill but does not spill at a non
  8-byte aligned stack address.
- Changed README.rst in patch 3 to explain the llvm dependency
  for the xdpwall test.

Martin KaFai Lau (4):
  bpf: Check the other end of slot_type for STACK_SPILL
  bpf: Support <8-byte scalar spill and refill
  bpf: selftest: A bpf prog that has a 32bit scalar spill
  bpf: selftest: Add verifier tests for <8-byte scalar spill and refill

 kernel/bpf/verifier.c                         |  97 +++--
 tools/testing/selftests/bpf/README.rst        |  13 +
 .../selftests/bpf/prog_tests/xdpwall.c        |  15 +
 tools/testing/selftests/bpf/progs/xdpwall.c   | 365 ++++++++++++++++++
 .../selftests/bpf/verifier/spill_fill.c       | 161 ++++++++
 5 files changed, 625 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdpwall.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdpwall.c

--=20
2.30.2

