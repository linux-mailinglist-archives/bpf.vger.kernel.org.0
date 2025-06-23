Return-Path: <bpf+bounces-61268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E148AE38DB
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 10:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EE23A71A7
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 08:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E83122DFB5;
	Mon, 23 Jun 2025 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VA65ncTq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D42EB1D;
	Mon, 23 Jun 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668410; cv=none; b=I4rppo82zG+V9pqRT1XcDEhVJDOjXULDTxSknDNv7GryC3G3E/obltpBpVckoa8+HkWRUM3dUf+pLBhCjhADKiXWKTAlilSqvhRuAHzitBi6tLj7BzjJVlBcBVvCHomA5V4lZJbjvKqyHlA5Jxsjq1cOOA7DrBqKJe/9V7fg/VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668410; c=relaxed/simple;
	bh=TNiTx+da12hoLkDdCgwf8jDT1PiJaS5t7fcXaTlUfrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ4RsSgFNnn55Wu3HPasGKvrmDwldzmul+H3iFBZPt/htquwodyWV46bmeoAI6tv10hfDhmycFYn5oRAwgoBYd+VxQ+0v2/+PRshsyHbptesXCUk+WqcjVLFX4knnHkaOGXxRHpYlY4+GsuCYivupBej2slW34c1FMxQZLqzynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VA65ncTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84326C4CEED;
	Mon, 23 Jun 2025 08:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750668410;
	bh=TNiTx+da12hoLkDdCgwf8jDT1PiJaS5t7fcXaTlUfrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VA65ncTq5fGDpqWnYanrU94Mo+s70pPf2FoonMzpDejNwuNPo2Hhx4gwC80P47xeV
	 IclHdOKiovtgGvzme/uwPxR0p32udqs0xDlL4TJ2Iw4W+ITCs8+tVuCPLlFwrmqdju
	 Ip0aPbX/XONytsAEic1TGmpmZhqWwlPn7qz0Kjfg=
Date: Mon, 23 Jun 2025 10:46:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Tom Herbert <tom@herbertland.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH stable 5.10,5.15 2/2] bpf: Fix L4 csum update on IPv6 in
 CHECKSUM_COMPLETE
Message-ID: <2025062357-grove-crisply-a3b2@gregkh>
References: <0bd9e0321544730642e1b068dd70178d5a3f8804.1750171422.git.paul.chaignon@gmail.com>
 <2ce92c476e4acba76002b69ad71093c5f8a681c6.1750171422.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce92c476e4acba76002b69ad71093c5f8a681c6.1750171422.git.paul.chaignon@gmail.com>

On Tue, Jun 17, 2025 at 05:49:21PM +0200, Paul Chaignon wrote:
> [ Upstream commit ead7f9b8de65632ef8060b84b0c55049a33cfea1 ]
> [ Note: Fixed conflict due to unrelated comment change. ]

This does not apply to the 5.15.y tree at all, due to:

> -		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, false);
> +		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, is_ipv6);

This chunk.

Can you fix that up and resend just this one?

thanks,

greg k-h

