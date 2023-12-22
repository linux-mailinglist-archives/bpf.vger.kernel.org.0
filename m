Return-Path: <bpf+bounces-18580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D43281C352
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 04:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB53287D1A
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 03:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8694310E2;
	Fri, 22 Dec 2023 03:17:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A146111
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 03:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id A68632BD9931B; Thu, 21 Dec 2023 19:17:29 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 0/8] bpf: Reduce memory usage for bpf_global_percpu_ma
Date: Thu, 21 Dec 2023 19:17:29 -0800
Message-Id: <20231222031729.1287957-1-yonghong.song@linux.dev>
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

Patch 1 avoids unnecessary extra percpu memory allocation.
Patch 2 adds objcg to bpf_mem_alloc at init stage so objcg can be
associated with root cgroup and objcg can be passed to later
bpf_mem_alloc_percpu_unit_init().
Patch 3 addresses memory consumption issue by avoiding to prefill
with all unit sizes, i.e. only prefilling with user specified size.
Patch 4 further reduces memory consumption by limiting the
number of prefill entries for percpu memory allocation.
Patch 5 has much smaller low/high watermarks for percpu allocation
to reduce memory consumption.
Patch 6 rejects percpu memory allocation with bpf_global_percpu_ma
when allocation size is greater than 512 bytes.
Patch 7 fixed test_bpf_ma test due to Patch 5.
Patch 8 added one test to show the verification failure log message.

Changelogs:
  v5 -> v6:
    . Change bpf_mem_alloc_percpu_init() to add objcg as one of parameter=
s.
      For bpf_global_percpu_ma, the objcg is NULL, corresponding root mem=
cg.
  v4 -> v5:
    . Do not do bpf_global_percpu_ma initialization at init stage, instea=
d
      doing initialization when the verifier knows it is going to be used
      by bpf prog.
    . Using much smaller low/high watermarks for percpu allocation.
  v3 -> v4:
    . Add objcg to bpf_mem_alloc during init stage.
    . Initialize objcg at init stage but use it in bpf_mem_alloc_percpu_u=
nit_init().
    . Remove check_obj_size() in bpf_mem_alloc_percpu_unit_init().
  v2 -> v3:
    . Clear the bpf_mem_cache if prefill fails.
    . Change test_bpf_ma percpu allocation tests to use bucket_size
      as allocation size instead of bucket_size - 8.
    . Remove __GFP_ZERO flag from __alloc_percpu_gfp() call.
  v1 -> v2:
    . Avoid unnecessary extra percpu memory allocation.
    . Add a separate function to do bpf_global_percpu_ma initialization
    . promote.
    . Promote function static 'sizes' array to file static.
    . Add comments to explain to refill only one item for percpu alloc.

Yonghong Song (8):
  bpf: Avoid unnecessary extra percpu memory allocation
  bpf: Add objcg to bpf_mem_alloc
  bpf: Allow per unit prefill for non-fix-size percpu memory allocator
  bpf: Refill only one percpu element in memalloc
  bpf: Use smaller low/high marks for percpu allocation
  bpf: Limit up to 512 bytes for bpf_global_percpu_ma allocation
  selftests/bpf: Cope with 512 bytes limit with bpf_global_percpu_ma
  selftests/bpf: Add a selftest with > 512-byte percpu allocation size

 include/linux/bpf_mem_alloc.h                 |  8 ++
 kernel/bpf/memalloc.c                         | 93 ++++++++++++++++---
 kernel/bpf/verifier.c                         | 45 ++++++---
 .../selftests/bpf/prog_tests/test_bpf_ma.c    | 20 ++--
 .../selftests/bpf/progs/percpu_alloc_fail.c   | 18 ++++
 .../testing/selftests/bpf/progs/test_bpf_ma.c | 66 ++++++-------
 6 files changed, 184 insertions(+), 66 deletions(-)

--=20
2.34.1


