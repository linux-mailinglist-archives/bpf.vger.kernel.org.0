Return-Path: <bpf+bounces-35734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE4793D531
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 16:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC321F24DA7
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 14:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DB118C3D;
	Fri, 26 Jul 2024 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LV3tcX3Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037D14A82;
	Fri, 26 Jul 2024 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004643; cv=none; b=gnx6UcWLEqVFaK74TRZTBXttOpXdbn4Y/QODzBzzQ69f+MP/8Ag44m+4ltpolnixeQLiblmUDVo3jXlGXo6BUI1DeewUZp+kJReHMOyJlNaXyROiN2Yw0QdtGBy/ovnxwPmX1QZS8+gs5RG+0L76m4sFq1oV7fCj1oNqQnzDeBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004643; c=relaxed/simple;
	bh=K9n6/9ljGvN8OE9MvsVVA2kxnO51XIKmmlv7tH6PkhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEUc6IDtIfn8xRu1FnJDveTBYgQu/Xk07JxWckKx/m0w/OufymX3vM+wf/jTZO6i71ZPsIJ425GraOkfz9q5xCU7n6DNiCWxuATTu3xagR4lIH6Oxt5bCuWsmtV4+EqFZRvmhZiY5ZdHyQMXOjreq2XID+0qWOwuNhS4M4G0CkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LV3tcX3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E65C32782;
	Fri, 26 Jul 2024 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004642;
	bh=K9n6/9ljGvN8OE9MvsVVA2kxnO51XIKmmlv7tH6PkhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LV3tcX3ZY5uxA5zaIQDO0D7AjIPDH5rfeirV+afOqWWDFsFnZsuI/Pq6TVvXMLpMW
	 4zjjEAwTn0yTi8K1Je3k59W7l8RaPbCu+7LY/xnHpKSSgWHGEZ+bO7tX4OXPAGJY7/
	 l3dmEeRfMHdjXB5bLoy0YJgrBDahG5VVP7e+KakYr4Sl5POlak1oT9hklBhzSFcpdF
	 RIWaT5kflebpBQoe5MJpOGw8EADcHHu4TWP0/7idcNDcnHU2CmTgbE8ZlCasWb1oF2
	 kp8E+Ot4hJQ4qfE1P6lH5v0lCccR5QZ3LGqFAjtgUVcbw9EAYfq1quNHV+fzFo0Jf8
	 uDnxEKBjVG/rQ==
Date: Fri, 26 Jul 2024 07:37:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <aleksander.lobakin@intel.com>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <bpf@vger.kernel.org>, Shannon Nelson
 <shannon.nelson@amd.com>, Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net 6/8] ice: improve updating ice_{t,
 r}x_ring::xsk_pool
Message-ID: <20240726073721.042b4d88@kernel.org>
In-Reply-To: <ZqOn+Lgr2DoEae6d@boxer>
References: <20240708221416.625850-1-anthony.l.nguyen@intel.com>
	<20240708221416.625850-7-anthony.l.nguyen@intel.com>
	<20240709184524.232b9f57@kernel.org>
	<ZqBAw0AEkieW+y4b@boxer>
	<20240724075742.0e70de49@kernel.org>
	<ZqEieHlPdMZcPGXI@boxer>
	<20240725063858.65803c85@kernel.org>
	<ZqKaAz8rNOx/Sz5E@boxer>
	<20240725160700.449e5b5f@kernel.org>
	<ZqOn+Lgr2DoEae6d@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 15:43:20 +0200 Maciej Fijalkowski wrote:
> > The _ONCE() helpers basically give you the ability to store the pointer
> > to a variable on the stack, and that variable won't change behind your
> > back. But the only reason to READ_ONCE(ptr->thing) something multiple
> > times is to tell KCSAN that "I know what I'm doing", it just silences
> > potential warnings :S  
> 
> I feel like you keep on referring to _ONCE (*) being used multiple times
> which might be counter-intuitive whereas I was trying from the beginning
> to explain my point that xsk pool from driver POV should get the very same
> treatment as xdp prog has currently. So, either mark it as __rcu variable
> and use rcu helpers or use _ONCE variants plus some sync.
> 
> (*) Ok, if you meant from the very beginning that two READ_ONCE against
> pool per single critical section is suspicious then I didn't get that,
> sorry. With diff below I would have single READ_ONCE and work on that
> variable for rest of the napi. Patch was actually trying to limit xsk_pool
> accesses from ring struct by working on stack variable.
> 
> Would you be okay with that?

Yup! That diff makes sense, thanks!

