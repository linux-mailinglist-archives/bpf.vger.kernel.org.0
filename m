Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B5A40FF5D
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 20:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbhIQSat (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 14:30:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7166 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240608AbhIQSaq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Sep 2021 14:30:46 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HFIoLj027203
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 11:29:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=01/nnzP53SB7U6sdJ+Ee5MQPiIUiOEy7ZwjelUlxwl0=;
 b=Rj4gboj1wXtvssmGy0UJzzhujNHvqlcTsiYSMWCJszVqI4YQ7W2jCI/uDIBBSrmHAHRj
 6XRFmAdSx8IH1ObjkcIm9zxXe3xQD2n+c0MyyYjTwCl1b1jHvh63rd3B/qXW75IVHKSx
 O2Ft0H/wqnQcqZWHlKNyOHVkEIys7HnJ9Q0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b47hfhp5p-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 11:29:21 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 17 Sep 2021 11:29:15 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 03EFE6BF31AC; Fri, 17 Sep 2021 11:29:11 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, <netdev@vger.kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v6 bpf-next 0/9] bpf: implement variadic printk helper
Date:   Fri, 17 Sep 2021 11:29:02 -0700
Message-ID: <20210917182911.2426606-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: SOriejT7hdtx2meI0fiRTH-nI_mCxv1j
X-Proofpoint-GUID: SOriejT7hdtx2meI0fiRTH-nI_mCxv1j
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_07,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series introduces a new helper, bpf_trace_vprintk, which functions
like bpf_trace_printk but supports > 3 arguments via a pseudo-vararg u64
array. The bpf_printk libbpf convenience macro is modified to use
bpf_trace_vprintk when > 3 varargs are passed, otherwise the previous
behavior - using bpf_trace_printk - is retained.

Helper functions and macros added during the implementation of
bpf_seq_printf and bpf_snprintf do most of the heavy lifting for
bpf_trace_vprintk. There's no novel format string wrangling here.

Usecase here is straightforward: Giving BPF program writers a more
powerful printk will ease development of BPF programs, particularly
during debugging and testing, where printk tends to be used.

This feature was proposed by Andrii in libbpf mirror's issue tracker
[1].

[1] https://github.com/libbpf/libbpf/issues/315

v5 -> v6: Rebase to pick up newly-added helper

v4 -> v5:

* patch 8: added test for "%pS" format string w/ NULL fmt arg [Daniel]
* patch 8: dmesg -> /sys/kernel/debug/tracing/trace_pipe in commit message =
[Andrii]
* patch 9: squash into patch 8, remove the added test in favor of just bpf_=
printk'ing in patch 8's test [Andrii]
    * migrate comment to /* */
* header comments improved$
    * uapi/linux/bpf.h: u64 -> long return type [Daniel]
    * uapi/linux/bpf.h: function description explains benefit of bpf_trace_=
vprintk over bpf_trace_printk [Daniel]
    * uapi/linux/bpf.h: added patch explaining that data_len should be a mu=
ltiple of 8 in bpf_seq_printf, bpf_snprintf descriptions [Daniel]
    * tools/lib/bpf/bpf_helpers.h: move comment to new bpf_printk [Andrii]
* rebase

v3 -> v4:
* Add patch 2, which migrates reference_tracking prog_test away from=20
  bpf_program__load. Could be placed a bit later in the series, but=20
  wanted to keep the actual vprintk-related patches contiguous
* Add patch 9, which adds a program w/ 0 fmt arg bpf_printk to vprintk
  test
* bpf_printk convenience macro isn't multiline anymore, so simplify [Andrii]
* Add some comments to ___bpf_pick_printk to make it more obvious when
  implementation switches from printk to vprintk [Andrii]
* BPF_PRINTK_FMT_TYPE -> BPF_PRINTK_FMT_MOD for 'static const' fmt string
  in printk wrapper macro [Andrii]
    * checkpatch.pl doesn't like this, says "Macros with complex values=20
      should be enclosed in parentheses". Strange that it didn't have simil=
ar
      complaints about v3's BPF_PRINTK_FMT_TYPE. Regardless, IMO the compla=
int
      is not highlighting a real issue in the case of this macro.
* Fix alignment of __bpf_vprintk and __bpf_pick_printk [Andrii]
* rebase

v2 -> v3:
* Clean up patch 3's commit message [Alexei]
* Add patch 4, which modifies __bpf_printk to use 'static const char' to
  store fmt string with fallback for older kernels [Andrii]
* rebase

v1 -> v2:

* Naming conversation seems to have gone in favor of keeping
  bpf_trace_vprintk, names are unchanged

* Patch 3 now modifies bpf_printk convenience macro to choose between
  __bpf_printk and __bpf_vprintk 'implementation' macros based on arg
  count. __bpf_vprintk is a renaming of bpf_vprintk convenience macro
  from v1, __bpf_printk is the existing bpf_printk implementation.

  This patch could use some scrutiny as I think current implementation
  may regress developer experience in a specific case, turning a
  compile-time error into a load-time error. Unclear to me how
  common the case is, or whether the macro magic I chose is ideal.

* char ___fmt[] to static const char ___fmt[] change was not done,
  wanted to leave __bpf_printk 'implementation' macro unchanged for v2
  to ease discussion of above point

* Removed __always_inline from __set_printk_clr_event [Andrii]
* Simplified bpf_trace_printk docstring to refer to other functions
  instead of copy/pasting and avoid specifying 12 vararg limit [Andrii]
* Migrated trace_printk selftest to use ASSERT_ instead of CHECK
  * Adds new patch 5, previous patch 5 is now 6
* Migrated trace_vprintk selftest to use ASSERT_ instead of CHECK,
  open_and_load instead of separate open, load [Andrii]
* Patch 2's commit message now correctly mentions trace_pipe instead of
  dmesg [Andrii]

Dave Marchevsky (9):
  bpf: merge printk and seq_printf VARARG max macros
  selftests/bpf: stop using bpf_program__load
  bpf: add bpf_trace_vprintk helper
  libbpf: Modify bpf_printk to choose helper based on arg count
  libbpf: use static const fmt string in __bpf_printk
  bpftool: only probe trace_vprintk feature in 'full' mode
  selftests/bpf: Migrate prog_tests/trace_printk CHECKs to ASSERTs
  selftests/bpf: add trace_vprintk test prog
  bpf: Clarify data_len param in bpf_snprintf and bpf_seq_printf
    comments

 include/linux/bpf.h                           |  3 +
 include/uapi/linux/bpf.h                      | 16 ++++-
 kernel/bpf/core.c                             |  5 ++
 kernel/bpf/helpers.c                          |  6 +-
 kernel/trace/bpf_trace.c                      | 54 ++++++++++++++-
 tools/bpf/bpftool/feature.c                   |  1 +
 tools/include/uapi/linux/bpf.h                | 16 ++++-
 tools/lib/bpf/bpf_helpers.h                   | 51 +++++++++++---
 tools/testing/selftests/bpf/Makefile          |  3 +-
 .../bpf/prog_tests/reference_tracking.c       | 39 ++++++++---
 .../selftests/bpf/prog_tests/trace_printk.c   | 24 +++----
 .../selftests/bpf/prog_tests/trace_vprintk.c  | 68 +++++++++++++++++++
 .../selftests/bpf/progs/trace_vprintk.c       | 33 +++++++++
 tools/testing/selftests/bpf/test_bpftool.py   | 22 +++---
 14 files changed, 286 insertions(+), 55 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/trace_vprintk.c
 create mode 100644 tools/testing/selftests/bpf/progs/trace_vprintk.c

--=20
2.30.2

