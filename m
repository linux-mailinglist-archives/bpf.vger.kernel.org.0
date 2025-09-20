Return-Path: <bpf+bounces-69038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 134C9B8BB97
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7051B2675B
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6FA22578A;
	Sat, 20 Sep 2025 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nutJiE8v"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B44223DCF;
	Sat, 20 Sep 2025 00:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329978; cv=none; b=lUiNjIr0CXtYNGuvzBJmeZQiGZXStMJyVJwjgAYAxaAPyJUxI6qxsYzrtEVgY6e5p3O/MPaOKFPG8d9281KqyKpBOP2hQEz4GdZbJ6IZ//umqHUjQTdc1s8BG6MxG6Kq60UJI1tikVMO4L5K5ePTCon66c8rfxqtpN1jn7ZnwNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329978; c=relaxed/simple;
	bh=PG7649qzgTnimZO0ESCzvakNOlbFx2LGdGUs31BVO00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtWjwKdD8ctK2x91j6rByU8L9hlngc6Q2bN8ovDVymeUqZ8UrpE+Im7pGdh/1txc0Ha0t4mxTjxoNIKLDgIFZdnNKaURnr7MalNPAmJRSxEgvwgaPy4kT4+vMzk+4AHArXJoGHo7ZBTtgpGNUYyRZg7ACNNfwCSJNzJVaBbmXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nutJiE8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C95EC4CEF0;
	Sat, 20 Sep 2025 00:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329978;
	bh=PG7649qzgTnimZO0ESCzvakNOlbFx2LGdGUs31BVO00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nutJiE8vtCrjPO7iBtU23h+Kh07jUp/05W12+B8CgmNoKnZbjb+igmgOAxD+lzRlU
	 PpLPgemKTmGUGCmgzw/Tm+l9XQr7kEb3mMCJ60WxiJ1zMk+UDw6YWxNAtp6UHgujgE
	 EM0eKdwfny57Ih0Hc6kn8YeKXe1NkyY1DEEvcnyLbh1vQ50E0FPAkRuIhs2orDitMh
	 orF9p4mXoDZoTs+g+nD+IcX4AtPX8185zuwqgjjYpO+y3eNAp7AIKjqHsGGTMfVBmD
	 cj9UnRrEB7yUZDQ1jxqNax1xfOFNuUQEiH5EfqJvhHuDKdTLz8x3Wu2CwMeMegFkGV
	 6WeALfMRxdFWg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/46] sched_ext: Use bitfields for boolean warning flags
Date: Fri, 19 Sep 2025 14:58:27 -1000
Message-ID: <20250920005931.2753828-5-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert warned_zero_slice and warned_deprecated_rq in scx_sched struct to
single-bit bitfields to reduce struct size.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 2e289931e567..1a80d01b1f0c 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -871,8 +871,8 @@ struct scx_sched {
 	struct scx_dispatch_q	**global_dsqs;
 	struct scx_sched_pcpu __percpu *pcpu;
 
-	bool			warned_zero_slice;
-	bool			warned_deprecated_rq;
+	bool			warned_zero_slice:1;
+	bool			warned_deprecated_rq:1;
 
 	atomic_t		exit_kind;
 	struct scx_exit_info	*exit_info;
-- 
2.51.0


