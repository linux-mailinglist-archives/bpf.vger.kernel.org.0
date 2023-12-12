Return-Path: <bpf+bounces-17597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2125180FA4A
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F560B21027
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 22:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AFD199A1;
	Tue, 12 Dec 2023 22:30:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ACBAA
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 14:30:54 -0800 (PST)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 1E0C92B68D727; Tue, 12 Dec 2023 14:30:40 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 0/5] bpf: Reduce memory usage for bpf_global_percpu_ma
Date: Tue, 12 Dec 2023 14:30:40 -0800
Message-Id: <20231212223040.2135547-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently when a bpf program intends to allocate memory for percpu kptr,
the verifier will call bpf_mem_alloc_init() to prefill all supported
unit sizes and this caused memory consumption very big for large number
of cpus. For example, for 128-cpu system, the total memory consumption
with initial prefill is ~175MB. Things will become worse for systems
with even more cpus.

Patch 1 is a preparatory patch.
Patch 2 addresses memory consumption issue by avoiding to prefill
with all unit sizes, i.e. only prefilling with user specified size.
Patch 3 further reduces memory consumption by limiting the=20
number of prefill entries for percpu memory allocation.
Patch 4 rejects percpu memory allocation with bpf_global_percpu_ma
when unit size is greater than 512 bytes.
Patch 5 fixed one test due to Patch 4 and added one test to
show the verification failure log message.

Yonghong Song (5):
  bpf: Refactor to have a memalloc cache destroying function
  bpf: Allow per unit prefill for non-fix-size percpu memory allocator
  bpf: Refill only one percpu element in memalloc
  bpf: Limit up to 512 bytes for bpf_global_percpu_ma allocation
  selftests/bpf: Cope with 512 bytes limit with bpf_global_percpu_ma

 include/linux/bpf_mem_alloc.h                 |  5 ++
 kernel/bpf/memalloc.c                         | 83 +++++++++++++++++--
 kernel/bpf/verifier.c                         | 30 +++----
 .../selftests/bpf/progs/percpu_alloc_fail.c   | 18 ++++
 .../testing/selftests/bpf/progs/test_bpf_ma.c |  9 --
 5 files changed, 114 insertions(+), 31 deletions(-)

--=20
2.34.1


