Return-Path: <bpf+bounces-72177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 012DCC08B81
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 07:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 947B24F012B
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 05:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40D128E571;
	Sat, 25 Oct 2025 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TYB8E02n"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69A35B121
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761370290; cv=none; b=DMQlGzGeXo310NhiNccGnOaazZHDcpDuH7BPRNmzIYjdKqc7Z7DTrnJawL9xeTLdLUjaRQOCEhwNlO4od7XpNv8nBglqwnUQy3FnzFZ+5oDyVGENLzlqyBFqap/CuOs6zcOHXlmDF/EGazdHuH973/pgNJPmMOo4JxwOQFgDfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761370290; c=relaxed/simple;
	bh=nbLQzAIKWPPzG1B4OQisWVGYbD9gq5/teEWcMvwVEFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mB67N4rwVUZCVlnDzjuzdwRnC4LgZkFN9gxS0VrsqK/eE5rv0qEORB78yb1TGIJgy3RljK+tZu3p4zb6bg46bJWhyX+GvGEPkmNEUjEsS6K5zC8/4HKFp5/xrI84ip1tVnELQ5gtxsJAGfp4VMxyC3uLDjsWhwUyW8M1Cvh3wQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TYB8E02n; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761370284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4GUWRgdM6geYV5MVtICzRgkHX0YuWzP6CfL5chOqQt0=;
	b=TYB8E02nS/qw2QTN6gXyuTSGymgZyX9zRo91/nJx9XA5T4Shg5xqcndeS6j4HWKXTIaPJX
	RXqdHXE+ktko30svX/4SZR7p2QC9QMqdDqNsWm6OhB5qLC6rk6GtXHhpEcucxEzRzb3z4L
	QEaTJxv1gp0UTTyaTG3fREXbQ9CR6V0=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	paul.chaignon@gmail.com,
	m.shachnai@gmail.com,
	harishankar.vishwanathan@gmail.com,
	colin.i.king@gmail.com,
	luis.gerhorst@fau.de,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>
Subject: [PATCH bpf-next v2 0/2] bpf: Skip bounds adjustment for conditional jumps on same register
Date: Sat, 25 Oct 2025 13:30:15 +0800
Message-ID: <20251025053017.2308823-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid verifier bug warning when conditional
 jumps on same register when the register holds a scalar with range.

v2:
 - Enhance is_branch_taken() and is_scalar_branch_taken() to handle
   branch direction computation for same register. (Eduard and Alexei)
 - Update the selftest.

v1:
  https://lore.kernel.org/bpf/20251022164457.1203756-1-kafai.wan@linux.dev/
---
KaFai Wan (2):
  bpf: Skip bounds adjustment for conditional jumps on same register
  selftests/bpf: Add test for BPF_JGT on same register

 kernel/bpf/verifier.c                         | 32 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_bounds.c     | 18 +++++++++++
 2 files changed, 50 insertions(+)

-- 
2.43.0


