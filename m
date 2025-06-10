Return-Path: <bpf+bounces-60222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53642AD420C
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 20:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494807A9683
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 18:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96464248886;
	Tue, 10 Jun 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9CKi5UK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A50F248861;
	Tue, 10 Jun 2025 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749580741; cv=none; b=k77L6PbByDzMpNVKXdt9tFEoeAWMLQBDJ+BxlwF5AHeCwL/xQ7NceGyCv8qpHYiqlt9ew0E3s7FfdMXtaQdep9G0O77zwmP4A+vqL3acTWGx95BZzwe0sTqAwPxTGLXTyxC+2LNXFpXO/Z6ogyxpBrBCLZcwcj2NMG1cPamXLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749580741; c=relaxed/simple;
	bh=GVfj29xrQrCzqueEAOo8sbZYSlXB8tV84v6/TlLCBkE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RdlW0xO/xGl1yTVd1M3IoRBgn/gT7SKxQi2rMTukInZfq9C6Ff+gRoKAiCHpMfME2C7cNh/qFhCqeAupgoLb97Nndl6jyoJX8vDIjg85yG5U2srljyA+i1XPFoCoJSrQSs/XzdGu7YWp4Jvs4VtDxlPZjengmk5ujQ9w/RZdu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9CKi5UK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F539C4CEF0;
	Tue, 10 Jun 2025 18:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749580740;
	bh=GVfj29xrQrCzqueEAOo8sbZYSlXB8tV84v6/TlLCBkE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=A9CKi5UKATuBoM0F267Jwdr79ENixbhNqJBnXiR4T6yK2ySHXYf97TZ8WLahXvV7o
	 XNsHep7gYPTJogvRlN4wmd6MRjRdD8HZ1MdjMS7DY2PnRmxO+HBPWbljJmh48VYu4P
	 n2A1Z7CFGiATkzbU8gSHw5utBXx7i5rGhz+YIDQ5f4pNMTMTiQvN7Hn/267I1AkiJJ
	 y3Ofr7+2ixfAf0r+Jcz2s+0AN5ISYQTKg0a4YTXBeuNWAJ35wcLb0EaJIIAOgm5bvZ
	 13FUBDr6lPUpcARtcWlSPbLzC9JbULHfp2D+Bn/gtaM2WIs7BgUudtsn9dka2eIqk9
	 ARLTsVE45NEug==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
 Quentin Monnet <qmo@kernel.org>, James Clark <james.clark@linaro.org>, 
 Tomas Glozar <tglozar@redhat.com>, 
 "Steinar H. Gunderson" <sesse@google.com>, 
 Guilherme Amadio <amadio@gentoo.org>, Leo Yan <leo.yan@arm.com>, 
 Yang Jihong <yangjihong@bytedance.com>, 
 Charlie Jenkins <charlie@rivosinc.com>, Jiri Olsa <jolsa@kernel.org>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250603221358.2562167-1-irogers@google.com>
References: <20250603221358.2562167-1-irogers@google.com>
Subject: Re: [PATCH v1] tools/build: Remove some unused libbpf pre-1.0
 feature test logic
Message-Id: <174958074028.4039944.11387595303056622807.b4-ty@kernel.org>
Date: Tue, 10 Jun 2025 11:39:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 03 Jun 2025 15:13:58 -0700, Ian Rogers wrote:
> Commit 76a97cf2e169 ("perf build: Remove libbpf pre-1.0 feature
> tests") removed the libbpf feature test logic used by perf in favor of
> using LIBBPF_MAJOR_VERSION. Remove some build targets that should have
> been removed as part of that clean up.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



