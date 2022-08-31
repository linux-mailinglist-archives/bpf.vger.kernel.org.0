Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295305A8536
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 20:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiHaSN4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiHaSN3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24141E9A90
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 11:12:08 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VHrw4e001115
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 11:11:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=sJft1uwMhrICHGesHFQX1fcoOlpj7x+v+T17ufjKYF0=;
 b=ZNqch0uccPuk7V8w8lSSja6d0iJAyW9Qn6PkjRvzE5zhcN8sqM0teacY4yzqHBtH/feP
 59CYh//wOL7OT4milIpIxDBdJj2q8fdU8/xMbslfSrrA6AyjEiSjWz7G1AeE2qIMVoeH
 L9CNEclmrrK3JgCoUucYBos3uFiYpuaRPoQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9qmh7enf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 11:11:10 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 11:11:09 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 4D5FB762CC29; Wed, 31 Aug 2022 11:10:56 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v10 0/5] Parameterize task iterators.
Date:   Wed, 31 Aug 2022 11:10:34 -0700
Message-ID: <20220831181039.2680134-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ldKks9O3-4bM5NPE9_jh2J-nV2wurSfd
X-Proofpoint-GUID: ldKks9O3-4bM5NPE9_jh2J-nV2wurSfd
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_10,2022-08-31_03,2022-06-22_01
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
resources of a specific task or process.  Passing the additional
parameters, people can now create an iterator to go through all
resources or only the resources of a task.

Major Changes:

 - Add new parameters in bpf_iter_link_info to indicate to go through
   all tasks or to go through a specific task.

 - Change the implementations of BPF iterators of vma, files, and
   tasks to allow going through only the resources of a specific task.

 - Provide the arguments of parameterized task iterators in
   bpf_link_info.

Differences from v9:

  - Fix the boundary check of computing page_shift.

  - Rewording the reason of checking and returning the same task.

Differences from v8:

 - Fix uninitialized variable.

 - Avoid redundant work of getting task from pid.

 - Change format string to use %u instead of %d.

 - Use the value of page_shift to compute correct offset in
   bpf_iter_vm_offset.c.

Differences from v7:

 - Travel the tasks of a process through task_group linked list
   instead of traveling through the whole namespace.

Differences from v6:

 - Add part 5 to make bpftool show the value of parameters.

 - Change of wording of show_fdinfo() to show pid or tid instead of
   always pid.

 - Simplify error handling and naming of test cases.

Differences from v5:

 - Use user-space tid/pid terminologies in bpf_iter_link_info and
   bpf_link_info.

 - Fix reference count

 - Merge all variants to one 'u32 pid' in internal structs.
   (bpf_iter_aux_info and bpf_iter_seq_task_common)

 - Compare the result of get_uprobe_offset() with the implementation
   with the vma iterators.

 - Implement show_fdinfo.

Differences from v4:

 - Remove 'type' from bpf_iter_link_info and bpf_link_info.

v9: https://lore.kernel.org/bpf/20220829192317.486946-1-kuifeng@fb.com/
v8: https://lore.kernel.org/bpf/20220829192317.486946-1-kuifeng@fb.com/
v7: https://lore.kernel.org/bpf/20220826003712.2810158-1-kuifeng@fb.com/
v6: https://lore.kernel.org/bpf/20220819220927.3409575-1-kuifeng@fb.com/
v5: https://lore.kernel.org/bpf/20220811001654.1316689-1-kuifeng@fb.com/
v4: https://lore.kernel.org/bpf/20220809195429.1043220-1-kuifeng@fb.com/
v3: https://lore.kernel.org/bpf/20220809063501.667610-1-kuifeng@fb.com/
v2: https://lore.kernel.org/bpf/20220801232649.2306614-1-kuifeng@fb.com/
v1: https://lore.kernel.org/bpf/20220726051713.840431-1-kuifeng@fb.com/

Kui-Feng Lee (5):
  bpf: Parameterize task iterators.
  bpf: Handle bpf_link_info for the parameterized task BPF iterators.
  bpf: Handle show_fdinfo for the parameterized task BPF iterators
  selftests/bpf: Test parameterized task BPF iterators.
  bpftool: Show parameters of BPF task iterators.

 include/linux/bpf.h                           |  25 ++
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/task_iter.c                        | 223 ++++++++++++--
 tools/bpf/bpftool/link.c                      |  19 ++
 tools/include/uapi/linux/bpf.h                |  10 +
 .../selftests/bpf/prog_tests/bpf_iter.c       | 282 ++++++++++++++++--
 .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
 .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
 .../selftests/bpf/progs/bpf_iter_task_file.c  |   9 +-
 .../selftests/bpf/progs/bpf_iter_task_vma.c   |   7 +-
 .../selftests/bpf/progs/bpf_iter_vma_offset.c |  37 +++
 11 files changed, 587 insertions(+), 46 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c

--=20
2.30.2

