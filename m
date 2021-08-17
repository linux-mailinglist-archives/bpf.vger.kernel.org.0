Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524BD3EF5CC
	for <lists+bpf@lfdr.de>; Wed, 18 Aug 2021 00:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhHQWnB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 18:43:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229466AbhHQWnB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 18:43:01 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17HMc5wL010921
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 15:42:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Yk3fhVXJMnB6KT0oUGlgWXNU3RX7hPZ7HMCDBqId7iI=;
 b=QXPGiy/C3VE82QtsD337Vs1rQDn4CKXmKcQw65KTylVdXihF/l73xQTBo/84NbY6yvfl
 C6FfTN7XK82z3IVxp847zRAdOY/9a5+DGapE1BwYjc+Dz9cnN1JF03p/kMpKxsjhIDae
 Q+3op8gTeeqDBMSAKBah4y39GzE8F9D90zk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3aftpf1v1x-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 15:42:27 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 15:42:24 -0700
Received: by devbig577.ftw3.facebook.com (Postfix, from userid 201728)
        id 174116E8CEEC; Tue, 17 Aug 2021 15:42:21 -0700 (PDT)
From:   Prankur gupta <prankgup@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, <prankur.07@gmail.com>
Subject: [PATCH v2 bpf-next 0/2] Add support for bpf_setsockopt and
Date:   Tue, 17 Aug 2021 15:42:19 -0700
Message-ID: <20210817224221.3257826-1-prankgup@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: pLttMyFtTtwxf1F6tKzByyQF6gchXG8u
X-Proofpoint-GUID: pLttMyFtTtwxf1F6tKzByyQF6gchXG8u
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_08:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

v2: Added details about the test in commit log

This patch contains support to set and get socket options from
setsockopt
bpf program.
This enables us to set multiple socket option when the user changes a
particular socket option.
Example use case, when the user sets the IPV6_TCLASS socket option we
would also like to change the tcp-cc for that socket. We don't have any
use case for calling bpf_setsockopt from supposedly read-only
sys_getsockopt, so it is made available to BPF_CGROUP_SETSOCKOPT only.

Prankur gupta (2):
  bpf: Add support for {set|get} socket options from setsockopt BPF
  selftests/bpf: Add test for {set|get} socket option from setsockopt
    BPF program

 kernel/bpf/cgroup.c                           |  8 +++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 18 +++++
 .../bpf/prog_tests/sockopt_qos_to_cc.c        | 70 +++++++++++++++++++
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   | 39 +++++++++++
 4 files changed, 135 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sockopt_qos_to=
_cc.c
 create mode 100644 tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c

--=20
2.30.2

