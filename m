Return-Path: <bpf+bounces-4792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA5374F7B5
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 20:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A985A28197E
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 18:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178BF1EA7C;
	Tue, 11 Jul 2023 18:00:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D631E508
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 18:00:25 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A101710
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 11:00:24 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 36BHhEsP028654
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 11:00:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=mFYx6ikCp+YFvdADF1y3LWfmCc++mMIn+3HW7N9fcTU=;
 b=CBsyd+6xDDzgvzmUPzdyPR22rxebZIP6lhRqUC+65XdKL7cjMD0f7VUsgE9oFrHn7bBH
 RwRbJR/Ky1C6OXOCLvYqejC0wXLs6z36EnLj0ZEtgqP+5sSe3uElwi1rRCemTW2mX1Np
 EpeJQ/WcD1pJY6975mbFLirS+kA2JirtJ8o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3rrtjnfhwf-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 11:00:23 -0700
Received: from twshared37136.03.ash8.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Jul 2023 10:59:55 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 913D320EAEEB9; Tue, 11 Jul 2023 10:59:46 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH bpf-next 0/6] BPF Refcount followups 2: owner field
Date: Tue, 11 Jul 2023 10:59:39 -0700
Message-ID: <20230711175945.3298231-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Q0e7AXW_cRkmIoFEnN24FW0jb2JmSZNo
X-Proofpoint-ORIG-GUID: Q0e7AXW_cRkmIoFEnN24FW0jb2JmSZNo
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_10,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series adds an 'owner' field to bpf_{list,rb}_node structs, to be
used by the runtime to determine whether insertion or removal operations
are valid in shared ownership scenarios. Both the races which the series
fixes and the fix itself are inspired by Kumar's suggestions in [0].

Aside from insertion and removal having more reasons to fail, there are
no user-facing changes as a result of this series.

* Patch 1 reverts disabling of bpf_refcount_acquire so that the fixed
logic can be exercised by CI. It should _not_ be applied.
* Patch 2 adds internal definitions of bpf_{rb,list}_node so that
their fields are easier to access.
* Patch 3 is the meat of the series - it adds 'owner' field and
enforcement of correct owner to insertion and removal helpers.
* Patch 4 adds a test based on Kumar's examples.
* Patch 5 disables the test until bpf_refcount_acquire is re-enabled.
* Patch 6 reverts disabling of test added in this series
logic can be exercised by CI. It should _not_ be applied.

  [0]: https://lore.kernel.org/bpf/d7hyspcow5wtjcmw4fugdgyp3fwhljwuscp3xyut=
5qnwivyeru@ysdq543otzv2/

Dave Marchevsky (6):
  [DONOTAPPLY] Revert "bpf: Disable bpf_refcount_acquire kfunc calls
    until race conditions are fixed"
  bpf: Introduce internal definitions for UAPI-opaque bpf_{rb,list}_node
  bpf: Add 'owner' field to bpf_{list,rb}_node
  selftests/bpf: Add rbtree test exercising race which 'owner' field
    prevents
  selftests/bpf: Disable newly-added 'owner' field test until refcount
    re-enabled
  [DONOTAPPLY] Revert "selftests/bpf: Disable newly-added 'owner' field
    test until refcount re-enabled"

 include/linux/bpf.h                           | 12 +++
 include/uapi/linux/bpf.h                      |  2 +
 kernel/bpf/helpers.c                          | 48 +++++++---
 kernel/bpf/verifier.c                         |  5 +-
 .../selftests/bpf/prog_tests/linked_list.c    | 78 +++++++--------
 .../bpf/prog_tests/refcounted_kptr.c          | 30 ++++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 94 ++++++++++++++++++-
 7 files changed, 212 insertions(+), 57 deletions(-)

--=20
2.34.1


