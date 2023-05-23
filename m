Return-Path: <bpf+bounces-1108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC0C70E28B
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 19:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63001C20A3F
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 17:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BC5206AF;
	Tue, 23 May 2023 17:00:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3320683
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 17:00:32 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A484E0
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:00:30 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NDkK5n005047
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:00:29 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qrds401wc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:00:29 -0700
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 10:00:27 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id AB1D13136532D; Tue, 23 May 2023 10:00:14 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <cyphar@cyphar.com>, <brauner@kernel.org>, <lennart@poettering.net>,
        <linux-fsdevel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 bpf-next 0/4] Add O_PATH-based BPF_OBJ_PIN and BPF_OBJ_GET support
Date: Tue, 23 May 2023 10:00:09 -0700
Message-ID: <20230523170013.728457-1-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: KOaCdBNWTX8HvFcxYb82yZj4uGecUg-m
X-Proofpoint-GUID: KOaCdBNWTX8HvFcxYb82yZj4uGecUg-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add ability to specify pinning location within BPF FS using O_PATH-based =
FDs,
similar to openat() family of APIs. Patch #2 adds necessary kernel-side
changes. Patch #3 exposes this through libbpf APIs. Patch #4 uses new mou=
nt
APIs (fsopen, fsconfig, fsmount) to demonstrated how now it's possible to=
 work
with detach-mounted BPF FS using new BPF_OBJ_PIN and BPF_OBJ_GET
functionality. We also add few more tests using various combinations of
path_fd and pathname to validate proper argument propagation in kernel co=
de.

This feature is inspired as a result of recent conversations during
LSF/MM/BPF 2023 conference about shortcomings of being able to perform BP=
F
objects pinning only using lookup-based paths.

v3->v4:
  - libbpf v1.3 bump (Daniel);
v2->v3:
  - __s32 for path_fd in union bpf_attr (Christian);
  - added subtest for absolute/relative paths during pinning/getting;
  - added pre-patch moving LSM hook (security_path_mknod) around (Christi=
an);
v1->v2:
  - add BPF_F_PATH_FD flag that should go along with path FD (Christian).

Andrii Nakryiko (4):
  bpf: Validate BPF object in BPF_OBJ_PIN before calling LSM
  libbpf: start v1.3 development cycle
  bpf: support O_PATH FDs in BPF_OBJ_PIN and BPF_OBJ_GET commands
  selftests/bpf: add path_fd-based BPF_OBJ_PIN and BPF_OBJ_GET tests

 include/linux/bpf.h                           |   4 +-
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/inode.c                            |  27 +-
 kernel/bpf/syscall.c                          |  25 +-
 tools/include/uapi/linux/bpf.h                |  10 +
 tools/lib/bpf/bpf.c                           |  17 +-
 tools/lib/bpf/bpf.h                           |  18 +-
 tools/lib/bpf/libbpf.map                      |   5 +
 tools/lib/bpf/libbpf_version.h                |   2 +-
 .../bpf/prog_tests/bpf_obj_pinning.c          | 268 ++++++++++++++++++
 10 files changed, 359 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_obj_pinnin=
g.c

--=20
2.34.1


