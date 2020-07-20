Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13864226A79
	for <lists+bpf@lfdr.de>; Mon, 20 Jul 2020 18:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbgGTQeb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 12:34:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4498 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732409AbgGTQeK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Jul 2020 12:34:10 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06KGY1K5019021
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 09:34:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=EKZSq/FWXhIpBvARM8Zuf2rlL8PzauCxwyQbY4Xpk8E=;
 b=f7EVMTaJXXXDD0wP9Bwr0moZ6TySzP5/glYklwEdEaVVCocq26zW0E4gwHJnVC+ftkhT
 oGOjbQmX91ONzMWLBhpR5AV9HtO3MZcBI3hV8XCP9z1hQHyXNisnnemeufaTPrh0NaBK
 YJF9pQBNp6NQMcF+3YJJtsrZDQxBuk+VkII= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32bxwfqfy3-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 09:34:09 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 20 Jul 2020 09:34:01 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 3D980370209A; Mon, 20 Jul 2020 09:33:58 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 0/5] bpf: compute btf_ids at build time for btf_iter
Date:   Mon, 20 Jul 2020 09:33:58 -0700
Message-ID: <20200720163358.1392964-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_09:2020-07-20,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=914 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200111
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 5a2798ab32ba
("bpf: Add BTF_ID_LIST/BTF_ID/BTF_ID_UNUSED macros")
implemented a mechanism to compute btf_ids at kernel build
time which can simplify kernel implementation and reduce
runtime overhead by removing in-kernel btf_id calculation.

This patch set tried to use this mechanism to compute
btf_ids for bpf_skc_to_*() helpers and for btf_id_or_null ctx
arguments specified during bpf iterator registration.
Please see individual patch for details.

Changelogs:
  v1 -> v2:
    - v1 ([1]) is only for bpf_skc_to_*() helpers. This version
      expanded it to cover ctx btf_id_or_null arguments
    - abandoned the change of "extern u32 name[]" to
      "static u32 name[]" for BPF_ID_LIST local "name" definition.
      gcc 9 incurred a compilation error.

 [1]: https://lore.kernel.org/bpf/20200717184706.3476992-1-yhs@fb.com/T

Yonghong Song (5):
  bpf: compute bpf_skc_to_*() helper socket btf ids at build time
  tools/bpf: sync btf_ids.h to tools
  bpf: add BTF_ID_LIST_GLOBAL in btf_ids.h
  bpf: make btf_sock_ids global
  bpf: net: use precomputed btf_id for bpf iterators

 include/linux/bpf.h                           |  5 +-
 include/linux/btf_ids.h                       | 40 +++++++++++++--
 kernel/bpf/btf.c                              |  6 +--
 kernel/bpf/map_iter.c                         |  7 ++-
 kernel/bpf/task_iter.c                        | 12 ++++-
 net/core/filter.c                             | 49 ++----------------
 net/ipv4/tcp_ipv4.c                           |  4 +-
 net/ipv4/udp.c                                |  4 +-
 net/ipv6/route.c                              |  7 ++-
 net/netlink/af_netlink.c                      |  7 ++-
 tools/include/linux/btf_ids.h                 | 51 +++++++++++++++++--
 .../selftests/bpf/prog_tests/resolve_btfids.c | 34 ++++++++++---
 12 files changed, 153 insertions(+), 73 deletions(-)

--=20
2.24.1

