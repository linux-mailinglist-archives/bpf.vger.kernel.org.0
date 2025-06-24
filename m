Return-Path: <bpf+bounces-61449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D0AE71FF
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBBD17EA14
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B147D248880;
	Tue, 24 Jun 2025 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgIF0dUI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668C3D994
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802447; cv=none; b=jnTnXapODrv9nsWaAg+uccwaS70oYgEcJXzEaaNWIPvQMgDqYcyOTwBSzaouKKQFXH72Y1NJv8QibWF5tYyYdyBAvEeIt8JOpplN0JKhv1XjavgeNEG0pX/slEJjopIqWR8/BzbYM4GHAWxh72tTQL2aAsMN0uw8tLG8f+5Spvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802447; c=relaxed/simple;
	bh=EUJDltZtLNf5Ok3jNt+QyKdeg49IkPgZlH6AD1w28JI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K033MIfPfARBGKp7sBeDGwreMfCvzA5pRMmqJofDYN/I5FCLYr7zJ9EOy/gG1LuOgT5Ae9V1ChR0OzDuw892ceipQSIaYw1JHbIkSMoS9SDIMxAeV7LggNAxmbqFwjEs16pVIZNNI6/3glwa19P0hHTiAwVHKX9XPAcYUJ8xJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgIF0dUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B73EC4CEE3;
	Tue, 24 Jun 2025 22:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750802446;
	bh=EUJDltZtLNf5Ok3jNt+QyKdeg49IkPgZlH6AD1w28JI=;
	h=From:To:Cc:Subject:Date:From;
	b=VgIF0dUIUrIL12IPx1RyONoZGx036xgh+0YEIMmoJjd0Q+sXomaZoHbrBLvp1hOgK
	 QVzPG4yZ0KIa6D8bGRxvXJIHHbmBkgN7bl4qUM5g0S2QCsvT1kMkLCE9sH7y+WMXFA
	 U5aaRZ2tqZxMoe+T7FhPiJHn0P6+Lhcx1aI3iwaO5VpwCV3Ak5uYL129n+ezm2h/cz
	 PvuR4Y1VcKpYOsDUYG7oSj2hKAcBgyRSqgd7rsOik7zWcI6nE0WgPcmyiC9ufJwA0B
	 lGqHvRMMjU9Q6fLxY+bMt8+inm3mxzVlz2ah+3pbGXLKLTeLnuI/bLDBPunRgle3cT
	 NkUSfe1RPnPKg==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 0/2] Range tracking for BPF_NEG
Date: Tue, 24 Jun 2025 15:00:36 -0700
Message-ID: <20250624220038.656646-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add range tracking for BPF_NEG. Please see commit log of 1/2 for more
details.

---

Changes v1 => v2:
1. Split new selftests to a separate patch. (Eduard)
2. Reset reg id on BPF_NEG. (Eduard)
3. Use env->fake_reg instead of a bpf_reg_state on the stack. (Eduard)
4. Add __msg for passing selftests.

v1: https://lore.kernel.org/bpf/20250624172320.2923031-1-song@kernel.org/

Song Liu (2):
  bpf: Add range tracking for BPF_NEG
  selftests/bpf: Add tests for BPF_NEG range tracking logic

 include/linux/tnum.h                          |  2 +
 kernel/bpf/tnum.c                             |  5 ++
 kernel/bpf/verifier.c                         | 17 ++++-
 .../bpf/progs/verifier_bounds_deduction.c     | 17 -----
 .../selftests/bpf/progs/verifier_precision.c  | 70 +++++++++++++++++++
 .../bpf/progs/verifier_value_ptr_arith.c      |  8 +--
 6 files changed, 95 insertions(+), 24 deletions(-)

--
2.47.1

