Return-Path: <bpf+bounces-69908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC09CBA637B
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 23:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F97189DE2C
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 21:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129D7230D0F;
	Sat, 27 Sep 2025 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6EAT7Z0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869174C9D;
	Sat, 27 Sep 2025 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759007029; cv=none; b=o54A7fhcK4Wb7ci3LdUMJVzpDZhibjJ9vTWYIg1pIDKI7PvxepFGc5JjcXxfYCxfbbqnkadZnj7gbFPe5nA8YWyHDcQGpuJ5ENlFmITtzoLFRQzNnm3KWSqWDkP8/DorecbYuytmpKHQiYFSt/g9+my+hCCTnIGpmsMxiw1Rv/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759007029; c=relaxed/simple;
	bh=fs1Lq4RPW2fS0QcVg+BQIUVpwMUM5JzFSfxkXhuawHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKtt1Ru/srtQU2D69BWZqeTZniPvZEnaZ6FayzB4QGxern2MT5dd+cDvsIpoCIxg0mGF/UhRM8GMA6rp5VQYPPqEmhPq7kzr8Ez/8VTv3unhIdxK5NF+2+kmIH0V1QW4UdMGmrS146La0fL3jzB0446qgQmV2p/FE5vfml27MIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6EAT7Z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C22C4CEE7;
	Sat, 27 Sep 2025 21:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759007029;
	bh=fs1Lq4RPW2fS0QcVg+BQIUVpwMUM5JzFSfxkXhuawHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6EAT7Z0jY/dmC3zOIFjLJRhqRWyd8nIov0qpKf8J1Y7NjLVXexn1fh+lBpUzH7tL
	 zOxc2iydHoUEXCmauLBTHtAyMa/u3qnC0qO0NAULyDqWUFkqf9khK9QyaSGGA2MPbG
	 c5pSry5Sn0hRrJ4DGn9hd54G1PbZwFBjy1ssMnNXB5UzgCk1EEpR8zBw3q9icvrsWG
	 wkrJSsJArjHaC1zc7GwoCM1BtGoWdL79MTcbx8bvRBKw1tJOhRn7P80EhqVzwBnU9Z
	 SNvYhMvpX3eQDWAjSFh80+QoHJhYXurhKw8LM1RszhO2f/A3BJOCoNogvcdBmrNAWY
	 XCfTIirGgOvIg==
Date: Sat, 27 Sep 2025 14:03:45 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	bboscaccy@linux.microsoft.com, paul@paul-moore.com,
	kys@microsoft.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org
Subject: Re: [PATCH v5 03/12] libbpf: Implement SHA256 internal helper
Message-ID: <20250927210345.GE9798@quark>
References: <20250921133133.82062-1-kpsingh@kernel.org>
 <20250921133133.82062-4-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921133133.82062-4-kpsingh@kernel.org>

On Sun, Sep 21, 2025 at 03:31:24PM +0200, KP Singh wrote:
> Use AF_ALG sockets to not have libbpf depend on OpenSSL. The helper is
> used for the loader generation code to embed the metadata hash in the
> loader program and also by the bpf_map__make_exclusive API to calculate
> the hash of the program the map is exclusive to.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Nacked-by: Eric Biggers <ebiggers@kernel.org>

No more users of AF_ALG, please.  It's a huge mistake and has been
incredibly problematic over the years.

If you don't want to depend on a library, then just include some basic
SHA-256 code, similar to what I'm doing for iproute2 and SHA-1 at
https://lore.kernel.org/netdev/20250925225322.13013-1-ebiggers@kernel.org/.
I'd even be glad to write the patch for you, if you want.

- Eric

