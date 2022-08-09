Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EDC58D3EB
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 08:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiHIGhe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 02:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiHIGhc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 02:37:32 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0133918B27
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 23:37:31 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2793L3aB029112
        for <bpf@vger.kernel.org>; Mon, 8 Aug 2022 23:37:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=HwFI3p9ALqi6n6jf0pEsTrT/HyZ3sbA990OA5BqNaI0=;
 b=OhkQ5eea6FYsGW5bjPsFtAFgWfr0BVtmOJNohYCwhvEALCrlUA1UDGcfPwOXtTAW9PeH
 rLSSuFzDOrrg7R1fnasu872MdiEuZSZlGV/yuno9zKO7DqBI2lACiHcy9HGaf5BkQ8Yw
 DzhRWvxd/VwvkWha0u9u4GkBkJcdmbwXZJM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hufk80pn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 23:37:31 -0700
Received: from twshared20276.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 23:37:29 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id F057C671675C; Mon,  8 Aug 2022 23:35:02 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v3 0/3] Parameterize task iterators.
Date:   Mon, 8 Aug 2022 23:34:58 -0700
Message-ID: <20220809063501.667610-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: o-iE0WA89w1MYzKdcpYPN1SOJAsQTVKh
X-Proofpoint-ORIG-GUID: o-iE0WA89w1MYzKdcpYPN1SOJAsQTVKh
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_03,2022-08-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow creating an iterator that loops through resources of one task/thread.

People could only create iterators to loop through all resources of
files, vma, and tasks in the system, even though they were interested in on=
ly the
resources of a specific task or process.  Passing the addintional
parameters, people can now create an iterator to go through all
resources or only the resources of a task.

Major Changes:

 - Add new parameters in bpf_iter_link_info to indicate to go through
   all tasks or to go through a specific task.

 - Change the implementations of BPF iterators of vma, files, and
   tasks to allow going through only the resources of a specific task.

 - Provide the arguments of parameterized task iterators in
   bpf_link_info.

Differences from v2:

 - Supports tid, tgid, and pidfd.

 - Change 'type' from __u8 to enum bpf_task_iter_type.

v2: https://lore.kernel.org/bpf/20220801232649.2306614-1-kuifeng@fb.com/
v1: https://lore.kernel.org/bpf/20220726051713.840431-1-kuifeng@fb.com/

Kui-Feng Lee (3):
  bpf: Parameterize task iterators.
  bpf: Handle bpf_link_info for the parameterized task BPF iterators.
  selftests/bpf: Test parameterized task BPF iterators.

 include/linux/bpf.h                           |   8 +
 include/uapi/linux/bpf.h                      |  43 +++
 kernel/bpf/task_iter.c                        | 153 +++++++++--
 tools/include/uapi/linux/bpf.h                |  43 +++
 .../selftests/bpf/prog_tests/bpf_iter.c       | 251 ++++++++++++++++--
 .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
 .../selftests/bpf/progs/bpf_iter_task_file.c  |   7 +
 .../selftests/bpf/progs/bpf_iter_task_vma.c   |   6 +-
 9 files changed, 474 insertions(+), 48 deletions(-)

--=20
2.30.2

