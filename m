Return-Path: <bpf+bounces-61696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35687AEA491
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 19:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE533B0B95
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA5B2EE26B;
	Thu, 26 Jun 2025 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6AZy5kk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB172ED842;
	Thu, 26 Jun 2025 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750959686; cv=none; b=e4tXNaKzUK1vTEOhEjhCB5igk8wP5tzZ0I3tw/U+nb32VkKcmuHTRegy5GPYxU4bT28RIzYB4RGjIckTLpIDvjUiurM0R46jOa7IRX/PpVP4u08tzsTIX4VU2dygNBoRP7LLJ5XqSJ3ERlpwtRpDbbvJtD6ZFA2w8c3Faw0nIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750959686; c=relaxed/simple;
	bh=HebmZL2Z3HETRCiyspKgxFuTZe15p2NjHFFkia4DbdE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VETraUDSJ9Ke+AJmIypUjMRsSt4Pv0BTyAe4NAX96NW34eZDvXuNKf0ZwHQzabV3rIiV1Oa8rv6lQ9QDJnRqbtDKznAc6P5KpybIA5kBwB0RYVOCtzvIUz6r4s1TnjcJPlQmGt7f5ssoQkFnmKb5VQxCBOpeITPyKba72GfMn8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6AZy5kk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B672FC4CEEB;
	Thu, 26 Jun 2025 17:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750959686;
	bh=HebmZL2Z3HETRCiyspKgxFuTZe15p2NjHFFkia4DbdE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=r6AZy5kkRmmObE8sYuKKVMBMMtfV6LzsWTGIdB+Aybv2L0b/OSWJ0qEmmZMFNf629
	 SfishkJiy/actyvV+lVrSIONrhfxsh+SFHkkwvakcC5zUl45kHLuGnLBEfc7HLEiqH
	 QwMR7MhLT1c4SP1vL9df0vl5Kgz65dD900TkQSMAEUC9Uv+/AgAh2AqaTfXBJBTKXI
	 eVCGVIWqHuO0ZILyRAIdvhk5oUtZTZiHhjKxZnRIUL61ZKzUPtyNB4mAtXS/gmwJGw
	 Qy9FofRvqrVwC5h3wIOtZkAQrMZ895dSkkoAP4Gz5zLpU4OvuGnpfZXWNYGefrtfuU
	 44/5KVwHUTEpQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
 Howard Chu <howardchu95@gmail.com>
In-Reply-To: <20250623225721.21553-1-namhyung@kernel.org>
References: <20250623225721.21553-1-namhyung@kernel.org>
Subject: Re: [PATCH v2] perf trace: Split BPF skel code to
 util/bpf_trace_augment.c
Message-Id: <175095968570.2045399.17117196657041897009.b4-ty@kernel.org>
Date: Thu, 26 Jun 2025 10:41:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 23 Jun 2025 15:57:21 -0700, Namhyung Kim wrote:
> And make builtin-trace.c less conditional.  Dummy functions will be
> called when BUILD_BPF_SKEL=0 is used.  This makes the builtin-trace.c
> slightly smaller and simpler by removing the skeleton and its helpers.
> 
> The conditional guard of trace__init_syscalls_bpf_prog_array_maps() is
> changed from the HAVE_BPF_SKEL to HAVE_LIBBPF_SUPPORT as it doesn't
> have a skeleton in the code directly.  And a dummy function is added so
> that it can be called unconditionally.  The function will succeed only
> if the both conditions are true.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



