Return-Path: <bpf+bounces-35512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE33B93B33E
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 16:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795962817CC
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47C715AADB;
	Wed, 24 Jul 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkRbg92T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909AD51E;
	Wed, 24 Jul 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721833064; cv=none; b=UVISLVQKq4rcf2fS7fjGN1OcT9Fdt3OdlhnT1uWqJsFOKnWDhGMES9IA7hjnjY01ozp72o4/YOndI6zGIG4FWMg/TXOXB17EAZQDrYlI2UIF6xsSmKC4HaD+r/NPYbldUhetvTM6fPaWcLj5MF4coIY/afWp20TARHjl2MnxlGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721833064; c=relaxed/simple;
	bh=3hT3gC4J7U26mZ56Rj7jljIh+g6fckfrp3tCpfixre4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+QSEatLUlqTafbiFP1CEw6G6m10EjMZyMSR6Ye/Doa3MoMD3nQ84VWDOH4B3KCbOzyQAAbwUOMl8Q0G7y3jh/+f0NbCJ0s+NLkQZqNR48kg1tjPQJePC4kBIFocqAqw6NHlHaJ3dF0G0Ydyi8JPjPfpiHYDu9UV3QtBI00aJUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkRbg92T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0C4C32781;
	Wed, 24 Jul 2024 14:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721833064;
	bh=3hT3gC4J7U26mZ56Rj7jljIh+g6fckfrp3tCpfixre4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QkRbg92TXMaPhm54AK1Mt3ZPQ90uCYosOP1K/dPKHTfRaaplJ43pug90pyhRbVL7u
	 B9MxcnAHsxed2VtdGoJm7X59iDh2Tufqr6YmUj+PJSdXS1aBAvmV0hzKw9J/MaXhhW
	 G1YSVuv6kFXmAm3hxtP45sY/dOqt6uvYobhrWm6AS/cFBLJNOnvdNnwXADB3XQgnBL
	 TTqD8KcYLLuSoPkVVOq8ao8HQ0RHmD6qPElbAnYz3H54ajum/M2iFwvZ/SbqkUcNLL
	 3OZevyzX7XZs3dMlhqnsgyMb1AedWjIDvuYZ6PVd7JLLlMKx2e8t04IyhnZtitafaj
	 G0whZ2Nrn2/hA==
Date: Wed, 24 Jul 2024 07:57:42 -0700
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
Message-ID: <20240724075742.0e70de49@kernel.org>
In-Reply-To: <ZqBAw0AEkieW+y4b@boxer>
References: <20240708221416.625850-1-anthony.l.nguyen@intel.com>
	<20240708221416.625850-7-anthony.l.nguyen@intel.com>
	<20240709184524.232b9f57@kernel.org>
	<ZqBAw0AEkieW+y4b@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 01:46:11 +0200 Maciej Fijalkowski wrote:
> Goal of this commit was to prevent compiler from code reoder such as NAPI
> is launched before update of xsk_buff_pool pointer which is achieved with
> WRITE_ONCE()/synchronize_net() pair. Then per my understanding single
> READ_ONCE() within NAPI was sufficient, the one that makes the decision
> which Rx routine should be called (zc or standard one). Given that bh are
> disabled and updater respects RCU grace period IMHO pointer is valid for
> current NAPI cycle.

So if we are already in the af_xdp handler, and update patch sets pool
to NULL - the af_xdp handler will be fine with the pool becoming NULL?
I guess it may be fine, it's just quite odd to call the function called
_ONCE() multiple times..

