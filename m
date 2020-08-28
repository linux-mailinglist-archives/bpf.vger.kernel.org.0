Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B8A25540B
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 07:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgH1FiU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 01:38:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53028 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgH1FiU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 28 Aug 2020 01:38:20 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 07S5ZjiT030572
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 22:38:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=zhxx0x1QBZvF9GZ8DV23wHZ1bB8/D3r5LUVPZQivKKE=;
 b=N2WPJuIxvxiH4NAmORqaSRFjKlR8jBT+SqDWA5/EjJ0nxP/0DVgmSEv8e7ElgS4c/U1P
 /kVfoADaee1VY+mgjzcYnB5bBU2B2die3+xFiEn5U3gGS5oJuWiurnuTHlkQpdJAhp7b
 3QgBlaW0FBUNJQFKlT0052xId6ASkxPDmvk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 335up71be5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 22:38:18 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 27 Aug 2020 22:38:17 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id AB2FC370541B; Thu, 27 Aug 2020 22:38:15 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2 0/2] bpf: avoid iterating duplicated files for task_file iterator
Date:   Thu, 27 Aug 2020 22:38:15 -0700
Message-ID: <20200828053815.817726-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_03:2020-08-27,2020-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=8 clxscore=1015 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280046
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit e679654a704e ("bpf: Fix a rcu_sched stall issue with
bpf task/task_file iterator") introduced rate limiting in
bpf_seq_read() to fix a case where traversing too many tasks
and files (tens of millions of files) may cause kernel rcu stall.
But rate limiting won't reduce the amount of work to traverse
all these files.

In practice, for a user process, typically all threads belongs
to that process share the same file table and there is no need
to visit every thread for its files.

This patch added additional logic for task_file iterator to
skip tasks if those tasks are not group_leaders and their files
are the same as those of group_leaders.
Such reduction of unnecessary work will make iterator runtime
much faster if there are a lot of non-main threads and open
files for the process.

Patch #1 is the kernel implementation and Patch #2 is the
selftest.
  v1 -> v2:
    - for task_file, no need for additional user parameter,
      kernel can just skip those files already visited, and
      this should not impact user space. (Andrii)
    - to add group_leader-only customization for task will
      be considered later.
    - remove Patch #1 and sent it separately as this patch set
      won't depend on it any more.

Yonghong Song (2):
  bpf: avoid iterating duplicated files for task_file iterator
  selftests/bpf: test task_file iterator without visiting pthreads

 kernel/bpf/task_iter.c                        | 14 ++++++++-----
 .../selftests/bpf/prog_tests/bpf_iter.c       | 21 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_task_file.c  | 10 ++++++++-
 3 files changed, 39 insertions(+), 6 deletions(-)

--=20
2.24.1

