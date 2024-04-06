Return-Path: <bpf+bounces-26088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C1E89ABDE
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 18:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D242823D5
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 16:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1748F3BBE1;
	Sat,  6 Apr 2024 16:04:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261173BBCB
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419455; cv=none; b=CO2mXbpSh+QlPNyGE3JV0W2bjAYz+H5aL/r+3wZZS2KUldNY7Jg5wEM94ShAvQJrYTuzyMYvGXW7v0slzNkt9lJ2MXcbSwAFcp5vgP/M65g17D+jLNEtQV0QQbJxe2sn758Ca6LyN60ZIbIXCqRK/JVHeeL/j3pdWlgulWej7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419455; c=relaxed/simple;
	bh=VTQECL2mkWvuxhM2/xJH0kKEro/udahGXuf+BsTW4n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tK6gHL0Ozv+BbPITQHOHENSA1uY9Fbt4cpc0t1UAUEpQEY3/1eEkdJGwKXAwYuRy3vDTjpvtIwx4W8Fsnu4O298zw9IHYzQbF6/mRwy47ttRKB20aYV4T+gq1Oz09+3JJwkb/OhRMGYRQVifXI37Xbwj0rVQPYpNQp2B72e1tj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 079642B5514E; Sat,  6 Apr 2024 09:03:59 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 0/5] bpf: Add bpf_link support for sk_msg and sk_skb progs
Date: Sat,  6 Apr 2024 09:03:58 -0700
Message-ID: <20240406160359.176498-1-yonghong.song@linux.dev>
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
 net/core/sock_map.c                           | 270 ++++++++++++++++--
 tools/bpf/bpftool/link.c                      |   9 +
 tools/include/uapi/linux/bpf.h                |   5 +
 tools/lib/bpf/libbpf.c                        |   7 +
 tools/lib/bpf/libbpf.h                        |   2 +
 tools/lib/bpf/libbpf.map                      |   5 +
 tools/lib/bpf/libbpf_version.h                |   2 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 171 ++++++++++-
 .../selftests/bpf/prog_tests/sockmap_listen.c |  38 +++
 .../bpf/progs/test_skmsg_load_helpers.c       |  27 +-
 .../bpf/progs/test_sockmap_pass_prog.c        |  17 +-
 .../progs/test_sockmap_skb_verdict_attach.c   |   2 +-
 16 files changed, 537 insertions(+), 37 deletions(-)

--=20
2.43.0


