Return-Path: <bpf+bounces-14884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A93E7E8C81
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 21:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7EE1C208E5
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06891D555;
	Sat, 11 Nov 2023 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58151B26D
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 20:16:51 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B360B3A85
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 12:16:50 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ABKGFWn023953
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 12:16:49 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ua884hqjf-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 12:16:49 -0800
Received: from twshared4634.37.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 12:16:47 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id EB83B3B5A8F16; Sat, 11 Nov 2023 12:16:34 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 0/8] BPF verifier log improvements
Date: Sat, 11 Nov 2023 12:16:25 -0800
Message-ID: <20231111201633.3434794-1-andrii@kernel.org>
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
X-Proofpoint-GUID: 1V66TwH6JNpJ7xux3UAtWZpFK63yjMHs
X-Proofpoint-ORIG-GUID: 1V66TwH6JNpJ7xux3UAtWZpFK63yjMHs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-11_16,2023-11-09_01,2023-05-22_02

This patch set moves a big chunk of verifier log related code from gigant=
ic
verifier.c file into more focused kernel/bpf/log.c. This is not essential=
 to
the rest of functionality in this patch set, so I can undo it, but it fel=
t
like it's good to start chipping away from 20K+ verifier.c whenever we ca=
n.

The main purpose of the patch set, though, is in improving verifier log
further.

Patches #3-#4 start printing out register state even if that register is
spilled into stack slot. Previously we'd get only spilled register type, =
but
no additional information, like SCALAR_VALUE's ranges. Super limiting dur=
ing
debugging. For cases of register spills smaller than 8 bytes, we also pri=
nt
out STACK_MISC/STACK_ZERO/STACK_INVALID markers. This, among other things=
,
will make it easier to write tests for these mixed spill/misc cases.

Patch #5 prints map name for PTR_TO_MAP_VALUE/PTR_TO_MAP_KEY/CONST_PTR_TO=
_MAP
registers. In big production BPF programs, it's important to map assembly=
 to
actual map, and it's often non-trivial. Having map name helps.

Patch #6 just removes visual noise in form of ubiquitous imm=3D0 and off=3D=
0. They
are default values, omit them.

Patch #7 is probably the most controversial, but it reworks how verifier =
log
prints numbers. For small valued integers we use decimals, but for large =
ones
we switch to hexadecimal. From personal experience this is a much more us=
eful
convention. We can tune what consitutes "small value", for now it's 16-bi=
t
range.

Patch #8 prints frame number for PTR_TO_CTX registers, if that frame is
different from the "current" one. This removes ambiguity and confusion,
especially in complicated cases with multiple subprogs passing around
pointers.

v1->v2:
  - use verbose_snum() for range and offset in register state (Eduard);
  - fixed typos and added acks from Eduard and Stanislav.

Andrii Nakryiko (8):
  bpf: move verbose_linfo() into kernel/bpf/log.c
  bpf: move verifier state printing code to kernel/bpf/log.c
  bpf: extract register state printing
  bpf: print spilled register state in stack slot
  bpf: emit map name in register state if applicable and available
  bpf: omit default off=3D0 and imm=3D0 in register state log
  bpf: smarter verifier log number printing logic
  bpf: emit frameno for PTR_TO_STACK regs if it differs from current one

 include/linux/bpf_verifier.h                  |  76 +++
 kernel/bpf/log.c                              | 480 ++++++++++++++++++
 kernel/bpf/verifier.c                         | 460 -----------------
 .../testing/selftests/bpf/prog_tests/align.c  |  42 +-
 .../selftests/bpf/prog_tests/log_buf.c        |   4 +-
 .../selftests/bpf/prog_tests/spin_lock.c      |  14 +-
 .../selftests/bpf/progs/exceptions_assert.c   |  40 +-
 7 files changed, 606 insertions(+), 510 deletions(-)

--=20
2.34.1


