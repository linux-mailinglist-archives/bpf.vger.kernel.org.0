Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B4D43A6CC
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 00:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhJYWsF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Oct 2021 18:48:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18742 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234275AbhJYWsF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 18:48:05 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PMiY3Y028960
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:45:42 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bx4fm0g6m-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 15:45:42 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 15:45:41 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 21CC174E663D; Mon, 25 Oct 2021 15:45:33 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/4] libbpf: add bpf_program__insns() accessor
Date:   Mon, 25 Oct 2021 15:45:27 -0700
Message-ID: <20211025224531.1088894-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: sibbz1HIHiOoBNhcuzkpo8m2SwtFtNlc
X-Proofpoint-ORIG-GUID: sibbz1HIHiOoBNhcuzkpo8m2SwtFtNlc
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_07,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=632 malwarescore=0 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110250128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add libbpf APIs to access BPF program instructions. Both before and after
libbpf processing (before and after bpf_object__load()). This allows to
inspect what's going on with BPF program assembly instructions as libbpf
performs its processing magic.

But in more practical terms, this allows to do a no-brainer BPF program
cloning, which is something you need when working with fentry/fexit BPF
programs to be able to attach the same BPF program code to multiple kernel
functions. Currently, kernel needs multiple copies of BPF programs, each
loaded with its own target BTF ID. retsnoop is one such example that
previously had to rely on bpf_program__set_prep() API to hijack program
instructions ([0] for before and after).

Speaking of bpf_program__set_prep() API and the whole concept of
multiple-instance BPF programs in libbpf, all that is scheduled for
deprecation in v0.7. It doesn't work well, it's cumbersome, and it will become
more broken as libbpf adds more functionality. So deprecate and remove it in
libbpf 1.0. It doesn't seem to be used by anyone anyways (except for that
retsnoop hack, which is now much cleaner with new APIs as can be seen in [0]).

  [0] https://github.com/anakryiko/retsnoop/pull/1

Andrii Nakryiko (4):
  libbpf: fix off-by-one bug in bpf_core_apply_relo()
  libbpf: add ability to fetch bpf_program's underlying instructions
  libbpf: deprecate multi-instance bpf_program APIs
  libbpf: deprecate ambiguously-named bpf_program__size() API

 tools/lib/bpf/libbpf.c   | 36 ++++++++++++++++++++++-----------
 tools/lib/bpf/libbpf.h   | 43 +++++++++++++++++++++++++++++++++++++---
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 66 insertions(+), 15 deletions(-)

-- 
2.30.2

