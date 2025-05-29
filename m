Return-Path: <bpf+bounces-59223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C39AC7513
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 02:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5353BA404AE
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 00:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D915C603;
	Thu, 29 May 2025 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJQZsLa9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE596A94F;
	Thu, 29 May 2025 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748478309; cv=none; b=T3atsHhv0RdF2SqGBBCi/HlpbS71Y2i7RLbtQEe+sToJ+7hkikKBbFO+KJ9KTOueXEzbiJsqv9ZwsA0mxFmdHq8PAO/Y8u3Jl0fuTBM9SbstbHm3UK93avECFYXHVpr3nxFouIEU5CIxuRb3dGLyvTTbO/W2BLrzTIABC42R24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748478309; c=relaxed/simple;
	bh=v4svvuyij4Z8F+Y+pVMDtFxCal2+XdBbL+ivhYA04w4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spTTzEQNdAtAufGXXX0ENVqWIG1+LBmnCiObLJEH6YwniODzDzrkaHFf935vNnMPGuBb7vnf35H2fxP7tVhJDiBFkgP8QcUb6+E4pt7fUVnWg06ThD9EKyznTLU1LkFGmeGIcLtSmTWsLbuQXTjP+WmHzL9AuTK8XJfD1wZlRY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJQZsLa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98931C4CEE3;
	Thu, 29 May 2025 00:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748478309;
	bh=v4svvuyij4Z8F+Y+pVMDtFxCal2+XdBbL+ivhYA04w4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uJQZsLa9leIQfjg29rN15B+7perBysS7FrPAzqEpOP1r41Nad0+TRKZgKTfQCksAg
	 gUJ/OuOUdqbuyAZWNXof09HIL7Cn5FPS6531qXOcFZ7gyLxWOtgqouZEbJ+pWYyqJr
	 LDBLINMGZSD3BdNsKJPQwWqdYwLn6+MUD0htmXEFxwOvyCnq72nho1nb+HDxTRIBeO
	 yh+3/j2VcZF44kggGrTn61H8nvsRmCTeuJhdb2IPoFv60s5jOb6sw0kj9ho5XOZ1sk
	 3zXRvmTgimf+w2JPt5qSnfTWPQBseJP2hwq/iyyTYPHcwI95UC9R5iLB/BNMYaIxuf
	 gz6RFBKW8G09Q==
Date: Wed, 28 May 2025 17:25:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
 <netdev@vger.kernel.org>, <maciej.fijalkowski@intel.com>,
 <magnus.karlsson@intel.com>, <michal.kubiak@intel.com>,
 <przemyslaw.kitszel@intel.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <horms@kernel.org>,
 <bpf@vger.kernel.org>, Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next 01/16] libeth: convert to netmem
Message-ID: <20250528172507.599cce65@kernel.org>
In-Reply-To: <20d9b588-f813-4bad-a4da-e058508322df@intel.com>
References: <20250520205920.2134829-1-anthony.l.nguyen@intel.com>
	<20250520205920.2134829-2-anthony.l.nguyen@intel.com>
	<20250527185749.5053f557@kernel.org>
	<20d9b588-f813-4bad-a4da-e058508322df@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 16:54:39 +0200 Alexander Lobakin wrote:
> > So what happens to the packet that landed in a netmem buffer in case
> > when HDS failed? I don't see the handling.  
> 
> This should not happen in general, as in order to use TCP devmem, you
> need to isolate the traffic, and idpf parses all TCP frames correctly.
> If this condition is true, then napi_build_skb() will be called with the
> devmem buffer passed as head. Should I drop such packets, so that this
> would never happen?

Yes, misrouted packets can't crash the kernel.

