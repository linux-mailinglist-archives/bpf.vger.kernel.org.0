Return-Path: <bpf+bounces-60351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A10EAD5CE5
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9884D3A8955
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932E1CD208;
	Wed, 11 Jun 2025 17:15:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8AEBE
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662137; cv=none; b=VMtQ9ox0gKM708Y8abS0r74oLkVp1DIHxThmIkbvkiWDuMLF15VCeTtgRFgupgltakUTzvCCDijOXAcdqHABWDYePbzRDsBAU5JWWWVbNCjWCB23LS4GYtPPIQGbZct8WxDZg1fEM+x/PjLAWnbY3ObUo1o9yY5TN3j16xGwXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662137; c=relaxed/simple;
	bh=b+2MQKAsAx2t/ZbIaeLCQ1JRUqIGwAJKGICh2nAYHvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TYelbf/hZKKWsozOdOqYFYMwqm50a+pP7sorWHd4Qi1kkexmXAKPtYyJ4ajY7q+BF1hqgObKXZNKrqem/m+7BY1Ifp6Kdsc1u6G0U+H3xQu+YsmrD6upCkEowj1P7nfnXFNHdzizwG/rL0AmwEfjxniCqtYZvREEfzWurlyE70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B46559680C19; Wed, 11 Jun 2025 10:15:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 0/3] bpf: Fix a few test failures with 64K page size
Date: Wed, 11 Jun 2025 10:15:19 -0700
Message-ID: <20250611171519.2033193-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This small patch set tried to fix a few networking related test failure f=
ailures
due to 64K page size. Please see each individual patch for details.

Changelog:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20250608165534.1019914-1-yonghong.s=
ong@linux.dev/
    - For xdp_adjust_tail, let kernel test_run can handle various page si=
zes for xdp progs.
    - For two change_tail tests, make code easier to understand.
    - Resolved a new test failure (xdp_do_redirect).

Yonghong Song (3):
  bpf: Fix an issue in bpf_prog_test_run_xdp when page size greater than
    4K
  selftests/bpf: Fix two net related test failures with 64K page size
  selftests/bpf: Fix xdp_do_redirect failure with 64KB page size

 net/bpf/test_run.c                            |  2 +-
 .../bpf/prog_tests/xdp_adjust_tail.c          | 95 +++++++++++++++++--
 .../bpf/prog_tests/xdp_do_redirect.c          | 13 ++-
 .../bpf/progs/test_sockmap_change_tail.c      |  5 +-
 .../selftests/bpf/progs/test_tc_change_tail.c |  5 +-
 .../bpf/progs/test_xdp_adjust_tail_grow.c     |  8 +-
 6 files changed, 115 insertions(+), 13 deletions(-)

--=20
2.47.1


