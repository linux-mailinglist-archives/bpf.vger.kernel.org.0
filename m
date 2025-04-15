Return-Path: <bpf+bounces-55950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CD1A89F3D
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 15:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A7916EC32
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 13:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F33297A67;
	Tue, 15 Apr 2025 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bsa+x95C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFB22973A0;
	Tue, 15 Apr 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723169; cv=none; b=WnhZnks6lEZsgwkCcO9tHBJz6k+xzULuuV5R3jthrHvGG0NnRoTBq44IgsQ0ocKVScZwVbeYxCve0x+wMQNAvFUhof1OtcL+3gyYP69FOPyJw46ooLudOwhLh49SkLHSYLwvR706WlOO2J0aw8lTtiJM3n8m0XM1nGI2vuEugRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723169; c=relaxed/simple;
	bh=dUTm412+K/VmHkyZw+CmlWzv4zckQvZAia5fbSEQNn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apSLqOO2TcpOftTe7biOp3Lf373d5DgkqKNBtv51ypqbfCoT6WumqgwsCnG8ZaTFL5Q5u37tRijxWX4aMoirAU+xUmxtYewgg6UlM1K9ixoiL0JO6JHRrAHNaDCfn5i8Axi2NI9JJkBcrsAxyVy4bRqW5bU4trJZZOPMbY6P998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bsa+x95C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B29EC4CEDD;
	Tue, 15 Apr 2025 13:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744723168;
	bh=dUTm412+K/VmHkyZw+CmlWzv4zckQvZAia5fbSEQNn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsa+x95CEBNUO6b4gx8SCg5V/g6rbLU/TUMfQaDLQ1SXJZlNiLTN85TIQw4vtBxyu
	 KqXMXtvGZ67Laj0y/0BHqw1DGEoVAGsGvMwAvXwnIDQYkoOTqX8TtVH4g9nSbV3iy7
	 lsA5r+Z56NYTEmNzQMCEOUs/mfIrK9MtKcQMWYbw=
Date: Tue, 15 Apr 2025 15:19:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Devaansh Kumar <devaanshk840@gmail.com>
Cc: sashal@kernel.org, stable@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH] bpf: Remove tracing program restriction on map types
Message-ID: <2025041517-semicolon-aloft-9910@gregkh>
References: <20250415130910.2326537-1-devaanshk840@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415130910.2326537-1-devaanshk840@gmail.com>

On Tue, Apr 15, 2025 at 06:39:07PM +0530, Devaansh Kumar wrote:
> [ Upstream commit 96da3f7d489d11b43e7c1af90d876b9a2492cca8 ]
> 
> The hash map is now fully converted to bpf_mem_alloc. Its implementation is not
> allocating synchronously and not calling call_rcu() directly. It's now safe to
> use non-preallocated hash maps in all types of tracing programs including
> BPF_PROG_TYPE_PERF_EVENT that runs out of NMI context.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Link: https://lore.kernel.org/bpf/20220902211058.60789-13-alexei.starovoitov@gmail.com
> Signed-off-by: Devaansh Kumar <devaanshk840@gmail.com>
> ---
>  kernel/bpf/verifier.c | 29 -----------------------------
>  1 file changed, 29 deletions(-)

what kernel tree(s) is this for?

