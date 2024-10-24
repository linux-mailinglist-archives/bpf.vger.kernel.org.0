Return-Path: <bpf+bounces-43041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A12F9AE35F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 13:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F3FB22951
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5FA1CB9E6;
	Thu, 24 Oct 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlQGJ62S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C317278D;
	Thu, 24 Oct 2024 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767884; cv=none; b=n30AwKiu0KE9K81La+r83lDGtwaimkqSfYZ8OgarrBp+QkhdrELiLixGhcQLc8xrmagcO7bOxH7MvN20gBl85wHWb/3Ybv9WIEtY/Wn/liTPKGJWU13yfkmVVp/dti6wKUZybPhi6BZ+awodAbdKhOQ0Na3LdLwnAm6c2CyJCR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767884; c=relaxed/simple;
	bh=MpVzXZkpsyfqn55c+HIWgp7lQUbVDeCzsYCY9XEMWZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFc22DB5CDja0aMZ+wCRcgU1CUEjg3UKw6kuZia8CASIcVR/XI0kLpVVgBYKg46YEBm/T5+IIdMLPQY10OsOLme6fOu3eZcgR7S06L7e9ueuxxMbAxENfrS/NvNFAnQ2UtV8l5sVQwGHaYBxuS3fZOk/VR4M6lHoNMP3UOiu9hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlQGJ62S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E9AC4CEC7;
	Thu, 24 Oct 2024 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729767884;
	bh=MpVzXZkpsyfqn55c+HIWgp7lQUbVDeCzsYCY9XEMWZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YlQGJ62S8bqwDlAfpqZEv1vqouCvow5Xk8A1uOfx7zf/7qZqTpZlsnPsksN0v+Gdf
	 /+B9yNetBs2dwQB6GPREokq+1uef5WoOBKbZiJVmeolZTzCg9nYMW39NXPQQiiTNhQ
	 Bg2nVbUbN5CGxUjWlNTgEgAed0R9RwI3qhDhU7nrpX3vbDXRWtsXTv+3IcZJJr0AIf
	 zVZ3BuaEp6kAhOIH4EXLz/Dri3lrRh0F7m+DTqmv+gFjyt6xGXOE6I+mamUHfRqUqB
	 ZZ9x7f6LHm7luK0kny9CWRvYJMIdDS6OYSGrjGe2FQRtgIPsX91KAMlUi1NvYemdxR
	 i1rwejz0T0IDg==
Date: Thu, 24 Oct 2024 12:04:38 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH] net: mana: use ethtool string helpers
Message-ID: <20241024110438.GD1202098@kernel.org>
References: <20241022204908.511021-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022204908.511021-1-rosenp@gmail.com>

On Tue, Oct 22, 2024 at 01:49:08PM -0700, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the data pointer.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


