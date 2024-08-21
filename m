Return-Path: <bpf+bounces-37724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C87B495A059
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50410B2322A
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 14:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0E71AF4C9;
	Wed, 21 Aug 2024 14:48:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3A1D12EB;
	Wed, 21 Aug 2024 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251737; cv=none; b=aGgFZ7694qEz2I1fiNLU0EwzAjqEhn+RmddFfIzKbKoMr1UBo3ZzE8Dq4eAE4bwuHTl//oQk9a5jGVopVtFpi7MoECnNr2l/0XHRacTTzSbX5IGTi1HQPAmwJsaVSb2nR1Q6DiZUHT2iPUq4AXPEcSmf8JaE+LQu1r9togC/0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251737; c=relaxed/simple;
	bh=iER9mwpUlrTMCYbs+gwjEgW3k8AduQxlR1qb5gfru7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUL2kKY3YRfBjHRmZuIP+nexlXhvI4GVKGu4T9q86gUNtmLA5kkDFLKSlEA+crGLLO1Z1BBBce9KYl1JW+s0NNl794twLGUx8wdJ/DP57hiZsvtiVxZn14SOJx8adlEIk7j0oRa67FXlA9wJqFQJi+T71yzwj6m7veRfOxFHR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sgmdV-0003E7-US; Wed, 21 Aug 2024 16:48:33 +0200
Date: Wed, 21 Aug 2024 16:48:33 +0200
From: Florian Westphal <fw@strlen.de>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, gnault@redhat.com,
	dsahern@kernel.org, fw@strlen.de, martin.lau@linux.dev,
	daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
	pablo@netfilter.org, kadlec@netfilter.org,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 1
Message-ID: <20240821144833.GA12371@breakpoint.cc>
References: <20240821125251.1571445-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-1-idosch@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Ido Schimmel <idosch@nvidia.com> wrote:
> tl;dr - This patchset starts to unmask the upper DSCP bits in the IPv4
> flow key in preparation for allowing IPv4 FIB rules to match on DSCP. No
> functional changes are expected.

Thanks Ido.

For netfilter bits:
Acked-by: Florian Westphal <fw@strlen.de>

