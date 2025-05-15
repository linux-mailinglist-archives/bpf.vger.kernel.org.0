Return-Path: <bpf+bounces-58331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B261CAB8CD6
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 18:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C64E16AC3B
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A73253F03;
	Thu, 15 May 2025 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfFRvaw8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C792B72638;
	Thu, 15 May 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327878; cv=none; b=LkPk3a7rPtGlT140SJMRMBF5RgzqmROK3Ao4m+3ycD3mH0V/VNn3MsqB4rcdrqOPEptzF+H2jDYim6xsCE1g30d6/mQSvT59cJFWR9HZFNvb9/ThjSLGeFliCDiVItWtnpVnWd2owYBVEvJp1WufVWrheeFZe8AWPNGm//ttnys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327878; c=relaxed/simple;
	bh=hhlOPM7z4HIlZKpReWFs9EedymGfWrq/M8vBY5bja1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjpS15jqzDLHw9rTJRouBOtWaSmWMNQJm63I7hKRWRsgn/u+xItyV7meFGXpthcAbOL80c7h0F/N6aGGoxnU/NdlSU9qMOxisSMtjZC576CUH+KVn6H1EeS4PEKSzmWDF4gh8q2biSahtXmdGfQaHnBf5WQYSqkdNKPAGUtMayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfFRvaw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3914AC4CEE7;
	Thu, 15 May 2025 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747327878;
	bh=hhlOPM7z4HIlZKpReWFs9EedymGfWrq/M8vBY5bja1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfFRvaw8pSJ2bcnJ42P3i0JZeLvyG+YvmakQgap00p7KY8c0dorb3I0wczZX86LMp
	 FCWpLVGBCyAOezr+FwpI8/r9F+O7Nar6XNh2/Mh7f0L1fFIkjlak+UJ8K6K4kHzxIA
	 XNkmMFSgh0lsFElmtyRTolr3vz9RuaUFC2Hg5xjSSxBJNoBq2pDk4u938G9lGgmJYe
	 5x+mfu96WBJap32k8lr2t/0Fr7xFyuOUtlTQYy/WWwAx7CAq0EYVSduMQfCfykyaNx
	 JmNiVNotH7Vrhz7WSJIzrVyNYsTeDvhZLepCnspCYUwOia9xVFZiD0Bpk8+uLYwDP/
	 j9tj1B4H9RIJA==
Date: Thu, 15 May 2025 09:51:15 -0700
From: Kees Cook <kees@kernel.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [REGRESSION] bpf verifier slowdown due to vrealloc() change
 since 6.15-rc6
Message-ID: <202505150911.1254C695D@keescook>
References: <20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
 <C66C764E-C898-457D-93F0-A680983707F0@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C66C764E-C898-457D-93F0-A680983707F0@kernel.org>

On Thu, May 15, 2025 at 07:51:26AM -0700, Kees Cook wrote:
> On May 15, 2025 6:12:25 AM PDT, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >There is an observable slowdown when running BPF selftests on 6.15-rc6
> >kernel[1] built with tools/testing/selftests/bpf/{config,config.x86_64}.
> [...]
> Where can I find the .config for the slow runs?

Oops, I can read. :) Doing a build now...

> And how do I run the test myself directly?

I found:
https://docs.kernel.org/bpf/bpf_devel_QA.html

But it doesn't seem to cover a bunch of stuff (no way to prebuild the
tests, no info on building the test modules).

This seems to be needed:

make O=regression-bug -C tools/testing/selftests/bpf/test_kmods

But then the booted kernel doesn't load it (missing signatures?)

Anyway, I'll keep digging...

-- 
Kees Cook

