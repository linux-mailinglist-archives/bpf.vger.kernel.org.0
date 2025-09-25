Return-Path: <bpf+bounces-69703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0208CB9EC86
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 12:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6077E16F2AA
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5F2F9D95;
	Thu, 25 Sep 2025 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvgxOavW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E52EA75D;
	Thu, 25 Sep 2025 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796965; cv=none; b=DyaaTQxCHGr+CYcDECr9O4wBmWtGYCtZcVd8U0bEgwM9rHeIbNOw/NKlUR9azBqwVF51hYdoABropa3l5iR1+hFJL789r9voOQoHCB9ZdGLjf8rfeBAsnReG3tXB/A+BJO9cs/Kc4ZcLoR6QyhNXwyx6E6+BA+4b41d89JO9YoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796965; c=relaxed/simple;
	bh=u7U036YsC/tIgi4yAuDO4E7PAwS1xrqPfbasQ3Ujv/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOgQgnj9kN59y67Xzlw5dC4Sm9wHtz7Dxs/D3eUYzZz3nId+gZEfNYRPAjf/5AxVfGuxI4CVe9/xDLY1iAQoP0JTYveKmSdWFT7WnEYk2cF79W35rAy6/m7GzMNMeYEEEag7v2z3c9h6p0P/EtIAmjnjF4TIIpApAfmiTA2ccZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvgxOavW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F94C4CEF0;
	Thu, 25 Sep 2025 10:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796964;
	bh=u7U036YsC/tIgi4yAuDO4E7PAwS1xrqPfbasQ3Ujv/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mvgxOavWfD6J4ad9MTct4h8LxkO2Guaq6oV6qdIL8WtJJ4A2XtpXe2LDojmrgZvWL
	 bffdvw0+5uQ9ni6ma+SAzYm/e78N9pKeYo8OpXx1nJXdSivdVOAtmF91Ujw1Sf4C6x
	 w+VLvkS8Cae3q5EDULHiOy/dHEhDX1kVj+DM72LAf3eBnOgiDyW2A8a9CYn7eDEWw4
	 Q3slXhA8GCrgRKj5smw4f8zEqkVnOage9LNOZx6aeFmOqbnh0Po2pNMNZgGmSpXFKG
	 rDYAe5pnd9mgaWeCTqC3hKrU2J4HOx6JzQ8PQhcI97WTqoPEHHpg5f0PNawvzuMTyR
	 UaywVVAN+uMgA==
Message-ID: <52fe87ef-0797-4cf1-9e70-dc218f904e77@kernel.org>
Date: Thu, 25 Sep 2025 11:42:39 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] bpftool: Conditionally add -Wformat-signedness flag
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 llvm@lists.linux.dev, bpf@vger.kernel.org
References: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com>
 <20250925-perf_build_android_ndk-v1-3-8b35aadde3dc@arm.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250925-perf_build_android_ndk-v1-3-8b35aadde3dc@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-25 11:26 UTC+0100 ~ Leo Yan <leo.yan@arm.com>
> clang-18.1.3 on Ubuntu 24.04.2 reports warning:
> 
>   warning: unknown warning option '-Wformat-signedness' [-Wunknown-warning-option]
> 
> Conditionally add the option only when it is supported by compiler.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>


Hi, how annoying is this warning? I'm asking because as far as I
understand, the option has been introduced in LLVM 19.1.0 [0] - the
latest being 21.1.0 already - so we won't need this check once distros
have transitioned, and I'm a bit reluctant to add it.

Quentin


[0]
https://github.com/llvm/llvm-project/commit/ea92b1f9d0fc31f1fd97ad04eb0412003a37cb0d

