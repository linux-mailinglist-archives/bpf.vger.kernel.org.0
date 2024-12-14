Return-Path: <bpf+bounces-46976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DD09F1C1C
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 03:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B31163B33
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 02:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2254199B8;
	Sat, 14 Dec 2024 02:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1rowdIZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5AD23AD;
	Sat, 14 Dec 2024 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734143481; cv=none; b=kME6ln1OIrIx7mnNxTjdR29k3bCTJoP5huS1d8nbKClzA5j7iQXhFOes8Yfp3W6SLyaBkE43RjIeWSrJUratdJfjVQI7IOcOPB9qnMN7bRRGABXteDJIuqmnrqqCMuW5LNeLYFvDW/Mf5JR3BmgLUIWaXQ7ISwZj36WcqUqS7B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734143481; c=relaxed/simple;
	bh=ONeE8zGtu5kORK57opTnqobNq2wLDyY1y+gmtaut78s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRgCnKkQpPdSg3ajF4aGDLOf7Nzf/yXB4p0S/ckkdpUdk6C0w3VUppDkPc+XDCKYeJwoAJ7auWf4yikRGyKolPrattKe6C6unHxIYUsavUbdWH1WcVq1152hhC/borVdTVOA5vVcKXYyKdZZMYnhmVvUdfidtY2m0m1auf+VjrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1rowdIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBB8C4CED0;
	Sat, 14 Dec 2024 02:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734143479;
	bh=ONeE8zGtu5kORK57opTnqobNq2wLDyY1y+gmtaut78s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R1rowdIZM1cL9WOMeGb8LIckGCLWM6HOAXTZJSb60tdINtSAUn81ee6Nn0a+/YL0K
	 CZCDYNMiKEg3o//d7r1LOF1jXCN5mq0LVaVTh2sXZK6SKSKkERIDxGiuK0x6GLmT0X
	 iXHdZw9marDXofkb5XBFM3uOlHaCFOSjoAKweeJY6tmfoGYLQBsrG3lb19tbetZU33
	 QXVJj7GoJn+x2eER2p2Hgo7zJMwTrQmfW9KUgwUEHer6ijK4to1zHMz/fA30inKfpn
	 xoD+2wnSlFgv0t9r1PRwbN46VtXnLy13lWBqRH6tc2/tXF7bm23qDlhsEVe//X1fs8
	 y4jZw4u9oSZ6g==
Date: Fri, 13 Dec 2024 18:31:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Josh
 Poimboeuf" <jpoimboe@kernel.org>, "Jose E. Marchesi"
 <jose.marchesi@oracle.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jason Baron <jbaron@akamai.com>, "Casey
 Schaufler" <casey@schaufler-ca.com>, Nathan Chancellor <nathan@kernel.org>,
 <nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 07/12] xsk: add generic XSk &xdp_buff -> skb
 conversion
Message-ID: <20241213183118.2fdca6f1@kernel.org>
In-Reply-To: <eb2aab4b-ba00-4b9d-ba53-5a5bb544f6fd@intel.com>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
	<20241211172649.761483-8-aleksander.lobakin@intel.com>
	<20241212181944.37ca3888@kernel.org>
	<eb2aab4b-ba00-4b9d-ba53-5a5bb544f6fd@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 18:31:59 +0100 Alexander Lobakin wrote:
> > Can we kill all the if !CONFIG_PAGE_POOL sections and hide
> > the entire helper under if CONFIG_PAGE_POLL ?  
> 
> We can. But I think I'd need to introduce a return-NULL wrapper in case
> of !PAGE_POOL to satisfy the linker, as lots of drivers build their XSk
> code unconditionally.

Oh wow, you're right. Bunch of drivers of a certain vendor still don't
use page pool.. return NULL wrapped SGTM.

