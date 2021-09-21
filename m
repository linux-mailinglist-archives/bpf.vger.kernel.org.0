Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4809E412A4D
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 03:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhIUBeV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Sep 2021 21:34:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44408 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230004AbhIUBch (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Sep 2021 21:32:37 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KHwM2T022907
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 18:31:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=jdtw8UrJYV2HtZCpgxLgHLH69Mo1hMKYMmGwSY9hARk=;
 b=BMzr2/cLlOTjZibvMBftuL5y2k/oSfTTst3hjNCWk3jNr0jTBcekNl9jHY6O6KmMTXFY
 qRyNOhPNptDQedCZ3USDlSA9bQ8NFGAh46wEFeM5pE8SIz18LS0RthQc4ImtQIblOryK
 qgJw+pJvsAcB0JSOwjmRVIUF8C6/dUIYuMg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b6mkmx3rv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 18:31:09 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 18:31:07 -0700
Received: by devbig005.ftw2.facebook.com (Postfix, from userid 6611)
        id 636F52940D2A; Mon, 20 Sep 2021 18:31:02 -0700 (PDT)
From:   Martin KaFai Lau <kafai@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next 0/4] bpf: Support <8-byte scalar spill and refill
Date:   Mon, 20 Sep 2021 18:31:02 -0700
Message-ID: <20210921013102.1035356-1-kafai@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: FL0VidmxOgScdOBF9QSn1eDYL4k8TTAc
X-Proofpoint-ORIG-GUID: FL0VidmxOgScdOBF9QSn1eDYL4k8TTAc
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_11,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=445 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210006
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

Martin KaFai Lau (4):
  bpf: Check the other end of slot_type for STACK_SPILL
  bpf: Support <8-byte scalar spill and refill
  bpf: selftest: A bpf prog that has a 32bit scalar spill
  bpf: selftest: Add verifier tests for <8-byte scalar spill and refill

 kernel/bpf/verifier.c                         |  97 ++++--
 .../selftests/bpf/prog_tests/xdpwall.c        |  15 +
 tools/testing/selftests/bpf/progs/xdpwall.c   | 302 ++++++++++++++++++
 .../selftests/bpf/verifier/spill_fill.c       | 161 ++++++++++
 4 files changed, 549 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdpwall.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdpwall.c

--=20
2.30.2

