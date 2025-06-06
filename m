Return-Path: <bpf+bounces-59831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11C2ACFB99
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 05:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA623AFDA7
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 03:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836791DE2DE;
	Fri,  6 Jun 2025 03:23:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D318F27702
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 03:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749180206; cv=none; b=gjxYfkqWmBi14d9Y5leeor0kngwX6oXJmU3jcbLGtEBGT8WJhmCOd/vNdYRuyVHDupPe/f7Z7MwPVor6vFzkZHAUW8suKtjLHu+Ovx1fEmo6QczsfWiUXb3wztgxERN5Le2F+85a0iRq6Q7IDIkphZ/C89/BxqXAeuiepCxdS+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749180206; c=relaxed/simple;
	bh=r88c6wdn840qeot24j8tKKDRgz4sG/1nxuf2js2ry3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBecE+EhKQTqNyt1OW+T7adt9WbmqPnzy1FYJNQJnflfkyrFZ7FcGPU8Cx8lp/KqZTns2j/w+cz4JOMGvsjk5/+4EBgVnUr6YJOL1iCsGHyOebAtaVOh8gz3Bqc1T42d4QqqlnYqlDdxy4ozo7F+vhUcVZSGgsM2qX2Tff6aJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig061.cco5.facebook.com (Postfix, from userid 128203)
	id DC077202ED84; Thu,  5 Jun 2025 20:23:09 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 0/4] selftests/bpf: Fix a few test failures with arm64 64KB page
Date: Thu,  5 Jun 2025 20:23:09 -0700
Message-ID: <20250606032309.444401-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

My local arm64 host has 64KB page size and the VM to run test_progs
also has 64KB page size. There are a few self tests assuming 4KB page
and hence failed in my envorinment. Patch 1 tries to reduce long assert
logs when tail failed. Patches 2-4 fixed three selftest failures.

Yonghong Song (4):
  selftests/bpf: Reduce test_xdp_adjust_frags_tail_grow logs
  selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB page size
  selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 64KB
    page size
  selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size

 .../selftests/bpf/prog_tests/bpf_mod_race.c    |  2 +-
 .../testing/selftests/bpf/prog_tests/ringbuf.c |  5 +++--
 .../selftests/bpf/prog_tests/user_ringbuf.c    |  6 ++++--
 .../selftests/bpf/prog_tests/xdp_adjust_tail.c | 18 ++++++++++++------
 .../selftests/bpf/progs/test_ringbuf_write.c   |  5 +++--
 5 files changed, 23 insertions(+), 13 deletions(-)

--=20
2.47.1


