Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFB143462A
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 09:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJTHuq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 03:50:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42116 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhJTHup (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 03:50:45 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K5rq5E000953
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 00:48:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=WriUjlWvY77pUn6Pi+Z10LcGJVKXHNS/ZpEWB8ATRV4=;
 b=O2YcAa6ia1DTOXnYjz6EOmJ9IKwQmn87PMCgnwKAQNAdmrxba0X5cuYeJn8kYkH708V+
 2ZlvtgHAjC33uPxyEPyQtmHktR1R1TOpDXmQJFUofZvf6bhdUZzcFTWzl5Jlh2m76Gcm
 TZluI1utKspa7nkFzkEpSKczfQB3nH/HLIQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3btdc3gjev-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 00:48:31 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 20 Oct 2021 00:48:30 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id F334684FD513; Wed, 20 Oct 2021 00:48:27 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v3 bpf-next 0/2] bpf: keep track of verifier insn_processed
Date:   Wed, 20 Oct 2021 00:48:16 -0700
Message-ID: <20211020074818.1017682-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: xj4znOzYRdmYLWBAv5jiKIZ8UrtMFdW8
X-Proofpoint-ORIG-GUID: xj4znOzYRdmYLWBAv5jiKIZ8UrtMFdW8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=413 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200043
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a followup to discussion around RFC patchset "bpf: keep track of
prog verification stats" [0]. The RFC elaborates on my usecase, but to
summarize: keeping track of verifier stats for programs as they - and
the kernels they run on - change over time can help developers of
individual programs and BPF kernel folks.

The RFC added a verif_stats to the uapi which contained most of the info
which verifier prints currently. Feedback here was to avoid polluting
uapi with stats that might be meaningless after major changes to the
verifier, but that insn_processed or conceptually similar number would
exist in the long term and was safe to expose.

So let's expose just insn_processed via bpf_prog_info and fdinfo for now
and explore good ways of getting more complicated stats in the future.

[0] https://lore.kernel.org/bpf/20210920151112.3770991-1-davemarchevsky@fb.=
com/

v2->v3:
  * Remove unnecessary check in patch 2's test [Andrii]
  * Go back to adding new u32 in bpf_prog_info (vs using spare bits) [Andri=
i]
	* Rebase + add acks [Andrii, John]

v1->v2:
  * Rename uapi field from insn_processed to verified_insns [Daniel]
  * use 31 bits of existing bitfield space in bpf_prog_info [Daniel]
  * change underlying type from 64-> 32 bits [Daniel]

Dave Marchevsky (2):
  bpf: add verified_insns to bpf_prog_info and fdinfo
  selftests/bpf: add verif_stats test

 include/linux/bpf.h                           |  1 +
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/syscall.c                          |  8 ++++--
 kernel/bpf/verifier.c                         |  1 +
 tools/include/uapi/linux/bpf.h                |  1 +
 .../selftests/bpf/prog_tests/verif_stats.c    | 28 +++++++++++++++++++
 6 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verif_stats.c

--=20
2.30.2

