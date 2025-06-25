Return-Path: <bpf+bounces-61546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 473CAAE8A12
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCDB1882929
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FB22D4B66;
	Wed, 25 Jun 2025 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU1XYH3F"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C25B2C3769
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869631; cv=none; b=UCjQC9vqnBts3+QY2DNdugLJ8+mh/UhSu/ySFWCZzqVxFzR38VOD91gmlN3gakaigG389CWCFyrxnMnFKpVs0VOpoCowt0fIlK6pLf+C5PVcegRSrJhQGOqpqNLqqi0Zojy3s8wCGhgnKKbw+qMv1xipKW1uJh+5fUtFSN2pbYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869631; c=relaxed/simple;
	bh=FXXUFZm5Fxj8/sL44xcr/GZrLEXxjA7av4uXWdQVgnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nymJg8XYtbL5xN+F03XUsZpWzl+BYWlFGcVX16v+qJBX6MSvAFKiRw+xSkb535sNIJ6u+ZW607ki8PJEvIbsCvc5wRNxvKDMLu+Z5jeWL2dilT3y6UADvnuXm6Ox0nzsYPRWa55lddujJWoRSdtvl8jfI7feY7eihkbARIPRgdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU1XYH3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6ADC4CEEA;
	Wed, 25 Jun 2025 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750869631;
	bh=FXXUFZm5Fxj8/sL44xcr/GZrLEXxjA7av4uXWdQVgnk=;
	h=From:To:Cc:Subject:Date:From;
	b=BU1XYH3FFZuzlST1mLJsEXoH1MAijXpWnTK0r7bPMSP9Pzsf/AyXlM8YdQJ5D83NG
	 /2jsQkFlbJ4VJxH6HjjM3cnnC8ZIcc5vD/lcVLHJo4WCts7SpmPUbSvRw7NfdLbddh
	 tHTIyYHVzgD2EheTeNbeY2zcNL+m30yvlYWnfTkS4yeRhHuHU9VS5f0p8Gdt9PTKfj
	 GslXjlexaiEz01a5XM6jasDGSrYl5sv5a5n1VZ5GSle9C9XGN20f3FIXCzXKRu2faV
	 zViVJru8Vr1asOCQJXcMR6fkRy15XGAOkmgmDps2gH7WLLz/zl03K/UO3GZZczsJ8o
	 zdUOs7Q3gOVDA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 0/2] Range tracking for BPF_NEG
Date: Wed, 25 Jun 2025 09:40:23 -0700
Message-ID: <20250625164025.3310203-1-song@kernel.org>
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

Changes v3 => v4:
1. Fix selftest verifier_value_ptr_arith.c. (Eduard)

v3: https://lore.kernel.org/bpf/20250624233328.313573-1-song@kernel.org/

Changes v2 => v3:
1. Minor changes in the selftests. (Eduard)

v2: https://lore.kernel.org/bpf/20250624220038.656646-1-song@kernel.org/

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
 .../bpf/progs/verifier_bounds_deduction.c     | 11 +--
 .../selftests/bpf/progs/verifier_precision.c  | 70 +++++++++++++++++++
 .../bpf/progs/verifier_value_ptr_arith.c      | 22 ++++--
 6 files changed, 116 insertions(+), 11 deletions(-)

--
2.47.1

