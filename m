Return-Path: <bpf+bounces-58494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D433ABC7AA
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 21:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA251B652F0
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 19:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB720E6E2;
	Mon, 19 May 2025 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+DZxez0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72367E107;
	Mon, 19 May 2025 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682325; cv=none; b=ZFIyaGJzudsC9syqpn1+VkNOARX3AQ/HT4v0OYYbVGEwGnIeJZSXgxlyuSz7cpgaVhlcnE6XSsZwvOPbk0zu9nPnBTyiFvgE/XSrHnxJ9M/yQt9PLPPQTjiY9Dap23TusgRX0IaxGrK3oz+IF/sr8DWL1khwDlXBU7EazzUzDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682325; c=relaxed/simple;
	bh=bFfpV36kQMKCPale8XoeiutNnEgryD5RS2/aT3AFDjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQcdJLx6mGZaFTzjGpq0tJGJ++oEQmYXJI2OBa8ADx8TJN4MrzapGmz+s9XuPvgLMNN5PIpuiq5TUlrAIcm3uNfMGZmCd+F+DosNvXbh0qE8fzOG6UrK5D4OzipziMDL8m994PWA5hR8rGZECj8JUSn8rKuaAJjnIdJJ2JJd1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+DZxez0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35481C4CEE4;
	Mon, 19 May 2025 19:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747682325;
	bh=bFfpV36kQMKCPale8XoeiutNnEgryD5RS2/aT3AFDjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+DZxez0T/Fbe6nV4JVUZizQmR6M39Ugitaa50NzxYzmUhqe5TKkPNz7IMa7Kp5BT
	 VxRnpJA5Dy94vAXbDOo/tgnPzUOJDs0J7fGG6lMNUsTQHxwudY0RiwZ2EF06Ya4xAd
	 4vuRC4TgK2AWJ/vjKEbpkqT3PriR/drVyURLBmHDU3hzCET1cU3836z/A2LPIQi+UE
	 Q6ytMdoBYBdGjCwSPEtm892OIMM+hJVS9nvtHdZuymmSH3G/ugzRjzsCthMITwg5bv
	 u1f0Xtkt5xmHAV5mxHLzqWvrslc5h8TSu/XjjOTuJRT3M1pGNRPoNEEApVwOjIEZ25
	 /hCxCudaPPC9w==
Date: Mon, 19 May 2025 12:18:42 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Erhard Furtner <erhard_f@mailbox.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: vmalloc: Actually use the in-place vrealloc
 region
Message-ID: <202505191217.B047E005F2@keescook>
References: <20250515214020.work.519-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515214020.work.519-kees@kernel.org>

On Thu, May 15, 2025 at 02:42:14PM -0700, Kees Cook wrote:
> This fixes a performance regression[1] with vrealloc(). This needs to
> get into v6.15, which is where the regression originates, and then it'll
> get backport to the -stable releases as well.

Andrew, can you get these to Linus this week? I can also send them his
way if you'd rather?

-Kees

-- 
Kees Cook

