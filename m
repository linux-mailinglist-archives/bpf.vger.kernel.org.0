Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1D849435A
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 00:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiASW7v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 17:59:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31928 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234447AbiASW7u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 17:59:50 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JIs480030540
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 14:59:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=woJFWP2BybCDZWy7eS/TlZuNhf9jH0Z5wuBASOFElIs=;
 b=ZJe/6R0QbP8p8uI2bhiTVpvxjgP2x4wWkOOeRnno62C0/9R7FQoVkj2+j7xYJwEeI3ht
 AuAvo3ljA0td+fep5Xrus7mg9PRIL6rZYUQlNxmKwGK6KMLyP39lxOJxGg/XXFGS+DVG
 2ySm0tS6YCv/bpZRad0j15SAKI3DBGg0/DI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dp0x32ajd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 14:59:50 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 14:59:46 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 46C19945C57D; Wed, 19 Jan 2022 14:59:36 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <kennyyu@fb.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>, <phoenix1987@gmail.com>,
        <alexei.starovoitov@gmail.com>
Subject: [PATCH v4 bpf-next 0/3] Add bpf_access_process_vm helper and sleepable bpf iterator programs
Date:   Wed, 19 Jan 2022 14:59:26 -0800
Message-ID: <20220119225929.2312908-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113233158.1582743-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hFJR7Dked18d0ldtvam7cDBjhtDZ1syn
X-Proofpoint-GUID: hFJR7Dked18d0ldtvam7cDBjhtDZ1syn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=895 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201190122
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

