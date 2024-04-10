Return-Path: <bpf+bounces-26354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 725AF89E8FA
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7D9286DF3
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 04:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADDE26AFF;
	Wed, 10 Apr 2024 04:35:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6995F22301
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723739; cv=none; b=l0RlIRBEfsIsbspbfWEvsf7QWtSpTbtuMjQspkWcLr6NuJ7xysXdYzF8pRtd5E+g+e2wrhg5yhqtoKUpaWCeKlbZQ2Anb+d66v56EcaEa69HlsURWNd266prxHc0RYsK1DPefzAZJFmRJttQFG7NvDNFvP8T/jmE2E0Lvtzwfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723739; c=relaxed/simple;
	bh=kyG+6Sb4Tu6tqLad143VnmnFmLTZnwm4wQG5RuU64Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PRLZG+9A3zW0zufO+Udr1ijOuU2dqVyfmTGbKUlUa0zgvcD3rwBC+oNOPkhL3uzRXmUAfkAOhHBNlEcMLplsuK6bfqk/Qc06EghProYYBnlDZCIMK7I/X9Av+Ju69tpL9F1jOeR9IXo4Zt5rP8hVPA+RWsI0WxPiD+Qi2BowciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 195F92D7F20B; Tue,  9 Apr 2024 21:35:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v7 0/5] bpf: Add bpf_link support for sk_msg and sk_skb progs
Date: Tue,  9 Apr 2024 21:35:22 -0700
Message-ID: <20240410043522.3736912-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

One of our internal services started to use sk_msg program and currently
it used existing prog attach/detach2 as demonstrated in selftests.
But attach/detach of all other bpf programs are based on bpf_link.
Consistent attach/detach APIs for all programs will make things easy to
undersand and less error prone. So this patch added bpf_link
support for BPF_PROG_TYPE_SK_MSG. Based on comments from
previous RFC patch, I added BPF_PROG_TYPE_SK_SKB support as well
as both program types have similar treatment w.r.t. bpf_link
handling.

For the patch series, patch 1 added kernel support. Patch 2
added libbpf support. Patch 3 added bpftool support and
patches 4/5 added some new tests.

Changelogs:
  v6 -> v7:
    - fix an missing-mutex_unlock error.
  v5 -> v6:
    - resolve libbpf conflict due to recent upstream change.
    - add a bpf_link_create() test.
    - some code refactoring for better code quality.
  v4 -> v5:
    - increase scope of mutex protection in link_release.
    - remove previous-leftover entry in libbpf.map.
    - make some code changes for better understanding.
  v3 -> v4:
    - use a single mutex lock to protect both attach/detach/update
      and release/fill_info/show_fdinfo.
    - simplify code for sock_map_link_lookup().
    - fix a few bugs.
    - add more tests.
  v2 -> v3:
    - consolidate link types of sk_msg and sk_skb to
      a single link type BPF_PROG_TYPE_SOCKMAP.
    - fix bpf_link lifecycle issue. in v2, after bpf_link
      is attached, a subsequent prog_attach could change
      that bpf_link. this patch makes bpf_link having
      correct behavior such that it won't go away facing
      other prog/link attach for the same map and the same
      attach type.

Yonghong Song (5):
  bpf: Add bpf_link support for sk_msg and sk_skb progs
  libbpf: Add bpf_link support for BPF_PROG_TYPE_SOCKMAP
  bpftool: Add link dump support for BPF_LINK_TYPE_SOCKMAP
  selftests/bpf: Refactor out helper functions for a few tests
  selftests/bpf: Add some tests with new bpf_program__attach_sockmap()
    APIs

 include/linux/bpf.h                           |   6 +
 include/linux/skmsg.h                         |   4 +
 include/uapi/linux/bpf.h                      |   5 +
 kernel/bpf/syscall.c                          |   4 +
 net/core/sock_map.c                           | 263 ++++++++++++++++--
 tools/bpf/bpftool/link.c                      |   9 +
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/lib/bpf/libbpf.c                        |   7 +
 tools/lib/bpf/libbpf.h                        |   2 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 171 +++++++++++-
 .../selftests/bpf/prog_tests/sockmap_listen.c |  38 +++
 .../bpf/progs/test_skmsg_load_helpers.c       |  27 +-
 .../bpf/progs/test_sockmap_pass_prog.c        |  17 +-
 .../progs/test_sockmap_skb_verdict_attach.c   |   2 +-
 15 files changed, 526 insertions(+), 35 deletions(-)

--=20
2.43.0


