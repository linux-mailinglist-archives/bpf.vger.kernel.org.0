Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD7849659E
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 20:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiAUTbU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 14:31:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49896 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232207AbiAUTbU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 Jan 2022 14:31:20 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20LG0TGM010823
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:31:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=0ZWee4CpMfczMS9IhUmkTC8waRumepvZV2LZLK8KiKo=;
 b=bXuv1RnH6cXzACRhHi+tmfK1hbMr17AwvVkd7IiUv/h3++hpa/DEHNCpKcdSfkJ1eVSl
 ffkEqS6kfxiZmiGFAL5BMLErWqylYLsh0V8eFSDJSoVYFAoS/tRjJPShi1qc7FbXFRjG
 g6fHJ6xG2k+jZLoZF/ceOdcstMdk4B4/xug= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dqj0gnc7h-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 11:31:19 -0800
Received: from twshared22811.39.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 21 Jan 2022 11:31:17 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id AA84095CDA5B; Fri, 21 Jan 2022 11:31:00 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <kennyyu@fb.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>,
        <alexei.starovoitov@gmail.com>, <andrii.nakryiko@gmail.com>,
        <phoenix1987@gmail.com>
Subject: [PATCH v6 bpf-next 0/3] Add bpf_copy_from_user_task helper and sleepable bpf iterator programs
Date:   Fri, 21 Jan 2022 11:30:44 -0800
Message-ID: <20220121193047.3225019-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113233158.1582743-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: P7GC2boTe0ZAp2IzDtK7RCn4bCWJIWce
X-Proofpoint-GUID: P7GC2boTe0ZAp2IzDtK7RCn4bCWJIWce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_09,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=874 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210127
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series makes the following changes:
* Adds a new bpf helper `bpf_copy_from_user_task` to read user space
  memory from a different task.
* Adds the ability to create sleepable bpf iterator programs.

As an example of how this will be used, at Meta we are using bpf task
iterator programs and this new bpf helper to read C++ async stack traces =
of
a running process for debugging C++ binaries in production.

Changes since v5:
* Rename `bpf_access_process_vm` to `bpf_copy_from_user_task`.
* Change return value to be all-or-nothing. If we get a partial read,
  memset all bytes to 0 and return -EFAULT.
* Add to docs that the helper can only be used by sleepable BPF programs.
* Fix nits in selftests.

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
  bpf: Add bpf_copy_from_user_task() helper
  libbpf: Add "iter.s" section for sleepable bpf iterator programs
  selftests/bpf: Add test for sleepable bpf iterator programs

 include/linux/bpf.h                           |  1 +
 include/uapi/linux/bpf.h                      | 10 +++++
 kernel/bpf/bpf_iter.c                         | 20 ++++++---
 kernel/bpf/helpers.c                          | 31 +++++++++++++
 kernel/trace/bpf_trace.c                      |  2 +
 tools/include/uapi/linux/bpf.h                | 10 +++++
 tools/lib/bpf/libbpf.c                        |  1 +
 .../selftests/bpf/prog_tests/bpf_iter.c       | 18 ++++++++
 .../selftests/bpf/progs/bpf_iter_task.c       | 43 +++++++++++++++++++
 9 files changed, 131 insertions(+), 5 deletions(-)

--=20
2.30.2

