Return-Path: <bpf+bounces-33988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A506592921D
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 11:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445F51F21A19
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D074D8C1;
	Sat,  6 Jul 2024 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSS6ywWG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4F5695;
	Sat,  6 Jul 2024 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720256578; cv=none; b=aNKnQrxn6UjA5WHryllyzkYNTz4CE4PkBjDjgJd7sCXxBkNZ9lRd1upbcNaDhR/rBt8KVJg0M8IkRIIF9JbO5x9Py8FRD6gnfJ1U9Q3ZmEAq2kyNh2lUCsKlLZz3VaAF4Ez1pE2q8NzugyguU+LdrrAZSuU2F+E53oVF2CHX1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720256578; c=relaxed/simple;
	bh=X4mPycFhWcc4FxPxIbLHKRt3pmtyzYPRqFdUa43qLlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFebdlVgUueI2oAxJgAPKwrDBNzeIt+AO+N9BzMKwspHLB3YtgL/AOHzhVWrryUuwCw0BFlTM+zySF0pMABKU3SpWb3cfBmGKtaFqrP8W+eHFTL7gaxGkHjeI7+qvTndFl6pUFCLtJJ2hOAsrCsg1YFe1yhRfS/jmvgmxc4H1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSS6ywWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD49C32786;
	Sat,  6 Jul 2024 09:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720256578;
	bh=X4mPycFhWcc4FxPxIbLHKRt3pmtyzYPRqFdUa43qLlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSS6ywWGgb0Ea+R4G2yaTTOHSoXjhmTJCA3KIaX3HyEC9pyKLFFp/dvoSySovZWvB
	 lekwROFvwbwim4BgJq3P14ztxo8WyqtNrQvHVzb1z5QAYpM40rZ7y+6h+o8pTP5sLY
	 VmhFOykpB5XCpoHV5qwSZyhX2KBI9Lj/NhsyvlhMEDyAAMT63NBGv61g+ucb+qZW7U
	 2ypC/M2sVT8rYxozuVSgo6LKVn5YnSO3EGMfIDAlstXWZiIfIL4SdtvbJ966+1QH2y
	 FOYy1zEDV/bKZwZDegW7ny9jqBmNALTRV68yWpUS7p76y8/WkPu3ELN5FwAB4xzY3J
	 6jsZjjvCPgbLA==
Date: Sat, 6 Jul 2024 11:02:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: remove unnecessary loop in
 task_file_seq_get_next()
Message-ID: <20240706-mitnichten-wolfsrudel-53235d096460@brauner>
References: <ZoWJF51D4zWb6f5t@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZoWJF51D4zWb6f5t@stanley.mountain>

On Thu, Jul 04, 2024 at 10:19:19AM GMT, Dan Carpenter wrote:
> After commit 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU") this
> loop always iterates exactly one time.  Delete the for statement and pull
> the code in a tab.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

