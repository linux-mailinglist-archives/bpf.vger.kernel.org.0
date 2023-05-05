Return-Path: <bpf+bounces-58-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E572C6F79EE
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 02:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF1F1C2164B
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3893EDE;
	Fri,  5 May 2023 00:09:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78140621
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 00:09:29 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA20132AC
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 17:09:26 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 344JahP4013410
	for <bpf@vger.kernel.org>; Thu, 4 May 2023 17:09:25 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3qccq04ma4-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 04 May 2023 17:09:25 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 17:09:22 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id E575D3002F916; Thu,  4 May 2023 17:09:09 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 00/10] Add precision propagation for subprogs and callbacks
Date: Thu, 4 May 2023 17:08:58 -0700
Message-ID: <20230505000908.1265044-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0oVSVt-MZpdMQh5C3jSIy9GdLYVgvwJU
X-Proofpoint-GUID: 0oVSVt-MZpdMQh5C3jSIy9GdLYVgvwJU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As more and more real-world BPF programs become more complex
and increasingly use subprograms (both static and global), scalar precisi=
on
tracking and its (previously weak) support for BPF subprograms (and callb=
acks
as a special case of that) is becoming more and more of an issue and
limitation. Couple that with increasing reliance on state equivalence (BP=
F
open-coded iterators have a hard requirement for state equivalence to con=
verge
and successfully validate loops), and it becomes pretty critical to addre=
ss
this limitation and make precision tracking universally supported for BPF
programs of any complexity and composition.

This patch set teaches BPF verifier to support SCALAR precision
backpropagation across multiple frames (for subprogram calls and callback
simulations) and addresses most practical situations (SCALAR stack
loads/stores using registers other than r10 being the last remaining
limitation, though thankfully rarely used in practice).

Main logic is explained in details in patch #8. The rest are preliminary
preparations, refactorings, clean ups, and fixes. See respective patches =
for
details.

Patch #8 has also veristat comparison of results for selftests, Cilium, a=
nd
some of Meta production BPF programs before and after these changes.

v1->v2:
  - addressed review feedback form Alexei, adjusted commit messages, comm=
ents,
    added verbose(), WARN_ONCE(), etc;
  - re-ran all the tests and veristat on selftests, cilium, and meta-inte=
rnal
    code: no new changes and no kernel warnings.

Andrii Nakryiko (10):
  veristat: add -t flag for adding BPF_F_TEST_STATE_FREQ program flag
  bpf: mark relevant stack slots scratched for register read
    instructions
  bpf: encapsulate precision backtracking bookkeeping
  bpf: improve precision backtrack logging
  bpf: maintain bitmasks across all active frames in
    __mark_chain_precision
  bpf: fix propagate_precision() logic for inner frames
  bpf: fix mark_all_scalars_precise use in mark_chain_precision
  bpf: support precision propagation in the presence of subprogs
  selftests/bpf: add precision propagation tests in the presence of
    subprogs
  selftests/bpf: revert iter test subprog precision workaround

 include/linux/bpf_verifier.h                  |  28 +-
 kernel/bpf/verifier.c                         | 638 +++++++++++++-----
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +
 tools/testing/selftests/bpf/progs/iters.c     |  26 +-
 .../bpf/progs/verifier_subprog_precision.c    | 536 +++++++++++++++
 .../testing/selftests/bpf/verifier/precise.c  | 107 +--
 tools/testing/selftests/bpf/veristat.c        |   9 +
 8 files changed, 1128 insertions(+), 222 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_pr=
ecision.c

--=20
2.34.1


