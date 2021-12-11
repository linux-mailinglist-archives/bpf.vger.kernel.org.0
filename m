Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65992470F82
	for <lists+bpf@lfdr.de>; Sat, 11 Dec 2021 01:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244279AbhLKAjy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 19:39:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13082 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237517AbhLKAjy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 19:39:54 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAMKZNw028995
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 16:36:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=04EWUHyrieCpJ2+yRCBuJtm3ug+PhSiqMF0nd5DLYyM=;
 b=asDS5PjjZIy1++wcz6OrDAmXfgPGzUTDIm08JlVxPZVT+gdYSdIvq61ugw1FlTs7r5/j
 jfDjFGbBgh3eb4L/VvgDqr0M8nrUk4F6uHFJ3c7/x7OIAi1uewF5kSKhEAXHHgQBDAlk
 +Rc8QNz1v0gr/S3p9KSK75hPHR1YV5C6tgM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cvch2a0ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 16:36:18 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 16:36:17 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 6CA43F370DA; Fri, 10 Dec 2021 16:36:15 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <ast@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH v2 bpf-next 0/4] Stop using bpf_object__find_program_by_title API
Date:   Fri, 10 Dec 2021 16:36:04 -0800
Message-ID: <20211211003608.2764928-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: xqGy_8uaMVf6mSA9_zjkww6njWkHeG08
X-Proofpoint-ORIG-GUID: xqGy_8uaMVf6mSA9_zjkww6njWkHeG08
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_09,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112110001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_object__find_program_by_title is going to be deprecated since
v0.7.  Replace all use cases with bpf_object__find_program_by_name if
possible, or use bpf_object__for_each_program to iterate over
programs, matching section names.

V2 fixes a compiling issue at part 1 and simplifies part 3 to declare
multiple variables in one line. [v1]

[v1] https://lore.kernel.org/bpf/20211210190855.1369060-1-kuifeng@fb.com/T/

Kui-Feng Lee (4):
  selftests/bpf: Stop using bpf_object__find_program_by_title API.
  samples/bpf: Stop using bpf_object__find_program_by_title API.
  tools/perf: Stop using bpf_object__find_program_by_title API.
  libbpf: Mark bpf_object__find_program_by_title API deprecated.

 samples/bpf/hbm.c                             | 11 ++-
 samples/bpf/xdp_fwd_user.c                    | 12 ++-
 tools/lib/bpf/libbpf.h                        |  1 +
 tools/perf/builtin-trace.c                    | 13 ++-
 .../selftests/bpf/prog_tests/bpf_obj_id.c     |  4 +-
 .../bpf/prog_tests/connect_force_port.c       | 18 ++---
 .../selftests/bpf/prog_tests/core_reloc.c     | 79 +++++++++++++------
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 46 +++++------
 .../bpf/prog_tests/get_stack_raw_tp.c         |  4 +-
 .../bpf/prog_tests/sockopt_inherit.c          | 15 ++--
 .../selftests/bpf/prog_tests/stacktrace_map.c |  4 +-
 .../bpf/prog_tests/stacktrace_map_raw_tp.c    |  4 +-
 .../selftests/bpf/prog_tests/test_overhead.c  | 20 ++---
 .../bpf/prog_tests/trampoline_count.c         |  6 +-
 14 files changed, 145 insertions(+), 92 deletions(-)

--=20
2.30.2

