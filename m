Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4796D49D4B2
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 22:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiAZVs1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 16:48:27 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36836 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230126AbiAZVs1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jan 2022 16:48:27 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20QL20nx014024
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 13:48:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=kPNaNh4RdcGN4RXq0ujINbxbPqIHOPmoavJGCQUZkrk=;
 b=LrbQ6ght/1QaOYjO3PRQkG0njgycMBBc6Rll3pJ/81v37Vq8KLBjxfSHbZfYCJh5WKQT
 L+ucgHUCKkSl8p9R4Q6WjXeUwCq6ImuGAu9K+YAF26/1pVvNeqkDqotniEKOMoLoqq5c
 71KUiiVExYboS4ZF8JpKvDqdjc7J1koy7pk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dtvbex1db-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 13:48:26 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 13:48:24 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 234C42C9AA2A; Wed, 26 Jan 2022 13:48:16 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 0/5] Attach a cookie to a tracing program.
Date:   Wed, 26 Jan 2022 13:48:04 -0800
Message-ID: <20220126214809.3868787-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: eCa5YwLe4pyLlbgGZgrBTwE1tEJZT1Dg
X-Proofpoint-ORIG-GUID: eCa5YwLe4pyLlbgGZgrBTwE1tEJZT1Dg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_08,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=793 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201260126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow users to attach a 64-bits cookie to a BPF program when link it
to fentry, fexit, or fmod_ret of a function.

This changeset includes several major changes.

 - Add a new field bpf_cookie to struct raw_tracepoint, so that a user
   can attach a cookie to a program.

 - Store flags in trampoline frames to provide the flexibility of
   storing more values in these frames.

 - Store the program ID of the current BPF program in the trampoline
   frame.

 - The implmentation of bpf_get_attach_cookie() for tracing programs
   to read the attached cookie.

Kui-Feng Lee (5):
  bpf: Add a flags value on trampoline frames.
  bpf: Detect if a program needs its program ID.
  bpf, x86: Store program ID to trampoline frames.
  bpf: Attach a cookie to a BPF program.
  bpf: Implement bpf_get_attach_cookie() for tracing programs.

 arch/x86/net/bpf_jit_comp.c                   | 53 ++++++++++++++---
 include/linux/bpf.h                           |  3 +
 include/linux/filter.h                        |  3 +-
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/syscall.c                          | 12 ++--
 kernel/bpf/trampoline.c                       | 10 +++-
 kernel/bpf/verifier.c                         |  5 +-
 kernel/trace/bpf_trace.c                      | 45 ++++++++++++++-
 tools/include/uapi/linux/bpf.h                |  1 +
 tools/lib/bpf/bpf.c                           | 14 +++++
 tools/lib/bpf/bpf.h                           |  1 +
 tools/lib/bpf/libbpf.map                      |  1 +
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 57 +++++++++++++++++++
 .../selftests/bpf/progs/test_bpf_cookie.c     | 24 ++++++++
 14 files changed, 211 insertions(+), 19 deletions(-)

--=20
2.30.2

