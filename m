Return-Path: <bpf+bounces-56354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B63EA959B0
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 01:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074FC1896FBF
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97DB22B8D5;
	Mon, 21 Apr 2025 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvY33TMN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF3FBA4A;
	Mon, 21 Apr 2025 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745276700; cv=none; b=RQ+08R73Q6G9CpHY32n27SYurPHZCX3xVQtzDUPmpuBGPgcwdpWA4r4yxeQAh+IwkLChUt2gIw9Ft+3fzqZDSQUUTvY1nl3WeQunO/Hfa4tBcGbdVeciFh3iZgQTVTQ+Yv7D5pcrJnvWZvu7qwLpFgq86MLYCno4+omWSvhwD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745276700; c=relaxed/simple;
	bh=MSYcz0q0reBMe686swMNM5aO4qi5W4b7KHGRS+QY/aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOc7c1/qmNk8J4xYkdaUuq54+mLtCvMbuiMszB2VsicfWZCr2m5LclzfIav6d9OBdCfa3OjOmAM5/ic0lPCF93tT6Q6yogMQV+QulKsANmCq2c4UbRpQFlDb+bIAo3DUh8bncP1C/Ru2mdDJUO7rp0O9ceLaABPzCaGb2HQK0Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvY33TMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D726FC4CEE4;
	Mon, 21 Apr 2025 23:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745276699;
	bh=MSYcz0q0reBMe686swMNM5aO4qi5W4b7KHGRS+QY/aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WvY33TMNO+wEQp16zMY+6W6xN63ydpyG9Ot5mdwCkdRl19vOywISNinOtMt0vpXut
	 +nFaBcsyrm8hcYdNKiWnVb1bEKfp3hVL5UMhpr9Gvshp2lyuVTRN9sT/9y1uz/9D4Z
	 HoJdKb3hj5K6p9LD5maq/zxHV96FCnJFAPaIImNM+scY6IRTRniQxDuIgtPgp6m8Jl
	 QiaQIEMCY/QsI4qjYosehKr9mDSLL96fZ8rRUTTW/ctWMwBoUtmRbV0kvBKQ8B9rj5
	 Pcj/8Kjq8mUSuzWpIaZp1KnZ65B9NIGfJF36DE2832Eg2sovg4etplEX6vS4wFKjkG
	 it9XOL0OyGLiQ==
Date: Mon, 21 Apr 2025 16:04:56 -0700
From: Kees Cook <kees@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 20/22] seccomp: passthrough uprobe systemcall
 without filtering
Message-ID: <202504211604.EE9BD62F@keescook>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-21-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421214423.393661-21-jolsa@kernel.org>

On Mon, Apr 21, 2025 at 11:44:20PM +0200, Jiri Olsa wrote:
> Adding uprobe as another exception to the seccomp filter alongside
> with the uretprobe syscall.
> 
> Same as the uretprobe the uprobe syscall is installed by kernel as
> replacement for the breakpoint exception and is limited to x86_64
> arch and isn't expected to ever be supported in i386.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Eyal Birger <eyal.birger@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

<insert standard grumbling>

Going forward, how can we avoid this kind of thing?

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

