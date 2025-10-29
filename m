Return-Path: <bpf+bounces-72863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35217C1CE2D
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 20:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A10189F746
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E42835A14B;
	Wed, 29 Oct 2025 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tQ1CSLgv"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9A4359F96
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764586; cv=none; b=SHuKIuf3yIS7ZwXaMookwK28WqDYj4UY+0sm5IglFu728HIxmhW2DlHrsE6m6JlorfuivzbLUxDKw+5x+fn683mYDJSyqppcTX4/9rwnAX+A3zbtJesC1e7Ru7JjmytNpix/5mQCGoqpvxXnHFI53P62ds/wFlKHx8ugRhB21Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764586; c=relaxed/simple;
	bh=BWW0Wh6Gz1RU5+4+VQ0C/qBHZmmchnqo4g0V3ToPsjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OC3lTsq92GWlJzarP4Tx45+rlxzn9SCmnXVowarF+WvZGY2TQtfOGQdZJvElf9HTaC+G8Ig/unM8yxAV3CNQuQBrLHYsl1yxGJdrwyzIzBu2Y/04r6Q7KqBEcA3P79KvvAt4090AtfIcXpVx/79p8vbks1Y0deKAVkLeNdq1XP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tQ1CSLgv; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pmM+QqxAYzQ0Ex8rQKlGyKdJwhlWLhvgdGRBawkKa4U=;
	b=tQ1CSLgvHfyG0HMiizZ5pW2JHqE74l+rOdKWIITRlvsJwjUKxIXIb9zPyYSTPd0mDCLvdW
	serTCSJcx+q/bb+baVJF2XelUdc2twY3gMfQlYMZkW6ZNHDCX7ajJbvpagh8ufi1DqJPEh
	RpF/TcUJDro6io9NliDwS89PzLSvZ34=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v1 0/3] btf_encoder: support for BPF magic kernel functions
Date: Wed, 29 Oct 2025 12:02:46 -0700
Message-ID: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series implements BTF encoding of BPF kernel functions marked
with KF_MAGIC_ARGS flag in pahole.

The kfunc flag indicates that the arguments of a kfunc with __magic
suffix are implicitly set by the verifier, and so pahole must emit two
functions to BTF:
  * kfunc_impl() with the arguments matching kernel declaration
  * kfunc() with __magic arguments omitted

For more details see relevant patch series for BPF:
"bpf: magic kernel functions"

This series is built upon KF_IMPLICIT_PROG_AUX_ARG support [1],
although the approach changed signifcantly to call it a v2.

[1] https://lore.kernel.org/dwarves/20250924211512.1287298-1-ihor.solodrai@linux.dev/

Ihor Solodrai (3):
  btf_encoder: refactor btf_encoder__add_func_proto
  btf_encoder: factor out btf_encoder__add_bpf_kfunc()
  btf_encoder: support kfuncs with KF_MAGIC_ARGS flag

 btf_encoder.c | 292 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 222 insertions(+), 70 deletions(-)

-- 
2.51.1


