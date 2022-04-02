Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991E24EFDDD
	for <lists+bpf@lfdr.de>; Sat,  2 Apr 2022 03:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiDBCBn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Apr 2022 22:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiDBCBn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 22:01:43 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EDBDFDD8
        for <bpf@vger.kernel.org>; Fri,  1 Apr 2022 18:59:52 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2320C7iW031548
        for <bpf@vger.kernel.org>; Fri, 1 Apr 2022 18:59:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=facebook;
 bh=ro7ArStNOpOEEz06aMJmHOTBWolAbhO1NATXCWGbAfM=;
 b=AxQv6W50bIcjacZiaWATUjV6y9BM5Nk3QT49pIeR/BTBoRr2pJw6RO+46gWVvDsIrRZQ
 HInlB15DNQLuztynQT3nNXuZLvqk6t0BAziccFDiJIKbm1jGe8ndsdZkeuPRZmflXh9g
 VY68qjXCnCJUj3uADgWlhHj843OW/FVr5aA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f5gpgax9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 01 Apr 2022 18:59:51 -0700
Received: from twshared16483.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 18:59:50 -0700
Received: by devbig010.atn6.facebook.com (Postfix, from userid 115148)
        id 8C488A790673; Fri,  1 Apr 2022 18:59:43 -0700 (PDT)
From:   Joanne Koong <joannekoong@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH bpf-next v1 0/7] Dynamic pointers
Date:   Fri, 1 Apr 2022 18:58:19 -0700
Message-ID: <20220402015826.3941317-1-joannekoong@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: VkX7YFHFiJMAIUCSjoTu4PoU0HqpACvr
X-Proofpoint-GUID: VkX7YFHFiJMAIUCSjoTu4PoU0HqpACvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_08,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joanne Koong <joannelkoong@gmail.com>

This patchset implements the basics of dynamic pointers in bpf.

A dynamic pointer (struct bpf_dynptr) is a pointer that stores extra meta=
data
alongside the address it points to. This abstraction is useful in bpf, gi=
ven
that every memory access in a bpf program must be safe. The verifier and =
bpf
helper functions can use the metadata to enforce safety guarantees for th=
ings=20
such as dynamically sized strings and kernel heap allocations.

From the program side, the bpf_dynptr is an opaque struct and the verifie=
r
will enforce that its contents are never written to by the program.
It can only be written to through specific bpf helper functions.

There are several uses cases for dynamic pointers in bpf programs. A list=
 of
some are: dynamically sized ringbuf reservations without any extra memcpy=
s,
dynamic string parsing and memory comparisons, dynamic memory allocations=
 that
can be persisted in a map, and dynamic parsing of sk_buff and xdp_md pack=
et
data.

At a high-level, the patches are as follows:
1/7 - Adds MEM_UNINIT as a bpf_type_flag
2/7 - Adds MEM_RELEASE as a bpf_type_flag
3/7 - Adds bpf_dynptr_from_mem, bpf_malloc, and bpf_free
4/7 - Adds bpf_dynptr_read and bpf_dynptr_write
5/7 - Adds dynptr data slices (ptr to underlying dynptr memory)
6/7 - Adds dynptr support for ring buffers
7/7 - Tests to check that verifier rejects certain fail cases and passes
certain success cases

This is the first dynptr patchset in a larger series. The next series of
patches will add persisting dynamic memory allocations in maps, parsing p=
acket
data through dynptrs, dynptrs to referenced objects, convenience helpers =
for
using dynptrs as iterators, and more helper functions for interacting wit=
h
strings and memory dynamically.

Joanne Koong (7):
  bpf: Add MEM_UNINIT as a bpf_type_flag
  bpf: Add MEM_RELEASE as a bpf_type_flag
  bpf: Add bpf_dynptr_from_mem, bpf_malloc, bpf_free
  bpf: Add bpf_dynptr_read and bpf_dynptr_write
  bpf: Add dynptr data slices
  bpf: Dynptr support for ring buffers
  bpf: Dynptr tests

 include/linux/bpf.h                           | 107 +++-
 include/linux/bpf_verifier.h                  |  23 +-
 include/uapi/linux/bpf.h                      | 100 ++++
 kernel/bpf/bpf_lsm.c                          |   4 +-
 kernel/bpf/btf.c                              |   3 +-
 kernel/bpf/cgroup.c                           |   4 +-
 kernel/bpf/helpers.c                          | 190 ++++++-
 kernel/bpf/ringbuf.c                          |  75 ++-
 kernel/bpf/stackmap.c                         |   6 +-
 kernel/bpf/verifier.c                         | 406 ++++++++++++--
 kernel/trace/bpf_trace.c                      |  20 +-
 net/core/filter.c                             |  28 +-
 scripts/bpf_doc.py                            |   2 +
 tools/include/uapi/linux/bpf.h                | 100 ++++
 .../testing/selftests/bpf/prog_tests/dynptr.c | 303 ++++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 527 ++++++++++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 147 +++++
 17 files changed, 1955 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_success.c

--=20
2.30.2

