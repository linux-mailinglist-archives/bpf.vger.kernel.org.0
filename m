Return-Path: <bpf+bounces-49149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E54EA1476A
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 02:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCC316B5C0
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 01:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1588622611;
	Fri, 17 Jan 2025 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhL8CJ4Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8373C33FE;
	Fri, 17 Jan 2025 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076491; cv=none; b=IhyqhK+aKTvXR1B5tHMVgP1KHMlmvu8s0hA8JGbeXpLCuMhVwIXIEdmj8WPAwkj0mRsZlKA83H4xMD2FB0veDfUFxWiAL9/BeE4fO/SB2F8ftEzm1HwBOwcNRTPVqZCkeI7HaKoB7hRqsw2KfNqBmOe/SwfCtsM1WYjqfBsPaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076491; c=relaxed/simple;
	bh=cImctKov/CLeObOEW3CL07IazF9oRfOMa8vH8ge27Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9JVvZ+LS+TAdl/fzTgwQuHHLdgXEzEtKizrj7mmSShfz6w6XZ338+IR1gaNsDbAC4wQxhnux1P7l96Bzt1p642SttQ1Bx4ELwjpLnrOdAZuwzN8iDVSbuhv4ZasgUqHCwcOBwLNV+5/TdV8wEoWMMVG3wiQfo9BotAGKumvZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhL8CJ4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A75C4CED6;
	Fri, 17 Jan 2025 01:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737076491;
	bh=cImctKov/CLeObOEW3CL07IazF9oRfOMa8vH8ge27Xg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KhL8CJ4YjgI4tcNOLq+XVBkx49AJIOgt9LgeePE4STDwAek4ADqWJFiB/gIAK/oXJ
	 53SXUec5uwqKa5iM4vZiYu5jIaH4ohQYzCLdFCT1dgeGd7fqKYOg9cALC2ZY+bPEWB
	 nQfBLVbAevjhTYUKbsVj4zDp+Dawgy/ZLGJKwPbz7JJGyfB9mFu+n7OjdArBcecsqL
	 99y9FwNxE4o5+TCUCoMzGmG8D/CCKf2MqOXGY0RQIN4YAianbNMK3+FbBSLoqqWZFT
	 rPQzG9WK3Mr965zzoZxB2CGKfcDyxN/+g2NPJXNyzFuPRfi88hSA8cQ4s49B5xx6xd
	 8HOr6tmkQ2x9g==
Date: Thu, 16 Jan 2025 17:14:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu
 <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/8] net: gro: expose GRO init/cleanup to
 use outside of NAPI
Message-ID: <20250116171449.40d228fc@kernel.org>
In-Reply-To: <20250115151901.2063909-3-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
	<20250115151901.2063909-3-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 16:18:55 +0100 Alexander Lobakin wrote:
> Make GRO init and cleanup functions global to be able to use GRO
> without a NAPI instance. Taking into account already global gro_flush(),
> it's now fully usable standalone.
> New functions are not exported, since they're not supposed to be used
> outside of the kernel core code.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

