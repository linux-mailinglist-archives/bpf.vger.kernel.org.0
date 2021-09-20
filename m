Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9417B41294F
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 01:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbhITXT5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 20 Sep 2021 19:19:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42698 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239559AbhITXR5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Sep 2021 19:17:57 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KHwP7h005194
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 16:16:30 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b6v27u3qp-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Sep 2021 16:16:29 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 16:16:26 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 00D6E487A9C5; Mon, 20 Sep 2021 16:16:23 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/4] libbpf: add legacy uprobe support
Date:   Mon, 20 Sep 2021 16:16:13 -0700
Message-ID: <20210920231617.3141867-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: joU6H4c50pcnSwJ_Alaf9o9zpA6F5V_N
X-Proofpoint-ORIG-GUID: joU6H4c50pcnSwJ_Alaf9o9zpA6F5V_N
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=838 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109200135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement libbpf support for attaching uprobes/uretprobes using legacy
tracefs interfaces. This is a logical complement to recently landed legacy
kprobe support ([0]). This patch refactors existing legacy kprobe code to be more
uniform with uprobe code as well, making the logic easier to compare and
follow.

This patch set also fixes two bugs recently found by Coverity in legacy kprobe
handling code, and thus subsumes previously submitted two patches ([1]):
original patch #1 is kept as is, while original patch #2 was dropped because
patch #3 of the current series refactors and fixes affected code.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20210912064844.3181742-1-rafaeldtinoco@gmail.com/
  [1] https://patchwork.kernel.org/project/netdevbpf/list/?series=549977&state=*

Andrii Nakryiko (4):
  libbpf: fix memory leak in legacy kprobe attach logic
  selftests/bpf: adopt attach_probe selftest to work on old kernels
  libbpf: refactor and simplify legacy kprobe code
  libbpf: add legacy uprobe attaching support

 tools/lib/bpf/libbpf.c                        | 297 +++++++++++++-----
 tools/lib/bpf/libbpf.h                        |   2 +-
 .../selftests/bpf/prog_tests/attach_probe.c   |  16 +-
 3 files changed, 228 insertions(+), 87 deletions(-)

-- 
2.30.2

