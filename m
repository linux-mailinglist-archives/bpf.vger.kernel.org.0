Return-Path: <bpf+bounces-42675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF539A90B3
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 22:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320E51C20E02
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 20:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F191FBC8B;
	Mon, 21 Oct 2024 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iuo1xN94"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BD61F8EEC;
	Mon, 21 Oct 2024 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541592; cv=none; b=ZYwZNnIzvHS8dZV1qCYzYF0QwGaE7tjJ6nDa9OvzjhpNB54Tx3c8Y1XsOA2VRhAbGFiNx1yF+H2or/biDFaTTSWLlq+vR+p9ffYaTg6GWTRR4sNJhAqB4kyV1izjVQ39qsmycClaNJG5wk5T3Kpx+STteBKXyCeAi1/2/mOcc8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541592; c=relaxed/simple;
	bh=5I/+WnSIh7ZTj3Ga0psfjktPdutzjm6moTImzEaKQW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+T0llHnWogz2O5XntWNujAEt0UgtL76qwu/AVeIsYQdIhjNiTqRQXge708wLNLq5XJGb8Fxx7+oPFC7ycephFyPIBC2rLtry/KR4AYQTsBzIMu5Vr4Vsa8nfw/Zc8+vqOf+1MSiUfBtrumRRIwAtrLjf3w2osC5+iH5ZuLYT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iuo1xN94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A743C4CEC3;
	Mon, 21 Oct 2024 20:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729541592;
	bh=5I/+WnSIh7ZTj3Ga0psfjktPdutzjm6moTImzEaKQW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iuo1xN94Rs2Bn2DyDG0QmNr4niT48ZHch9GxgPDRmF7o067lncwie3plP0dtmD6Jz
	 2qEZSmQszFXnlvzMR16Qj0J6FN5g1SHDOfLAq+I7fydMbf6HEEP2NhI2/aYuCR835S
	 1vfX0hBaZr7ByQNDZLZolxSKGFv9Oe7sviLOKBcnp/bf2PSqGfVPH0LnTDNIXiNvRs
	 itXIjyP2kEDM8H7iIzYmwQFLzTw0XaN/ts/Ny3XvbFhTjRpbBcQmhT/1AqPva2ayva
	 /6TTzClNXQOpET+ZTN+v1Y/GHVPpdFnr5FJVEBFK1zxv/3clRnYfNT+md+nDV7WHr0
	 TE9EJQDBLGyKA==
Date: Mon, 21 Oct 2024 10:13:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched-ext: Use correct annotation for strings in kfuncs
Message-ID: <Zxa113xfLj4Dffyk@slm.duckdns.org>
References: <20241021201143.2010388-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021201143.2010388-1-memxor@gmail.com>

On Mon, Oct 21, 2024 at 01:11:43PM -0700, Kumar Kartikeya Dwivedi wrote:
> The sched-ext kfuncs with bstr suffix need to take a string, but that
> requires annotating the parameters with __str suffix, as right now the
> verifier will treat this parameter as a one-byte memory region.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Fixes: 07814a9439a3 ("sched_ext: Print debug dump after an error exit")
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

