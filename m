Return-Path: <bpf+bounces-46289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 367629E75C9
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CD916E96E
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E329A20E328;
	Fri,  6 Dec 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+GkuS8n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73D20DD79;
	Fri,  6 Dec 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502060; cv=none; b=EMPUSqv1HD6g951rMuhJwg/oeuB/LZXQ4Fk7zcfY3vfF48oA4cBhFI8U3yK7NfHvD6G2kQLsfPT+VlTYynbZcMzdM9Pf5ro0C+LHaQ3vh9udjfaixZOiSY5z/zWM1daQqVDciGZjbbV8UH9afDHlDdVO9RLMgkCggPtSv/3BkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502060; c=relaxed/simple;
	bh=raoRWGeQWo6TjS9m0YDmjSIZiLYrzZGkhLuHH5ogzR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTiQm+hy/uuBdzR1OZZr36aMiT1b+zPhbwbCXTeehZII40ttPBgXfWc2VjhgbZfx8/h2rpxPW4jCndvOseGURRj5SYoftEQUti7oRBzLR8W0HVIFtp88O0yiGQYctoatcT899S0em+lNaJHZZ9IdnW3fmQQCV6LxfpixsXQFDms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+GkuS8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BDFC4CEDC;
	Fri,  6 Dec 2024 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733502059;
	bh=raoRWGeQWo6TjS9m0YDmjSIZiLYrzZGkhLuHH5ogzR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V+GkuS8n5xccMr0jcHw7LjnA4UIvx6oB70SfLQiuuXHa2olFC1hyS2FBbjRWjjQag
	 PsYkEQl5Z0XqV91OqIKgUNck3oUeqQdlv3hGIHB7BYo0BUnlvPoYhf3g+m1nTwW2RC
	 Y/utOtd9x3dsGW2Ph+EA4zQ4PDVpoC4pWXEjflDCQESHwP/LTqO0xtkqLrR6+aVIve
	 pgA8GFLG+0A0kWQArrwSSiH0z0ktPXlmDxw/26UzCy3wtrXOix9ffsCW/tKKXze7bZ
	 2UXrnBaSkP+mFNIqvix4+rOEBaapPR31NurAsYI9s5Oe7MCzZhbrUhzdWcHKScJJ85
	 HyWPtEzE49X2A==
Date: Fri, 6 Dec 2024 08:20:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, "Maciej
 Fijalkowski" <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 <nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 09/10] page_pool: allow mixing PPs within
 one bulk
Message-ID: <20241206082058.4a185982@kernel.org>
In-Reply-To: <f817137c-3f02-4c12-96ef-04b7dcf5501a@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
	<20241203173733.3181246-10-aleksander.lobakin@intel.com>
	<20241205184016.6941f504@kernel.org>
	<f817137c-3f02-4c12-96ef-04b7dcf5501a@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 14:49:18 +0100 Alexander Lobakin wrote:
> > nit: netmem_pp is not a great name. Ain't nothing especially netmem
> > about it, it's just the _current_ page pool.  
> 
> It's the page_pool of the @netmem we're processing on this iteration.
> "This netmem's PP" => netmem_pp.
> Current page_pool which we'll use for recycling is @pool.

Heh, yes, I guess there are levels to current..ness :)
Maybe instead of current the one we're servicing could be called tgt_pp
and the one from iterator just pp? No big deal either way, tho, this is
very nit picky and subjective...

