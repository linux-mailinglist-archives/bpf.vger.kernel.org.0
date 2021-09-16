Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D6940D178
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 03:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhIPCAC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 15 Sep 2021 22:00:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62064 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhIPCAC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 22:00:02 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM3vvK015239
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:58:42 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3my2b1y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:58:42 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 18:58:41 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id F12FB422A268; Wed, 15 Sep 2021 18:58:38 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/7] Improve set_attach_target() and deprecate open_opts.attach_prog_fd
Date:   Wed, 15 Sep 2021 18:58:29 -0700
Message-ID: <20210916015836.1248906-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: vXiDAFJygxiI3rhozUnDAxdrUDJpgyDU
X-Proofpoint-ORIG-GUID: vXiDAFJygxiI3rhozUnDAxdrUDJpgyDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_07,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1034 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=731 bulkscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set deprecates bpf_object_open_opts.attach_prog_fd (in libbpf 0.7+)
by extending bpf_program__set_attach_target() to support some more flexible
scenarios. Existing fexit_bpf2bpf selftest is updated accordingly to not use
deprecated APIs.

While at it, also deprecate no-op relaxed_core_relocs option (they are always
"relaxed").

Last patch also const-ifies all high-level libbpf attach APIs, as there is no
reason for them to assume bpf_program/bpf_map modifications.

Patch #1 also removes one more unneeded use of find_sec_def(), relying on
prog->sec_def that's set during bpf_object__open() operation, simplifying
upcoming refactoring a little bit more.

All these changes are preparatory patches before SEC() handling refactoring
that will come next.

Andrii Nakryiko (7):
  libbpf: use pre-setup sec_def in libbpf_find_attach_btf_id()
  selftests/bpf: stop using relaxed_core_relocs which has no effect
  libbpf: deprecated bpf_object_open_opts.relaxed_core_relocs
  libbpf: allow skipping attach_func_name in
    bpf_program__set_attach_target()
  selftests/bpf: switch fexit_bpf2bpf selftest to set_attach_target()
    API
  libbpf: schedule open_opts.attach_prog_fd deprecation since v0.7
  libbpf: constify all high-level program attach APIs

 tools/lib/bpf/libbpf.c                        | 98 ++++++++++---------
 tools/lib/bpf/libbpf.h                        | 39 ++++----
 tools/lib/bpf/libbpf_common.h                 |  5 +
 .../selftests/bpf/prog_tests/core_reloc.c     |  3 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 43 ++++----
 5 files changed, 107 insertions(+), 81 deletions(-)

-- 
2.30.2

