Return-Path: <bpf+bounces-26189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ED789C82B
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 17:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6887D1C22F61
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4395140391;
	Mon,  8 Apr 2024 15:24:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95E13FD87
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589881; cv=none; b=DTWhCI8kv834jB0xEbkFa8n5/RKsn1fVaYYb67AKsQ2BV/HBO4gSr0mzutHHVn9M9cxC96NlteIPp4uxxk2pOb4OCeP4VcqCgRysgxquLTl618lgUlZeIyxtIZgLviZWKeyo5PUko0sXgB0bj+zRxil3dRZHscYnuOG6sWE+k9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589881; c=relaxed/simple;
	bh=fk0j/agTyJLumpn2w9huXLiY4yzlb7rKIYJVHXRTFI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KznkVKv1JnNL97lw+AhbasQ77qbG2rf1vY1YUdyUmhGFTyyzxGiSM5mnW6KXOa2fFFaZSQg4vhdsvnhB5MJmtUqH/PnQR/ERbQcPlWsW995D/jIMcL7DjGaaXRaVk8K3yhqyKRLyePsdOTp1iGnEmewHjE7r7qh0Z6peYAL7fUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id E41962C7DFC3; Mon,  8 Apr 2024 08:24:25 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 0/5] bpf: Add bpf_link support for sk_msg and sk_skb progs
Date: Mon,  8 Apr 2024 08:24:25 -0700
Message-ID: <20240408152425.4160829-1-yonghong.song@linux.dev>
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
 net/core/sock_map.c                           | 261 ++++++++++++++++--
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
 15 files changed, 524 insertions(+), 35 deletions(-)

--=20
2.43.0


