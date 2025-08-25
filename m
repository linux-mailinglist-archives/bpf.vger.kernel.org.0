Return-Path: <bpf+bounces-66474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54228B34F65
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2D05E7BF3
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2532C15A5;
	Mon, 25 Aug 2025 22:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye53pHRO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBAB2BE7A7;
	Mon, 25 Aug 2025 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162695; cv=none; b=nZ5RyDwUwvMFz88PPvaq5V3A4LwFYOiIcSCSnakDc8w8JuMWVd1us7s7a7lsEDIenyTP/G4noLByF0RquDd6PaZLg8qMVrFWHb+LRkTbpLABvUfQo3j1Z7TUmOe8k7rvr0pZ/DZkCASkru5KXSGpN/WUXRbFkGQpXmluq7poQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162695; c=relaxed/simple;
	bh=nEd2B7JtJ8bxxbHtSu23HrxgYmnmojifSFLn9AVabU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Abn8PAYSPrApbO/kmKJqwIyHFapdCywHSG23SBHyH4+3R4QTUL7+AkjuNKT22U79YCOax4Jb9ypJGfTqfloxxz++vNGwmFxrcGUrHQWcSPVl8JB2JtPK4Frs3yt6yXIHJc/C5MfVa/njrqUnko/3hxyGaalPw7OL6hD6ejFL9t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye53pHRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE03C4CEED;
	Mon, 25 Aug 2025 22:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756162694;
	bh=nEd2B7JtJ8bxxbHtSu23HrxgYmnmojifSFLn9AVabU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ye53pHROPXTburcqsrLkLRLeOTkKZ8E5jM71PeZztPNCEZXtNr742fAawYJtB7f8W
	 gEzc5YrTh0Sv50aWRrna+/vbRNCoN+0/1/H/ikj0ne8r/R70HBCKy3056vsVd+d5fC
	 D1fTWi3yMH/n7cdxFzK5pFUXxCqr2E/NOaHlnG0VoO21IwmVbPcYFOjTFLGNVA0ggr
	 iD8O9A3GFe2zxc4Dd4rBTDXz4e8JPpgI2wMlJrL1SYY8Ydhu7g/0pfppzv0H0kmTeQ
	 AKCxBsjeZKf5GKM28hQblYEPQg0Zm0wDA8ogwMZUr6Hvy7I6/pmC11yxPs5eEH5SAo
	 1wNLl6DbZyEEQ==
Date: Mon, 25 Aug 2025 15:58:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, mohsin.bashr@gmail.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maciej.fijalkowski@intel.com, kernel-team@meta.com
Subject: Re: [RFC bpf-next v1 3/7] bpf: Support pulling non-linear xdp data
Message-ID: <20250825155813.763d2a59@kernel.org>
In-Reply-To: <aKznqjd1aowjxJfK@mini-arch>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
	<20250825193918.3445531-4-ameryhung@gmail.com>
	<aKzVsZ0D53rhOhQe@mini-arch>
	<CAMB2axOkPx=5vseNXbwQtHQTFhdur6OSZ-HbNPUciwBmubQa1w@mail.gmail.com>
	<aKznqjd1aowjxJfK@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 15:46:02 -0700 Stanislav Fomichev wrote:
> > > skb_frag_address can return NULL for unreadable frags.  
> > 
> > Is it safe to assume that drivers will ensure frags to be readable? It
> > seems at least mlx5 does.
> > 
> > I did a quick check and found other xdp kfuncs using
> > skb_frag_address() without checking the return.  
> 
> The unreadable frags will always be unredabale to the host. This is TCP
> device memory, the memory on the accelerators that is not mapped onto
> the CPU. Any attempts to read that memory should gracefully error out.
> 
> Can you also pls fix that other one? (not as part of the series should
> be ok)

But we don't support mixing XDP with unreadable mem today.
Is the concern just for future proofing?

