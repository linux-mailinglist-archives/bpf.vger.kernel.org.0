Return-Path: <bpf+bounces-77374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CEBCDA414
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 19:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588E43044BA1
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982B22D0C8F;
	Tue, 23 Dec 2025 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNVcuAQD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F9B145348;
	Tue, 23 Dec 2025 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766513870; cv=none; b=s/ylMa2H8CBKq58jepXHURqorUzKwvPLMu5ojTYNUIlUI6BDYNzIVcRyksXrxDE/+OBM7XR2M19/MAEeGc2WsQ8rd6RFpn/MSTUNyI0DfwGqohLoKfjP+/vF9y4FODT0FJ9KYnE3xasNNYHPL5ICOdEnLSYh15uZlZpR5y3FX74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766513870; c=relaxed/simple;
	bh=qxa2Z6aaX/4/qbcI7Ja2shuIsOq4JDxDWNKGlrZqeoI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C7khrJh6qEQS7mdEYr/3GBuj3724LgTA1h7/NLnyC9Bfo6FVqtc99mdFCKmW3tpVyozBI1ObtwHwD9P3bFjdE5bCZCRiPcC1G748LS334r0C+lGlDXbHtpNnzAhdzKMJwMu+YUU8hb4y8R0CG14pfjHw3Y4clLQyHpOfZKfXOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNVcuAQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE43C113D0;
	Tue, 23 Dec 2025 18:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766513869;
	bh=qxa2Z6aaX/4/qbcI7Ja2shuIsOq4JDxDWNKGlrZqeoI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tNVcuAQD7NPk26LD4Fr7eqUMjcIV+VcLS1pB2VGV0i5/DISRlRredG/xLZrlV7LQL
	 OP8Eu2IK/+JMuXjsI7POAN5SDE482H48fq9xYhaTObyrnyovWZnseHQR2V9tjNybkx
	 1KAPri+DsAiIos3bRhtHwf+IZmn4vlCGj0011QXl6MnwCfBT1CUxRpkYsNUjJqZVwC
	 Ca+OpjQLNhTo9/Q5ta0SxZUji8fOCx+dQwjXkMzISV+8TP4elCXr4eBSf/Sw973PFi
	 eF5GYwS2IAjsCjIPMikCtU6NN/ODdDkCsTIDGoDNwUYZcCFTuOu2zY2LQ+V8i0w8xA
	 SDIYbwIqvVjMw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 bpf@vger.kernel.org
In-Reply-To: <20251203232924.1119206-1-namhyung@kernel.org>
References: <20251203232924.1119206-1-namhyung@kernel.org>
Subject: Re: [PATCH 1/2] tools/build: Add a feature test for libopenssl
Message-Id: <176651386851.34483.15637713722145735287.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 10:17:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 03 Dec 2025 15:29:23 -0800, Namhyung Kim wrote:
> It's used by bpftool and the kernel build.  Let's add a feature test so
> that perf can decide what to do based on the availability.
> 
> 
Applied to perf-tools, thanks!

Best regards,
Namhyung



