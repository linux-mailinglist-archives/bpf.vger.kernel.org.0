Return-Path: <bpf+bounces-17706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D9C811E37
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 20:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A217B2827EF
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 19:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4342F503;
	Wed, 13 Dec 2023 19:09:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1309C1726
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:08:53 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDIXs7M031323
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:08:53 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uxx6qfh1f-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:08:53 -0800
Received: from twshared4634.37.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 13 Dec 2023 11:08:51 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 2FBB33D1859ED; Wed, 13 Dec 2023 11:08:46 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v3 bpf-next 00/10] BPF token support in libbpf's BPF object
Date: Wed, 13 Dec 2023 11:08:32 -0800
Message-ID: <20231213190842.3844987-1-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: EG00MlUlR4kn58N53DqDQw3LHjumnlAL
X-Proofpoint-GUID: EG00MlUlR4kn58N53DqDQw3LHjumnlAL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_12,2023-12-13_01,2023-05-22_02

Add fuller support for BPF token in high-level BPF object APIs. This is t=
he
most frequently used way to work with BPF using libbpf, so supporting BPF
token there is critical.

Patch #1 is improving kernel-side BPF_TOKEN_CREATE behavior by rejecting =
to
create "empty" BPF token with no delegation. This seems like saner behavi=
or
which also makes libbpf's caching better overall. If we ever want to crea=
te
BPF token with no delegate_xxx options set on BPF FS, we can use a new fl=
ag to
enable that.

Patches #2-#5 refactor libbpf internals, mostly feature detection code, t=
o
prepare it from BPF token FD.

Patch #6 adds options to pass BPF token into BPF object open options. It =
also
adds implicit BPF token creation logic to BPF object load step, even with=
out
any explicit involvement of the user. If the environment is setup properl=
y,
BPF token will be created transparently and used implicitly. This allows =
for
all existing application to gain BPF token support by just linking with
latest version of libbpf library. No source code modifications are requir=
ed.
All that under assumption that privileged container management agent prop=
erly
set up default BPF FS instance at /sys/bpf/fs to allow BPF token creation=
.

Patches #7-#8 adds more selftests, validating BPF object APIs work as exp=
ected
under unprivileged user namespaced conditions in the presence of BPF toke=
n.

Patch #9 extends libbpf with LIBBPF_BPF_TOKEN_PATH envvar knowledge, whic=
h can
be used to override custom BPF FS location used for implicit BPF token
creation logic without needing to adjust application code. This allows ad=
mins
or container managers to mount BPF token-enabled BPF FS at non-standard
location without the need to coordinate with applications.
LIBBPF_BPF_TOKEN_PATH can also be used to disable BPF token implicit crea=
tion
by setting it to an empty value. Patch #10 tests this new envvar function=
ality.

v2->v3:
  - move some stray feature cache refactorings into patch #4 (Alexei);
  - add LIBBPF_BPF_TOKEN_PATH envvar support (Alexei);
v1->v2:
  - remove minor code redundancies (Eduard, John);
  - add acks and rebase.

Andrii Nakryiko (10):
  bpf: fail BPF_TOKEN_CREATE if no delegation option was set on BPF FS
  libbpf: split feature detectors definitions from cached results
  libbpf: further decouple feature checking logic from bpf_object
  libbpf: move feature detection code into its own file
  libbpf: wire up token_fd into feature probing logic
  libbpf: wire up BPF token support at BPF object level
  selftests/bpf: add BPF object loading tests with explicit token
    passing
  selftests/bpf: add tests for BPF object load with implicit token
  libbpf: support BPF token path setting through LIBBPF_BPF_TOKEN_PATH
    envvar
  selftests/bpf: add tests for LIBBPF_BPF_TOKEN_PATH envvar

 kernel/bpf/token.c                            |  10 +-
 tools/lib/bpf/Build                           |   2 +-
 tools/lib/bpf/bpf.c                           |   9 +-
 tools/lib/bpf/btf.c                           |   7 +-
 tools/lib/bpf/elf.c                           |   2 -
 tools/lib/bpf/features.c                      | 478 +++++++++++++++
 tools/lib/bpf/libbpf.c                        | 573 ++++--------------
 tools/lib/bpf/libbpf.h                        |  37 +-
 tools/lib/bpf/libbpf_internal.h               |  36 +-
 tools/lib/bpf/libbpf_probes.c                 |   8 +-
 tools/lib/bpf/str_error.h                     |   3 +
 .../testing/selftests/bpf/prog_tests/token.c  | 347 +++++++++++
 tools/testing/selftests/bpf/progs/priv_map.c  |  13 +
 tools/testing/selftests/bpf/progs/priv_prog.c |  13 +
 14 files changed, 1065 insertions(+), 473 deletions(-)
 create mode 100644 tools/lib/bpf/features.c
 create mode 100644 tools/testing/selftests/bpf/progs/priv_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/priv_prog.c

--=20
2.34.1


