Return-Path: <bpf+bounces-61463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31127AE7349
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 01:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EB45A0FC4
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 23:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FF826B2A6;
	Tue, 24 Jun 2025 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE4M+zwv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B075E25D537
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 23:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750808012; cv=none; b=NOIuakgQqKfDxh4zB5RK0PmnAigw7KaucErs7N5T5lRPgKVxZl5k3mKx9NXEKqcI/C0YlzuqJPY799FUVXklzZODg4PSD9Khhk9PLHXzssTQIot8kVfuMDQRAZ9vnU6SXCjyM7Dprm7XTbOg/10zdG+NyozwaGScYOtrB6VO4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750808012; c=relaxed/simple;
	bh=UkGpfiPuWSwGi8JvYm3ftnBNpfR2kR6yI5DbC6p+l8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JlhVur85Dc9HWl5GEDhRI/AJk5hpCAKuHXEdkcLCi0VGiSlTBTc7PZkpwcxM37cWPmoOeVGvReCjwE3IdD/Klauvjmq4IzIGn4+b3TkRRtQoA6LIq2hC+mMf6tIy5l/TMmuj1XYPir9eFj8KtsqvlS7g2qcn9DogsD8XjsYQnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE4M+zwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6C7C4CEE3;
	Tue, 24 Jun 2025 23:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750808012;
	bh=UkGpfiPuWSwGi8JvYm3ftnBNpfR2kR6yI5DbC6p+l8I=;
	h=From:To:Cc:Subject:Date:From;
	b=HE4M+zwvJMgtlxjiOEAuseBBKTtC1I8hyH42eXAVssvDztat5AZAjxS0hc+tbnUU5
	 7h+fzmhFwBoR9TCG2+LCzpunAOzpUmqJ+HIjuTTiqCdOB4CeacK+nA6aBgRauD5J0+
	 waEsaXo66oI69qMtbphZcc4XXfr6Hn9ckl78Hvs002FW9h1yKVWxBInxIQmU335PpJ
	 RDFGcxvEz8OVM6y+HaVUyFuZNNFMoOPXfbeml3MweguCBDWWmBBOcQVpm3vj62/Ol/
	 DYr3RgIIAmnrMaQfItCCdoxdWhOi5NjsBTR0ueHXeINkyWHLnd0cY7WWYh3T9hEknT
	 ebQeUyNfgC9fQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 0/2] Range tracking for BPF_NEG
Date: Tue, 24 Jun 2025 16:33:26 -0700
Message-ID: <20250624233328.313573-1-song@kernel.org>
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
 .../bpf/progs/verifier_value_ptr_arith.c      |  8 +--
 6 files changed, 102 insertions(+), 11 deletions(-)

--
2.47.1

