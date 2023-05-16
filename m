Return-Path: <bpf+bounces-587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B99704221
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 02:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637381C20CBF
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 00:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C2417F5;
	Tue, 16 May 2023 00:14:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9417E0
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 00:14:11 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC01759EE
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:14:08 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FMksvR003603
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:14:08 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qj5vr8dgw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:14:08 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 17:14:05 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 87F5030BEFA0F; Mon, 15 May 2023 17:13:53 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <cyphar@cyphar.com>, <brauner@kernel.org>, <lennart@poettering.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 0/3] Add O_PATH-based BPF_OBJ_PIN and BPF_OBJ_GET support
Date: Mon, 15 May 2023 17:13:45 -0700
Message-ID: <20230516001348.286414-1-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: QkurLOrUETmet_qXH-5LIo5_SE1NvLZ1
X-Proofpoint-GUID: QkurLOrUETmet_qXH-5LIo5_SE1NvLZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Andrii Nakryiko (3):
  bpf: support O_PATH FDs in BPF_OBJ_PIN and BPF_OBJ_GET commands
  libbpf: add opts-based bpf_obj_pin() API and add support for path_fd
  selftests/bpf: add path_fd-based BPF_OBJ_PIN and BPF_OBJ_GET tests

 include/linux/bpf.h                           |   4 +-
 include/uapi/linux/bpf.h                      |   5 +
 kernel/bpf/inode.c                            |  16 +--
 kernel/bpf/syscall.c                          |   8 +-
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/lib/bpf/bpf.c                           |  16 ++-
 tools/lib/bpf/bpf.h                           |  17 ++-
 tools/lib/bpf/libbpf.map                      |   1 +
 .../bpf/prog_tests/bpf_obj_pinning.c          | 110 ++++++++++++++++++
 9 files changed, 164 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_obj_pinnin=
g.c

--=20
2.34.1


