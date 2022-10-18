Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83F56022F1
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 05:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJRD5C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 17 Oct 2022 23:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJRD5B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 23:57:01 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC2518366
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 20:56:59 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I11ghs029062
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 20:56:58 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k9j409cax-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 20:56:58 -0700
Received: from twshared9384.24.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 20:56:57 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 41E7D2047200A; Mon, 17 Oct 2022 20:56:48 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 0/3] libbpf: support non-mmap()'able data sections
Date:   Mon, 17 Oct 2022 20:56:43 -0700
Message-ID: <20221018035646.1294873-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DYR8ks08YU7jRT5w37HqegL40RfFEa-e
X-Proofpoint-GUID: DYR8ks08YU7jRT5w37HqegL40RfFEa-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make libbpf more conservative in using BPF_F_MMAPABLE flag with internal BPF
array maps that are backing global data sections. See patch #2 for full
description and justification.

Changes in this dataset support having bpf_spinlock, kptr, rb_tree nodes and
other "special" variables as global variables. Combining this with libbpf's
existing support for multiple custom .data.* sections allows BPF programs to
utilize multiple spinlock/rbtree_node/kptr variables in a pretty natural way
by just putting all such variables into separate data sections (and thus ARRAY
maps).

Andrii Nakryiko (3):
  libbpf: clean up and refactor BTF fixup step
  libbpf: only add BPF_F_MMAPABLE flag for data maps with global vars
  libbpf: add non-mmapable data section selftest

 tools/lib/bpf/libbpf.c                        | 176 +++++++++++-------
 .../selftests/bpf/prog_tests/skeleton.c       |  11 +-
 .../selftests/bpf/progs/test_skeleton.c       |  17 ++
 3 files changed, 138 insertions(+), 66 deletions(-)

-- 
2.30.2

