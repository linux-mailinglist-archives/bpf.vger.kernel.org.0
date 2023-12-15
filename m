Return-Path: <bpf+bounces-17903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4388C813E8E
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26E81F22615
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D0FEC4;
	Fri, 15 Dec 2023 00:12:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ACCEBC
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id E9A5F2B862734; Thu, 14 Dec 2023 16:11:52 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 0/6] bpf: Reduce memory usage for bpf_global_percpu_ma
Date: Thu, 14 Dec 2023 16:11:52 -0800
Message-Id: <20231215001152.3249146-1-yonghong.song@linux.dev>
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
Patch 2 avoids unnecessary extra percpu memory allocation.
Patch 3 addresses memory consumption issue by avoiding to prefill
with all unit sizes, i.e. only prefilling with user specified size.
Patch 4 further reduces memory consumption by limiting the
number of prefill entries for percpu memory allocation.
Patch 5 rejects percpu memory allocation with bpf_global_percpu_ma
when allocation size is greater than 512 bytes.
Patch 6 fixed one test due to Patch 5 and added one test to
show the verification failure log message.

Changelogs:
  v1 -> v2:
    . Avoid unnecessary extra percpu memory allocation.
    . Add a separate function to do bpf_global_percpu_ma initialization
    . promote.
    . Promote function static 'sizes' array to file static.
    . Add comments to explain to refill only one item for percpu alloc.

Yonghong Song (6):
  bpf: Refactor to have a memalloc cache destroying function
  bpf: Avoid unnecessary extra percpu memory allocation
  bpf: Allow per unit prefill for non-fix-size percpu memory allocator
  bpf: Refill only one percpu element in memalloc
  bpf: Limit up to 512 bytes for bpf_global_percpu_ma allocation
  selftests/bpf: Cope with 512 bytes limit with bpf_global_percpu_ma

 include/linux/bpf.h                           |   2 +-
 include/linux/bpf_mem_alloc.h                 |   7 ++
 kernel/bpf/core.c                             |   8 +-
 kernel/bpf/memalloc.c                         | 100 +++++++++++++++---
 kernel/bpf/verifier.c                         |  36 ++++---
 .../selftests/bpf/progs/percpu_alloc_fail.c   |  18 ++++
 .../testing/selftests/bpf/progs/test_bpf_ma.c |   9 --
 7 files changed, 138 insertions(+), 42 deletions(-)

--=20
2.34.1


