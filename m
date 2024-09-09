Return-Path: <bpf+bounces-39341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B297224E
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 21:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F4028425D
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 19:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBFD17588;
	Mon,  9 Sep 2024 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKWJNlbp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3797188CC8;
	Mon,  9 Sep 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908674; cv=none; b=D+HEncAzoWOLsIAdFv8lbJdx9KKaIPHd2jYMF0TG42VJKpy4JXVnOQodHo+hQXHmPptbD+yKOu4E6mvKFjBgBkqUSICm85vXhxdYQDEdK+ZHkJptdAlmFs1lsNKgpKnhaT5cp6+kUpAY4tXIK8IGKeSQFWA+azVq1xspFhkD+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908674; c=relaxed/simple;
	bh=RAY+RZcuHomsSGFISszKdVRLeO9WN27ZaWTimUnKDEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/K7601M8yEDCE39oJBfePek726rn0XbTO2m/zGf3trW5RQ5ptjQa5Q2OMtEk+ure0itSJxkJwDA7XQU1GiIzFbe3rQh5qp5pre68G5rxMewwZl1+zgcbBgtQxG927LacMJ8YuLTm4sbAS9QoXTfL3ttlPuaF55cCPzGPY2pnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKWJNlbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0B4C4CEC5;
	Mon,  9 Sep 2024 19:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725908673;
	bh=RAY+RZcuHomsSGFISszKdVRLeO9WN27ZaWTimUnKDEQ=;
	h=From:To:Cc:Subject:Date:From;
	b=CKWJNlbpuJ3eefYyZgHMobwxY/9Eo39l3wh4flNv5U3BvI9DnlyCflL1H2chKZSi1
	 sKUiWQ7eF09ym8hoHc/XTkoc5+aUfwhV9UHtR/wve65/hPnmDR3+SY+kuH9S5OeqnN
	 MdwKaiLEzmUkNJnYZesZA/KSId6zRC/XXiQbHMHxgnccFgASfvSajr041xdLZXdSJG
	 m8+KV4HcVoOzx5pszz7LowKPfqP5FbfKaFffDa0hmOfQ/fdgba5yMt2dQrqeTay1z6
	 Oq0Qb5a4WG9ogGtRVoexaKaemfFJCAm4IWUzHU12lCaIqzPgFYSOzsf0ljMh/R+Iq9
	 /A34IV+CeLXSA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: akpm@linux-foundation.org,
	linux-perf-users@vger.kernel.org,
	jolsa@kernel.org,
	song@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next] MAINTAINERS: record lib/buildid.c as owned by BPF subsystem
Date: Mon,  9 Sep 2024 12:04:26 -0700
Message-ID: <20240909190426.2229940-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Build ID fetching code originated from ([0]), and is still both owned
and heavily relied upon by BPF subsystem.

Fix the original omission in [0] to record this fact in MAINTAINERS.

  [0] bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..a86834bb4c25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4098,6 +4098,7 @@ F:	include/uapi/linux/btf*
 F:	include/uapi/linux/filter.h
 F:	kernel/bpf/
 F:	kernel/trace/bpf_trace.c
+F:	lib/buildid.c
 F:	lib/test_bpf.c
 F:	net/bpf/
 F:	net/core/filter.c
@@ -4218,6 +4219,7 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	kernel/bpf/stackmap.c
 F:	kernel/trace/bpf_trace.c
+F:	lib/buildid.c
 
 BROADCOM ASP 2.0 ETHERNET DRIVER
 M:	Justin Chen <justin.chen@broadcom.com>
-- 
2.43.5


