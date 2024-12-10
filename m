Return-Path: <bpf+bounces-46554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 473349EB9FE
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 20:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38472832BD
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C74224AEB;
	Tue, 10 Dec 2024 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+5QdI2i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102723ED63;
	Tue, 10 Dec 2024 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858356; cv=none; b=e0WqpQzOxhNDFxNX8ZTKBwr8bUexGyKEo9qTGF6BK4/XJgBKML3F5wP+vJdm1s4axFv2JwykcRmpLJEmHICnxCAvPc8Tia2TmAHcGUuy8CtxvPuxkIkd+dcUfXleWv6q8fs7X+hTyhf7YIho0ax4csp1SA7GvoM1TQdc4aYkvZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858356; c=relaxed/simple;
	bh=f/2I2NEjWuoNBz7QcMvWTkLzTyI64hz2Jn6DzQBMHBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmUIQG5QXHsRwY9i2G3NeV6lAp4NJqbT5RG7DA5SQ/QN1X3R/J1eKJM7o2cfhWY4bCAkPBDCorGAPlEF1BY7mH5QvKEU3FtDBYIR66FyaIpZ7Ul/Ikrx7nidMGlDEN5KEWeAvzVD7BAYCS7p8yyiDSn0evGLuKkSCciTtea71xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+5QdI2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AD7C4CED6;
	Tue, 10 Dec 2024 19:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858356;
	bh=f/2I2NEjWuoNBz7QcMvWTkLzTyI64hz2Jn6DzQBMHBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+5QdI2i/0/QraX8s9l7QZlVNz7fiaV1GkkSzpwL+OcMKg2nNFMOFpl6tTf0Upcuc
	 3owPwlqOeSkhK2yp6yAllMJ45AFigGVbmhTKRMBkDVSfD4Eh/WvzoTfgna1NFjbjKX
	 JZUCcAJzwtTY/a1YqzLmQahy09wQjcMvnBBa7wCitSd/G0SYNN64TA/0eLnuomcWJ/
	 KtqLkYznqp5js25QuYpfVP1h22IMm6CmhIrmMCl+wnsGk6CabJ8+xcPORd/smj8vGB
	 8mNqS64z5OmItDL11IjLnbPdyPFin7/NC2utEg2IpkZZr7ac/J4/PzyVGDPbsByDhT
	 KRrCkORVweABg==
Date: Tue, 10 Dec 2024 16:19:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, song@kernel.org, james.clark@linaro.org,
	yangyicong@hisilicon.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/3] perf tool: Fix multiple memory leakages
Message-ID: <Z1iUMnlQp98XCIZG@x1>
References: <20241205084500.823660-1-quic_zhonhan@quicinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205084500.823660-1-quic_zhonhan@quicinc.com>

On Thu, Dec 05, 2024 at 04:44:57PM +0800, Zhongqiu Han wrote:
> Zhongqiu Han (3):
>   perf header: Fix one memory leakage in process_bpf_btf()
>   perf header: Fix one memory leakage in process_bpf_prog_info()
>   perf bpf: Fix two memory leakages when calling
>     perf_env__insert_bpf_prog_info()

Thanks, applied to perf-tools-next,

- Arnaldo

