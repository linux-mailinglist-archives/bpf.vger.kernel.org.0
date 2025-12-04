Return-Path: <bpf+bounces-76035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DC4CA2B16
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 08:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F349305A3F1
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2E830B507;
	Thu,  4 Dec 2025 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZct1t9E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFE2D3750;
	Thu,  4 Dec 2025 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834750; cv=none; b=B012YNaxouk4+u0rMSJZNh7SPhuRMtHE7PdL7qEwjXQ5+8+5qgjQVEitMqBretp87JGs55RYydkCUsZAu/hZAB20sqNx5Ug41P3ycV8xMfJNQswfB/n0eGDP7i4dfPZodPEwaaWtElN/MzF6UaNO7A7atYF7CilGsqACqeTvqlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834750; c=relaxed/simple;
	bh=iAhVWvBf3zFv4CZsl6smvbicBnnBr996JAw02smUVlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP06gSfVA+2Pj6kbwQVFgr4gZri+NsX38N2owcbGUDfK5kmk1sXrqwegmGXbGz0LLSOkQm3qQaMc7YD/o/0NIAdG6t0u9TEwljwhBVK1aT9fu0WXZAlEth4nKvB3dDiMiA0VEy6evNFQDkugFQPkS+B9jX3iqa7vvO7FEVc4R0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZct1t9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51C2C4CEFB;
	Thu,  4 Dec 2025 07:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764834750;
	bh=iAhVWvBf3zFv4CZsl6smvbicBnnBr996JAw02smUVlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZct1t9EpWE9Oh/lDDiFy/diSrEY8Z6qRwTkq0mu+g+kdswpyRnMceDwjmj9eb+Xk
	 fNDKGClpR/hZBh5KXE7JDwscOLAhL/kvgkGCCnMUabzkuL/q06R4ZVUMgbAg1lKZ7L
	 yoNYzhauFuC74NNVG/UXGY1WcRCYcOUEXAFQgdJ/oS9woTJ3Dqlkijg+wUQXivD7Y0
	 T/mbdhZWId2sHJzT6oFz+yodeKgxJDUFD/FHs+Bcjk8TZNJqxcvFBck8oQlvuchEW4
	 K/MkQzHG1XxwPBVNvuApf8Hg/uX939ral65QZKxlsCn9FoBucbuKGg8gjz4uDme33a
	 7Js3o32Xa/2/g==
Date: Wed, 3 Dec 2025 23:52:26 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/build: Add a feature test for libopenssl
Message-ID: <aTE9uh90UarabZjL@google.com>
References: <20251203232924.1119206-1-namhyung@kernel.org>
 <CAP-5=fU=G75jpsG-X6pa8_rdKapxVc615CqvcdSPBFesj02D6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU=G75jpsG-X6pa8_rdKapxVc615CqvcdSPBFesj02D6A@mail.gmail.com>

Hi Ian,

On Wed, Dec 03, 2025 at 04:34:56PM -0800, Ian Rogers wrote:
> On Wed, Dec 3, 2025 at 3:29 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It's used by bpftool and the kernel build.  Let's add a feature test so
> > that perf can decide what to do based on the availability.
> 
> It seems strange to add a feature test that bpftool is missing and
> then use it only in the perf build. The signing of bpf programs isn't
> something I think we need for skeleton support in perf. I like the
> feature test, could we add it and use it in bpftool? The only two
> functions using openssl appear to be:
> 
>   __u32 register_session_key(const char *key_der_path)
>   int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
> 
> so we can do the whole feature test then #ifdef HAVE_FEATURE... stub
> static inline versions of the functions game?
> 
> Perhaps we only need the bootstrap version of bpftool in perf and we
> can just avoid dependencies that way. Looking at bpftool's build I see
> that sign.o/c with those functions in is part of the bootstrap version
> of bpftool :-(

BPF folks said it's a required library and they don't want to build
without it.

https://lore.kernel.org/linux-perf-users/e44f70bf-8f50-4a4b-97b8-eaf988aabced@kernel.org/

Thanks,
Namhyung


