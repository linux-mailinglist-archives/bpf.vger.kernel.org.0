Return-Path: <bpf+bounces-52554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F00A448FC
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CABA168CBA
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB1A19ABD4;
	Tue, 25 Feb 2025 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZgSk1Nu"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373FF199FD0
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505930; cv=none; b=H/TNSPrQD/xP95wxPyxWHGya78CkSVqWeLZ8pUE4t7HCBD67I/yRTrQPPfNVZBR4eEpkGpC4e/KiW0tjb9TLsQE3GFbbN4AWsvzyYt8GG2nImZFNGAuPyncmdPuGnd3cyd0mY+alANxh/FJ0EL3WxVBHnHHvd8hurdsMKp4VDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505930; c=relaxed/simple;
	bh=mWRKanm/louFkwn/wZwiUzhOV3aYMVxvVek8GtZomag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWWfhfB+TwrP8bQIIQGKbcBFsuj2GBzYHqZGFe3imHN445LHnutQrmHp+1bX2Xb+5C+J3VApsw4ycNjcPyI04s08UVA+ZVYgK5pgRp0uHgdqY3SMlojSXcgPeGvdKpyWWg2oqTIhY6IJ8qd2TxJS/UlIyWT0/V2oOa58LpQ6CRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZgSk1Nu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BE2C4CEDD;
	Tue, 25 Feb 2025 17:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740505929;
	bh=mWRKanm/louFkwn/wZwiUzhOV3aYMVxvVek8GtZomag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZgSk1NuXrouOjUHZF/gh/fohCopHPAPzTscvVa2NQLEO+wQuQXL8jmP53U8Bg54y
	 1XF3HYHfLyaah/fG9R60rBVxGWTj0hWy6nC+5J0W97NxVqDNnk305i1kVpkOoU/3j5
	 5mkXOjH3isyGifFLVEANFfM8N72Nsljobw4XxFwot1IoNtQMsJmmKJj8IVceM2Y3ch
	 Q2MHBXmq1mV9BIMloRUrZ68fTB1/yvlekC+B86aRYGhgcVWFhH7G1MQYLdnxnwqpHO
	 JpkW62hjTUroSeq7VPSEVuEcrNOsxQ4poH5Iqy7xxojoeCVLsXrB2kHxwcSLU6VKqb
	 rxUzRC7Nigk6w==
Date: Tue, 25 Feb 2025 09:52:07 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, peterz@infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 1/2] bpf: Reject attaching fexit to functions
 annotated with __noreturn
Message-ID: <20250225175207.2q3c74ggwiw6lwsl@jpoimboe>
References: <20250224114606.3500-1-laoar.shao@gmail.com>
 <20250224114606.3500-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224114606.3500-2-laoar.shao@gmail.com>

On Mon, Feb 24, 2025 at 07:46:05PM +0800, Yafang Shao wrote:
> +BTF_SET_START(fexit_deny)
> +#define NORETURN(fn) BTF_ID(func, fn)
> +NORETURN(__fortify_panic)
> +NORETURN(__ia32_sys_exit)
> +NORETURN(__ia32_sys_exit_group)

Why not just sync with the objtool noreturns.h?  Now we have two
hard-coded lists instead of one.  These are guaranteed to diverge.

-- 
Josh

