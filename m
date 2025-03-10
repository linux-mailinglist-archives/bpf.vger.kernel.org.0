Return-Path: <bpf+bounces-53730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C774DA5976C
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 15:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD437A5F47
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE68522D4C0;
	Mon, 10 Mar 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XMItmqxO"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9324922B8BD
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616468; cv=none; b=FzNYMwI4STuVsJviGciG/hvAgldIIn8CflywxR56t8aW20ZUb14nwElQziUxQkw2HUkrFC5P13x5jqP4cnHKiZMPYoRpa8AxaRSY7O37tlZKCSXo1hPJ4or0gkrUPR69RirsjmGdLU6Qr6KJ0zHjho3qSHdb6FHzJz2r280Fce0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616468; c=relaxed/simple;
	bh=aVMorMUiyrSnpjgp/0n5/Fu8Y14PnT/tyqBbuLhoxOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gp5EdSKiCnD4hfXBPrD4GIbvUeekI3zkKkCl47hnV9LHJHZ3z6B18JCHPt8uFqGeIrpQmyyRTGKc+2lY99hFD2FnVNr+3uXAURFbCD245qwK7bhgGf4xmiHIU1hjc6rsyQD3AjoUUn9HoMJhWSnAuaHp1wjGBiz027bths8kIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XMItmqxO; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741616463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tdnaKqRE25Nlj4kRDb0pUzwsk1xxSG4ugbiY1bif4c=;
	b=XMItmqxOZoE/imkSMs4uxBdrASELhaNwUAvEoqEJN+ljWnmDqyd54sMlWQnZSEKlm8Qd4Q
	A71y+ynbhTwx6A8EaZML9rNGngBbG3wIZ/a3pRLPwyQM2Oz9tbOxYxUghq17RDEIr65Fxo
	LenOjJR2TewFTlHjf2zERxkZ86yhlwY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	qmo@kernel.org
Cc: daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
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
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH bpf-next v1 1/2] bpftool: Add -Wformat-signedness flag to detect format errors
Date: Mon, 10 Mar 2025 22:20:36 +0800
Message-ID: <20250310142037.45932-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250310142037.45932-1-jiayuan.chen@linux.dev>
References: <20250310142037.45932-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This commit adds the -Wformat-signedness compiler flag to detect and
prevent printf format errors, where signed or unsigned types are
mismatched with format specifiers. This helps to catch potential issues at
compile-time, ensuring that our code is more robust and reliable. With
this flag, the compiler will now warn about incorrect format strings, such
as using %d with unsigned types or %u with signed types.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/bpf/bpftool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index dd9f3ec84201..d9f3eb51a48f 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -71,7 +71,7 @@ prefix ?= /usr/local
 bash_compdir ?= /usr/share/bash-completion/completions
 
 CFLAGS += -O2
-CFLAGS += -W -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers
+CFLAGS += -W -Wall -Wextra -Wformat-signedness -Wno-unused-parameter -Wno-missing-field-initializers
 CFLAGS += $(filter-out -Wswitch-enum -Wnested-externs,$(EXTRA_WARNINGS))
 CFLAGS += -DPACKAGE='"bpftool"' -D__EXPORTED_HEADERS__ \
 	-I$(or $(OUTPUT),.) \
-- 
2.47.1


