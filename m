Return-Path: <bpf+bounces-63386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D660B069CC
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 01:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EBB568088
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 23:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D402D46DB;
	Tue, 15 Jul 2025 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsUg21HO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F216C2C178E;
	Tue, 15 Jul 2025 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752621554; cv=none; b=FUuJH470nVw6VuX/iZNSwQc4i6xFgmt5nHEjdiZ1+ugf4FFASNtXLPWlRcjBsXmNII9lbPqoXpj+HH27dtXigUl40VobmuQ9Xz7GAR/9l69bi1DoRyxAUqTvaPWYw4QtqQqdqL6G0fz5MXfOpgdkiwgG+bdcieg/KS+MXBcjnuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752621554; c=relaxed/simple;
	bh=K820+iBNMoJZqAsuKkgRQGrNMefBkmNasJMHvGIYUSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFKYbfReX4j08BfNKAeAN0FLBX0zIsCm9Uo0GmGW/SaIO31WG6uFWTGfej08lCw7g1JzJqXWcx0lLM8djM9eHDr9erJ9qFnVZ5zZ9F/B9GTFZYdbNJFdekXWiOYiPPVipfP8XntFno/ze45KhO+bIQ3OfgLqw7bBHhIP9IR9Y2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsUg21HO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BFCC4CEE3;
	Tue, 15 Jul 2025 23:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752621553;
	bh=K820+iBNMoJZqAsuKkgRQGrNMefBkmNasJMHvGIYUSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bsUg21HO0ipbwsHClRFaSe7FkUUAlpRr6ie30rbiUIbGwWTXq618tuOSpQlYLrXC4
	 AhPeCSd45wRX+6qvyGW6rM4/6HINkJWTxuR1cyjFGJBKrVsQPDOtc7v/TFHg/DHAGv
	 YJsuSul5gQVenP6NpqhEss7mqFSrzyT4c6i2KEtpr71mD0KfY6E3ArpzMLzvz4a0Y1
	 lF5zhJbTVfl7OEmTB7Y/4Zo1zEREsifd3ob3cy8l8KHn8GSqGvpiD0bUTEoXrxeTI8
	 gKjvSLNPT6yaQENQ/hzB4YXq1fMDkCB0uJhfnWHya2xNjSplVw9rnE1P+/15D4wFaa
	 NynEORywD96Mg==
Date: Tue, 15 Jul 2025 16:19:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joe@dama.to, willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] xsk: skip validating skb list in xmit path
Message-ID: <20250715161911.32272364@kernel.org>
In-Reply-To: <CAL+tcoCiL0jjUO8RPiWX-+9VtjQm50ZeM5MQXn3Q6m+yNYryzQ@mail.gmail.com>
References: <20250713025756.24601-1-kerneljasonxing@gmail.com>
	<aHUqR5_NoU8BYbz5@mini-arch>
	<CAL+tcoCiL0jjUO8RPiWX-+9VtjQm50ZeM5MQXn3Q6m+yNYryzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 07:53:19 +0800 Jason Xing wrote:
> > Although, again, if you care about performance, why not use zerocopy
> > mode?  
> 
> I attached the performance impact because I'm working on the different
> modes in xsk to see how it really behaves. You can take it as a kind
> of investigation :)

How does the copy mode compare to a normal packet socket?

