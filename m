Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A188159A829
	for <lists+bpf@lfdr.de>; Sat, 20 Aug 2022 00:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiHSWJn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 18:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiHSWJn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 18:09:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF217EFEC
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 15:09:41 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27JIPKJC006352
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 15:09:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=ea4HhKxzskjjYH6tqg6oqWWSv9wXvJ6Sty2JTnTxo1Y=;
 b=dgAVk6KoDbfnb9AVAhj0Lmdb+M0jEF0LHUhCj2/KQ6bixXQ/+UXkuUZHcV6GC501/8kj
 LHCeejRpJ+/4Q04qUCnue8EdB1V7LRhxb4QRPhydSN0y+WlZ94zjQGKd7qBME0T9keUH
 EZSMaVSEb0SBlIUkBgI3qqzPsipclyw5xt0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j1p0s4pa7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 15:09:41 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 15:09:39 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 34B346DDB7F8; Fri, 19 Aug 2022 15:09:29 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v6 0/4] Parameterize task iterators.
Date:   Fri, 19 Aug 2022 15:09:23 -0700
Message-ID: <20220819220927.3409575-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: U2e2obMsezIYIl_jGk9ZzKk6YpxPqjC9
X-Proofpoint-GUID: U2e2obMsezIYIl_jGk9ZzKk6YpxPqjC9
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_12,2022-08-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Differences from v5:

 - Use user-speace tid/pid terminologies in bpf_iter_link_info *** BLURB HE=
RE ***
   bpf_link_info.

 - Fix reference count

 - Merge all variants to one 'u32 pid' in internal structs.
   (bpf_iter_aux_info and bpf_iter_seq_task_common)

 - Compare the result of get_uprobe_offset() with the implementation
   with the vma iterators.

 - Implement show_fdinfo.

Differences from v4:

 - Remove 'type' from bpf_iter_link_info and bpf_link_info.

v5: https://lore.kernel.org/bpf/20220811001654.1316689-1-kuifeng@fb.com/
v4: https://lore.kernel.org/bpf/20220809195429.1043220-1-kuifeng@fb.com/
v3: https://lore.kernel.org/bpf/20220809063501.667610-1-kuifeng@fb.com/
v2: https://lore.kernel.org/bpf/20220801232649.2306614-1-kuifeng@fb.com/
v1: https://lore.kernel.org/bpf/20220726051713.840431-1-kuifeng@fb.com/

Kui-Feng Lee (4):
  bpf: Parameterize task iterators.
  bpf: Handle bpf_link_info for the parameterized task BPF iterators.
  bpf: Handle show_fdinfo for the parameterized task BPF iterators
  selftests/bpf: Test parameterized task BPF iterators.

 include/linux/bpf.h                           |  25 ++
 include/uapi/linux/bpf.h                      |  12 +
 kernel/bpf/task_iter.c                        | 142 +++++++--
 tools/include/uapi/linux/bpf.h                |  12 +
 .../selftests/bpf/prog_tests/bpf_iter.c       | 284 +++++++++++++++++-
 .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
 .../selftests/bpf/progs/bpf_iter_task_file.c  |   9 +-
 .../selftests/bpf/progs/bpf_iter_task_vma.c   |   6 +-
 .../bpf/progs/bpf_iter_uprobe_offset.c        |  35 +++
 10 files changed, 493 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_uprobe_offse=
t.c

--=20
2.30.2

