Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A34F3EF0BF
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 19:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhHQRUg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 13:20:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14550 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229723AbhHQRUg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 13:20:36 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HHFjju022965
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 10:20:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=//mf/y2Xxar2k4mvur8EuItzzFRmBR1x8w6npnT/meE=;
 b=KBaZSr8bAV8ix3CBEvHJV5wYGJd95p6gtyBZdsqr0Ekst0BrFn2AJi4KytDe3RzLY/ad
 VcIqZwbCIZeF2oz+yqVXJ5n+70bnar+KnKgciEve91HCoFEisIW+/CuKdZdONv2iqlD0
 DddkzFHkvzzaW8S5t7VI0s6VItKLW5tX4is= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aftmjqxnp-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 10:20:02 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 10:20:00 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id BBA666063B78; Tue, 17 Aug 2021 10:19:58 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/2] selftests/bpf: fix flaky send_signal test
Date:   Tue, 17 Aug 2021 10:19:58 -0700
Message-ID: <20210817171958.2769074-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: cL6uFgj_HBzyIVYJvWuWwJzSUY7Q4Cs_
X-Proofpoint-GUID: cL6uFgj_HBzyIVYJvWuWwJzSUY7Q4Cs_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_06:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 mlxlogscore=646 mlxscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108170108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf selftest send_signal() is flaky for its subtests trying to
send signals in softirq/nmi context. To reduce flakiness, the
signal-targetted process priority is boosted, which should minimize
preemption of that process and improve the possibility that
the underlying task in softirq/nmi context is the bpf_send_signal()
wanted task.

Patch #1 did a refactoring to use ASSERT_* instead of old CHECK macros.
Patch #2 did actual change of boosting priority.

Yonghong Song (2):
  selftests/bpf: replace CHECK with ASSERT_* macros in send_signal.c
  selftests/bpf: fix flaky send_signal test

 .../selftests/bpf/prog_tests/send_signal.c    | 68 ++++++++++++-------
 .../bpf/progs/test_send_signal_kern.c         |  3 +-
 2 files changed, 43 insertions(+), 28 deletions(-)

--=20
2.30.2

