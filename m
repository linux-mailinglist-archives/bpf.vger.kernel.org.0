Return-Path: <bpf+bounces-23246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9C86F178
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 17:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFB7283319
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2474222627;
	Sat,  2 Mar 2024 16:50:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88315231
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398231; cv=none; b=j3vr5WNDV7n9AdIMKHB7BZ5PBm2C4XVI1kfE4KMN1y2U+cdC1rRrp1UjULnuWe7hnexapRgP8EFFZK+zBpA5oxGTSp8eX/LZBd63PaxiRY2PZk3AXOvWKrj1HyKiwheC2NIkrsflL4s/8rs4yJZX4EcSYCG+YZEVYEawnB7Abyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398231; c=relaxed/simple;
	bh=lLfKQ6H1wKEjRcp/ZrfNvLY9l03rW2BWj73IqetVHcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m1emAOd6T7aIn8R5cbXIduFM69VprMHoh2T7q/fWO8NfKljE8V80vlCPgZZrZrSJnIXNusNCYMViOuSeKKJ6p4PmpyNey7EP7bRa3/koHBAnV0N5od/2S0DJcZ3apnw1Ubq7byMqIMasTWzVJR4ujqhVqZVqPRnIGoXu7FbXhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 90F2A11F11A0; Sat,  2 Mar 2024 08:50:17 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 0/4] selftests/bpf: Fix a couple of test failures with LTO kernel
Date: Sat,  2 Mar 2024 08:50:17 -0800
Message-ID: <20240302165017.1627295-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With a LTO kernel built with clang, I encountered two test failures,
ksyms and kprobe_multi_bench_attach/kernel. Both test failures are
due to static variable/function renaming due to cross-file inlining.
The solution is to either skip the test or filter out those renamed
functions. A helper function check_lto_kernel() is introduced to
identify whether the underlying kernel is built with LTO or not.
Please see each individual patches for details.

Yonghong Song (4):
  selftests/bpf: Replace CHECK with ASSERT macros for ksyms test
  selftests/bpf: Add check_lto_kernel() helper
  selftests/bpf: Fix possible ksyms test failure with LTO kernel
  selftests/bpf: Fix possible kprobe_multi_bench_attach test failure
    with LTO kernel

 .../bpf/prog_tests/kprobe_multi_test.c        |  7 +++
 .../testing/selftests/bpf/prog_tests/ksyms.c  | 42 +++++++++--------
 tools/testing/selftests/bpf/testing_helpers.c | 47 +++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  1 +
 4 files changed, 78 insertions(+), 19 deletions(-)

--=20
2.43.0


