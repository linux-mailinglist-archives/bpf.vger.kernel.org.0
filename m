Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62271498986
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 19:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344619AbiAXS4z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 13:56:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41950 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344501AbiAXSyq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jan 2022 13:54:46 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20OHWI8k028383
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 10:54:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=TKaSsKRc8kH6FkRuTUn1634SC2q16OovJH46/78as18=;
 b=U4iiP45doLvl5DnBR7Rtl/RvM3aq6LwZMLT1i5WL+BcS7L00epv8k8KcoAmDBywlPM7L
 /lpA9O1AzvpO/zkxggCBTZDUevDqRTL0FhYBLL1YQT0C5Mfq/nTt386qdxY5Akr2wB+k
 xd4MJKPCvxCv4B+1EkRw2mfeGYdc9k4AQf0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dsjyx5180-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 10:54:44 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 10:54:43 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 8DF739816148; Mon, 24 Jan 2022 10:54:35 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <kennyyu@fb.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>,
        <alexei.starovoitov@gmail.com>, <andrii.nakryiko@gmail.com>,
        <phoenix1987@gmail.com>
Subject: [PATCH v7 bpf-next 0/4] Add bpf_copy_from_user_task helper and sleepable bpf iterator programs
Date:   Mon, 24 Jan 2022 10:53:59 -0800
Message-ID: <20220124185403.468466-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113233158.1582743-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 94ieWxuINqsDAKQXbOMolUdDxxiKr2P4
X-Proofpoint-ORIG-GUID: 94ieWxuINqsDAKQXbOMolUdDxxiKr2P4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_09,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201240124
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

Changes since v6:
* Split first patch into two patches: first patch to add support
  for bpf iterators to use sleepable helpers, and the second to add
  the new bpf helper.
* Simplify implementation of `bpf_copy_from_user_task` based on feedback.
* Add to docs that the destination buffer will be zero-ed on error.

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

Kenny Yu (4):
  bpf: Add support for bpf iterator programs to use sleepable helpers
  bpf: Add bpf_copy_from_user_task() helper
  libbpf: Add "iter.s" section for sleepable bpf iterator programs
  selftests/bpf: Add test for sleepable bpf iterator programs

 include/linux/bpf.h                           |  1 +
 include/uapi/linux/bpf.h                      | 11 ++++
 kernel/bpf/bpf_iter.c                         | 20 +++++--
 kernel/bpf/helpers.c                          | 34 ++++++++++++
 kernel/trace/bpf_trace.c                      |  2 +
 tools/include/uapi/linux/bpf.h                | 11 ++++
 tools/lib/bpf/libbpf.c                        |  1 +
 .../selftests/bpf/prog_tests/bpf_iter.c       | 20 +++++++
 .../selftests/bpf/progs/bpf_iter_task.c       | 54 +++++++++++++++++++
 9 files changed, 149 insertions(+), 5 deletions(-)

--=20
2.30.2

