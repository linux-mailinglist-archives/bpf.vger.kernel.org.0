Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3884709E0
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 20:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbhLJTN0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 14:13:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63236 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242008AbhLJTN0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 14:13:26 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJ3S7X026814
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 11:09:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=RbL6uCp3+hvdcWemezugNnqF7HKEUHjA0KTDsL5i+iM=;
 b=SL6yhsDndHTFkwFxQeXCfXoAaIkZjJytboAG/WjqaoUzwluKm0f4MwgDenX6EPg6ujIm
 GbLCdaEhbNQ9+lE9BtPl8nTDzR6jAE892+vbBuv2h58ID5aDKmvfj6xBwra+adjgIH/0
 LOqsmkEuXDEEmxYSlNyGd5l26VScml23XS4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cvcqd022g-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 11:09:50 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 11:09:47 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 5FA2AF0FC16; Fri, 10 Dec 2021 11:09:41 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <ast@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 0/4] Stop using bpf_object__find_program_by_title API
Date:   Fri, 10 Dec 2021 11:08:52 -0800
Message-ID: <20211210190855.1369060-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: Lkf_bhf63YiZw0Xf2Wx117DQhpOl5nD4
X-Proofpoint-GUID: Lkf_bhf63YiZw0Xf2Wx117DQhpOl5nD4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_07,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1011
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=973 lowpriorityscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_object__find_program_by_title is going to be deprecated since
v0.7.  Replace all use cases with bpf_object__find_program_by_name if
possible, or use bpf_object__for_each_program to iterate over
programs, matching section names.

Kui-Feng Lee (4):
  selftests/bpf: Stop using bpf_object__find_program_by_title API.
  samples/bpf: Stop using bpf_object__find_program_by_title API.
  tools/perf: Stop using bpf_object__find_program_by_title API.
  libbpf: Mark bpf_object__find_program_by_title API deprecated.

 samples/bpf/hbm.c                             | 11 ++-
 samples/bpf/xdp_fwd_user.c                    | 12 ++-
 tools/lib/bpf/libbpf.h                        |  1 +
 tools/perf/builtin-trace.c                    | 14 +++-
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
 14 files changed, 146 insertions(+), 92 deletions(-)

--=20
2.30.2

