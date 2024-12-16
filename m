Return-Path: <bpf+bounces-47035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCEC9F2F09
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 12:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED9D1882F1F
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 11:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7B2204573;
	Mon, 16 Dec 2024 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFpjYKin"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDBB20100C;
	Mon, 16 Dec 2024 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348215; cv=none; b=U7ak1lMlWHAimsQ3mzvA9n+4joF/PUr4fnNJQ+loR45bQkovqsWyob+jmvvdpmeBYQ7E5aPpH7XKttOkrcw0Te63B6ab/RfliJ3V80W3t4tgJytsRTqlaobSQRGXj/hsU8Ly2+tRuJ+gzVSnQgmEgsbGU3bv6c9BYlfOUC4KQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348215; c=relaxed/simple;
	bh=a+8v+fuwd8dw9g2lGEMgITHzsDDNppuzd2b4d2wGLss=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BjGJZEBLwmdIUtD3ubU+Tkg1p/OB5Fn4emvJi5sNS6WnMbyiSUAk2jDccVm8Bz7koaKh53idE3JHni0NKI7F6JarLofC6WeeeVGnFw9EwG89odN0oxXNexlThEGY8fFDFbXLEvv+g4rZxTybp1DxLodUe9vLw1QKNKU8fq0fQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFpjYKin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189FDC4CED0;
	Mon, 16 Dec 2024 11:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734348214;
	bh=a+8v+fuwd8dw9g2lGEMgITHzsDDNppuzd2b4d2wGLss=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=VFpjYKinpVL/5vV/gJlmV5q/9cdhf0EgGASLoKB6f6WoHzGYrXlJrVcNnMkyouulB
	 EVkWqAEthfRfo8zSmuUiuSMbH0vmV7KoCZRYxVen3DNycbOhhkyGy9Op0MpSEOz1uw
	 6xBEA4Odd1+q4RGhgP/DTVGXWxFxnQMUx5XwV8GdtSWmpKqZb0mRFTVDJSzTxdh9uD
	 +lQwGt8WnYHspXSQpyOFJUV3rt8grkYegXN3e56+TbUpU4OyY9ief0UYCx8kS8WOgO
	 kg3Lc96A+HHHfgX5zkARk1X60t2joAJNLkfT5mZnjnwenJ5fcbamFMGBVi5/uWZVmP
	 p8j0F1zrCdfDg==
Message-ID: <fa534569-b3e0-486d-a0f9-25523f404aed@kernel.org>
Date: Mon, 16 Dec 2024 11:23:29 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] bpftool: Link zstd lib required by libelf
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>, Guilherme Amadio <amadio@gentoo.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20241215221223.293205-1-leo.yan@arm.com>
 <20241215221223.293205-4-leo.yan@arm.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241215221223.293205-4-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-12-15 22:12 UTC+0000 ~ Leo Yan <leo.yan@arm.com>
> When the feature libelf-zstd is detected, the zstd lib is required by
> libelf.  Link the zstd lib in this case.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thank you! And thanks for the updated commit description in your first
patch, looks great.

Quentin

