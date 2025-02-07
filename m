Return-Path: <bpf+bounces-50729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8E9A2B8B8
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 03:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2350D3A8130
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 02:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6B9156678;
	Fri,  7 Feb 2025 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mc9U3B3J"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F4E1632FE
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894510; cv=none; b=PYlJbLlM3eSQfd1K0Re9k4A+6gBp6zi5TrDLIHP7wi5OPQtNC02XO1kYjuBUqnFuc/BKMzl0YUKFCLZnFAIwhAQnUMv0g0cw6scuPp9CMQs3eKdDrwpfrqTUVs2ghTrfsM4BDFe1IcB7RfOdV1ZIdTdVjo5fjRUHH3ijbJdtNDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894510; c=relaxed/simple;
	bh=tHWxYTXXghS8lUNHhvRCHiXiHYTiapfFlzJ3GpeJMu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ce1tt1wJb26zhO6u/0IH66wNRzRDEhWY4ZpFt3YvW7D4RLdFHl2Yc33VdqLYMK6xNUyeyL8Cn8pO36YO7GdItYh7bm8p4Z2XXCcJj9D/+DNWoBWz/dY7hKruYjQ6Qm9eQWoeHGjcqaYe++xDjDjoyfqHamucUrKURVmZ6X48sdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mc9U3B3J; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738894496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ufOzeXDANJk02xtsuzgAdHSpbbZFi3WmezQKBuPU3jA=;
	b=Mc9U3B3JaoY/unvV/3N9kN/KuxNbvm6MII+2kdQ9jSS0b5hlOMnvRe8M9BC8/GADAz6TbT
	1EQThhpvoK5ITq8OiaGDtd88xoNFdyvG9k47leJoochZpsknZQAypdpMnfkE7CPQ/PgQBo
	xFsOqRC9Z2I2V+5fEUnjwKnQwc8oQ7I=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Cc: acme@kernel.org,
	alan.maguire@oracle.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH dwarves 0/3] btf_encoder: emit type tags for bpf_arena pointers
Date: Thu,  6 Feb 2025 18:14:39 -0800
Message-ID: <20250207021442.155703-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series implements emitting appropriate BTF type tags for
argument and return types of kfuncs marked with KF_ARENA_* flags.

For additional context see the description of BPF patch
"bpf: define KF_ARENA_* flags for bpf_arena kfuncs" [1].

The feature depends on recent changes in libbpf [2].

[1] https://lore.kernel.org/bpf/20250206003148.2308659-1-ihor.solodrai@linux.dev/
[2] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/

Ihor Solodrai (3):
  btf_encoder: collect kfuncs info in btf_encoder__new
  btf_encoder: emit type tags for bpf_arena pointers
  pahole: introduce --btf_feature=attributes

 btf_encoder.c | 190 ++++++++++++++++++++++++++++++++++++++++++++------
 dwarves.h     |   1 +
 pahole.c      |  11 +++
 3 files changed, 179 insertions(+), 23 deletions(-)

-- 
2.48.1


