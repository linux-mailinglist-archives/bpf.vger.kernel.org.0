Return-Path: <bpf+bounces-70585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EF6BC4502
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 12:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05EFB4EDC1F
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 10:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C922F6184;
	Wed,  8 Oct 2025 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RcSnmZFl"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A0B2E7BDC
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919217; cv=none; b=SqPhh7+eZaig3ihaKBjosM8/0II1u4qLonGbNj7MG8+HtCKo9awtjiY1BiaVuiCVTGhfBgDZq+/KuhpnQzmJ5CsFcXVnEeIsV0QDdTE0pGxh2ANxaTTNmjWb1XumNuIThV0s7ZJnQWuG1w9NdbN5yCkM47HYwOCayqtVQXIn16o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919217; c=relaxed/simple;
	bh=AEFel8Jyuz/acM4rK1Kr9Q7YLMR6GVipoE2WsOQReR4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=X0Hk79uMfFQvt1qtqAQ294r2/iLURsjvQjwdrRp9T4sk0QYhh8rTesfx6LeNxR/049CPY7NhY+0zXz+ecUszLiRqDFpXCa9cnzsHeHfmsb2UWQZ94mKXpQQIg8Jd+HhDrHDrt0owjwHIzSzaFtnLjTUHa4VH7WO7nFPPSpdWTJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RcSnmZFl; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759919202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g6KcRE+7jq80YyojGjcpCzmM0DGnxx2JGBpTmSjkJUM=;
	b=RcSnmZFl17t/tG5HV3zY0RGJUPLeSikcyFaU03nYTXtQes6lCzUELJg207w0XPfMz4CHcH
	/68451It8zsEjMo/7eOXhISNnXMcUB1EFWrby2hSXnK7eJRknPUVJgYNWGwSi6qgXepnsp
	XAcqKloTYrnAZhgATz6Xl3/+3wwOFQU=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	toke@redhat.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 0/2] bpf: Avoid RCU context warning when unpinning htab with internal structs
Date: Wed,  8 Oct 2025 18:26:25 +0800
Message-ID: <20251008102628.808045-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This small patchset is about avoid RCU context warning when unpinning
htab with internal structs (timer, workqueue, or task_work).

v3:
  - fix nit (Yonghong Song)
  - add Acked-by: Yonghong Song <yonghong.song@linux.dev>

v2:
  - rename bpf_free_inode() to bpf_destroy_inode() (Andrii)
 https://lore.kernel.org/all/20251007012235.755853-1-kafai.wan@linux.dev/

v1:
 https://lore.kernel.org/all/20251003084528.502518-1-kafai.wan@linux.dev/

---
KaFai Wan (2):
  bpf: Avoid RCU context warning when unpinning htab with internal
    structs
  selftests/bpf: Add test for unpinning htab with internal timer struct

 kernel/bpf/inode.c                            |  4 +--
 .../selftests/bpf/prog_tests/pinning_htab.c   | 36 +++++++++++++++++++
 .../selftests/bpf/progs/test_pinning_htab.c   | 25 +++++++++++++
 3 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_pinning_htab.c

-- 
2.43.0


