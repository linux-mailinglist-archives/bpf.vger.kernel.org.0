Return-Path: <bpf+bounces-51562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84CFA35CBE
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 12:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9840E3AE16A
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 11:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E88263C83;
	Fri, 14 Feb 2025 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKGG8UKx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213C25E44A;
	Fri, 14 Feb 2025 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533177; cv=none; b=uCSy87Gji5ScB/zEdttZG8u/J1JheqTs1UWQGNE+JLoi+d4Cm1vserfMjK3iYytsE3V4NcCNhn7qlsqEwGZ5tRBPyVDOQfqU4Xf2T9tar+e8bR9Z4Gn3N0uE3aGXuiGyhf3YyaJXA/etDprn+I6cJ/+zuVjM9kpkduWANQJasBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533177; c=relaxed/simple;
	bh=YUJQiKwOhAsN4sg0qPw7CVwm4lT0b1XkLxFsPIZD5xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmZq2wY4zmbojqkjDS96yFNhdlKeHJjUH9ZsTE3pAMcwcywZEPYO3+IEKybvmWyTvbwiIuKYORJG1TFWP7YPf47IBwO69hlfANNUFbeJHe1cylQa1EFIpO4DTed0hpx1rXPCfHfyAvVU3oZYqUh7P7iA9lIpzEPQCM7IBl6fMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKGG8UKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87DEC4CED1;
	Fri, 14 Feb 2025 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739533174;
	bh=YUJQiKwOhAsN4sg0qPw7CVwm4lT0b1XkLxFsPIZD5xQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DKGG8UKxHfGO17hVPcFD9ecMVR4cE3yqbeMsFnFwEc5LacPAxFY305IFJa/3M90Vy
	 Xsihmt/xA0MY8cLfjvCu25EiBez6DoUjF7wNIgEYc0tRProBofM6SiY06MfSm5pUPm
	 P3iWT0xqbIkJN8nTMcGIkYt662OSAAc9XhRWvsQ51OOnMGEa62QNyWpwGA2/odT8qE
	 oNAvh18yrS6aTkgcgOaGB9XIget2VmIrpijbplp5CiIHj1jENPQwxVNlOxcTEyv9uB
	 S5XSkkUZnnkAyke6fhA0yJy57snX9zVjs7Xo9DlmICe8lbDUgLQbCNVpEbgxFceEa0
	 TULSWgMSmiIKQ==
Message-ID: <7aebeef7-2977-4557-905d-15135a1a1f23@kernel.org>
Date: Fri, 14 Feb 2025 13:39:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net: ethernet: ti: am65-cpsw: fix memleak in
 certain XDP cases
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Julien Panis
 <jpanis@baylibre.com>, Jacob Keller <jacob.e.keller@intel.com>,
 danishanwar@ti.com, s-vadapalli@ti.com, srk@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250210-am65-cpsw-xdp-fixes-v1-0-ec6b1f7f1aca@kernel.org>
 <20250210-am65-cpsw-xdp-fixes-v1-1-ec6b1f7f1aca@kernel.org>
 <20250212201430.5bfaecc7@kernel.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250212201430.5bfaecc7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/02/2025 06:14, Jakub Kicinski wrote:
> On Mon, 10 Feb 2025 16:52:15 +0200 Roger Quadros wrote:
>> -		/* Compute additional headroom to be reserved */
>> -		headroom = (xdp.data - xdp.data_hard_start) - skb_headroom(skb);
>> -		skb_reserve(skb, headroom);
>> +		headroom = xdp.data - xdp.data_hard_start;
>> +	}
> 
> I'm gonna do a minor touch up here and set the headroom in "else" hope
> you don't mind. Easier to read the code if the init isnt all the way up
> at definition. Also that way reverse xmas tree is maintained.

Thank you for the touch up.

-- 
cheers,
-roger


