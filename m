Return-Path: <bpf+bounces-69304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFC9B93D06
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 03:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B561F19C1AA1
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629BE1EE7B7;
	Tue, 23 Sep 2025 01:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txPGHGvZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70CF14A0BC;
	Tue, 23 Sep 2025 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590250; cv=none; b=Ns7Ik96jLtq/wSxUA0hYpoJ0GysmcLGu6/jQ0r+VhQ9S0lZwizML3rilqtz524w0qhjk4xV2hj1AsaTs3kSRwHHV5538aEM0HXEmxhX/04m8QuY27vjcggv8CNPl1rbrpbdqzBQBrpOvnyRRyK/aMgdqYdQyS3Pg92UUPakQ4to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590250; c=relaxed/simple;
	bh=X6VoqCMha7mh35RsNAZnPf3eqhRxDFtLDqghwBjaH0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/GwqVME3GSe1akTxLTdVBmFl0kxLgV/GitJIAehg1thg9F+BMiGc127iFUbWRSbyq/EcCwLJBP2erzeRMqINPgfyPzA5Q3n8DUrQp4WIgKGZrNrbT73BO1/fUk/DDIy743P8UmEepb2jMTbvhJ3UU0K/naYoa4F1LH6/Mcarf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txPGHGvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1038C116B1;
	Tue, 23 Sep 2025 01:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758590250;
	bh=X6VoqCMha7mh35RsNAZnPf3eqhRxDFtLDqghwBjaH0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=txPGHGvZkwwD5mONGl8SzVVoqzF6Nkw1f5EqYVWib9fn4tZvnML4THTIJN8/cHYC7
	 JrFSwK+4+hc21kNADrrXEvKBR6XyHXC6NIOnDwSE0v2HxJ9wXw1Shw++Ty8i8sWzAd
	 AX7rNT5JtGWcSgR6NNFUX5epm2QYXzv6zwk3G7S5KiODAk5az2VZitgrEcjI0lwFvE
	 2/ulpSbTcxbNfBVwRyI8cNmDcdKV87qBtQa7lj22VqTam6vT/fUq1Q1mRs6qPs86sN
	 pst5SuJWnkUEJRHHPDhg345MCC9QfY1NuGm9s5xarMzAGDqqUxRKowQ0+2/Ns1QbEh
	 KRyOtkRuetwkQ==
Date: Mon, 22 Sep 2025 18:17:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 01/20] net, ynl: Add bind-queue operation
Message-ID: <20250922181728.4aa70650@kernel.org>
In-Reply-To: <20250919213153.103606-2-daniel@iogearbox.net>
References: <20250919213153.103606-1-daniel@iogearbox.net>
	<20250919213153.103606-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 23:31:34 +0200 Daniel Borkmann wrote:
> Subject: [PATCH net-next 01/20] net, ynl: Add bind-queue operation

We use "ynl" for changes to ynl itself. If you're just adding to 
the YAML specs or using them there's no need to mention YNL.
Please remove in all the subjects.

> +  -
> +    name: queue-pair
> +    attributes:
> +      -
> +        name: src-ifindex
> +        doc: netdev ifindex of the physical device
> +        type: u32
> +        checks:
> +          min: 1

max: s32-max ?

> +      -
> +        name: src-queue-id
> +        doc: netdev queue id of the physical device
> +        type: u32


> @@ -772,6 +795,20 @@ operations:
>            attributes:
>              - id
>  
> +    -
> +      name: bind-queue
> +      doc: Bind a physical netdev queue to a virtual one

Would be good to have a few sentences of documentation here.
All netdev APIs currently carry queue id with type.
I'm guessing the next few patches would explain but whether
you're attaching rx, tx, or both should really be explained here :)

