Return-Path: <bpf+bounces-46979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 629839F1C61
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 04:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EEB17A0561
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 03:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758CC26AFF;
	Sat, 14 Dec 2024 03:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdRUKrfd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E019BA6;
	Sat, 14 Dec 2024 03:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734146675; cv=none; b=XWg2CvwsxtaZPX0D5dFifxK2f3Of2KcL6L89nR+QpouTrfLkiPyRsCO8xwRXLoxGM1YZ/apEGC2aTK4NTOv5MI639s9bMFzm1maRKoXzld9vaiXd3OcugXEBRsMTeX2XNHuv5RICaOH0LFrCWExC4mFFh5WowPq5FcoHktlxqDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734146675; c=relaxed/simple;
	bh=Je3jjh68XKfBdCyVDTsqkImeTuTILX7G5i01KgG0Ebw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkB82OEfJVHq0Sjc1wDIIi40H5vRrnHlf2TnpvvZMR+Xn9eglATtTKSHlFl5CnIU/mFoC02QiYq1PeDu1puwjg9Vl/GcZ0+yPbJYe9L72Thezezqqn5iK48fdZtlPfzAnDiPZrbTdbJ0oSFRoCg3F41aSV55aMS+If5JYaj8esI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdRUKrfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB232C4CED0;
	Sat, 14 Dec 2024 03:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734146674;
	bh=Je3jjh68XKfBdCyVDTsqkImeTuTILX7G5i01KgG0Ebw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdRUKrfdTQatBqCBIEICSA9ss3vL2M+R8ZQlvSkFRqj6d4geh0RMfBw1NfjofjpIq
	 DDdlJAGrgDv4W6PvTfWYQIWYrhfSsEARu7KQNa+oEO7HYW1/gOT+RyTbd54bWX4QJa
	 rbeyguQnpelH+kE2yOPJGIeM8Y81K1vPhd5xY11LkdVq/B2WOG+nY9JuhdJ30n4XAV
	 i+HKqv7XjGInBqTKgY9Be4x9p1D2NoNmFMg67gdOEObi2rKgg+3XmEn+ei98cnnnY+
	 pCb+9Ue3i0PLIpb9N1WrSa9xco1OPtTZ4oKjvTRcvJ++0y9B0oII/UkTsGJmI6aQBZ
	 9qWy88MEcPNCg==
Date: Fri, 13 Dec 2024 19:24:31 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] jump_label: export
 static_key_slow_{inc,dec}_cpuslocked()
Message-ID: <20241214032431.algrflxqdp4jilnr@jpoimboe>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
 <20241211172649.761483-12-aleksander.lobakin@intel.com>
 <20241211174000.tpnavd77pyfq7hw3@jpoimboe>
 <a4af5958-38bd-44c3-b539-8e112a0c0be6@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4af5958-38bd-44c3-b539-8e112a0c0be6@intel.com>

On Fri, Dec 13, 2024 at 06:22:51PM +0100, Alexander Lobakin wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> >> +EXPORT_SYMBOL_GPL(static_key_slow_dec_cpuslocked);
> > 
> > Where's the code which uses this?
> 
> It's not in this series -- the initial one was too large, so it was split.

It's best to put the patch exporting the symbol adjacent to (or squashed
with) the patch using it so the justification for exporting it can be
reviewed at the same time.

-- 
Josh

