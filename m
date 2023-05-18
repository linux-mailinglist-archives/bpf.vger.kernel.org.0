Return-Path: <bpf+bounces-919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A5E708AD4
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 23:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0BE1C20BCE
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 21:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D598324E8A;
	Thu, 18 May 2023 21:55:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7093D134C8
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 21:55:05 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215A0E6E
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 14:55:01 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IKEF9f020439
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 14:55:00 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qntvegks5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 14:55:00 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 14:54:59 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 14:54:59 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id CCFC430EEE484; Thu, 18 May 2023 14:54:45 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <cyphar@cyphar.com>, <brauner@kernel.org>, <lennart@poettering.net>,
        <linux-fsdevel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 0/3] Add O_PATH-based BPF_OBJ_PIN and BPF_OBJ_GET support
Date: Thu, 18 May 2023 14:54:41 -0700
Message-ID: <20230518215444.1418789-1-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: IT2UUStMNeQnFMcZPRBbhV2xyusc6QT4
X-Proofpoint-GUID: IT2UUStMNeQnFMcZPRBbhV2xyusc6QT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_15,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add ability to specify pinning location within BPF FS using O_PATH-based =
FDs,
similar to openat() family of APIs. Patch #1 adds necessary kernel-side
changes. Patch #2 exposes this through libbpf APIs. Patch #3 uses new mou=
nt
APIs (fsopen, fsconfig, fsmount) to demonstrated how now it's possible to=
 work
with detach-mounted BPF FS using new BPF_OBJ_PIN and BPF_OBJ_GET
functionality.

This feature is inspired as a result of recent conversations during
LSF/MM/BPF 2023 conference about shortcomings of being able to perform BP=
F
objects pinning only using lookup-based paths.

v1->v2:
  - add BPF_F_PATH_FD flag that should go along with path FD (Christian).

Andrii Nakryiko (3):
  bpf: support O_PATH FDs in BPF_OBJ_PIN and BPF_OBJ_GET commands
  libbpf: add opts-based bpf_obj_pin() API and add support for path_fd
  selftests/bpf: add path_fd-based BPF_OBJ_PIN and BPF_OBJ_GET tests

 include/linux/bpf.h                           |   4 +-
 include/uapi/linux/bpf.h                      |  10 ++
 kernel/bpf/inode.c                            |  16 +--
 kernel/bpf/syscall.c                          |  25 +++-
 tools/include/uapi/linux/bpf.h                |  10 ++
 tools/lib/bpf/bpf.c                           |  17 ++-
 tools/lib/bpf/bpf.h                           |  18 ++-
 tools/lib/bpf/libbpf.map                      |   1 +
 .../bpf/prog_tests/bpf_obj_pinning.c          | 112 ++++++++++++++++++
 9 files changed, 193 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_obj_pinnin=
g.c

--=20
2.34.1


