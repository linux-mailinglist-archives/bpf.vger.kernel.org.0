Return-Path: <bpf+bounces-32098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D157590775E
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 17:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7601C24648
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289BE15A864;
	Thu, 13 Jun 2024 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE9Z1NUn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96371149C4E;
	Thu, 13 Jun 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293244; cv=none; b=r25PZ4uUh2tp2BBgjFeMWllVq6TyEIazQJyHIJYErpwVuXOp6wbWOmpYE6R+dpAZ8JEpQJBoOf9z+wj9dRxFkTxQW/jDySUqYXO1omzbM/IKsl3B/ULnqcMKDCHgHVtNE+CnbT3vfm6GaR3kWkBQgT22m2SUgJb6zgGl1JFc9lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293244; c=relaxed/simple;
	bh=JcXvOUaKdlxs2Ht40iN7VRSX7BT4jA2+5PBP7oY41xc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIGmdWiPLePVrw7cuTBlsfdh2wZvEKUWTTuJs4SFe24jWndCMb1vYO5rFApTtZU+Tlvyt4NwWEqbog1fuA3f46a32UNBFyjQ/LIPuVpqDwuuS10CEpjaoGDsfrESUbfQfDGjN8dyQgdWbBgozMBU7ICbd2zSXf4v20Mpx9m+N04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE9Z1NUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63916C32786;
	Thu, 13 Jun 2024 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718293244;
	bh=JcXvOUaKdlxs2Ht40iN7VRSX7BT4jA2+5PBP7oY41xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WE9Z1NUnN2yyAnjrE9nBV1RUF+SFyoifvSbOJ4sNgec7xO0QNAaq1qrB4mXpLPnaV
	 vg3xdmR4KToKvfpGJrei1/MhoJRAv4FBSVh2MuqwZNT7D4GkaLZjR6hg9voDEMssbc
	 /rka534WIOa/2wRcqXOwGowkNpjoMO+tsbYg6Gy3yIHifMR4KT9iLfuhkk2nLBjRRD
	 l3TC7i5O+LyB5QuDBWq43PFyb96p6xXCL+V8wLKJODYBcLCiNOZEYOK6Y3e60PQKFX
	 bQGD8wVrP183595n1vr/JN2azD2QmxcOXWSIz1eo8H/dwCKb5gpChjK7BB/rMmKtmR
	 SUr0dTvhEoEMg==
Date: Thu, 13 Jun 2024 08:40:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: <intel-wired-lan@lists.osuosl.org>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH iwl-net 0/3] ice: fix synchronization between .ndo_bpf()
 and reset
Message-ID: <20240613084042.7db4c410@kernel.org>
In-Reply-To: <ZmsR8F9GFgxgBXfV@lzaremba-mobl.ger.corp.intel.com>
References: <20240610153716.31493-1-larysa.zaremba@intel.com>
	<20240611193837.4ffb2401@kernel.org>
	<ZmlGppe04yuGHvPx@lzaremba-mobl.ger.corp.intel.com>
	<20240612140935.54981c49@kernel.org>
	<ZmqztPo6UDIC6gKx@lzaremba-mobl.ger.corp.intel.com>
	<20240613071343.019e7dca@kernel.org>
	<ZmsR8F9GFgxgBXfV@lzaremba-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 17:36:16 +0200 Larysa Zaremba wrote:
> > > AFAIK, netif_device_detach() does not affect .ndo_bpf() calls. We were trying 
> > > such approach with idpf and it does work for ethtool, but not for XDP.  
> > 
> > I reckon that's an unintentional omission. In theory XDP is "pure
> > software" but if the device is running driver will likely have to
> > touch HW to reconfigure. So, if you're willing, do send a ndo_bpf 
> > patch to add a detached check.  
> 
> This does not seem that simple. In cases of program/pool detachment, 
> .ndo_bpf() does not accept 'no' as an answer, so there is no easy existing way 
> of handling !netif_device_present() either. And we have to notify the driver 
> that pool/program is no longer needed no matter what. So what is left is somehow 
> postpone pool/prog removal to after the netdev gets attached again.

I see, thanks for investigating!

