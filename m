Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E112449533B
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 18:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiATRad (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 12:30:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5542 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229629AbiATR37 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 12:29:59 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K56QiL009285
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 09:29:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kvpimz4dEROyUn0fcqBgTbYEWCW5+uCMLjK1ULq+WlM=;
 b=mBF717QxaNSoSKrHuS5NLsLuKdGTPe7GnV2K5UGofLXJB/+m1I9y72DgQ+4M3edlk9r3
 WfbihUxeHlCyxQ+JuToh0gNs38m795Lu7Qe7H6JdgXCoje2He9K/ntLTrDsvtUFxkVX0
 VfwHQ/hmsLCgr67IU8zdkLnklQ0z4X3PLOM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dq1a3bqj2-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 09:29:58 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 09:29:57 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 7601494F45B2; Thu, 20 Jan 2022 09:29:51 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <kennyyu@fb.com>
CC:     <alexei.starovoitov@gmail.com>, <andrii@kernel.org>,
        <ast@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
        <phoenix1987@gmail.com>, <yhs@fb.com>
Subject: [PATCH v5 bpf-next 0/3] Add bpf_access_process_vm helper and sleepable bpf iterator programs
Date:   Thu, 20 Jan 2022 09:29:39 -0800
Message-ID: <20220120172942.246805-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113233158.1582743-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6biEe8hzJ_L9W7-6JXNsyLgH1_vKPhyR
X-Proofpoint-GUID: 6biEe8hzJ_L9W7-6JXNsyLgH1_vKPhyR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_06,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 mlxlogscore=907 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201200090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series makes the following changes:
* Adds a new bpf helper `bpf_access_process_vm` to read user space
  memory from a different task.
* Adds the ability to create sleepable bpf iterator programs.

As an example of how this will be used, at Meta we are using bpf task
iterator programs and this new bpf helper to read C++ async stack traces =
of
a running process for debugging C++ binaries in production.

Changes since v4:
* Make `flags` into u64.
* Use `user_ptr` arg name to be consistent with `bpf_copy_from_user`.
* Add an extra check in selftests to verify access_process_vm calls
  succeeded.

Changes since v3:
* Check if `flags` is 0 and return -EINVAL if not.
* Rebase on latest bpf-next branch and fix merge conflicts.

Changes since v2:
* Reorder arguments in `bpf_access_process_vm` to match existing related
  bpf helpers (e.g. `bpf_probe_read_kernel`, `bpf_probe_read_user`,
  `bpf_copy_from_user`).
* `flags` argument is provided for future extensibility and is not
  currently used, and we always invoke `access_process_vm` with no flags.
* Merge bpf helper patch and `bpf_iter_run_prog` patch together for bette=
r
  bisectability in case of failures.
* Clean up formatting and comments in selftests.

Changes since v1:
* Fixed "Invalid wait context" issue in `bpf_iter_run_prog` by using
  `rcu_read_lock_trace()` for sleepable bpf iterator programs.

Kenny Yu (3):
  bpf: Add bpf_access_process_vm() helper
  libbpf: Add "iter.s" section for sleepable bpf iterator programs
  selftests/bpf: Add test for sleepable bpf iterator programs

 include/linux/bpf.h                           |  1 +
 include/uapi/linux/bpf.h                      | 11 +++++
 kernel/bpf/bpf_iter.c                         | 20 ++++++---
 kernel/bpf/helpers.c                          | 23 ++++++++++
 kernel/trace/bpf_trace.c                      |  2 +
 tools/include/uapi/linux/bpf.h                | 11 +++++
 tools/lib/bpf/libbpf.c                        |  1 +
 .../selftests/bpf/prog_tests/bpf_iter.c       | 16 +++++++
 .../selftests/bpf/progs/bpf_iter_task.c       | 44 +++++++++++++++++++
 9 files changed, 124 insertions(+), 5 deletions(-)

--=20
2.30.2

