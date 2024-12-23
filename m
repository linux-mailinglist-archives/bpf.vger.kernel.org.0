Return-Path: <bpf+bounces-47550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD5A9FB42C
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 19:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8308D1885AE7
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABEA1D14FF;
	Mon, 23 Dec 2024 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYTZv7+i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4231D0E2B;
	Mon, 23 Dec 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979736; cv=none; b=BnGTYCZEhkzDXxKMwfoYRBwOz1AgcT4nIUkgL4uAarM3eASNTNCabuVqzrD73GfFG3cEeyzGxlZc44clXAFStB4d/n82vh9NocpqGXqHq7W831pfFDX0PqinKGGupXQIiTt94buXzbq4h4AAAg2AI1TTbCSp4ut797q0H3ZUGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979736; c=relaxed/simple;
	bh=czSZsGgJ33XYIcDsPVIV+jFMTEOuHEdUxjS/eR3yKCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geHbTC7zluMdD0ZDuit5AGtG+/tXmUyJ0K8K0/mKpCnWsIlb5M92peXLHFPkUH/KY54SuilnF+jyuxgXbtKKtJljabbBazUOmuy60j03x3ffQS3KqEBjkaQ4L1kurPXxVWKusViznMzOIlOz7IIrOtD2rMIoDrK/3ZnMOM5PFzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYTZv7+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DFDC4CED3;
	Mon, 23 Dec 2024 18:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734979735;
	bh=czSZsGgJ33XYIcDsPVIV+jFMTEOuHEdUxjS/eR3yKCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NYTZv7+iFctNHtG6mB+1OgSnP2lbxfmL6BYdnBdnAcEl9r7BdpxiK/V+zy74JqrWN
	 qAowdZuEZMUyo9svgCY9h4SXtYhLCadS66a47IokmwRZc6E04DaGSqRgc8hJc4SHZo
	 FCTM7Cqn755olnAuu63K3qL7XE6bxb2gApLh84wfjrIRj7phUDFDDJueHRkxs1qETL
	 cWGgRYeIzETHfomVmfEEMvON/MH5NNl8F/9hRGRv1dw9xMSwCqnvaKJ5K2eMq5FGZo
	 DX/P4pr8VIuI7134x+FAC72kUHb5ufjS0apUjVkmOKiDh6hj70IR3UvL1dkWgYf9+/
	 HnPEpAdIZxdVA==
Date: Mon, 23 Dec 2024 10:48:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, razor@blackwall.org, pabeni@redhat.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] netkit: Allow for configuring
 needed_{head,tail}room
Message-ID: <20241223104854.60da50e4@kernel.org>
In-Reply-To: <20241220234658.490686-1-daniel@iogearbox.net>
References: <20241220234658.490686-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Dec 2024 00:46:56 +0100 Daniel Borkmann wrote:
> +	static struct {

'const' also, I think, but either way:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

